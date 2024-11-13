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
<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<script>

var targetLevelId = '<%= cleanXss(request.getParameter("targetLevelId")) %>';
var confilterid = '<%= cleanXss(request.getParameter("id")) %>';
var conditionList;
var seq = 1;
var selectedFilterId;
var selectedFilterName;
var filterId;
var targetListGrid;
var targetListGridWidth;
var sessionTrue;

var userTargetingPop;

//그룹괄호 체크
function checkGroupFunc(){
	var groupFuncCheck = true;
	
	for(var i=0; i<$("#fieldSelectArea").children().find('ul.group_list').length; i++){
		
		var groupFuncCnt = 0;
		
		for(var k=0; k<$("#fieldSelectArea").children().find('ul.group_list').eq(i).find('p').length; k++){
			
			if($("#fieldSelectArea").children().find('ul.group_list').eq(i).find('p').eq(k).attr('groupVal') == 1){
				groupFuncCnt++;
			}
		}
		
		if(groupFuncCnt > 1){
			groupFuncCheck = false;
		}
	}
	
	return groupFuncCheck;
}


//그룹 괄호 업데이트
function setGroupFilterList(){
	
	var groupList = [];
	var segId = confilterid;
	
	for(var i=0; i<$("#fieldSelectArea").children().find('ul.group_list').length; i++){
		
		for(var k=0; k<$("#fieldSelectArea").children().find('ul.group_list').eq(i).find('li.draggable_list').length; k++){
			
			var obj = {};
			
			if(k==0){
				obj.filterId = $("#fieldSelectArea").children().find('ul.group_list').eq(i).find('li.draggable_list').eq(k).attr('filterId');
				obj.groupValue = 1;
				obj.parentGroup = i+1;
				groupList.push(obj);
			}
			
			else if(k==$("#fieldSelectArea").children().find('ul.group_list').eq(i).find('li.draggable_list').length-1){
				obj.filterId = $("#fieldSelectArea").children().find('ul.group_list').eq(i).find('li.draggable_list').eq(k).attr('filterId');
				obj.groupValue = 2;
				obj.parentGroup = i+1;
				groupList.push(obj);
			}
			
			else{
				obj.filterId = $("#fieldSelectArea").children().find('ul.group_list').eq(i).find('li.draggable_list').eq(k).attr('filterId');
				obj.groupValue = 0;
				obj.parentGroup = i+1;
				groupList.push(obj);
			}
			
		}
		
		
	}
	
	//if(groupList.length > 0){
		
		$.ifvPostJSON('<ifvm:action name="setGroupFilterList"/>',{filterItem : groupList, segmentId : segId}
		,function(result) {
	        
		}); 
		
	//}
}

//필터 순서 업데이트
function setFilterSeq(){
	var filterList = [];
	
	for(var i=1; i<=$("#fieldSelectArea").children().find('li.draggable_list').length; i++){
		var obj = {};
		obj.filterId = $("#fieldSelectArea").children().find('li.draggable_list').eq(i-1).attr('filterId');
		obj.filterSeq = i;
		filterList.push(obj);
	
	}
	
	if(filterList.length > 0){
		
		$.ifvPostJSON('<ifvm:action name="segFilterSeq"/>',{filterItem : filterList}
		,function(result) {
	        
			//순서 변경 완료 후 괄호 업데이트
			//seq = $("#fieldSelectArea").children().find('li.draggable_list').length + 1;
			setGroupFilterList();
		}); 
		
	}
	
}

//첫번째 필터 숨김처리 & AND로 변경
function filterHide(){
	$("#fieldSelectArea").find("li:not(.group_edge)").find("select").show();
	$("#fieldSelectArea").find("li:not(.group_edge)").eq(1).find("select").hide()
	.children("option").removeAttr("selected").eq(0).attr('selected', 'selected');
}

//조건 변경 시 서버 업데이트
function changeAndOr(item){
    	
	
	
   	var obj = {};
   	obj.filterId = item.parentNode.parentNode.getAttribute('filterId');
   	$(item).children('option').not(':selected').removeAttr('selected');
   	$(item).children('option:selected').attr('selected', 'selected');
   	
   	if(item.selectedIndex == '0'){
   		obj.andOr = 'AND';
   	}
   	else{
   		obj.andOr = 'OR';
   	}
   	
   	
   	$.ifvSyncPostJSON('<ifvm:action name="updateAndOr"/>',obj
	,function(result) {
		
		/* var filterId = fieldId + '_temp' + seq;
        
        $("#" + filterId).attr("filterId", result.message); */
        
        
	}); 
	
}

//필드를 끌어놓는 순간 빈 필드 저장
function setEmptyField(fieldId){
	
	
	
	var obj = {};
	obj.filterSeq = $("#fieldSelectArea").children().find('li.draggable_list').length;
	obj.segmentId = confilterid;
	obj.fieldId = fieldId;
	
	$.ifvSyncPostJSON('<ifvm:action name="setEmptyField"/>',obj
	,function(result) {
		
		var filterId = fieldId + '_temp' + seq;
        
        $("#" + filterId).attr("filterId", result.message);
        
        
	}); 
	
}


//세그먼트 쿼리 조회
function getSegmentQuery(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getSegmentQuery"/>',{segmentId : confilterid}
	,function(result) {
		
		
		if(result.sqlQuery != null && result.sqlQuery != ''){
			$("#sqlQuery").text(result.sqlQuery);
		}
		else{
			$("#sqlQuery").text('<spring:message code="M01213"/>');
		}
		
	}); 

}


