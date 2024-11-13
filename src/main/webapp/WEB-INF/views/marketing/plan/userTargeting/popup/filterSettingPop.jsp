<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var filterBtn;
var filterSetPopGrid; 
var storeArray = [];
var defFilterFlag = false;
var groupFlag = false;

var cursorFlag = "";


function filterBtn(_this){
	filterBtn = _this;
}

//그룹함수 조건 목록 조회
function groupCondition(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_TARGET_SERC_OPRT_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#groupFuncCommStatustemp").tmpl(result.rows);
		$("#fcon2_notUsed").append(temp);
	});
	
}


//그룹함수 선택 시 필드 리스트 조회
function getGroupFunction(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getGroupFieldList"/>',{filterId : filterId}
	,function(result) {
		
		var temp = $("#groupFieldListTemp").tmpl(result.rows);
		$("#groupNm_notUsed").children().remove();
		$("#groupNm_notUsed").append(temp);
		
	});
}


//필터 상세 조회
function getFilter(){
		$.ifvSyncPostJSON('<ifvm:action name="getFieldvalue"/>',{filterId : filterId}
		,function(result) {
			
			
			var filterValue = "";
			var filterKeycode = "";
			
			for(var i=0; i<result.length; i++){
				
				/* if(result[i].groupFuncType != null && result[i].groupFuncType.length > 0){
					
					//그룹 조회
					$("#groupNm").val(result[i].groupFuncType);
					$("#fcon2").val(result[i].criteriaType);
					$("#fValue2").val(result[i].filterValue);
					//obj.groupfilterKeycode = $("#fValue2").text();
					
					
				}
				else{ */
					
					if(result[i].groupFuncType != null && result[i].groupFuncType.length > 0){
						$("#groupNm").val(result[i].groupFuncType);
					}
					
					if(result[i].criteriaType == "BETWEEN"){
						$("#between").show();
					}
					
					if(result[i].criteriaType =="CUSTDTDEF"){
						
						//사용자날짜정 일 경우 그리드 출력
						//filterDefSetPopGrid();
						defFilterFlag = true;
						
					}
					else{
						defFilterFlag = false;
					}
					
					$("#fcon").val(result[i].criteriaType);
					$("#andValue").val(result[i].filterAttrib1);
					
					if(i == result.length-1){
						//필터 조회
						filterValue += result[i].filterValue;
					}
					else{
						//필터 조회
						filterValue += result[i].filterValue + ",";
					}
					
					if(i == result.length-1){
						//필터코드 조회
						filterKeycode += result[i].filterKeycode;
					}
					else{
						//필터코드 조회
						filterKeycode += result[i].filterKeycode + ",";
					}
					
					
				//}
				
				
				
				
				
				
				
				
				
					//그룹함수일 경우 조회
					if(result[i].groupFuncType != null && result[i].groupFuncType != ""){
						
						
						if($("#groupNm_notUsed").val() == null){
							//필드 목록 조회
							getGroupFunction();
						}
						
						if($("#fcon2_notUsed").val() == null){
							//필드 조건 조회
							groupCondition();
						}
						
						
						$("#groupArea").show();
						$("#groupNm_notUsed").val(result[i].groupFuncFieldId);
						$("#fcon2_notUsed").val(result[i].groupFuncCriteriaType);
						
						
						if(result[i].groupFuncCriteriaType == "BETWEEN"){
							$("#between2").show();
							$("#andValue2_notUsed").val(result[i].groupFuncValueSub);
							$("#fValue2_notUsed").val(result[i].groupFuncValue);
						}
						else if(result[i].groupFuncCriteriaType == "CUSTDTDEF"){
							
							$("#fValue2_notUsed").text(result[i].groupFuncValue);
							$("#fValue2_notUsed").val(result[i].groupDefValue);
							defFilterFlag = true;
							
						}
						else{
							$("#fValue2_notUsed").val(result[i].groupFuncValue);
						}
					}
					
					
					
					
					
					
					
				
			}
			
			if(filterValue != null && filterValue.length > 0 && filterValue != 'null'){
				$("#fValue").val(filterValue);
			}
			
			if(filterKeycode!= null && filterKeycode.length > 0 && filterKeycode != 'null'){
				$("#fValue").text(filterKeycode);
			}
			
			
		});
		
		if(defFilterFlag){
			filterDefSetPopGrid();
		}
}


