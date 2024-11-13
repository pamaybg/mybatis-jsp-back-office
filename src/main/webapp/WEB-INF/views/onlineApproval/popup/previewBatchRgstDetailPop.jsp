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

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var prodTempObj={};
var tempObj= {};
function batchRgstDetailSetting(){
	if(testViewList_rid!=null){
		$.ifvSyncPostJSON('<ifvm:action name="getBatchRgstDetail"/>', {
			rid : testViewList_rid
		}, function(result) {
			$("#batchRgstDtlForm").dataSetting(result);

		});
		numberFormatterSetting();
		dateFormatSetting();
	}
	if($("#chnlNo").val()==""){

		$.ifvSyncPostJSON('<ifvm:action name="selectE1ChannelSetting"/>', {
			chnlNo : "10000"
		}, function(result) {
			if (result.records != 0) {
				var obj = result.rows[0];
				$("#chnlNm").val(obj.chnlNm);
				$("#chnlNo").val(obj.chnlNo);
				$("#ridChnl").val(obj.rid);
			}
		})
	}


	buttonValid();
}


function buttonValid(){
	if($("#ridActcSbst").val()!=ifvmUserInfo.empId){    //검수자 일시 버튼 보여줌
		$("#vanApprovalBtn").addClass("hidden");
		$("#vanReApprovalBtn").addClass("hidden");
		$("#vanReApprovalEndBtn").addClass("hidden");

		$("#pointSaveBtn").removeClass("hidden");
		$("#mainVanConfirmReqBtn").removeClass("hidden");
		$("#batchRgstSaveBtn").removeClass("hidden");
		$("#pointCancelBtn").removeClass("hidden");
		$("#pointEditBtn").removeClass("hidden");
	}else{
		$("#vanApprovalBtn").removeClass("hidden");
		$("#vanReApprovalBtn").removeClass("hidden");
		$("#vanReApprovalEndBtn").removeClass("hidden");

		$("#pointSaveBtn").addClass("hidden");
		$("#mainVanConfirmReqBtn").addClass("hidden");
		$("#batchRgstSaveBtn").addClass("hidden");
		$("#pointCancelBtn").addClass("hidden");
		$("#pointEditBtn").addClass("hidden");

		if($("#pointTrtStauts").val()!="75"){
			$("#vanApprovalBtn").attr("disabled",true);
		}
		if($("#pointTrtStauts").val()!="15"){
			$("#vanReApprovalBtn").attr("disabled",true);
			$("#vanReApprovalEndBtn").attr("disabled",true);
		}



	}
	if($("#pointTrtStauts").val()=="50"){
		$("#mainVanConfirmReqBtn").attr("disabled",true);
	}
	if($("#pointTrtStauts").val()!="40"){
		$("#mainVanConfirmReqBtn").attr("disabled",true);
	}

	if($("#pointTrtStauts").val()!="00"  && $("#pointTrtStauts").val()!="40" ){
		$($('#batchRgstDtlForm').find('input')).each(function(index, item){
 			$(item).attr("disabled",true);
		});

	$($('#batchRgstDtlForm').find('select')).each(function(index, item){
			$(item).attr("disabled",true);
		});

	$($('#batchRgstDtlForm').find('textarea')).each(function(index, item){
			$(item).attr("disabled",true);
		});

	$("#channelSearchBtn").addClass("hidden");
	$("#approverSearchBtn").addClass("hidden");
	$("#actcSearchBtn").addClass("hidden");
	}

	if($("#pointTrtStauts").val()!="00" && $("#pointTrtStauts").val()!="40"){
		$("#batchRgstSaveBtn").attr("disabled",true);
	}
}

function channelSearchHelpBlur(){
	if($("#chnlNm").val()==""){
		$("#ridChnl").val("");
		$("#chnlNo").val("");

	}else{
		channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNo=' +encodeURI(encodeURIComponent($('#chnlNo').val())));
	}
}