//세그먼트 저장
function setTargetSegment(){
	
	if($("#fieldSelectArea").children().find('li.draggable_list').length > 0){
		
	
			var filterSavedFlag = true;
			
			for(var i=0; i<$("#fieldSelectArea").children().find('li.draggable_list').length; i++){
				
				if(!$("#" + $("#fieldSelectArea").children().find('li.draggable_list').eq(i).attr('id')).find(".btn_filter").hasClass("btn_filter_save")){
					filterSavedFlag = false;
				}
			}
			
			if(filterSavedFlag){
				
				
				var obj = {};
			 	if(typeof(quickFlag) != "undefined"){
					
			 		if(camId != null && camId != 'null'){
						obj.camId = camId;
						obj.segmentId = confilterid;
						obj.targetLevelId = targetLevelId;
						obj.quickFlag = quickFlag;
						
						//캠페인 워크플로우 분기처리
						if (typeof(workflowFlag) != "undefined") {
							obj.workflowFlag = workflowFlag;
						}
						
						if($("#compareValue").val() != null && $("#compareValue").val().length > 0){
							obj.compareValue = $("#compareValue").val();
							obj.compareType = $("#compareSelect").val();
						}
						
						obj.chnlType = $("#chnlType").val();
						
						if($('input:checkbox[id="fatigueExcept"]').is(":checked")){
							obj.fatiExceptYn = "1";
						}
						else{
							obj.fatiExceptYn = "0";
						}
						
						$.ifvSyncPostJSON('<ifvm:action name="setTargetSegment"/>',obj
						,function(result) {
							alert('<spring:message code="M00295"/>');
						}); 
						
					}
					else{	
						alert('<spring:message code="M00615"/>');
					}
					
				}
			 	else{
				
			 		obj.segmentId = confilterid;
					obj.targetLevelId = targetLevelId;
					
					if($("#compareValue").val() != null && $("#compareValue").val().length > 0){
						obj.compareValue = $("#compareValue").val();
						obj.compareType = $("#compareSelect").val();
					}
					
					$.ifvSyncPostJSON('<ifvm:action name="setTargetSegment"/>',obj
					,function(result) {
						alert('<spring:message code="M00295"/>');
					}); 
						
			 	}
			 	
			 	
			}
			else{
				alert('<spring:message code="M01215"/>');
			}
	}
	else{
		alert('<spring:message code="M01215"/>');
	}
	
	
}