//타겟 테이블 컬럼 저장
function setFillter(){
	
	var obj = {};
	validation = $("#FormArea").ifvValidation();
	
	if(validation.confirm()){
		
		var fieldId = selectedFilterId.split("_")[0];
		
		//andor 조회
		if($("#" + selectedFilterId).find('select').eq(0).val() == '1'){
			obj.andOr = 'AND';
		}
		else{
			obj.andOr = 'OR';
		}
		
		//필터 순서 조회
		obj.filterSeq = selectedFilterId.split("_")[1].split('temp')[1];
		
		/* for(var i=1; i<=$("#fieldSelectArea").children().find('li').length; i++){
			
			if(selectedFilterId == $("#fieldSelectArea").children().find('li').eq(i).attr('id')){
				obj.filterSeq = i;
			}
		} */
		
		//세그먼트 아이디 저장
		obj.segmentId = confilterid;
		

		//필터 저장
		obj.criteriaType = $("#fcon").val();
		obj.filterValue = $("#fValue").val();
		
		
		var splitValue = "";
		
		if($("#fcon").val() == "CUSTDTDEF"){
			
			if($("#fValue").text() != 'null' && $("#fValue").text() != ''){
				
				var splitFilter = $("#fValue").val().split(',');
				
				for(var i=0; i<splitFilter.length; i++){
					
					for(var k=0; k<filterSetPopGrid.getRowData().length; k++){
						
						if(splitFilter[i] == filterSetPopGrid.getRowData()[k].vName){
							
							if(k==filterSetPopGrid.getRowData().length){
								splitValue += filterSetPopGrid.getRowData()[k].keyCode;
							}
							else{
								splitValue += filterSetPopGrid.getRowData()[k].keyCode + ",";
							}
							
						}
					}
				}
				
				if(splitValue != "" && splitValue.length > 0){
					obj.filterKeycode = splitValue;
				}
				
				//obj.filterKeycode = $("#fValue").text();
			}
			
		}
		else{
			
			if($("#fValue").text() != 'null' && $("#fValue").text() != ''){
				
				var splitFilter = $("#fValue").val().split(',');
				
				for(var i=0; i<splitFilter.length; i++){
					
					for(var k=0; k<filterSetPopGrid.getRowData().length; k++){
						
						if(splitFilter[i] == filterSetPopGrid.getRowData()[k].VNAME){
							
							if(k==filterSetPopGrid.getRowData().length){
								splitValue += filterSetPopGrid.getRowData()[k].keyCode;
							}
							else{
								splitValue += filterSetPopGrid.getRowData()[k].keyCode + ",";
							}
							
						}
					}
				}
				
				if(splitValue != "" && splitValue.length > 0){
					obj.filterKeycode = splitValue;
				}
				
				//obj.filterKeycode = $("#fValue").text();
			}
			
		}
		
		
		obj.filterAttrib1 =  $("#andValue").val();
		obj.fieldId = fieldId;
		
		if(filterId != null && filterId.length > 0){
			obj.filterId = filterId;
		}
		
		//그룹 저장
		if($("#groupNm").val() != "NOTUSED"){
			obj.groupFuncType = $("#groupNm").val();
		}
		obj.groupcriteriaType = $("#fcon2").val();
		obj.groupfilterValue = $("#fValue2").val();
		obj.groupfilterKeycode = $("#fValue2").text();
		//obj.groupfilterAttrib1 =  $("#between2").text();
		
		
		
		var isValid = true; 
		
		if($("#fcon").val() != 'IN' && $("#fcon").val() != 'NOT IN'){
			
			var stringRegx = /,/gi; 
			
			if(stringRegx.test($("#fValue").val())) { 
			isValid = false; 
			} 
			  
		}
		
		
		
		//그룹함수 일 경우 그룹 조건을 저장
		if($("#groupNm").val() != "NOTUSED"){
			obj.groupFuncFieldId = $("#groupNm_notUsed").val();
			obj.groupFuncCriteriaType = $("#fcon2_notUsed").val();
			
			if("CUSTDTDEF" == $("#fcon2_notUsed").val()){
				obj.groupFuncValue = $("#fValue2_notUsed").text();
			}
			else if("BETWEEN" != $("#fcon2_notUsed").val()){
				obj.groupFuncValue = $("#fValue2_notUsed").val();
			}
			else{
				obj.groupFuncValue = $("#fValue2_notUsed").val();
				obj.groupFuncValueSub = $("#andValue2_notUsed").val();
			}
			
			if($("#fcon2_notUsed").val() != 'IN' && $("#fcon2_notUsed").val() != 'NOT IN'){
				
				var stringRegx = /,/gi; 
				
				if(stringRegx.test($("#fValue2_notUsed").val())) { 
				isValid = false; 
				} 
				  
			}
			
		}
		
		//장용 - 2016-03-30 그룹함수 추가
    	if($("#groupNm").val() != "NOTUSED"){
    		$("#" + selectedFilterId).find('p').attr('groupVal', 1);
    	}
    	else{
    		$("#" + selectedFilterId).find('p').attr('groupVal', 0);
    	}
		
		//그룹함수 체크
		var chkVal = checkGroupFunc();
		
		if(chkVal){
			
			if(isValid){
				
				$.ifvSyncPostJSON('<ifvm:action name="setFilterValue"/>',obj
				,function(result) {
					
					//필터 조건  셋팅
					if($("#fcon").val() != "BETWEEN"){
						var conditionValue = $("#fcon").val() + "  " + $("#fValue").val();
						$("#" + selectedFilterId).find('p').text(conditionValue);
					}
					else{
						var conditionValue = $("#fcon").val() + "  " + $("#fValue").val() + " AND " + $("#andValue").val();
						$("#" + selectedFilterId).find('p').text(conditionValue);
					}
					
					//장용 - 2016-03-30 그룹함수 추가
		        	if($("#groupNm").val() != "NOTUSED"){
		        		$("#" + selectedFilterId).find('p').text( "[" + $("#groupNm").val() + "]" + " " + $("#" + selectedFilterId).find('p').text());
		        		$("#" + selectedFilterId).find('p').attr('groupVal', 1);
		        	}
		        	else{
		        		$("#" + selectedFilterId).find('p').attr('groupVal', 0);
		        	}
					
					//필터 아이디 셋팅
					$("#" + selectedFilterId).attr("filterId", result.message);
					alert('<spring:message code="M00623"/>');
					//userTargetingPopClose();
					
					userTargetingPopClose();
				});
				
			}
			else{
				alert('<spring:message code="M01210"/>');
			}
			
		}
		else{
			$("#" + selectedFilterId).find('p').attr('groupVal', 0);
			alert('<spring:message code="M01388"/>');
		}
		
		
		//저장 성공시 필터설정 버튼 변경
		filterSetBtnUI(filterBtn);
	}	
}


