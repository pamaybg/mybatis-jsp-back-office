<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>
var selectedRowArray = commCodeGrid.getCheckedGridData();

//다국어 복사 생성 팝업
function commCodeAddByCopyPopInit(selectedRowArray) {
	
	$("#commCodeAddByCopyModal").hide();
 	validation = $("#commCodeAddByCopyPopFormArea").ifvValidation();  

	//해당 아이디로 등록 가능한 언어 목록 가져오기
	$("#languageCopy option").remove();
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeLangByIdList"/>'
		,{id : selectedRowArray[0].id,
			schema : $("#schema option:selected").val()
		}
		,function(result) {

			//해당 아이디로 모든 언어가 등록되어 있다면(isCreatable = false) -> 종료, 그렇지 않은 경우에만 진행
			var isCreatable = false;
			for (var i=0; i<result.rows.length; i++) {
				if (result.rows[i].country == null) {
					isCreatable = true;
					break;
				}
			}
			if (isCreatable) {
				$("#commCodeAddByCopyModal").show();
				var temp = $("#languageCopyTemplate").tmpl(result.rows);
				$("#languageCopy").append(temp);
				
				//country list code
				$("#countryCopy option").remove();
				$.ifvSyncPostJSON('<ifvm:action name="getCommCodeCountry"/>', {
				}, function(result) {

					var temp = $("#countryTemplate").tmpl(result.rows);
					$("#countryCopy").append(temp);
				});
				
				//그룹명과 마크명 채우기
				$("#groupNameCopy").val(selectedRowArray[0].groupName);
				$("#markNameCopy").val(selectedRowArray[0].markName);
				
				$("#commCodeAddByCopyModal").show();
				
			} else {	
					commCodePopupClose();
					alert('<spring:message code="M00272"/>');

			
			}
		}
	);
}

function saveCommCodePopBtnClick() {
	//var obj = $('#commCodeListFormArea').getSubmitData();
	//유효성 검사
	if( validation.confirm() == false ) return;	//함수 호출시 체크
	
	//등록작업 시작
	var selectedRowArray = commCodeGrid.getCheckedGridData();
	$.ifvSyncPostJSON('<ifvm:action name="addCommCode"/>'
		, {
			id : selectedRowArray[0].id,
			countryType : $("#countryCopy").val(),
			langType : $("#languageCopy option:selected").val(),
			groupName : $("#groupNameCopy").val(),
			markName : $("#markNameCopy").val(),
			schema : $("#schema option:selected").val(),
			commCodeMode : "copy"
		}
		,function(result){
			alert('<spring:message code="M00010"/>');	//등록
			$("#commCodeAddByCopyModal").hide();
			commCodeGrid.requestData( getData() );
			commCodePopupClose();
		}
		,function(result){
			alert('<spring:message code="M00258"/>');	//중복
		}
	);
}

$(document).ready(function(){

	commCodeAddByCopyPopInit(selectedRowArray);

	$("#saveCommCodePopBtn").on("click", saveCommCodePopBtnClick);
});
</script>

<script id="languageCopyTemplate" type="text/x-jquery-tmpl">
{{if country != null}}
	<option value="${'${'}lang}" disabled>${'${'}lang}</option>
{{else}}
	<option value="${'${'}lang}">${'${'}lang}</option>
{{/if}}
</script>

<script id="countryTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}country}">${'${'}country}</option>
</script>


<div class="pop_inner_wrap">   		
	<div class="form-horizontal" id="commCodeAddByCopyPopFormArea">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00246"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="countryCopy" />
			</div>
			<label class="col-xs-3 control-label"><spring:message code="M00237"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="languageCopy" />
			</div>
		</div>
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00238"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="groupNameCopy" maxLength="50" required="true" />
			</div>
			<label class="col-xs-3 control-label"><spring:message code="M00243"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="markNameCopy" maxLength="50" required="true" />
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button id="saveCommCodePopBtn" class="btn btn-sm btn_gray">
    	<i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00170"/>
    </button>
</div>