function channelSearchHelpEnter(){
	if($("#chnlNm").val()==""){
		$("#ridChnl").val("");
		$("#chnlNo").val("");

	}else{
		channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>'+'?ouTypeCd=A&&chnlNo=' +encodeURI(encodeURIComponent($('#chnlNo').val())));
	}
}

function channelSearchFn(){
	channelSearchHelpPopOpen('<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A');
}

function channelSearchHelpPopOpen(url){
	channelSearchHelpPop ={
	        id : "channelSearchPopDiv"
	    };
channelSearchHelpPop.popup = function (){
	channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L00987'/>",
	            width: "700px"
	        });
	};
	channelSearchHelpPop.beforeClose = function (obj) {
	};
	channelSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
	        	$("#chnlNm").val(obj.chnlNm);
	        	$("#chnlNo").val(obj.chnlNo);
	        	$("#ridChnl").val(obj.rid);
	        	prodTempObj.chnlNm = obj.chnlNm;
	        }else{
	        	$("#chnlNm").val(prodTempObj.chnlNm);
	        }
	        this.beforeClose(obj);
	        channelSearchPopDiv._destroy();
	 };
	channelSearchHelpPop.popup();
}


function vanReApprovalFn(){
	var vanApprovalObj = $("#batchRgstDtlForm").getSubmitData();
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="batchRgstReVanApproval"/>', vanApprovalObj
				, function(result) {
				alert(result.message);
		},function(result){
			alert(result.message);
		});
}



function inspectorSearchFn() {

	inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
			+ '?authNm=' + 'E10007')


}

function inspectorSearchHelpEnter() {
	if ($('#actcNm').val() == "") {
		$('#ridActcSbst').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10007&&name='
				+ encodeURI(encodeURIComponent($('#actcNm').val())));
	}
}

function inspectorSearchHelpBlur() {
	if ($('#actcNm').val() == "") {
		$('#ridActcSbst').val("");
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
			if (obj.authNm == 'E10007') {
				$("#actcNm").val(obj.name);
				$("#ridActcSbst").val(obj.rid);
				tempObj.actcNm = obj.name;
			}
		} else {
			$("#actcNm").val(tempObj.actcNm);
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
	if ($('#apvNm').val() == "") {
		$('#ridApv').val("");
	} else {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=E10008&&name='
				+ encodeURI(encodeURIComponent($('#apvNm').val())));
	}
}

function approverSearchHelpBlur() {
	if ($('#apvNm').val() == "") {
		$('#ridApv').val("");
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
			if (obj.authNm == 'E10008') {
				$("#apvNm").val(obj.name);
				$("#ridApv").val(obj.rid);
				tempObj.apvNm = obj.name;
			}
		} else {
			$("#dtiRidApv").val(tempObj.apvNm)
		}
		this.beforeClose(obj);
		empSearchPopDiv._destroy();
	};
	empSearchHelpPop.popup();
}

function commCodeSetting() {
	$.ifvGetCommCodeList('select', 'acuRdn', '<ifvm:action name="getCommCodeList2"/>', 'TXN_REASON_ALL_TYPE', 'loy', true, true);
	$.ifvGetCommCodeList('select', 'pointTrtStauts', '<ifvm:action name="getCommCodeList2"/>', 'TXN_STATUS_UPLOAD', 'loy', true, true);
}
//1000단위 정규식
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatterSetting() {
	var numFormatVal = $("#fileUpldSucesCnt").val();
	$("#fileUpldSucesCnt").ifvNumberOnly();
	$("#fileUpldSucesCnt").val(numberWithCommas(numFormatVal));
	numFormatVal = $("#fileUpldFailCnt").val();
	$("#fileUpldFailCnt").ifvNumberOnly();
	$("#fileUpldFailCnt").val(numberWithCommas(numFormatVal));

	numFormatVal = $("#pointSucesCnt").val();
	$("#pointSucesCnt").ifvNumberOnly();
	$("#pointSucesCnt").val(numberWithCommas(numFormatVal));

	numFormatVal = $("#pointFailCnt").val();
	$("#pointFailCnt").ifvNumberOnly();
	$("#pointFailCnt").val(numberWithCommas(numFormatVal));
}

