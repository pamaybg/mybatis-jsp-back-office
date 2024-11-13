<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var callGrid;
var callFlag = false;


function callList(){
	var jqGridOption = {
		ondblClickRow : function(data){
		},
	    onSelectRow : function (data) {
	    	rowData = [];
	    	rowData = data;
		},
		serializeGridData : function( data ){
			if(window.rowData2.callId != null){
				data.callId = rowData2.callId;
			}else{
				data.callFlag = '1';
			}

			if(callFlag){
				data.callFlag = '1';
			}

// 			if ($.fn.ifvmIsNotEmpty(requestitem)) {
//                 data.item = requestitem;
//             }
            return data;
		},
		loadComplete : function(data){
			parent.setParentIframeHeight();
		},
		url: '<ifvm:action name="getCallList"/>',
	    colNames:[
	              '<spring:message code="L00132"/>', /* 채널유형 */
// 	              '<spring:message code="V00076"/>', /* 서비스유형 */
	              '<spring:message code="V00029"/>', /* 통화ID */
	              '<spring:message code="V00077"/>', /* 통화시간 */
// 	              '<spring:message code="L00320"/>', /* 고객명 */
// 	              '<spring:message code="L00400"/>', /* 전화번호 */
	              '<spring:message code="V00079"/>', /* 상담원명 */
	              '<spring:message code="V00078"/>', /* 통화일시 */
	              'rid'
	              ],
	    colModel:[
	              {name:'chnlType',  			index:'b.mark_name', 			resizable : false, 		align:'center',    	width:'100px'},
// 	              {name:'svcType', 				index:'c.mark_name', 			resizable : false, 		align:'left',    	width:'100px'},
	              {name:'callId', 				index:'a.CALL_ID', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'cserCurTime', 			index:'a.CSER_CUR_TIME', 		resizable : false, 		align:'center',    	width:'100px'},
// 	              {name:'custNm',     			index:'d.cust_nm', 				resizable : false, 		align:'left',    	width:'100px'},
// 	              {name:'telNo', 				index:'a.TEL_NO', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'csName', 				index:'f.name', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'rcpDt',/*createDate*/ 	index:'a.CREATE_DATE', 			resizable : false, 		align:'center',    	width:'100px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'rid', 					index:'a.rid', 					resizable : false, 		hidden : true}
			      ],
		radio:true,
		sortname: 'a.CREATE_DATE',
		sortorder: "desc",
// 		tempId : 'ifvGridExcelTemplete'
	};
	callGrid = $("#callListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function init(){
// 	callList();
// 	$.ifvGetCommCodeList('select', 'errCd', '<ifvm:action name="getCommCodeList"/>', 'CCA_ERR_CODE', 'loy', false, true, true);
	$.fn.ifvmSetSelectOptionCommCode("errCd", "CCA_ERR_CODE", null, null, false);

	$("#unmaskBtn, #unmaskBtn2, #callTransmitNo, #msgTransmitNo, #callContactableNo, #msgContactableNo, #callHomePhoneNo, #msgHomePhoneNo, #callMobilePhoneNo, #msgMobilePhoneNo").attr("disabled",true);
}

//녹취청취 버튼
function clickRecordBtn(){
	if((voiceMailBoxGrid.getCheckedGridData()[0] != undefined)
			&& (callGrid.getCheckedGridData()[0] != undefined)){
		$("#playRecordFilePop").ifvsfPopup({
		   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="playRecordFilePop"/>?callId='+rowData.callId+'&callDate='+rowData.rcpDt,
		   contentType: "ajax",
		   title: "<spring:message code='V00158'/>",
		   width: 600,
		   close : 'playRecordFilePopClose'
		});
	}else{
		alert('<spring:message code="V00198"/>');
	}
}

//가원장 추가정보 상세 조회
function getCustAddInfoDetail(data){
	$.ifvSyncPostJSON('<ifvm:action name="getCustAddInfoDetailForVoc"/>',{
		rid : data.rid
	},function(result) {
		if(result != null){
			$("#mbrName").val(result.memName);
			$("#mypinNo").val(result.userMypin);
			if(result.errYn == "Y"){
				$("#errYn").prop("checked",true);
			}else{
				$("#errYn").prop("checked",false);
			}
			$("#cardNo").val(result.cardNo);
			$("#gender").val(result.gender);
			$("#errCd").val(result.errCd);
			$("#transmitNo").val(result.telNo);
			$("#errDt").val(result.errDt);
			$("#contactableNo").val(result.cntcPosblNo);
			$("#errContent").val(result.errSbst);
			$("#cardChkYn").val(result.cardChkYn);

			$("#saveBtn").attr("disabled",false);

			if(result.regYn == "Y"){
				//카드등록을 한 경우
				$("#mbrName, #cardNo, #transmitNo, #errYn, #validateCardChkBtn, #regAddCardBtn, #regNewMemCardBtn, #saveBtn").attr("disabled",true);
			}else if(result.errYn == "Y"){
				//오류여부가 Y인 경우
				$("#errCd, #errContent").attr("disabled",null);
				$("#validateCardChkBtn, #regAddCardBtn, #regNewMemCardBtn").attr("disabled",true);
			}
		}else{
			clearCustAddInfo();
		}
	});
}

//실 고객 정보 상세 조회
function getRealCustDetail(data){
	$.ifvSyncPostJSON('<ifvm:action name="getRealCustDetail"/>',{
		rid : data.ridCust
	},function(result) {
		if(result != null){
			$("#memNo").val(result.mbrNo);
			$("#memName").val(result.custNm);
			$("#memSep").val(result.memDiv);
			$("#homePhoneNo").val(result.homeTelNo);
			$("#memGrade").val(result.tierNm);
			$("#mobilePhoneNo").val(result.hhpNo);
			$("#memStatus").val(result.mbrStatusNm);
			$("#webMemId").val(result.wbMemId);
			$("#joinChl").val(result.sbscChnlNm);
			if(result.e1MemYn == "Y"){
				$("#e1BonusMemYn").prop("checked",true);
			}else{
				$("#e1BonusMemYn").prop("checked",false);
			}
			if(result.wbMemYn == "Y"){
				$("#webMemYn").prop("checked",true);
			}else{
				$("#webMemYn").prop("checked",false);
			}
			ridMbr = result.ridMbr;
		}else{
			clearRealCustInfo();
		}
	});
}


//카드유효성체크 버튼
function clickValidateCardChkBtn(){
	var cardNo = null;

	if(voiceMailBoxGrid.getCheckedGridData()[0] != undefined){
		//음성사서함 관리 목록 row 선택
		if($("#cardNo").val() != ""){
	   		//카드유효성체크
	       	$.ifvSyncPostJSON('<ifvm:action name="checkCardValid"/>',{
	       		cardNo : $("#cardNo").val()
	       		, rid : rowData2.rid
	       		, cardChkYn : '1'
	       	},function(result) {
	       		//result.success == true;
	       		if(result.success == true){
	       			afterValidateCardChkModifyCallContactOccuringError();
	       			alert('<spring:message code="V00193"/>');
	       			getCustAddInfoDetail(rowData2);
	       		}
	       	},function(result) {
	       		//result.success == false;
       			alert(result.message);
	       	});
		}else{
			alert('<spring:message code="V00194"/>');
		}
	}else{
		//음성사서함 관리 목록 row 미선택
		alert('<spring:message code="V00195"/>');
	}
}

//카드유효성체크 이후, 내용 저장
function afterValidateCardChkModifyCallContactOccuringError(){
	var errYn = null;
	if($("#errYn").prop("checked") == true){
		errYn = "Y";
	}else{
		errYn = "N";
	}

	$.ifvSyncPostJSON('<ifvm:action name="modifyCallContactOccuringError"/>',{
   		mbrNm : $("#mbrName").val()
   		, cardNo : $("#cardNo").val()
   		, telNo : $("#transmitNo").val()
   		, rid : rowData2.rid
   		, errYn : errYn
   		, errCd : $("#errCd").val()
   		, errSbst : $("#errContent").val()
   	},function(result2) {
   		//result.success == true;
   		if(result2.success == true){
   			
   		}
   	},function(result2) {
   		//result.success == false;
   			alert(result2.message);
   	});
}

//카드추가등록 버튼
function clickRegAddCardBtn(){
	if(voiceMailBoxGrid.getCheckedGridData()[0] != undefined){
		//음성사서함 관리 목록 row 선택
		if($("#cardChkYn").val() == 'Y'){
			//카드유효성체크를 한 경우
			//카드추가등록
			var tCallBackNo = getCallBackNo();
			
			$.ifvPostJSON('<ifvm:action name="registerAddCard"/>',{
	       		mbrNm : $("#mbrName").val()
	       		, mypin : $("#mypinNo").val()
	       		, gender : $("#gender").val()
	       		, cardNo : $("#cardNo").val()
	       		, ani : $("#transmitNo").val()
	       		, rid : rowData2.rid
	       		, cardPw : rowData2.cardPwd
	       		, callId : rowData2.callId
	       		, callBackNo : tCallBackNo
	       	},function(result) {
	       		//result.success == true;
	       		if(result.success == true){
	       			alert('<spring:message code="V00196"/>');
	       			getVoiceMailBoxListOnlyRegYnIsN();
	       			clearCustAddInfo();
	       			clearRealCustInfo();
	       			resetCallList();
	       		}
	       	},function(result) {
	       		//result.success == false;
	       		if(result.errorType == "170"){
	       			//채널전송 실패 시
	       			alert(result.message);
	       			getVoiceMailBoxListOnlyRegYnIsN();
	       			clearCustAddInfo();
	       			clearRealCustInfo();
	       			resetCallList();
	       		}else{
	       			alert(result.message);
	       		}
	       	});
		}else{
			//카드유효성체크를 하지 않은 경우
			alert('<spring:message code="V00197"/>');
		}
	}else{
		//음성사서함 관리 목록 row 미선택
		alert('<spring:message code="V00195"/>');
	}
}

//신규회원카드등록 버튼
function clickRegNewMemCardBtn(){
	if(voiceMailBoxGrid.getCheckedGridData()[0] != undefined){
		//음성사서함 관리 목록 row 선택
		if($("#cardChkYn").val() == 'Y'){
			var tCallBackNo = getCallBackNo();
			
			//카드유효성체크를 한 경우
			$.ifvPostJSON('<ifvm:action name="registerNewCard"/>',{
	       		mbrNm : $("#mbrName").val()
	       		, mypin : $("#mypinNo").val()
	       		, gender : $("#gender").val()
	       		, cardNo : $("#cardNo").val()
	       		, ani : $("#transmitNo").val()
	       		, rid : rowData2.rid
	       		, cardPw : rowData2.cardPwd
	       		, callId : rowData2.callId
	       		, callBackNo : tCallBackNo
	       	},function(result) {
	       		//result.success == true;
	       		if(result.success == true){
	       			alert('<spring:message code="V00196"/>');
	       			getVoiceMailBoxListOnlyRegYnIsN();
	       			clearCustAddInfo();
	       			clearRealCustInfo();
	       			resetCallList();
	       		}
	       	},function(result) {
	       		//result.success == false;
	       		if(result.errorType == "170"){
	       			//채널전송 실패 시
	       			alert(result.message);
	       			getVoiceMailBoxListOnlyRegYnIsN();
	       			clearCustAddInfo();
	       			clearRealCustInfo();
	       			resetCallList();
	       		}else{
	       			alert(result.message);
	       		}
	       	});
		}else{
			//카드유효성체크를 하지 않은 경우
			alert('<spring:message code="V00197"/>');
		}
	}else{
		//음성사서함 관리 목록 row 미선택
		alert('<spring:message code="V00195"/>');
	}
}

//실 고객 정보 마스크해제 버튼
function clickUnmaskBtn(){
	if($("#homePhoneNo").val() != ""){
		//집전화번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData2.ridCust,
	           type: 'mbr2' ,
	           field: 'tel'
	       },
	       function(result) {
	       	$("#homePhoneNo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		    	$("#callHomePhoneNo").attr("disabled",null);
	       	}
	    	$("#msgHomePhoneNo").attr("disabled",null);
	       });
	}
	if($("#mobilePhoneNo").val() != ""){
		//핸드폰번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData2.ridCust,
	           type: 'mbr2' ,
	           field: 'phone'
	       },
	       function(result) {
	       	$("#mobilePhoneNo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		    	$("#callMobilePhoneNo").attr("disabled",null);
	       	}
	    	$("#msgMobilePhoneNo").attr("disabled",null);
	       });
	}

	$("#unmaskBtn").attr("disabled","true");
}

