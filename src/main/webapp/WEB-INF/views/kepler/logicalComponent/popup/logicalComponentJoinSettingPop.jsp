<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var curBaseInfo = new Object();

// 조인설정 공통리스트에서 팝업내 설정할 모든 조인 설정 데이터 가져오기
function getJoinSettingPopupDataList(pLeftLgcCompTblRelId, pRightLgcCompTblRelId){
	var rtnItem;
	joinCommonData.joinPopupDataList.forEach(function(item) {
		
		var isEqualLeftId = (item.leftLgcCompTblRelId === pLeftLgcCompTblRelId);
		var isEqualRightId = (item.rightLgcCompTblRelId === pRightLgcCompTblRelId);
		
		if(isEqualLeftId && isEqualRightId){
			rtnItem = item;
		}
	});
	
	return rtnItem;
}

// 조인설정 공통리스트에 조인 설정 데이터 설정하기
function setJoinSettingPopupDataList(newItem){
	
	if(joinCommonData.joinPopupDataList.length !== 0){
		
		// 저장 된 전보가 있는지 확인
		var isExists = false;
		var existsIndex = 0;
		joinCommonData.joinPopupDataList.forEach(function(item, index) {
			
			var isEqualLeftId = (item.leftLgcCompTblRelId === newItem.leftLgcCompTblRelId);
			var isEqualRightId = (item.rightLgcCompTblRelId === newItem.rightLgcCompTblRelId);
			
			if(isEqualLeftId && isEqualRightId){
				isExists = true;
				existsIndex = index;
			}
		});
		
		// 기존에 저장된 정보가 있을 땐 변경, 없을 땐 새로 입력
		if(isExists){
			joinCommonData.joinPopupDataList[existsIndex] = newItem;
		} else {
			joinCommonData.joinPopupDataList.push(newItem);
		}
		
	} else {
		joinCommonData.joinPopupDataList.push(newItem);
	}
}

//조인설정 공통리스트에 조인 설정 데이터 제거하기
function removeJoinSettingPopupDataList(pLeftLgcCompTblRelId, pRightLgcCompTblRelId){
	
	var newList = new Array();
	joinCommonData.joinPopupDataList.forEach(function(item) {
		var isEqualLeftId = (item.leftLgcCompTblRelId === pLeftLgcCompTblRelId);
		var isEqualRightId = (item.rightLgcCompTblRelId === pRightLgcCompTblRelId);
		
		if(!isEqualLeftId && !isEqualRightId){
			newList.push(item);
		}
	});
	
	joinCommonData.joinPopupDataList = newList;
}

// 조인 설정 팝업내 데이터를 가져오기
function getJoinSettingPopup() {
	
	curBaseInfo.joinTypeCd = $("input:radio[name='joinTypeCd']:checked").val();
	curBaseInfo.joinColumnList = getJoinColumn();
	
	return curBaseInfo;
}

// 조인 설정 팝업내 데이터 설정
function setJoinSettingPopup(joinSetObj) {
	
	curBaseInfo = joinSetObj;
	
	// Basic Data Setting
	$("input:radio[name='joinTypeCd'][value='"+joinSetObj.joinTypeCd+"']").prop('checked', "true");
	$("#inputLeftTableId").val(joinSetObj.leftTblId);
	$("#inputLeftTableName").val(joinSetObj.leftTblNm);
	$("#inputLeftTableAlias").val(joinSetObj.leftTblAlias);
	$("#inputRightTableId").val(joinSetObj.rightTblId);
	$("#inputRightTableName").val(joinSetObj.rightTblNm);
	$("#inputRightTableAlias").val(joinSetObj.rightTblAlias);
	
	// JoinColumn Data Setting
	if(joinSetObj.joinColumnList != null){
		setJoinColumn(joinSetObj.joinColumnList);
	}
}

// 새로 추가한 조인 칼럼행에 '+', '-' 버튼 이벤트 설정
function _setOnclickEvent() {
	$('.lgcItemPlusBtn').unbind("click");
	$('.lgcItemMinusBtn').unbind("click");
	
	//필수항목 플러스 버튼
    $('.lgcItemPlusBtn').click(function(e){addJoinColumn()});
    $('.lgcItemMinusBtn').click(function(e){removeJoinColumn(e, this)});
}

