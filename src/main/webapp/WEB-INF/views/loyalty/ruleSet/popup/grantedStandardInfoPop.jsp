<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var grantedStandardInfoPopValidation;

function initGrantedStandardInfoPop() {

	//정액/정률 구분
	$.fn.ifvmSetSelectOptionCommCode("acrlType", "LOY_ACRL_TYPE", null, null, true);

	//area 설정
	var _promSubType = $("#promTypeCd").val();
	//등급가산포인트||승급업포인트||등급별포인트 아닐경우 회원등급 삭제
	if ( (_promSubType == "P002" || _promSubType == "P003" || _promSubType == "P014") == false ) {
		$("#tierArea").remove();
	}

	//금액대별포인트(판매/결제) 아닐경우 이상/미만 삭제
	if ( (_promSubType == "P005" || _promSubType == "P006") == false ) {
		$("#minMaxArea").remove();
	}

	grantedStandardInfoPopValidation = $("#grantedStandardInfoPop").ifvValidation();
}

function initGrantedStandardInfoPopData(data) {
	selGrantedStandardData = data;
	$("#grantedStandardInfoPop #tierNm").val(data.tierNm);
	$("#grantedStandardInfoPop #ridTiers").val(data.ridTiers);
	$("#grantedStandardInfoPop #acrlType").val(data.acrlType);
	$("#grantedStandardInfoPop #acrlAmt").val(data.acrlAmt);
	$("#grantedStandardInfoPop #maxAmt").val(data.maxAmt);
	$("#grantedStandardInfoPop #minAmt").val(data.minAmt);
}

//회원 등급 팝업 열기
function tierListPopupOpen() {
    $("#tierListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00185'/>",
        width: '600px',
        close : 'tierListPopupClose'
    });
}

//회원 등급 팝업 선택
function tierListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(tierListPopGrid.getCheckedList())) {
		var selData = tierListPopGrid.getCheckedList()[0];
		$("#ridTiers").val(selData.rid);  //rid
		$("#tierNm").val(selData.tierNm); //등급명

		//close popup
		tierListPopupClose();
	}
	else {
		alert("<spring:message code='L00186'/>");

		return false;
	}
}

//회원 등급 팝업 닫기
function tierListPopupClose() {
	tierListPopup._destroy();
}

$(document).ready(function() {
	initGrantedStandardInfoPop();

	//등록 클릭시
    $('#grantedStandardInfoPopSaveBtn').on('click', function() {
    	grantedStandardInfoPopupSave();
    });

    //닫기 클릭시
    $('#grantedStandardInfoPopCancelBtn').on('click', function() {
    	grantedStandardInfoPopupClose();
    });

    //회원등급 팝업
    $('#tierListPopupBtn').on('click', function() {
    	tierListPopupOpen();
    });

    $("input[val-opt=decimalComma]").keyup(function() {
        $(this).val(this.value);
    });
});
</script>

<div id="grantedStandardInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="grantedStandardInfoPop" >
		<div class="row qt_border" id="tierArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00187'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="tierNm" names="tierNm" />
                    <ifvm:input type="hidden" id="ridTiers" names="ridTiers" />
                    <span class="input-group-addon" id="tierListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
		</div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00188'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="acrlType" names="acrlType" />
            </div>
        </div>
        <div class="row qt_border">
            <%-- 정액/정률 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00189'/></label>
            <div class="col-xs-9 control_content">
                <%-- <ifvm:input type="text" valOpt="decimalComma" maxLength="8" required="true" id="acrlAmt" names="acrlAmt" /> --%>
               <ifvm:input type="number"   className="text-right" required="true" id="acrlAmt" names="acrlAmt"  maxLength="8"/>

            </div>
        </div>
		<div class="row qt_border" id="minMaxArea">
            <%-- 이상 --%>
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00190'/></label>
            <div class="col-xs-3 control_content">
<%--                 <ifvm:input type="text" valOpt="decimalComma" maxLength="8" required="true" id="minAmt" names="minAmt" /> --%>
  				<ifvm:input type="number"   className="text-right" required="true" id="minAmt" names="minAmt"  maxLength="8"/>
            </div>
            <%-- 미만 --%>
            <label class="col-xs-2 control-label">~  <span class="asterisk">*</span><spring:message code='L00191'/></label>
            <div class="col-xs-3 control_content">
            	<ifvm:input type="number"   className="text-right" required="true" id="maxAmt" names="maxAmt"  maxLength="8"/>
                <%-- <ifvm:input type="text" valOpt="decimalComma" maxLength="8" required="true" id="maxAmt" names="maxAmt" /> --%>
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="grantedStandardInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="grantedStandardInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>
<div id="tierListPopup"></div>