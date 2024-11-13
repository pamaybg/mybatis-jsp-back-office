<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

gGroupDetail = {
	data : {},
	pointFieldId : ['avlPoint'],
	setPointField : function(){
		for(var pi = 0 ; pi < this.pointFieldId.length ; pi++){
			var _pval = $("#"+this.pointFieldId[pi]).val();
			var _aval="";
			if(_pval){
				_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			$("#"+this.pointFieldId[pi]).css("text-align","right").val(_aval);
		}
	},
	init : function(){
		$.ifvGetCommCodeList('select', 'memDiv', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_TYPE_ONLY_G', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'mbrTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_TYPE_CD', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'mbrStatCd', '<ifvm:action name="getCommCodeList2"/>', 'LOY_MEM_STAT_CD', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'tierCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'loy', false, false, true);
		$.ifvmLnbSetting('mbrGroupList');
		this.loadData();
	},
	loadData : function(){
		var action = '<ifvm:action name="getMbrGroupDetail"/>';
		$.ifvSyncPostJSON(action, {
			rid: $.ifvGetParam('rid')
		}, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				gGroupDetail.data = result ;
				$("#mbrGroupDetailForm").dataSetting(result);
				gGroupDetail.setPointField();
				//회원구분 -제휴단체 일 경우 카드 비밀번호 수정가능
				if($("#memDiv option:selected").val() == "A"){
					$("#cardPass, #btnSaveMbrGrp").prop("disabled",false);
				}
			}else{
				alert('<spring:message code="L01609"/>');//잘못된 접근입니다.
				gGroupDetail.moveList();
			}
		}, function(result){
			alert(result.message);
		})
	},
	save : function(){
		var vali  = $("#mbrGroupDetailForm").ifvValidation();
		if(vali.confirm()){
			var data  = $("#mbrGroupDetailForm").getSubmitData();
			data.rid = $.ifvGetParam('rid');
			var action = '<ifvm:action name="editMbrGroupDetail"/>';
			$.ifvSyncPostJSON(action, data, function(result) {

				if ($.fn.ifvmIsNotEmpty(result)) {
					gGroupDetail.loadData();
				}
			})
		}
	},
	moveList : function(){
		qtjs.href('<ifvm:url name="mbrGroupList"/>');
	}
}


$(document).ready(function(){
	gGroupDetail.init();
});

</script>


<div class="page-title">
	<h1>
		<spring:message code="L01606"/><span>
		&gt; <spring:message code="L00028"/></span>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span><spring:message code="L01464"/></span>
	</div>

	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" id="btnSaveMbrGrp" btnFunc="gGroupDetail.save" btnType="save" text="L00074" disabled="true" objCode="btnSaveMbrGrp_OBJ"/><!-- 저장 -->
		<ifvm:inputNew type="button" btnFunc="gGroupDetail.moveList" text="L00824" objCode="moveListMbrGrp_OBJ"/><!-- 목록 -->
	</div>
</div>

<div class="form-horizontal underline top_well" id="mbrGroupDetailForm" >
	<div class="row">
		<ifvm:inputNew type="text" id="chnlNm" maxLength="50"  dto="chnlNm"  required="true" disabled="true"
			label="L01466" labelClass="1" conClass="2" /><!-- 단체명 -->
		<ifvm:inputNew type="text" id="mbrNo" maxLength="50"  dto="mbrNo"	disabled="true"
			label="L01467" labelClass="1" conClass="2" /><!-- 회원번호 -->
		<ifvm:inputNew type="select" id="tierCd" dto="tierCd"	disabled="true"
			label="L01468" labelClass="1" conClass="2" /><!-- 회원등급 -->
		<ifvm:inputNew type="text" id="avlPoint" maxLength="50"  dto="avlPoint"	disabled="true"
			label="L01469" labelClass="1" conClass="2" /><!-- 가용포인트 -->
	</div>
	<div class="row">
		<ifvm:inputNew type="select" id="memDiv" dto="memDiv"	disabled="true"
			label="L01470" labelClass="1" conClass="2" /><!-- 회원구분 -->
		<ifvm:inputNew type="select" id="mbrTypeCd" dto="mbrTypeCd"	disabled="true"
			label="L01471" labelClass="1" conClass="2" /><!-- 회원유형 -->
		<ifvm:inputNew type="select" id="mbrStatCd" dto="mbrStatCd"	disabled="true"
			label="L01472" labelClass="1" conClass="2" /><!-- 회원상태 -->
		<%-- <ifvm:inputNew type="text" id="cardPass" maxLength="50"  dto="cardPass"	disabled="true"
			label="L01473" labelClass="1" conClass="2" /><!-- 카드비밀번호 --> --%>
	 </div>
</div>
<div id="mbrGroupDetailTabArea" class="white_bg grid_bd0"></div>

<script type="text/javascript">
var testTab = $('#mbrGroupDetailTabArea').DrawTab({
	item: [
		{label: '<spring:message code="L01474"/>', href: '<ifvm:url name="mbrGroupAddInfo"/>'},//추가정보
		{label: '<spring:message code="L01475"/>', href: '<ifvm:url name="mbrGroupUserList"/>'},//동호회회원
		{label: '<spring:message code="L01476"/>', href: '<ifvm:url name="mbrGroupPointTxnHistList"/>'},//동호회 포인트 거래내역
		{label: '<spring:message code="L01477"/>', href: '<ifvm:url name="mbrOrangeCardList"/>'},//단체 카드리스트
		{label: '<spring:message code="L01478"/>', href: '<ifvm:url name="mbrPtnTxnHistList"/>'},//E1 포인트 거래내역 회원- 포인트 거래 이력과 같은 페이지
		{label: '<spring:message code="L01479"/>', href: '<ifvm:url name="mbrGroupPointStandard"/>'}, //포인트 적립기준
		{label: '<spring:message code="L01480"/>', href: '<ifvm:url name="mbrGroupChangeHistList"/>'} //변경이력
	]
});
</script>

<div id="mbrGroupDetailPopupContainer" class="popup_container"></div><!-- 팝업 -->