// 조인 칼럼 추가
function addJoinColumn() {

	// Common Data Setting
	var rowId = $.ifvmGetRowID();
	
	// Add JoinColumn Template	
	$("#joinColumnTmpl").tmpl({
		 joinRowId : rowId
	}).appendTo("#joinColumnList");
	$("#" + rowId + " #inputJoinColumnId").val("");
	$("#" + rowId + " #inputTempJoinColumnId").val(rowId);
	$("#" + rowId + " #inputLeftTblRelId").val(curBaseInfo.leftLgcCompTblRelId);
	$("#" + rowId + " #inputRightTblRelId").val(curBaseInfo.rightLgcCompTblRelId);
	
	// Hiding
	$("#" + rowId + " #inputJoinColumnId").hide();
	$("#" + rowId + " #inputTempJoinColumnId").hide();
	$("#" + rowId + " #inputLeftTblRelId").hide();
	$("#" + rowId + " #inputRightTblRelId").hide();

	// Item Click Event Reset
	_setOnclickEvent();
	
	// Column List Data Setting
	var leftColumnList = joinCommonData.curJoinPopData.leftTblNode.addInfo.data.columnList;
	var rightColumnList = joinCommonData.curJoinPopData.rightTblNode.addInfo.data.columnList;
	
	var joinOprtData; 
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{  
		groupCode : 'ANL_JOIN_OPRT_TYPE_CD'
		, enableNA : true
	},function(result) {
		joinOprtData = result.rows;
	});
	
	var selLeftTblCol = $("#" + rowId + " #selectLeftTableColumn");
	var selOprtCd = $("#" + rowId + " #selectColumnJoinOrptCd");
	var selRightTblCol = $("#" + rowId + " #selectRightTableColumn");
	$("#selectTableColumnTmpl").tmpl(leftColumnList).appendTo(selLeftTblCol);
	$("#selectCommCodeTmpl").tmpl(joinOprtData).appendTo(selOprtCd);
	$("#selectTableColumnTmpl").tmpl(rightColumnList).appendTo(selRightTblCol);

	// First Row's Minus Button will Hide
	if($(".local-join-column").length == 1){
		$(".local-join-column #btnColumnJoinRemove").hide();
	} else {
		$(".local-join-column #btnColumnJoinRemove").show();
	}
}

// 조인 칼럼 수정
function editJoinColumn(pItem) {
	
	// Common Data Setting
	var rowId = $.ifvmGetRowID();
	
	// Add JoinColumn Template	
	$("#joinColumnTmpl").tmpl({
		 joinRowId : rowId
	}).appendTo("#joinColumnList");
	$("#" + rowId + " #inputJoinColumnId").val(pItem.joinColumnId);
	$("#" + rowId + " #inputTempJoinColumnId").val(pItem.tempJoinColumnId);
	$("#" + rowId + " #inputLeftTblRelId").val(curBaseInfo.leftLgcCompTblRelId);
	$("#" + rowId + " #inputRightTblRelId").val(curBaseInfo.rightLgcCompTblRelId);
	
	// Hiding
	$("#" + rowId + " #inputJoinColumnId").hide();
	$("#" + rowId + " #inputTempJoinColumnId").hide();
	$("#" + rowId + " #inputLeftTblRelId").hide();
	$("#" + rowId + " #inputRightTblRelId").hide();

	// Item Click Event Reset
	_setOnclickEvent();

	// Column List Data Setting
	var leftColumnList = joinCommonData.curJoinPopData.leftTblNode.addInfo.data.columnList;
	var rightColumnList = joinCommonData.curJoinPopData.rightTblNode.addInfo.data.columnList;

	var joinOprtData; 
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{  
		groupCode : 'ANL_JOIN_OPRT_TYPE_CD'
		, enableNA : true
	},function(result) {
		joinOprtData = result.rows;
	});
	
	var selLeftTblCol = $("#" + rowId + " #selectLeftTableColumn");
	var selOprtCd = $("#" + rowId + " #selectColumnJoinOrptCd");
	var selRightTblCol = $("#" + rowId + " #selectRightTableColumn");
	$("#selectTableColumnTmpl").tmpl(leftColumnList).appendTo(selLeftTblCol);
	$("#selectCommCodeTmpl").tmpl(joinOprtData).appendTo(selOprtCd);
	$("#selectTableColumnTmpl").tmpl(rightColumnList).appendTo(selRightTblCol);

	// When Join Column Data EDIT 
	selLeftTblCol.val(pItem.leftColId).prop("selected", "true");
	selOprtCd.val(pItem.joinOprtCd).prop("selected", "true");
	selRightTblCol.val(pItem.rightColId).prop("selected", "true");
	
	// First Row's Minus Button will Hide
	if($(".local-join-column").length == 1){
		$(".local-join-column #btnColumnJoinRemove").hide();
	} else {
		$(".local-join-column #btnColumnJoinRemove").show();
	}
}

