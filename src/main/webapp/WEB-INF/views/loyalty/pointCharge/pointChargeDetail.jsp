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

var pntChargeRid = '<%= cleanXss(request.getParameter("rid")) %>';

var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var manualDtlValid;
var chnlObj=null;

function pointChargeDetailDataLoad(pntChargeRid) {
	if(pntChargeRid !=null){
		$.ifvSyncPostJSON('<ifvm:action name="getPointChargeDetail"/>', {
			  rid: pntChargeRid
			 }, function(result) {
			  if($.fn.ifvmIsNotEmpty(result)) {
				  var pntChargeObj =result.rows[0];
			 		$($('#pntChargeDtlForm').find('input')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 	 		if($(this).attr('type')=="checkbox"){
			 	 			if(result.rows[0][$(item).attr('id')]=='Y'){
			 	 				$(this).attr('checked', 'true');
			 	 			}
			 	 		}
			 			$(item).attr("disabled",true);
			 		});

			 		$($('#pntChargeDtlForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 			$(item).attr("disabled",true);
			 		});
			  }
			  if((pntChargeObj.cardTypeCd=="20"&&pntChargeObj.cprtCardCd!='' )||pntChargeObj.cardTypeCd=='30'){
				  $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
			            rid: pntChargeRid ,
			            type: 'lspt' ,
			            field: 'cardNum'
			        },function(result) {
			        	if(result.message!=null){
				        	 $("#cardNum").val(result.message);
			        	}
			        });
			  }
			});
	}
	numberFormatter();
	dateFormatSetting();
}

//날짜 뒤에 .0 삭제
function dateFormatSetting(){
	var dateFormatVal=$("#approveDt").val().split(".")[0];
	$("#approveDt").val(dateFormatVal);

	dateFormatVal = $("#cancelDt ").val().split(".")[0]
	$("#cancelDt ").val(dateFormatVal);

	dateFormatVal = $("#orgTxnDt").val().split(".")[0]
	$("#orgTxnDt").val(dateFormatVal);
}

//숫자데이터 포매터 처리
function numberFormatter(){
	var numFormatVal=$("#accPoints").val();

	$("#accPoints").ifvNumberOnly();
	$("#accPoints").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#usePoints").val();
	$("#usePoints").ifvNumberOnly();
	$("#usePoints").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#totalUsablePoints").val();
	$("#totalUsablePoints").ifvNumberOnly();
	$("#totalUsablePoints").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#txnUcost").val();
	$("#txnUcost").ifvNumberOnly();
	$("#txnUcost").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#prodCost").val();
	$("#prodCost").ifvNumberOnly();
	$("#prodCost").val(numberWithCommas(numFormatVal));

	numFormatVal=$("#adjListPri").val();
	$("#adjListPri").ifvNumberOnly();
	$("#adjListPri").val(numberWithCommas(numFormatVal));
}