//가원장 추가정보 마스킹 해제
function clickUnmaskBtn2(){
	if($("#transmitNo").val() != ""){
		//발신번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData2.rid ,
	           type: 'voc2' ,
	           field: 'telNo'
	       },
	       function(result) {
	       	$("#transmitNo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		    	$("#callTransmitNo").attr("disabled",null);
	       	}
	    	$("#msgTransmitNo").attr("disabled",null);
	       });
	}

	if($("#contactableNo").val() != ""){
		//연락가능번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData2.rid ,
	           type: 'voc2' ,
	           field: 'cntcPosblNo'
	       },
	       function(result) {
	       	$("#contactableNo").val(result.message);
	       	if(window.parent.document.getElementById("TSPhone")){
		    	$("#callContactableNo").attr("disabled",null);
	       	}
	    	$("#msgContactableNo").attr("disabled",null);
	       });
	}

// 	if($("#cardNo").val() != ""){
// 		//카드번호 마스킹 해제
// 		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
// 	           rid: rowData2.rid ,
// 	           type: 'voc2' ,
// 	           field: 'cardNo'
// 	       },
// 	       function(result) {
// 	       	$("#cardNo").val(result.message);
// 	       });
// 	}

	$("#unmaskBtn2").attr("disabled","true");
}

