<%@page trimDirectiveWhitespaces="true" %>
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
// Calculate Buffer Array
var calDtlHis = new Array();
// Button Disable Option Object
var btnCalculDisabledOption = {
		 column : true
		,symbol : true
		,back   : true
		,init   : true
		,braceOpen  : true
		,braceClose : true
	};

//필드 팝업 데이터 가져오기 
function getFieldSetting() {
	var curData = curContextMenuTarget.data;
	
	var nodeText = $("#txtFieldName").val();
	var tempId = $.ifvmGetRowID();
	var fieldObj = {
			 id : tempId
			,parentId : curData.id
			,text : nodeText
			,hasChild : false
			,extended : false
			,atribGroupId : curData.id
			,attributeGroupColumnId : ""
			,tempAttributeGroupColumnId : tempId
			,dpNm : nodeText
			,seq : ""
			,lgcCompId : lgcCompData.lgcCompId
			,lgcCompTblRelId : ""
			,tblAliasColNm : ""
			,colId : ""
			,dimColId : ""
			,calDtl : $("#txtAreaCalDtl").text()
			,calDtlHis : JSON.stringify(calDtlHis)
			,calColYn : "1"
			,segKeyYn : "0" 
			,colType : "C"
		}
	return fieldObj;
}

//필드 팝업 데이터 가져오기 
function getFieldSettingForModify() {
	var curData = curContextMenuTarget.data;
	
	var nodeText = $("#txtFieldName").val();
	var fieldObj = {
			 id : curData.id
			,parentId : curData.parentId
			,text : nodeText
			,hasChild : false
			,extended : false
			,atribGroupId : curData.id
			,attributeGroupColumnId : curData.attributeGroupColumnId
			,tempAttributeGroupColumnId : curData.tempAttributeGroupColumnId
			,dpNm : nodeText
			,seq : ""
			,lgcCompId : lgcCompData.lgcCompId
			,lgcCompTblRelId : curData.lgcCompTblRelId
			,tblAliasColNm : ""
			,colId : curData.colId
			,dimColId : ""
			,calDtl : $("#txtAreaCalDtl").text()
			,calDtlHis : JSON.stringify(calDtlHis)
			,calColYn : "1"
			,segKeyYn : "0" 
			,colType : "C"
		}
	return fieldObj;
}

// 필드 팝업 수정일 때 
function setFieldSetting(fieldObj) {
	
	setTableSelectCombo();
	setColumnSelectCombo();
	
	if(fieldObj !== undefined && fieldObj !== null){
		$("#txtFieldName").val(fieldObj.text);
		$("#txtAreaCalDtl").text(fieldObj.calDtl);
		calDtlHis = JSON.parse(fieldObj.calDtlHis);
		
		var lastCalType = (calDtlHis.length > 0) ? calDtlHis[calDtlHis.length-1].type : "INIT";
		setCalculBtnDisable(lastCalType);
	}
}

// 필수값 체크
function checkFieldData(){
	var nodeText = $("#txtFieldName").val();
	// 필드 텍스트 체크
	if(nodeText === ""){
		alert("<spring:message code='M01508'/>");
		return false;
	}
	
	// 필드명 중복 체크
	var isExistsName = false;
	var treeObj = $("#attributeTree").data("ejTreeView");
	treeObj.dataSource().forEach(function(node){
		if(node.colType === "C"){
			if(node.text === nodeText){
				isExistsName = true;
			}
		}
	});
	if(isExistsName){
		alert("<spring:message code='M01468'/>");
		return false;
	}
	
	return true;
}

// kj.kang 추가 :: 수정일 때 다른 체크.
function checkFieldDataForModify(){
	var nodeText = $("#txtFieldName").val();
	var curTargetId = curContextMenuTarget.data.id;
	
	// 필드 텍스트 체크
	if(nodeText === ""){
		alert("<spring:message code='M01508'/>");
		return false;
	}
	
	// 필드명 중복 체크
	var isExistsName = false;
	var treeObj = $("#attributeTree").data("ejTreeView");
	treeObj.dataSource().forEach(function(node){
		if(node.colType === "C"){
			if(node.text === nodeText && node.id !== curTargetId){
				isExistsName = true;
			}
		}
	});
	if(isExistsName){
		alert("<spring:message code='M01468'/>");
		return false;
	}
	
	return true;
}

