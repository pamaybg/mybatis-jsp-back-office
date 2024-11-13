<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well underline" id="newCustDetailForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="ticket"  names="ticket"  label="티켓번호" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="pMbrNo"  names="mbrNo"  label="회원번호" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="airline"  names="airline"  label="항공사" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="date" id="date"  names="date"  label="날짜" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="origin"  names="origin"  label="출발지" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="desti"  names="desti"  label="도착지" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="classCd"  names="classCd"  label="좌석클래스" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="flightNo"  names="flightNo"  label="항공편번호" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="passenger"  names="passenger"  label="고객명" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="number" id="sellAmt"  names="sellAmt"  label="거래금액" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<label class="control-label col-xs-3">결과</label>
		<div class="control_content col-xs-9">
			<div id="resultTxt" style="height: 200px; border: 1px solid #dedede; padding-left: 5px; padding-right: 5px; white-space: pre; overflow: scroll;"></div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="acrlBtn" objCode="">
		적립
	</button> 
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="">
		<spring:message code="L00941" />
	</button> 
</div>
<div id="pgmPopupContainer" class="popup_container"></div>
<div id="chnlPopupContainer" class="popup_container"></div>
<div id="adrDtlSearchPop" class="popup_container"></div>


<script type="text/javascript">
var acrlMilePop;

var acrlMileagePopFn = function(){
	var inputField = $("#newCustDetailForm input");
	var selectField =$("#newCustDetailForm select");
	this.textField =[],
	this.selectField =[],
	this.custItemVal=[],
	this.init = function(){
		this.action();
		this.setDateField();
		this.getField();
	},
	this.save = function(){
		var data = {
				evtType	: "APPR"
				, evtDtlType : "APPR_ACRL"
				, ticket : $("#ticket").val()
				, mbrNo : $("#pMbrNo").val()
				, airline : $("#airline").val()
				, date : $("#date").val().replaceAll("-", "")
				, origin : $("#origin").val()
				, desti : $("#desti").val()
				, classCd : $("#classCd").val()
				, flightNo : $("#flightNo").val()
				, passenger : $("#passenger").val()
				, sellAmt : $("#sellAmt").val()
				, campaignId: "01A37DBC625747FC935535F006F28EAA"
				, ridIntactType : "91C99F3FC3563CB6E05379B67B0AEBCC"
		};
		
		$.ifvSyncPostJSON('/marketing/api/eventTrigger.do',data, function(result) {
			if (result != null) {
				if (result.resultList.length > 0) {
					$.each(result.resultList, function(k, v) {
						$("#resultTxt").empty();
						$("#resultTxt").append(document.createTextNode(JSON.stringify(v, null, 4)));
					});
				}
			}
		}.bind(this));
	},
	this.close = function(){
		$.fn.ifvmPopupClose();
	},
    this.setDateField = function(){
    	var date = $("#date");
    	date.ifvDateChecker({});
    	
    	var selRow = mbrTxnHistListGrid.opt.gridControl.getSelectedRecords();
    	if (selRow.length > 0) {
    		var data = selRow[0];
    		$("#ticket").val(data.tickNo);
    		$("#airline").val(data.flightNo.substring(0, 2));
    		$("#date").val(data.sellDate);
    		var origin = data.routeTypeCd.split("/")[0];
    		var desti = data.routeTypeCd.split("/")[1];
    		$("#origin").val(origin);
    		$("#desti").val(desti);
    		$("#classCd").val(data.seatNo);
    		$("#flightNo").val(data.flightNo);
    		$("#sellAmt").val(data.sellAmt);
    	}
    }
	this.getField = function(){
		$("#pMbrNo").val($("#mbrNo").val());
		$("#passenger").val($("#custNm").val());
	},
	this.setSelectField = function(values) {
        $.fn.ifvmSetSelectOptionCommCode("nlty", "COUNTRY_TYPE_CD", nlty, null, false);	
    },
	this.action = function() {
    	$("#acrlBtn").click(function() {
    		this.save();
    	}.bind(this));
    	
    	$("#closePopBtn").click(function() {
    		this.close();
    	}.bind(this));
    },
    this.sample = function() {

    }
}

$(document).ready(function(){
	acrlMilePop = new acrlMileagePopFn();
	acrlMilePop.init();
})
</script>