<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var validation = null;


function init(){
	$.ifvGetCommCodeList('select', 'modal_receptionMethod', '<ifvm:action name="getCommCodeList"/>', 'CALL_TYPE', 'voc', false, false, true);
	$.ifvGetCommCodeList('select', 'modal_affiliatedCom', '<ifvm:action name="getCommCodeList"/>', 'ALLIANCE_COMPANY_TYPE', 'voc', false, false, true);

	$.fn.ifvmSetSelectOptionCommCode("modal_consultType1st", "SR_AREA_L", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("modal_consultType2nd", "SR_AREA_M", null, "modal_consultType1st", true);
	$.fn.ifvmSetSelectOptionCommCodeSync("modal_consultType3rd", "SR_AREA_S", null, "modal_consultType2nd", true);

	//접수자 입력
	$("#modal_receptionist").val(ifvmUserInfo.empName);
}

//담당자 선택
function clickAddBtn(data){
	$("#modal_personInChargeRid").val(pic.ridUser);
	$("#modal_personInChargeUserId").val(pic.userId);
	$("#modal_personInChargeName").val(pic.empName);
	setPICPopClose();
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

//상담유형 변경 이벤트
function changeConsultType(){
	$("#modal_consultType1st").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("modal_consultType2nd", "SR_AREA_M", null, "modal_consultType1st", true);
		$.fn.ifvmSetSelectOptionCommCodeSync("modal_consultType3rd", "SR_AREA_S", null, "modal_consultType2nd", true);
	});
	$("#modal_consultType2nd").change(function(){
		$.fn.ifvmSetSelectOptionCommCodeSync("modal_consultType3rd", "SR_AREA_S", null, "modal_consultType2nd", true);
	});
}

function clickClosePopBtn(){
	$.modalClose();
}

//확인 버튼 클릭 시, 상담요청 저장
function clickNewReqConsultBtn(){
	validation = $("#formArea").ifvValidation();

	//제휴업체 호전환 실패 체크 여부 확인
	var chkFlag = "0";

	if($("#modal_affiliatedComFail").attr("checked") == "checked"){
		chkFlag = "1";
	}

	if(validation.confirm()){
		$.ifvSyncPostJSON('<ifvm:action name="setRequestConsultation"/>',{
// 			ridMbr : ridMbr
			ridCrmuser : $("#modal_personInChargeRid").val()
			, ridChnl : $("#modal_franchiseRid").val()
			, cnslgTypeCdL : $("#modal_consultType1st").val()
			, cnslgTypeCdM : $("#modal_consultType2nd").val()
			, cnslgTypeCdS : $("#modal_consultType3rd").val()
			, cnslgTitle : $("#modal_consultTitle").val()
			, cnslgSbst : $("#modal_consultContent").val()
			, rcpMeth : $("#modal_receptionMethod").val()
			, memNo : $("#modal_memNo").val()
			, callId : $("#modal_callId").val()
			, memPtblNo : $("#modal_phoneNo").val()
			, memNm : $("#modal_memName").val()
			, cntcDesk : $("#modal_contactInfo").val()
// 			, emailAddr : $("#modal_email").val()
			, cprtVndrHhoConvFail : chkFlag
			, cprtVndrCd : $("#modal_affiliatedCom").val()
		},function(result) {
			if(result.success){
				qtjs.href("${pageContext.request.contextPath}/voc/requestConsultation/consultList");
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
	}else{
		alert('<spring:message code="M01055"/>');
	}
}

//가맹점드 및 가맹점명 선택 팝업 - 이성원 대리님
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
		            title: '가맹정명 찾기',
		            width: 700
		        });
		};
		channelSearchHelpPop.beforeClose = function (obj) {
		};
		channelSearchHelpPop.close = function (obj) {
			 if(obj!=null){
		        	$("#modal_franchiseRid").val(obj.rid);
		        	$("#modal_franchiseName").val(obj.chnlNm);
		        	$("#modal_franchiseCode").val(obj.chnlNo);
		        }
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		channelSearchHelpPop.popup();
}

$(document).ready(function(){
	init();

	changeConsultType();
});
</script>

<div class="modal-body pop_inner_wrap form-horizontal">
	<div class="row qt_border">
		<div class="col-xs-4">
			<ifvm:inputNew type="select" id="modal_receptionMethod" label="V00020" labelClass="5" conClass="7" required="true"/>
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" id="modal_contactInfo" label="V00009" labelClass="5" conClass="7" />
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" id="modal_callId" label="V00029" labelClass="5" conClass="7" disabled="true" />
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-4">
			<ifvm:inputNew type="select" id="modal_consultType1st" names="modal_consultType1st" label="V00010" labelClass="5" conClass="7" required="true"/>
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" id="modal_phoneNo" label="V00006" labelClass="5" conClass="7" />
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" id="modal_receptionist" label="V00025" labelClass="5" conClass="7" disabled="true" />
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-4">
			<ifvm:inputNew type="select" id="modal_consultType2nd" names="modal_consultType2nd" label="V00011" labelClass="5" conClass="7" required="true"/>
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="hidden" id="modal_franchiseRid" />
			<ifvm:inputNew type="hidden" id="modal_franchiseCode" />
			<ifvm:inputNew type="search" id="modal_franchiseName" names="modal_franchiseName" objCode="SRCH" dto="modal_franchiseName" btnFunc="showFranchisePop" label="V00022" labelClass="5" conClass="7" />
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" id="modal_transferDate" label="V00027" labelClass="5" conClass="7" disabled="true" />
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-4">
			<ifvm:inputNew type="select" id="modal_consultType3rd" names="modal_consultType3rd" label="V00012" labelClass="5" conClass="7" required="true"/>
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="select" id="modal_affiliatedCom" label="V00023" labelClass="5" conClass="7" />
		</div>
		<div class="col-xs-4">
        	<ifvm:inputNew type="singleCheckbox" id="modal_affiliatedComFail" label="V00024" values="1" labelClass="9" conClass="1" checked="false"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-4">
			<ifvm:inputNew type="hidden" id="modal_personInChargeRid" required="true"/>
			<ifvm:inputNew type="search" id="modal_personInChargeUserId" names="modal_personInChargeUserId" objCode="SRCH" dto="modal_personInChargeUserId" btnFunc="showPersonInChargePop" label="V00026" labelClass="5" conClass="7" required="true"/>
		</div>
		<div class="col-xs-4">
			<ifvm:inputNew type="search" id="modal_personInChargeName" names="modal_personInChargeName" objCode="SRCH" dto="modal_personInChargeName" btnFunc="showPersonInChargePop" label="V00026" labelClass="5" conClass="7" required="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="modal_consultTitle" label="V00018" labelClass="2" conClass="8" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="modal_consultContent" label="V00019" labelClass="2" conClass="8"  rows="5" required="true"/>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="newReqConsultBtn"  text="V00003" btnType="plus" btnFunc="clickNewReqConsultBtn"/>
	<ifvm:inputNew type="button" id="closePopBtn"  text="M00805" btnType="" btnFunc="clickClosePopBtn"/>
</div>
<!-- 가맹점드 및 가맹점명 선택 팝업 - 이성원 과장님 -->
<div id="channelSearchPopDiv" class="empty_popup_container"></div>
<!-- 담당자 팝업 -->
<div id="setPICPop"></div>
