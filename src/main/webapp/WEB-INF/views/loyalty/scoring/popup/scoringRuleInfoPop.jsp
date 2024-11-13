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
var currentPopup = "scoringRuleInfoPop";

//grid - 집계함수
var scalarFuncInfoListGrid;
var scalarFuncInfoPopValidation;
var gridIdscalarFuncInfoListGrid;
//grid - 조건상세
var ruleInfoListGrid;
var ruleInfoPopValidation;
var gridIdruleInfoListGrid;


var nodeTypeCd = "RUL";

var ruleInfoPopData = {
		etScoringCond: {
			condValList: []			
		}
		, etScoringCondScalarFunc: {
			condValList: []			
		}
		, lgcCompColumnList: []
		, lgclCmpntId : ""
		, operTypeCodeList: []
		, logicOperCodeList: ['AND', 'OR']
		, selRowData: {}
		, lgclFldGroup : {}
}

/**
 * 집계함수,조건상세 그리드 width Resize
 */
function ruleInfoGridResize() {
	var w = $("#dialogPopupWrap").width();
	ruleInfoListGrid.setWidth(w);
	scalarFuncInfoListGrid.setWidth(w);
}


//rule 정보 팝업 설정
function initRuleInfoPop() {
	//set popup
	cDialog.model.title = "<spring:message code='M01877'/>";
    $("#dialog_title").append("<spring:message code='M01877'/>");
    cDialog.model.width = "700";
    cDialog.model.close = "closeRuleInfoPop";
	
	//node 유형 설정
	$.fn.ifvmSetSelectOptionCommCode("type", "MKT_CAM_NODE_TYPE", "STRUC", "00b68f1de9b011e000000614", true)
	
	//연산자 조회
	getOperTypeCodeList();
	//집계함수 조회
	getFuncTypeCodeList();
	
	setRuleInfoArea("STRUC");
}

//rule 정보 데이터 설정
function initRuleInfoData() {
	//set task type
	diagram._selectedObject.taskType = "SCRCOND";
	
	//캠페인 ID
	var rid = diagram._selectedObject.actualTaskId; 
	if($.fn.ifvmIsEmpty(rid)) {
		rid = scoring.id;
	}
	
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getETScoringCond"/>', {
        rid: rid
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
    		//rule 정보 설정
    		setRuleInfo(result);
    		
    		var _result = clone(result);
    		var _etScoringCond = clone(result);
    		_etScoringCond.condValList = [];
    		var _etScoringCondScalarFunc = clone(result);
    		_etScoringCondScalarFunc.condValList = [];
    		
    		if($.fn.ifvmIsNotEmpty(_result.condValList)) {
	    		$.each(_result.condValList, function(idx, data) {
		    		if(data.lcCompValType === 'SELECT') {
		    			_etScoringCondScalarFunc.condValList.push(data);
		    		} else if(data.lcCompValType === 'WHERE') {
		    			_etScoringCond.condValList.push(data);
		    		} else if(data.lcCompValType === 'GROUP') {
		    			ruleInfoPopData.lgclFldGroup = data;
		    		}
	    		});
	    		ruleInfoPopData.etScoringCond = _etScoringCond;
	    		ruleInfoPopData.etScoringCondScalarFunc = _etScoringCondScalarFunc;
    		}
    	}
    });
    
    //집계함수 그리드 설정
    setScalarFuncInfoGridList();
    //조건 상세 그리드 설정
    setRuleInfoGridList();
    //그룹핑 설정
    setLgclFldGroup();
}

//정형/비정형 area 설정
function setRuleInfoArea(type) {
	if (type == "UNSTRUC") {
		$("#STRUC_area").hide();
		$("#UNSTRUC_area").show();
		
		//그리드 초기화
		if($.fn.ifvmIsNotEmpty(gridIdruleInfoListGrid)) {
			gridIdruleInfoListGrid.clearGridData();
		}
		
		//로지컬 컴포넌트 아이디 초기화
		ruleInfoPopData.lgclCmpntId = "";
	} else {
		$("#STRUC_area").show();
		$("#UNSTRUC_area").hide();
		
		//초기화
	    $("#ridNodeSubType").val("");
	    $("#subInputScrn").val("");
	}
	
    //popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});
	
	//validation
    ruleInfoPopValidation = $("#" + type + "_area").ifvValidation(); 
}

