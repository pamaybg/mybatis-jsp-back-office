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
var actObj={}
actObj.actYearMonth= '<%= cleanXss(request.getParameter("actYearMonth")) %>';
actObj.actnum= '<%= cleanXss(request.getParameter("actnum")) %>';
var tempObj= {};
var sumObj = {};
var insertCnt="";

function settleHistoryDetailSetting(){
	console.log(actObj);
	if(actObj!=null){
		$.ifvSyncPostJSON('<ifvm:action name="getSettleHistoryDetail"/>', actObj, function(result) {

			$("#settleHistoryDetailForm").dataSetting(result);
			if(result.aprvrequest != $.ifvmGetUserInfo().empId){
				$("#cancelApprovalBtn").prop('disabled',true);
			}

			//enis전송여부
			/* if(result.secapprove != ''){
				$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
					groupCode : 'ENIS_TRANS_YN_CODE',
					codeName : result.secapprove
				},function(result){
					$("#secapprove").val(result.rows[0].markName);
				});
			} */
		});
	}
	dateFormatSetting();
	numberFormatterSetting();
	buttonValid();

}

//1000단위 정규식
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatterSetting() {

	var numFormatVal =   $("#acte1share").val().split(".")[0];
	$("#acte1share").ifvNumberOnly();
	$("#acte1share").val(numberWithCommas(numFormatVal));

	numFormatVal =  $("#actpointsum").val().split(".")[0];
	$("#actpointsum").ifvNumberOnly();
	$("#actpointsum").val(numberWithCommas(numFormatVal));

	numFormatVal =   $("#actpartshare").val().split(".")[0];
	$("#actpartshare").ifvNumberOnly();
	$("#actpartshare").val(numberWithCommas(numFormatVal));
}

function dateFormatSetting(){
	var year;
	var month;
	var day;
	var date;
	year =  $("#actenddt").val().substring(0,4);
	month = $("#actenddt").val().substring(4,6);
	day = $("#actenddt").val().substring(6,8);

	date = year+ "-" + month + "-" + day;
	$("#actenddt").val(date);

	year =  $("#actstartdt").val().substring(0,4);
	month = $("#actstartdt").val().substring(4,6);
	day = $("#actstartdt").val().substring(6,8);

	date = year+ "-" + month + "-" + day;
	$("#actstartdt").val(date);
}

function settleHistoryListFn() {
	var url = '<ifvm:url name="settleHistoryList"/>';
	qtjs.href(url);
}

function inspectorSearchFn() {
	inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
			+ '?authNm=' + 'E10007')
}

function inspectorSearchHelpEnter() {
	if ($('#fstapprovenm').val() == "") {
		$('#fstapprove').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10007&&name='
				+ encodeURI(encodeURIComponent($('#actcNm').val())));
	}
}

function inspectorSearchHelpBlur() {
	if ($('#fstapprovenm').val() == "") {
		$('#fstapprove').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10007&&name='
				+ encodeURI(encodeURIComponent($('#actcNm').val())));
	}
}

function inspectorSearchPopOpen(url) {
	empSearchHelpPop = {
		id : "empSearchPopDiv"
	};
	empSearchHelpPop.popup = function() {
		empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : url,
			contentType : "ajax",
			title : "<spring:message code='L00989'/>",
			width : "700px",
		});
	};
	empSearchHelpPop.beforeClose = function(obj) {
	};
	empSearchHelpPop.close = function(obj) {
		if (obj != null || typeof obj != "undefined") {
			if(obj.name==$.ifvmGetUserInfo().empName){
				alert("<spring:message code='L01867'/> ");
				return;
			}

			if (obj.authNm == 'E10007') {
				$("#fstapprovenm").val(obj.name);
				$("#fstapprove").val(obj.rid);
				tempObj.fstapprovenm = obj.name;
			}
		} else {
			$("#fstapprovenm").val(tempObj.fstapprovenm);
		}
		this.beforeClose(obj);
		empSearchPopDiv._destroy();
	};
	empSearchHelpPop.popup();
}

function approverSearchFn() {
	approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
			+ '?authNm=' + 'E10008')
}

function approverSearchHelpEnter() {
	if ($('#secapprovenm').val() == "") {
		$('#secapprove').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10008&&name='
				+ encodeURI(encodeURIComponent($('#apvNm').val())));
	}
}

function approverSearchHelpBlur() {
	if ($('#secapprovenm').val() == "") {
		$('#secapprove').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10008&&name='
				+ encodeURI(encodeURIComponent($('#apvNm').val())));
	}
}