//타겟 테이블 컬럼 수정
function modifyFillter(){
	 var obj = {};

	validation = $("#FormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.criteriaType = $("#fcon").val();
		obj.filterValue = $("#fValue").val();
		obj.filterKeycode = $("#fValue").text();
		obj.fieldId = confilterid;

		$.ifvSyncPostJSON('<ifvm:action name="editFilterValue"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
		});
		
		obj.groupFuncType = $("#groupNm").val();
		obj.criteriaType = $("#fcon2").val();
		obj.filterValue = $("#fValue2").val();
		obj.fieldId = confilterid;
		
		$.ifvSyncPostJSON('<ifvm:action name="editFilterValue"/>',obj
		,function(result) {
			 alert('<spring:message code="M00624"/>');
		});
	} 
	
}


function filterSetPopGridList(){
	
	
	
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){

			data.id = selectedFilterId.split("_")[0];
			data.segmentId = confilterid;
			//data.enableNA = false;
			
			return data;
		},	
		url: '<ifvm:action name="getFieldValueList"/>',
	    colNames:[
	              '<spring:message code="M01233"/>',
/* 	              '<spring:message code="M01206"/>',
	              'code', */
	              ],
	    colModel:[
			{name:'VNAME',index:'VNAME', resizable : false}
			/* {name:'vCode',index:'valueCode', resizable : false},
			{name:'keyCode',index:'fvv.Keycode', resizable : false,hidden : true} */
	    ],
	    multiselect : true,
	    sortname: 'MEM_NM',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete2' 
	};
	filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function filterSetPopGridList(){
	
	
	
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){

			data.id = selectedFilterId.split("_")[0];
			data.segmentId = confilterid;
			//data.enableNA = false;
			
			return data;
		},	
		url: '<ifvm:action name="getFieldValueList"/>',
	    colNames:[
	              '<spring:message code="M01233"/>',
/* 	              '<spring:message code="M01206"/>',
	              'code', */
	              ],
	    colModel:[
			{name:'VNAME',index:'VNAME', resizable : false}
			/* {name:'vCode',index:'valueCode', resizable : false},
			{name:'keyCode',index:'fvv.Keycode', resizable : false,hidden : true} */
	    ],
	    multiselect : true,
	    sortname: 'MEM_NM',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete2' 
	};
	filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function filterDefSetPopGridUserDef(){
	
	
	
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},	
		url: '<ifvm:action name="getFieldDefValue"/>',
	    colNames:[
				  '<spring:message code="M01233"/>',
	              '<spring:message code="M01206"/>',
	              'code',
	              ],
	    colModel:[
			{name:'vCode',index:'code_Name', resizable : false},
			{name:'vName',index:'mark_name', resizable : false},
			{name:'keyCode',index:'id', resizable : false,hidden : true}
	    ],
	    multiselect : true,
	    sortname: 'seq',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete2'
	};
	filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function filterDefSetPopGrid(){
	
	
	
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},	
		url: '<ifvm:action name="getFieldDefValue"/>',
		colNames:[
				  '<spring:message code="M01233"/>',
	              '<spring:message code="M01206"/>',
	              'code',
	              ],
	    colModel:[
			{name:'vCode',index:'code_Name', resizable : false},
			{name:'vName',index:'mark_name', resizable : false},
			{name:'keyCode',index:'id', resizable : false,hidden : true}
	    ],
	    multiselect : true,
	    sortname: 'seq',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete2'
	};
	filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function selectOptionList() {
	
	
	
	var checkedList = filterSetPopGrid.getCheckedList();
	var textStore = null;
	var listFlowIdList = [];
	var temp = null;

	for( var i = 0; i < checkedList.length; i++ ){
		if(textStore == null){
			textStore = checkedList[i].VNAME;
			
			if(textStore == null || textStore.length == 0){
				textStore = checkedList[i].vName;
			}
			
			temp = checkedList[i].keyCode; 
		}
		else{
		
			if(checkedList[i].VNAME != null && checkedList[i].VNAME.length > 0){
				textStore = textStore + ',' + checkedList[i].VNAME;
			}
			else{
				textStore = textStore + ',' + checkedList[i].vName;
			}
			
		    temp = temp + ',' + checkedList[i].keyCode;
		}
	}
	
	if(groupFlag == false){
		
		if(cursorFlag != "1" && cursorFlag != "0"){
			
			if(textStore != null){
				
				if($("#andValue").val() != ''){
					$("#andValue").val($("#andValue").val() + "," + textStore);
				}
				else{
					$("#andValue").val(textStore);
				}
				
			}
				
			if(temp != null){
				
				if($("#fValue").text() != ''){
					$("#fValue").text($("#fValue").text() + "," + temp);
				}
				else{
					$("#fValue").text(temp);
				}
			
			}
			
		}
		else{
			
			if(textStore != null){
				
				if($("#fValue").val() != ''){
					$("#fValue").val($("#fValue").val() + "," + textStore);
				}
				else{
					$("#fValue").val(textStore);
				}
				
			}
				
			if(temp != null){
				
				if($("#fValue").text() != ''){
					$("#fValue").text($("#fValue").text() + "," + temp);
				}
				else{
					$("#fValue").text(temp);
				}
			
			}
		}
		
	}
	else{
		
		if(cursorFlag != "3"){
			
			if($("#andValue2_notUsed").val() != ''){
				$("#andValue2_notUsed").val($("#andValue2_notUsed").val() + "," + textStore);
			}
			else{
				$("#andValue2_notUsed").val(textStore);
			}
			
			if(temp != null){
				
				if($("#andValue2_notUsed").text() != ''){
					$("#andValue2_notUsed").text($("#andValue2_notUsed").text() + "," + temp);
				}
				else{
					$("#andValue2_notUsed").text(temp);
				}
				
			}
			
		}
		else{
			
			if($("#fValue2_notUsed").val() != ''){
				$("#fValue2_notUsed").val($("#fValue2_notUsed").val() + "," + textStore);
			}
			else{
				$("#fValue2_notUsed").val(textStore);
			}
			
			if(temp != null){
				
				if($("#fValue2_notUsed").text() != ''){
					$("#fValue2_notUsed").text($("#fValue2_notUsed").text() + "," + temp);
				}
				else{
					$("#fValue2_notUsed").text(temp);
				}
				
			}
		}
		
		
	}
	
	
	
	filterSetPopGrid.resetChecked();
	
}