function dateFormatSetting(){
	var dateFormatVal=$("#fileUpldDt").val().split(".")[0];
	$("#fileUpldDt").val(dateFormatVal);

	dateFormatVal = $("#pointTrtDt").val().split(".")[0]
	$("#pointTrtDt").val(dateFormatVal);

	dateFormatVal = $("#apvTrtDt").val().split(".")[0]
	$("#apvTrtDt").val(dateFormatVal);

	dateFormatVal = $("#actcTrtDt").val().split(".")[0]
	$("#actcTrtDt").val(dateFormatVal);
}
function batchRgstListFn() {
	var url = '<ifvm:url name="batchRgstList"/>';
	qtjs.href(url);
}

function batchRgstSaveFn(){
	var obj={};
	obj = $("#batchRgstDtlForm").getSubmitData();
	obj.rid = testViewList_rid;
	$.ifvSyncPostJSON('<ifvm:action name="updateBatchRgstDetail"/>',obj,
	function(result) {
		alert('<spring:message code="L00127" />');
		batchRgstDetailSetting();
	//	batchRgstDetailSetting();
	//	numberFormatterSetting();
	//	dateFormatSetting();
	});
}


/***************************************************************************
이  름 : Main_VAN_Confirm_Req
기  능 : 포인트 일괄등록 검수 요청
작성자 : kklliop@Quintet
작성일   :   2009/10/23
수정이력 :   2017/11/27
수정자   :   김준기
기타사항 :
*****************************************************************************/
function mainVanConfirmReq(){
	var vanConfirmObj = {};
	vanConfirmObj = $("#batchRgstDtlForm").getSubmitData();
	if(vanConfirmValid(vanConfirmObj)){
		vanConfirmObj.rid = testViewList_rid;
		$.ifvSyncPostJSON('<ifvm:action name="updateVanPntStatus"/>', vanConfirmObj
				, function(result) {
				alert(result.message);
				qtjs.href('<ifvm:url name="batchRgstDetail"/>?rid=' + testViewList_rid);
		},function(result){
			alert(result.message);
		})
	}
}