//rule 정보 설정
function setRuleInfo(data) {
	//정형/비정형 area 설정
	setRuleInfoArea(data.type);
	var area = data.type + "_area";
	$("#type").val(data.type)
	$("#" + area + " #title").val(data.title);
	$("#" + area + " #desctxt").val(data.desctxt);
	
	$("#" + area + " #subInputScrn").val(data.subInputScrn);
	$("#" + area + " #ridNodeSubType").val(data.ridNodeSubType);
	
	//로지컬 컴포넌트 아이디
	if ($.fn.ifvmIsNotEmpty(data.condValList) && data.condValList.length > 0) {
		var lgclCmpntId = data.condValList[0].lgclCmpntId;
		ruleInfoPopData.lgclCmpntId = lgclCmpntId;
		
		//로지컬 컴포넌트 컬럼 목록 조회
		getETLogicalComponentColumnList(lgclCmpntId);
		
		//로지컬컴포넌트명
		$("#lgcCompNm").val(data.condValList[0].lgcCompNm);
	} else {
		ruleInfoPopData.etScoringCond.condValList = [];
		ruleInfoPopData.etScoringCondScalarFunc.condValList = [];
	}
}

//로지컬 컴포넌트 컬럼 목록 조회
function getETLogicalComponentColumnList(lgclCmpntId) {
	if ($.fn.ifvmIsNotEmpty(lgclCmpntId)) {
	    $.ifvSyncPostJSON('<ifvm:action name="getETLogicalComponentColumnList"/>', {
	    	logicalCompId: lgclCmpntId
	    },
	    function(result) {
	    	if ($.fn.ifvmIsNotEmpty(result)){
	    		ruleInfoPopData.lgcCompColumnList = result;
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
		ruleInfoPopData.operTypeCodeList = result.rows;
	});
}

/**
 * 집계함수 코드 목록 조회
 */
function getFuncTypeCodeList() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'LC_COMP_OPER_FUNC'
		, enableNA : true
	},function(result) {
		ruleInfoPopData.funcTypeCodeList = result.rows;
	});
}

/**
 * 2.집계함수 설정 그리드 draw
 */