function initoption(){
	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_TARGET_SERC_OPRT_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#commStatustemp").tmpl(result.rows);
		$("#fcon").append(temp);
	});
	
	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_TARGET_SERC_OPRT_TYPE'
		, enableNA : true
	},function(result) {
		var store = []
		
		var size = result.rows.length;
		for(var i=0;i<size;i++){
			if(result.rows[i].attrib01 == "group")
			{
				var store2 = {}
				store2.codeName = result.rows[i].codeName
				store2.markName = result.rows[i].markName
				store.push(store2)
			}
		}
		
		var temp = $("#commStatustemp").tmpl(store);
		$("#fcon2").append(temp);
	});
	
}

function groupFuncList(){
	
	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEG_GROUP_CONDITION_TYPE'
		, enableNA : true
	},function(result) {
	    //그룹 미선택 추가
		var notSelect = {};
		notSelect.codeName = "NOTUSED";
		notSelect.markName = '<spring:message code="M01207"/>';
		var tempGroup = $("#commStatustemp").tmpl(notSelect);
		$("#groupNm").prepend(tempGroup);
	    
	    var temp = $("#commStatustemp").tmpl(result.rows);
		$("#groupNm").append(temp);
	});
	
}


$(document).ready(function(){
	
	//그룹 영역 숨김 
	$("#groupArea").hide();
	//필드명 셋팅
	$("#popFieldName").text(selectedFilterName);
	
	initoption();
	
	groupFuncList();
	
	if(filterId != null && filterId.length > 0){
		getFilter();
	}
	
	//취소
	$("#filterSetCancelBtn").on("click", function(){
		userTargetingPopClose();
	});
	
	//선택
	$("#selectField").on("click", function(){
		selectOptionList();
	});
	

	//취소
	$("#cancleField").on("click", function(){
		
		if(groupFlag == false){
			//$(".filter_textarea").val("");
			$("#fValue").val("");
			$("#fValue").text("");
			$("#andValue").val("");
		}
		else{
			//$(".filter_textarea").val("");
			$("#fValue2_notUsed").val("");
			$("#fValue2_notUsed").text("");
			$("#andValue2_notUsed").val("");
		}
		
		filterSetPopGrid.resetChecked();
		
	});
	 
	//취소
	$("#fcon").on("change", function(){
		
		if("BETWEEN" == $("#fcon option:selected").text()) $("#between").show();
		else{
			$("#between").hide();
			$("#between").val("");
		}
		
		
		
		if("CUSTDTDEF" == $("#fcon option:selected").val()){
			
			filterDefSetPopGridUserDef();
			groupFlag = false;
			//filterDefSetPopGrid.requestData({fType:this.value});
			
		}
		else{
			filterSetPopGridList();
			groupFlag = false;
		}
		
		
	});
	
	//취소
	$("#fcon2").on("change", function(){
		
		if("BETWEEN" == $("#fcon2 option:selected").text()) $("#between2").show();
		else{
			$("#between2").hide();
			$("#between2").val("");
		}
	});
	
	//저장
	$("#filterSetSaveBtn").on("click", function(){
		
		//필터 measure 값 체크 
		$.ifvPostJSON('<ifvm:action name="checkFilterType"/>',{fieldId : filterId}
		,function(result) {
	        
			if(result.message != null && result.message == "MEASURE"){
				
				if($("#groupNm").val() == "SUM" || $("#groupNm").val() == "AVG"){
					setFillter();
					//필터 순서 업데이트
					setFilterSeq();
				}
				else{
					alert('<spring:message code="M01647"/>');
				}
			}
			else{
				setFillter();
				//필터 순서 업데이트
				setFilterSeq();
			}
			
		}); 
		
	});
	
	//초기화 버튼
	$("#initValue").on("click", function(){
		
		$("#fValue").val("");
		$("#fValue").text("");
		$("#andValue").val("");
		
		$("#fcon").html("");
		$("#groupNm").html("");
		$("#andValue").val("");
		$("#between").hide();
		
		initoption();
		groupFuncList();
		
		var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			data.id = selectedFilterId.split("_")[0];
			data.enableNA = false;
		},	
		url: '<ifvm:action name="getFieldValueList"/>',
	    colNames:[
				  //'<spring:message code="M01206"/>',
	              '<spring:message code="M01233"/>',
	              //'code',
	              ],
	    colModel:[
			//{name:'vCode',index:'valueCode', resizable : false},
			{name:'VNAME',index:'VNAME', resizable : false},
			//{name:'keyCode',index:'fvv.keyCode', resizable : false,hidden : true}
	    ],
	    multiselect : true,
	    sortname: 'fvv.valueName',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete2'
	};
	filterSetPopGrid = $("#filterSetPopGrid").ifvGrid({ jqGridOption : jqGridOption });
		
		//filterSetPopGrid();
		
	});
	
	//조건 between일 때 and 입력창
	//$(".between_row").show();
	
	//그룹함수 선택 시 하단 노출
	$("#groupNm").on("change", function(){
		
		
		if(this.value != 'NOTUSED'){
			$("#groupArea").show();
			
			if($("#groupNm_notUsed").val() == null){
				//필드 목록 조회
				getGroupFunction();
			}
			
			if($("#fcon2_notUsed").val() == null){
				//필드 조건 조회
				groupCondition();
			}
			
			
		}
		else{
			$("#groupArea").hide();
		}
		
	});
	
	$("#fcon2_notUsed").on("change", function(){
		
		if("BETWEEN" == $("#fcon2_notUsed option:selected").text()) $("#between2").show();
		else{
			$("#between2").hide();
			$("#between2").val("");
		}
		
		
		
		if("CUSTDTDEF" == $("#fcon2_notUsed option:selected").val()){
			
			filterDefSetPopGrid();
			groupFlag = true;
			//filterDefSetPopGrid.requestData({fType:this.value});
			
		}
		
	});
	
	$("#fValue").on('click', function(){
		
		groupFlag = false;
		cursorFlag = "1";
	});
	
	$("#andValue").on('click', function(){
		
		groupFlag = false;
		cursorFlag = "2";
		
	});
	
	$("#fValue2_notUsed").on('click', function(){
		groupFlag = true;
		cursorFlag = "3";
	});
	
	$("#andValue2_notUsed").on('click', function(){
		
		groupFlag = true;
		cursorFlag = "4";
	});
	
	if($("#fcon").val() == "CUSTDTDEF"){
		filterDefSetPopGridUserDef();
	}
	else{
		filterSetPopGridList();
	}
	
});
</script>

	
<script id="commStatustemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="groupFuncCommStatustemp" type="text/x-jquery-tmpl">
{{if codeName != 'IN' && codeName != 'NOT IN'}}
<option value="${'${'}codeName}">${'${'}markName}</option>
{{/if}}
</script>