//필드 필터 정보 조회
function fieldFilterList(){
	
	
	
	$.ifvSyncPostJSON('<ifvm:action name="getFieldFilterList"/>',{
		segmentId : confilterid
	},function(result) {
		
		//세그먼트 명 셋팅
		$("#targetSegNm").text(result.segNm);
		
		 var fieldTemp = {};
		 var selectFlag = false;
		 var selectList = "";
	        
		 $("#selectedFilterCnt").text(result.fieldFilterItem.length);
		 
		 
		 if(result.fieldFilterItem != null && result.fieldFilterItem.length > 0){
			 if(result.fieldFilterItem[0].comparUnit != null){
				 $("#compareSelect").val(result.fieldFilterItem[0].comparUnit);
				 $("#compareValue").val(result.fieldFilterItem[0].comparAmt);
			 }
		 }
		 
		 
		 for(var i=0; i<result.fieldFilterItem.length; i++){
			
			$("#fieldSelectArea").find( ".placeholder" ).hide();
			 
			fieldTemp.id = result.fieldFilterItem[i].fieldId + '_temp' + result.fieldFilterItem[i].filterSeq;
	        fieldTemp.func = result.fieldFilterItem[i].fieldId + '_temp' + result.fieldFilterItem[i].filterSeq;
	        fieldTemp.text = result.fieldFilterItem[i].fieldName;
	        fieldTemp.filterId = result.fieldFilterItem[i].filterId;
	        fieldTemp.andOr = result.fieldFilterItem[i].andOr;
	        seq = result.fieldFilterItem[i].filterSeq;
	        
	        //괄호넣기 start -----------------------------------------------------------------------------
	        
	        
	        
	        //필터값 셋팅
	        fieldTemp.filterValue = 'false';
	        
	        if(result.fieldFilterItem[i].filterValue!= null && result.fieldFilterItem[i].filterValue != 'null'){
	        	 
	        	if(result.fieldFilterItem[i].criteriaType != "BETWEEN"){
	        		fieldTemp.filterValue = result.fieldFilterItem[i].criteriaType + "  " + result.fieldFilterItem[i].filterValue;
	        	}
	        	else{
	        		fieldTemp.filterValue = result.fieldFilterItem[i].criteriaType + "  " + result.fieldFilterItem[i].filterValue + " AND " + result.fieldFilterItem[i].filterAttr;
	        	}
	        	
	        	///장용 - 2016-03-30 그룹함수 추가
	        	if(result.fieldFilterItem[i].groupFunc != null && result.fieldFilterItem[i].groupFunc.length > 0){
	        		fieldTemp.filterValue = "[" + result.fieldFilterItem[i].groupFunc + "]" + " " + fieldTemp.filterValue;
	        		fieldTemp.groupFunc = "1";
	        	}
	        	else{
	        		fieldTemp.groupFunc = "0";
	        	}	
	        	 
	        	//버튼 색 변경
	 			//$("#" + fieldTemp.id).find('button').addClass("btn_filter_save");
	 			//$("#" + fieldTemp.id).find('button').children(".filter_ico").attr("src", "<ifvm:image name='ico_check2' />");
	 			
	        }
	        
	        
	        
	        if(result.fieldFilterItem[i].parenDiv == 1){
	        	selectList = "";
	        	selectList += "<ul class='group_list'><li class='group_start_item group_edge'>{</li>";
	        	var tempGroup = $("#draggableTempGroup").tmpl(fieldTemp); 
	        	selectList += tempGroup[0].outerHTML;
	        	selectFlag = true;
	        }
	        
	        if(!selectFlag){
	        	var temp = $("#draggableTemp").tmpl(fieldTemp);
		        $("#fieldSelectArea > ul").append(temp);
	        }
	        else{
	        	
	        	if(result.fieldFilterItem[i].parenDiv == 0){
	        		var tempGroup = $("#draggableTempGroup").tmpl(fieldTemp); 
		        	selectList += tempGroup[0].outerHTML;
	        	}
	        }
	        
	        if(result.fieldFilterItem[i].parenDiv == 2){
	        	
	        	var tempGroup = $("#draggableTempGroup").tmpl(fieldTemp); 
	        	selectList += tempGroup[0].outerHTML;
	        	selectList += "<li class='group_end_item group_edge'>}</li></ul>";
	        	
	        	$("#fieldSelectArea > ul").append(selectList);
	        	selectFlag = false;
	        }
	        
	        //괄호넣기 end -----------------------------------------------------------------------------
	        
	        $("#" + fieldTemp.id).attr("filterId", result.fieldFilterItem[i].filterId);
	        
	        if(result.fieldFilterItem[i].andOr == 'AND'){
	        	$("#" + fieldTemp.id).find('select').val("1");
	        }
	        else{
	        	$("#" + fieldTemp.id).find('select').val("2");
	        }
	        
	       //필터 값 셋팅
	        var filterValue = "";
	        
	        if(result.fieldFilterItem[i].filterValue!= null && result.fieldFilterItem[i].filterValue != 'null'){
	        	 
	        	if(result.fieldFilterItem[i].criteriaType != "BETWEEN"){
	        		filterValue += result.fieldFilterItem[i].criteriaType + "  " + result.fieldFilterItem[i].filterValue;
		        	 $("#" + fieldTemp.id).find('p').text(filterValue);
	        	}
	        	else{
	        		filterValue += result.fieldFilterItem[i].criteriaType + "  " + result.fieldFilterItem[i].filterValue + " AND " + result.fieldFilterItem[i].filterAttr;
		        	 $("#" + fieldTemp.id).find('p').text(filterValue);
	        	}
	        	
	        	///장용 - 2016-03-30 그룹함수 추가
	        	if(result.fieldFilterItem[i].groupFunc != null && result.fieldFilterItem[i].groupFunc.length > 0){
	        		 $("#" + fieldTemp.id).find('p').text("[" + result.fieldFilterItem[i].groupFunc + "]" + " " + filterValue);
	        		fieldTemp.groupFunc = "1";
	        	}
	        	else{
	        		fieldTemp.groupFunc = "0";
	        	}	
	        	 
	        	//버튼 색 변경
	 			$("#" + fieldTemp.id).find('button').addClass("btn_filter_save");
	 			$("#" + fieldTemp.id).find('button').children(".filter_ico").attr("src", "<ifvm:image name='ico_check2' />");
	 			
	        }
	        else{
	        	 $("#" + fieldTemp.id).find('p').text('<spring:message code="M01205"/>');
	        }
	       
	        
	        
		 }
	        
		 seq ++;
	        
		 filterHide();
		 
	        /* var comTemp = $("#conditionTypeTemplate").tmpl(conditionList.rows);
			$("#" + fieldTemp.func).append(comTemp); 
			
			var notFunc = {};
			notFunc.codeName = 'NA';
			notFunc.markName = '--';
			
			var comNotFunc = $("#conditionTypeTemplate").tmpl(notFunc);
			$("#" + fieldTemp.func).prepend(comNotFunc);  */
		
	});
}

function divideScreen() {
	$('#adminCon').split({orientation:'vertical', limit:100, position:'15%'});
}

function accordionSetting(){
	$("#basicAccordion").ejAccordion({
		collapsible: true
	});
}


function init(){
	compareType();
		
	$("#adminCon").height(900);
	accordionSetting();	//아코디언
	$("#userTargetingTab").ejTab(); //탭
	settingUserMenu();
	conditionType();
	fieldFilterList();
	if($('#dialog').length == 0)
	{
		divideScreen();	//split
	} else {
		setTimeout(function() {
			divideScreen();	//split	
		}, 500);
	}
}