function setScalarFuncInfoGridList(){
    
	var jqGridOption = {
	   		loadComplete : function(obj){
	   			//popup 높이 맞추기
	 			/* new ifvm.PopupHeight({
	 				popupDivId : 'ruleInfoPop',
	 				contentsId : 'dialogPopupWrap'
	 			}); */
	   		},
			data : ruleInfoPopData.etScoringCondScalarFunc.condValList,
			datatype: 'clientSide',
		    colNames:["<spring:message code='L02218'/>", //삭제
		              "<spring:message code='L02258'/>", //집계함수명
		              "<spring:message code='L02259'/>", //집계필드
		              'lcCompValType',
		              'rid'],
		    colModel:[
		        {name:'rid',index:'', resizable : false, align: 'center', width: "26", formatter: delFormatScalarFunc},
		        {name:'lcCompOper',index:'', resizable : false, width: "100", formatter: lcCompOperFormatScalarFunc},
		        {name:'lgclFld',index:'', resizable : false, width: "100", formatter: lgclFldFormat},
		        {name:'lcCompValType', index:'', hidden : true },
		        {name:'rid', index:'', hidden : true }
		    ],
		    rowList : [10000],
		    tempId : 'ifvGridSimpleTemplete',
		};
	
	scalarFuncInfoListGrid = $("#scalarFuncInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
	scalarFuncInfoListGrid.opt.postData= {page: 1};
	gridIdscalarFuncInfoListGrid = $("#gridIdscalarFuncInfoListGrid");
}

/**
 * 3.조건 상세 설정 그리드 draw
 */
function setRuleInfoGridList(){
    
	var jqGridOption = {
	   		loadComplete : function(obj){
	   			//popup 높이 맞추기
	 			/* new ifvm.PopupHeight({
	 				popupDivId : 'ruleInfoPop',
	 				contentsId : 'dialogPopupWrap'
	 			}); */
	   		},
			data : ruleInfoPopData.etScoringCond.condValList,
			datatype: 'clientSide',
		    colNames:["<spring:message code='L02218'/>", //삭제
		              "<spring:message code='M01878'/>", //AND/OR
		              '(',
		              "<spring:message code='M01879'/>", //기준필드
		              "<spring:message code='M01880'/>", //연산자
		              "<spring:message code='M01881'/>", //값
		              ')',
		              'lcCompValType',
		              'rid'],
		    colModel:[
		        {name:'rid',index:'', resizable : false, align: 'center', width: "50", formatter: delFormat},
		        {name:'lcLogicOper',index:'', resizable : false, width: "70", formatter: lcLogicOperFormat},
		        {name:'lcLeftbrkt',index:'', resizable : false, width: "20", formatter: lcLeftbrktFormat},
		        {name:'lgclFld',index:'', resizable : false, width: "100", formatter: lgclFldFormat},
		        {name:'lcCompOper',index:'', resizable : false, width: "70", formatter: lcCompOperFormat},
		        {name:'lcCompVal',index:'', resizable : false, width: "100", formatter: lcCompValFormat},
		        {name:'lcRightbrkt',index:'', resizable : false, width: "20", formatter: lcRightbrktFormat},
		        {name:'lcCompValType', index:'', hidden : true },
		        {name:'rid', index:'', hidden : true }
		    ],
		    rowList : [10000],
		    tempId : 'ifvGridSimpleTemplete',
		};
	
	ruleInfoListGrid = $("#ruleInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
	ruleInfoListGrid.opt.postData= {page: 1};
	gridIdruleInfoListGrid = $("#gridIdruleInfoListGrid");
}

/**
 * 집계함수 삭제 formatter
 */
function delFormatScalarFunc(cellValue, options, rowdata){
	var html = '<button class="analysisFilterRowMinusBtn" id="del_' + options.rowId + '" onClick="delScalarFuncInfoListGridTr(this)"><img src="/resources/images/marketing/common/btn_minus.gif" alt=""></button>';
	
	return html;
}

/**
 * 조건상세 삭제 formatter
 */
function delFormat(cellValue, options, rowdata){
	var html = '<button class="analysisFilterRowMinusBtn" id="del_' + options.rowId + '" onClick="delRuleInfoListGridTr(this)"><img src="/resources/images/marketing/common/btn_minus.gif" alt=""></button>';
	
	return html;
}

//and/or formatter
function lcLogicOperFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	
	var select = "<select class='lcLogicOper' id='lcLogicOper_" + options.rowId + "' name='lcLogicOper_" + options.rowId + "'>"  ;
	//option
	$.each(ruleInfoPopData.logicOperCodeList, function(index, data){
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
	$.each(ruleInfoPopData.lgcCompColumnList, function(index, data){
		if (data.id == value) {
			select += "<option codeId='" + data.id + "' value='" + data.id + "' selected >"+ data.displayName +"</option>";
		} else {
			select += "<option codeId='" + data.id + "' value='" + data.id + "'>"+ data.displayName +"</option>";
		}
	});
    select += "</select>";
    return select;
}

/**
 * 집계함수 함수목록 formatter
 */
function lcCompOperFormatScalarFunc(cellValue, options, rowdata){	
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var select = "<select class='lcCompOper' id='lcCompOper_" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(ruleInfoPopData.funcTypeCodeList, function(index, data){
		if (data.codeName == value) {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "' selected >"+ data.markName +"</option>";
		} else {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "'>"+ data.markName +"</option>";
		}
	});
    select += "</select>";
    return select;
}

/**
 * 조건상세 연산자 formatter 
 */
function lcCompOperFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var select = "<select class='lcCompOper' id='lcCompOper_" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(ruleInfoPopData.operTypeCodeList, function(index, data){
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
            +'<span class="input-group-addon colValPopupOpenBtn" name="colVal_' + options.rowId + '" id="colVal_' + options.rowId + '" >'
            +'<a><i class="fa fa-search"></i></a>'
            +'</span>' 
            +'</div>'
    
	return html;
}

/**
 * 집계함수 Grid 추가
 */
function addScalarFuncInfoListGridTr(){
	var condValList = ruleInfoPopData.etScoringCondScalarFunc.condValList;
	var rowData = {lcCompValType:'SELECT'};
	
	condValList.push(rowData);
	
    //추가
    scalarFuncInfoListGrid.addLocalTr();
	
    //popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});
}

/**
 * 조건상세 Grid 추가
 */
function addRuleInfoListGridTr(){
	var condValList = ruleInfoPopData.etScoringCond.condValList;
	var rowData = {lcCompValType:'WHERE'};
	
	condValList.push(rowData);
	
    //추가
    ruleInfoListGrid.addLocalTr();
	
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
}

/**
 * 집계함수 조건 상세 Grid row 삭제
 */
function delScalarFuncInfoListGridTr(_this) {
// 	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdruleInfoListGrid");
	var _id = $(_this).attr('id');
	var _curr;
	if(_id.indexOf("scalarFuncInfoListGrid") > 0) {
		_curr = _id.split("scalarFuncInfoListGrid")[1];
	} else if(_id.indexOf("scalarFuncInfoListGrid") < 0 && _id.indexOf("del_") >= 0) {
		_curr = _id.split("_")[1];
	} else {
		//Exception
		alert('<spring:message code="M00911"/>');
		return false;
	}
	
	var condValList = ruleInfoPopData.etScoringCondScalarFunc.condValList;
	
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	condValList.splice(_curr-1, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdscalarFuncInfoListGrid.clearGridData();
    gridIdscalarFuncInfoListGrid.setGridParam({data: condValList}).trigger("reloadGrid");
    
    //popup 높이 맞추기
    setPopupHeight();
}

/**
 * 조건상세 Grid row 삭제
 */
function delRuleInfoListGridTr(_this) {
// 	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdruleInfoListGrid");
	var _id = $(_this).attr('id');
	var _curr;
	if(_id.indexOf("ruleInfoListGrid") > 0) {
		_curr = _id.split("ruleInfoListGrid")[1];
	} else if(_id.indexOf("ruleInfoListGrid") < 0 && _id.indexOf("del_") >= 0) {
		_curr = _id.split("_")[1];
	} else {
		//Exception
		alert('<spring:message code="M00911"/>');
		return false;
	}
	
	var condValList = ruleInfoPopData.etScoringCond.condValList;
	
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	condValList.splice(_curr-1, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdruleInfoListGrid.clearGridData();
    gridIdruleInfoListGrid.setGridParam({data: condValList}).trigger("reloadGrid");
    
    //popup 높이 맞추기
    setPopupHeight();
}

//로지컬 컴포넌트 목록 팝업 열기
function campaignLgcCompListPopupOpen() {
    $("#campaignLgcCompListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="campaignLgcCompListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M01882'/>",
        width: 700,
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
	    
	    ruleInfoPopData.lgclCmpntId = logicalCompId;
	    $("#lgcCompNm").val(logicalCompName);
	    
		//로지컬 컴포넌트 컬럼 목록 조회
		getETLogicalComponentColumnList(logicalCompId);
		
		//집계함수 grid 초기화
		ruleInfoPopData.etScoringCondScalarFunc.condValList = [];
		gridIdscalarFuncInfoListGrid.clearGridData();
		gridIdscalarFuncInfoListGrid.setGridParam({data:ruleInfoPopData.etScoringCondScalarFunc.condValList}).trigger("reloadGrid");
		
		//조건상세 grid 초기화
		ruleInfoPopData.etScoringCond.condValList = [];
		gridIdruleInfoListGrid.clearGridData();
		gridIdruleInfoListGrid.setGridParam({data:ruleInfoPopData.etScoringCond.condValList}).trigger("reloadGrid");
		
		//그룹필드 목록 설정
		setLgclFldGroup();
		
		//팝업닫기
		campaignLgcCompListPopup._destroy();
    }
}

/**
 * 조건상세 컬럼값 목록 팝업 열기
 */
function columnValueListPopupOpen(_this) {
	var rowid = _this.id;
	rowid = rowid.replace("colVal_", "");
	
	var rowData = getGridRowData(rowid);
	ruleInfoPopData.selRowData = rowData;
	
	//Rule 필터설정 팝업 열기
    if (isNotEmpty(rowData.lgclFld)) {
    	ruleInfoPopData.etScoringCond.lgclFld = rowData.lgclFld;
    	ruleInfoPopData.etScoringCond.lcCompOper = rowData.lcCompOper;
    	
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

/**
 * 집계함수 그리드 rowdata 추출
 */
function getGridRowDataScalarFunc(rowid) {
	var data = scalarFuncInfoListGrid.getRowDatas(rowid);

	var rid = data.rid;
	var lcCompOper = $("#scalarFuncInfoListGrid #lcCompOper_" + rowid).val();
	var lgclFld = $("#scalarFuncInfoListGrid #lgclFld_" + rowid).val();
	
	var rowData = {
		rid: rid,
		lcCompValType: 'SELECT',
		lcCompOper: lcCompOper,
		lgclFld: lgclFld,
		lgclCmpntId: ruleInfoPopData.lgclCmpntId,
		rowid: rowid
	};
	
	return rowData;
}

/**
 * 조건상세 그리드 rowdata 추출
 */
function getGridRowData(rowid) {
	var data = ruleInfoListGrid.getRowDatas(rowid);

	var rid = data.rid;
	var lcCompOper = $("#ruleInfoListGrid #lcCompOper_" + rowid).val();
	var lcCompVal = $("#ruleInfoListGrid #lcCompVal_" + rowid).val();
	var lgclFld = $("#ruleInfoListGrid #lgclFld_" + rowid).val();
	var lcLogicOper = $("#ruleInfoListGrid #lcLogicOper_" + rowid).val();
	
	var lcLeftbrkt = $("#ruleInfoListGrid #lcLeftbrkt_" + rowid).is(":checked");
	lcLeftbrkt = lcLeftbrkt ? "1" : "0";
	
	var lcRightbrkt = $("#ruleInfoListGrid #lcRightbrkt_" + rowid).is(":checked");
	lcRightbrkt = lcRightbrkt ? "1" : "0";
	
	var rowData = {
		rid: rid,
		lcCompValType: 'WHERE',
		lcCompOper: lcCompOper,
		lcCompVal: lcCompVal,
		lgclFld: lgclFld,
		lcLogicOper: lcLogicOper,
		lcLeftbrkt: lcLeftbrkt,
		lcRightbrkt: lcRightbrkt,
		lgclCmpntId: ruleInfoPopData.lgclCmpntId,
		rowid: rowid
	};
	
	return rowData;
}

/**
 * 집계함수 그리드 전체 데이터 추출
 */
function getGridAllDataScalarFunc() {
	var rowIds = scalarFuncInfoListGrid.getAllRowIds();
	var rtnDatas = [];
	
	$.each(rowIds, function(index, rowid) {
		rtnDatas.push(getGridRowDataScalarFunc(rowid));
	});
	
	return rtnDatas;
}

/**
 * 조건상세 그리드 전체 데이터 추출
 */
function getGridAllData() {
	var rowIds = ruleInfoListGrid.getAllRowIds();
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
        title: "<spring:message code='M01883'/>",
        width: 700,
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

//Rule 정보 저장
function saveRuleInfo() {
	if (ruleInfoPopValidation.confirm()) {
// 		var type = $("#type").val();
		var type = "STRUC";
		
		var area = type + "_area";
		
		var title = $("#" + area + " #title").val();
		var desctxt = $("#" + area + " #desctxt").val();
		var xCoord = diagram.selectionList[0].offsetX;
		var yCoord = diagram.selectionList[0].offsetY;
		var condValList = getGridAllData();
		var condValListScalarFunc = getGridAllDataScalarFunc();
		
		//정형 일 경우는 rule유형 코드를 비정형일경우는 function rid를 넣는다.
		var ridNodeSubType = type;
		if (type == "UNSTRUC") {
			ridNodeSubType = $("#ridNodeSubType").val();
		}
		
		var rid = ruleInfoPopData.etScoringCond.rid;
		rid = $.fn.ifvmIsNotEmpty(rid) ? rid : "";
		
		var requestData = {
				rid: rid,
				type: type,
				title: title,
				desctxt: desctxt,
				xCoord: xCoord,
				yCoord: yCoord,
				condValList: condValList,
				ridNodeSubType: ridNodeSubType,
				ridMktCamMst: scoring.id,
				campaignId: scoring.id,
				dataStatus: "U"
		}
		var requestDataScalarFunc = {
				rid: rid,
				type: type,
				title: title,
				desctxt: desctxt,
				xCoord: xCoord,
				yCoord: yCoord,
				condValList: condValListScalarFunc,
				ridNodeSubType: ridNodeSubType,
				ridMktCamMst: scoring.id,
				campaignId: scoring.id,
				dataStatus: "U"
		}
		
	    diagram._selectedObject.data.etScoringCond = requestData;
	    diagram._selectedObject.data.etScoringCondScalarFunc = requestDataScalarFunc;
	    diagram._selectedObject.taskDataStatus = getTaskStatusCode(requestData);
		
	    //룰 저장 시 집계함수, 조건상세, 그룹핑 데이터 merge 하여 저장한다.
	    requestData.condValList = requestData.condValList.concat(requestDataScalarFunc.condValList);
	    if($.fn.ifvmIsNotEmpty($('#lgclFldGroup').val())) {
	    	var lgclFldGroupRid = '';
	    	if(ruleInfoPopData.lgclFldGroup.hasOwnProperty('rid')) {
	    		lgclFldGroupRid = ruleInfoPopData.lgclFldGroup.rid;
	    	}
	    	requestData.condValList = requestData.condValList.concat([{
	    		rid:lgclFldGroupRid
	    		, lcCompValType:'GROUP'
	    		, lgclFld:$('#lgclFldGroup').val()
	    		, lgclCmpntId:ruleInfoPopData.lgclCmpntId
	    		, lcCompOper:''
	    	}]);
	    }
        $.ifvSyncPostJSON('<ifvm:action name="saveETScoringCond"/>', requestData,
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
        	closeRuleInfoPop();
       	},
       	function(result) {
       		$.errorChecker(result);
       	});
	}
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

//dialog close
function closeRuleInfoPop(args) {
    //dialog 파괴
    cDialog._destroy();
}

/**
 * 그룹필드 목록 설정
 */
function setLgclFldGroup() {
	//그룹필드 초기화
	$("#lgclFldGroup").empty();
	
	var emptyRow = [{id:'',displayName:''}];
	var tempEmpty = $("#lgclFldGroupTemplate").tmpl(emptyRow);
	$("#lgclFldGroup").append(tempEmpty);

	var temp = $("#lgclFldGroupTemplate").tmpl(ruleInfoPopData.lgcCompColumnList);
	$("#lgclFldGroup").append(temp);
	
	if($.fn.ifvmIsNotEmpty(ruleInfoPopData.lgclFldGroup)) {
		$("#lgclFldGroup").val(ruleInfoPopData.lgclFldGroup.lgclFld);
	}
}

/**
 * Object Shallow Copy (얕은복사)
 */
function clone(obj) {
	if (obj === null || typeof(obj) !== 'object') return obj;
	var copy = obj.constructor();
	for (var attr in obj) {
		if (obj.hasOwnProperty(attr)) {
			copy[attr] = obj[attr];
		}
	}
	return copy;
}

$(document).ready(function() {
	initRuleInfoPop();
	initRuleInfoData();
	
	//저장 클릭시
    $('#ruleInfoPopSaveBtn').on('click', function(){
    	saveRuleInfo();
    });
    
    //집계함수 추가 클릭시
    $('#scalarFuncInfoListAddBtn').on('click', function(){
    	addScalarFuncInfoListGridTr();
    });
    
    //조건상세 추가 클릭시
    $('#ruleInfoListAddBtn').on('click', function(){
    	addRuleInfoListGridTr();
    });
    
    //취소 클릭시
    $('#ruleInfoPopCloseBtn').on('click', function(){
    	closeRuleInfoPop();
    });
    
    //로지컬 컴포넌트 팝업
    $('#campaignLgcCompListPopupBtn').on('click', function(){
    	campaignLgcCompListPopupOpen();
    });
    
    //rule 유형 변경시
    $('#type').on('change', function() {
    	setRuleInfoArea($(this).val());
    });
    
    //function 목록 팝업
    $("#functionListPopupBtn").on('click', function() {
    	functionListPopupOpen();
    });
    
    //값 버튼 클릭시
    $(".colValPopupOpenBtn").on('click', function(){
    	//컬럼값 목록 팝업 열기
    	columnValueListPopupOpen(this);
    });
});
</script>

<style>
/* 제목 영역 */
.temp_title_bb2{
	position:relative;
	padding-left: 0;
	height: 32px;
	line-height: 32px;
	background: transparent;
	color: #094371;
	font-size: 11px;
	font-weight:bold;
	border-bottom: 1px solid #dfdfdf;
	margin-bottom: 10px;
}
</style>

<script id="lgclFldGroupTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}displayName}</option>
</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="ruleInfoPop" >
		<%--
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='L02212'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="type" names="type" required="true" />
            </div>
        </div>
        --%>
        <div id="STRUC_area">
        	<%-- 1.기본정보 --%>
			<header class="temp_title_bb">
				<spring:message code="L02213"/>
			</header>
	        <div class="row qt_border">
	        	<%-- Rule 명 --%>
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='L02215'/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="text" id="title" names="title" required="true" maxLength="100"/>
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
	        
	        <div class="row qt_border">
	        	<%-- 설명 --%>
	            <label class="col-xs-2 control-label"><spring:message code='L02217'/></label>
	            <div class="col-xs-10 control_content">
	                <ifvm:input type="textarea" rows="2" id="desctxt" maxLength="200"/>
	            </div>
	        </div>
	        
	        <%-- 2.집계함수 설정 --%>
	        <header class="temp_title" id="headerScalarFunc">
				<spring:message code='L02257'/>
				<button class="btn_pop_white pop_top_btn" id="scalarFuncInfoListAddBtn" >
					<img src="<ifvm:image name='btn_plus'/>" alt="" />
					<spring:message code="M00166"/>
				</button>
			</header>
	        <div id="scalarFuncInfoListGrid" class="con_size"></div>
	        
	        <%-- 3.조건 상세 등록 --%>
	        <header class="temp_title" id="headerRuleInfo">
				<spring:message code='L02214'/>
				<button class="btn_pop_white pop_top_btn" id="ruleInfoListAddBtn" >
					<img src="<ifvm:image name='btn_plus'/>" alt="" />
					<spring:message code="M00166"/>
				</button>
			</header>
	        <div id="ruleInfoListGrid" class="con_size"></div>
	        
	        <%-- 4.그룹핑 설정 --%>
	        <header class="temp_title_bb2">
				<spring:message code='L02260'/>
			</header>
	        <div class="row qt_border">
				<label class="col-xs-2 control-label"><spring:message code='L02261'/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="select" id="lgclFldGroup" names="lgclFldGroup" />
	            </div>
	        </div>
	        
	        </div>
        <div id="UNSTRUC_area" style="display:none;">
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01889'/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="text" id="title" names="title" required="true" />
	            </div>
	        </div>
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><spring:message code='M01890'/></label>
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
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><spring:message code='M01891'/></label>
	            <div class="col-xs-10 control_content">
	                <ifvm:input type="textarea" rows="2" id="desctxt" maxLength="200"/>
	            </div>
	        </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="ruleInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00137"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="ruleInfoPopCloseBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>

<div id="campaignLgcCompListPopup" class="popup_container"></div>
<div id="ruleFilterSetPopup" class="popup_container"></div>
<div id="functionListPopup" class="popup_container"></div>