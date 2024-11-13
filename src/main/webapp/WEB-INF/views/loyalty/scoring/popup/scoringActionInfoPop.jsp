<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
/**
 * Action, Rule 정보팝업에서 동일한 ruleFilterSetPop.jsp 를 사용하므로
 * 참조할 룰 필터설정 데이터셋을 분기치기 위해 사용 
 */
var currentPopup = "scoringActionInfoPop";

//grid
var actionInfoListGrid;
var gridIdactionInfoListGrid;

/**
 * 그리드 width Resize
 */
function actionInfoGridResize() {
	var w = $("#dialogPopupWrap").width();
	actionInfoListGrid.setWidth(w);
}

var actionInfoPopValidation;

var nodeTypeCd = "ACT";

var actionInfoPopData = {
		etScoringAct: {
			actVal: {}	
		},
		etScoringCond: {
			condValList: []			
		}
		, lgcCompColumnList: []
		, lgclCmpntId : ""
		, operTypeCodeList: []
		, logicOperCodeList: ['AND', 'OR']
		, selRowData: {}
}

//삭제 formatter
function delFormat(cellValue, options, rowdata){
	var html = '<button class="analysisFilterRowMinusBtn" id="del_' + options.rowId + '" onClick="delActionInfoListGridTr(this)"><img src="/resources/images/marketing/common/btn_minus.gif" alt=""></button>';
	
	return html;
}

//and/or formatter
function lcLogicOperFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	
	var select = "<select class='lcLogicOper' id='lcLogicOper_" + options.rowId + "' name='lcLogicOper_" + options.rowId + "'>"  ;
	//option
	$.each(actionInfoPopData.logicOperCodeList, function(index, data){
		if (data == value) {
			select += "<option codeId='" + data + "' value='" + data + "' selected >"+ data +"</option>";
		} else {
			select += "<option codeId='" + data + "' value='" + data + "'>"+ data +"</option>";
		}
	});
    select += "</select>";
    return select;
}

//( formatter
function lcLeftbrktFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";	
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var id = "lcLeftbrkt_" + options.rowId;
	
	var html = "<input id='" + id + "' type='checkbox'>"
	
	if (value == "1") {
		html = "<input id='" + id + "' type='checkbox' checked>"
	}
	
	return html;
}

//) formatter
function lcRightbrktFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";	
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var id = "lcRightbrkt_" + options.rowId;
	
	var html = "<input id='" + id + "' type='checkbox'>"
	
	if (value == "1") {
		html = "<input id='" + id + "' type='checkbox' checked>"
	}
	
	return html;
}

//기준필드 formatter
function lgclFldFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var select = "<select class='lgclFld' id='lgclFld_" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(actionInfoPopData.lgcCompColumnList, function(index, data){
		if (data.id == value) {
			select += "<option codeId='" + data.id + "' value='" + data.id + "' selected >"+ data.displayName +"</option>";
		} else {
			select += "<option codeId='" + data.id + "' value='" + data.id + "'>"+ data.displayName +"</option>";
		}
	});
    select += "</select>";
    return select;
}

//연산자 formatter
function lcCompOperFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var select = "<select class='lcCompOper' id='lcCompOper_" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(actionInfoPopData.operTypeCodeList, function(index, data){
		if (data.codeName == value) {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "' selected >"+ data.markName +"</option>";
		} else {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "'>"+ data.markName +"</option>";
		}
	});
    select += "</select>";
    return select;
}

//값 formatter
function lcCompValFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	
	var html = '<div class="input-group">'
        	+'<input type="text" id="lcCompVal_' + options.rowId + '" class="search_input" value="' + value + '">'
//             +'<span class="input-group-addon colValPopupOpenBtn" name="colVal_' + options.rowId + '" id="colVal_' + options.rowId + '" >'
//             +'<a><i class="fa fa-search"></i></a>'
//             +'</span>' 
            +'</div>'
    
	return html;
}

//부여점수 formatter
function irreglrRtnFldValFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	/*
	var html = '<div class="input-group">'
        	+'<input type="text" id="lcCompVal_' + options.rowId + '" class="search_input" value="' + value + '">'
            +'<span class="input-group-addon colValPopupOpenBtn" name="colVal_' + options.rowId + '" id="colVal_' + options.rowId + '" >'
            +'<a><i class="fa fa-search"></i></a>'
            +'</span>' 
            +'</div>'
    */
    
    var html = '<input type="text" id="irreglrRtnFldVal_' + options.rowId + '" required="true" value="' + value + '">';
	return html;
}

