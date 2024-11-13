<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid

var ruleInfoListGrid;
var ruleInfoPopValidation;
var gridIdruleInfoListGrid;

var nodeTypeCd = "RUL";

var ruleInfoPopData = {
		etCampaignCond: {
			condValList: []			
		}
		, lgcCompColumnList: []
		, lgclCmpntId : ""
		, operTypeCodeList: []
		, logicOperCodeList: ['AND', 'OR']
		, selRowData: {}
}

function ruleInfoGridResize() {
	var w = $('#ruleInfoListGrid').find('.grid_con').width();
	ruleInfoListGrid.setWidth(w);
}

//rule 정보 팝업 설정
function initRuleInfoPop() {
	//set popup
	cDialog.model.title = "<spring:message code='M01877'/>";
    $("#dialog_title").append("<spring:message code='M01877'/>");
    cDialog.model.close = "closeRuleInfoPop";
	
	//node 유형 설정
	$.fn.ifvmSetSelectOptionCommCode("type", "MKT_CAM_NODE_TYPE", "STRUC", "00b68f1de9b011e000000614", true)
	
	//연산자 조회
	getOperTypeCodeList();
	
	setRuleInfoArea("STRUC");
}

//rule 정보 데이터 설정
function initRuleInfoData() {
	//set task type
	diagram._selectedObject.taskType = "ETCOND";
	
	//캠페인 ID
	var rid = diagram._selectedObject.actualTaskId; 
	
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getETCampaignCond"/>', {
        rid: rid
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
    		ruleInfoPopData.etCampaignCond = result;
    		
    		//rule 정보 설정
    		setRuleInfo(result);
    	}
    });
    
    //조건 상세 그리드 설정
    setRuleInfoGridList();
}

//정형/비정형 area 설정
function setRuleInfoArea(type, flag) {
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
	    
	    if (flag) {
	    	ruleInfoGridResize();
	    }
	}
	
    //popup 높이 맞추기
	/* new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	}); */
	
	$("#dialog").resize();
	
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
		if (data.type == "STRUC") {
			var lgclCmpntId = data.condValList[0].lgclCmpntId;
			ruleInfoPopData.lgclCmpntId = lgclCmpntId;
			
			//로지컬 컴포넌트 컬럼 목록 조회
			getETLogicalComponentColumnList(lgclCmpntId);
			
			//로지컬컴포넌트명
			$("#lgcCompNm").val(data.condValList[0].lgcCompNm);
		} else if (data.type == "UNSTRUC") {
			$("#irreglrCompVal").val(data.condValList[0].irreglrCompVal);
		}
	} else {
		ruleInfoPopData.etCampaignCond.condValList = [];
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
			data : ruleInfoPopData.etCampaignCond.condValList,
			datatype: 'clientSide',
		    colNames:[
		              "<spring:message code='M01878'/>",
		              '(',
		              "<spring:message code='M01879'/>",
		              "<spring:message code='M01880'/>",
		              "<spring:message code='M01881'/>",
		              ')',
		              'lcCompValType',
		              'rid'],
		    colModel:[
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
		    tempId : 'ifvGridSimpleTemplete2',
		    radio: true
		};
	
	ruleInfoListGrid = $("#ruleInfoListGrid").ifvGrid({ jqGridOption : jqGridOption });
	ruleInfoListGrid.opt.postData= {page: 1};
	gridIdruleInfoListGrid = $("#gridIdruleInfoListGrid");
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

//연산자 formatter
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

//조건상세 Grid 추가
function addRuleInfoListGridTr(){
	var condValList = ruleInfoPopData.etCampaignCond.condValList;
	var rowData = {};
	
	condValList.push(rowData);
	
    //추가
    ruleInfoListGrid.addLocalTr();
	
    $("#dialog").resize();
    
    //값 버튼 클릭시
    $(".colValPopupOpenBtn").on('click', function(){
    	//컬럼값 목록 팝업 열기
    	columnValueListPopupOpen(this);
    });
}

//조건 상세 Grid row 삭제
function delRuleInfoListGridTr(_this) {
	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdruleInfoListGrid");
	
	var condValList = ruleInfoPopData.etCampaignCond.condValList;
	
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	condValList.splice(_curr, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdruleInfoListGrid.clearGridData();
    gridIdruleInfoListGrid.setGridParam({data: condValList}).trigger("reloadGrid");
    
    $("#dialog").resize();
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
		
		//grid 초기화
		ruleInfoPopData.etCampaignCond.condValList = [];
		gridIdruleInfoListGrid.clearGridData();
		gridIdruleInfoListGrid.setGridParam({data:ruleInfoPopData.etCampaignCond.condValList}).trigger("reloadGrid");
		
		//팝업닫기
		campaignLgcCompListPopup._destroy();
    }
}

//컬럼값 목록 팝업 열기
function columnValueListPopupOpen(_this) {
	var rowid = _this.id;
	rowid = rowid.replace("colVal_", "");
	
	var rowData = getGridRowData(rowid);
	ruleInfoPopData.selRowData = rowData;
	
	//Rule 필터설정 팝업 열기
    if (isNotEmpty(rowData.lgclFld)) {
    	
    	ruleInfoPopData.lgclFld = rowData.lgclFld;
    	
        $("#ruleFilterSetPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="ruleFilterSetPop"/>',
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
	var data = ruleInfoListGrid.getRowDatas(rowid);

	var rid = data.rid;
	var lcCompOper = $("#lcCompOper_" + rowid).val();
	var lcCompVal = $("#lcCompVal_" + rowid).val();
	var lgclFld = $("#lgclFld_" + rowid).val();
	var lcLogicOper = $("#lcLogicOper_" + rowid).val();
	var lcCompValType = data.lcCompValType;
	
	var lcLeftbrkt = $("#lcLeftbrkt_" + rowid).is(":checked");
	lcLeftbrkt = lcLeftbrkt ? "1" : "0";
	
	var lcRightbrkt = $("#lcRightbrkt_" + rowid).is(":checked");
	lcRightbrkt = lcRightbrkt ? "1" : "0";
	
	var rowData = {
		rid: rid,
		lcCompOper: lcCompOper,
		lcCompVal: lcCompVal,
		lgclFld: lgclFld,
		lcLogicOper: lcLogicOper,
		lcLeftbrkt: lcLeftbrkt,
		lcRightbrkt: lcRightbrkt,
		lgclCmpntId: ruleInfoPopData.lgclCmpntId,
		lcCompValType: lcCompValType,
		rowid: rowid
	};
	
	return rowData;
}

//그리드 전체 데이터 추출
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
		var type = $("#type").val();
		
		var area = type + "_area";
		
		var title = $("#" + area + " #title").val();
		var desctxt = $("#" + area + " #desctxt").val();
		var xCoord = diagram.selectionList[0].offsetX;
		var yCoord = diagram.selectionList[0].offsetY;
		var condValList = getGridAllData();
		
		//정형 일 경우는 rule유형 코드를 비정형일경우는 function rid를 넣는다.
		var ridNodeSubType = type;
		if (type == "UNSTRUC") {
			ridNodeSubType = $("#ridNodeSubType").val();
			condValList = ruleInfoPopData.etCampaignCond.condValList;
			
			if (condValList.length == 0) { 
				var condVal = {
						irreglrCompVal : $("#irreglrCompVal").val()
				}
				condValList.push(condVal);
			} else {
				condValList[0].irreglrCompVal = $("#irreglrCompVal").val();
			}
		}
		
		var rid = ruleInfoPopData.etCampaignCond.rid;
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
				ridMktCamMst: campaign.id,
				campaignId: campaign.id,
				dataStatus: "U"
		}
		
	    diagram._selectedObject.data.etCampaignCond = requestData;
	    diagram._selectedObject.taskDataStatus = getTaskStatusCode(requestData);
		
        $.ifvSyncPostJSON('<ifvm:action name="saveETCampaignCond"/>', requestData,
       	function(result) {
        	//set actual task ID
            diagram._selectedObject.actualTaskId = result.message;
        	
            //set campaign ID
            diagram._selectedObject.campaignId = campaign.id;
            
            //set old campaign ID
            diagram._selectedObject.oldCampaignId = campaign.id;
        	
          	//save workflow
            saveWorkflow();
        	
        	//close popup
        	closeRuleInfoPop();
       	},
       	function(result) {
       		
       	});
	}
}