//대상 카운트
function countTarget(){
	
	
	/* var targetItem = [];
	
	
	for(var i=1; i<$("#fieldSelectArea").find('li').length; i++){
		
		var saveItem = {};
		
		//필드 아이템 조회
		saveItem.fieldSeq = i;
		saveItem.fieldId = $("#fieldSelectArea").find('li')[i].id;
		saveItem.groupVal = $("#" + saveItem.fieldId).find('select').eq(0).val();
		
		if(saveItem.groupVal != 'NA'){
			saveItem.groupFuncType = 'GROUP';
		}
		else{
			saveItem.groupFuncType = 'NORMAL';
		}
		
		if($("#" + saveItem.fieldId).find('select').eq(1).val() == '1'){
			saveItem.andOr = 'AND';
		}
		else{
			saveItem.andOr = 'OR';
		}
		
		saveItem.fieldId = $("#fieldSelectArea").find('li')[i].id.split('_')[0];
		
		//필터 정보 조회
		var filterVal = {};
		
		filterVal.filterSeq = i;
		
		var filterValue = new Array();
		filterValue.push('5000');
		
		filterVal.filterVal = filterValue;
		filterVal.operation = '<';
		
		saveItem.filterItem = filterVal;
		
		//그룹 정보 조회
		var groupVal = {};
		
		groupVal.filterSeq = i;
		
		var groupValue = new Array();
		groupValue.push('aaa');
		
		groupVal.filterVal = groupValue;
		groupVal.operation = '<=';
		
		saveItem.groupItem = groupVal;
		
		
		
		targetItem.push(saveItem);
		
		
	} */
	
	
	/* var targetItem = [];
	
	for(var i=1; i<$("#fieldSelectArea").find('li').length; i++){
		
		var saveItem = {};
		//saveItem.fieldId = $("#fieldSelectArea").find('li')[i].id;
		if($("#fieldSelectArea").find('li').eq(i).children().find('button').attr('class').indexOf('save') != '-1'){
			saveItem.filterId = $("#fieldSelectArea").find('li')[i].getAttribute('filterId');
			targetItem.push(saveItem);
		}
		
	} */
	
	var obj = {};
	obj.segmentId = confilterid;
	obj.targetLevelId = targetLevelId;
	
	if(typeof(quickFlag) != "undefined"){
		obj.chnlType = $("#chnlType").val();
		
		if($('input:checkbox[id="fatigueExcept"]').is(":checked")){
			obj.fatiExceptYn = "1";
		}
		else{
			obj.fatiExceptYn = "0";
		}
	}
	
	 $.ifvPostJSON('<ifvm:action name="getTargetCount"/>',obj
	,function(result) {
		
		
		$("#filterAllCnt").text(result.allCnt);
		
		for(var i=0; i<result.countItem.length; i++){
			
			for(var k=0; k<$("#fieldSelectArea").find('li').length; k++){
				
				if(result.countItem[i].filterId == $("#fieldSelectArea").find('li')[k].getAttribute('filterId')){
					$("#fieldSelectArea").find('li').eq(k).find('input').val(result.countItem[i].filterCount);
				}
			}
		}
		
	}
	,function(result){    
		alert('<spring:message code="M01214"/>');
	}, 'body', 'bigsize_progressRoll'); 
	
	
}

//공통코드 조회 - 조건유형
function conditionType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEG_GROUP_CONDITION_TYPE'
		, enableNA : true
	},function(result) {
		
		conditionList = result;
	});
}; 

//공통코드 조회 - 비교군
function compareType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEND_UNIT_CD'
		, enableNA : true
	},function(result) {
		
		var temp = $("#compareTemplate").tmpl(result.rows);
		$("#compareSelect").append(temp);
	});
}; 

//필터 저장시 버튼 변경
function filterSetBtnUI(_this){
	$(_this).addClass("btn_filter_save")
	.children(".filter_ico").attr("src", "<ifvm:image name='ico_check2' />");
}

function userTargetingPopClose(){
	userTargetingPop._destroy();
}

//서브젝트 에어리어 영역 조회
function settingUserMenu(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getSubjectFieldList"/>'
	, {targetLevelId : targetLevelId}
	,function(result) {
		
		
		for(var i=0; i<result.subjectAreaList.length; i++){
			
			$("#targetLevelNm").text(result.subjectAreaList[0].targetLevelNm);
			
			var temp = $("#toggleMenuTemp").tmpl(result.subjectAreaList[i]);
		    $("#menuArea").append(temp);
		    
		    var temp2 = $("#toggleSubMenuTemp").tmpl(result.subjectAreaList[i].fieldList);
		    $("#"+ result.subjectAreaList[i].subjectAreaId).append(temp2);
			
		}

	});
	draggable();
	
	/* var temp = $("#toggleMenuTemp").tmpl();
    $("#menuArea").append(temp);
    
    var temp2 = $("#toggleSubMenuTemp").tmpl();
    $("#menuArea .menu_ul").append(temp2); */
}
function draggable(){
	$( "#basicAccordion li" ).draggable({
    	appendTo: "body",
    	helper: "clone"
    });
}


function isKeyPressed(event, _this) {
	//ctrl key 눌렀을 때 event
	if (event.ctrlKey) {
    	
    	$(_this).addClass("sel");
    	notFilterSet(_this);
    	
    	var selectList = $( "#fieldSelectArea>ul>li.sel" ); 
		//group버튼 활성화
    	if( selectList.length > 1 ){
			$("#groupBtn").removeAttr("disabled");
		}
		
		if(  $( "#fieldSelectArea>ul>ul" ).hasClass("sel") ){
    		$("#groupBtn").attr("disabled", "disabled");
    	}
    	
    } else {	//일반 클릭 시
    	removeSelClass();
    	$("#groupBtn").attr("disabled", "disabled");
    	$(_this).addClass("sel");
    	notFilterSet(_this);
    }
}

