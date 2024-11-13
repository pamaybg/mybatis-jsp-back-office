<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var consultGrid=null;
var mbrListGrid =null;
var rowData = null;
var listUrl;
//조회조건영역 조회 flag
var searchFlag = false;
//전체 상담요청 조회 flag
var allFlag = false;
//미할당리스트 조회 flag
var noneFlag = false;
var temp = null;
var initFlag = false;


function consultList(){
	var ejGridOption = {
	        loadComplete : function(obj){
	    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
	    		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListGrid.opt.data.records);
	        },
	      	serializeGridData : function(data) {
	      		
	      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
	        }
	          return data;
	      	},
	      	recordDoubleClick : function(args) {
	    	  	var data = args.data.rid ;
	    	  	goMbrDetail(data); // ??
	      	},
	      	dataUrl : '<ifvm:action name="getMbrListNewPage"/>',
	      	columns: [
	    	  {
	    		  field : 'pgmNm', headerText : '프로그램', headerTextAlign : 'center', width:'300px',
	    	  },
	    	  /* {
	    		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center', textAlign : 'center' ,
	    	  }, */
	    	  {
	    		  field : 'mbrNo', headerText : '회원번호',headerTextAlign : 'center', textAlign : 'center' ,
	    	  },
	    	  {
	    		  field : 'custNm', headerText : '회원명',headerTextAlign : 'center',
	    	  },
	    	  {
	    		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center',
	    	  },
	    	  {
			      field : 'mbrStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center' , customAttributes : {index : 'mbrStatCd'}
		  	  },
	    	  {
			      field : 'sbscDate', headerText : '가입일시', headerTextAlign : 'center', textAlign : 'center' ,
		  	  },
	    	  {
	    		  field : 'sbscChnlNm', headerText : '가입채널',headerTextAlign : 'center', 
	    	  },
	    	  {
	    		  field : 'createDate', headerText : '등록일자',headerTextAlign : 'center', width:'160px', textAlign : 'center',
	    	  },
	    	  {
	    		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
	    	  }

	      ],
	      	requestGridData : {
	    	  	sidx 	: '3',
	    	  	sord 	: 'desc'
	      	},
	      	rowList : [10,25,50,100],
	      	gridDataInit: false,
	      	radio: true,
	      	tempId : 'ifvGridSimplePageTemplete2'
	 	};

	  	mbrListGrid = $("#mbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//초기화
function clickInitializeBtn(){
	/* $("#memNo").val("");
	$("#memName").val("");
	$("#phoneNo").val("");
	$("#email").val("");
	$("#contactInfo").val("");
	$("#processSituation").val("");
	$("#consultType1st").val("");
	$("#consultType2nd").val("");
	$("#consultType3rd").val("");
	$("#srNo").val("");
	$("#rcpMeth").val("");
	setCalendar(); */
	$("#comSearchArea input, #comSearchArea select").val("");
}

//목록 조회
function clickSearchBtn(){
	
	if($("#memNo").val() == "" && $("#memName").val() == "" && $("#phoneNo").val() == ""
		&& $("#processSituation").val() == "" && $("#email").val() == "" && $("#contactInfo").val() == ""
		&& $("#consultType1st").val() == "" && $("#consultType2nd").val() == "" && $("#consultType3rd").val() == ""
		&& $("#startDate_rcpDt").val() == "" && $("#endDate_rcpDt").val() == "" && $("#rcpMeth").val() == ""){
		//상담요청 조회 시, 하나 이상의 조회 조건을 주어야합니다.
		alert('<spring:message code="V00290"/>');
	}else if($("#memName").val() != "" && $("#memName").val().length < 2){
		//회원명은 2자 이상 입력
		alert('<spring:message code="L01986"/>');
	}else{
		searchFlag = true;
		consultList();
		searchFlag = false;
	}
}

function init(){
// 	$.ifvGetCommCodeList('select', 'processSituation', '<ifvm:action name="getCommCodeList"/>', 'SR_STATUS', 'voc', false, true, false);
	$.fn.ifvmSetSelectOptionCommCode("processSituation", "SR_STATUS", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("rcpMeth", "CALL_TYPE", null, null, false);

	$.fn.ifvmSetSelectOptionCommCode("consultType1st", "SR_AREA_L", null, null, false);
	$.fn.ifvmSetSelectOptionCommCodeSync("consultType2nd", "SR_AREA_M", null, "consultType1st", false);
	$.fn.ifvmSetSelectOptionCommCodeSync("consultType3rd", "SR_AREA_S", null, "consultType2nd", false);

	$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, false);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", false);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", false);


	$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, true, true);
	$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false, true, true);

	$("#unmaskBtn").attr("disabled",true);

	setCalendar();
}

