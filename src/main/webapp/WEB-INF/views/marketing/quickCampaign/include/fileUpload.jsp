<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="${pageContext.request.contextPath}/resources/js/marketing/calendar_beans_v2.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/jquery.mask.min.js" type="text/javascript"></script>

<script>
var segName = null;
var saveTargetObj = {};	//저장될 정보
//var memId = [];	//저장될 회원 목록

var segmentPopupCon;

var saveSegObj = {};
var memberList = null;
var targetCustCnt = null;
var agreeCust = null;
var fatiCnt = null;
var prmsCnt = null;
var dupCnt = null;

//파일 저장 변수
var uploadMemberInfoGrid; 
var uploadResultNumberGrid;
var gridData;
var uploadData;
var nodeId = [];
var tableObj = [];
var memIds = [];
isRefresh = true;


//세그먼트 저장 변수
var promptList = [];
var promptAttr = {};
var segNameFlag;

//세그먼트 저장
function saveSegment(){
	
	var itemList = [];
	
	//최종 저장할 데이터 초기화
	promptList = [];
	
	//세그먼트 1/2번 템플릿을 조회하여 선택된 값을 저장
	for(var i=1; i<=nodeId.length; i++){
		
		var itemValue = {};
		var items = [];
		//세그먼트 1/2번 템플릿의 하위 아이템들을 조회
		var tempItems = $("#tempTable" + i).children();
		
		for(var k=0; k<tempItems.length; k++){
			
			var obj = {};
			
			//타입에 따라서 분기하여 해당 타입에 대한 값을 조회
			var tempType = tempItems.eq(k).attr('prompttype');
			
			obj.tempType = tempType;
			
			if(tempType == 'MULTIA'){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:checkbox:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('values'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
			}
			else if(tempType == "DDLB" || tempType == "DATE"){
				
				var condName = tempItems.eq(k).attr('condition');
				//var attrListValue = tempItems.eq(k).find('select option:selected').text();
				var attrListValue = tempItems.eq(k).find('select option:selected').attr('condName');
				var attrList = [];
				
				if(attrListValue != null && attrListValue){
					attrList.push(attrListValue);
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = tempItems.eq(k).find('select option:selected').attr('value');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
				
			}
			//Y/N플래그 등
			else if(tempType == "CHECK"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:radio:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('value'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
			}
			//구매금액 등
			else if(tempType == "NUMBER"){
				
				var condName = tempItems.eq(k).attr('condition');
				
				var fromNum = $("#" + tempItems.eq(k).attr('id')).find(fromNumTemp).eq(0).val();
				var toNum = $("#" + tempItems.eq(k).attr('id')).find(toNumTemp).eq(0).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromNum = fromNum;
				promptAttr.toNum = toNum;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromNum = fromNum;
				obj.toNum = toNum;
				
				items.push(obj);
				
			}
			//구매날짜 등
			else if(tempType == "TERM"){
				var condName = tempItems.eq(k).attr('condition');
				
				var fromDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(0).val();
				var toDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(1).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromDate = fromDate;
				promptAttr.endDate = toDate;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromDate = fromDate;
				obj.toDate = toDate;
				
				items.push(obj);
			}
			//구매날짜 등(월단위)
			else if(tempType == "MONTH_TERM"){
				var condName = tempItems.eq(k).attr('condition');
				
				var fromDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(0).val();
				var toDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(1).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromDate = fromDate;
				promptAttr.endDate = toDate;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromDate = fromDate;
				obj.toDate = toDate;
				
				items.push(obj);
			}
			//RADIO, 연령대 등ifvUiRadio
			else if(tempType == "RADIO"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:radio:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('value'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
			}			
			//멀티 A B 분류, 멀티A = 체크박스, 멀티B = 이동가능 div
			else if(tempType == "MULTIB"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = $("#" + 'gridId' + tempItems.eq(k).attr('id') + 'SelectedList').getRowData();
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue[j].condCode);
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue[j].id;
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
			}
		}
		
		itemValue.items = items;
		itemValue.tempId = nodeId[i-1];
		itemList.push(itemValue);
	}
	
	
	
	if(camId != null && camId.length > 0 && camId != "null"){
		
		if($("#saveSegName").val().length > 0){
			
			//if(memberList != null && memberList.length > 0){
				
				saveSegObj = {};
				
				saveSegObj.memberList = memberList;
				saveSegObj.targetCustCnt = targetCustCnt;
				saveSegObj.agreeCust = agreeCust;
				saveSegObj.fatiCnt = fatiCnt;
				saveSegObj.prmsCnt = prmsCnt;
				saveSegObj.dupCnt = dupCnt;
				
				/* var memObjList = [];
				
				for(var i=0; i<memIds[0].length; i++){
					var memObj = {};
					memObj.memId = memIds[0][i];
					memObjList.push(memObj);
				} */
				
				var tempObjList = [];
				
				for(var i=0; i<nodeId.length; i++){
					var tempObj = {};
					tempObj.ntempId = nodeId[i];
					tempObjList.push(tempObj);
				}
				
				saveSegObj.segName = $("#saveSegName").val();
				saveSegObj.camId = camId;
				saveSegObj.segType = 'SEG';
				saveSegObj.promptList = promptList;	
				saveSegObj.tempIds = tempObjList;
				//obj.memIds = memObjList;
				//obj.allUploadCnt = memObjList.length;
				saveSegObj.chnlType = $("#chnlType").val();
				
				if(nodeId != null && nodeId.length > 1){
					saveSegObj.calType = $(':radio[name="templateSet"]:checked').val();
				}
				
				//퀵캠페인 / 캠페인워크플로우 분기
				if (typeof campaignSubjectsPopData != "undefined" 
				        && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
				    //캠페인 워크플로우에서의 세그먼트 유형
                    saveSegObj.segType = campaignSubjectsPopData.campaignSegType;
                    saveSegObj.chnlType = campaignSubjectsPopData.campaignChnlType;
                }
				
				$.ifvSyncPostJSON('<ifvm:action name="setSegment"/>',saveSegObj
					,function(result) {
					
					alert("<spring:message code='M00267'/>");
					$("#segConfirmWrap").show();
					$("#segConfirmName").text(result.message);
					
				});
				
				
			/* }
			else{
				alert("<spring:message code='M00712'/>");
			} */
		}
		else{
			alert("<spring:message code='M00713'/>");
		}
	}
	else{
		alert("<spring:message code='M00710'/>");
	}
	
	
	
	
	
}


//세그먼트 카운팅 조회
function segCount(){
	
	var itemList = [];
	
	//최종 저장할 데이터 초기화
	promptList = [];
	
	//세그먼트 1/2번 템플릿을 조회하여 선택된 값을 저장
	for(var i=1; i<=nodeId.length; i++){
		
		var itemValue = {};
		var items = [];
		//세그먼트 1/2번 템플릿의 하위 아이템들을 조회
		var tempItems = $("#tempTable" + i).children();
		
		for(var k=0; k<tempItems.length; k++){
			
			var obj = {};
			
			//타입에 따라서 분기하여 해당 타입에 대한 값을 조회
			var tempType = tempItems.eq(k).attr('prompttype');
			
			obj.tempType = tempType;
			
			if(tempType == 'MULTIA'){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:checkbox:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('values'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
			}
			else if(tempType == "DDLB" || tempType == "DATE"){
				
				var condName = tempItems.eq(k).attr('condition');
				//var attrListValue = tempItems.eq(k).find('select option:selected').text();
				var attrListValue = tempItems.eq(k).find('select option:selected').attr('condName');
				var attrList = [];
				
				if(attrListValue != null && attrListValue){
					attrList.push(attrListValue);
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = tempItems.eq(k).find('select option:selected').attr('value');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
				
			}
			//Y/N플래그 등
			else if(tempType == "CHECK"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:radio:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('value'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
			}
			//구매금액 등
			else if(tempType == "NUMBER"){
				
				var condName = tempItems.eq(k).attr('condition');
				
				var fromNum = $("#" + tempItems.eq(k).attr('id')).find(fromNumTemp).eq(0).val();
				var toNum = $("#" + tempItems.eq(k).attr('id')).find(toNumTemp).eq(0).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromNum = fromNum;
				promptAttr.toNum = toNum;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromNum = fromNum;
				obj.toNum = toNum;
				
				items.push(obj);
				
			}
			//구매날짜 등
			else if(tempType == "TERM"){
				
				var condName = tempItems.eq(k).attr('condition');
				
				var fromDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(0).val();
				var toDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(1).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromDate = fromDate;
				promptAttr.endDate = toDate;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromDate = fromDate;
				obj.toDate = toDate;
				
				items.push(obj);
			}
			//구매날짜 등(월단위)
			else if(tempType == "MONTH_TERM"){
				
				var condName = tempItems.eq(k).attr('condition');
				
				var fromDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(0).val();
				var toDate = $("#" + tempItems.eq(k).attr('id')).find('input').eq(1).val();
				
				//최종 저장 시 필요한 프롬프트 정보
				promptAttr = {};
				promptAttr.promptCode = tempItems.eq(k).attr('condVal');
				promptAttr.metaCode = tempItems.eq(k).attr('attrId');
				promptAttr.fromDate = fromDate;
				promptAttr.endDate = toDate;
				promptAttr.tempId = nodeId[i-1];
				
				promptList.push(promptAttr);
				
				obj.condName = condName;
				obj.fromDate = fromDate;
				obj.toDate = toDate;
				
				items.push(obj);
			}
			//RADIO, 연령대 등ifvUiRadio
			else if(tempType == "RADIO"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = tempItems.eq(k).find('input:radio:checked');
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue.eq(j).attr('value'));
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue.eq(j).attr('id');
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
			}			
			//멀티 A B 분류, 멀티A = 체크박스, 멀티B = 이동가능 div
			else if(tempType == "MULTIB"){
				
				var condName = tempItems.eq(k).attr('condition');
				var attrListValue = $("#" + 'gridId' + tempItems.eq(k).attr('id') + 'SelectedList').getRowData();
				var attrList = [];
				
				for(var j=0; j<attrListValue.length; j++){
					attrList.push(attrListValue[j].condCode);
					
					//최종 저장 시 필요한 프롬프트 정보
					promptAttr = {};
					promptAttr.promptCode = tempItems.eq(k).attr('condVal');
					promptAttr.metaCode = attrListValue[j].id;
					promptAttr.tempId = nodeId[i-1];
					
					promptList.push(promptAttr);
				}
				
				obj.condName = condName;
				obj.attrList = attrList;
				
				items.push(obj);
				
			}
		}
		
		itemValue.items = items;
		itemValue.tempId = nodeId[i-1];
		itemList.push(itemValue);
	}
	
	var segType = $(':radio[name="templateSet"]:checked').val();
	
	var segCntObj = {
			itemList : itemList, 
			segType : segType, 
			chnlType : $("#chnlType").val() 
	};
	
	//퀵캠페인 / 캠페인워크플로우 분기
    if (typeof campaignSubjectsPopData != "undefined" 
    		&& $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
        //캠페인 워크플로우에서의 세그먼트 유형
        //segCntObj.segType = campaignSubjectsPopData.campaignSegType;
        segCntObj.chnlType = campaignSubjectsPopData.campaignChnlType;
    }
	
	var fatiExceptYn = '0';
	
	//피로도 체크 여부 확인
	if($("input:checkbox[id='fatigueExcept']").is(":checked")){
		fatiExceptYn = '1';
	}
	
	segCntObj.fatiExceptYn = fatiExceptYn;
	
	$.ifvSyncPostJSON('<ifvm:action name="getSegmentCustCnt"/>', segCntObj
			,function(result) {
	
			$("#segAllCount").text(result.targetCustCnt);
			$("#segCalCount").text(result.agreeCust);
			
			memberList = null;
			memberList = result.memberList;
			
			targetCustCnt = result.targetCustCnt;
			agreeCust = result.agreeCust;
			fatiCnt = result.fatiCnt;
			prmsCnt = result.prmsCnt;
			dupCnt = result.dupCnt;
			
			//memIds = [];
			//memIds.push(result.memIds);
			
	});
	
	
}

function addTrFunc( table, list ){
	
	//미선택 항목 숨김
	$(".empty_msg").hide();
	
	for(var i=0; i<list.length; i++){
		table.jqGrid('addRowData', list[i].id, list[i], "last");
	}
};

function moveSelectRow(obj){
	
	
	//선택된 행 저장
	var selectlist = $("#gridId" + obj + "NonSelectedList").getGridParam('selarrrow');
	
	var returnList = [];
	
	//선택된 아이디로 이동할 객체를 찾은 후 저장
	for( var i = 0; i<$("#gridId" + obj + "NonSelectedList").getRowData().length; i++ ){
		
		for(var k=0; k<selectlist.length; k++){
			
			if(selectlist[k] == $("#gridId" + obj + "NonSelectedList").getRowData()[i].id){
				returnList.push($("#gridId" + obj + "NonSelectedList").getRowData()[i]);
			}
		}
	}
	
	while(selectlist.length > 0){
		$("#gridId" + obj + "NonSelectedList").delRowData(selectlist[0]);
	}
	/* for(var j=0; j<selectlist.length; j++){
		//선택된 행 삭제
		$("#gridId" + obj + "NonSelectedList").delRowData(selectlist[j]);
	} */
	
	addTrFunc($("#gridId" + obj + "SelectedList"), returnList);
	
}

function allMoveNonTable(obj){
	
	var allList = $("#gridId" + obj + "NonSelectedList").getRowData();
	
	for(var j=0; j<allList.length; j++){
	//선택된 행 삭제
	$("#gridId" + obj + "NonSelectedList").delRowData(allList[j].id);
	} 

	/* while(allList.length > 0){
		$("#gridId" + obj + "NonSelectedList").delRowData(allList[0].id);
	} */
	
	addTrFunc($("#gridId" + obj + "SelectedList"), allList);
	
	
}

function moveNoRow(obj){
	
	
	//선택된 행 저장
	var selectlist = $("#gridId" + obj + "SelectedList").getGridParam('selarrrow');
	
	var returnList = [];
	
	//선택된 아이디로 이동할 객체를 찾은 후 저장
	for( var i = 0; i<$("#gridId" + obj + "SelectedList").getRowData().length; i++ ){
		
		for(var k=0; k<selectlist.length; k++){
			
			if(selectlist[k] == $("#gridId" + obj + "SelectedList").getRowData()[i].id){
				returnList.push($("#gridId" + obj + "SelectedList").getRowData()[i]);
			}
		}
	}
	
	//선택된 행 삭제
	while(selectlist.length > 0){
		$("#gridId" + obj + "SelectedList").delRowData(selectlist[0]);
	}
	
	/* for(var j=0; j<selectlist.length; j++){
		$("#gridId" + obj + "SelectedList").delRowData(selectlist[j]);
	} */
	
	
	addTrFunc($("#gridId" + obj + "NonSelectedList"), returnList);
}

function allMoveTable(obj){
	
	var allList = $("#gridId" + obj + "SelectedList").getRowData();
	
	for(var j=0; j<allList.length; j++){
	//선택된 행 삭제
	$("#gridId" + obj + "SelectedList").delRowData(allList[j].id);
	} 
	
	/* while(allList.length > 0){
		$("#gridId" + obj + "SelectedList").delRowData(allList[0].id);
	} */
	
	addTrFunc($("#gridId" + obj + "NonSelectedList"), allList);
}

function saveTarget(){

	if(camId != null && camId != '' && camId != 'null'){
		if(saveTargetObj.memberList != null && saveTargetObj.memberList.length > 0){
			
			saveTargetObj.camId = camId;
			saveTargetObj.segType = 'IMP';
			saveTargetObj.fileType = $("#fileType").val();
			saveTargetObj.memType = $(':radio[name="memType"]:checked').val();
			
			//퀵캠페인 / 캠페인워크플로우 분기
            if (typeof campaignSubjectsPopData != "undefined" 
                        && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
                //캠페인 워크플로우에서의 세그먼트 유형
                saveTargetObj.segType = campaignSubjectsPopData.campaignSegType;
                saveTargetObj.chnlType = campaignSubjectsPopData.campaignChnlType;
            }
			
			$.ifvSyncPostJSON('<ifvm:action name="setSegment"/>',saveTargetObj
				,function(result) {
				segName = result.message;
				
				$("#savedArea").show();
				$("#segNameTxt").text(segName);
				
				alert("<spring:message code='M00990'/>");
				
			});
			
		}
		else{
			alert("<spring:message code='M00708'/>");
		}
	}
	else{
		alert("<spring:message code='M00710'/>");
	}
	
	/* if(segName != null){
		saveTargetObj.camId = camId;
		saveTargetObj.segType = 'file';
		saveTargetObj.fileType = $("#fileType").val();
		saveTargetObj.memType = $(':radio[name="memType"]:checked').val();
		
		$.ifvSyncPostJSON('<ifvm:action name="modifySegment"/>',saveTargetObj
				,function(result) {
				$("#savedArea").show();
				alert("<spring:message code='M00990'/>");
				
		});
	}
	else{
		if(camId != null && camId != '' && camId != 'null'){
			if(saveTargetObj.memIds != null && saveTargetObj.memIds.length > 0){
				
				saveTargetObj.camId = camId;
				saveTargetObj.segType = 'file';
				saveTargetObj.fileType = $("#fileType").val();
				saveTargetObj.memType = $(':radio[name="memType"]:checked').val();
				
				
				$.ifvSyncPostJSON('<ifvm:action name="setSegment"/>',saveTargetObj
					,function(result) {
					segName = result.message;
					
					$("#savedArea").show();
					$("#segNameTxt").text(segName);
					
					alert("<spring:message code='M00990'/>");
					
				});
				
			}
			else{
				alert("<spring:message code='M00708'/>");
			}
		}
		else{
			alert("<spring:message code='M00710'/>");
		}
	} */
	
}

//공통코드 파일 유형 조회
function fileType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FILE_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#fileTypeTemplate").tmpl(result.rows);
		$("#fileType").append(temp);
		
	});
}; 

//세그먼트 템플릿 설정 코드 조회
function templateType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAL_TYPE'
		, enableNA : true
	},function(result) {
		
		var temp = $("#templateTypeTemplate").tmpl(result.rows);
		$("#templateTypeWrap").append(temp);
		
	});
}; 


