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

<%-- var testViewList_rid = '<%= request.getParameter("rid") %>'; --%>
var defaultArchive =  '<%= cleanXss(request.getParameter("defaultArchive")) %>';
console.log(defaultArchive);

function addInfoDetailDataLoad(testViewList_rid) {
 $.ifvSyncPostJSON('<ifvm:action name="getTransactAddInfo"/>', {
  rid: testViewList_rid,
  defaultArchive : defaultArchive
 }, function(result) {
  if($.fn.ifvmIsNotEmpty(result)) {
 	 	$($('#stampTxnDetailForm').find('input')).each(function(index, item){
 	 		var value=result.rows[0][$(item).attr('id')];
 	 		isEmptyCheck(value);
 	 		if(isEmpty){
			/* 	if(result.rows[0][$(item).attr('id')].split(".").length>1){
					var numVal=result.rows[0][$(item).attr('id')].split(".")[0];

					if(numVal.split("-").length>1){//날짜필드
						$(item).val(numVal);
					}else{ //숫자필드
						$(item).val(numberWithCommas(numVal));
						$(item).attr("style", "text-align:right;");
					}

				}else{
			 		$(item).val(result.rows[0][$(item).attr('id')]);
				} */
 	 			$(item).val(result.rows[0][$(item).attr('id')]);
			}
 	 		if($(this).attr('type')=="checkbox"){
 	 			if(result.rows[0][$(item).attr('id')]=='Y'){
 	 				$(this).attr('checked', 'true');
 	 			}
 	 		}
 			$(item).attr("disabled",true);
 		});

 		$($('#stampTxnDetailForm').find('select')).each(function(index, item){
 			$(item).val(result.rows[0][$(item).attr('id')]);
 			$(item).attr("disabled",true);
 		});
  }
    });
 tabNumFormatter();
 dateFormatSetting();
 dateYMFormatter();

}
function addCommCodeSetting(){
	$.ifvGetCommCodeList('select', 'tabReqTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_REQ_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'tabAmtTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_AMT_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'tabPaymentCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_PAYMENT', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'tabCnclTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'CANCEL_REASON', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'tabTerminalCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_TERMINAL', 'loy', true, true);

/*
	//요청유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_REQ_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#tabReqTypeCdTemp").tmpl(result.rows);
		$("#tabReqTypeCd").append(temp);
	});

	//금액유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_AMT_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#tabAmtTypeCdTemp").tmpl(result.rows);
		$("#tabAmtTypeCd").append(temp);
	});

	//결제수단
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_PAYMENT'
		, enableNA : true
	},function(result) {
		var temp = $("#tabPaymentCdTemp").tmpl(result.rows);
		$("#tabPaymentCd").append(temp);
	});

	//취소사유
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'CANCEL_REASON'
		, enableNA : true
	},function(result) {
		var temp = $("#tabCnclTypeCdTemp").tmpl(result.rows);
		$("#tabCnclTypeCd").append(temp);
	});

	//승인요청기관
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_TERMINAL'
		, enableNA : true
	},function(result) {
		var temp = $("#tabTerminalCdTemp").tmpl(result.rows);
		$("#tabTerminalCd").append(temp);
	}); */
}



function dateFormatSetting(){
	var dateFormatVal=$("#tabSndDate").val().split(".")[0];
	$("#tabSndDate").val(dateFormatVal);

	dateFormatVal = $("#tabTxnDate").val().split(".")[0]
	$("#tabTxnDate").val(dateFormatVal);

	dateFormatVal = $("#tabCnclDt").val().split(".")[0]
	$("#tabCnclDt").val(dateFormatVal);

}


function tabNumFormatter(){
	var numFormatVal=$("#tabProdUnitCost").val();
	if(numFormatVal !="" || numFormatVal==null){
		$("#tabProdUnitCost").val(parseFloat(numFormatVal));
		$("#tabProdUnitCost").attr("style","text-align:right");
	}
	numFormatVal=$("#tabProdQty").val();
	if(numFormatVal !="" || numFormatVal==null){

		$("#tabProdQty").val(parseFloat(numFormatVal));
		$("#tabProdQty").attr("style","text-align:right");
	}
	numFormatVal=$("#tabTxnAmt").val();
	if(numFormatVal !="" || numFormatVal==null){
		numFormatVal=(parseInt(numFormatVal));
		$("#tabTxnAmt").attr("style","text-align:right");
		$("#tabTxnAmt").val(numberWithCommas(numFormatVal));
	}
	numFormatVal=$("#tabGroupPnt").val();
	if(numFormatVal !="" || numFormatVal==null){
		numFormatVal=(parseInt(numFormatVal));
		$("#tabGroupPnt").attr("style","text-align:right");
		$("#tabGroupPnt").val(numberWithCommas(numFormatVal));

	}

	/* numFormatVal=$("#stnMaxUcost").val();
	$("#stnMaxUcost").ifvNumberOnly();
	$("#stnMaxUcost").val(numberWithCommas(numFormatVal)); */





 	numFormatVal=$("#tabCardDrctDdctPnt").val();
 	if(numFormatVal=="" || numFormatVal==null){
		numFormatVal = "0";
 	}else{
		numFormatVal=(parseInt(numFormatVal));
	}

	$("#tabCardDrctDdctPnt").attr("style","text-align:right");
	$("#tabCardDrctDdctPnt").val(numberWithCommas(numFormatVal));
}

function dateYMFormatter(){
	if($("#tabExpireMonths").val()!=""){
		var year;
		var month;
		var date;
		year = $("#tabExpireMonths").val().substring(0,4);
		month = $("#tabExpireMonths").val().substring(4,6);
		date=year+"-"+month;
		$("#tabExpireMonths").val(date);
	}
}

$(document).ready(function(){
	addCommCodeSetting();
	addInfoDetailDataLoad(testViewList_rid);
});

</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="form-horizontal underline top_well" id="stampTxnDetailForm" >
  <div class="row  qt_border">
  <ifvm:inputNew type="text" id="tabSndDate" maxLength="50"  dto="tabSndDate"   label="L00601" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="tabPaymentCd" maxLength="50"  dto="tabPaymentCd"   label="L00358" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabChnlNo" maxLength="50"  dto="tabChnlNo"   label="L00585" labelClass="1" conClass="2" />
  <label class="col-xs-1 control-label"><spring:message code="L00571"/></label>

 <div class="col-xs-2 control_content">
   <input type="checkbox"  id="tabCnclYn" />
  </div>
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="text" id="tabRefNo" maxLength="50"  dto="tabRefNo"   label="L00602" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabProdId" maxLength="50"  dto="tabProdId"   label="L00566" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabChnlNm" maxLength="50"  dto="tabChnlNm"   label="L00586" labelClass="1" conClass="2" />
  <ifvm:inputNew type="select" id="tabCnclTypeCd" maxLength="50"  dto="tabCnclTypeCd"   label="L00572" labelClass="1" conClass="2" />
 </div>

<div class="row  qt_border">
  <ifvm:inputNew type="select" id="tabTerminalCd" maxLength="50"  dto="tabTerminalCd"   label="L00603" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabProdNm" maxLength="50"  dto="tabProdNm"   label="L00567" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabGroupPnt" maxLength="50"  dto="tabGroupPnt"   label="L00587" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabCnclDt" maxLength="50"  dto="tabCnclDt"   label="L00411" labelClass="1" conClass="2" />
 </div>

 <div class="row  qt_border">
  <ifvm:inputNew type="text" id="tabTxnDate" maxLength="50"  dto="tabTxnDate"   label="L00604" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabProdUnitCost" maxLength="50"  dto="tabProdUnitCost"   label="L00605" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabRidMbrTransfer" maxLength="50"  dto="tabRidMbrTransfer"   label="L00562" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabOrgnApprDate" maxLength="50"  dto="tabOrgnApprDate"   label="L00612" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">
    <ifvm:inputNew type="text" id="tabTicketNum" maxLength="50"  dto="tabTicketNum"   label="L00576" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabProdQty" maxLength="50"  dto="tabProdQty"   label="L00606" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabCustNm" maxLength="50"  dto="tabCustNm"   label="L00563" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabOrgnApprNo" maxLength="50"  dto="tabOrgnApprNo"   label="M02020" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">
    <ifvm:inputNew type="select" id="tabReqTypeCd" maxLength="50"  dto="tabReqTypeCd"   label="L00607" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabTxnAmt" maxLength="50"  dto="tabTxnAmt"   label="L00355" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabCardDrctDdctPnt" maxLength="50"  dto="tabCardDrctDdctPnt"   label="L00608" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="tabExpireMonths" maxLength="50"  dto="tabExpireMonths"   label="L00609" labelClass="1" conClass="2" />

 </div>
 <div class="row  qt_border">


  <ifvm:inputNew type="select" id="tabAmtTypeCd" maxLength="50"  dto="tabAmtTypeCd"   label="L00610" labelClass="1" conClass="2" />
    <label class="col-xs-1 control-label"><spring:message code="L00611"/></label>
 <div class="col-xs-2 control_content">
   <input type="checkbox"  id="tabAutoDeductYn" />
  </div>
  <ifvm:inputNew type="text" id="tabCouponNo" maxLength="50"  dto="tabCouponNo"   label="M00346" labelClass="1" conClass="2" />
 </div>

</div>