//상담요청 상세
function getConsultDetail(data){
	$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
		rid : data.rid
	},function(result) {
		if(result != null){
			$("#detail_srNo").val(result.srNo);
			$("#detail_contactInfo").val(result.cntcDesk);
			$("#detail_memRid").val(result.ridMbr);
			$("#detail_ridCust").val(result.ridCust);
			$("#detail_memNo").val(result.memNo);
			$("#detail_phoneNo").val(result.memPtblNo);
			$("#detail_memName").val(result.memNm);
			$("#detail_email").val(result.emailAddr);
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
			$("#detail_affiliatedCom").val(result.cprtVndrCd);
			if(result.cprtVndrHhoConvFail == "Y"){
				$("#detail_affiliatedComFail").prop("checked",true);
			}else{
				$("#detail_affiliatedComFail").prop("checked",false);
			}
			$("#detail_processSituation").val(result.srTrtStatusNm);
			$("#detail_receptionist").val(result.createBy);
			$("#detail_receptionDate").val(result.rcpDt);
			$("#detail_personInChargeName").val(result.crmuserName);
			$("#detail_transferDate").val(result.trcDt);
			$("#detail_endDate").val(result.endDt);
			$("#detail_callId").val(result.callId);
			//setDetailRowHighlight();
		}

	});
}

//상담요청 신규
function clickNewBtn(){
	qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultDetail?custNm=");
}

//상담완료
function clickCompleteBtn(){
	var checkedList = consultGrid.getCheckedList();
	var objectRidList = [];
	var objectStatList = [];
	var completeFlag = false;

	for( var i = 0; i < checkedList.length; i++ ){
		objectRidList.push( checkedList[i].rid );

		if(checkedList[i].srTrtStatus == 'Closed'){
			completeFlag = true;
			break;
		}
	}

	if(objectRidList.length <= 0){
		alert('<spring:message code="V00142"/>'); //완료할 상담요청 목록을 선택해주세요.
	}else if(completeFlag){
		alert('<spring:message code="V00214"/>'); //이미 완료된 목록은 다시 완료 처리할 수 없습니다.
	}else if(confirm('<spring:message code="V00221"/>') == true){

		$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
			srTrtStatus : "Closed"
			, ridList : objectRidList
		},function(result) {
			if(result.success){
				alert('<spring:message code="V00202"/>');
				getConsultListStatusOpen();
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
	}

	rowData = "";
}

//담당자 팝업
function showPersonInChargePop(){
	$("#setPICPop").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="setPICPop"/>',
	   contentType: "ajax",
	   title: "<spring:message code='I02080'/>",
	   width: 600,
	   close : 'setPICPopClose'
	});
}

//담당자 팝업 닫기
function setPICPopClose() {
	setPICPop._destroy();
}

//담당자 선택
function clickAddBtn(data){
	if(pic.length==0){
		alert('<spring:message code="L01393"/>');
		return;
	}
	var checkedList = consultGrid.getCheckedList();
	var objectRidList = [];
	for( var i = 0; i < checkedList.length; i++ ){
		objectRidList.push( checkedList[i].rid );
	}

	//담당자와 현 로그인 한 담당자 비교
	var picFlag = false;
	for( var i = 0; i < checkedList.length; i++ ){
		if( pic.ridUser == checkedList[i].ridCrmuser ){
			picFlag = true;
			break;
		}
	}

	if(picFlag){
		alert('<spring:message code="V00072"/>');
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
			srTrtStatus : "Transfer"
			, ridList : objectRidList
			, ridCrmuser : pic.ridUser
		},function(result) {
			if(result.success){
				alert('<spring:message code="V00203"/>');
				getConsultListStatusOpen();
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
		setPICPopClose();
	}
}

//상담원 이관
function clickTransferBtn(){
	var checkedList = consultGrid.getCheckedList();
	var objectRidList = [];
	for( var i = 0; i < checkedList.length; i++ ){
		objectRidList.push( checkedList[i].rid );
	}

	if(objectRidList.length <= 0){
		alert('<spring:message code="V00141"/>'); //이관할 상담요청 목록을 선택해주세요.
	}else{
		showPersonInChargePop();
	}

	rowData = "";
}

//상담유형 변경 이벤트
function changeConsultType(){
	$("#consultType1st").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("consultType2nd", "SR_AREA_M", null, "consultType1st", false);
		$.fn.ifvmSetSelectOptionCommCodeSync("consultType3rd", "SR_AREA_S", null, "consultType2nd", false);
	});
	$("#consultType2nd").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("consultType3rd", "SR_AREA_S", null, "consultType2nd", false);
	});
}

