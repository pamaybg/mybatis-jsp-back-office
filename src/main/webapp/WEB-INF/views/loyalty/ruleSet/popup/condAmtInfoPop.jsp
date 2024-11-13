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
var condAmtInfoPopValidation;
var amtOpenType = '<%= cleanXss(request.getParameter("amtOpenType")) %>';


function initCondAmtInfoPop() {
	$.fn.ifvmSetSelectOptionCommCode("type", "RULESET_TYPE", null, null, true);
	//채널유형
	condAmtInfoPopValidation = $("#condAmtInfoPopDiv").ifvValidation();
}


function initCondAmtInfoPopData(data){
	$("#condAmtInfoPopDiv #type").val(data.type);
	$("#condAmtInfoPopDiv #startAmt").val(data.startAmt);
	$("#condAmtInfoPopDiv #endAmt").val(data.endAmt);

}

$(document).ready(function() {
	initCondAmtInfoPop();

	//등록 클릭시
    $('#condAmtInfoPopSaveBtn').on('click', function(){
    	condAmtInfoPopupSave();
    });

    //닫기 클릭시
    $('#condAmtInfoPopCancelBtn').on('click', function(){
    	condAmtInfoPopupClose();
    });

    if(amtOpenType=="E"){
    	initCondAmtInfoPopData(condAmtData);
    }

});
</script>

	<div class="pop_inner_wrap form-horizontal" id="condAmtInfoPopDiv" >
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>시작금액</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number"   className="text-right" required="true" id="startAmt" names="startAmt" />
                </div>
            </div>
		</div>



		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>종료금액</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number"   className="text-right" required="true" id="endAmt" names="endAmt" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>적립구분</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="type" names="type" />
                </div>
            </div>
		</div>

	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="condAmtInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="condAmtInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>

<div id="tierInfoPopup" class ="popup_container"></div>