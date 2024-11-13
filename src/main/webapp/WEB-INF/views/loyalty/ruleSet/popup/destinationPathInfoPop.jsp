<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var destinationPathInfoPopValidation;

function initDestinationPathInfoPop() {
    
	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("ouTypeCd", "PARTNER_TYPE", null, null, true);
	
	destinationPathInfoPopValidation = $("#destinationPathInfoPop").ifvValidation();
}

function initDestinationPathInfoPopData(data) {
	$("#destinationPathInfoPop #ouTypeCd").val(data.ouTypeCd);
	$("#destinationPathInfoPop #ridChnl").val(data.ridChnl);
	$("#destinationPathInfoPop #chnlCd").val(data.chnlCd);
	$("#destinationPathInfoPop #chnlNm").val(data.chnlNm);
}

//채널 목록 팝업 열기
function loyChannelListPopupOpen() {
    $("#loyChannelListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyChannelListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02429'/>",
        width: '600px',
        close : 'loyChannelListPopupClose'
    });
}

//채널 목록 팝업 선택
function loyChannelListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyChannelListPopGrid.getCheckedList())) {
		var selData = loyChannelListPopGrid.getCheckedList()[0];
		$("#destinationPathInfoPop #chnlNm").val(selData.chnlNm);	//채널명
		$("#destinationPathInfoPop #chnlCd").val(selData.chnlNo);	//채널코드
		$("#destinationPathInfoPop #ridChnl").val(selData.rid);	    //rid
		$("#destinationPathInfoPop #ouTypeCd").val(selData.ouTypeCd);
		
		//close popup
		loyChannelListPopupClose();
	} else {
		alert("<spring:message code='L00173'/>");
		
		return false;
	}
}

//채널 목록 팝업 닫기
function loyChannelListPopupClose() {
	loyChannelListPopup._destroy();
}

$(document).ready(function() {
	initDestinationPathInfoPop();
	
	//등록 클릭시
    $('#destinationPathInfoPopSaveBtn').on('click', function(){
    	destinationPathInfoPopupSave();
    });
    
    //닫기 클릭시
    $('#destinationPathInfoPopCancelBtn').on('click', function(){
    	destinationPathInfoPopupClose();
    });
    
    //채널 목록 팝업
    $('#loyChannelListPopupBtn').on('click', function(){
    	loyChannelListPopupOpen();
    });
    
    //가맹점 유형 변경시 가맹점명 초기화
    $('#ouTypeCd').on('change', function() {
        $('#destinationPathInfoPop #chnlNm').val('');
        $('#destinationPathInfoPop #ridChnl').val('');
        $('#destinationPathInfoPop #chnlCd').val('');
    });
    
});
</script>

<div id="destinationPathInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="destinationPathInfoPop" >
		<div class="row qt_border">
        
            <%-- 가맹점유형 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00630'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="ouTypeCd" names="ouTypeCd" />
            </div>
        </div>
		<div class="row qt_border" id="tierArea">
        
            <%-- 가맹점명 --%>
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00789'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="chnlNm" names="chnlNm" />
                    <ifvm:input type="hidden" readonly="true" required="true" id="ridChnl" names="ridChnl" />
                    <ifvm:input type="hidden" readonly="true" required="true" id="chnlCd" names="chnlCd" />
                    <span class="input-group-addon" id="loyChannelListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="destinationPathInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="destinationPathInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="loyBrandListPopup"></div>
<div id="loyChannelListPopup"></div>