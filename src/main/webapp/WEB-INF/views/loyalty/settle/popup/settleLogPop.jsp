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
<script type="text/javascript">

var parActSeq = '<%= cleanXss(request.getParameter("actSeq")) %>'
var dbClick = '<%= cleanXss(request.getParameter("dbClick")) %>'
var tempObj = {};
var settleLogValid;

function settleLogPopDtlSetting(){
	if(parActSeq!="null"){
		var submitData={};
		submitData.actseq = parActSeq;
		submitData.actnum =actObj.actnum;
		submitData.actYearMonth = actObj.actYearMonth;
		$.ifvSyncPostJSON('<ifvm:action name="getSettleLogDetail"/>',submitData
				, function(result) {

					tempObj=result;
					$("#settleLogInfoPopForm").dataSetting(result);
					if( parseInt(result.actseq)<10000 && dbClick =="Y"){
						$("#settleLogInfoPopForm input, #settleLogInfoPopForm select").prop('disabled',true);
						if(dbClick =="Y"){
							$("#settleLogInfoPopForm .input-group-addon, #saveInfoPopBtn").hide();
						}
					}
					//승인상태가  결재요청 or 결재완료 이면 비활성화
					if($("#aprvstatus").val()=="20" ||$("#aprvstatus").val() =="30"){
						$("#settleLogInfoPopForm input, #settleLogInfoPopForm select").prop('disabled',true);
					}
			});
	}else{
		$("#actmethod").val("");
	}
	popNumberFormatterSetting();
}

function closePopFn(){
	settleLogPop.close();
}

function saveInfoPopFn(){
	settleLogValid = $("#settleLogInfoPopForm").ifvValidation();
	if (settleLogValid.confirm() == true) {
		var submitData = $("#settleLogInfoPopForm").getSubmitData();
		submitData.actYearMonth = actObj.actYearMonth;
		submitData.actnum = actObj.actnum;
		if(parActSeq=="null"){
			$.ifvSyncPostJSON('<ifvm:action name="addAccountDetail"/>',submitData
					, function(result) {
					alert('<spring:message code="I00741"/>');
					closePopFn(result);
					settleLogList.requestData();
					insertDataCheck();
				});
		}else{
			if(dbClick=="N"){
				//카피 등록
				$.ifvSyncPostJSON('<ifvm:action name="addAccountDetail"/>',submitData
						, function(result) {
						alert('<spring:message code="I00741"/>');
						closePopFn(result);
						settleHistoryDetailSetting();
						settleLogList.requestData();
						insertDataCheck();
					});

			}else{
				submitData.actseq = parActSeq
				$.ifvSyncPostJSON('<ifvm:action name="updateAccountDetail"/>',submitData
						, function(result) {
						alert('<spring:message code="M00106"/>');
						closePopFn(result);
						settleHistoryDetailSetting();
						settleLogList.requestData();
						insertDataCheck();
					});
			}

		}
	}
}

function copySaveFn(){
	var submitData = $("#settleLogInfoPopForm").getSubmitData();
	submitData.actYearMonth = actObj.actYearMonth;
	submitData.actnum = actObj.actnum;
	$.ifvSyncPostJSON('<ifvm:action name="addAccountDetail"/>',submitData
			, function(result) {
			alert('<spring:message code="I00741"/>');
			closePopFn();

			settleLogList.requestData();
			insertDataCheck();
		});
}

function numInputInit() {
	//기존 popNumberFormatterSetting 함수 내에서 중복선언되던 부분 분리
	//ifvNumberOnly 는 keyup event를 거는 함수로, 중복선언되면 선언된 만큼 keyup 이벤트도 중복호출됨
	$("#settleLogInfoPopForm #actpointsum").ifvNumberOnly();
	$("#settleLogInfoPopForm #acte1share").ifvNumberOnly();
	$("#settleLogInfoPopForm #actpartshare").ifvNumberOnly();
}