function approverSearchHelpOpenPop(url) {
	empSearchHelpPop = {
		id : "empSearchPopDiv"
	};
	empSearchHelpPop.popup = function() {
		empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : url,
			contentType : "ajax",
			title : "<spring:message code='L00990'/>",
			width : "700px"
		});
	};
	empSearchHelpPop.beforeClose = function(obj) {
	};
	empSearchHelpPop.close = function(obj) {
		if (obj != null || typeof obj != "undefined") {
			if(obj.name==$.ifvmGetUserInfo().empName){
				alert("<spring:message code='L01868'/> ");
				return;
			}

			if (obj.authNm == 'E10008') {
				$("#secapprovenm").val(obj.name);
				$("#secapprove").val(obj.rid);
				tempObj.secapprovenm = obj.name;
			}
		} else {
			$("#secapprovenm").val(tempObj.secapprovenm)
		}
		this.beforeClose(obj);
		empSearchPopDiv._destroy();
	};
	empSearchHelpPop.popup();
}


var settleLogList;
var actseq =null ;
//정산처리 로그
function getSettleLogListSearch(){
    var jqGridOption = {
		ondblClickRow : function(data){
	      var data = settleLogList.getRowData()[data-1];
	      actseq = data.actseq;
	      var url = '<ifvm:url name="settleLogPop"/>' + '?actSeq='+actseq+"&&dbClick=Y"
	      correctionFn(url);
	    },
        onSelectRow : function (data) {
/*         	if(settleLogList.getCheckedGridData().length >0){
            	actseq = settleLogList.getCheckedGridData()[0].actseq;
        	}else{
        		actseq =null;
        	} */
        },

       serializeGridData : function( data ){
        	data.actYearMonth = actObj.actYearMonth;
        	data.actnum =  actObj.actnum;

            return data;
        },
        loadComplete : function(obj){
        	//insertDataCheck();
        	settlLogGridTotal();
        	actseq =null;
        	console.log(obj);
        },
        url : '<ifvm:action name="getSettleLogList"/>',
        colNames:[
                   '<spring:message code="L01898" />',  /* 가맹점번호 */
                   '<spring:message code="L01897" />',  /* 정산방법 */
                   '<spring:message code="L01899" />',  /* 제품코드 */
                   '<spring:message code="L01900" />',	/* 제품명 */
                   '<spring:message code="L01901" />',	/* 사업자번호 */
                   '<spring:message code="L01902" />',	/* 전체 금액 */
                   '<spring:message code="L01903" />',	/* E1 금액 */
                   '<spring:message code="L01904" />',	/* 가맹점 금액 */
                   '<spring:message code="L00660" />',	/* 사유 */
                   'actseq',	/* 순번 */
                 ],
        colModel:[
             { name:'actpartner',   index:'actpartner',  	resizable : true, align:'center',   width:'100px' },
             { name:'actmethod',   	index:'actmethod',  	resizable : true, align:'center',   width:'100px'  ,formatter : getActmethodCommCode },
             { name:'actprodcode',  index:'actprodcode',  	resizable : true, align:'center',   width:'100px'  },
             { name:'actprodnm',   	index:'actprodnm',  	resizable : true, align:'center' ,  width:'100px' },
             { name:'actounum',   	index:'actounum',  		resizable : true, align:'center' ,  width:'100px' },
             { name:'actpointsum',  index:'actpointsum',  	resizable : true, align:'right',    width:'100px' ,formatter:'integer'	,searchable:false},
             { name:'acte1share',   index:'acte1share',  	resizable : true, align:'right',    width:'100px' ,formatter:'integer'	,searchable:false},
             { name:'actpartshare', index:'actpartshare',  	resizable : true, align:'right',    width:'100px' ,formatter:'integer'	,searchable:false},
             { name:'actreason',   	index:'actreason',  	resizable : true, align:'left',    	width:'150px' },
             { name:'actseq',   	index:'actseq', 	hidden: true },
        ],
         sortname: 'actseq'
        ,autowidth : true
        ,sortorder: "desc"
        ,footerrow: true
        , shrinkToFit: false
        ,userDataOnFooter : true
        ,multiselect : true
        ,tempId : 'ifvGridOriginTemplete'

    };
    settleLogList = $("#settleLogGridList").ifvGrid({ jqGridOption : jqGridOption });
}

function getActmethodCommCode(cellvalue, options, rowObjec){
	var actmethod = rowObjec.actmethod;
	$("#actmethodCommCode").val(actmethod);
	var text =$("#actmethodCommCode option:selected").text();
	return text;
}

