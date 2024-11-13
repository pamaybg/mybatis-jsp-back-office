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
<script>

var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var detail = false;  //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
var validation = '<%= cleanXss(request.getParameter("validation")) %>';
var isValid = '<%= cleanXss(request.getParameter("isValid")) %>';
var popSelectlId = '<%= cleanXss(request.getParameter("popSelectlId")) %>';

//상세 페이지인지 체크
function idCheck(){
	if(rid != "null")
	{
		//상세 내용 적용
		$.ifvSyncPostJSON('<ifvm:action name="getOrganizationDetail"/>', {
			   rid : rid
		}, function(result) {
			    $("#divNo").val(result.divNo);
			    $("#divNm").val(result.divNm);
			    $("#divLvl").val(result.divLvl);
			    $("#divTypeCd").val(result.divTypeCd);
			    $("#ridParDiv").val(result.ridParDiv);
			    $("#ridParDivNm").val(result.ridParDivNm);
			    $("#divStatus").val(result.divStatus);
			    $("#xBrandCd").val(result.xBrandCd);
		});
		detail = true;
	}else{
	}

	validation = $("#selectForm").ifvValidation();
}

function popupClose(){
	orgInfo._destroy();
}

//저장 버튼클릭 시 동작
function saveOrganization() {
	isValid = validation.confirm();

	if(isValid){

		var obj = {
			 divNo : $("#divNo").val()
			, divNm : $("#divNm").val()
			, divLvl : $("#divLvl").val()
			, divTypeCd : $("#divTypeCd").val()
			, ridParDiv : $("#ridParDiv").val()
			, divStatus : $("#divStatus").val()
			, xBrandCd : $("#xBrandCd").val()
		}

		//상세 페이지일 시 수정 작업 동작
		if(detail)
		{
			obj.rid = rid;

			$.ifvSyncPostJSON('<ifvm:action name="updateOrganization"/>', obj
				, function(result) {
					if(result.success){
						alert('<spring:message code="M01048"/>');
					}
					else{
						alert('<spring:message code="M01050"/>');
					}
					qtjs.href('<ifvm:url name="organizationNew"/>');
			});
		}
		//상세 페이지가 아닐 시 insert 동작
		else
		{
			//language code
			$.ifvSyncPostJSON('<ifvm:action name="insertOrganization"/>', obj
				, function(result) {
					if(result.success){
						alert('<spring:message code="M01047"/>');
					}
					else{
						alert('<spring:message code="M01050"/>');
					}
					qtjs.href('<ifvm:url name="organizationNew"/>');
			});
		}
	}
	else{
		alert('<spring:message code="M01055"/>');
	}
}

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="organizationNew"/>');
}

$(function () {

    // 메뉴 설정
    $.ifvmLnbSetting('organizationListNew');

	$.fn.ifvmSetSelectOptionCommCode("divTypeCd", "COM_DIVISION_TYPE_CD", null, null, false);

	$.fn.ifvmSetSelectOptionCommCode("divStatus", "ACCOUNT_STATUS", "ACTIVE", null, false);

	$.fn.ifvmSetSelectOptionCommCode("xBrandCd", "DIVISION_BRAND_CD", null, null, false);

	idCheck();

	//조직 정보 검색창
	$('#orgBtn').on('click', function(){
		$.fn.ifvmPopupOpen('orgInfo', 'ridParDiv', '<ifvm:url name="orgInfoPop"/>', '<spring:message code="조직 조회"/>');
	});

	$('#organizationSaveBtn').on('click', function(){
		saveOrganization();
    });
});

</script>

<div class="page-title">
	<h1>
		<span><spring:message code="L00483"/>  &gt; <spring:message code="M01852"/> or <spring:message code="M01853"/></span>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00484"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="organizationSaveBtn" className="organizationSaveBtn" text="I02029" btnType="save" objCode="organizationDetailSave_OBJ"/><!-- 저장 -->
			<ifvm:inputNew type="button" id="goOrganizaionListNew" btnFunc="goList" text="L00824" objCode="goOrganizaionListNew_OBJ"/> <!-- 목록 -->
			</button>
		</div>
	</div>
	<div class="well form-horizontal underline" id="selectForm" >
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00336"/></label><!-- divNo -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="divNo" maxLength='32'/>
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00555"/></label><!-- divNm -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text"  required="true" id="divNm" maxLength='60'/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="L00478"/></label><!-- divTypeCd -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" required="true" id="divTypeCd" names="divTypeCd"  maxLength='11'/>
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00481"/></label><!-- divStatus -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" required="true" id="divStatus" names="divStatus"  maxLength='11'/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="L00480"/></label><!-- ridParDiv -->
			<div class="col-xs-4 control_content">
				<div class="input-group">
					<ifvm:input type="hidden" id="ridParDiv" maxLength='11' readonly="true"/>
					<ifvm:input type="text" id="ridParDivNm" maxLength='11' readonly="true"/>
					<span class="input-group-addon" id="orgBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>

			<label class="col-xs-2 control-label"><spring:message code="브랜드 유형"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" className="form-control" id="xBrandCd" names="xBrandCd" dto="xBrandCd" />
			</div>
		</div>
	</div>
</div>
<div id="orgInfo" class="popup_container"></div>