//선택한 style 없애기
function removeSelClass(){
	$( "#fieldSelectArea ul" ).removeClass("sel");
	$( "#fieldSelectArea ul li" ).removeClass("sel");
}

//그룹안에 리스트 1개일 때 그룹 해제
function setUngroup(){
	var selectList = $( "#fieldSelectArea ul.group_list.sel li:not(.group_edge)" );
	
	if( selectList.length == 1 ){
		var html = "";
		
		for(var i=0; i<selectList.length; i++){
			html += selectList[i].outerHTML;	//복제
		}  
		
		$("#fieldSelectArea ul.group_list.sel").after(html);
		$("#fieldSelectArea ul.group_list.sel").remove();
		removeSelClass();
	}
}

//필터 저장하기 전에는 선택해제 되도록
function notFilterSet(_this){
	
	if( !$(_this).find(".btn_filter").hasClass("btn_filter_save") ){
		$(_this).removeClass("sel");
	}	
}

//대상자 목록 조회
function getGridOptionInfo(){
	$.ifvSyncPostJSON('<ifvm:action name="getSegColNames"/>',{segmentId : confilterid}
	,function(result) {
		sessionTrue = true;
 		if(result.length > 0){
			var colNames = [];
			var colModel = [];
			for(var i = 0; i < result.length; i++) {
				colNames.push(result[i].colKorName);
				colModel.push({index:result[i].colEngName, name:result[i].colEngName, resizable: false});				
			}

			var widthUnit = 120;
			var totalUnitLength = parseInt(widthUnit * result.length);
			var parentLength = parseInt($('#targetListTab').width() - 40);
			
			if(totalUnitLength < parentLength)
				targetListGridWidth = parentLength;
			else
				targetListGridWidth = totalUnitLength;
						
			$('#targetListGrid').css('width', targetListGridWidth);
			//colModel 대문자 변환
			 for(var i=0; i<colModel.length; i++){
				colModel[i].name = colModel[i].name.toUpperCase();
			} 
			makeTargetListGrid(colNames, colModel);
		}
		else{
			$("#targetListGrid").text('<spring:message code="M01213"/>');
		}
	}); 
}

function makeTargetListGrid(colNames, colModel){
	//칼럼 갯수당 width값 연산 후 추가 필요
  	var jqGridOption = {
			serializeGridData : function( data ){
				data.segmentId = confilterid;
				return data;
			},
			loadComplete : function(data){
				if(data.message == 'error'){
					alert('<spring:message code="M01214"/>');
				}else{
					$("#excelDownload").show();
				}
			},
		    url:'<ifvm:action name="getSegDataList"/>',
 		    colNames: colNames,
		    colModel: colModel,

/*  			colNames: ['이름'],
 			colModel: [{name: 'name', index: 'name', resizable: false}], */
 			autowidth: true,
 			sortname: 'cid_id',
 			sortorder: "desc",
		    tempId : 'ifvGridOriginTemplete',
		    caption : '<spring:message code="M01217"/>'
	};
  	
	targetListGrid = $("#targetListGrid").ifvGrid({ jqGridOption : jqGridOption });
 
/* 	$.ifvSyncPostJSON('<ifvm:action name="getSegDataList"/>',{segmentId : confilterid}
	,function(result) {
	});  */
 }
 

