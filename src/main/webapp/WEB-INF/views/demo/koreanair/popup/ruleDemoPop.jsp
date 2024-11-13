<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well underline" id="ruleDemoPopForm">

    <div style="">
        <img src="https://www.koreanair.com/etc/clientlibs/koreanair/images/mobile/txt_logo.png"/>
    </div>
    <div style="padding:10px 18px 0px 18px;background: white;border-bottom: 1px solid #ddd;margin-bottom:5px;">
    </div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="type"  names="type"  label="유형" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="ticket"  names="ticket"  label="티켓번호" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="mbrNo"  names="mbrNo"  label="회원번호" nuc="true" labelClass="3" conClass="9"/>
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
		<ifvm:inputNew type="number" id="sellAmt"  names="sellAmt"  label="항공운임" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="number" id="txnMile"  names="txnMile"  label="거래마일" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="number" id="txnAmt"  names="txnAmt"  label="거래금액" nuc="true" labelClass="3" conClass="9"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="orgnApprNo"  names="orgnApprNo"  label="원거래승인번호" nuc="true" labelClass="3" conClass="9"/>
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
		실행
	</button> 
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="">
		<spring:message code="L00941" />
	</button> 
</div>

<script id="typeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}val}">${'${'}text}</option>
</script>

<script type="text/javascript">
var acrlMilePop;

