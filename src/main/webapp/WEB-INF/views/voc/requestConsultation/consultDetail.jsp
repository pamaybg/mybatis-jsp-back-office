<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
<%@ page import = "java.net.URLDecoder" %>
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
<%
	String param = URLDecoder.decode(cleanXss(request.getParameter("custNm")), "UTF-8");
%>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var ridCust = '<%= cleanXss(request.getParameter("ridCust")) %>';
var mbrNo = '<%= cleanXss(request.getParameter("mbrNo")) %>';
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';
var custNm = '<%= cleanXss(param) %>';

var validation1 = null;
var validation2 = null;
var validation3 = null;

var detailFlag = false;
var closedFlag = false;

//활동내역
var actyHistoryData = null;

function setWriter(result){
	$.ifvSyncPostJSON('<ifvm:action name="getReplyHistoryList"/>',{
		rid : rid
	},function(result2) {
		if(result2.rows[0] != null){
			$("#detail_receptionist").val(result2.rows[0].writer); //접수자
			$("#detail_personInChargeName").val(result2.rows[0].writer); //담당자
		}else{
			$("#detail_receptionist").val(result.createBy); //접수자
			$("#detail_personInChargeName").val(result.createBy); //담당자
		}
	},function(result){
	});
}
//상담요청 상세
function getConsultDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
		rid : rid
		, ridCust : ridCust
	},function(result) {
		$("#detail_srNo").val(result.srNo);
		$("#detail_contactInfo").val(result.unMaskCntcDesc);
		$("#detail_memRid").val(result.ridMbr);
		$("#detail_ridCust").val(result.ridCust);
		$("#detail_ridMbr").val(result.ridMbr);
		$("#detail_memNo").val(result.memNo);
		$("#detail_phoneNo").val(result.unMaskMemPtblNo);
		$("#detail_memName").val(result.unMaskMemNm);
		$("#detail_email").val(result.unMaskEmailAddr);
		$("#detail_consultTitle").val(result.cnslgTitle);
		$("#detail_consultContent").val(result.cnslgSbst);
		$("#detail_consultType1st").val(result.cnslgTypeCdL);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
		$("#detail_consultType2nd").val(result.cnslgTypeCdM);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
		$("#detail_consultType3rd").val(result.cnslgTypeCdS);

		$("#detail_receptionMethod").val(result.rcpMeth);
		$("#detail_franchiseRid").val(result.ridChnl)
		$("#detail_franchiseCode").val(result.chnlNo);
		$("#detail_franchiseName").val(result.chnlNm);
		/* $("#detail_affiliatedCom").val(result.cprtVndrCd); */
		if(result.cprtVndrHhoConvFail == "Y"){
			$("#detail_affiliatedComFail").prop("checked",true);
		}else{
			$("#detail_affiliatedComFail").prop("checked",false);
		}
		$("#detail_processSituation").val(result.srTrtStatusNm);

		setWriter(result);
	
		
		$("#detail_receptionDate").val(result.rcpDt);
		$("#detail_personInChargeRid").val(result.ridCrmuser);
		$("#detail_personInChargeUserId").val(result.crmuserId);
		$("#detail_transferDate").val(result.trcDt);
		$("#detail_endDate").val(result.endDt);


		if(result.srTrtStatus == "Closed"){
			closedFlag = true;
		}
	});
}

function init(){
	$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);

	$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, false, false, false);