function popNumberFormatterSetting(){
	//소숫점 제거부분 임시변경
	//var numFormatVal=$("#settleLogInfoPopForm #actpointsum").val().split(".")[0];
	var numFormatVal=$("#settleLogInfoPopForm #actpointsum").val().split(".")[0];
	$("#settleLogInfoPopForm #actpointsum").val(numberWithCommas(numFormatVal));

	//numFormatVal=$("#settleLogInfoPopForm #acte1share").val().split(".")[0];
	numFormatVal=$("#settleLogInfoPopForm #acte1share").val().split(".")[0];
	$("#settleLogInfoPopForm #acte1share").val(numberWithCommas(numFormatVal));

	//numFormatVal=$("#settleLogInfoPopForm #actpartshare").val().split(".")[0];
	numFormatVal=$("#settleLogInfoPopForm #actpartshare").val().split(".")[0];
	$("#settleLogInfoPopForm #actpartshare").val(numberWithCommas(numFormatVal));

}

function channelSearchFn() {
	channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>'
			+ '?ouTypeCd=' + 'A')
}

function channelSearchHelpEnter() {
	if ($('#actpartner').val() == "") {
		$('#actounum').val("");
	} else {
		channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=A&&chnlNo='
				+ encodeURI(encodeURIComponent($('#actpartner').val())));
	}
}

function keyUpFn(){
	var submitData;
	var acte1Share;
	var actpartshare;
	var pointSum;
	$("#settleLogInfoPopForm #acte1share").keyup( function () {
		if($(this).val()!="-"){ //-일때 계산 못하게끔
			submitData  = $("#shareDiv").getSubmitData();
			if(submitData.acte1share ==""){
				submitData.acte1share="0";
			}
			acte1Share = parseInt(submitData.acte1share);
			if(submitData.actpartshare ==""){
				submitData.actpartshare="0";
			}
			actpartshare = parseInt(submitData.actpartshare);
			pointSum = acte1Share + actpartshare;
			$("#settleLogInfoPopForm #actpointsum").val(pointSum+"");
			popNumberFormatterSetting();
		}
	});

	$( "#settleLogInfoPopForm #actpartshare" ).keyup( function () {
		if($(this).val()!="-"){ //-일때 계산 못하게끔
			submitData  = $("#shareDiv").getSubmitData();
			if(submitData.acte1share ==""){
				submitData.acte1share="0";
			}
			acte1Share = parseInt(submitData.acte1share);
			if(submitData.actpartshare ==""){
				submitData.actpartshare="0";
			}
			actpartshare = parseInt(submitData.actpartshare);
			pointSum = acte1Share + actpartshare;
			$("#settleLogInfoPopForm #actpointsum").val(pointSum+"");
			popNumberFormatterSetting();
		}
	});
}


function channelSearchHelpBlur() {
	if ($('#actpartner').val() == "") {
		$('#actounum').val("");
	} else {
		channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=A&&chnlNo='
				+ encodeURI(encodeURIComponent($('#actpartner').val())));
	}
}

function channelSearchPopOpen(url) {
	channelSearchHelpPop = {
		id : "channelSearchPopDiv"
	};
	channelSearchHelpPop.popup = function() {
		channelSearchHelpPop.pop = $('#' + channelSearchHelpPop.id)
				.ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : url,
					contentType : "ajax",
					title : "<spring:message code='L00987'/>",
					width : "700px"
				});
	};
	channelSearchHelpPop.beforeClose = function(obj) {
		$("#actpartner").val(obj.chnlNo);
		$("#actounum").val(obj.bizrNo);
		tempObj.actpartner = obj.chnlNo;
	};
	channelSearchHelpPop.close = function(obj) {
		if (obj != null || typeof obj != "undefined") {
			channelSearchHelpPop.beforeClose(obj);
		} else {
			$("#actpartner").val(tempObj.actpartner);
		}
		this.beforeClose(obj);
		channelSearchPopDiv._destroy();
	};
	channelSearchHelpPop.popup();
}


function popCommCodeSetting() {
	//$.fn.ifvGetCommCodeList 통해서 attribu검색 조건 넣기
	$.fn.ifvGetCommCodeList('select', 'actmethod', '<ifvm:action name="getCommCodeList2"/>', 'ECOS_NICK_B01', 'loy', true, true, null, null, null, null, '정산');
}