//조건상세 Grid 추가
function addActionInfoListGridTr(){
	var condValList = actionInfoPopData.etScoringCond.condValList;
	var rowData = {};
	
	condValList.push(rowData);
	
    //추가
    actionInfoListGrid.addLocalTr();
	
    //popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});
    
    //값 버튼 클릭시
    $(".colValPopupOpenBtn").on('click', function(){
    	//컬럼값 목록 팝업 열기
    	columnValueListPopupOpen(this);
    });
    
    setPopupHeight();
}

//조건 상세 Grid row 삭제
function delActionInfoListGridTr(_this) {
// 	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdactionInfoListGrid");
	var _id = $(_this).attr('id');
	console.log("_id : " + _id);
	var _curr;
	if(_id.indexOf("actionInfoListGrid") > 0) {
		_curr = _id.split("actionInfoListGrid")[1];
	} else if(_id.indexOf("actionInfoListGrid") < 0 && _id.indexOf("del_") >= 0) {
		_curr = _id.split("_")[1];
	} else {
		//Exception
		alert('<spring:message code="M00911"/>');
		return false;
	}
	
	var condValList = actionInfoPopData.etScoringCond.condValList;
	
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	condValList.splice(_curr-1, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdactionInfoListGrid.clearGridData();
    gridIdactionInfoListGrid.setGridParam({data: condValList}).trigger("reloadGrid");
    
    //popup 높이 맞추기
    setPopupHeight();
}

//프로그램 목록
function setRuleInfoGridList(){
    
	var jqGridOption = {
	   		loadComplete : function(obj){
	   			//popup 높이 맞추기
	 			/* new ifvm.PopupHeight({
	 				popupDivId : 'ruleInfoPop',
	 				contentsId : 'dialogPopupWrap'
	 			}); */
	   		},
			data : actionInfoPopData.etScoringCond.condValList,
			datatype: 'clientSide',
		    colNames:["<spring:message code='L02218'/>", //삭제
// 		              "<spring:message code='M01878'/>", //AND/OR
// 		              '(',
		              "<spring:message code='M01879'/>", //기준필드
		              "<spring:message code='M01880'/>", //연산자
		              "<spring:message code='M01881'/>", //값
		              "<spring:message code='L02226'/>", //부여점수
// 		              ')',
		              'rid'],
		    colModel:[
		        {name:'rid',index:'', resizable : false, align: 'center', width: "50", formatter: delFormat},
// 		        {name:'lcLogicOper',index:'', resizable : false, width: "70", formatter: lcLogicOperFormat},
// 		        {name:'lcLeftbrkt',index:'', resizable : false, width: "20", formatter: lcLeftbrktFormat},
		        {name:'lgclFld',index:'', resizable : false, width: "100", formatter: lgclFldFormat},
		        {name:'lcCompOper',index:'', resizable : false, width: "100", formatter: lcCompOperFormat},
		        {name:'lcCompVal',index:'', resizable : false, width: "100", formatter: lcCompValFormat},
		        {name:'irreglrRtnFldVal',index:'', resizable : false, width: "100", formatter: irreglrRtnFldValFormat},
// 		        {name:'lcRightbrkt',index:'', resizable : false, width: "20", formatter: lcRightbrktFormat},
		        {name:'rid', index:'', hidden : true }
		    ],
		    rowList : [10000],
		    tempId : 'ifvGridSimpleTemplete',
		};
	
	actionInfoListGrid = $("#actionInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
	actionInfoListGrid.opt.postData= {page: 1};
	gridIdactionInfoListGrid = $("#gridIdactionInfoListGrid");
}

//rule 정보 팝업 설정
function initActionInfoPop() {
	//set popup
	cDialog.model.title = '<spring:message code="M01865"/>';
    $("#dialog_title").append('<spring:message code="M01865"/>');
    cDialog.model.width = "700";
    cDialog.model.close = "closeActionInfoPop";
	
	//연산자 조회
	getOperTypeCodeList();
    
	//node 유형 설정
	//$.fn.ifvmSetSelectOptionCommCode("type", "LOY_SCR_NODE_TYPE");
	
	//적립 유형
	$.fn.ifvmSetSelectOptionCommCode("acrlType", "LOY_ACRL_TYPE");
	
	//validation
    actionInfoPopValidation = $("#actionInfoPop").ifvValidation(); 
}

//rule 정보 데이터 설정
function initActionInfoData() {
	//set task type
	diagram._selectedObject.taskType = "SCRACT";
	
	//캠페인 ID
	var rid = diagram._selectedObject.actualTaskId; 
	
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getETScoringAct"/>', {
        rid: rid
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
			if ($.fn.ifvmIsNotEmpty(result.actVal)) {
	    		actionInfoPopData.etScoringAct.actVal = result.actVal;
			}
			if ($.fn.ifvmIsNotEmpty(result.condValList)) {
    			actionInfoPopData.etScoringCond.condValList = result.condValList;
			}
    		
    		//rule 정보 설정
    		setActionInfo(result);
    	}
    });
    
    setRuleInfoGridList();
}