//소프트폰 전화걸기 함수
function makeCallForTransmitNo(){
	var transmitNo = $("#transmitNo").val();

	parent.localSoftMakeCall(transmitNo,null);
}
function makeCallForContactableNo(){
	var contactableNo = $("#contactableNo").val();

	parent.localSoftMakeCall(contactableNo,null);
}
function makeCallForHomePhoneNo(){
	var homePhoneNo = $("#homePhoneNo").val();

	parent.localSoftMakeCall(homePhoneNo,null);
}
function makeCallForMobilePhoneNo(){
	var mobilePhoneNo = $("#mobilePhoneNo").val();

	parent.localSoftMakeCall(mobilePhoneNo,null);
}

//문자메시지 전송 팝업
function showTransChnlPopForTransmitNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#transmitNo").val() + "&ridCust=" + rowData2.ridCust;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForContactableNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#contactableNo").val() + "&ridCust=" + rowData2.ridCust;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForHomePhoneNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#homePhoneNo").val() + "&ridCust=" + rowData2.ridCust;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForMobilePhoneNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#mobilePhoneNo").val() + "&ridCust=" + rowData2.ridCust;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}

//가원장 추가정보 초기화
function clearCustAddInfo(){
	$("#mbrName").val("");
	$("#mypinNo").val("");
	$("#errYn").prop("checked",false);
	$("#cardNo").val("");
	$("#gender").val("");
	$("#errCd").val("");
	$("#transmitNo").val("");
	$("#errDt").val("");
	$("#contactableNo").val("");
	$("#errContent").val("");
	$("#cardChkYn").val("");
}