function prodSearchHelpBlur(){
	if($.trim($('#actprodnm').val())==""){
		$('#actprodcode').val("");
	}else{
		prodSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#actprodnm').val())));
	}
}

function prodSearchHelpEnter(){
	if($.trim($('#actprodnm').val())==""){
		$('#actprodcode').val("");
	}else{
		prodSearchPopOpen('<ifvm:url name="prodSearchHelp"/>'+"?prodNm="+encodeURI(encodeURIComponent($('#actprodnm').val())));
	}
}

function prodSearchFn(){
	prodSearchPopOpen('<ifvm:url name="prodSearchHelp"/>');
}

function prodSearchPopOpen(url){
	prodSearchHelpPop ={
	        id : "prodSearchHelpPopDiv"
	    };
	prodSearchHelpPop.popup = function (){
	prodSearchHelpPop.pop = $('#'+prodSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L01394'/>",
	            width: "700px"
	        });
	};
	prodSearchHelpPop.beforeClose = function (obj) {
	};
	prodSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
	        	$("#actprodnm").val(obj.prodNm);
	        	$("#actprodcode").val(obj.prodId);
	        	tempObj.actprodnm = obj.prodNm;
	        }else{
	        	$("#actprodnm").val(tempObj.actprodnm);
	        }

	        this.beforeClose(obj);
	        prodSearchHelpPopDiv._destroy();
	 };
	 prodSearchHelpPop.popup();
}

$(document).ready(function() {
	numInputInit();
	popCommCodeSetting();
	settleLogPopDtlSetting();

	keyUpFn();
});
</script>

<div id="settleLogInfoPopForm" >
	<div class="form-horizontal underline top_well" >
	 	<div class="row">
	    	<ifvm:inputNew type="select" id="actmethod"   dto="actmethod"   label="L01906" labelClass="2" conClass="2" required="true"   />

		   	<ifvm:inputNew type="search" id="actpartner|btnChannelSearch"  names="actpartner"  dto="actpartner" disabled="false" required="true" btnFunc="channelSearchFn"
				searchBlurEvent="channelSearchHelpBlur" searchEnterEvent="channelSearchHelpEnter" label="L01907"  labelClass="2" conClass="2" />

			<ifvm:inputNew type="search" id="actprodnm|prodSearch"  dto="actprodnm" names="taxtnProdNm"  disabled="false" required="true"
			   btnFunc="prodSearchFn" searchBlurEvent="prodSearchHelpBlur" searchEnterEvent="prodSearchHelpEnter" label="L01909"  labelClass="2" conClass="2" />





	 	</div>

		<div class="row">
			<ifvm:inputNew type="text" id="actpointsum"   dto="actpointsum"   label="L01911" labelClass="2" conClass="2" required="true" disabled="true" />
		    <ifvm:inputNew type="text" id="actounum"   dto="actounum"   label="L01910" labelClass="2" conClass="2"  required="true"  />
		    <ifvm:inputNew type="text" id="actprodcode"  dto="actprodcode"   label="L01908" labelClass="2" conClass="2" disabled="true" required="true"  />

	 	</div>

	 	<div class="row" id="shareDiv">
	    	<ifvm:inputNew type="text" id="acte1share"   dto="acte1share"   label="L01912" labelClass="2" conClass="2" required="true"  />
		    <ifvm:inputNew type="text" id="actpartshare"   dto="actpartshare"   label="L01913" labelClass="2" conClass="2" required="true"  />

	 	</div>
	 	<div class="row" id="shareDiv">
	    	<ifvm:inputNew type="text" id="actreason"   dto="actreason"   label="L00660" labelClass="2" conClass="10"  />
	 	</div>
	 	<div>
	 		 <ifvm:inputNew type="hidden" id="actseq"   dto="actseq" />
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="saveInfoPopBtn" btnFunc="saveInfoPopFn"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closePoppBtn" btnFunc="closePopFn"/>
</div>

 <div id="channelSearchPopDiv" class="popup_container"></div>
 <div id="prodSearchHelpPopDiv" class="popup_container"></div>
