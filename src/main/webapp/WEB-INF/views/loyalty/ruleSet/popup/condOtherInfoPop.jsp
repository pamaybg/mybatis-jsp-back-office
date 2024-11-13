<%@ page trimDirectiveWhitespaces="true" %>
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
var condOtherInfoPopValidation;
var otherOpenType = '<%= cleanXss(request.getParameter("otherOpenType")) %>';

function initCondOtherInfoPop() {

	$.fn.ifvmSetSelectOptionCommCode("type", "RULESET_TYPE", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("rulsetEtcCd", "RULSET_ETC_CD", null, null, true);
	//채널유형
	condOtherInfoPopValidation = $("#condOtherInfoPopDiv").ifvValidation();
}


function initCondOtherInfoPopData(data){
	$("#condOtherInfoPopDiv #rulsetEtcCd").val(data.rulsetEtcCd);
	$("#condOtherInfoPopDiv #rulsetEtcVal").val(data.rulsetEtcVal);
	$("#condOtherInfoPopDiv #type").val(data.type);

}




$(document).ready(function() {
	initCondOtherInfoPop();

	//등록 클릭시
    $('#destinationPathInfoPopSaveBtn').on('click', function(){
    	otherInfoPopupSave();
    });

    //닫기 클릭시
    $('#destinationPathInfoPopCancelBtn').on('click', function(){
    	otherInfoPopupClose();
    });

    if(otherOpenType=="E"){
    	initCondOtherInfoPopData(selCondOtherData);
    }



});
</script>

	<div class="pop_inner_wrap form-horizontal" id="condOtherInfoPopDiv" >
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>유형</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="rulsetEtcCd" names="rulsetEtcCd" />
                </div>
            </div>
		</div>


		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>구분</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="type" names="type" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>구분값</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" required="true" id="rulsetEtcVal" names="rulsetEtcVal" />
                </div>
            </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="destinationPathInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="destinationPathInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