//실 고객 정보 초기화
function clearRealCustInfo(){
	$("#memNo").val("");
	$("#memName").val("");
	$("#memSep").val("");
	$("#homePhoneNo").val("");
	$("#memGrade").val("");
	$("#mobilePhoneNo").val("");
	$("#memStatus").val("");
	$("#webMemId").val("");
	$("#joinChl").val("");
	$("#e1BonusMemYn").prop("checked",false);
	$("#webMemYn").prop("checked",false);
}

function setCustAddInfoDisabled(){
	if( $("#errYn").attr("checked") == "checked" ){
		$("#errCd, #errContent").attr("disabled",false);
		$("#validateCardChkBtn, #regAddCardBtn, #regNewMemCardBtn").attr("disabled",true);
	}else{
		$("#errCd, #errContent").attr("disabled",true);
		$("#validateCardChkBtn, #regAddCardBtn, #regNewMemCardBtn").attr("disabled",false);
	}
}

//가원장 추가 정보 > 저장 버튼
function clickSaveBtn(){
	if(voiceMailBoxGrid.getCheckedGridData()[0] != undefined){
		var errYn = null;
		if($("#errYn").prop("checked") == true){
			errYn = "Y";
		}else{
			errYn = "N";
		}

		$.ifvSyncPostJSON('<ifvm:action name="modifyCallContactOccuringError"/>',{
	   		mbrNm : $("#mbrName").val()
	   		, cardNo : $("#cardNo").val()
	   		, telNo : $("#transmitNo").val()
	   		, rid : rowData2.rid
	   		, errYn : errYn
	   		, errCd : $("#errCd").val()
	   		, errSbst : $("#errContent").val()
	   	},function(result) {
	   		//result.success == true;
	   		if(result.success == true){
	   			alert('<spring:message code="L00076"/>');
	   			getVoiceMailBoxListOnlyRegYnIsN();
	   			clearCustAddInfo();
	   			clearRealCustInfo();
	   			$("#errYn").attr("disabled",false);
	   			$("#errCd, #errContent").attr("disabled",true);
				resetCallList();
	   		}
	   	},function(result) {
	   		//result.success == false;
	   			alert(result.message);
	   	});
	}else{
		//음성사서함 관리 목록 row 미선택
		alert('<spring:message code="V00195"/>');
	}
}