// 필드를 트리에 추가
function addFieldSetting() {

	if(!checkFieldData()){
		return;
	}
	
	if(!checkAttributeCalField()){
		return;
	}
	
	var newFieldObj = getFieldSetting();
	
	// 가장 첫번째 컬럼의 colId와 tblRelId를 넣음
	// -> 변환필드는 실제 데이터 활용에 쓰이지 않으나 테이블에 필수 값이므로 더미 데이터처럼 넣는 것
	for(var i=0; i<calDtlHis.length; i++){
		var item = calDtlHis[i];
		if(item.type === "COLUMN"){
    		newFieldObj.lgcCompTblRelId = item.tblRelId;
    		newFieldObj.colId = item.colId;
    		break;
    	}		
	}
	
	// 저장
	var targetTree = $("#attributeTree").data("ejTreeView");
	targetTree.dataSource().push(newFieldObj);
	targetTree.refresh();
	
	logicalComponentPopClose();
}

//필드 수정 내용을 트리에 넣음
function editFieldSetting() {

	if(!checkFieldDataForModify()){
		return;
	}
	
	// 저장 로직 처리
	var newFieldObj = getFieldSettingForModify();
	
	var treeObj = $("#attributeTree").data("ejTreeView");
	var treeData = treeObj.getTreeData();
	treeData[curContextMenuTarget.dataIndex] = newFieldObj;
	treeObj.dataSource(treeData);
	treeObj.refresh();
	
	logicalComponentPopClose();
}

// Calcul Click Handling
function btnCalculCilckHandler(type, val, colId, tblRelId, tblNmAlias){
	// TYPE : BACK, INIT, COLUMN, SYMBOL, BRACE_OPEN, BRACE_CLOSE
	
	var colId1 = (colId === undefined) ? "" : colId;
	var tblRelId1 = (tblRelId === undefined) ? "" : tblRelId;
	var tblNmAlias1 = (tblNmAlias === undefined) ? "" : tblNmAlias;
	
	// Text And Buffer Handle
	setFieldExpression(type, val, colId1, tblRelId1, tblNmAlias1);
	
	// Button Enable Handle
	setCalculBtnDisable(type);
	
	// kj.kang 추가 :: 연산자 추가 시, 필드값 초기화
	if(type != "COLUMN") {
		resetSelectFiled();
	}
}

// Set Field Expression Text And Buffer
function setFieldExpression(type, val, colId, tblRelId, tblNmAlias) {
	
	// Set Buffer
	if(type === "BACK"){
		var newBuffer = new Array();
		calDtlHis.forEach(function(item, idx, arr){
			if(calDtlHis.length-1 !== idx){
				newBuffer.push(calDtlHis[idx]);
			}
		});
		calDtlHis = newBuffer;
	}
	else if(type === "INIT"){
		calDtlHis = new Array();
	} 
	else {
		var calculObj = {
			type : type
			,val : val
			,colId : colId
			,tblRelId : tblRelId
			,tblNmAlias : tblNmAlias
		}
		calDtlHis.push(calculObj);
	}

	// Set Text
	var text = "";
	calDtlHis.forEach(function(item, idx, arr){
		text += " "+item.val;
	});

	$("#txtAreaCalDtl").text(text);
}