//rule 정보 설정
function setActionInfo(data) {
	//area 설정
	setActionInfoArea(data.type);
	
	var area = data.type + "_area";
	$("#type").val(data.type)
	$("#title").val(data.title);
	$("#desctxt").val(data.desctxt);
	
	$("#subInputScrn").val(data.subInputScrn);
	$("#ridNodeSubType").val(data.ridNodeSubType);

	if ($.fn.ifvmIsNotEmpty(data.actVal)) {
		$("#offerNm").val(data.actVal.offerNm);
	    $("#offerTypeCdNm").val(data.actVal.offerTypeCdNm);
	    $("#acrlType").val(data.actVal.acrlType);
	    $("#bnftAcrlAmt").val(data.actVal.bnftAcrlAmt);
	    $("#ridMktOfferMst").val(data.actVal.ridMktOfferMst);
	} else {
		actionInfoPopData.etScoringAct.actVal = {};
	}
	
	//로지컬 컴포넌트 아이디
	if ($.fn.ifvmIsNotEmpty(data.condValList) && data.condValList.length > 0) {
		var lgclCmpntId = data.condValList[0].lgclCmpntId;
		actionInfoPopData.lgclCmpntId = lgclCmpntId;
		
		//로지컬 컴포넌트 컬럼 목록 조회
		getETLogicalComponentColumnList(lgclCmpntId);
		
		//로지컬컴포넌트명
		$("#lgcCompNm").val(data.condValList[0].lgcCompNm);
	} else {
		actionInfoPopData.etScoringCond.condValList = [];
	}
}

/**
 * Action 유형 별 area 세팅 
 */
function setActionInfoArea(type) {
	if(type === "A") { //실행
		$("#tier_area").hide();
		$("#target_area").show();
		
		//초기화
		$("#subInputScrn").val("");
		$("#ridNodeSubType").val("");
		
	} else if(type === "R") { //룰설정
		$("#tier_area").show();
		$("#target_area").hide();
		
		//초기화
		$("#subInputScrn").val("");
		$("#ridNodeSubType").val("");
	}
	
	setPopupHeight();
	
	//validation
    actionInfoPopValidation = $("#actionInfoPop").ifvValidation(); 
}

//오퍼 목록 팝업 열기
function benefitsOfferListPopupOpen() {
	
    $("#benefitsOfferListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="benefitsOfferListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02303"/>',
        width: 1020,
        close : 'benefitsOfferListPopupClose'
    });
}

//오퍼 목록 팝업 닫기
function benefitsOfferListPopClose() {
	benefitsOfferListPopup._destroy();
}

//오퍼 목록 팝업 선택시
function benefitsOfferListPopSelect() {
	var rowId = gridIdbenefitsOfferListPopGrid.getGridParam("selrow");
	var rowData = gridIdbenefitsOfferListPopGrid.getRowData(rowId);
    
	if ($.fn.ifvmIsNotEmpty(rowId)) {
    	
		$("#ridMktOfferMst").val(rowData.id);
	    $("#offerNm").val(rowData.offerName);
	    $("#offerTypeCdNm").val(rowData.offerTypeCd);
	    
	    //팝업닫기
	    benefitsOfferListPopClose();
    }
}

//그리드 전체 데이터 추출
function getGridAllData() {
	var rowIds = actionInfoListGrid.getAllRowIds();
	var rtnDatas = [];
	
	$.each(rowIds, function(index, rowid) {
		rtnDatas.push(getGridRowData(rowid));
	});
	
	return rtnDatas;
}

//function 목록 팝업 열기
function functionListPopupOpen() {
	
    $("#functionListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="functionListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01867"/>',
        width: 600,
        close : 'functionListPopupClose'
    });
}

//function 목록 팝업 닫기
function functionListPopupClose() {
	functionListPopup._destroy();
}