//callList 초기화
function resetCallList(){
	callFlag = true;

	callList();

	callFlag = false;
}

//카드 등록 전, callBackNo 조회
function getCallBackNo(){
	var callBackNo = null;
	
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'SMS_CALL_BACK',
		codeName : 'SR'
	} , function(result) {

    	if (result.success) {
    		callBackNo = result.rows[0].markName;
    	}
    }, function(result){
    	alert(result.message);
    })

    return callBackNo;
}

$(document).ready(function(){
	init();
	
	$("#errYn").click(function(){
		setCustAddInfoDisabled();
	});
})
</script>

<style>
	.heightForm{
		height:230px;
	}
</style>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="V00075"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" id="recordBtn"  text="V00080" btnType="" btnFunc="clickRecordBtn" objCode="VOC_REC_001"/>
		<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('callListGrid')" objCode="COM_EXC_001"/>
	</div>
</div>
<div id="callListGrid" class="white_bg grid_bd0"></div>

<!-- 가원장 추가정보 -->
<div class="col-xs-7">
	<div class="page_btn_area">
		<div class="col-xs-3">
			<span><spring:message code="V00118"/></span>
		</div>
		<div class="col-xs-9 searchbtn_r">
			<ifvm:inputNew type="button" id="unmaskBtn2"  text="L00326" btnType="" btnFunc="clickUnmaskBtn2" objCode="COM_MSK_001"/>
			<ifvm:inputNew type="button" id="validateCardChkBtn"  text="V00119" btnType="" btnFunc="clickValidateCardChkBtn" objCode="VOC_CHK_001"/>
			<ifvm:inputNew type="button" id="regAddCardBtn"  text="V00120" btnType="" btnFunc="clickRegAddCardBtn" objCode="VOC_REG_001"/>
			<ifvm:inputNew type="button" id="regNewMemCardBtn"  text="V00121" btnType="" btnFunc="clickRegNewMemCardBtn" objCode="VOC_REG_002"/>
			<ifvm:inputNew type="button" id="saveBtn"  text="L00074" btnType="" btnFunc="clickSaveBtn" objCode="VOC_SAV_001"/>
		</div>
	</div>
	<div class="well form-horizontal heightForm underline">
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="mbrName" label="L00798" labelClass="1" conClass="3" />
			<ifvm:inputNew type="text" id="transmitNo" label="V00125" labelClass="2" conClass="3" />
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="callTransmitNo" nuc="" btnType="phone" btnFunc="makeCallForTransmitNo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgTransmitNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForTransmitNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="cardNo" label="L00414" labelClass="1" conClass="3" />
			<ifvm:inputNew type="hidden" id="cardChkYn" />
			<ifvm:inputNew type="text" id="contactableNo" label="V00126" labelClass="2" conClass="3" disabled="true" />
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="callContactableNo" nuc="" btnType="phone" btnFunc="makeCallForContactableNo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgContactableNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForContactableNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="gender" label="V00124" labelClass="1" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="mypinNo" label="V00122" labelClass="2" conClass="3" disabled="true" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="errDt" label="V00112" labelClass="1" conClass="3" disabled="true"/>
			<ifvm:inputNew type="select" id="errCd" names="errCd" label="V00111" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="singleCheckbox" id="errYn" label="V00123" values="Y" labelClass="1" conClass="1" checked="false"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="errContent" label="V00127" labelClass="1" conClass="8" disabled="true" rows="5"/>
		</div>
	</div>
