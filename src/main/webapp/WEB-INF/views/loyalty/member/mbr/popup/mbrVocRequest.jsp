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
<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';

var validation1 = null;
var validation2 = null;
var validation3 = null;

var detailFlag = false;

//활동내역
var actyHistoryData = [];
var PhoneArray = [];

//상담요청 상세
function getConsultDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getConsultDetail"/>',{
		rid : rid
	},function(result) {
		$("#detail_srNo").val(result.srNo);
		$("#detail_contactInfo").val(result.cntcDesk);
		$("#detail_memRid").val(result.ridMbr);
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
		if(result.cprtVndrHhoConvFail == "1"){
			$("#detail_affiliatedComFail").prop("checked",true);
		}else{
			$("#detail_affiliatedComFail").prop("checked",false);
		}
		$("#detail_processSituation").val(result.srTrtStatusNm);
		$("#detail_receptionist").val(result.createBy);
		$("#detail_receptionDate").val(result.rcpDt);
		$("#detail_personInChargeRid").val(result.ridCrmuser);
		$("#detail_personInChargeUserId").val(result.crmuserId);
		$("#detail_personInChargeName").val(result.crmuserName);
		$("#detail_transferDate").val(result.trcDt);
		$("#detail_endDate").val(result.endDt);
		$("#detail_callId").val(result.callId);
	});
}