//function 목록 팝업 선택시
function functionListPopupSelect() {
    if ($.fn.ifvmIsNotEmpty(functionListGrid.getCheckedList())) {
	    var rid = functionListGrid.getCheckedList()[0].rid;   //rid
	    var inputScrn = functionListGrid.getCheckedList()[0].subInputScrn;	//function명
		
	    $("#ridNodeSubType").val(rid);
	    $("#subInputScrn").val(inputScrn);
	    
	    //팝업닫기
	    functionListPopupClose();
    }
}

//Action 정보 저장
function saveActionInfo() {
	if (actionInfoPopValidation.confirm()) {
		var type = $("#type").val();
		var title = $("#title").val();
		var desctxt = $("#desctxt").val();
		var xCoord = diagram.selectionList[0].offsetX;
		var yCoord = diagram.selectionList[0].offsetY;
		var ridNodeSubType = $("#ridNodeSubType").val();
		var condValList = getGridAllData();
		
		var actValRid = actionInfoPopData.etScoringAct.actVal.rid;
		actValRid = $.fn.ifvmIsNotEmpty(actValRid) ? actValRid : "";
		
		var actVal = {
				rid: actValRid,
				ridMktOfferMst: $("#ridMktOfferMst").val(),
				acrlType: $("#acrlType").val(),
				bnftAcrlAmt: $("#bnftAcrlAmt").val(),
		};
		
		var rid = actionInfoPopData.etScoringAct.rid;
		rid = $.fn.ifvmIsNotEmpty(rid) ? rid : "";
		
		var requestData = {
				rid: rid,
				type: type,
				title: title,
				desctxt: desctxt,
				xCoord: xCoord,
				yCoord: yCoord,
				actVal: actVal,
				ridNodeSubType: ridNodeSubType,
				ridMktCamMst: scoring.id,
				campaignId: scoring.id,
				condValList: condValList
		}
		
	    diagram._selectedObject.data.etScoringCond = requestData;
	    diagram._selectedObject.taskDataStatus = getTaskStatusCode(requestData);
	    requestData.dataStatus= getTaskStatusCode(requestData);
		
        $.ifvSyncPostJSON('<ifvm:action name="saveETScoringAct"/>', requestData,
       	function(result) {
        	//set actual task ID
            diagram._selectedObject.actualTaskId = result.message;
        	
            //set campaign ID
            diagram._selectedObject.scoringId = scoring.id;
            
            //set old campaign ID
            diagram._selectedObject.oldScoringId = scoring.id;
        	
          	//save workflow
            saveWorkflow();
        	
        	//close popup
        	closeActionInfoPop();
       	},
       	function(result) {
       		
       	});
	}
}

//dialog close
function closeActionInfoPop(args) {
    //dialog 파괴
    cDialog._destroy();
}

/**
 * popup 높이 맞추기
 */
function setPopupHeight() {
	new ifvm.PopupHeight({
	    popupDivId : 'dialog',
	    contentsId : 'dialogPopupWrap'
	});

	cDialog.refresh();
}

//로지컬 컴포넌트 목록 팝업 열기
function campaignLgcCompListPopupOpen() {
    $("#campaignLgcCompListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="campaignLgcCompListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M01882'/>",
        width: 580,
        close : 'campaignLgcCompListPopupClose'
    });
}

//로지컬 컴포넌트 목록 팝업 닫기
function campaignLgcCompListPopupClose(args) {
    campaignLgcCompListPopup._destroy();
}

//로지컬컴포넌트 목록 팝업 확인 클릭시
function campaignLgcCompListPopConfirm() {
    //로지컬 컴포넌트 아이디 확인
    if ($.fn.ifvmIsNotEmpty(campaignLgcCompListGrid.getCheckedList())) {
	    var logicalCompId = campaignLgcCompListGrid.getCheckedList()[0].logicalCompId;   //로지컬 컴포넌트 아이디
	    var logicalCompName = campaignLgcCompListGrid.getCheckedList()[0].logicalCompName;	//로지컬 컴포넌트명
	    
	    actionInfoPopData.lgclCmpntId = logicalCompId;
	    $("#lgcCompNm").val(logicalCompName);
	    
		//로지컬 컴포넌트 컬럼 목록 조회
		getETLogicalComponentColumnList(logicalCompId);
		
		//grid 초기화
		actionInfoPopData.etScoringCond.condValList = [];
		gridIdactionInfoListGrid.clearGridData();
		gridIdactionInfoListGrid.setGridParam({data:actionInfoPopData.etScoringCond.condValList}).trigger("reloadGrid");
		
		//팝업닫기
		campaignLgcCompListPopup._destroy();
    }
}