//전체 상담요청 조회
function clickSearchAllBtn(){
	if($("#memNo").val() == "" && $("#memName").val() == "" && $("#phoneNo").val() == ""
		&& $("#processSituation").val() == "" && $("#email").val() == "" && $("#contactInfo").val() == ""
		&& $("#consultType1st").val() == "" && $("#consultType2nd").val() == "" && $("#consultType3rd").val() == ""
		&& $("#startDate_rcpDt").val() == "" && $("#endDate_rcpDt").val() == "" && $("#rcpMeth").val() == ""){
		//전체 상담요청 조회 시, 하나 이상의 조회 조건을 주어야합니다.
		alert('<spring:message code="V00205"/>');
	}else if($("#memName").val() != "" && $("#memName").val().length < 2){
		//회원명은 2자 이상 입력
		alert('<spring:message code="L01986"/>');
	}else{
		allFlag = true;
		searchFlag = true;

		consultList();

		searchFlag = false;
		allFlag = false;
	}
}

//미할당 리스트 조회
function clickSearchNoneBtn(){
	noneFlag = true;
	allFlag = true;
	clickSearchBtn();
	allFlag = false;
	noneFlag = false;
}

//SR정보 마스킹 해제
function clickUnmaskBtn(){
	if($("#detail_contactInfo").val() != ""){
		//연락처 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	           rid: rowData.rid ,
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
	           rid: rowData.rid ,
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
	           rid: rowData.rid ,
	           type: 'voc' ,
	           field: 'emailAddr'
	       },
	       function(result) {
	       	$("#detail_email").val(result.message);
	       	$("#sendEmail").attr("disabled",null);
	       });
	}

	$("#unmaskBtn").attr("disabled",true);
}

//녹취청취 버튼
function clickRecordBtn(){
	var checkedList = consultGrid.getCheckedList();

	if(consultGrid.getCheckedGridData()[0] != undefined && checkedList.length == 1){
		$("#playRecordFilePop").ifvsfPopup({
		   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="playRecordFilePop"/>?callId='+rowData.callId+'&callDate='+rowData.rcpDt,
		   contentType: "ajax",
		   title: "<spring:message code='V00158'/>",
		   width: 600,
		   close : 'playRecordFilePopClose'
		});
	}else if(checkedList.length > 1){
		alert('<spring:message code="V00204"/>');
	}else if(consultGrid.getCheckedGridData()[0] == undefined){
		alert('<spring:message code="V00198"/>');
	}
}

//소프트폰 전화걸기 함수
function makeCallForContactInfo(){
	var contactInfo = $("#detail_contactInfo").val();

	parent.localSoftMakeCall(contactInfo,null);
}
function makeCallForHhpNo(){
	var phoneNo = $("#detail_phoneNo").val();

	parent.localSoftMakeCall(phoneNo,null);
}

function getConsultListStatusOpen(){
// 	initFlag = true;
// 	consultList();
// 	initFlag = false;

	$("#processSituation").val("Open");
	clickSearchBtn();

}

//문자메시지&이메일 전송 팝업
function showTransChnlPopForConNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_contactInfo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForHpNo() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=sms&hpNo=" + $("#detail_phoneNo").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}
function showTransChnlPopForEmail() {
	var url = "/loyalty/common/winpop/transChnlPop?sendType=email&email=" + $("#detail_email").val() + "&ridCust=" + $("#detail_ridCust").val() + "&ridVocReq=" + rowData.rid;

	window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740');
}