// 	$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false , true, false, false);
	$.fn.ifvmSetSelectOptionCommCode("detail_affiliatedCom", "ALLIANCE_COMPANY_TYPE", null, null, false);

	$("#callConNo, #msgConNo, #callHpNo, #msgHpNo, #sendEmail").attr("disabled",true);

	if(rid != "undefined" && rid != "null"){
		//상세
		detailFlag = true;
		getConsultDetail();
	}else{
		//신규
		/* $("#detail_callId").val(window.parent.CTI.callId); */
		$("#recordBtn").attr("disabled",true);
		//회원정보 세팅
		if(ridCust != "null"){
			$("#detail_ridCust").val(ridCust);
		}
		if(mbrNo != "null"){
			$("#detail_memNo").val(mbrNo);
		}
		if(custNm != "null"){
			$("#detail_memName").val(custNm);
		}
		if(ridMbr != "null"){
			$("#detail_memRid").val(ridMbr);
		}
		
		//담당자 세팅
		var tPIC = $.ifvmGetUserInfo();
		
		$("#detail_personInChargeRid").val(tPIC.id);
		$("#detail_personInChargeUserId").val(tPIC.userId);
		$("#detail_personInChargeName").val(tPIC.empName);
	}

	if($("#detail_contactInfo").val() == "" && $("#detail_phoneNo").val() == "" && $("#detail_email").val() == ""){
		$("#unmaskBtn").attr("disabled",true);
	}

	/* if($("#detail_callId").val() == ""){
		$("#recordBtn").attr("disabled",true);
	} */

	$("#completeBtn").attr("disabled",true);
}

//담당자 팝업
function showPersonInChargePop(){
	$("#setPICPop").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="setPICPop"/>',
	   contentType: "ajax",
	   title: "<spring:message code='I02080'/>",
	   width: 900,
	   close : 'setPICPopClose'
	});
}

//담당자 팝업 닫기
function setPICPopClose() {
	setPICPop._destroy();
}

//담당자 선택
function clickAddBtn(data){
	$("#detail_personInChargeRid").val(pic.ridUser);
	$("#detail_personInChargeUserId").val(pic.userId);
	$("#detail_personInChargeName").val(pic.empName);
	setPICPopClose();
}

//회원번호 및 회원명 선택 팝업 - 이성원 과장님
function showMemPop(){
	mbrSearchHelpPop ={
	        id : "mbrSearchPopDiv"
	    };
	mbrSearchHelpPop.popup = function (){
	mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="mbrListPop"/>'    ,
	            contentType: "ajax",
	            title: '<spring:message code="L00988"/>',
	            width: 800
	        });
	};
	mbrSearchHelpPop.beforeClose = function (obj) {
	};
	mbrSearchHelpPop.close = function (obj) {
		 if(obj!=null){
// 	        	$("#detail_memRid").val(obj.rid);
	        	$("#detail_ridCust").val(obj.ridCust);
	        	$("#detail_ridMbr").val(obj.ridMbr);
	        	$("#detail_memNo").val(obj.mbrNo);
	        	$("#detail_memName").val(obj.custNm);
// 	        	if(!detailFlag){
		        	setMbrInfoWhenMbrSearchHappens(obj);
// 	        	}
	        }
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 mbrSearchHelpPop.popup();
}

//회원 찾기 시, 휴대폰번호 및 이메일 세팅
function setMbrInfoWhenMbrSearchHappens(obj){
	//휴대폰번호 마스킹 해제 > 전화,문자 버튼 활성화
	if(obj.hhpNo != ""){
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: obj.rid ,
	           type: 'mbr' ,
	           field: 'phone'
	    },function(result) {
    	   $("#detail_phoneNo").val(result.message);
    	   $("#callHpNo").attr("disabled",null);
    	   $("#msgHpNo").attr("disabled",null);
       	});	
	}
	
	//이메일 마스킹 해제 > 이메일 버튼 활성화
	if(obj.emailAddr != ""){
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: obj.rid ,
	           type: 'mbr' ,
	           field: 'email'
	    },function(result) {
    	   $("#detail_email").val(result.message);
    	   $("#sendEmail").attr("disabled",null);
       	});	
	}
	
}

//가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님
function showFranchisePop(){
	channelSearchHelpPop ={
	        id : "channelSearchPopDiv"
	    };
	channelSearchHelpPop.popup = function (){
		channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A',
		            contentType: "ajax",
		            title: '<spring:message code="L00987"/>',
		            width: 700
		        });
		};
		channelSearchHelpPop.beforeClose = function (obj) {
		};
		channelSearchHelpPop.close = function (obj) {
			 if(obj!=null){

		        	$("#detail_franchiseRid").val(obj.rid);
		        	$("#detail_franchiseName").val(obj.chnlNm);
		        	$("#detail_franchiseCode").val(obj.chnlNo);
		        }
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		channelSearchHelpPop.popup();
}