//컬럼값 목록 팝업 열기
function columnValueListPopupOpen(_this) {
	var rowid = _this.id;
	rowid = rowid.replace("colVal_", "");
	
	var rowData = getGridRowData(rowid);
	actionInfoPopData.selRowData = rowData;
	
	//Rule 필터설정 팝업 열기
    if (isNotEmpty(rowData.lgclFld)) {
    	
    	actionInfoPopData.etScoringCond.lgclFld = rowData.lgclFld;
    	actionInfoPopData.etScoringCond.lcCompOper = rowData.lcCompOper;
    	
        $("#ruleFilterSetPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="scoringRuleFilterSetPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M01187" />',
            width: 770,
            close : 'ruleFilterSetPopupClose'
        });
    }
}

//Rule 필터설정 팝업 닫기
function ruleFilterSetPopupClose() {
	ruleFilterSetPopup._destroy();
}

//그리드 rowdata 추출
function getGridRowData(rowid) {
	var data = actionInfoListGrid.getRowDatas(rowid);

	var rid = data.rid;
	var lcCompOper = $("#lcCompOper_" + rowid).val();
	var lcCompVal = $("#lcCompVal_" + rowid).val();
	var lgclFld = $("#lgclFld_" + rowid).val();
	var irreglrRtnFldVal = $("#irreglrRtnFldVal_" + rowid).val();
// 	var lcLogicOper = $("#lcLogicOper_" + rowid).val();
	
// 	var lcLeftbrkt = $("#lcLeftbrkt_" + rowid).is(":checked");
// 	lcLeftbrkt = lcLeftbrkt ? "1" : "0";
	
// 	var lcRightbrkt = $("#lcRightbrkt_" + rowid).is(":checked");
// 	lcRightbrkt = lcRightbrkt ? "1" : "0";
	
	var rowData = {
		rid: rid,
		lcCompOper: lcCompOper,
		lcCompVal: lcCompVal,
		lgclFld: lgclFld,
// 		lcLogicOper: lcLogicOper,
// 		lcLeftbrkt: lcLeftbrkt,
// 		lcRightbrkt: lcRightbrkt,
		irreglrRtnFldVal: irreglrRtnFldVal,
		lgclCmpntId: actionInfoPopData.lgclCmpntId,
		rowid: rowid
	};
	
	return rowData;
}

//로지컬 컴포넌트 컬럼 목록 조회
function getETLogicalComponentColumnList(lgclCmpntId) {
	if ($.fn.ifvmIsNotEmpty(lgclCmpntId)) {
	    $.ifvSyncPostJSON('<ifvm:action name="getETLogicalComponentColumnList"/>', {
	    	logicalCompId: lgclCmpntId
	    },
	    function(result) {
	    	if ($.fn.ifvmIsNotEmpty(result)){
	    		actionInfoPopData.lgcCompColumnList = result;
	    	}
	    });
	}
}

//연산자 코드 목록 조회
function getOperTypeCodeList() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SERC_OPRT_TYPE'
		, enableNA : true
	},function(result) {
		actionInfoPopData.operTypeCodeList = result.rows;
	});
}