$(document).ready(function() {

	$("#excelDownload").hide();
	
	if(typeof(quickFlag) == "undefined"){
		$.ifvmLnbSetting('userMain');
		init();
		
	}

	//drag and drop
	draggable();
    $( "#fieldSelectArea>ul" ).droppable({
        accept: "#basicAccordion li",
        drop: function( event, ui ) {	//신규 필드
	        $( this ).find( ".placeholder" ).hide();
	        //$( "<li></li>" ).text( ui.draggable.text() ).appendTo( this );
	        
	        
	        var fieldTemp = {};
	        
	        fieldTemp.id = ui.draggable.attr('id') + '_temp' + seq;
	        fieldTemp.func = ui.draggable.attr('id') + '_func' + seq;
	        fieldTemp.text = ui.draggable.text();
	        fieldTemp.andOr = 'AND';
	        
	        var temp = $("#draggableTemp").tmpl(fieldTemp);
	        $("#fieldSelectArea>ul").append(temp);
	        
	        var comTemp = $("#conditionTypeTemplate").tmpl(conditionList.rows);
			$("#" + fieldTemp.func).append(comTemp); 
			
			var notFunc = {};
			notFunc.codeName = 'NA';
			notFunc.markName = '--';
			
			var comNotFunc = $("#conditionTypeTemplate").tmpl(notFunc);
			$("#" + fieldTemp.func).prepend(comNotFunc); 
			
			var fieldCnt = parseInt($("#selectedFilterCnt").text()) + 1;
			$("#selectedFilterCnt").text(fieldCnt);
			
			//필터 저장
			setEmptyField(ui.draggable.attr('id'));
			
			filterHide();
			
			seq++;
	    }
    }).sortable({
    	axis : "y",
        items : "li:not(.placeholder, .group_edge), ul.group_list",
        opacity : 0.8,
		start : function (event, ui){
			//그룹일 때
			var parent = ui.item.parent();
			
			if( $(parent).hasClass("group_list") ){
				 if( $(parent).children("li:not(.group_edge)").length == 3 ){
					 $(".group_list").removeClass("sel");
					 $(parent).addClass("sel");
				 }
			}
		},
        sort : function(event, ui) {
        	var item = ui.item[0];
        	$(item).addClass("sort");
        },
        stop : function(event, ui){
        	//괄호안에 그룹함수 1개 체크
        	var groupCheck = true;
        	
        	if(ui.item.find('p').attr('groupVal') == 1 && ui.item.parent().hasClass("group_list")){
        		
        		var groupCnt = 0;
            	
            	for(var i=0; i<ui.item.parent().find('p').length; i++){
            		
            		if(ui.item.parent().find('p').eq(i).attr('groupVal') == 1){
            			groupCnt++;
            		}
            	}
            	
            	if(groupCnt > 1){
            		groupCheck = false;
            	}
        	}
        	
        	if(groupCheck){
        		
        		//필터 순서 변경시 순서 업데이트
            	setFilterSeq();
            	
            	var item = ui.item[0];
            	$(item).removeClass("sort");
            	setUngroup();	//1개 남을 때 그룹해제
            	filterHide();	//첫번째 리스트의 select 삭제 
            	
            	//그룹안에 그룹 방지	
            	if( ui.item.hasClass("group_list") ){
            		if( ui.item.parent().hasClass("group_list") ){
                		$(this).sortable('cancel');	
                	}
            	}
            	
            	//필터 설정 전 그룹 방지 
            	if( !ui.item.find(".btn_filter").hasClass("btn_filter_save") ){
            		if( ui.item.parent().hasClass("group_list") ){
                		$(this).sortable('cancel');	
                	}
        		}
        		
        	}
        	else{
        		$(this).sortable('cancel');	
        		alert('<spring:message code="M01388"/>');
        	}
        	
        }
    });
    
  //필드 조건 리스트 클릭
	$( "#fieldSelectArea ul li" ).live("click", function(event){
		var _this = $(this);
		$( "#groupBtn" ).text("Group");
		isKeyPressed(event, _this);
		$("#excelDownload").hide();
    });
	
    //group버튼 클릭
	$( "#groupBtn" ).live("click", function(event){
		
if( $(this).text() == "Group" ){
				var selectList = $( "#fieldSelectArea>ul>li.sel" ); 
				
				var groupCnt = 0;
				for(var i=0; i<selectList.length; i++){
					
					if(selectList.eq(i).find('p').attr('groupVal') == 1){
						groupCnt++;
					}
				}
				
				if(groupCnt > 1){
					
					alert('<spring:message code="M01388"/>');
					
				}
				else{
					
					if( selectList.length > 1 ){
						removeSelClass();
						var html = "";
						html += "<ul class='group_list'>";
						html += "<li class='group_start_item group_edge'>{</li>";
						
						for(var i=0; i<selectList.length; i++){
							html += selectList[i].outerHTML;	//복제
						}  
			
						html += "<li class='group_end_item group_edge'>}</li>";
						html += "</ul>";
					   
					    $(selectList[0]).before(html);
					    selectList.remove();	//선택된 list 삭제
					}
					
				}
				
		} else {	// Ungroup
			
			var selectList = $( "#fieldSelectArea ul.group_list.sel li:not(.group_edge)" );
			var html = "";

			for(var i=0; i<selectList.length; i++){
				html += selectList[i].outerHTML;	//복제
			}  
			
			$("#fieldSelectArea ul.group_list.sel").after(html);
			$("#fieldSelectArea ul.group_list.sel").remove();	//선택된 list 삭제
			removeSelClass();
			
		}
		
		//괄호 업데이트
		setFilterSeq();
		
		$("#groupBtn").attr("disabled", "disabled");
    });
    
    //그룹 리스트 클릭
	$( "#fieldSelectArea ul.group_list" ).live("click", function(){
		removeSelClass();
		$(this).addClass("sel");
		$( "#groupBtn" ).text("Ungroup");
		$("#groupBtn").removeAttr("disabled");
	});
    
    //토글 메뉴
    $(".menu_wrap .menu_title").live("click", function(){
    	$(this).next('ul').slideToggle( "fast", function(){
    		$(this).prev(".menu_title").toggleClass( "focus", 1000 );	
    	} );
    	
    });
    
    //토글 메뉴 리스트 drag시 style 
    $( "#basicAccordion li" ).live("dragstart", function(){
    	
    	$(this).addClass("focus");
    });
    $( "body" ).live("mouseup", function(){
    	
    	$( "#basicAccordion li" ).removeClass("focus");
    });
    
    //필드 조건 닫기 버튼
    $(".draggable_close").live("hover", function(e){
    	if(e.type== "mouseleave"){
    		$(this).children("img").attr("src", "<ifvm:image name='ico_close' />");	
    	} else {
    		$(this).children("img").attr("src", "<ifvm:image name='ico_close_hover' />");	
    	}
    	
    }).live("click", function(){
    	
    	var group = $(this).parent().parent(".group_list");
    	
    	if( $(group).hasClass("group_list") ){
    		$(".group_list").removeClass("sel");
    		$(group).addClass("sel");
    	}
    	
    	var delFilterId = this.parentElement.getAttribute('filterId');
    	
    	if(delFilterId.length > 0){
    		
    		$.ifvPostJSON('<ifvm:action name="deleteFilterValue"/>',{filterId : delFilterId}
    		,function(result) {
    			
    			setFilterSeq();
    			//alert('<spring:message code="M00622"/>');
    		});
    	}
    	
    	$(this).parent().remove();	//제거
		setUngroup();	//1개남을 때 그룹해제
		
    	if( $(".draggable_list").length == 0 ){
    		$("#fieldSelectArea").find( ".placeholder" ).show();	
    	}

    	var fieldCnt = $("#fieldSelectArea").children().children().length -1;
    	$("#selectedFilterCnt").text(fieldCnt);
    	
    	filterHide();
    	
    });
    
    //필터설정 버튼
    $(".btn_filter").live("click", function(){
    	//selectedFilterName = this.parentElement.parentElement.getElementsByClassName("field_row_label")[0].id;
    	selectedFilterName = $(this).parent().parent().find(".field_row_label").text();
    	selectedFilterId = this.parentElement.parentElement.id;
    	
    	//필터값 유무 조회
    	if(this.parentElement.parentElement.getAttribute('filterId').length > 0){
    		filterId = this.parentElement.parentElement.getAttribute('filterId');
    	}
    	else{
    		filterId = null;
    	}
    	
    	var _this = $(this);
    	$("#userTargetingPop").ejDialog({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="filterSettingPop" />',
            contentType: "ajax",
            title: '<spring:message code="M01230"/>',
            width: 828,
            open : function(){
            	filterBtn(_this);
            },
            close : 'userTargetingPopClose'
        }); 
    	
    	userTargetingPop = $("#userTargetingPop").data("ejDialog");
    	
    });
    
    //카운트 버튼 클릭
    $("#countBtn").on('click', function(){
    	countTarget();
    });
    
    //저장 버튼 클릭
    $("#targetSegmentSaveBtn").on('click', function(){
    	setTargetSegment();
    });
    
    //sql 확인 버튼 클릭
    $("#sqlConfirm").on('click', function(){
    	$("#excelDownload").hide();
    	getSegmentQuery();
    });

    //대상자 목록 버튼 클릭
    $("#targetList").on('click', function(){
    	getGridOptionInfo();
    });
    
     //엑셀 다운로드  버튼 클릭
    $("#excelDownload").on('click', function(){
    	getGridOptionInfo();
    	
    	if(sessionTrue){
 			qtjs.href('<ifvm:action name="excelExportSegmentTargetList"/>'+"?country="+country+"&lang="+lang+"&appServiceId="+appServiceId+"&id="+confilterid);
    	}
    	sessionTrue =false;
 		
    });
     
	    
   
     if( typeof(quickFlag) == "undefined" &&  typeof(workflowFlag) == "undefined"){
    	 $("#compareSelect").hide();
    	 $("#compareValue").hide();
    	 $("#compareTxt").hide();
    	 
     }
    
});