//SR정보,SR유형,처리현황 정보 초기화
function getConDetailInfoClear(){
	$("#detail_srNo").val("");
	$("#detail_contactInfo").val("");
	$("#detail_memRid").val("");
	$("#detail_memNo").val("");
	$("#detail_phoneNo").val("");
	$("#detail_memName").val("");
	$("#detail_email").val("");
	$("#detail_consultTitle").val("");
	$("#detail_consultContent").val("");
	$("#detail_consultType1st").val("");
	$("#detail_consultType2nd").val("");
	$("#detail_consultType3rd").val("");
	$("#detail_receptionMethod").val("");
	$("#detail_franchiseRid").val("")
	$("#detail_franchiseCode").val("");
	$("#detail_franchiseName").val("");
	$("#detail_affiliatedCom").val("");
	$("#detail_affiliatedComFail").prop("checked",false);
	$("#detail_processSituation").val("");
	$("#detail_receptionist").val("");
	$("#detail_receptionDate").val("");
	$("#detail_personInChargeName").val("");
	$("#detail_transferDate").val("");
	$("#detail_endDate").val("");
	$("#detail_callId").val("");
}

function goGridRowMbrLink(cellvalue, options, rowObjec){
    var memNo = rowObjec.memNo;
    var url = '<ifvm:url name="mbrDetail"/>' + '?mbrNo=' + memNo;
   	var tag = null;

   	if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }

   	return tag;
}

function setCalendar() {
	 var startDate = $('#startDate_rcpDt');
	 var endDate = $('#endDate_rcpDt');
	 //오늘날짜
// 	 startDate.val($.ifvGetTodayDate());
// 	 endDate.val($.ifvGetTodayDate());
	 //오늘부터 한달 뒤
//	 endDate.val($.ifvGetNewDate('m', +1).newDateS);

	 //설정
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}

$(document).ready(function(){
	//마스킹해제 권한 체크
// 	checkButtnAuth();
	
	$.ifvmLnbSetting('consultList');

	init();

	getConsultListStatusOpen();

	//상담유형 변경 이벤트
	changeConsultType();

	$.ifvEnterSetting(["#comSearchArea"], function(){
		clickSearchBtn();
	});
});

</script>


<div class="page-title">
	<h1>
		<spring:message code="V00067"/> &gt;  <spring:message code="L00030"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code="L01838"/></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="searchAllBtn"  text="V00073" btnType="search" btnFunc="clickSearchAllBtn"/>
		<ifvm:inputNew type="button" id="searchBtn"  text="L00030" btnType="search" btnFunc="clickSearchBtn"/>
		<ifvm:inputNew type="button" id="initializeBtn"  text="L00031" btnFunc="clickInitializeBtn"/>
	</div>
</div>
<div class="well form-horizontal underline" id="comSearchArea">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="memNo" label="V00004" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="memName" label="V00005" labelClass="2" conClass="2" />
		<ifvm:inputNew type="text" id="phoneNo" label="V00006" labelClass="2" conClass="2" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="processSituation" names="processSituation" label="V00007" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="email" label="V00008" labelClass="2" conClass="2" />
		<ifvm:inputNew type="text" id="contactInfo" label="V00009" labelClass="2" conClass="2" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="consultType1st" names="consultType1st" label="V00010" labelClass="1" conClass="2" />
		<ifvm:inputNew type="select" id="consultType2nd" names="consultType2nd" label="V00011" labelClass="2" conClass="2" />
		<ifvm:inputNew type="select" id="consultType3rd" names="consultType3rd" label="V00012" labelClass="2" conClass="2" />

	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="dateTerm" startDto="startDateRcpDt" endDto="endDateRcpDt" startId="startDate_rcpDt" endId="endDate_rcpDt" label="V00294" labelClass="1" conClass="3"/>
		<ifvm:inputNew type="select" id="rcpMeth" names="rcpMeth" label="V00020" labelClass="1" conClass="2" />
		<ifvm:inputNew type="text" id="srNo"  label="V00016" labelClass="2" conClass="2" />
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-4">
			<span><spring:message code="M00277"/></span>
		</div>
		<div class="col-xs-8 searchbtn_r">
			<ifvm:inputNew type="button" id="newBtn"  text="M00274" btnType="plus" btnFunc="clickNewBtn" objCode="COM_NEW_001"/>
			<ifvm:inputNew type="button" id="transferBtn"  text="V00013" btnFunc="clickTransferBtn" objCode="VOC_TRN_001"/>
			<ifvm:inputNew type="button" id="completeBtn"  text="V00014" btnFunc="clickCompleteBtn" objCode="VOC_COM_001"/>
			<ifvm:inputNew type="button" id="recordBtn"  text="V00015" btnFunc="clickRecordBtn" objCode="VOC_REC_001"/>
			<ifvm:inputNew type="button" id="searchNoneBtn"  text="V00074" btnType="search" btnFunc="clickSearchNoneBtn" objCode="VOC_NON_001"/>
			<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('consultGrid')" objCode="COM_EXC_001"/>
		</div>
	</div>
	<div id=mbrListGrid class="white_bg grid_bd0"></div>
