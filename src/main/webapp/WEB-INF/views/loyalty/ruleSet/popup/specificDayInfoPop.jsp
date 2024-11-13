<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var specificDayInfoPopValidation;

function initSpecificDayInfoPop() {
	$.fn.ifvmSetSelectOptionCommCode("days", "LOY_FAM_DAY", null, null, true);
	//채널유형
	specificDayInfoPopValidation = $("#specificDayInfoPopDiv").ifvValidation();

}
function initSpecificDayInfoPopData(data){
	$("#specificDayInfoPopDiv #days").val(data.days);
}


$(document).ready(function() {
	initSpecificDayInfoPop();

	//등록 클릭시
    $('#specificDayInfoPopSaveBtn').on('click', function(){

    	specificDayInfoPopupSave();

    });

    //닫기 클릭시
    $('#specificDayInfoPopCancelBtn').on('click', function(){
    	specificDayInfoPopupClose();
    });


	/* $('#tierSearchBtn').on('click', function(){
		$("#tierInfoPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="loyTierListPop"/>',
	        contentType: "ajax",
	        title: '등급 정보',
	        width: '700px',
	        close : 'tierInfoPopupClose'
	    });
	}); */



});
</script>

	<div class="pop_inner_wrap form-horizontal" id="specificDayInfoPopDiv" >

		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span>일</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="days" names="days" />
                </div>
            </div>
		</div>

	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="specificDayInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="specificDayInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>

<div id="tierInfoPopup" class ="popup_container"></div>