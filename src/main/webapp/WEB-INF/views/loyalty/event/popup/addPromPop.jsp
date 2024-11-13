<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well" id="addPromForm">
	<!-- 조건유형 -->
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="L02548"/></label>
        <ifvm:inputNew type="select" id="conCd" names="conCd" dto="conCd" disabled="true" conClass="9" required="true"/>
	</div>
	<!-- 조건값 -->
	<div class="row qt_border">
		<!-- 페이지 로드 시 첫번째 활성영역인 제한시작일로 focus 이벤트가 자동발생하므로 hidden input 추가. -->
		<input type="text" style="border:none; width: 1px;"/>
		<ifvm:inputNew type="number" id="condVal" names="condVal" dto="condVal" label="L02549" labelClass="2" conClass="9" required="true"/>
	</div>
	<!-- 캠페인명 -->
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02115"/></label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="camNm" names="camNm" disabled="true" required="true"/>
				<span class="input-group-addon" id="btnPromotionListPop2">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="promSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00074"/><!-- 저장 -->
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="promCancelBtn">
		<spring:message code="L01781"/><!-- 닫기 -->
	</button>
</div>
<div id="promContainer" class="popup_container"></div><!-- 프로모션 팝업 -->

<script>
var selectProm;	  //캠페인명
var selectPromRid;//캠페인rid
var promRid =  '<%= cleanXss(request.getParameter("rid")) %>';
if(promRid == "undefined") promRid = null;

$(document).ready(function(){
	if(promRid != null){
		addPromDetail(promRid);
	}else{
		$('#condVal').val(maxStmpCnt);
	}
	
	//프로모션 조회
	$("#btnPromotionListPop2").on("click",function(){
		promotionPopUp2();
	});	
	
	//공통코드 세팅
	commcodeSetting();
	
	//닫기
	$("#promCancelBtn").on("click",function(){
		addPromPopUpClose();
	});	
	
	//등록
	$("#promSaveBtn").on("click",function(){
		addPromSave();
	});
	
	//조건값 숫자 정규식
	$('#condVal').on("blur keyup",function(){
		$(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-z]/g,''));
	});
});

function addPromDetail(promRid){
	$.ifvSyncPostJSON('<ifvm:action name="selectAddProm"/>',{
		rid : promRid
	}, function(result) {
		$('#conCd').val(result.conCd);
		$('#condVal').val(result.condVal);
		$('#camNm').val(result.camNm);
		selectPromRid=result.camRid
    });
}
//프로모션 팝업 Close
function promotionPopUp2Close() {
	promContainer._destroy();
}

//프로모션 팝업 Open
function promotionPopUp2() {
    $("#promContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="promotionDetailPop2"/>',
        contentType: "ajax",
        title: '<spring:message code="L02580"/>',/* 프로모션 */
        width: '900px',
        close : 'promotionPopUp2Close'
    });
}

//공통코드 세팅
function commcodeSetting(){
	$.fn.ifvmSetSelectOptionCommCode("conCd", "COND_TYPE_CD", "M02", null, true);
}

//추가혜택 등록
function addPromSave(){
	var conCd = $('#conCd').val();
	var condVal = $('#condVal').val();
	validation = $("#addPromForm").ifvValidation();
	var url;
	
	if(promRid != null){
		url = '<ifvm:action name="updatePromSave"/>'
	}else{
		url = '<ifvm:action name="addPromSave"/>'
	}
	
	if(validation.confirm() && confirm('<spring:message code="L02555" />')){/* 추가혜택을 저장하시겠습니까? */
		//조건값이 최대스탬프보다 큰 경우
		if(maxStmpCnt != condVal){
			alert('<spring:message code="L02639"/>');//조건값과 스탬프 개수가 일치하지 않습니다.
			return;
		}
	
		$.ifvSyncPostJSON(url,{
			conCd : conCd,
			condVal : condVal,
			camRid : selectPromRid,
			evtRid : eventRid
		}, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="L01822" />');/* 저장되었습니다. */
	                getAddPromList();
	                addPromPopUpClose();
	            }
	        }
	    });
	}
}
</script>