</div>
<!-- SR정보 -->
<div class="half_wrap top_well">
	<div class="col-xs-6">
		<div class="page_btn_area">
			<div class="col-xs-3">
				<span><spring:message code="V00030"/></span>
			</div>
			<div class="col-xs-9 searchbtn_r">
				<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn" objCode="COM_MSK_001"/>
			</div>
		</div>
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_srNo" label="V00016" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_contactInfo" label="V00009" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="callConNo" nuc="" btnType="phone" btnFunc="makeCallForContactInfo" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgConNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForConNo" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_ridCust" />
				<ifvm:inputNew type="hidden" id="detail_memRid" />
	<%-- 			<ifvm:inputNew type="search" id="detail_memNo" names="detail_memNo" objCode="SRCH" dto="detail_memNo" btnFunc="showMemNoPop" label="V00004" labelClass="2" conClass="3" /> --%>
				<ifvm:inputNew type="text" id="detail_memNo" label="V00004" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_phoneNo" label="V00006" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="callHpNo" nuc="" btnType="phone" btnFunc="makeCallForHhpNo" className="btn-imgonly"/>
					<ifvm:inputNew type="button" id="msgHpNo" nuc="" btnType="commenting" btnFunc="showTransChnlPopForHpNo" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
	<%-- 			<ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemNamePop" label="V00005" labelClass="2" conClass="3" /> --%>
				<ifvm:inputNew type="text" id="detail_memName" label="V00005" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_email" label="V00008" labelClass="2" conClass="3" disabled="true"/>
				<div class="col-xs-2 middle">
					<ifvm:inputNew type="button" id="sendEmail" nuc="" btnType="envelope-o" btnFunc="showTransChnlPopForEmail" className="btn-imgonly"/>
				</div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_consultTitle" label="V00018" labelClass="2" conClass="8" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="textarea" id="detail_consultContent" label="V00019" labelClass="2" conClass="8" disabled="true" rows="5"/>
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
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType1st" names="detail_consultType1st" label="V00010" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType2nd" names="detail_consultType2nd" label="V00011" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType3rd" names="detail_consultType3rd" label="V00012" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_receptionMethod" label="V00020" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
	<%-- 			<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode" objCode="SRCH" dto="detail_franchiseCode" btnFunc="showFranchiseCodePop" label="V00021" labelClass="4" conClass="6" /> --%>
				<ifvm:inputNew type="text" id="detail_franchiseCode" label="V00021" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
	<%-- 			<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName" objCode="SRCH" dto="detail_franchiseName" btnFunc="showFranchiseNamePop" label="V00022" labelClass="4" conClass="6" /> --%>
				<ifvm:inputNew type="text" id="detail_franchiseName" label="V00022" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_affiliatedCom" label="V00023" labelClass="4" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
	            <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail" label="V00024" values="1" labelClass="4" conClass="6" checked="false" disabled="true"/>
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
		<div class="form-horizontal well heightForm underline">
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_processSituation" label="V00007" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionist" label="V00025" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionDate" label="V00017" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
	<%-- 			<ifvm:inputNew type="hidden" id="detail_personInChargeRid" required="true"/> --%>
	<%-- 			<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" /> --%>
	<%-- 			<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="detail_personInChargeName" btnFunc="" label="V00026" labelClass="3" conClass="6" required="true"/> --%>
				<ifvm:inputNew type="text" id="detail_personInChargeName" label="V00026" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_transferDate" label="V00027" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_endDate" label="V00028" labelClass="3" conClass="6" disabled="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_callId" label="V00029" labelClass="3" conClass="6" disabled="true"/>
			</div>
		</div>
	</div>
</div>
<!-- 담당자 팝업 -->
<div id="setPICPop"></div>
<!-- 녹취파일 듣기 팝업 -->
<div id="playRecordFilePop"></div>