</script>

<!-- 비교군 공통코드 -->
<script id="compareTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 조건 공통코드 -->
<script id="conditionTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 메뉴 타이틀 -->
<script id="toggleMenuTemp" type="text/x-jquery-tmpl">
<h3 class="menu_title"><a href="#">${'${'}subjectAreaNm}</a></h3>
<ul class="menu_ul" id="${'${'}subjectAreaId}">
	
</ul>	
</script>

<!-- 메뉴 리스트 -->
<script id="toggleSubMenuTemp" type="text/x-jquery-tmpl">
{{if filterType == 'MEASURE'}}
<li style="background-color:#F1F5F8" id="${'${'}fieldId}" title="${'${'}fieldKroNm}"><font color="2185C3">${'${'}fieldKroNm}</font></li>
{{else}}
<li id="${'${'}fieldId}" title="${'${'}fieldKroNm}">${'${'}fieldKroNm}</li>
{{/if}}
</script>

<!-- 필드 조건 편집 템플릿 -->
<script id="draggableTemp" type="text/x-jquery-tmpl">
<li class="draggable_list" id="${'${'}id}" filterId="">
	<div class="in_select select_and">
		<select onChange="changeAndOr(this)">
			{{if andOr == 'AND'}}
				<option value="1" selected="selected">AND</option>
				<option value="2">OR</option>
			{{/if}}
			{{if andOr == 'OR'}}
				<option value="1">AND</option>
				<option value="2" selected="selected">OR</option>
			{{/if}}
		</select>
	</div>
	<span class="field_row_label" title="${'${'}text}">${'${'}text}</span>
	<div class="right_area">
		<button class="btn_filter">
			<img src="<ifvm:image name='ico_setting' />" alt="" class="filter_ico" />
			<spring:message code="M01187"/>
		</button>
		
		<ifvm:input type="text" className="in_text text-right" disabled="true" placeholder="M01185" />
	</div>			
	<p class="field_txt_area" groupVal="${'${'}groupFunc}"><spring:message code="M01205"/></p>
	
	<a href="javascript:;" class="draggable_close"><img src="<ifvm:image name='ico_close' />" alt="" /></a>
</li>
</script>