// 조인 컬럼 제거
function removeJoinColumn(e, _this) {
	
	// First Row's Minus Button will Hide
	if($(".local-join-column").length == 2){
		$(".local-join-column #btnColumnJoinRemove").hide();
	}
	
	$($(_this).parent().parent().parent().parent()).remove();
	_setOnclickEvent();
}

// 현재 팝업내 모든 조인 컬럼 데이터 가져오기
function getJoinColumn(){
	var joinColumnList = new Array();
	
	$(".local-join-column").each(function(e) {
		var item = {
			  joinColumnId			: $(this).find("#inputJoinColumnId").val()
			, tempJoinColumnId		: $(this).find("#inputTempJoinColumnId").val()
			, seq					: e+1
			, joinTypeCd 			: $("input:radio[name='joinTypeCd']:checked").val()
			, leftLgcCompTblRelId 	: $(this).find("#inputLeftTblRelId").val()
			, leftColId 			: $(this).find("#selectLeftTableColumn").val()
			, leftTblAliasColNm 	: $("#inputLeftTableAlias").val() + "." + $(this).find("#selectLeftTableColumn :selected").data('text')
			, joinOprtCd 			: $(this).find("#selectColumnJoinOrptCd").val()
			, rightLgcCompTblRelId 	: $(this).find("#inputRightTblRelId").val()
			, rightColId 			: $(this).find("#selectRightTableColumn").val()
			, rightTblAliasColNm 	: $("#inputRightTableAlias").val() + "." + $(this).find("#selectRightTableColumn :selected").data('text')
		}
		joinColumnList.push(item);
	});
	
	return joinColumnList;
}

// 불러온 모든 조인 칼럼 설정
function setJoinColumn(joinColumnList){
	$("#joinColumnList").html("");
 	joinColumnList.forEach(function(item, index, arr){
		editJoinColumn(item);
	});
}

// 조인설정 제거
function removeJoinSetting(){
	diagram.remove(diagram.selectionList[0]);
	var curInfo = getJoinColumn()[0];
	
	removeJoinSettingPopupDataList(curInfo.leftLgcCompTblRelId, curInfo.rightLgcCompTblRelId);
	
	logicalComponentPopClose();
}


//
function joinSettingPopup_Close(e){
	if(e !== undefined && e.event.keyCode === 27){
		if(joinCommonData.curJoinPopData.popType === "NEW"){
			diagram.undo();
		}
		return;
	} 
	if (confirm("<spring:message code='M01514'/>")){
		if(joinCommonData.curJoinPopData.popType === "NEW"){
			diagram.undo();
		}
		logicalComponentPopClose();
		return true;
	} else {
		return false;
	}
}