function init(){
	$.ifvGetCommCodeList('select', 'detail_receptionMethod', '<ifvm:action name="getCommCodeList2"/>', 'CALL_TYPE', 'voc', false, false, true);
	$.ifvGetCommCodeList('select', 'detail_affiliatedCom', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_ALIANCE_TYPE', 'voc', false, false, true);

	$.fn.ifvmSetSelectOptionCommCode("detail_consultType1st", "SR_AREA_L", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType2nd", "SR_AREA_M", null, "detail_consultType1st", true);
	$.fn.ifvmSetSelectOptionCommCodeSync("detail_consultType3rd", "SR_AREA_S", null, "detail_consultType2nd", true);

	if(rid != "undefined" && rid != "null"){
		//상세
		detailFlag = true;
		getConsultDetail();
	}else{
		//신규
		//$("#tabVocType").remove();

	}
}

//담당자 팝업
function showPersonInChargePop(){
// 	$.ifvLoadPop({url : '<ifvm:url name="setPICPop"/>', params : '', close : function(){}});
	$("#setPICPop").ifvsfPopup({
       enableModal : true,
	   enableResize: false,
	   contentUrl: '<ifvm:url name="setPICPop"/>',
	   contentType: "ajax",
	   title: "<spring:message code='I02080'/>",
	   width: '600px',
	   close : 'setPICPopClose'
	});
}

//담당자 팝업 닫기
function setPICPopClose() {
	$('#setPICPop').ejDialog('destroy');
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
	            contentUrl: '<ifvm:url name="mbrSearchHelp"/>'    ,
	            contentType: "ajax",
	            title: '회원명 찾기',
	            width: '700px'
	        });
	};
	mbrSearchHelpPop.beforeClose = function (obj) {
	};
	mbrSearchHelpPop.close = function (obj) {
		 if(obj!=null){
	        	$("#detail_memRid").val(obj.rid);
	        	$("#detail_memNo").val(obj.mbrNo);
	        	$("#detail_memName").val(obj.custNm);
	        }
	        this.beforeClose(obj);
	        this.pop.data('ejDialog')._destroy();
	 };
	 mbrSearchHelpPop.popup();
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
		            width: '700px'
		        });
		};
		channelSearchHelpPop.beforeClose = function (obj) {
		};
		channelSearchHelpPop.close = function (obj) {
			 if(obj!=null){

		        	$("#detail_franchiseRid").val(obj.rid);
		        	$("#detail_franchiseName").val(obj.chnlNm);
		        	$("#detail_franchiseCode").val(obj.chnlNo);
// 		        	$("#dtlBizrNo").val(obj.bizrNo);
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
	var chkFlag = "0";

	if($("#detail_affiliatedComFail").attr("checked") == "checked"){
		chkFlag = "1";
	}

	if(validation1.confirm() && validation2.confirm() && validation3.confirm()){
		if(detailFlag){
			//상담요청 상세 수정
			$.ifvSyncPostJSON('<ifvm:action name="modifyRequestConsultation"/>',{
				ridMbr : $("#detail_memRid").val()
				, ridCrmuser : $("#detail_personInChargeRid").val()
				, srNo : $("#detail_srNo").val()
				, cnslgTypeCdL : $("#detail_consultType1st").val()
				, cnslgTypeCdM : $("#detail_consultType2nd").val()
				, cnslgTypeCdS : $("#detail_consultType3rd").val()
				, cnslgTitle : $("#detail_consultTitle").val()
				, cnslgSbst : $("#detail_consultContent").val()
				, rcpMeth : $("#detail_receptionMethod").val()
				, callId : $("#detail_callId").val()
				, memPtblNo : $("#detail_phoneNo").val()
				, memNo : $("#detail_memNo").val()
				, memNm : $("#detail_memName").val()
				, cntcDesk : $("#detail_contactInfo").val()
				, emailAddr : $("#detail_email").val()
				, cprtVndrHhoConvFail : chkFlag
				, cprtVndrCd : $("#detail_affiliatedCom").val()
				, rid : rid
				, ridChnl : $("#detail_franchiseRid").val()
				, srTrtStatus : "detailUpdate"
			},function(result) {
				if(result.success){

					alert('<spring:message code="L00127"/>');
					fnMbrVocRequestClose();
					getmbrVocListSearch();
				}else{
					alert('<spring:message code="M02248"/>');
				}
			});
		}else{
			//상담요청 상세 신규
			$.ifvSyncPostJSON('<ifvm:action name="setRequestConsultation"/>',{
				ridMbr : $("#detail_memRid").val()
				, ridCrmuser : $("#detail_personInChargeRid").val()
				, ridChnl : $("#detail_franchiseRid").val()
				, cnslgTypeCdL : $("#detail_consultType1st").val()
				, cnslgTypeCdM : $("#detail_consultType2nd").val()
				, cnslgTypeCdS : $("#detail_consultType3rd").val()
				, cnslgTitle : $("#detail_consultTitle").val()
				, cnslgSbst : $("#detail_consultContent").val()
				, rcpMeth : $("#detail_receptionMethod").val()
				, memNo : $("#detail_memNo").val()
				, callId : $("#detail_callId").val()
				, memPtblNo : $("#detail_phoneNo").val()
				, memNm : $("#detail_memName").val()
				, cntcDesk : $("#detail_contactInfo").val()
				, emailAddr : $("#detail_email").val()
				, cprtVndrHhoConvFail : chkFlag
				, cprtVndrCd : $("#detail_affiliatedCom").val()
			},function(result) {
				if(result.success){
// 					qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultList");
					window.close();
				}else{
					alert('<spring:message code="M02248"/>');
				}
			});
		}
	}else{
		alert('<spring:message code="M01055"/>');
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
function tabVocContent(){
	$('#tabVocContent').DrawTab({
		item: [
			{label: '<spring:message code="V00033"/>', href: '<ifvm:url name="actyHistoryList"/>'},
			{label: '<spring:message code="V00041"/>', href: '<ifvm:url name="transactionListByRidMbr"/>'},
			{label: '<spring:message code="V00068"/>', href: '<ifvm:url name="cardListByRidMbr"/>'},
		]
	});
}

$(document).ready(function(){
	init();

	//상담유형 변경 이벤트
	changeConsultType();

	tabVocContent();
});


</script>

<style>
	.heightForm{
		height:360px;
	}
</style>



<%-- <div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00028"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" id="saveBtn"  text="V00003" btnType="plus" btnFunc="clickSaveBtn"/>
    </div>
</div> --%>

<!-- SR정보 -->
<div class="col-xs-6">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="V00030"/></span>
		</div>
	</div>
	<div class="well form-horizontal heightForm">
		<div id='formArea1'>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_srNo" label="V00016" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="detail_contactInfo" label="V00009" labelClass="2" conClass="3" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_memRid" />
				<ifvm:inputNew type="search" id="detail_memNo" names="detail_memNo" objCode="SRCH" dto="detail_memNo" btnFunc="showMemPop" label="V00004" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="detail_phoneNo" label="V00006" labelClass="2" conClass="3" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="detail_memName" names="detail_memName" objCode="SRCH" dto="detail_memName" btnFunc="showMemPop" label="V00005" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="detail_email" label="V00008" labelClass="2" conClass="3" />
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
	<div class="well form-horizontal heightForm">
		<div id='formArea2'>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType1st" names="detail_consultType1st" label="V00010" labelClass="4" conClass="6" required="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType2nd" names="detail_consultType2nd" label="V00011" labelClass="4" conClass="6" required="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_consultType3rd" names="detail_consultType3rd" label="V00012" labelClass="4" conClass="6" required="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_receptionMethod" label="V00020" labelClass="4" conClass="6" required="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_franchiseRid" />
				<ifvm:inputNew type="search" id="detail_franchiseCode" names="detail_franchiseCode" objCode="SRCH" dto="detail_franchiseCode" btnFunc="showFranchisePop" label="V00021" labelClass="4" conClass="6" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="search" id="detail_franchiseName" names="detail_franchiseName" objCode="SRCH" dto="detail_franchiseName" btnFunc="showFranchisePop" label="V00022" labelClass="4" conClass="6" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="select" id="detail_affiliatedCom" label="V00023" labelClass="4" conClass="6" />
			</div>
			<div class="row qt_border">
		        <ifvm:inputNew type="singleCheckbox" id="detail_affiliatedComFail" label="V00024" values="1" labelClass="6" conClass="6" checked="false"/>
			</div>
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
	<div class="well form-horizontal heightForm">
		<div id='formArea3'>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_processSituation" label="V00007" labelClass="3" conClass="6" disabled="true" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionist" label="V00025" labelClass="3" conClass="6" disabled="true" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_receptionDate" label="V00017" labelClass="3" conClass="6" disabled="true" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="hidden" id="detail_personInChargeRid" required="true"/>
				<ifvm:inputNew type="hidden" id="detail_personInChargeUserId" />
				<ifvm:inputNew type="search" id="detail_personInChargeName" names="detail_personInChargeName" objCode="SRCH" dto="detail_personInChargeName" btnFunc="showPersonInChargePop" label="V00026" labelClass="3" conClass="6" required="true"/>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_transferDate" label="V00027" labelClass="3" conClass="6" disabled="true" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_endDate" label="V00028" labelClass="3" conClass="6" disabled="true" />
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="detail_callId" label="V00029" labelClass="3" conClass="6" disabled="true" />
			</div>
		</div>
	</div>
</div>

<!-- 탭 컨텐츠 -->
<div id="tabVocArea">
	<div class="btn-group btn-group-justified" id="tabVocType">
	       <div id="tabVocContent" ></div>
	</div>
</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="L01462" btnFunc="clickSaveBtn" className="btn_lightGray2"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="vocDetailPop.close" className="btn_lightGray2"/>
</div>

<!-- 담당자 팝업 -->
<div id="setPICPop"></div>
<!-- 회원번호 및 회원명 선택 팝업 - 이성원 과장님 -->
<div id="mbrSearchPopDiv" class="empty_popup_container"></div>
<!-- 가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님 -->
<div id="channelSearchPopDiv" class="empty_popup_container"></div>