function settlLogGridTotal(){
	$.ifvSyncPostJSON('<ifvm:action name="getSettleDetailPointSum"/>', actObj, function(result) {
		sumObj=result;
		var e1sharesum = sumObj.e1sharesum.split(".")[0];
		var partsharesum = sumObj.partsharesum.split(".")[0];
		var pointsum = sumObj.pointsum.split(".")[0];
		settleLogList.setFooter({"actpartner" : "Total", "actpointsum" :  Math.round(Number(pointsum)),  "acte1share" :  Math.round(Number(e1sharesum))  ,"actpartshare" :  Math.round(Number(partsharesum))    });
	});
}

function correctionPopOpen(){
	if(settleLogList.getCheckedGridData().length>1){
		alert("<spring:message code='L02112'/>");
		return;
	}
	var url = '<ifvm:url name="settleLogPop"/>';
	if(settleLogList.getCheckedGridData().length>0){
		actseq = settleLogList.getCheckedGridData()[0].actseq;
		url = '<ifvm:url name="settleLogPop"/>' + '?actSeq='+actseq+"&&dbClick=N"
	}
	correctionFn(url);
}

function correctionFn(url){
	settleLogPop ={
		        id : "settleLogPopDiv"
		    };
	 settleLogPop.popup = function (){
		 settleLogPop.pop = $('#'+settleLogPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: url,
		            contentType: "ajax",
		            title: '<spring:message code="L01918" />',
		            width: "1000px"
		        });
		};
		settleLogPop.beforeClose = function (obj) {
			settleLogList.requestData();
			insertDataCheck();
		};
		settleLogPop.close = function (obj) {
			if(obj != null ){
				this.beforeClose(obj);
			}
		    this.pop.data('ejDialog')._destroy();
		};
		settleLogPop.popup();
}

function insertDataCheck(){
	$.ifvSyncPostJSON('<ifvm:action name="getSettleDetailSeqCheck"/>', actObj, function(result) {
		insertCnt = result.seqcnt;
		buttonValid();
		$.ifvSyncPostJSON('<ifvm:action name="getSettleDetailPointSum"/>', actObj, function(result) {

			var dObj = {
					acte1share : result.e1sharesum.split(".")[0],
					actpartshare : result.partsharesum.split(".")[0],
					actpointsum : result.pointsum.split(".")[0]
			}
			actObj = $.extend(actObj,dObj);
			$.ifvSyncPostJSON('<ifvm:action name="updateSettleDetailSum"/>', actObj, function(result) {

				settleHistoryDetailSetting();

			});
		});
	});
}

function sumObjSetting(){
	$.ifvSyncPostJSON('<ifvm:action name="getSettleDetailPointSum"/>', actObj, function(result) {
		sumObj=result;
	});
}

function settleHistoryDetailDisabled(){
	$($('#settleHistoryDetailForm').find('input')).each(function(index, item){
		$(item).attr("disabled",true);
	});
	$($('#settleHistoryDetailForm').find('select')).each(function(index, item){
		$(item).attr("disabled",true);
	});
	$($('#settleHistoryDetailForm').find('textarea')).each(function(index, item){
		$(item).attr("disabled",true);
	});
	$("#actcSearchBtn").addClass("hidden");
	$("#approverSearchBtn").addClass("hidden");
}

function approvalFn(){
	var submitData =  $("#settleHistoryDetailForm").getSubmitData();
	submitData.actYearMonth = actObj.actYearMonth;
	submitData.actnum = actObj.actnum;
	submitData.aprvrequestnm = $.ifvmGetUserInfo().empName;
	submitData.aprvrequest = $.ifvmGetUserInfo().empId;

	console.log(submitData);

	if(vanConfirmValid(submitData)){
		$.ifvSyncPostJSON('<ifvm:action name="settleApprovalReq"/>', submitData
				, function(result) {


			alert(result.message);
			//settleHistoryDetailSetting();
			qtjs.reload();
		});
	}
}