// Set Calculate Button Disable 
function setCalculBtnDisable(type){
	
	if(type === "COLUMN") {
		btnCalculDisabledOption = {
				 column : true
				,symbol : false
				,back   : false
				,init   : false
				,braceOpen  : true
				,braceClose : getBraceCloseDisable()
			}
	}
	else if(type === "SYMBOL") {
		btnCalculDisabledOption = {
				 column : false
				,symbol : true
				,back   : false
				,init   : false
				,braceOpen  : false
				,braceClose : true
			}
	} 
	else if(type === "BACK") {
		// Back 버튼은 재처리
 		if(calDtlHis.length === 0){
			setCalculBtnDisable("INIT");
		} else {
			setCalculBtnDisable(calDtlHis[calDtlHis.length-1].type);
		} 
	} 
	else if(type === "BRACE_OPEN") {
		btnCalculDisabledOption = {
				 column : false
				,symbol : true
				,back   : false
				,init   : false
				,braceOpen  : false
				,braceClose : getBraceCloseDisable()
			}
	} 
	else if(type === "BRACE_CLOSE") {
		btnCalculDisabledOption = {
				 column : true
				,symbol : false
				,back   : false
				,init   : false
				,braceOpen  : true
				,braceClose : getBraceCloseDisable()
			}
	}
	else if(type === "INIT") {
		btnCalculDisabledOption = {
				 column : false
				,symbol : true
				,back   : true
				,init   : true
				,braceOpen  : false
				,braceClose : true
			}
	}
	
	// Button Disabled
	$("select[name=local-type-column]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.column);
	});
 	$("button[name=local-type-symbol]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.symbol);
	});
 	$("button[name=local-type-brace-open]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.braceOpen);
	});
	$("button[name=local-type-brace-close]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.braceClose);
	});
	$("button[name=local-type-back]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.back);
	});
	$("button[name=local-type-init]").each(function(){
		$(this).attr("disabled", btnCalculDisabledOption.init);
	});
	// Button Disabled
}

// Brace Open - Close Check
function getBraceCloseDisable(){
	
	// Brace Open and Close Count
	var openCnt = 0, closeCnt = 0;
	for(var i=0; i<calDtlHis.length; i++){
		if(calDtlHis[i].type === "BRACE_OPEN"){
			openCnt++;	
		} else if(calDtlHis[i].type === "BRACE_CLOSE"){
			closeCnt++;			
		}
	}
	var rtnVal = (openCnt > closeCnt) ? false : true;
	
	// Latest Brace Open Check
	rtnVal = (calDtlHis[calDtlHis.length-1].type === "BRACE_OPEN") ? true : rtnVal;
		
	return rtnVal;
}


// 테이블 콤보 리스트
function setTableSelectCombo(){
	// Table Select Setting
	$("#selectTmpl").tmpl(leftAttributeTreeData).appendTo("#selectFieldTable");
}

// 칼럼 콤보 리스트
function setColumnSelectCombo(){
	
	var colComboId = "selectFieldColumn";
	
	var slctedVal = $("#selectFieldTable :selected").val();
	if(slctedVal !== null && slctedVal !== ""){
		$("#selectFieldColumn").prop("disabled", "");
		
		var columnList = new Array();
		columnList.push({id: "", text:""});
		
		leftAttributeTreeData.forEach(function(item, index){
			if(slctedVal === item.id){
				
				// MEASURE 값만 발라냄.
				item.treeList.forEach(function(treeNode, treeNodeIndex){
					if(treeNode.colTypeCd === "MEASURE"){
						columnList.push(treeNode);
					}
				});
			}
		});
		$("#"+colComboId).html("");
		$("#selectTmpl").tmpl(columnList).appendTo("#"+colComboId);
		$("#"+colComboId).prop("selected", "");
		
	} else {
		$("#selectFieldColumn").prop("disabled", "true");
	}

}

function logicalComponentFieldSettingPop_Init() {
	var curMode = '<%= cleanXss(request.getParameter("mode")) %>'
	if(curMode === "NEW"){
		setCalculBtnDisable("INIT");
		setFieldSetting();
		
		$("#btnFieldSave").show();
		$("#btnFieldModify").hide();
		$("#btnFieldRemove").hide();
	} else {
		setCalculBtnDisable("INIT");
		setFieldSetting(curContextMenuTarget.data);
		
		$("#btnFieldSave").hide();
		$("#btnFieldModify").show();
		$("#btnFieldRemove").show();
	}
}