//상담요청 상세 저장
function clickSaveBtn(){
	validation1 = $("#formArea1").ifvValidation();
	validation2 = $("#formArea2").ifvValidation();
	validation3 = $("#formArea3").ifvValidation();

	//제휴업체 호전환 실패 체크 여부 확인
	var chkFlag = "N";

	/* if($("#detail_affiliatedComFail").attr("checked") == "checked"){
		chkFlag = "Y";
	} */

	if($.ifvmGetUserInfo().userId != $("#detail_personInChargeUserId").val()){
		alert('<spring:message code="V00296"/>'); //다른 담당자의 상담은 수정할 수 없습니다.
	}else{
		if(validation1.confirm() && validation2.confirm() && validation3.confirm()){
			if(detailFlag){
				//상담요청 상세 수정
				$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
					ridCust : $("#detail_ridCust").val()
					, ridMbr : $("#detail_ridMbr").val()
					, ridCrmuser : $("#detail_personInChargeRid").val()
					, srNo : $("#detail_srNo").val()
					, cnslgTypeCdL : $("#detail_consultType1st").val()
					, cnslgTypeCdM : $("#detail_consultType2nd").val()
					, cnslgTypeCdS : $("#detail_consultType3rd").val()
					, cnslgTitle : $("#detail_consultTitle").val()
					, cnslgSbst : $("#detail_consultContent").val()
					, rcpMeth : $("#detail_receptionMethod").val()
					, memPtblNo : $("#detail_phoneNo").val()
					, memNo : $("#detail_memNo").val()
					, memNm : $("#detail_memName").val()
					, cntcDesk : $("#detail_contactInfo").val()
					, emailAddr : $("#detail_email").val()
					, cprtVndrHhoConvFail : chkFlag
					/* , cprtVndrCd : $("#detail_affiliatedCom").val() */
					, rid : rid
					, ridChnl : $("#detail_franchiseRid").val()
					, srTrtStatus : "detailUpdate"
				},function(result) {
					if(result.success){
						alert("<spring:message code="C00094" />");
						/* qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultDetail?rid="+rid+"&ridCust="+$("#detail_ridCust").val()+"&custNm="); */
						qtjs.href('<ifvm:url name="consultListNew"/>');
					}
				},function(result) {
					alert('<spring:message code="M02248"/>');
				});
			}else{
				//상담요청 상세 신규
				$.ifvSyncPostJSON('<ifvm:action name="setRequestConsultation"/>',{
					ridCust : $("#detail_ridCust").val()
					, ridMbr : $("#detail_ridMbr").val()
					, ridCrmuser : $("#detail_personInChargeRid").val()
					, crmName : $("#detail_personInChargeName").val()
					, ridChnl : $("#detail_franchiseRid").val()
					, cnslgTypeCdL : $("#detail_consultType1st").val()
					, cnslgTypeCdM : $("#detail_consultType2nd").val()
					, cnslgTypeCdS : $("#detail_consultType3rd").val()
					, cnslgTitle : $("#detail_consultTitle").val()
					, cnslgSbst : $("#detail_consultContent").val()
					, rcpMeth : $("#detail_receptionMethod").val()
					, memNo : $("#detail_memNo").val()
					, callId : 	window.parent.CTI.callId
					, memPtblNo : $("#detail_phoneNo").val()
					, memNm : $("#detail_memName").val()
					, cntcDesk : $("#detail_contactInfo").val()
					, emailAddr : $("#detail_email").val()
					, groupCode : "CALL_TYPE"
					, cprtVndrHhoConvFail : chkFlag
					/* , cprtVndrCd : $("#detail_affiliatedCom").val() */
				},function(result) {
					if(result.success){
						alert("<spring:message code="C00094" />");
						if(window.parent.document.getElementById("TSPhone")){
							$("#mainIframe").attr("src",window.history.back());
						}else{
							history.back();
						}
	// 					qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultList");
					}
				},function(result) {
					alert('<spring:message code="M02248"/>');
				});
			}
		}else if(validation1.confirm() && validation2.confirm() && !validation3.confirm()){
			alert('<spring:message code="V00220"/>'); //담당자를 입력해주세요.
		}else{
			alert('<spring:message code="M01055"/>'); //필수항목을 입력해주세요.
		}
	}
}