/* 팝업 닫기 */
function segmentPopupClose(){
	segmentPopupCon.destroy();
}

//실패사유 포맷
function failGridFormat(cellValue, options, rowdata){

	
	var message = '';
	var sucessFlag = true; 
	
	//내부고객용
	if($(':radio[name="memType"]:checked').val() == 'internal'){
		
	
		var message = '';
		var sucessFlag = true; 
		
		//내부고객용
			if(rowdata.memberYn != null && rowdata.memberYn == 0){
				
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
				
			}
			
			else if(rowdata.failFlag != null && rowdata.failFlag == '1'){
				
				//tm수신동의여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			} 
			
	}
	else{	//외부고객용
		
		if(rowdata.duplicateDeleteYn != null && rowdata.duplicateDeleteYn == 1){
			
			//중복 삭제 여부
			if(message.length > 0){
				message += ',';
			}
			message += "<spring:message code='M00692'/>";
			
			//비동의일 때 이미지
			var imgFullPath = "<ifvm:image name='upload_red'/>";
			sucessFlag = false; 
		}
	
		if($("#chnlType").val() != 'EMAIL'){ //sms, mms, lms 등 체크
			
			if(rowdata.hpYn != null && rowdata.hpYn != 1){
				
				//핸드폰번호유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00695'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
		}
		else{ //이메일 체크
			
			if(rowdata.emailYn != null && rowdata.emailYn != 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00698'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
			else if(rowdata.permissionCheckDeleteYn != null && rowdata.permissionCheckDeleteYn == 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M01017'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
				
			}
		
			if(rowdata.memNameYn != null && rowdata.memNameYn != 1){
				
				//이메일주소유무여부
				if(message.length > 0){
					message += ',';
				}
				message += "<spring:message code='M00850'/>";
				
				//비동의일 때 이미지
				var imgFullPath = "<ifvm:image name='upload_red'/>";
				sucessFlag = false; 
			}
			
		
		}
		
	}
	
	
	if(sucessFlag){
		message += "<spring:message code='M00253'/>";
		var imgFullPath = "<ifvm:image name='upload_green'/>";
	}
	
	var tempHtml = "<img src='" + imgFullPath + "' alt='' />";
	tempHtml += "<span class='grid_inner_text'>"+ message +"</span>";
	
	return tempHtml;
	 
}

//업로드 회원정보 그리드
function uploadMemberInfoGridFunc(){
	var jqGridOption = {
		/* serializeGridData : function( data ){
			
		},			
		loadComplete : function(obj){
			
		}, */
		data : gridData,
		datatype: 'clientSide',
	    //url:'<ifvm:action name="getContenttypeList"/>',
	    colNames:['<spring:message code="M00688"/>',
	              '<spring:message code="M00689"/>', 'mobileFlag', 'emailFlag', 'smsConFlag',  'emailConFlag'],
	    colModel:[
	        {name:'memberId',index:'', resizable : false},
	        {name:'memFlag',index:'', resizable : false, formatter: failGridFormat},
	        {name:'mobileFlag',index:'', resizable : false, hidden : true},
	        {name:'emailFlag',index:'', resizable : false, hidden : true},
	        {name:'smsConFlag',index:'', resizable : false, hidden : true},
	        {name:'emailConFlag',index:'', resizable : false, hidden : true}
	    ],
	    rowList : [10000],
	    tempId : 'uploadMemInfoTemplete',
	    caption : '<spring:message code="M00684"/>'
	};
	uploadMemberInfoGrid = $("#uploadMemberInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
	
	setMemberSearch();
}


function setMemberSearch() {
	var searchTypeL = $('#searchTypeL option:selected').val();
	var searchKeyL = $('#searchKeyL').val();

	if(searchKeyL == '') {
	 	for(var i = 1; i <= gridData.length; i++) {
	 		$('#gridIduploadMemberInfoGrid tbody tr').eq(i).show();
	 	}
	} else {
	 	for(var i = 1; i <= gridData.length; i++) {
	 		var tdValue;
			if(searchTypeL == '0')	 		
				tdValue = $('#gridIduploadMemberInfoGrid tbody tr').eq(i).children('td').eq(searchTypeL).text();
			else 
				tdValue = $('#gridIduploadMemberInfoGrid tbody tr').eq(i).children('td').eq(searchTypeL).children('span').text();
			if(tdValue.indexOf(searchKeyL) > -1)
				$('#gridIduploadMemberInfoGrid tbody tr').eq(i).show();
			else
				$('#gridIduploadMemberInfoGrid tbody tr').eq(i).hide();			
		} 
	}
}

function enterCheck(evt){
	var code = evt.which?evt.which:event.keyCode;
	if(code == 13){
	
		setMemberSearch();
		return false;
	}
}

//업로드 결과 건수 그리드
function uploadResultNumberGridFunc(){
	var jqGridOption = {
		/* serializeGridData : function( data ){
			
		},			
		loadComplete : function(obj){
			
		}, */
		data : uploadData,
		datatype: 'clientSide',
	    //url:'<ifvm:action name="getContenttypeList"/>',
	    colNames:['<spring:message code="M00690"/>',
	              '<spring:message code="M00691"/>'],
	    colModel:[
	        {name:'name',index:'', resizable : false},
	        {name:'uploadCnt',index:'', resizable : false}
	    ],
	    sortname: '',
		sortorder: "desc",
	    tempId : 'uploadResultTemplete',
	    caption : '<spring:message code="M00685"/>'
	};
	uploadResultNumberGrid = $("#uploadResultNumberGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//데이터세팅
function setCustomerInfo(segmentFlag) {
	
	var segFlag = "";
	
	if(segmentFlag != null){
		segFlag = segmentFlag;
	}
	
	$("#tempTable1").empty();	
	$("#tempTable2").empty();	
	
	if(nodeId.length > 0) {
		for(var i = 0; i < nodeId.length; i++) {
			$.ifvSyncPostJSON('<ifvm:action name="getTemplatePromptInfo"/>',{
				templateId : nodeId[i], segFlag : segFlag, camId : camId
			},function(result) {
				
				tableObj = [];
				for(var j = 0; j < result.rows.length; j++) {
					var obj = {};
					obj.seq = result.rows[j].promptSeq + i;
					obj.unique = result.rows[j].essentialVal;
					obj.condName = result.rows[j].condName;
					obj.rable = result.rows[j].promptLabel;
					obj.desc = result.rows[j].promptDesc;
					obj.type = result.rows[j].promptType;
					
					//var selectedId = $("#gridIdtaskList").children().children().eq(i).children('td[aria-describedby="gridIdtaskList_condName"]').find('select option:selected').attr('id');
					obj.rowId = 'tempTable' + (i+1) + 'row' + i;
					obj.condVal = result.rows[j].promptId;
					obj.promptAttrList = result.rows[j].promptAttrList;
					obj.promptAttrs = result.rows[j].promptAttrs;
					
					
					//장용 추가
					var attrIdList = [];
					
					for(k=0; k<result.rows[j].promptAttrList.length; k++){
						
						attrIdList.push(result.rows[j].promptAttrList[k].attrId);
						
					}
					
					obj.attrId = attrIdList;
					
					var attrValueList = [];
					
					for(k=0; k<result.rows[j].promptAttrList.length; k++){
						
						attrValueList.push(result.rows[j].promptAttrList[k].condName);
						
					}
					
					obj.attrValue = attrValueList;
					
					var attrCodeList = [];
					
					for(k=0; k<result.rows[j].promptAttrList.length; k++){
						
						attrCodeList.push(result.rows[j].promptAttrList[k].condCode);
						
					}
					
					obj.attrCode = attrCodeList;
					
					
					
					//obj.selectRowId = $("#gridIdtaskList").children().children().eq(i).attr('id');
					
					tableObj.push(obj);
					
				}				
			});
			uiSetting(i);			
		}
		

	} else {
		$('#tempTable1').empty();
		$('#tempTable2').empty();
	}
}

function uiSetting(num){
	//asd
	
	var OtherProdHtml = '';
	for(var i=0; i<tableObj.length; i++){
		
	
		var tempData = {seq:tableObj[i].seq
				, condName:tableObj[i].condName
				, condVal:tableObj[i].condVal
				, rable:tableObj[i].rable
				, desc:tableObj[i].desc
				, unique:tableObj[i].unique
				, promptAttrList:tableObj[i].promptAttrList
				, type:tableObj[i].type
				, promptAttrs:tableObj[i].promptAttrs
				, attrId:tableObj[i].attrId
				, attrValue:tableObj[i].attrValue
				, rowId:tableObj[i].rowId	
				, attrCode:tableObj[i].attrCode	
				};
/* 			for(i=0; i < attrCheckValue.length; i++) {
			if(attrcheckValue[i].rowId == tempData.selectRowId) {
				var selectedDataId = 					
			}
		} */
		if(tableObj[i].type == "DDLB" || tableObj[i].type == "DATE"){
			OtherProdHtml = $("#ifvUiDdlb").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			
			//데이터 셋팅
			
			if(tempData.promptAttrs != null && tempData.promptAttrs.length > 0){
				$("#" + tempData.seq).find("[id=" + tempData.condVal + "]").val(tempData.promptAttrs[0].attrId);
			}
			//id값 받을 경우 id값으로 변경
		}
		//Y/N플래그 등
		else if(tableObj[i].type == "CHECK"){
			OtherProdHtml = $("#ifvUiCheck").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			
			if(tempData.promptAttrs != null && tempData.promptAttrs.length > 0){
				$("#" + tempData.seq).find("[id=" + tempData.promptAttrs[0].attrId + "]").attr('checked', 'checked');
			}
		}
		//구매금액 등
		else if(tableObj[i].type == "NUMBER"){
			OtherProdHtml = $("#ifvUiNumber").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			
			if(tempData.promptAttrs != null && tempData.promptAttrs.length > 0){
				$("#" + tempData.seq).find("[id='fromNumTemp']").val(tempData.promptAttrs[0].fromNum);
				$("#" + tempData.seq).find("[id='toNumTemp']").val(tempData.promptAttrs[0].toNum);
			}
		}
		//구매날짜 등
		else if(tableObj[i].type == "TERM"){
			
			OtherProdHtml = $("#ifvUiTerm").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			setCalendar(tableObj[i].rowId + 'FromDate', tableObj[i].rowId + 'ToDate', tableObj[i].promptAttrs[0].fromDate, tableObj[i].promptAttrs[0].toDate);				
		}
		//구매날짜 등(월단위)
 		else if(tableObj[i].type == "MONTH_TERM"){
			OtherProdHtml = $("#ifvUiMonthTerm").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			setMonthCalendar(tableObj[i].rowId + 'FromDate', tableObj[i].rowId + 'ToDate', tableObj[i].promptAttrs[0].fromDate, tableObj[i].promptAttrs[0].toDate);				
		} 
		//RADIO, 연령대 등ifvUiRadio
		else if(tableObj[i].type == "RADIO"){
			OtherProdHtml = $("#ifvUiRadio").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			
			if(tempData.promptAttrs != null && tempData.promptAttrs.length > 0){
				$("#" + tempData.seq).find("[id=" + tempData.promptAttrs[0].attrId + "]").attr('checked', 'checked');
			}
		}			
		//멀티 A B 분류, 멀티A = 체크박스, 멀티B = 이동가능 div
		else if(tableObj[i].type == "MULTIA"){
			OtherProdHtml = $("#ifvUiMultia").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
			
			
			for(var k=0; k<tempData.promptAttrs.length; k++){
				$("#" + tempData.seq).find("[id=" + tempData.promptAttrs[k].attrId + "]").attr('checked', 'checked');
			}
			
		}
		else if(tableObj[i].type == "MULTIB"){
			
			OtherProdHtml = $("#ifvUiMultib").tmpl(tempData);
			$("#tempTable" + (num+1)).append(OtherProdHtml);
  			var objList = [];
			var anotherList = {};
			anotherList.attrId = tempData.attrId;
			anotherList.attrValue = tempData.attrValue;
			anotherList.condCode = tempData.attrCode;
			
			for(var l=0; l < tableObj[i].promptAttrs.length; l++) {
				for(var k=0; k < tableObj[i].attrId.length; k++){
					if(tableObj[i].promptAttrs[l].attrId == tableObj[i].attrId[k]){
						var obj = {};
						obj.name = tableObj[i].promptAttrs[l].condName;
						obj.id = tableObj[i].promptAttrs[l].attrId;
						obj.condCode = tableObj[i].promptAttrs[l].condCode;
						objList.push(obj);
						for(var j=0; j < anotherList.attrId.length; j++) {
							if(anotherList.attrId[j] == obj.id) {
								anotherList.attrId.splice(j,1);
								anotherList.attrValue.splice(j,1);
								anotherList.condCode.splice(j,1);
							}
						}
					}
 				}
			}
 			var selectedList = selectedListInit(tableObj[i].seq + 'SelectedList', objList);				
			var nonSelectedList = nonSelectedListInit(tableObj[i].seq + 'NonSelectedList', anotherList); 
		}
	}
	
	//setUiData();
}

function setCalendar(fromDate, toDate, fromDD, toDD) {
	
	var startDate = $("#" + fromDate); 
	var endDate = $("#" + toDate); 
	startDate.val(fromDD);
	endDate.val(toDD);
	
/* 	startDate.val($.ifvGetNewDate('d', 0).newDateS);
	endDate.val($.ifvGetNewDate('d', 1).newDateS);
 */	
	startDate.ifvDateChecker({
		maxDate : endDate
	});
	
	endDate.ifvDateChecker({
		minDate : startDate
	});
}

function setMonthCalendar(fromDate, toDate, fromDD, toDD) {
	var startDate = $("#" + fromDate); 
	var endDate = $("#" + toDate);

	initCal({id:fromDate,type:"mon",min:'1900',max:'2500'});			
	initCal({id:toDate,type:"mon",min:'1900',max:'2500'});
	
	startDate.val(fromDD);
	endDate.val(toDD);
	
/* 	startDate.val($.ifvGetNewDate('d', 0).newDateS);
	endDate.val($.ifvGetNewDate('d', 1).newDateS);
 */	
}

function setMonthCalValue(dateId) {
	return;
}

function nonSelectedListInit(nonSelectedList, tempData){
 	
	 var objList = [];
	
	for(var k=0; k<tempData.attrValue.length; k++){
		
		var obj = {};
		obj.id = tempData.attrId[k];
		obj.name = tempData.attrValue[k];
		obj.condCode = tempData.condCode[k];
		
		objList.push(obj);
		
	} 
	
	var jqGridOption = {
		data : objList,
		datatype: 'clientSide',
        colNames:[ 'id', 'condCode', '<spring:message code="M00662"/>'],
        colModel:[
            { name:'id', sortable : false, resizable : false, hidden : true }, 
            { name:'condCode', sortable : false, resizable : false, hidden : true }, 
            { name:'name', sortable : false, resizable : false }, 
        ],
        multiselect: true,
        ajaxGridOptions : { async : false },
        width : 350,
        rowList : [100],
        tempId : 'listGridTemplete'
    };
		
	return $("#" + nonSelectedList).ifvGrid({ jqGridOption : jqGridOption }); 
}

function selectedListInit(selectedList, tempData){
	
	var jqGridOption = {
		data : tempData,
		datatype: 'clientSide',
        colNames:[ 'id', 'condCode', '<spring:message code="M00661"/>'],
        colModel:[
            { name:'id', sortable : false, resizable : false, hidden : true }, 
            { name:'condCode', sortable : false, resizable : false, hidden : true }, 
            { name:'name', sortable : false, resizable : false }
        ],
        multiselect: true,        
        width : 350,
        ajaxGridOptions : { async : false },
        rowList : [100],
        tempId : 'listGridTemplete'
    };
	
	return $("#" + selectedList).ifvGrid({ jqGridOption : jqGridOption });
}

/* function setUiData() {
  	for(var i=0; i < attrCheckValue.length; i++) {
		if(attrCheckValue[i].metaType == 'RADIO' || attrCheckValue[i].metaType == 'MULTIA' || attrCheckValue[i].metaType == 'CHECK') {
			$('div').find('[selectRowId="' + attrCheckValue[i].rowId + '"]').find('#' + attrCheckValue[i].checkId).attr('checked', 'checked');
		} else if(attrCheckValue[i].metaType == 'DDLB' || attrCheckValue[i].metaType == 'DATE') {
			$('div').find('[selectRowId="' + attrCheckValue[i].rowId + '"]').find('[value="' + attrCheckValue[i].checkId + '"]').attr('selected', 'selected');
		} else if(attrCheckValue[i].metaType == 'NUMBER') {
			$('#' + attrCheckValue[i].rowId + 'FromNum').val(attrCheckValue[i].fromNum);
			$('#' + attrCheckValue[i].rowId + 'ToNum').val(attrCheckValue[i].toNum);
  		} else if(attrCheckValue[i].metaType == 'TERM'){
			$('#' + attrCheckValue[i].rowId + 'FromDate').val(attrCheckValue[i].fromDate);
			$('#' + attrCheckValue[i].rowId + 'ToDate').val(attrCheckValue[i].toDate);
  		}
	} 
} */

function segmentLoad(){
	var obj = $.ifvCachedHtml('<ifvm:url name="userMainLoad"/>');
	$('#segmentContent').html(obj.responseText);
	loadUiSetting();
}

$(document).ready(function(){
	
	$("#segConfirmWrap").hide();
	
	//세그먼트 load
	segmentLoad();
	
	//저장 문구 숨김
	$("#savedArea").hide();
	
	//업로드 결과 영역 최초 하이드
	$("#uploadResult").hide();
	
	//템플릿 설정 조회
	templateType();
	
	//공통코드 파일 유형 조회
	fileType();
	
	
	//저장버튼 클릭 시
	$("#targetSaveBtn").on('click', function(){
		saveTarget();
	});
	
	//파일 다운로드 버튼 클릭 시 
	$("#fileDownload").on('click', function(){
		
		
		if($(':radio[name="memType"]:checked').val() == 'internal'){
			qtjs.href('<ifvm:url name="fileDownload"/>/internalCustomer.csv');
		}
		else{
			qtjs.href('<ifvm:url name="fileDownload"/>/externalCustomer.csv');
		}
		
		
		//혜정샘 파일서버에서 올련호고 다운로드 할때 경로좁 잡아주세요 , 파일서버에 파일은 잇어요 밑에 경로
		//${pageContext.request.contextPath} + "resources/uploadImages/CSV_File/sample.xlsx";
	});
	
	
	//uploadMemberInfoGrid();
	//uploadResultNumberGrid();
	
	//파일 검색 클릭 시
	$("#searchFile").on("click", function(){
		$("#hideFile").trigger("click");
	});
	//세그먼트 라디오 클릭 시
	$("#segmentRadio").on("click", function(){
		$("#segmentConArea").show();
		$("#uploadConArea").hide();
	});
	//업로드 라디오 클릭 시
	$("#uploadRadio").on("click", function(){
		$("#segmentConArea").hide();
		$("#uploadConArea").show();
	});
	
	//파일 검색 클릭 후 파일 선택 시 실행
	$("#hideFile").on("change", function(){
		
		$("#savedArea").hide();
		
		var validationCheck = false;
		
		if($("#fileType").val() == 'CSV'){
			if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv'){
				validationCheck = true;
			}
		}
		else{
			if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx' || $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls'){
				validationCheck = true;
			}
		}
		
		if(validationCheck){
			
			if(($("#hideFile")[0].files[0].type.split('/')[1]=='vnd.ms-excel') || $("#hideFile")[0].files[0].type.split('/')[1]== 'vnd.openxmlformats-officedocument.spreadsheetml.sheet'){
					
				memId = [];

					var formData = new FormData();
					//파일업로드
					formData.append("file", $("#hideFile")[0].files[0]);  
					//회원 구분
					formData.append("memType", $(':radio[name="memType"]:checked').val());
					//파일유형
					formData.append("uploadFileType", $("#fileType").val());
					//타겟 방법
					formData.append("tgtType", $(':radio[name="targetMethod"]:checked').val());
					
					var fatiExceptYn = '0';
					
					//피로도 체크 여부 확인
					if($("input:checkbox[id='fatigueExcept']").is(":checked")){
						fatiExceptYn = '1';
					}
					
					//피로도 제외 여부
					formData.append("fatiExceptYn", fatiExceptYn);
					
					//채널 유형
					
					if(typeof $("#chnlType").val() == 'undefined' || $("#chnlType").val() == null || $("#chnlType").val() == 'null' || $("#chnlType").val() == ''){
						formData.append("chnlType", "");	
					}
					else if($("#chnlType").val() == 'EMAIL'){
						formData.append("chnlType", "EMAIL");
					}
					else if($("#chnlType").val() == 'PUSH'){
						formData.append("chnlType", "PUSH");
					}
					else if($("#chnlType").val() == 'SMS'){
						formData.append("chnlType", "SMS");
					}
					else{
						formData.append("chnlType", "MMS");
					}
					

					
					formData.append("appServiceId", appServiceId);
					formData.append("country", country);
					formData.append("lang", lang);

					$.ajax({
						url: '<ifvm:action name="setFileUpload"/>',
						data: formData,
						processData: false,
						contentType: false,
						type: 'POST',
							success: function(data){	

							if(data.errorType == 200410){
								qtjs.href('<ifvm:url name="MKTLogin"/>');
							}
							//최종저장 시 사용 객체
							saveTargetObj.dupCnt = data.dupCnt;
							//saveTargetObj.allUploadCnt = data.allUploadCnt;
							saveTargetObj.targetCustCnt = data.targetCustCnt;
							saveTargetObj.fileName = data.fileName;
							saveTargetObj.memberList = data.memberList;
							//saveTargetObj.successCnt = data.successCnt;
							saveTargetObj.agreeCust = data.agreeCust;
							saveTargetObj.failCnt = data.failCnt;
							saveTargetObj.fatiCnt = data.fatiCnt;
							saveTargetObj.prmsCnt = data.prmsCnt;
							
							//파일 순서 결정
							if( $(':radio[name="memType"]:checked').val() != 'internal'){
								data.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
							}
							
							$("#fileConfirmTextArea").text("<spring:message code='M00687'/>");
							gridData = null;
							$("#uploadMemberInfoGrid").empty();
							
							//업로드 결과 회원 정보 조회
							gridData = data.memberList;
							uploadMemberInfoGridFunc();
							
							//업로드 결과 건수 조회
							var resultGridList = new Array();
							var resultAllCnt = {};
							var resultSuccessCnt = {};
							var resultFailCnt = {};
							
							
							resultAllCnt.name = "<spring:message code='M00700'/>";
							resultAllCnt.uploadCnt = data.targetCustCnt;
							
							resultSuccessCnt.name = "<spring:message code='M00701'/>";
							resultSuccessCnt.uploadCnt = data.agreeCust;
							
							resultFailCnt.name = "<spring:message code='M00702'/>";
							resultFailCnt.uploadCnt = data.failCnt;
							
							resultGridList.push(resultAllCnt);
							resultGridList.push(resultSuccessCnt);
							resultGridList.push(resultFailCnt);
							
							uploadData = resultGridList;
							
							uploadResultNumberGridFunc();
							
							$("#uploadResult").show();
							//setPopHeight();	//campaignSubjectsPop.jsp에 함수 정의
						}
					});  
					
					/* var obj = {};
					
					var formData = new FormData();
					formData.append("file", $("#hideFile")[0].files[0]);      
					
					obj.file = formData;
					obj.memType = $(':radio[name="memType"]:checked').val();
					
					$.ifvSyncPostJSON('<ifvm:action name="setFileUpload"/>', obj //{offerTypeCd : obj}
					,function(result) {
						gridData = null;
						$("#uploadMemberInfoGrid").empty();
						gridData = data.items;
						uploadMemberInfoGridFunc();
						uploadResultNumberGrid();
						
						$("#uploadResult").show();
					});  */
			}else{
				alert("<spring:message code='M00703'/>");
				$("#hideFile").removeAttr("value");
			}	
			
			//초기화
			$("#hideFile").val("");
			
		}
		else{
			alert("<spring:message code='M00703'/>");
			$("#hideFile").removeAttr("value");
		}
			
			
	});
	
	

});


</script>

<script id="templateTypeTemplate" type="text/x-jQuery-tmpl">
	<div class="col-xs-3 text-center">
		<label class="radio-inline">
			{{if codeName == 'UNION'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio" checked="true" />
			<img src="<ifvm:image name='set_union'/>" alt="" />
			{{/if}}
			{{if codeName == 'INTERSECTION'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_intersection'/>" alt="" />
			{{/if}}
			{{if codeName == 'A_DIFF_SET'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_a'/>" alt="" />
			{{/if}}
			{{if codeName == 'B_DIFF_SET'}}	
			<ifvm:input type="radio" names="templateSet" values="${'${'}codeName}" className="segment_template_radio"/>
			<img src="<ifvm:image name='set_b'/>" alt="" />
			{{/if}}
		</label>
	</div>
</script>

<script id="fileTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="uploadMemInfoTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="left">
				<select id="searchTypeL">
					<option value="0">회원번호</option>
					<option value="1">실패사유</option>
				</select>
				<input type="text" id="searchKeyL" onkeypress="enterCheck(event)"/>
				<a href="javascript:setMemberSearch();" id="searchBtnL" class="ifv_search_box_search_btn">검색</a>
			</div>
		</div>
	
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			<div class="total_area">{total}</div>	
		<div>
	</div>
</script>
<script id="uploadResultTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>


<script id="listGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<!-- For Targeting Template -->
<script id="ifvUiCheck" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_check" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
		{{each(key, val) attrValue}}
			<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px;">
				<ifvm:input type="radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}" names="${'${'}seq}check"/><label>${'${'}val}</label>
			</div>
		{{/each}}
		</div>
	</div>
</script>

<script id="ifvUiDdlb" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_ddlb" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10">
			<select class="form-control" id="${'${'}condVal}">
			{{each(key, val) attrValue}}
				<option id="${'${'}key}" value="${'${'}attrId[key]}" condName="${'${'}attrCode[key]}">${'${'}val}</option>
			{{/each}}
			</select>
		</div>
	</div>
</script>

<script id="ifvUiRadio" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_radio" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		{{each(key, val) attrValue}}
			{{if key%2 == 0}}
				<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px">
				<ifvm:input type="radio"  names="${'${'}seq}radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label><br />
				{{if attrValue.length-1 == key}}
					</div>
					</div>
				{{/if}}
				{{else}}
					<ifvm:input type="radio"  names="${'${'}seq}radio" id="${'${'}attrId[key]}" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label>
					</div>
				{{if attrValue.length-1 == key}}
					</div>
				{{/if}}
			{{/if}}
		{{/each}}
	</div>
</script>

<script id="ifvUiMultia" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_multia" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		

		{{each(key, val) attrValue}}
			{{if key%2 == 0}}
				<div class="row form-horizontal col-xs-6" style="padding-bottom : 0px">
				<input type="checkbox" id="${'${'}attrId[key]}" names="${'${'}seq}multiA" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label><br />
				{{if attrValue.length-1 == key}}
					</div>
					</div>
				{{/if}}
				{{else}}
					<input type="checkbox" id="${'${'}attrId[key]}" names="${'${'}seq}multiA" values="${'${'}attrCode[key]}"/><label>${'${'}val}</label>
					</div>
				{{if attrValue.length-1 == key}}
					</div>
				{{/if}}
			{{/if}}
		{{/each}}

		
	</div>
</script>

<script id="ifvUiNumber" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_num" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="number" id="fromNumTemp" names="request" className="text-right"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="number" id="toNumTemp" names="request" className="text-right"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiTerm" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_term" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="date" id="${'${'}rowId}FromDate" readonly="true"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="date" id="${'${'}rowId}ToDate" readonly="true"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiMonthTerm" type="text/x-jQuery-tmpl">
	<div class="col-sm-6 seg_box seg_term" id="${'${'}seq}" condition = "${'${'}condName}" attrId="${'${'}attrId}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<label class="col-sm-2 control-label">${'${'}rable}</label>
		<div class="col-sm-10 control_content">
			<div class="col-sm-6 pd0 cal_frt">
				<div class="input">
					<ifvm:input type="text" id="${'${'}rowId}FromDate" readonly="true"/>
				</div>
			</div>
			<div class="col-sm-1 swung_dash text-center">~</div>
			<div class="col-sm-6 pd0 cal_scd">
				<div class="input">
					<ifvm:input type="text" id="${'${'}rowId}ToDate" readonly="true"/>
				</div>
			</div>
		</div>
	</div>
</script>

<script id="ifvUiMultib" type="text/x-jQuery-tmpl">
	<div class="col-sm-12 qt_border seg_box seg_multib" id="${'${'}seq}" condition = "${'${'}condName}" condVal = "${'${'}condVal}" rable= "${'${'}rable}" promptDesc = "${'${'}desc}" essentialVal = "${'${'}unique}" promptType = "${'${'}type}">
		<div class="row form-horizontal qt_border col-xs-12" style="padding-bottom : 0px"><label>${'${'}rable}</label></div>
		<div class="col-sm-12 qt_border">
			<table>
				<tbody>
					<tr>
						<td style="width:47%; vertical-align:top;">
							<div id="${'${'}seq}NonSelectedList"></div>
						</td>
						<td class="move_list" style="width:6%;">
							<button onClick="javascript:moveSelectRow(${'${'}seq});" class="next_btn"></button>
							<button onClick="javascript:allMoveNonTable(${'${'}seq});" class="last_btn"></button>
							<button onClick="javascript:moveNoRow(${'${'}seq});" class="prev_btn"></button>
							<button onClick="javascript:allMoveTable(${'${'}seq});" class="first_btn"></button>
						</td>
						<td style="width:47%; vertical-align:top;">
							<div id="${'${'}seq}SelectedList"></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>	
	</div>

</script>

<style>
#uploadConArea{display:none;}
#hideFile {display:none}
#uploadMemberInfoGrid .grid_con{height:173px; overflow-x:hidden; overflow-y:auto;}
/* #tempTable1:before, #tempTable1:after, #tempTable2:before, #tempTable2:after {content: ' '; display: table; clear: both;} */
.campaign_load_contents .ui-th-ltr, .campaign_load_contents .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr:first-child {border-left: 1px solid #dddddd;}
#searchTypeL {width: 150px; float: left; height: 25px; margin-right: 3px;}
#searchKeyL {width: 200px; float: left; height: 25px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00619"/>
	</h1>
</div>
<div id="targetingConArea">
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M00621"/></span>
		</div>
	</div>
	<div class="well form-horizontal well_sum">
		<div class="row">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00665"/></label>	
			<div class="col-xs-10 control_content">
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="segment" checked="true" id="segmentRadio" />
					<spring:message code="M00666"/>
				</label>
				<label class="radio-inline">
					<ifvm:input type="radio" names="targetMethod" values="upload" id="uploadRadio" />
					<spring:message code="M00667"/>
				</label>
			</div>
		</div> 
	</div>
</div>
<!-- 세그먼트 -->
<div id="segmentConArea">
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M00666"/></span>
		</div>
	</div>
		
	<div class="well form-horizontal well_wrap pad0" id="segmentContent">
		
		
	</div>
</div>

<!-- 업로드 -->
<div id="uploadConArea">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00667"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id="fileDownload">
				<spring:message code="M00704"/>
				<%-- <a href= '<ifvm:url name="fileDownload"/>/sample.csv'></a> --%>
			</button> 
			<button class="btn btn-sm btn_gray" id="searchFile">         
				<spring:message code="M00681"/>
			</button> 
				<ifvm:input type="file" id="hideFile"/>
			<button class="btn btn-sm btn_gray" id="targetSaveBtn">    
				<i class="glyphicon glyphicon-check"></i>     
				<spring:message code="M00280"/>
			</button>  
		</div>
	</div>
		
	<div class="well form-horizontal well_wrap">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00682"/></label>	
			<div class="col-xs-2 control_content">
				<ifvm:input type="select" id="fileType"/> 
			</div>
			
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00705"/></label>
			<div class="col-xs-3 control_content">
				<label class="radio-inline">
					<ifvm:input type="radio" names="memType" values="internal" checked="true" id="internalMem" />
					<spring:message code="M00706"/>
				</label>
				<label class="radio-inline">
					<ifvm:input type="radio" names="memType" values="external" id="externalMem" />
					<spring:message code="M00707"/>
				</label>
			</div>
			
			
		</div>
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00683"/></label>	
			<div class="col-xs-10 control_content">
				<span class="detail_txt" id="fileConfirmTextArea"><spring:message code="M00686"/></span> 
			</div>
		</div>
		
<!-- 파일 업로드 결과 영역 -->
	<div id="uploadResult">
			<div class="row">
				<div class="col-xs-6">
					<div id="uploadMemberInfoGrid"></div>
				</div>
				<div class="col-xs-6 upload_grid_right">
					<div id="uploadResultNumberGrid"></div>
					<div class="multi_description" id="savedArea">
						<p><spring:message code="M00676"/></p>
						<p>(<spring:message code="M00677"/>: <span id="segNameTxt"></span>)</p>
					</div>
				</div>
			</div>
	</div>
	</div>
</div>


<div id="segmentPopupCon" class="popup_container"></div>