<!-- 괄호 추가 시 필드 조건 편집 템플릿 -->
<script id="draggableTempGroup" type="text/x-jquery-tmpl">
<li class="draggable_list" id="${'${'}id}" filterId="${'${'}filterId}">
	<div class="in_select select_and">
		<select onChange="changeAndOr(this)">
			{{if andOr == 'AND'}}
			<option value="1" selected="selected">AND</option>
			<option value="2">OR</option>
			{{/if}}
			{{if andOr == 'OR'}}
			<option value="1">AND</option>
			<option value="2" selected="selected">OR</option>
			{{/if}}
		</select>
	</div>
	<span class="field_row_label" id="${'${'}text}">${'${'}text}</span>
	<div class="right_area">
		{{if filterValue != 'false'}}
			<button class="btn_filter btn_filter_save">
				<img src="<ifvm:image name='ico_check2' />" alt="" class="filter_ico" />
				<spring:message code="M01187"/>
			</button>
		{{/if}}	
		{{if filterValue == 'false'}}
			<button class="btn_filter">
				<img src="<ifvm:image name='ico_setting' />" alt="" class="filter_ico" />
				<spring:message code="M01187"/>
			</button>
		{{/if}}	
		
		<ifvm:input type="text" className="in_text text-right" disabled="true" placeholder="M01185" />
	</div>		
	
	{{if filterValue != 'false'}}
		<p class="field_txt_area" groupVal="${'${'}groupFunc}" >${'${'}filterValue}</p>
	{{/if}}	
	{{if filterValue == 'false'}}
		<p class="field_txt_area" groupVal="${'${'}groupFunc}"><spring:message code="M01205"/></p>
	{{/if}}	
	<a href="javascript:;" class="draggable_close"><img src="<ifvm:image name='ico_close' />" alt="" /></a>
</li>
</script>

<div class="user_targeting_area">
	<div class="page-title">
		<h1>
			<spring:message code="M01188"/>
			<span> &gt; <spring:message code="M01103"/></span>
		</h1>
	</div>
	<div id="adminCon">
		<!-- 좌측 아코디언 -->
 		<div id="basicAccordion" class="left_userTargeting">
			<h2>
				<a href="#"><spring:message code="M01189"/></a>
			</h2>
			<div class="menu_wrap" id="menuArea">
				
			</div>
		</div>
		<!-- 우측 컨텐츠 -->									
		<div class="right_userTargeting">
			<div class="page_btn_area">
				<div class="col-xs-9">
					<span><spring:message code="M01190"/><span class="level_label" id="targetLevelNm"></span></span>
					<span><spring:message code="M01216"/><span class="level_label" id="targetSegNm"></span></span>
				</div>
				
				<div class="col-xs-3 searchbtn_r">
	 			<button class="btn btn-sm" id="targetSegmentSaveBtn">
						<i class="glyphicon glyphicon-check"></i>
						<spring:message code="M00280"/>
					</button> 
					<button class="btn btn-sm" id="excelDownload">
						<i class="glyphicon glyphicon-check"></i>
						<spring:message code="M01218"/>
					</button> 

				</div>
			</div>
			<div class="well">
				<div>
				<p class="user_description left"><spring:message code="M01199"/></p>
				</div>
				<div id="userTargetingTab" class="round_tab">
					<ul>
						<li><a href="#fieldConditionTab"><spring:message code="M01191"/></a></li>
						<li><a href="#sqlConfirmTab" id="sqlConfirm"><spring:message code="M01192"/></a></li>
						<li><a href="#targetListTab" id="targetList"><spring:message code="M01217"/></a></li>						
					</ul>
					<!-- 필드 조건편집 -->
					<div id="fieldConditionTab">
						<div class="field_condition_top">
							<p class="field_label">
								<spring:message code="M01193"/> <!-- 선택 필드 -->
								<span><span id="selectedFilterCnt">0</span> <spring:message code="M01195"/></span>
							</p> 
							<p class="field_label">
								<spring:message code="M01194"/> <!-- 전체 추출 고객 수 -->
								<span><span id="filterAllCnt">0</span> <spring:message code="M01196"/></span>
							</p>
							<div class="pull-right right_area">
								<span class="field_label" id="compareTxt"><spring:message code="M01200"/></span>
								<ifvm:input type="select" className="in_select" id="compareSelect" />
								<ifvm:input type="text" className="in_text" id="compareValue"/>
								<button class="btn btn-sm btn_gray" id="countBtn"><spring:message code="M01186"/></button>	<!-- count 버튼 -->
								<button class="btn btn-sm btn_gray" id="groupBtn" disabled="disabled">Group</button>
							</div>
							
						</div>
						<div id="fieldSelectArea" class="field_select_area">
							<ul>
						      <li class="placeholder">
							      <span class="font_bold"><spring:message code="M01197"/></span><br />
							      <spring:message code="M01198"/>
						      </li>
						    </ul>
						</div>
					</div>
					<!-- SQL 확인  -->
					<div id="sqlConfirmTab">
						<ifvm:input type="textarea" className="sql_readOnly" disabled="true" id="sqlQuery" />
					</div>
					<!-- 대상자 목록  -->					
					<div id="targetListTab" class="target_list_box">
						<div id="targetListGrid" class="target_list_grid"></div>
					</div>
					
			<!-- 		<div class="col-xs-3 searchbtn_r">
					<button class="btn btn-sm" id="excelDownload">
						<i class="glyphicon glyphicon-check"></i>
						엑셀 다운로드
					</button> 
				</div> -->
				</div>
			</div>
			
		</div>	 
	</div>
</div>

<div id="userTargetingPop" class="popup_container"></div>