function logicalComponentFieldSettingPop_Handler() {
	// 연산자 버튼 +
	$("#btnPlus").click(function(){
		btnCalculCilckHandler("SYMBOL", "+");
	});
	
	// 연산자 버튼 -
	$("#btnMinus").click(function(){
		btnCalculCilckHandler("SYMBOL", "-");
	});
	
	// 연산자 버튼 *
	$("#btnMutiply").click(function(){
		btnCalculCilckHandler("SYMBOL", "*"); //×
	});
	
	// 연산자 버튼 /
	$("#btnDivine").click(function(){
		btnCalculCilckHandler("SYMBOL", "/"); //÷
	});
	
	// 연산자 버튼 (
	$("#btnOpenBrace").click(function(){
		btnCalculCilckHandler("BRACE_OPEN", "(");
	}); 
		
	// 연산자 버튼 )
	$("#btnCloseBrace").click(function(){
		btnCalculCilckHandler("BRACE_CLOSE", ")");
	});
	
	// 연산자 버튼 <-
	$("#btnBackspace").click(function(){
		btnCalculCilckHandler("BACK", "");
	}); 
	
	// 연산자 버튼 C
	$("#btnInitiate").click(function(){
		btnCalculCilckHandler("INIT", "");
	});
	
	// 연산자 버튼 +
	$("#selectFieldTable").change(function(){
		setColumnSelectCombo();
	});
	
	// 필드 콤보 박스
	$("#selectFieldColumn").change(function(){
		var tblId = $("#selectFieldTable :selected").val();
		var colId = $("#selectFieldColumn :selected").val();
		var tblNmAlias = "";
		
		var columnName = "";
		leftAttributeTreeData.forEach(function(item, index){
			if(item.id === tblId){
				item.treeList.forEach(function(curCol, indexCol){
					if(curCol.id === colId){
						columnName = curCol.tblAliasColNm;
					}
				});
				
				tblNmAlias = item.tblNmAlias;
			}
		});
		
		
		btnCalculCilckHandler("COLUMN", columnName, colId, tblId, tblNmAlias);
	});
	
	// 저장
	$("#btnFieldSave").click(function(){
		addFieldSetting();
	});
	
	// 저장(수정)
	$("#btnFieldModify").click(function(){
		editFieldSetting();
	});
	
	// 취소
	$("#btnFieldCancel").click(function(){
		logicalComponentPopClose();
	});
	
	// 삭제
	$("#btnFieldRemove").click(function(){
		if(confirm("<spring:message code='M00074'/>")){
			var treeObj = $("#attributeTree").data("ejTreeView");
			treeObj.removeNode(curContextMenuTarget.data.id);
			var treeData = treeObj.getTreeData();
			treeObj.dataSource(treeData);
			treeObj.refresh();
			treeObj.expandAll();
			logicalComponentPopClose();
		}
	});
}

// 변환 필드 동작 여부 확인을 위한 실행 테스트
function checkAttributeCalField(){
	
	// 스키마명.테이블명 약어 형식의 데이터를 리스트에 담음 
	var tblNmAliasList = new Array();
	calDtlHis.forEach(function(item){
		if(item.type === "COLUMN"){
			// 중복 데이터 제외를 위한 for문
			var isExists = false;
			tblNmAliasList.forEach(function(tblNmAlias){
				if(tblNmAlias === item.tblNmAlias){
					isExists = true;
				} else {
					isExists = false;
				}
			});
			
			if(!isExists){
				tblNmAliasList.push(item.tblNmAlias);	
			} 
		}
	});
	
	var reqDto = {
		 lgcCompId : lgcCompData.lgcCompId
		,calDtl : $("#txtAreaCalDtl").text()
		,dbInformId : lgcCompData.dbInformId
		,tblNmAliasList : tblNmAliasList
	};
	
	var isSuccess = false;
	$.ifvSyncPostJSON(
		'<ifvm:action name="checkAttributeCalField"/>'
	    ,reqDto
		,function(result) {
			isSuccess = true;
         }
		,function(result) {
			isSuccess = false;
			alert(convertMessage(result.message));
         }
    );
	
	return isSuccess;
}

function resetSelectFiled() {
	$("#selectFieldColumn").val("");
}

$(document).ready(function(){
	
	logicalComponentFieldSettingPop_Init();
	logicalComponentFieldSettingPop_Handler();

});
</script>

<script id="selectTmpl" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>