//dialog close
function closeRuleInfoPop(args) {
    //dialog 파괴
    cDialog._destroy();
}

$(document).ready(function() {
	initRuleInfoPop();
	initRuleInfoData();
	
	//저장 클릭시
    $('#ruleInfoPopSaveBtn').on('click', function(){
    	saveRuleInfo();
    });
    
    //추가 클릭시
    $('#ruleInfoListAddBtn').on('click', function(){
    	addRuleInfoListGridTr();
    });
    
    //삭제 클릭시
    $('#ruleInfoListRmvBtn').on('click', function(){
    	delRuleInfoListGridTr();
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
    	setRuleInfoArea($(this).val(), true);
    	ruleInfoPopData.etCampaignCond.condValList = [];
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

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap" id="ruleInfoPop" >
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01884'/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="type" names="type" required="true" />
            </div>
        </div>
        <div id="STRUC_area" style="min-height:300px;">
			<header class="temp_title_bb">
				기본정보
			</header>
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01885'/></label>
	            <div class="col-xs-4 control_content">
	                <ifvm:input type="text" id="title" names="title" required="true" maxLength="100"/>
	            </div>
	            <label class="col-xs-2 control-label"><spring:message code='M01886'/></label>
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
	            <label class="col-xs-2 control-label"><spring:message code='M01887'/></label>
	            <div class="col-xs-10 control_content">
	                <ifvm:input type="textarea" rows="2" id="desctxt" maxLength="200"/>
	            </div>
	        </div>
	        
	        <header class="temp_title_bb">
				<spring:message code='M01888'/>
				<div class="pop_top_btn">
					<button class="btn_pop_white " id="ruleInfoListAddBtn" >
						<img src="<ifvm:image name='btn_plus'/>" alt="" />
						<spring:message code="M00166"/>
					</button>
					<button class="btn_pop_white " id="ruleInfoListRmvBtn" >
						<img src="<ifvm:image name='btn_minus'/>" alt="" />
						<spring:message code="M01854"/>
					</button>
				</div>
			</header>
	        <div id="ruleInfoListGrid" class="" style="padding-bottom: 10px;"></div>
	    </div>
        <div id="UNSTRUC_area" style="min-height:150px;">
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
	        <div class="row qt_border" >
	            <label class="col-xs-2 control-label">비교 값</label>
	            <div class="col-xs-4 control_content">
	            	<ifvm:input type="text" id="irreglrCompVal" names="irreglrCompVal" />
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