//1000단위 정규식
function numberWithCommas(x) {
    return Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function pntChargeListFn(){
	var url = '<ifvm:url name="pointChargeList"/>';
	qtjs.href(url);
}
function commCodeSetting(){
	$.ifvGetCommCodeList('select', 'typeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_TYPE_CD', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'subTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'SPNT_TXN_SUB_TYPE_CD', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'terminalCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_TERMINAL', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'reqTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_REQ_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'amtTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_AMT_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'paymentTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'TXN_PAYMENT', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'memDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'memGrade', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'cancelCd', '<ifvm:action name="getCommCodeList2"/>', 'CANCEL_REASON', 'loy', true, true);
}

$(document).ready(function(){
	$.ifvmLnbSetting('pointChargeList');
	commCodeSetting();
	pointChargeDetailDataLoad(pntChargeRid);
   	});

</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
 <h1>
     <spring:message code="L01019"/>&gt;  <spring:message code="L00079"/>
 </h1>
</div>

<div class="page_btn_area" id="headForm">
 <div class="col-xs-4">
  <span> <spring:message code="L01021"/></span></span>
 </div>

 <div class="col-xs-8 searchbtn_r">
	 <ifvm:inputNew type="button"   text="L00824"  id="pntChargeListBtn" btnFunc="pntChargeListFn"/>
 </div>
</div>

<div id="pntChargeDtlForm">

<div class="form-horizontal underline top_well">

	<div class="row  qt_border">
	  	<ifvm:inputNew type="text" id="approveDt" maxLength="50"  dto="approveDt"   label="L00935" labelClass="1" conClass="2"   />
		<ifvm:inputNew type="text" id="mbrNo" maxLength="50"  dto="mbrNo"   label="L00975" labelClass="1" conClass="2"  disabled="true"/>
		<ifvm:inputNew type="text" id="accPoints" maxLength="50"  dto="accPoints"   label="L01013" labelClass="1" conClass="2" disabled="true"/>
	 	<label class="col-xs-1 control-label"><spring:message code="L00571"/></label>
  		<div class="col-xs-2 control_content">
			<input type="checkbox"  id="cancelFlg" />
  		</div>


	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="text" id="approvalNm" maxLength="50"  dto="approvalNm"   label="L00995" labelClass="1" conClass="2"  />
		<ifvm:inputNew type="text" id="custNm" maxLength="50"  dto="custNm"   label="L00435" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="usePoints" maxLength="50"  dto="usePoints"   label="L01014" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="select" id="cancelCd" maxLength="50"  dto="cancelCd"   label="L00572" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="typeCd" maxLength="50"  dto="typeCd"   label="L00996" labelClass="1" conClass="2" />
		<ifvm:inputNew type="select" id="memDiv" maxLength="50"  dto="memDiv"   label="L00837" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="totalUsablePoints" maxLength="50"  dto="totalUsablePoints"   label="L01015" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="cancelDt" maxLength="50"  dto="cancelDt"   label="L00411" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="subTypeCd" maxLength="50"  dto="subTypeCd"   label="L00997" labelClass="1" conClass="2" />
		<ifvm:inputNew type="select" id="memGrade" maxLength="50"  dto="memGrade"   label="L00180" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="prodId" maxLength="50"  dto="prodId"   label="L00566" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="orgTxnDt" maxLength="50"  dto="orgTxnDt"   label="L00612" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="terminalCd" maxLength="50"  dto="terminalCd"   label="L00603" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="cardNum" maxLength="50"  dto="cardNum"   label="L00917" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="prodNm" maxLength="50"  dto="prodNm"   label="L01006" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="orgTxnApprvNum" maxLength="50"  dto="orgTxnApprvNum"  label="L00575" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="reqTypeCd" maxLength="50"  dto="reqTypeCd"   label="L00607" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="chnlNo" maxLength="50"  dto="chnlNo"   label="L00788" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="txnUcost" maxLength="50"  dto="txnUcost"   label="L00605" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="ticketNum" maxLength="50"  dto="ticketNum"   label="L00576" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="amtTypeCd" maxLength="50"  dto="amtTypeCd"   label="L00610" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="chnlNm" maxLength="50"  dto="chnlNm"   label="L00565" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="prodCost" maxLength="50"  dto="prodCost"   label="L00606" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="complexApprvNum" maxLength="50"  dto="complexApprvNum"   label="L00577" labelClass="1" conClass="2" disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="paymentTypeCd" maxLength="50"  dto="paymentTypeCd"   label="L00358" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="bizrNo" maxLength="50"  dto="bizrNo"   label="L00597" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="adjListPri" maxLength="50"  dto="adjListPri"   label="L00945" labelClass="1" conClass="2" disabled="true"/>
		<ifvm:inputNew type="text" id="stationGiftNm" maxLength="50"  dto="stationGiftNm"   label="L01016" labelClass="1" conClass="2" disabled="true" />
	</div>

</div>

<script>
</script>
<div id="channelSearchPopDiv" class="popup_container"></div>