//조인 설정 화면 초기화
function joinSettingPopup_Init(){
	
	// Default Setting
	$("#inputLeftTblId").hide();
	$("#inputRightTblId").hide();
	
	// 분석/세그먼트 사용시
	if(lgcCompData.isAnalysisSegmentUsed){
		
		$("input:radio[name='joinTypeCd']").each(function(){
			$(this).prop("disabled", "true");
		});
		
		// +, - 버튼 숨김
		$(".lgcItemPlusBtn").each(function(){
			$(this).hide();
		});
		$(".lgcItemMinusBtn").each(function(){
			$(this).hide();
		});
		
		$(".local-join-column select").each(function(){
			$(this).prop("disabled", "true");
		});
		
		// 하단 버튼 숨김/표시 처리
		$("#btnJoinSettingSave").hide();
		$("#btnJoinSettingRemove").hide();
		$("#btnJoinSettingCancel").hide();
		$("#btnJoinSettingClose").show();
	} else {
		$("#btnJoinSettingSave").show();
		$("#btnJoinSettingRemove").show();
		$("#btnJoinSettingCancel").show();
		$("#btnJoinSettingClose").hide();
	}
	
	// Data Setting
	var curPopData = joinCommonData.curJoinPopData;
	var leftData = curPopData.leftTblNode.addInfo.data;
	var rightData = curPopData.rightTblNode.addInfo.data;
	
	var baseSettingData = new Object();
	if(curPopData.popType === "NEW"){
		// Inner 라디오 버튼 기본 선택
		$("input:radio[name='joinTypeCd']")[0].click();
		
		baseSettingData = {
			  joinTypeCd : ""
			, leftNodeId : leftData.nodeId
			, leftLgcCompTblRelId : leftData.tblRelId || leftData.tempTblRelId
			, leftTblId : leftData.tblMstId
			, leftTblNm : leftData.tblMstNm
			, leftTblAlias : leftData.tblAlias
			, rightNodeId : rightData.nodeId
			, rightLgcCompTblRelId : rightData.tblRelId || rightData.tempTblRelId
			, rightTblId : rightData.tblMstId
			, rightTblNm : rightData.tblMstNm
			, rightTblAlias : rightData.tblAlias
		};
		curBaseInfo = baseSettingData;
		addJoinColumn();
		
		$("#btnJoinSettingRemove").hide();
	} else if(curPopData.popType === "MODIFY") {
		var leftId = (leftData.tblRelId === "") ? leftData.tempTblRelId : leftData.tblRelId;
		var rightId = (rightData.tblRelId === "") ? rightData.tempTblRelId : rightData.tblRelId;
		
		baseSettingData = getJoinSettingPopupDataList(leftId, rightId);
		$("#btnJoinSettingRemove").show();
	}
	
	setJoinSettingPopup(baseSettingData);
}

// 조인 설정 팝업 이벤트 핸들러
function joinSettingPopup_Handler(){
	$("#btnJoinSettingSave").click(function(){
		
		var joinColumnPopupData = getJoinSettingPopup();
		if(joinColumnPopupData.joinTypeCd === undefined){
			alert("<spring:message code='M01509'/>");
			return;
		}
		
		setJoinSettingPopupDataList(joinColumnPopupData);
		
		logicalComponentPopClose();
	});
	
	$("#btnJoinSettingCancel").click(function(){
		joinSettingPopup_Close();
	});
	
	$("#btnJoinSettingRemove").click(function(){
		if(confirm("<spring:message code='M00074'/>")){
			removeJoinSetting();
		}	
	});
	
	$("#btnJoinSettingClose").click(function(){
		logicalComponentPopClose();
	});
	
	$("#logicalComponentPopupContainer_closebutton").off("click"); // 닫기 버튼 재정의
	$("#logicalComponentPopupContainer_closebutton").click(function(){
		joinSettingPopup_Close();
	});
}



$(document).ready(function() {
	
	joinSettingPopup_Init();
	joinSettingPopup_Handler();

});

</script>

<!-- 칼럼 콤보 박스 템플릿 -->
<%-- 2017. 7. 26. jh.kim. 컬럼명 출력 추가 --%>
<script id="selectTableColumnTmpl" type="text/x-jquery-tmpl">
	<option value="${'${'}columnMstId}" data-text="${'${'}column}">${'${'}column} {{if columnName != null && columnName != '' }}(${'${'}columnName}){{/if}}</option>