<script id="groupFieldListTemp" type="text/x-jquery-tmpl">
<option value="${'${'}fieldId}">${'${'}fieldName}</option>
</script>



<div class="pop_inner_wrap filter_wrap">

	<div class="filter_left" id="FormArea">
	
		<!-- 필터 조건 -->
		<div class="temp_title">
			<spring:message code="M01236"/>
		</div>
		<div class="group_box_bg2 filter_condition">
			<!-- 필드명 -->
			<div class="row row_bottom">
				<label class="filter_label text-right"><spring:message code="M01231"/></label>
				<span class="field_name" id="popFieldName"></span>
			</div>
			<!-- 조건 -->
			<div class="row row_bottom">
				<label class="filter_label text-right"><spring:message code="M01232"/></label>
				<ifvm:input type="select" className="filter_input" id="fcon"/>
			</div>
			
			<!-- 그룹 조건 -->
			<div class="row row_bottom">
				<label class="filter_label text-right"><spring:message code="M01211"/></label>
				<ifvm:input type="select" className="filter_input" id="groupNm"/>
			</div>
				
			<!-- 값 -->
			<div class="row row_bottom">
				<label class="filter_label text-right"><spring:message code="M01233"/></label>
				<ifvm:input type="text" className="long_text" id="fValue" required="true"/>
			</div>
			<!-- and -->
			<div class="row between_row" id="between">
				<label class="filter_label text-right"><spring:message code="M01234"/></label>
				<ifvm:input type="text" className="long_text" id="andValue"/>
			</div>
			
			<div class="row row_bottom">
				<spring:message code="M01208"/>
			</div>
			
			<div class="row row_bottom">
				<spring:message code="M01209"/>
			</div>
		</div>
		
		<div id="groupArea">
			<!-- 그룹 함수 -->
			<div class="temp_title">
				<spring:message code="M01237"/>
			</div>
			<div class="group_box_bg2 group_func">
				<!-- 그룹 -->
				<div class="row row_bottom">
					<label class="filter_label text-right"><spring:message code="M01231"/></label>
					<ifvm:input type="select" className="filter_input" id="groupNm_notUsed"/>
				</div>
				<!-- 조건 -->
				<div class="row row_bottom">
					<label class="filter_label text-right"><spring:message code="M01232"/></label>
					<ifvm:input type="select" className="filter_input" id="fcon2_notUsed"/>
				</div>
				<!-- 값 -->
				<div class="row row_bottom">
					<label class="filter_label text-right"><spring:message code="M01233"/></label>
					<ifvm:input type="text" className="long_text" id="fValue2_notUsed"/>
				</div>
				<!-- and -->
				<div class="row between_row" id="between2">
					<label class="filter_label text-right"><spring:message code="M01234"/></label>
					<ifvm:input type="text" className="long_text" id="andValue2_notUsed"/>
				</div>
				
				<%-- <div class="row between_row" id="between2">
					<label class="filter_label text-right"><spring:message code="M01234"/></label>
					<ifvm:input type="text" className="long_text" id="andValue2_notUsed"/>
				</div> --%>
			</div>
		</div>
		
		
	</div>
	<div class="filter_right">
		<!-- 목록 선택 -->
		<div class="temp_title">
			<spring:message code="M01238"/>
			<div class="pop_top_btn">
				<button class="btn_pop_white" id="selectField">
			        <img src="<ifvm:image name='ico_check' />" alt="">
			      	<spring:message code="M00282"/>
			    </button>  
			    <button class="btn_pop_white" id="cancleField">  
			        <img src="<ifvm:image name='btn_delete' />" alt="">
			      	<spring:message code="M00284"/>
			   </button> 
			</div>
		</div>
		<div id="filterSetPopGrid" class="grid_bd0 con_size"></div>
	</div>
	
	
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="filterSetSaveBtn">  
		<i class="glyphicon glyphicon-check"></i>       
		<spring:message code="M00280"/>
	</button> 
	<%-- <button class="btn btn-sm btn_lightGray2" id="initValue">  
		<spring:message code="M00278"/>
	</button> --%>
	<button class="btn btn-sm btn_lightGray2" id="filterSetCancelBtn">         
		<spring:message code="M00284"/>
	</button>
</div> 