var acrlMileagePopFn = function(){
	var inputField = $("#ruleDemoPopForm input");
	var selectField =$("#ruleDemoPopForm select");
	this.textField =[],
	this.selectField =[],
	this.custItemVal=[],
	this.init = function(){
		this.action();
		this.setDateField();
		this.getField();
		this.setSelectField();
		this.setType();
	},
	this.save = function(){
		
		var validation = $("#ruleDemoPopForm").ifvValidation();
		
		if (validation.confirm()) {
			var type = $("#type").val();
			
			var data = {
					evtType	: "APPR"
					, evtDtlType : "APPR_ACRL"
					, ticket : $("#ticket").val()
					, mbrNo : $("#mbrNo").val()
					, airline : $("#airline").val()
					, date : $("#date").val().replaceAll("-", "")
					, origin : $("#origin").val()
					, desti : $("#desti").val()
					, classCd : $("#classCd").val()
					, flightNo : $("#flightNo").val()
					, passenger : $("#passenger").val()
					, sellAmt : $("#sellAmt").val()
					, txnMile : $("#txnMile").val()
					, txnAmt : $("#txnAmt").val()
					, orgnApprNo : $("#orgnApprNo").val()
					, campaignId: "01A37DBC625747FC935535F006F28EAA"
					, ridIntactType : "91C99F3FC3563CB6E05379B67B0AEBCC"
			};
			
			/*
			A1	01A37DBC625747FC935535F006F28EAA	[Demo]대한항공 탑승 마일리지 계산
			A3	11DDE304D95B4EE89EF345578C6D0E09	[Demo]Dynamic Redemption Case1
			A4	D2FA60CC49864CA6B6EADDCF1EFFDF67	[Demo]Dynamic Redemption Case2
			A6	8AEE27BA627C4007866FC68900ED2711	[Demo]마일리지 판매
			A5	57DCD9B1493249DF93AB82472971FFA6	[Demo]복합 결제
			A2	638A489C30D74196A5D30BCE604EE32B	[Demo]보너스 항공권 공제 마일리지
			*/
			
			if (type == "A1") {
				data.campaignId = "01A37DBC625747FC935535F006F28EAA";
				data.evtType = "BURN";
				data.evtDtlType = "BURN";
			} else if (type == "A2") {
				data.campaignId = "638A489C30D74196A5D30BCE604EE32B";
				data.evtType = "PUR";
				data.evtDtlType = "MILE_TICKET";
			} else if (type == "A3") {
				data.campaignId = "11DDE304D95B4EE89EF345578C6D0E09";
				data.evtType = "PUR";
				data.evtDtlType = "MILE_TICKET";
			} else if (type == "A4") {
				data.campaignId = "D2FA60CC49864CA6B6EADDCF1EFFDF67";
				data.evtType = "PUR";
				data.evtDtlType = "AFFL_PROD";
			} else if (type == "A5") {
				data.campaignId = "57DCD9B1493249DF93AB82472971FFA6";
				data.evtType = "PUR";
				data.evtDtlType = "CPLX_PAY";
			} else if (type == "A6") {
				data.campaignId = "8AEE27BA627C4007866FC68900ED2711";
				data.evtType = "PUR";
				data.evtDtlType = "PUR_MILE";
			} else if (type == "A7") {
				data.campaignId = "58A73300961A48EE949A75963FC34B50";
				data.evtType = "PUR";
				data.evtDtlType = "PUR_MILE";
			} else if (type == "A8") {
				data.campaignId = "B3DCCCD6BBEB436D86CFE98239DA0EB5";
				data.evtType = "BURN";
				data.evtDtlType = "BURN_PET";
			} else if (type == "A9") {
				data.campaignId = "4875899D3DDC45C0AC09FB7EFCD6DDB7";
				data.evtType = "APPR";
				data.evtDtlType = "APPR_PET";
			} else if (type == "A10") {
				data.campaignId = "7DEBCA311A594F34A72FACAF9E63B45B";
				data.evtType = "PUR";
				data.evtDtlType = "CANCEL_MILE_TICKET";
			}
			
			
			
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
		
		}
	},
	this.close = function(){
		//$.fn.ifvmPopupClose();
		window.close();
	},
    this.setDateField = function(){
    	var date = $("#date");
    	date.ifvDateChecker({});
    	
    	if (typeof mbrTxnHistListGrid != "undefined") {
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
    }
	this.getField = function(){
		$("#mbrNo").val($("#mbrNo").val());
		$("#passenger").val($("#custNm").val());
	},
	this.setSelectField = function(values) {
		
    	var obj = [
    		{val : "A1", text : "탑승 마일리지"}
    		, {val : "A2", text : "보너스 항공권 공제"}
    		, {val : "A10", text : "보너스 항공권 공제 환급"}
    		, {val : "A3", text : "Dynamic Redemption Case1"}
    		, {val : "A4", text : "Dynamic Redemption Case2"}
    		, {val : "A5", text : "복합 결제"}
    		, {val : "A6", text : "마일리지 구매"}
    		, {val : "A7", text : "마일리지 구매 취소"}
    		, {val : "A8", text : "Pet Point 적립"}
    		, {val : "A9", text : "Pet Point 사용"}
    	];
    	
    	var tmpl = $("#typeTemp").tmpl(obj);
    	$("#type").append(tmpl);
    },
	this.action = function() {
    	$("#acrlBtn").click(function() {
    		this.save();
    	}.bind(this));
    	
    	$("#closePopBtn").click(function() {
    		this.close();
    	}.bind(this));
    	
    	$("#type").change(function() {
    		this.setType();
    	}.bind(this));
    },
    this.setType = function() {
		var type = $("#type").val();
		
		$("#mbrNo").attr("disabled", false); 
		$("#ticket").attr("disabled", true); 
		$("#airline").attr("disabled", true); 
		$("#date").attr("disabled", true); 
		$("#origin").attr("disabled", true); 
		$("#desti").attr("disabled", true); 
		$("#classCd").attr("disabled", true); 
		$("#flightNo").attr("disabled", true); 
		$("#passenger").attr("disabled", true); 
		$("#sellAmt").attr("disabled", true); 
		$("#txnMile").attr("disabled", true); 
		$("#txnAmt").attr("disabled", true); 
		$("#orgnApprNo").attr("disabled", true); 
		
		if (type == "A6") {
			$("#txnMile").attr("disabled", false); 
			$("#txnAmt").attr("disabled", false); 
		} else if (type == "A7") {
			$("#txnAmt").attr("disabled", false); 
			$("#orgnApprNo").attr("disabled", false); 
		} else if (type == "A8" || type == "A9") {
			$("#ticket").attr("disabled", false); 
			$("#airline").attr("disabled", false); 
			$("#date").attr("disabled", false); 
			$("#origin").attr("disabled", false); 
			$("#desti").attr("disabled", false); 
			$("#flightNo").attr("disabled", false); 
			$("#passenger").attr("disabled", false); 
			$("#txnMile").attr("disabled", false); 
		} else if (type == "A5") {
			$("#mbrNo").attr("disabled", true); 
			$("#date").attr("disabled", false); 
			$("#origin").attr("disabled", false); 
			$("#desti").attr("disabled", false); 
			$("#txnMile").attr("disabled", false); 
			$("#airline").attr("disabled", false); 
		} else if (type == "A3") {
			$("#mbrNo").attr("disabled", true); 
			$("#classCd").attr("disabled", false); 
		} else if (type == "A4") {
			$("#mbrNo").attr("disabled", true); 
			$("#origin").attr("disabled", false); 
			$("#desti").attr("disabled", false)
			$("#date").attr("disabled", false);
		} else if (type == "A10") {
			$("#orgnApprNo").attr("disabled", false); 
		} else {
			$("#ticket").attr("disabled", false); 
			$("#airline").attr("disabled", false); 
			$("#date").attr("disabled", false); 
			$("#origin").attr("disabled", false); 
			$("#desti").attr("disabled", false); 
			$("#classCd").attr("disabled", false); 
			$("#flightNo").attr("disabled", false); 
			$("#passenger").attr("disabled", false); 
		}
		
		if (type == "A2") {
			$("#ticket").attr("disabled", true);
		}
		
		if (type == "A5") {
			$("#txnMile").attr("disabled", false);
		}
		
		
		$.each($("#ruleDemoPopForm input"), function(i, obj) {
			$(obj).attr("required", !$(obj).is('[disabled]')); 
		});
		
    }
}

$(document).ready(function(){
	acrlMilePop = new acrlMileagePopFn();
	acrlMilePop.init();
})
</script>