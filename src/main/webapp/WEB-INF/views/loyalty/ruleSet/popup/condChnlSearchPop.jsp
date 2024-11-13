<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var condChnlSearchPopValidation;

function initCondChnlSearchPop() {

	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("ouTypeCd", "PARTNER_TYPE", null, null, true);

	condChnlSearchPopValidation = $("#condChnlSearchPop").ifvValidation();
}

function initCondChnlInfoPopData(data) {
	$("#condChnlSearchPop #ouTypeCd").val(data.ouTypeCd);
	$("#condChnlSearchPop #ridChnl").val(data.ridChnl);
	$("#condChnlSearchPop #chnlCd").val(data.chnlCd);
	$("#condChnlSearchPop #chnlNm").val(data.chnlNm);
}

//채널 목록 팝업 열기
function condChnlListPopupOpen() {
    $("#condChnlListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condChnlListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02429'/>",
        width: '600px',
        close : 'condChnlListPopupClose'
    });
}

//채널 목록 팝업 선택
function condChnlListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(condChnlListPopGrid.getCheckedList())) {
		var selData = condChnlListPopGrid.getCheckedList()[0];
		$("#condChnlSearchPop #chnlNm").val(selData.chnlNm);	//채널명
		$("#condChnlSearchPop #chnlCd").val(selData.chnlNo);	//채널코드
		$("#condChnlSearchPop #ridChnl").val(selData.rid);	    //rid
		$("#condChnlSearchPop #ouTypeCd").val(selData.ouTypeCd);

		//close popup
		condChnlListPopupClose();
	} else {
		alert("<spring:message code='L00173'/>");

		return false;
	}
}

//채널 목록 팝업 닫기
function condChnlListPopupClose() {
	condChnlListPopup._destroy();
}

$(document).ready(function() {
	initCondChnlSearchPop();

	//등록 클릭시
    $('#condChnlSearchPopSaveBtn').on('click', function(){
    	condChnlSeachPopupSave();
    });

    //닫기 클릭시
    $('#condChnlSearchPopCancelBtn').on('click', function(){
    	condChnlSearchPopClose();
    });

    //채널 목록 팝업
    $('#condChnlListPopupBtn').on('click', function(){
    	condChnlListPopupOpen();

    });

    //가맹점 유형 변경시 가맹점명 초기화
    $('#ouTypeCd').on('change', function() {
        $('#condChnlInfoPop #chnlNm').val('');
        $('#condChnlInfoPop #ridChnl').val('');
        $('#condChnlInfoPop #chnlCd').val('');
    });

});
</script>

<div id="condChnlInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="condChnlSearchPop" >
		<div class="row qt_border">

            <%-- 가맹점유형 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00630'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="ouTypeCd" names="ouTypeCd" />
            </div>
        </div>
		<div class="row qt_border">

            <%--채널명 --%>
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00223'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="chnlNm" names="chnlNm" />
                    <ifvm:input type="hidden" readonly="true" required="true" id="ridChnl" names="ridChnl" />
                    <span class="input-group-addon" id="condChnlListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
		</div>
		<div class="row qt_border">
            <%-- 채널코드 --%>
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00222'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="chnlCd" names="chnlCd" />
                </div>
            </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="condChnlSearchPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="condChnlSearchPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>
<div id="loyBrandListPopup"></div>
<div id="condChnlListPopup"></div>