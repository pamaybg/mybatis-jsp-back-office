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

var testViewList_rid = '<%=cleanXss(request.getParameter("rid"))%>';
var prodTempObj={};
var tempObj= {};
function unRgstCardUploadDetailSetting(){
	if(testViewList_rid!=null){
		$.ifvSyncPostJSON('<ifvm:action name="getUnRgstCardUploadDetail"/>', {
			rid : testViewList_rid
		}, function(result) {

			$("#unRgstCardUploadDtlForm").dataSetting(result);
			//내가 요청한 건만 결재 요청 취소 가능
			 if(result.ridUpldEmp != $.ifvmGetUserInfo().empId){
				 $("#cancelInsBtn").prop('disabled',true);
			 }
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
	approverSearchBtn
	if($("#preSaveTrtStatus").val()!="65"){
		$("#cancelInsBtn").attr("disabled",true);
	}
	if($("#preSaveTrtStatus").val()=="65"){
		$("#mainVanConfirmReqBtn").attr("disabled",true);
	}
	if($("#preSaveTrtStatus").val()!="40"){
		$("#approverSearchBtn").addClass("hidden");
		$("#mainVanConfirmReqBtn").attr("disabled",true);
	}else{
		$("#approverSearchBtn").removeClass("hidden");
	}

	if($("#preSaveTrtStatus").val()!="00" && $("#preSaveTrtStatus").val()!="40"){
		$("#unRgstCardUploadSaveBtn").attr("disabled",true);
	}
	if($("#preSaveTrtStatus").val()!="50"){
		$("#cancelInsBtn").attr("disabled",true);
	}
	if($("#preSaveTrtStatus").val()=="70"){
		$("#mainVanConfirmReqBtn").attr("disabled",false);
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

/*
function vanReApprovalFn(){
	var vanApprovalObj = $("#unRgstCardUploadDtlForm").getSubmitData();
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="preCardApprRequest"/>', vanApprovalObj
				, function(result) {
				alert(result.message);
		},function(result){
			alert(result.message);
		});
} */



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
	$.ifvGetCommCodeList('select', 'preSaveTrtStatus', '<ifvm:action name="getCommCodeList2"/>', 'TXN_STATUS_UPLOAD', 'loy', true, true);
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

}

function dateFormatSetting(){
	var dateFormatVal=$("#fileUpldDt").val().split(".")[0];
	$("#fileUpldDt").val(dateFormatVal);


	dateFormatVal = $("#apvTrtDt").val().split(".")[0]
	$("#apvTrtDt").val(dateFormatVal);

	dateFormatVal = $("#apvRqtDt").val().split(".")[0]
	$("#apvRqtDt").val(dateFormatVal);


}
function unRgstCardUploadListFn() {
	var url = '<ifvm:url name="unRgstCardUploadList"/>';
	qtjs.href(url);
}

function unRgstCardUploadSaveFn(){
	var obj={};
	obj = $("#unRgstCardUploadDtlForm").getSubmitData();
	obj.rid = testViewList_rid;
	$.ifvSyncPostJSON('<ifvm:action name="updateUnRcstCardUploadtDetail"/>',obj,
	function(result) {
		alert('<spring:message code="L00127" />');
		unRgstCardUploadDetailSetting();
	//	dateFormatSetting();
	});
}



function mainVanConfirmReq(){
	var vanConfirmObj = {};
	vanConfirmObj = $("#unRgstCardUploadDtlForm").getSubmitData();
	if(vanConfirmValid(vanConfirmObj)){
		vanConfirmObj.rid = testViewList_rid;
		$.ifvSyncPostJSON('<ifvm:action name="preCardApprRequest"/>', vanConfirmObj
				, function(result) {
					if(result.success){
						alert("<spring:message code='L02031'/>");
					}
				unRgstCardUploadDetailSetting();
		},function(result){
			alert(result.message);
		})
	}
}

function vanConfirmValid(obj){
	var vanValid = true;
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
	if(obj.ridApv == ifvmUserInfo.id){
		alert("<spring:message code='L01868'/>");
		vanValid =  false
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
	var vanApprovalObj = $("#unRgstCardUploadDtlForm").getSubmitData();
	if(vanApprovalValid(vanApprovalObj)){
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="unRgstCardUploadVanApproval"/>', vanApprovalObj
				, function(result) {
				alert(result.message);
				qtjs.href('<ifvm:url name="unRgstCardUploadDetail"/>?rid=' + testViewList_rid);
		},function(result){
			alert(result.message);
		});
	}
}

function vanApprovalValid(obj){
	var sCurStatus = obj.preSaveTrtStatus
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
	var vanApprovalObj = $("#unRgstCardUploadDtlForm").getSubmitData();
	if(vanApprovalValid(vanApprovalObj)){
		vanApprovalObj.rid = testViewList_rid
		$.ifvSyncPostJSON('<ifvm:action name="unRgstCardUploadVanCancel"/>', vanApprovalObj
				, function(result) {
				alert("<spring:message code='L01872'/>");
				unRgstCardUploadDetailSetting();

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
        url : '<ifvm:action name="getUnRgstCardUploadItem"/>',
        colNames:[
                  '<spring:message code="L01646" />',  /*성공/실패 */
                  '<spring:message code="L00414" />',  /*카드번호*/
                  '<spring:message code="L01899" />',  /*제품코드*/
                  '<spring:message code="L02092" />',  /*유효기간*/
                  '<spring:message code="L00700" />',  /*선 지급금액*/
                  '<spring:message code="L02093" />',  /*E1 카드번호*/
                  '<spring:message code="L02094" />',  /*E1 제품명*/
                  '<spring:message code="L01630" />',  /*처리상태*/
                  '<spring:message code="L02066" />',  /*업로드 실패 메세지*/

                  'rid',
                  'ridPar',
                ],
       colModel:[
            { name:'uploadRslt',   index:'luri.UPLOAD_RSLT',  	resizable : true, align:'center',  width:'60px'},
            { name:'cardNum',   	index:'luri.CARD_NUM',  	resizable : true, align:'center',  width:'90px' },
            { name:'prodId',   	index:'luri.PROD_ID',  	resizable : true, align:'center',   width:'80px'},
            { name:'expireDt',   	index:'luri.EXPIRE_DT',  		resizable : true, align:'center',  width:'90px', formatter:'date', formatoptions:{newformat:"Y-m-d"}  },
            { name:'preSavePoint',   		index:'luri.PRE_SAVE_POINT',  		resizable : true, align:'right',  width:'80px' ,formatter :'integer'},
            { name:'e1CardNum',   	index:'lcri.CARD_NUM',  		resizable : true, align:'center',  width:'90px' },
            { name:'prodNm',   	index:'lp.PROD_NM',  		resizable : true, align:'center',  width:'90px' },
            { name:'statusCd',   	index:'luri.STATUS_CD',  		resizable : true, align:'left',  width:'60px' },
            { name:'errMsg',   	index:'luri.ERR_MSG',  		resizable : true, align:'left',  width:'100px' },

            { name:'rid',    		index:'lui.RID',    	hidden : true},
            { name:'ridPar',    	index:'lui.RID_PAR',    hidden : true},
       ],
        sortname: 'luri.UPLOAD_RSLT',
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
	$.ifvmLnbSetting('unRgstCardUploadList');
	commCodeSetting();
	unRgstCardUploadDetailSetting();
	allSearchFn();

})
</script>



<div id="unRgstCardUploadDtlForm">
	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00685" /></span>
			</div>
		</div>

		<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="fileNm"   dto="fileNm"   label="L01699" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="filePath"  dto="filePath"   label="L01700" labelClass="1" conClass="2"  disabled="true" />
		    <%-- <ifvm:inputNew type="select" id="acuRdn"  dto="acuRdn"   label="L01701" labelClass="1" conClass="2"   /> --%>
	 	</div>


	 	<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="fileUpldDt"   dto="fileUpldDt"   label="L01712" labelClass="1" conClass="2"  disabled="true"/>
		    <ifvm:inputNew type="text" id="custNm"  dto="custNm"   label="L01713" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="text" id="fileUpldSucesCnt"  dto="fileUpldSucesCnt"   label="L01714" labelClass="1" conClass="2" disabled="true" />
		    <ifvm:inputNew type="text" id="fileUpldFailCnt"  dto="fileUpldFailCnt"   label="L01715" labelClass="1" conClass="2"  disabled="true" />
		    <ifvm:inputNew type="hidden" id="ridUpldEmp"  dto="ridUpldEmp" />
		    <ifvm:inputNew type="hidden" id="offerType"  dto="offerType"/>
		</div>


</div>

<div class="form-horizontal underline top_well" >
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="L02047"/></span>
			</div>
		</div>
	  	<div class="row">

			<ifvm:inputNew type="text" 	maxLength="50"	label="L02048"	id="rqtName" 	dto="rqtName"   	labelClass="1" conClass="2"  disabled="true"/>
			<ifvm:inputNew type="text" 	maxLength="50"	label="L02049"	id="apvRqtDt" 	dto="apvRqtDt" 	labelClass="1" conClass="2" disabled="true" />
			<ifvm:inputNew type="search" id="apvNm|approverSearchBtn"
						names="apvNm" hidId="ridApv" hidDto="ridApv" dto="apvNm"
						disabled="false" btnFunc="approverSearchFn"
						searchBlurEvent="approverSearchHelpBlur"
						searchEnterEvent="approverSearchHelpEnter" label="L00678"
						labelClass="1" conClass="2" required="true" />
	 	  	<ifvm:inputNew type="text" 	maxLength="50"	label="L02051"	id="apvTrtDt" 		dto="apvTrtDt"   	labelClass="1" conClass="2" disabled="true" />
	 	</div>
		<ifvm:inputNew type="hidden" 	maxLength="50"	id="ridRqt" 	dto="ridRqt"   conClass="2"  />


	 	<div class="row">
	    	<ifvm:inputNew type="select"  	maxLength="50"	label="L02052"		id="preSaveTrtStatus" 	  	dto="preSaveTrtStatus"    	labelClass="1" conClass="2" disabled="true" />
	 	  	<ifvm:inputNew type="text" 		maxLength="50"	label="L02053"		id="apvRjtRsn" 	dto="apvRjtRsn"   labelClass="1" conClass="8" disabled="true" />
	 	</div>
	</div>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L01645" /></span>
	</div>
	 <div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button"   btnType="search"  text="L01666"  id="allSearchBtn" btnFunc="allSearchFn"/>
		<ifvm:inputNew type="button"   btnType="search" text="L01667"  id="sucesSearchBtn" btnFunc="sucesSearchFn"/>
		<ifvm:inputNew type="button"   btnType="search" text="L01668"  id="failSearchBtn" btnFunc="failSearchFn"/>
     </div>
</div>
<div id="upldItemListGrid" class="white_bg grid_bd0"></div>

<div id="channelSearchPopDiv" class="popup_container"></div>
<div id="mbrSearchPopDiv" class="popup_container"></div>
<div id="empSearchPopDiv" class="popup_container"></div>