</script>

<!-- 공통 코드 콤보 박스 템플릿 -->
<script id="selectCommCodeTmpl" type="text/x-jquery-tmpl">
	<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 조인 칼럼행 템플릿 -->
<script id="joinColumnTmpl" type="text/x-jquery-tmpl">
<div id= ${'${'}joinRowId} class="row qt_border local-join-column">
	<div class="col-xs-12">
		<ifvm:input type="text" id="inputJoinColumnId"/>
		<ifvm:input type="text" id="inputTempJoinColumnId"/>
		<ifvm:input type="text" id="inputLeftTblRelId"/>
		<ifvm:input type="text" id="inputRightTblRelId"/>

		<div class="col-xs-2 control_content">
			<div class="lgc_flex_btn_area">
				<!-- Column Add --> 
				<button id="btnColumnJoinAdd" class="lgcItemPlusBtn">
					<img src="<ifvm:image name='btn_plus'/>" alt="" />
				</button>
				<!-- Column Remove -->
				<button id="btnColumnJoinRemove" class="lgcItemMinusBtn">
					<img src="<ifvm:image name='btn_minus'/>" alt="" />
				</button>
			</div>
		</div>
		<!-- Left Table Column --> 
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="selectLeftTableColumn"/>
			</div>
		</div>
		<!-- Join Oprt Code -->
		<div class="col-xs-2 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="selectColumnJoinOrptCd"/>
			</div>
		</div>
		<!-- Right Table Column -->
		<div class="col-xs-4 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="selectRightTableColumn"/>
			</div>
		</div>
	</div>
</div>
</script>

<div id="contentTypeArea">
	<div class="pop_inner_wrap">
		<div class="form-horizontal underline">
			<div class="row qt_border store_content_top">
				<!-- 구분 -->
				<div class="col-xs-12">
					<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00690"/></label>
					<div class="col-xs-10 control_content">
						<div class="input-group">
							<ifvm:input type="radio" names="joinTypeCd" values="INNER"/> Inner   
							<ifvm:input type="radio" names="joinTypeCd" values="LEFT OUTER"/> Left Outer   
							<ifvm:input type="radio" names="joinTypeCd" values="RIGHT OUTER"/> Right Outer   
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-horizontal">
			<div class="row qt_border store_content_top">
			</div>
			<!-- 테이블명 -->
			<div class="row qt_border store_content_top">
				<div class="col-xs-6"> 
					<label class="col-xs-4 control-label"><spring:message code="M01154"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="text" id="inputLeftTableName" readonly="true" disabled="true"/>
						</div>
					</div>
				</div>
				<div class="col-xs-6"> 
					<label class="col-xs-4 control-label"><spring:message code="M01154"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="text" id="inputRightTableName" readonly="true" disabled="true"/>
						</div>
					</div>
				</div>
			</div>
			<!-- 테이블 Alias -->
			<div class="row qt_border store_content_top">
				<div class="col-xs-6"> 
					<label class="col-xs-4 control-label"><spring:message code="M01447"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="text" id="inputLeftTableAlias" readonly="true" disabled="true"/>
						</div>
					</div>
				</div>
				<div class="col-xs-6"> 
					<label class="col-xs-4 control-label"><spring:message code="M01447"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="text" id="inputRightTableAlias" readonly="true" disabled="true"/>
						</div>
					</div>
				</div>
			</div>
			<div id="joinColumnList" class="row qt_border store_content_top">
				
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<button id="btnJoinSettingSave" class="btn btn-sm btn_gray">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137"/>
		</button>
		<button id="btnJoinSettingCancel" class="btn btn-sm btn_lightGray2 cancel">     
			<spring:message code="M00171"/>
		</button>
        <button id="btnJoinSettingRemove" class="btn btn-sm btn_gray">
        	<i class="fa fa-minus"></i>
			<spring:message code="M00165" />
        </button>
		<button id="btnJoinSettingClose" class="btn btn-sm btn_lightGray2 cancel">
			<spring:message code="M00441" />
        </button>
	</div>
</div>