function vanConfirmValid(obj){
	var vanValid = true;
	if(obj.fstapprovenm==""|| obj.fstapprovenm==null){
		$.ifvCallValidationBox($("#fstapprovenm"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}
/* 	if(obj.secapprovenm==""|| obj.secapprovenm==null){
		$.ifvCallValidationBox($("#secapprovenm"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	} */
	var e1sharesum = sumObj.e1sharesum.split(".")[0];
	var partsharesum = sumObj.partsharesum.split(".")[0];
	var pointsum = sumObj.pointsum.split(".")[0];

	/* if(pointsum!=obj.actpointsum ){
		alert("<spring:message code='L01954'/>");
		vanValid = false;
		return vanValid;
	}

	if(e1sharesum!=obj.acte1share ){
		alert("<spring:message code='L01955'/>");
		vanValid = false;
		return vanValid;
	}
	if(partsharesum!=obj.actpartshare ){
		alert("<spring:message code='L01956'/>");
		vanValid = false;
		return vanValid;
	} */
	return vanValid;
}

function buttonValid(){
	if($("#aprvstatus").val()!=""){ //상태값이 빈값이 아니면 보정 버튼 잠금
		$("#correctionBtn").attr("disabled",true);
		settleHistoryDetailDisabled();
	}
	if($("#aprvstatus").val()=="20" || $("#aprvstatus").val()=="10") {//결재요청, 작성중
		//$("#approvalBtn").attr("disabled",true);
	}
	if($("#aprvstatus").val()=="10" || $("#aprvstatus").val()=="50"){//작성중, 결재요청취소
		//$("#approvalBtn").attr("disabled",false);
		//$("#settleConfirmBtn").attr("disabled",true);
		$("#correctionBtn").attr("disabled",false);

		//$("#fstapprovenm").attr("disabled",false);
		$("#actcSearchBtn").removeClass("hidden");
	}
	if($("#aprvstatus").val()!="20"){ //결제 요청
		$("#cancelApprovalBtn").prop('disabled',true);
	}
	if(parseInt(insertCnt)>0){  //보정 등록된게 있을시
		if($("#aprvstatus").val()!="20"){//결재요청이 아닐때
			//$("#settleConfirmBtn").attr("disabled",true);
			//$("#approvalBtn").attr("disabled",false);
		}

	}else{
		//$("#approvalBtn").attr("disabled",true);
	}
	//승인요청 버튼 활성화 규칙 => 승인상태 Null OR 승인상태  승인거절 or 결재요청취소
	if($("#aprvstatus").val()=="" || $("#aprvstatus").val()=="40" ||$("#aprvstatus").val()=="50"){
		$("#approvalBtn").attr("disabled",false);
	}else{
		$("#approvalBtn").attr("disabled",true);
	}

	//정산확정 버튼 활성화 규칙 => 승인상태 승인완료 일경우 활성화
	if($("#aprvstatus").val()=="30"){
		$("#settleConfirmBtn").attr("disabled",false);
	}else{
		$("#settleConfirmBtn").attr("disabled",true);
	}
	if($("#secapprove").val() == "0"){
		$("#settleConfirmBtn").attr("disabled",true);
	}
}

function commCodeSetting() {
	//$.fn.ifvGetCommCodeList 통해서 attribu검색 조건 넣기
	$.fn.ifvGetCommCodeList('select', 'actmethodCommCode', '<ifvm:action name="getCommCodeList2"/>', 'ECOS_NICK_B01', 'loy', true, true, null, null, null, null, '정산');
	$.ifvGetCommCodeList('select', 'aprvstatus', '<ifvm:action name="getCommCodeList2"/>', 'REQ_STATUS_CD', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'secapprove', '<ifvm:action name="getCommCodeList2"/>', 'ENIS_TRANS_YN_CODE', 'loy', true, true);
}

$(document).ready(function() {
	commCodeSetting();
	$.ifvmLnbSetting('settleHistoryList');
	settleHistoryDetailSetting();
	getSettleLogListSearch();
	//sumObjSetting();
	//insertDataCheck();
})
</script>
<div class="page-title">
	<h1>
		<spring:message code="L01876"/>&gt;  <spring:message code="L00079"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L01894" /></span>
	</div>

	<div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button" text="L01916" id="approvalBtn" btnFunc="approvalFn" />
		<ifvm:inputNew type="button" text="L01765" id="cancelApprovalBtn" btnFunc="fnCancelApproval" />
		<ifvm:inputNew type="button" text="L01896" id="settleConfirmBtn" btnFunc="settleConfirmFn" />
		<ifvm:inputNew type="button" text="L01698" id="litBtn" btnFunc="settleHistoryListFn" />
	</div>
	<script>
	function fnCancelApproval(){
		var submitData = actObj;

		$.ifvSyncPostJSON('<ifvm:action name="cancelSettleAppr"/>',
			submitData, function(result) {

			alert('<spring:message code="L02060" />');
			qtjs.reload();
		});

	}
	function settleConfirmFn(){
		var submitData = actObj;
		submitData.empNo = $.ifvmGetUserInfo().empNo;

		$.ifvSyncPostJSON('<ifvm:action name="confirmSettle"/>',
				submitData, function(result) {

				alert('<spring:message code="L02060" />');
				qtjs.reload();
			});

	}
	</script>
</div>

<div class="form-horizontal underline top_well"  id="settleHistoryDetailForm">
	<div class="half_wrap top_well">
		<div class="half_content half_left">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L01895" /></span>
			</div>
		</div>

		<div class="row">
	    	<ifvm:inputNew type="text" id="actyearmonth"   dto="actyearmonth"   label="L01877" labelClass="2" conClass="4"  disabled="true"  />
		   <!-- 버전 -->
		    <ifvm:inputNew type="text" id="actnum" dto="actnum" label="L01884" labelClass="2" conClass="4"  disabled="true"   />
	 	</div>

	 	<div class="row">
		  	<ifvm:inputNew type="text" id="actstartdt"   dto="actstartdt"   label="L01878" labelClass="2" conClass="4"  disabled="true"   />
			<ifvm:inputNew type="text" id="actenddt"   dto="actenddt"   label="L01879" labelClass="2" conClass="4"   disabled="true" />
		</div>

		<div class="row ">
			<ifvm:inputNew type="text" id="actexecmethod"   dto="actexecmethod"   label="L01880" labelClass="2" conClass="4" disabled="true"   />
			<!--상태   -->
			<ifvm:inputNew type="text" id="actstatus"   dto="actstatus"   label="L01885" labelClass="2" conClass="4"  disabled="true"  />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="actpointsum"   dto="actpointsum"   label="L01881" labelClass="2" conClass="4"  disabled="true"   />
			<ifvm:inputNew type="text" id="acte1share"   dto="acte1share"   label="L01882" labelClass="2" conClass="4"  disabled="true"   />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="actpartshare"   dto="actpartshare"   label="L01883" labelClass="2" conClass="4"  disabled="true"  />
			<!--  enis전송방법 -->
			<ifvm:inputNew type="select" id="secapprove"   dto="secapprove"   label="L01886" labelClass="2" conClass="4"  disabled="true"   />

		</div>
		<div hidden="true">
			<ifvm:inputNew type="select" id="actmethodCommCode"   dto="actmethodCommCode"   label="L01886" labelClass="2" conClass="4"  disabled="true"   />
		</div>
	</div>


	<div id="approvalInfoForm">
		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="L01917" /></span>
				</div>
			</div>

			<div class="row">
			    <ifvm:inputNew type="select" id="aprvstatus"  dto="aprvstatus"   label="L01887" labelClass="2" conClass="4" disabled="true"/>
			    <ifvm:inputNew type="text" id="aprvrequestnm"  dto="aprvrequestnm"   label="L01888" labelClass="2" conClass="4" disabled="true"/>
			    <ifvm:inputNew type="hidden" id="aprvrequest"  dto="aprvrequest" />

		 	</div>
		 	<div class="row">
		 		<ifvm:inputNew type="search" id="fstapprovenm|actcSearchBtn" names="fstapprovenm" hidId="fstapprove" hidDto="fstapprove" dto="fstapprovenm"  btnFunc="inspectorSearchFn"
				searchBlurEvent="inspectorSearchHelpBlur" searchEnterEvent="inspectorSearchHelpEnter" label="L01707" labelClass="2" conClass="4" />
				<%-- <ifvm:inputNew type="search" id="secapprovenm|approverSearchBtn" names="secapprovenm" hidId="secapprove" hidDto="secapprove" dto="secapprovenm" disabled="false" btnFunc="approverSearchFn"
				searchBlurEvent="approverSearchHelpBlur" searchEnterEvent="approverSearchHelpEnter" label="L01707" labelClass="2" conClass="4" /> --%>
		 	</div>
		 	<div class="row">

		 	  <ifvm:inputNew type="textarea" id="rejectrsn"  dto="rejectrsn"   label="L01891" labelClass="2" conClass="10"  disabled="true" />
		 	</div>
		</div>
	</div>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L01905" /></span>
	</div>
	<div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button"  text="L01892" id="correctionBtn" btnFunc="correctionPopOpen" />
		<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('settleLogGridList')" />
	</div>
</div>
 <div id="settleLogGridList" class="white_bg grid_bd0"></div>


 <div id="empSearchPopDiv" class="popup_container"></div>
 <div id="settleLogPopDiv" class="popup_container"></div>