</div>
<!-- 실 고객 정보 -->
<div class="col-xs-5 pl10">
	<div class="page_btn_area">
		<div class="col-xs-3">
			<span><spring:message code="V00128"/></span>
		</div>
		<div class="col-xs-9 searchbtn_r">
			<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn" objCode="COM_MSK_001"/>
		</div>
	</div>
	<div class="well form-horizontal heightForm underline">
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="homePhoneNo" label="V00129" labelClass="2" conClass="4" disabled="true"/>
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="callHomePhoneNo" nuc="" btnType="phone" btnFunc="makeCallForHomePhoneNo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgHomePhoneNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHomePhoneNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="mobilePhoneNo" label="L00840" labelClass="2" conClass="4" disabled="true"/>
			<div class="col-xs-2 middle">
				<ifvm:inputNew type="button" id="callMobilePhoneNo" nuc="" btnType="phone" btnFunc="makeCallForMobilePhoneNo" className="btn-imgonly"/>
				<ifvm:inputNew type="button" id="msgMobilePhoneNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForMobilePhoneNo" className="btn-imgonly"/>
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="memNo" label="L00787" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="memName" label="L00798" labelClass="2" conClass="3" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="memSep" label="L00837" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="memGrade" label="L00180" labelClass="2" conClass="3" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="memStatus" label="M02019" labelClass="2" conClass="3" disabled="true"/>
			<ifvm:inputNew type="text" id="webMemId" label="V00131" labelClass="2" conClass="3" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="joinChl" label="V00132" labelClass="2" conClass="3" disabled="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="singleCheckbox" id="webMemYn" label="V00134" values="1" labelClass="2" conClass="2" checked="false" disabled="true"/>
			<ifvm:inputNew type="singleCheckbox" id="e1BonusMemYn" label="V00133" values="1" labelClass="3" conClass="1" checked="false" disabled="true"/>
		</div>
	</div>
</div>