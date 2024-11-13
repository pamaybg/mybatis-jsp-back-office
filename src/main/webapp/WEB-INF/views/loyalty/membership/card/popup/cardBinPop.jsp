<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var cardBinPopData = { rid : "" };

function cardBinPopInit() {
    $("#validEndDt").ifvDateChecker();
	$.fn.ifvmSetSelectOptionCommCode("statCd", "LOY_CARD_BIN_STAT_CD", "", null, true);
}

function cardBinPopInitData(flag) {
	if (flag) {
		if (cardBinList.opt.gridControl.getSelectedRecords().length > 0) {
			var data = cardBinList.opt.gridControl.getSelectedRecords()[0];
			cardBinPopData.rid = data.rid;
			$("#startNo").val(data.startNo);
			$("#endNo").val(data.endNo);
			$("#validEndDt").val(data.validEndDt);
		}
	}
}

//저장
function saveCardBinBtn() {
	var validation = $("#cardBinPop").ifvValidation();

	function maxlengthCheck() {
        var startNo = $("#startNo").val();
        var endNo = $("#endNo").val();
	    return startNo.length <= 4 && endNo.length <= 4;
	}

	if (validation.confirm() && maxlengthCheck()) {
		var obj = {
			rid : cardBinPopData.rid
			, ridCardKind : ifvGlobal.cardTypeRid
			, startNo : $("#startNo").val()
			, endNo : $("#endNo").val()
			, validEndDt : $("#validEndDt").val()
		};

		$.ifvPostJSON('<ifvm:action name="saveCardBin"/>', obj ,function(result) {
			alert('<spring:message code="M00623"/>');
			$.ifvProgressControl(false);
			getcardBinListInit();
			$.fn.ifvmPopupClose();
		});
	} else {
	    alert('<spring:message code="L02906"/>');
	}
}

//취소
function cancelCardBinBtn() {
    $.fn.ifvmPopupClose();
}

$(document).ready(function(){
	cardBinPopInit();
});
</script>


<div id='cardBinPop'>
	<div class="pop_inner_wrap form-horizontal">
	<br>
		<input type="hidden" id="rid" />
	    <div class="row qt_border">
	        <ifvm:inputNew type="text" id="startNo" label="M02968" labelClass="3" conClass="9" required="true"/>
	    </div>
	    <div class="row qt_border">
	        <ifvm:inputNew type="text" id="endNo" label="M02969" labelClass="3" conClass="9" required="true"/>
	    </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="date" id="validEndDt" label="O00011" labelClass="3" conClass="9" />
        </div>
	</div>
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="addCardBinBtn" btnFunc="saveCardBinBtn" text="C00164" objCode="cardBinPopAddCardBinBtn_OBJ"/>
	<ifvm:inputNew type="button" id="cancelCardBinBtn" btnFunc="cancelCardBinBtn" text="M00284" objCode="cardBinPopCancelCardBinBtn_OBJ"/>
</div>