//상담유형 변경 이벤트
function changeConsultType(){
	$("#detail_consultType1st").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
	});
	$("#detail_consultType2nd").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);
	});
}

//탭 컨텐츠 생성
function tabContent(){
	$('#tabContent').DrawTab({
		item: items
		/* [
			{label: '답변내역', href: '<ifvm:url name="replyHistoryList"/>'},
		] */
	});
}

//SR정보 마스킹 해제 -> 상세 시작 시 자동으로
/* function clickUnmaskBtn(){
	if($("#detail_srNo").val() != ""){
		if($("#detail_contactInfo").val() != ""){
			//연락처 마스킹 해제
			$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
		           rid: rid ,
		           type: 'voc' ,
		           field: 'cntcDesk'
		       },
		       function(result) {
		       	$("#detail_contactInfo").val(result.message);
		       	if(window.parent.document.getElementById("TSPhone")){
			       	$("#callConNo").attr("disabled",null);
		       	}
				$("#msgConNo").attr("disabled",null);
		       });
		}

		if($("#detail_phoneNo").val() != ""){
			//휴대폰번호 마스킹 해제
			$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
		           rid: rid ,
		           type: 'voc' ,
		           field: 'memPtblNo'
		       },
		       function(result) {
		       	$("#detail_phoneNo").val(result.message);
		       	if(window.parent.document.getElementById("TSPhone")){
			       	$("#callHpNo").attr("disabled",null);
		       	}
				$("#msgHpNo").attr("disabled",null);
		       });
		}

		if($("#detail_email").val() != ""){
			//이메일 마스킹 해제
			$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
		           rid: rid ,
		           type: 'voc' ,
		           field: 'emailAddr'
		       },
		       function(result) {
		       	$("#detail_email").val(result.message);
				$("#sendEmail").attr("disabled",null);
		       });
		}

		$("#unmaskBtn").attr("disabled",true);
	}else{
		alert('<spring:message code="V00200"/>');
	}
} */

//소프트폰 전화걸기 함수
function makeCallForContactInfo(){
	var contactInfo = $("#detail_contactInfo").val();

	parent.localSoftMakeCall(contactInfo,null);
}
function makeCallForHhpNo(){
	var phoneNo = $("#detail_phoneNo").val();

	parent.localSoftMakeCall(phoneNo,null);
}

//문자메시지&이메일 전송 팝업
function showTransChnlPopForConNo() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=sms&hpNo=" + $("#detail_contactInfo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForHpNo() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=sms&hpNo=" + $("#detail_phoneNo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForEmail() {
	var url = '<ifvm:url name="transChnlPop"/>';
	url += "?sendType=email&email=" + $("#detail_email").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}

//상담요청 리스트로 돌아가기
function clickGoBackListBtn(){
	if(window.parent.document.getElementById("TSPhone")){
		$("#mainIframe").attr("src",window.history.back());
	}else{
		history.back();
	}
}

//녹취청취 버튼
function clickRecordBtn(){
	$("#playRecordFilePop").ifvsfPopup({
	   enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="playRecordFilePop"/>?callId='+$("#detail_callId").val()+'&callDate='+$("#detail_receptionDate").val(),
	   contentType: "ajax",
	   title: "<spring:message code='V00158'/>",
	   width: 600,
	   close : 'playRecordFilePopClose'
	});
}

//상담완료 시, 모든 기능 disabled 처리
function setBtnDisabledAll(){
	$("#saveBtn, #newBtn, #smsBtn, #emailBtn").attr("disabled",true);
}
function setAreaDisabledAll(){
	$("input, select, textarea, #msgConNo, #msgHpNo, #sendEmail").attr("disabled",true);
	$(".input-group-addon").remove();
}