function vanConfirmValid(obj){
	var vanValid = true;
	if(obj.acuRdn==""|| obj.acuRdn==null){
		$.ifvCallValidationBox($("#acuRdn"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}

	if(obj.actcNm==""){

		$.ifvCallValidationBox($("#actcNm"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}

	if(obj.apvNm==""){
		$.ifvCallValidationBox($("#apvNm"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}

	if(obj.actcNm == ifvmUserInfo.id){
		alert("<spring:message code='L01867'/>");
		vanValid =  false
		return vanValid;
	}
	if(obj.apvNm == ifvmUserInfo.id){
		alert("<spring:message code='L01868'/>");
		vanValid =  false
		return vanValid;
	}
	if(obj.apvNm ==  actcNm){
		alert("<spring:message code='L01869'/>");
		vanValid = false;
		return vanValid;
	}

	if(obj.pointTrtStauts!="40"){
		alert("<spring:message code='L01870'/>");
		vanValid = false;
		return vanValid;
	}

	if(obj.chnlNo ==""){
		$.ifvCallValidationBox($("#chnlNo"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}

	// sPointTransFlg 처리 후 만들기 if()
	if(Call_LookUpValue() =="Y"   && obj.chnlNo!="10000"){
		alert("<spring:message code='L01871'/>");
	}

	if(obj.acuRdn==""){
		$.ifvCallValidationBox($("#acuRdn"),"<spring:message code='C00024'/>");
		vanValid =  false;
		return vanValid;
	}
	return vanValid;
}

/***************************************************************************
이  름 : Call_LookUpValue
기  능 : 주식회사E1 가맹점 제약 여부
작성자 : kklliop@quintet.co.kr
작성일 : 2009/07/07
수정이력 :
기타사항 :

*****************************************************************************/
function Call_LookUpValue(){
	var codeName;
	$.ifvSyncPostJSON('<ifvm:action name="callLookUpValue"/>', {
		rid : testViewList_rid
	}, function(result) {
		codeName = result.codeName
	});
	return codeName;
}


function vanApprovalFn(){
	var vanApprovalObj = $("#batchRgstDtlForm").getSubmitData();
	if(vanApprovalValid(vanApprovalObj)){
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="batchRgstVanApproval"/>', vanApprovalObj
				, function(result) {
				alert(result.message);
				qtjs.href('<ifvm:url name="batchRgstDetail"/>?rid=' + testViewList_rid);
		},function(result){
			alert(result.message);
		});
	}
}

function vanApprovalValid(obj){
	var sCurStatus = obj.pointTrtStauts
	var valid = true;
	if (sCurStatus == "00" || sCurStatus == "30"){
		alert("<spring:message code='L01873'/>");
		valid = false;
		return valid;
	}

	if(obj.chnlNo ==""){
		$.ifvCallValidationBox($("#chnlNo"),"<spring:message code='C00024'/>");
		valid =  false;
		return valid;
	}

	if(Call_LookUpValue() =="Y"   && obj.chnlNo!="10000"){
		alert("<spring:message code='L01871'/>");
		valid = false;
		return valid;
	}

	if(obj.acuRdn ==""){
		$.ifvCallValidationBox($("#acuRdn"),"<spring:message code='C00024'/>");
		valid =  false;
		return valid;
	}
	return valid;
}


function vanReApprovalEndFn(){
	var vanApprovalObj = $("#batchRgstDtlForm").getSubmitData();
	if(vanApprovalValid(vanApprovalObj)){
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="batchRgstVanCancel"/>', vanApprovalObj
				, function(result) {
				alert("<spring:message code='L01872'/>");

				batchRgstDetailSetting();

		},function(result){
			alert(result.message);
		});
	}
}




var upldItemList;
var ridPar;
var uploadRslt="";
var testViewList_rid = '<%= cleanXss(request.getParameter("rid"))%>';
function upldItemSearch(){
    var jqGridOption = {
        onSelectRow : function (data) {


        },
       serializeGridData : function( data ){
    	   data.parRid = testViewList_rid
        	   data.uploadRslt = uploadRslt
           return data;
        },
        loadComplete : function(obj){
        	if(obj.rows.length>0){
            	ridPar = obj.rows[0].ridPar
        	}
        	uploadRslt="";
        },
        url : '<ifvm:action name="getUpldItemList"/>',
        colNames:[
                   '<spring:message code="L01646" />',  /*성공/실패 */
                   '<spring:message code="L01647" />',  /*거래유형 */
                   '<spring:message code="L01648" />',  /*회원아이디*/
                   '<spring:message code="L01649" />',  /*회원번호 */
                   '<spring:message code="L01650" />',  /*요청포인트 */
                   '<spring:message code="L01651" />',  /*E1회원번호*/
                   '<spring:message code="L01652" />',  /*회원명*/
                   '<spring:message code="L01653" />',  /*회원상태*/
                   '<spring:message code="L01654" />',  /*가맹점코드*/
                   '<spring:message code="L01655" />',  /*가맹점명*/
                   '<spring:message code="L01656" />',  /*처리상태*/
                   '<spring:message code="L01657" />',  /*요청일시*/
                   '<spring:message code="L01658" />',  /*요청자*/
                   '<spring:message code="L01659" />',  /*승인요청기관*/
                   '<spring:message code="L01660" />',  /*거래일시*/
                   '<spring:message code="L01661" />',  /*거래추적번호*/
                   '<spring:message code="L01662" />',  /*VAN 승인일자*/
                   '<spring:message code="L01663" />',  /*승인번호*/
                   '<spring:message code="L01664" />',  /*승인응답*/
                   '<spring:message code="L01665" />',  /*처리실패 메시지*/
                   'rid',
                   'ridPar',
                 ],
        colModel:[
             { name:'uploadRslt',   index:'lui.UPLOAD_RSLT',  resizable : true, align:'center',    width:'80px'},
             { name:'typeCd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',  width:'70px' },
             { name:'webLogin',   index:'lui.WEB_LOGIN',  resizable : true, align:'center',     width:'140px' },
             { name:'mbrNo',   index:'lui.MBR_NO',  resizable : true, align:'center',  width:'80px' },
             { name:'reqPoint',   index:'lui.REQ_POINT',  resizable : true, align:'right',    width:'80px',formatter :'integer' },
             { name:'e1MbrNo',   index:'lm.MBR_NO',  resizable : true, align:'center',    width:'90px' },
             { name:'mbrHidNm',   index:'lm.MBR_HID_NM',  resizable : true, align:'center',    width:'80px' },
             { name:'memStatus',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
             { name:'acntId',   index:'lc.ACCNT_ID',  resizable : true, align:'center',    width:'100px' },
             { name:'statusCd',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'requestDt',   index:'lui.REQUEST_DT',  resizable : true, align:'center',    width:'140px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'requestId',   index:'lui.REQUEST_ID',  resizable : true, align:'center',    width:'80px' },
             { name:'terminalCd',   index:'cc4.MARK_NAME',  resizable : true, align:'center',   width:'100px'  },
             { name:'txnDt',   index:'lui.TXN_DT',  resizable : true, align:'center',    width:'130px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}  },
             { name:'txnNum',   index:'lui.TXN_NUM',  resizable : true, align:'right',    width:'100px' },
             { name:'approvalDt',   index:'lui.APPROVAL_DT',  resizable : true, align:'center',    width:'130px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}  },
             { name:'approvalNum',   index:'lui.APPROVAL_NUM',  resizable : true, align:'center',    width:'80px' },
             { name:'returnCd',   index:'cc5.MARK_NAME',  resizable : true, align:'center',    width:'80px' },
             { name:'returnText',   index:'lui.RETURN_TEXT',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'lui.RID',    hidden : true},
             { name:'ridPar',    index:'lui.RID_PAR',    hidden : true},
        ],
        sortname: 'lui.UPLOAD_RSLT',
		sortorder: "desc",
    };
    upldItemList = $("#upldItemListGrid").ifvGrid({ jqGridOption : jqGridOption });
}



function pointStandardDtlFn(){
 	var url = "<ifvm:url name='standardPointDetail'/>";
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	qtjs.href(url);
}

function pointStandardNewFn(){
	qtjs.href("<ifvm:url name='standardPointDetail'/>");
}

function tabContent(){
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="pointSaveListInfo"/>'},
		]
	});
}

function allSearchFn(){
	uploadRslt =""
	upldItemSearch();
}
function sucesSearchFn(){
	uploadRslt ="S"
	upldItemSearch();
}

function failSearchFn(){
	uploadRslt ="F"
	upldItemSearch();
}





$(document).ready(function() {
	$.ifvmLnbSetting('batchRgstList');
	commCodeSetting();
	batchRgstDetailSetting();
	allSearchFn();

})
</script>



<div id="batchRgstDtlForm">
	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00685" /></span>
			</div>
		</div>

		<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="fileNm"   dto="fileNm"   label="L01699" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="filePath"  dto="filePath"   label="L01700" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="select" id="acuRdn"  dto="acuRdn"   label="L01701" labelClass="1" conClass="2"   />
		    <ifvm:inputNew type="select" id="pointTrtStauts"  dto="pointTrtStauts"   label="L01702" labelClass="1" conClass="2"  disabled="true" />
	 	</div>

	 	<div class="row  qt_border">
	 		<ifvm:inputNew type="search" id="chnlNo|channelSearchBtn" names="chnlNo" hidId="ridChnl" hidDto="ridChnl" dto="chnlNo" disabled="false" btnFunc="channelSearchFn"
			searchBlurEvent="channelSearchHelpBlur" searchEnterEvent="channelSearchHelpEnter" label="L01703" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="chnlNm"  dto="chnlNm"   label="L01704" labelClass="1" conClass="2" disabled="true" />
		</div>

		<div class="row  qt_border">
	 		<ifvm:inputNew type="search" id="actcNm|actcSearchBtn" names="actcNm" hidId="ridActcSbst" hidDto="ridActcSbst" dto="actcNm" disabled="false" btnFunc="inspectorSearchFn"
			searchBlurEvent="inspectorSearchHelpBlur" searchEnterEvent="inspectorSearchHelpEnter" label="L01705" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="actcTrtDt"  dto="actcTrtDt"   label="L01706" labelClass="1" conClass="2" disabled="true" />
			<ifvm:inputNew type="search" id="apvNm|approverSearchBtn" names="apvNm" hidId="ridApv" hidDto="ridApv" dto="apvNm" disabled="false" btnFunc="approverSearchFn"
			searchBlurEvent="approverSearchHelpBlur" searchEnterEvent="approverSearchHelpEnter" label="L01707" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="apvTrtDt"  dto="apvTrtDt"   label="L01708" labelClass="1" conClass="2" disabled="true" />
		</div>


		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="actcSbst" maxLength="50" dto="actcSbst" label="L01709" labelClass="1" conClass="5" disabled="true"  />
			<ifvm:inputNew type="textarea" id="apvSbst" maxLength="50" dto="apvSbst" label="L01710" labelClass="1" conClass="5"  disabled="true" />
		</div>

		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="rmark" maxLength="50" dto="rmark" label="L01711" labelClass="1" conClass="5"  />
		</div>
		<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="fileUpldDt"   dto="fileUpldDt"   label="L01712" labelClass="1" conClass="2"  disabled="true"/>
		    <ifvm:inputNew type="text" id="upldEmpNm"  dto="upldEmpNm"   label="L01713" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="fileUpldSucesCnt"  dto="fileUpldSucesCnt"   label="L01714" labelClass="1" conClass="2" disabled="true" />
		    <ifvm:inputNew type="text" id="fileUpldFailCnt"  dto="fileUpldFailCnt"   label="L01715" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="hidden" id="ridUpldEmp"  dto="ridUpldEmp" />
		    <ifvm:inputNew type="hidden" id="offerType"  dto="offerType"/>

	 	<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="pointTrtDt"   dto="pointTrtDt"   label="L01716" labelClass="1" conClass="2"  disabled="true"/>
		    <ifvm:inputNew type="text" id="pointEmpNm"  dto="pointEmpNm"   label="L01717" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="pointSucesCnt"  dto="pointSucesCnt"   label="L01718" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="pointFailCnt"  dto="pointFailCnt"   label="L01719" labelClass="1" conClass="2"  disabled="true" />
	 	</div>
	</div>
</div>



	<div class="page_btn_area">
			<div class="col-xs-4">
				<span> <spring:message code="L01645" /></span>
			</div>
			 <div class="col-xs-8 searchbtn_r">
				<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn" btnFunc="allSearchFn"/>
				<ifvm:inputNew type="button"   btnType="search" text="L01667"  id="sucesSearchBtn" btnFunc="sucesSearchFn"/>
				<ifvm:inputNew type="button"   btnType="search" text="L01668"  id="failSearchBtn" btnFunc="failSearchFn"/>
		     </div>


	</div>
</div>
  <div class="col-xs-12">
  	<div id="upldItemListGrid" class="white_bg grid_bd0"></div>
  </div>





<div id="channelSearchPopDiv" class="popup_container"></div>
<div id="mbrSearchPopDiv" class="popup_container"></div>
<div id="empSearchPopDiv" class="popup_container"></div>