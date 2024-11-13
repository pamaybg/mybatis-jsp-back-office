<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="chnlSettleAddForm">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="pgmNo" names="pgmNo" label="프로그램번호" labelClass="3" conClass="5" required="true" disabled="true"/>
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="pgmNm" names="pgmNm" label="프로그램명" labelClass="3" conClass="5" required="true" disabled="true"/>	
				<span class="input-group-addon" style="padding: 6px;" id="chnlLoyPgmListBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
	</div>
	
	<!-- 분사분담율 --> 
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="정산유형"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" required="true" id="settleTypeCd" dto="settleTypeCd" names="settleTypeCd" maxLength="5"/>
		</div>
	</div>
	<!-- 채널분담율 -->
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>본사분담율(%)</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="number" id="hqRate" maxNum="100" dto="hqRate" required="true"/>
		</div>
	</div>
	<!-- 정산율시작일 -->
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>채널분담율(%)</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="number" id="chnlRate" dto="chnlRate" maxNum="100" required="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>정산 시작일</label>
		<div class="col-xs-4 control_content">
			<ifvm:inputNew type="date" id="settleStartDate" dto="settleStartDate" required="true"/>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="addChnlSettleSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L02251"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="chnlSettleCancel" objCode="addChnlSettleCancel_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="chnlLoyPgmListPopup" class="popup_container"></div>

<script>
var isNew;
var pgmChnlRid;
var rid;

function chnlSettleInit(){
	if(typeof chnlSettleRid === 'undefined' || chnlSettleRid == null){
		isNew = true;
		$("#pgmNo").val("");
		$("#pgmNm").val("");
	}
	else	{
		isNew = false;
		getChnlLoyPgm();
	}
}

function getChnlLoyPgm() {
	$.ifvSyncPostJSON('<ifvm:action name="getLoyChnlPgmDetailNew"/>',{
		rid  : chnlSettleRid
	},function(result) {
		rid		   = result.rid;
		pgmChnlRid = result.pgmChnlRid;
		$("#pgmNo").val(result.pgmNo);
		$("#pgmNm").val(result.pgmNm);
		$("#settleTypeCd").val(result.settleTypeCd);
		$("#hqRate").val(result.hqRate);
		$("#chnlRate").val(result.chnlRate);
		$("#settleStartDate").val(result.settleStartDate);
	});
}

function chnlLoyPgmListPop() {
	$("#chnlLoyPgmListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlLoyPgmListPopup"/>',
        contentType: "ajax",
        title: '프로그램 등록',
        width: 880,
        close : 'chnlLoyPgmListClosePop'
	});
}

function chnlLoyPgmListClosePop() {
	chnlLoyPgmListPopup._destroy();
}

function saveChnlSettle(){
	var validation = $("#chnlSettleAddForm").ifvValidation();

	//유효성 체크
	if(validation.confirm()){
		if($("#hqRate").val() >100 || $("#chnlRate").val()>100) {
			alert("정산률은 100을 초과할수 없습니다.");
			return;
		}
		var result = Number($("#hqRate").val()) + Number($("#chnlRate").val());
		if(result!=100) {
			alert("본사사분담율, 채널분담율 합산이 100%여야 합니다.");
			return;
		}
		
 		var url = isNew? '<ifvm:action name="saveChnlSettle"/>' : '<ifvm:action name="modifyChnlSettle"/>';
		var varData = null;
		varData = {
				rid		       : chnlSettleRid,
				pgmRid		   : pgmRid,
				chnlRid		   : channelDetail_rid,
				pgmChnlRid     : pgmChnlRid,
				settleTypeCd   : $("#settleTypeCd").val(),
				hqRate		   : $("#hqRate").val(),
				chnlRate	   : $("#chnlRate").val(),
				settleStartDate: $("#settleStartDate").val()
		};
		$.ifvSyncPostJSON(url, varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
				}
			}, function(result) {
				if(result.message) alert(result.message);
				else alert("<spring:message code="M02248" />");
		});
		addChnlSettleClosePop();
		getChnlSettleList();
		isNew = false;
	}
}

$(document).ready(function(){
	$.fn.ifvmSetSelectOptionCommCode("settleTypeCd", "LOY_SETTLE_TYPE_CD", null, null, true);
	setValidCalendar();//달력셋팅
	
	chnlSettleInit();
	
	//닫기
	$("#chnlSettleCancel").on("click",function(){
		chnlSettleCancel();
	});
	
	$("#chnlLoyPgmListBtn").click(function(){
		chnlLoyPgmListPop();
	});
	
	$("#btnSave").click(function(){
		saveChnlSettle();
	});
	
/* 	//닫기
	$("#chnlSettleCancel").on("input",function(){
		chnlSettleCancel();
	}); */
});

function chnlSettleCancel() {
	addChnlSettleClosePop();
}

 
//달력셋팅
function setValidCalendar() {	
	var settleStartDate = $("#settleStartDate");

	settleStartDate.val($.ifvGetTodayDate());

	settleStartDate.ifvDateChecker({
		
	});
}
</script>