//상담완료
function clickCompleteBtn(){
	var objectRidList = [];
	objectRidList.push( rid );

	if(confirm('<spring:message code="V00221"/>') == true){
		$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
			srTrtStatus : "Closed"
			, ridList : objectRidList
			, rid : rid
			, crmName : $("#detail_personInChargeName").val()
			, ridCust : $("#detail_ridCust").val()
			, ridCrmuser : $("#detail_personInChargeRid").val()
		},function(result) {
			if(result.success){
				alert('<spring:message code="V00202"/>');
				getConsultDetail();			
				$("#completeBtn").attr("disabled",true);
				actyHistoryGrid._doAjax();
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
	}
}

$(document).ready(function(){
	$.ifvmLnbSetting('consultList');
	init();

	//상담유형 변경 이벤트
	changeConsultType();

	tabContent();
	
	if(rid != "undefined" && rid != "null"){
		//상세일 경우, 마스킹 해제
		//clickUnmaskBtn();
		$("#completeBtn").attr("disabled",false);
	}

	if(closedFlag){
		setAreaDisabledAll();
		$("#completeBtn").attr("disabled",true);
	}
});

$(window).load(function(){
	/*
	if(rid != "undefined" && rid != "null"){
		//상세일 경우, 마스킹 해제
		//clickUnmaskBtn();
		$("#completeBtn").attr("disabled",false);
	}

	if(closedFlag){
		setAreaDisabledAll();
		$("#completeBtn").attr("disabled",true);
	} */
});

</script>

<style>
	.heightForm{
		height:230px;
	}
	.middle {
	  	vertical-align: middle;
	  	text-align: left;
	}
</style>

<div class="page-title">
	<h1>
		<spring:message code="상담내역"/> &gt;  <spring:message code="L00079"/>
	</h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00028"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<%-- <ifvm:inputNew type="button" id="recordBtn"  text="V00015" btnFunc="clickRecordBtn" objCode="VOC_REC_001"/> --%>
		<ifvm:inputNew type="button" id=""  text="L01698" btnFunc="clickGoBackListBtn" objCode="consultDetailList_OBJ"/>
		<ifvm:inputNew type="button" id="completeBtn"  text="V00014" btnFunc="clickCompleteBtn" objCode="consultDetailCompl_OBJ"/>
		<ifvm:inputNew type="button" id="saveBtn"  text="V00003" btnType="save" btnFunc="clickSaveBtn" objCode="consultDetailSave_OBJ"/>
    </div>
</div>
<div class="half_wrap top_well">
	<!-- SR정보 -->
	<div class="col-xs-6">
		<div class="page_btn_area">
			<div class="col-xs-3">
				<span><spring:message code="V00030"/></span>
			</div>
			<div class="col-xs-9 searchbtn_r">
<%-- 				<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn"/> --%>
			</div>
		</div>
		<div class="well form-horizontal heightForm underline">
			<div id='formArea1'>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_srNo" label="V00016" labelClass="2" conClass="3" disabled="true"/>
					<%-- <ifvm:inputNew type="text" id="detail_contactInfo" label="V00009" labelClass="2" conClass="3" /> --%>
				<div class="col-xs-2 middle">
					<%-- <ifvm:inputNew type="button" id="callConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfo" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgConNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForConNo" className="btn-imgonly"/> --%>
				</div>
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="hidden" id="detail_memRid" />
					<ifvm:inputNew type="hidden" id="detail_ridCust" />
					<ifvm:inputNew type="hidden" id="detail_ridMbr" />
					<ifvm:inputNew type="text" id="detail_memNo" names="detail_memNo" objCode="SRCH" disabled="true" dto="detail_memNo" label="V00004" labelClass="2" conClass="3" />
					<ifvm:inputNew type="text" id="detail_phoneNo" disabled="true"	 label="V00006" labelClass="2" conClass="3" />
				<div class="col-xs-2 middle">
					<%-- <ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgHpNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHpNo" className="btn-imgonly"/> --%>
				</div>
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemPop" label="V00005" labelClass="2" conClass="3" />
					<ifvm:inputNew type="text" id="detail_email" disabled="true" label="V00008" labelClass="2" conClass="3" />
				<div class="col-xs-2 middle">
					<%-- <ifvm:inputNew type="button" id="sendEmail" nuc="" btnType="envelope-o" btnFunc="showTransChnlPopForEmail" className="btn-imgonly"/> --%>
				</div>
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_consultTitle" label="V00018" labelClass="2" conClass="8" required="true"/>
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="textarea" id="detail_consultContent" label="V00019" labelClass="2" conClass="8"  rows="5" required="true"/>
				</div>
			</div>
		</div>
	</div>
	<!-- SR유형 -->
	<div class="col-xs-3 pl10">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="V00031"/></span>
			</div>
		</div>
		<div class="well form-horizontal heightForm underline">
			<div id='formArea2'>
				<div class="row qt_border">
					<ifvm:inputNew type="select" id="detail_consultType1st" names="detail_consultType1st" label="V00010" labelClass="4" conClass="6" required="true"/>
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="select" id="detail_consultType2nd" names="detail_consultType2nd" label="V00011" labelClass="4" conClass="6" required="true"/>
				</div>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="select" id="detail_consultType3rd" names="detail_consultType3rd" label="V00012" labelClass="4" conClass="6" required="true"/>
				</div> --%>
				<div class="row qt_border">
					<ifvm:inputNew type="select" id="detail_receptionMethod" label="V00020" labelClass="4" conClass="6" required="true"/>
				</div>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="hidden" id="detail_franchiseRid" />
					<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode" objCode="SRCH" dto="detail_franchiseCode" btnFunc="showFranchisePop" label="V00021" labelClass="4" conClass="6" />
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName" objCode="SRCH" dto="detail_franchiseName" btnFunc="showFranchisePop" label="V00022" labelClass="4" conClass="6" />
				</div> --%>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="select" id="detail_affiliatedCom" names="detail_affiliatedCom" label="V00023" labelClass="4" conClass="6" />
				</div> --%>
				<%-- <div class="row qt_border">
			        <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail" label="V00024" values="1" labelClass="4" conClass="6" checked="false"/>
				</div> --%>
			</div>
		</div>
	</div>
	<!-- 처리현황 -->
	<div class="col-xs-3 pl10">
		<div class="page_btn_area">
			<div class="col-xs-7">
				<span><spring:message code="V00032"/></span>
			</div>
		</div>
		<div class="well form-horizontal heightForm underline">
			<div id='formArea3'>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_processSituation" label="V00007" labelClass="3" conClass="6" disabled="true" />
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_receptionist" label="V00025" labelClass="3" conClass="6" disabled="true" />
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_receptionDate" label="접수일자" labelClass="3" conClass="6" disabled="true" />
				</div>
				<div class="row qt_border">
					<ifvm:inputNew type="hidden" id="detail_personInChargeRid" required="true"/>
					<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" />
					<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="detail_personInChargeName" btnFunc="showPersonInChargePop" label="V00026" labelClass="3" conClass="6" required="true"/>
				</div>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_transferDate" label="이관일자" labelClass="3" conClass="6" disabled="true" />
				</div> --%>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_endDate" label="종료일자" labelClass="3" conClass="6" disabled="true" />
				</div> --%>
				<%-- <div class="row qt_border">
					<ifvm:inputNew type="text" id="detail_callId" label="V00029" labelClass="3" conClass="6" disabled="true" />
				</div> --%>
			</div>
		</div>
	</div>
</div>
</div>
<!-- 탭 컨텐츠 -->
<div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
	       <div id="tabContent" ></div>
	</div>
</div>

<!-- 담당자 팝업 -->
<div id="setPICPop"></div>
<!-- 회원번호 및 회원명 선택 팝업 - 이성원 과장님 -->
<div id="mbrSearchPopDiv" class="empty_popup_container"></div>
<!-- 가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님 -->
<div id="channelSearchPopDiv" class="empty_popup_container"></div>
<!-- 녹취파일 듣기 팝업 -->
<div id="playRecordFilePop"></div>
<!-- 과거이력 조회 팝업 -->
<div id="txnSearchPopupContainer" class="popup_container"></div>

<div id="mbrListPop" class="popup_container"></div>