<div id="contentTypeArea">
	<div class="pop_inner_wrap">
		<div class="form-horizontal underline">
			<div class="row qt_border store_content_top">
				<!-- 필드명 -->
				<div class="col-xs-12">
					<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01231"/></label>
					<div class="col-xs-10 control_content">
						<div class="input-group">
							<ifvm:input type="text" id="txtFieldName" maxLength="25" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-horizontal">
			<div class="row qt_border store_content_top">
			</div>
			<div class="row qt_border store_content_top">
				<!-- 테이블 -->
				<div class="col-xs-6"> 
					<label class="col-xs-4 control-label"><spring:message code="M01175"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="select" id="selectFieldTable" names="local-type-column"/>
						</div>
					</div>
				</div>
				<!-- 필드 -->
				<div class="col-xs-6">
					<label class="col-xs-4 control-label"><spring:message code="M01442"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifvm:input type="select" id="selectFieldColumn" names="local-type-column"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row qt_border store_content_top">
				<!-- 연산자 -->
				<div class="col-xs-12">
					<label class="col-xs-2 control-label"><spring:message code="M01463"/></label>
					<div class="col-xs-10 control_content">
						<button id="btnPlus" class="btn_field_white" name="local-type-symbol" objCode="lgcFbtnPlus_OBJ">
							<img src="<ifvm:image name='icon_plus_gray'/>" alt="" />
						</button>
						<button id="btnMinus" class="btn_field_white" name="local-type-symbol" objCode="lgcFbtnMinus_OBJ">
							<img src="<ifvm:image name='icon_minus_gray'/>" alt="" />
						</button>
						<button id="btnMutiply" class="btn_field_white" name="local-type-symbol" objCode="lgcFbtnMutiply_OBJ">
							<img src="<ifvm:image name='icon_multiply_gray'/>" alt="" />
						</button>
						<button id="btnDivine" class="btn_field_white" name="local-type-symbol" objCode="lgcFbtnDivine_OBJ">
							<img src="<ifvm:image name='icon_division_gray'/>" alt="" />
						</button>
						<button id="btnOpenBrace" class="btn_field_white" name="local-type-brace-open" objCode="lgcFbtnOpenBrace_OBJ">
							<img src="<ifvm:image name='icon_bracket_left_gray'/>" alt="" />
						</button>
						<button id="btnCloseBrace" class="btn_field_white" name="local-type-brace-close" objCode="lgcFbtnCloseBrace_OBJ">
							<img src="<ifvm:image name='icon_bracket_right_gray'/>" alt="" />
						</button>
						<button id="btnBackspace" class="btn_field_white" name="local-type-back" objCode="lgcFbtnBackspace_OBJ">
							<img src="<ifvm:image name='icon_backspace_gray'/>" alt="" />
						</button>
						<button id="btnInitiate" class="btn_field_white" name="local-type-init" objCode="lgcFbtnInitiate_OBJ">
							<img src="<ifvm:image name='icon_c_gray'/>" alt="" />
						</button>
					</div>
				</div>
			</div>
			<div class="row qt_border store_content_top">
				<!-- 변환식 -->
				<div class="col-xs-12">
					<label class="col-xs-2 control-label"><spring:message code="M01464"/></label>
					<div class="col-xs-10 control_content">
						<div class="input-group">
							<ifvm:input type="textarea" id="txtAreaCalDtl" readonly="true" disabled="true" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<button id="btnFieldSave" class="btn btn-sm btn_gray" objCode="lgcFbtnFieldSave_OBJ">
			<i class="glyphicon glyphicon-check"></i>   
			<spring:message code="M00137"/>
		</button>
		<button id="btnFieldModify" class="btn btn-sm btn_gray" objCode="lgcFbtnFieldModify_OBJ">
			<i class="glyphicon glyphicon-check"></i>   
			<spring:message code="M00259"/>
		</button>
		<button id="btnFieldRemove" class="btn btn-sm btn_lightGray2 cancel" objCode="lgcFbtnFieldRemove_OBJ">  
			<i class="fa fa-minus"></i>   
			<spring:message code="M00275"/>
		</button>
		<button id="btnFieldCancel" class="btn btn-sm btn_lightGray2 cancel"objCode="lgcFbtnFieldCancel_OBJ">
			<spring:message code="M00171"/>
		</button>
	</div>
</div>