$(document).ready(function() {
	initActionInfoPop();
	initActionInfoData();
	
	//저장 클릭시
    $('#actionInfoPopSaveBtn').on('click', function(){
    	saveActionInfo();
    });
	
    //추가 클릭시
    $('#actionInfoListAddBtn').on('click', function(){
    	addActionInfoListGridTr();
    });
    
    //취소 클릭시
    $('#actionInfoPopCloseBtn').on('click', function(){
    	closeActionInfoPop();
    });
    
    //rule 유형 변경시
    $('#type').on('change', function() {
    	setActionInfoArea($(this).val());
		//조건상세 그리드 draw
		setRuleInfoGridList();
		actionInfoGridResize();
    });
    
    //function 목록 팝업
    $("#functionListPopupBtn").on('click', function() {
    	functionListPopupOpen();
    });
    
    //function 목록 팝업
    $("#benefitsOfferListPopupBtn").on('click', function() {
    	benefitsOfferListPopupOpen();
    });
    
    //로지컬 컴포넌트 팝업
    $('#campaignLgcCompListPopupBtn').on('click', function(){
    	campaignLgcCompListPopupOpen();
    	
    	var w = $("#dialogPopupWrap").width();
    	campaignLgcCompListGrid.setWidth(w);
    });
    
    //값 버튼 클릭시
    $(".colValPopupOpenBtn").on('click', function(){
    	//컬럼값 목록 팝업 열기
    	columnValueListPopupOpen(this);
    });
    
    setActionInfoArea('R');
    setPopupHeight();
});
</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="actionInfoPop" >
        <%-- Action유형 --%>
        <%--
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02223"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="type" names="type" required="true" />
            </div>
        </div>
        --%>
		<%-- 1.기본정보 --%>
		<header class="temp_title_bb">
			<spring:message code="L02213"/>
		</header>
		
        <div class="row qt_border">
        	<%-- 구간명 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02253"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="title" names="title" required="true" />
            </div>
			<%-- 컴포넌트명 --%>
			<label class="col-xs-2 control-label"><spring:message code='L02216'/></label>
			<div class="col-xs-4 control_content">
			 <div class="input-group">
			     <ifvm:input type="text" id="lgcCompNm" names="lgcCompNm" readonly="true" />
			     <span class="input-group-addon" id="campaignLgcCompListPopupBtn">
			         <a><i class="fa fa-search"></i></a>
			     </span> 
			 </div>
			</div>
		</div>
        <!--
        <div id="offer_area" style="display:none;">
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01870"/></label>
	            <div class="col-xs-4 control_content">
	             <div class="input-group">
	                 <ifvm:input type="text" id="offerNm" names="offerNm" readonly="true" required="true"  />
	                 <input type="hidden" id="ridMktOfferMst"/>
	                 <span class="input-group-addon" id="benefitsOfferListPopupBtn">
	                     <a><i class="fa fa-search"></i></a>
	                 </span> 
	             </div>
	            </div>
	            <label class="col-xs-2 control-label"><spring:message code="M01871"/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="select" id="acrlType" names="acrlType" />
	            </div>
	        </div>
	        
	        <div class="row qt_border">
	        	<label class="col-xs-2 control-label"><spring:message code="M01872"/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="text" id="offerTypeCdNm" names="offerTypeCdNm" readonly="true" />
	            </div>
	            <label class="col-xs-2 control-label"><spring:message code="M01873"/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="text" id="bnftAcrlAmt" names="bnftAcrlAmt" />
	            </div>
	        </div>
        </div>
        
        <div id="function_area" style="display:none;">
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><spring:message code="M01874"/></label>
	            <div class="col-xs-4 control_content">
	             <div class="input-group">
	                 <ifvm:input type="text" id="subInputScrn" names="subInputScrn" readonly="true" />
	                 <input type="hidden" id="ridNodeSubType"/>
	                 <span class="input-group-addon" id="functionListPopupBtn">
	                     <a><i class="fa fa-search"></i></a>
	                 </span> 
	             </div>
	            </div>
	        </div>
        </div>
        -->
        
        <%-- 외부테이블전송 --%>
        <div id="target_area" style="display:none;">
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><spring:message code="M01874"/></label>
	            <div class="col-xs-4 control_content">
	             <div class="input-group">
	                 <ifvm:input type="text" id="subInputScrn" names="subInputScrn" readonly="true" />
	                 <input type="hidden" id="ridNodeSubType"/>
	                 <span class="input-group-addon" id="functionListPopupBtn">
	                     <a><i class="fa fa-search"></i></a>
	                 </span> 
	             </div>
	            </div>
	        </div>
        </div>
        
        <div class="row qt_border">
        	<%-- 설명 --%>
            <label class="col-xs-2 control-label"><spring:message code="L02217"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="textarea" rows="2" id="desctxt" />
            </div>
        </div>
        
        <%-- 구간별설정 --%>
        <div id="tier_area" style="display:none;">
	        <div class="row qt_border">
		        <%-- 2.구간 상세 등록 --%>
		        <header class="temp_title">
					<spring:message code='L02252'/>
					<button class="btn_pop_white pop_top_btn" id="actionInfoListAddBtn" >
						<img src="<ifvm:image name='btn_plus'/>" alt="" />
						<spring:message code="M00166"/>
					</button>
				</header>
        		<div id="actionInfoListGrid" class="con_size"/> 
        	</div>
        </div>
        
	</div>
	
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="actionInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00137"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="actionInfoPopCloseBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>

<div id="campaignLgcCompListPopup" class="popup_container"></div>
<div id="ruleFilterSetPopup" class="popup_container"></div>
<div id="benefitsOfferListPopup" class="popup_container"></div>
<div id="functionListPopup" class="popup_container"></div>