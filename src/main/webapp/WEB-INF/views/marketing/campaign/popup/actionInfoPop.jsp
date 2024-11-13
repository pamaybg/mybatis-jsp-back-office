<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var actionInfoPopValidation;

var nodeTypeCd = "ACT";

var actionInfoPopData = {
		etCampaignAct: {
			actVal: {}	
			, actParam: []
		}
		, lgclCmpntId : ""
		, lgcCompColumnList: []
}

//rule 정보 팝업 설정
function initActionInfoPop() {
	//set popup
	cDialog.model.title = '<spring:message code="M01865"/>';
    $("#dialog_title").append('<spring:message code="M01865"/>');
    cDialog.model.width = "700";
    cDialog.model.close = "closeActionInfoPop";

    
	$.fn.ifvmSetSelectOptionCommCode("tranTypeCd", "MKT_ACT_TRAN_TYPE_CD", "", "", false);
	
	//node 유형 설정
	$.fn.ifvmSetSelectOptionCommCode("type", "MKT_CAM_NODE_TYPE", "", "00b68f1de9b011e000000615", true);
	
	//적립 유형
	//$.fn.ifvmSetSelectOptionCommCode("acrlType", "LOY_ACRL_TYPE", "", "", true);
	
	// function
	$.fn.ifvmSetSelectOptionCommCode("function", "MKT_ACT_FUNC_TYPE_CD", "", "", true);
	
	// symbol
	$.fn.ifvmSetSelectOptionCommCode("symbol", "MKT_ACT_SYMBOL_TYPE_CD", "", "", true);
	
	//validation
    actionInfoPopValidation = $("#actionInfoPop").ifvValidation(); 
}

//rule 정보 데이터 설정
function initActionInfoData() {
	//set task type
	diagram._selectedObject.taskType = "ETACT";
	
	//캠페인 ID
	var rid = diagram._selectedObject.actualTaskId; 
	
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getETCampaignAct"/>', {
        rid: rid
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
    		actionInfoPopData.etCampaignAct = result;
    		
    		//rule 정보 설정
    		setActionInfo(result);
    	} else {
    		setActionInfoArea("CAL");
    	}
    });
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
	    $("#tranTypeCd").val(data.actVal.acrlType);
	    $("#bnftAcrlAmt").val(data.actVal.bnftAcrlAmt);
	    $("#ridMktOfferMst").val(data.actVal.ridMktOfferMst);
	    $("#lgcCompNm").val(data.actVal.lgcCompNm);
	    
	    if ($.fn.ifvmIsNotEmpty(data.actVal.lgclCmpntId)) {
	    	actionInfoPopData.lgclCmpntId = data.actVal.lgclCmpntId;
	    	getETLogicalComponentColumnList(data.actVal.lgclCmpntId);
	    }
	} else {
		actionInfoPopData.etCampaignAct.actVal = {};
	}
	
	if ($.fn.ifvmIsNotEmpty(data.actParam)) {
		setParamList(data.actParam);
	} else {
		actionInfoPopData.etCampaignAct.actParam = [];
	}
}

//정형/비정형 area 설정
function setActionInfoArea(type) {
	if (type == "OFF") {
		$("#offer_area").show();
		$("#function_area").hide();
		
		//초기화
		$("#subInputScrn").val("");
		$("#ridNodeSubType").val("");
		
		//validation 추가
		$("#offerNm").attr("required", "");
	} else if (type == "FUNC") {
		$("#function_area").show();
		$("#offer_area").hide();
		
		//초기화
	    $("#offerNm").val("");
	    $("#offerTypeCdNm").val("");
	    $("#acrlType").val("");
	    $("#bnftAcrlAmt").val("");
	    $("#ridMktOfferMst").val("");
	    
	  	//validation 삭제
		$("#offerNm").removeAttr("required");
	} else if (type == "CAL") {
		$("#function_area").hide();
		$("#offer_area").hide();
		$("#lc_area").show();
		$("#function_area2").show();
		$("#symbol_area").show();
		$("#param_area").show();
		
		//초기화
		$("#subInputScrn").val("");
		$("#ridNodeSubType").val("");
	    $("#offerNm").val("");
	    $("#offerTypeCdNm").val("");
	    $("#tranTypeCd").val("");
	    $("#bnftAcrlAmt").val("");
	    $("#ridMktOfferMst").val("");
	    
	  	//validation 삭제
		$("#offerNm").removeAttr("required");
	} else if (type == "TR") {
		$("#function_area").hide();
		$("#offer_area").hide();
		$("#lc_area").show();
		$("#function_area2").show();
		$("#symbol_area").hide();
		$("#param_area").show();
		
		//초기화
		$("#subInputScrn").val("");
		$("#ridNodeSubType").val("");
	    $("#offerNm").val("");
	    $("#offerTypeCdNm").val("");
	    $("#acrlType").val("");
	    $("#bnftAcrlAmt").val("");
	    $("#ridMktOfferMst").val("");
	    
	  	//validation 삭제
		$("#offerNm").removeAttr("required");
	}
	
	
	//popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});
	
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

// param 설정
function setParamList(param) {
	var r = 0;
	var o = 0;
	var i = 0;
	var j = 0;
	
	
    $.each(param, function(k, v) {
    	var paramObj;
		    	
    	if (v.paramType == "RESULT") {
    		if (r > 0) { resultAddBtn(); }
    		
    		paramObj = $("[name=param]")[r++];
    	} else if (v.paramType == "OUPUT") {
    		paramObj = $("[name=outputParam]")[o++];
    	} else if (v.paramType == "INPUT") {
    		inputAddBtn();
    		
    		paramObj = $("[name=inputParam]")[i++];
    	} else if (v.paramType == "RETURN") {
    		if (j > 0) { returnValAddBtn(); }
    		
    		paramObj = $("[name=returnParam]")[j++];
    	}
    	
        $(paramObj).find('#paramNm').val(v.paramNm);
        $(paramObj).find('#paramVal').val(v.paramVal);
    });
}

// paream 목록
function getParamList() {
	var params = [];
	
    $.each($("[name=param]"), function(index, obj) {
        var paramNm = $(obj).find('#paramNm').val();
        var paramVal = $(obj).find('#paramVal').val();

        if (paramNm != "" && paramVal != "") {
            var obj = {
            		paramNm : paramNm
            		, paramVal : paramVal
            		, paramType: "RESULT"
            } 
            
            params.push(obj);
        }
    });
    
    $.each($("[name=outputParam]"), function(index, obj) {
        var paramNm = $(obj).find('#paramNm').val();
        var paramVal = $(obj).find('#paramVal').val();

        if (paramNm != "" && paramVal != "") {
            var obj = {
            		paramNm : paramNm
            		, paramVal : paramVal
            		, paramType: "OUTPUT"
            } 
            
            params.push(obj);
        }
    });
    
    $.each($("[name=inputParam]"), function(index, obj) {
        var paramNm = $(obj).find('#paramNm').val();
        var paramVal = $(obj).find('#paramVal').val();

        if (paramNm != "" && paramVal != "") {
            var obj = {
            		paramNm : paramNm
            		, paramVal : paramVal
            		, paramType: "INPUT"
            } 
            
            params.push(obj);
        }
    });
    
    $.each($("[name=returnParam]"), function(index, obj) {
        var paramNm = $(obj).find('#paramNm').val();
        var paramVal = $(obj).find('#paramVal').val();

        if (paramNm != "" && paramVal != "") {
            var obj = {
            		paramNm : paramNm
            		, paramVal : paramVal
            		, paramType: "RETURN"
            } 
            
            params.push(obj);
        }
    });
    
    return params;
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
		
		var actValRid = actionInfoPopData.etCampaignAct.actVal.rid;
		actValRid = $.fn.ifvmIsNotEmpty(actValRid) ? actValRid : "";
		
		var actVal = {
				rid: actValRid,
				ridMktOfferMst: $("#ridMktOfferMst").val(),
				acrlType: $("#tranTypeCd").val(),
				bnftAcrlAmt: $("#bnftAcrlAmt").val(),
				lgclCmpntId: actionInfoPopData.lgclCmpntId 
		};
		
		var rid = actionInfoPopData.etCampaignAct.rid;
		rid = $.fn.ifvmIsNotEmpty(rid) ? rid : "";
		
		var actParam = [];
		if (type == "CAL") {
			actParam = getParamList()
		}
		
		var requestData = {
				rid: rid,
				type: type,
				title: title,
				desctxt: desctxt,
				xCoord: xCoord,
				yCoord: yCoord,
				actVal: actVal,
				actParam: actParam,
				ridNodeSubType: ridNodeSubType,
				ridMktCamMst: campaign.id,
				campaignId: campaign.id
		}
		
	    diagram._selectedObject.data.etCampaignCond = requestData;
	    diagram._selectedObject.taskDataStatus = getTaskStatusCode(requestData);
	    requestData.dataStatus= getTaskStatusCode(requestData);
		
        $.ifvSyncPostJSON('<ifvm:action name="saveETCampaignAct"/>', requestData,
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
	    
	    actionInfoPopData.lgclCmpntId = logicalCompId;
	    $("#lgcCompNm").val(logicalCompName);
	    
		//로지컬 컴포넌트 컬럼 목록 조회
		getETLogicalComponentColumnList(logicalCompId);
		
		//팝업닫기
		campaignLgcCompListPopup._destroy();
    }
}

//로지컬 컴포넌트 컬럼 목록 조회
function getETLogicalComponentColumnList(lgclCmpntId) {
	$("#lcField option").remove();

	if ($.fn.ifvmIsNotEmpty(lgclCmpntId)) {
	    $.ifvSyncPostJSON('<ifvm:action name="getETLogicalComponentColumnList"/>', {
	    	logicalCompId: lgclCmpntId
	    },
	    function(result) {
	    	if ($.fn.ifvmIsNotEmpty(result)){
	    		var temp = $("#lcFieldTemplate").tmpl(result);
	    		$("#lcField").append(temp);
	    	}
	    });
	}
}

// LC 필드 선택
function lcFieldSelBtn() {
	var text = $("#lcField  option:checked").val();
	textCopy(text);
}

// function 선택
function functionSelBtn() {
	var text = $("#function  option:checked").text();
	
	textCopy(text);
}

// symbol 선택
function symbolSelBtn() {
	var text = $("#symbol  option:checked").text();
	
	textCopy(text);
}

function textCopy(string) {
	  var textarea = document.createElement('textarea');
	  textarea.value = string;

	  document.body.appendChild(textarea);
	  textarea.select();
	  textarea.setSelectionRange(0, 9999);  // 추가

	  document.execCommand('copy');
	  document.body.removeChild(textarea);
}

function resultAddBtn() {
	var temp = $("#resultTemplate").tmpl();
	$("#result_area").append(temp);
}

function resultRemoveBtn(_this) {
	$($(_this).closest("div")).remove();
}

function inputAddBtn() {
	var temp = $("#inputParamTemplate").tmpl();
	$("#input_area").append(temp);
}

function inputRemoveBtn(_this) {
	$($(_this).closest("div")).remove();
}

function returnValAddBtn() {
	var temp = $("#returnParamTemplate").tmpl();
	$("#returnVal_area").append(temp);
}

function returnValRemoveBtn(_this) {
	$($(_this).closest("div")).remove();
}

function setTranTypeCd(type) {
	$("#input_area").empty();
	
	var parmas = [];
	
	if ("ACRL_MILE" == type) {
		parmas = [
			{paramNm : "pMileage"}
			, {paramNm : "pMileageEffDt"}
		];
	}
	
	else if ("ACRL_Q_MILE" == type) {
		parmas = [
			{paramNm : "pMileage"}
			, {paramNm : "pQualMileage"}
		];
	}
	
	else if ("RDM_MILE" == type) {
		parmas = [
			{paramNm : "pMileage"}
		];
	}
	
	else if ("PUR_MILE" == type) {
		parmas = [
			{paramNm : "pMileage"}
			, {paramNm : "pTxnAmt"}
		];
	}
	
	else if ("CANCEL_PUR_MILE" == type) {
		parmas = [
			{paramNm : "pTxnAmt"}
		];
	}
	
	$.each(parmas, function(index, obj) {
		var temp = $("#inputParamTemplate").tmpl(obj);
		$("#input_area").append(temp);
	});
}

$(document).ready(function() {
	initActionInfoPop();
	
	setTimeout(function() {
		initActionInfoData();
	}, 100);
	
	//저장 클릭시
    $('#actionInfoPopSaveBtn').on('click', function(){
    	saveActionInfo();
    });
    
    //취소 클릭시
    $('#actionInfoPopCloseBtn').on('click', function(){
    	closeActionInfoPop();
    });
    
    //rule 유형 변경시
    $('#type').on('change', function() {
    	setActionInfoArea($(this).val());
    });
    
    //Transaction 유형 변경시
    $('#tranTypeCd').on('change', function() {
    	setTranTypeCd($(this).val());
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
    });
});
</script>

<script id="lcFieldTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}id}" value="${'${'}alias}">${'${'}displayName}(${'${'}alias})</option>
</script>

<script id="resultTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border" id="param" name="param">
	<label class="control-label col-xs-2">Result</label>
	<div class="control_content col-xs-2">
		<input type="text" id="paramNm" >
	</div>
    <div class="control_content col-xs-6">
		<input type="text" id="paramVal" >
	</div>
	<button type="button" class="btn btn-sm btn_pop_white" id="resultRemoveBtn" onclick="resultRemoveBtn(this);">Remove</button>
</div>
</script>

<script id="inputParamTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border" id="inputParam" name="inputParam">
	<label class="control-label col-xs-2">Input</label>
	<div class="control_content col-xs-2">
		<input type="text" id="paramNm" disabled value="${'${'}paramNm}">
	</div>
    <div class="control_content col-xs-6">
		<input type="text" id="paramVal" >
	</div>
	<%-- <button type="button" class="btn btn-sm btn_pop_white" id="inputRemoveBtn" onclick="inputRemoveBtn(this);">Remove</button> --%>
</div>
</script>

<script id="returnParamTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border" id="returnParam" name="returnParam">
	<label class="control-label col-xs-2">Return Val.</label>
	<div class="control_content col-xs-2">
		<input type="text" id="paramNm" >
	</div>
    <div class="control_content col-xs-6">
		<input type="text" id="paramVal" >
	</div>
	<button type="button" class="btn btn-sm btn_pop_white" id="returnValRemoveBtn" onclick="returnValRemoveBtn(this);">Remove</button>
</div>
</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="actionInfoPop" >
        <div class="row qt_border" style="display:none;">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01868"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="type" names="type" required="true" />
            </div>
        </div>
        
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01869"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" id="title" names="title" required="true" />
            </div>
        </div>
        
        <div id="offer_area">
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
        
        <div id="lc_area" >
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label">LC</label>
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
	            <label class="col-xs-2 control-label">Field</label>
	            <div class="col-xs-4 control_content">
	            	<ifvm:input type="select" id="lcField" names="lcField"/>
	            </div>
	            <div class="col-xs-1 control_content">
	            	<ifvm:inputNew type="button" className="btn_pop_white" text="Copy" nuc="true" id="lcFieldSelBtn"  btnFunc="lcFieldSelBtn" />
	            </div>
	        </div>
		</div>
		<div id="function_area2" >
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label">Function</label>
	            <div class="col-xs-4 control_content">
	            	<ifvm:input type="select" id="function" names="function"/>
	            </div>
	            <div class="col-xs-1 control_content">
	            	<ifvm:inputNew type="button" className="btn_pop_white" text="Copy" nuc="true" id="functionSelBtn"  btnFunc="functionSelBtn" />
	            </div>
	        </div>
		</div>
		<div id="symbol_area">
	        <div class="row qt_border">
	            <label class="col-xs-2 control-label">Symbol</label>
	            <div class="col-xs-4 control_content">
	            	<ifvm:input type="select" id="symbol" names="symbol"/>
	            </div>
	            <div class="col-xs-1 control_content">
	            	<ifvm:inputNew type="button" className="btn_pop_white" text="Copy" nuc="true" id="symbolSelBtn"  btnFunc="symbolSelBtn" />
	            </div>
	        </div>
	    </div>

		<div id="calculation_area">
	        <header class="temp_title_bb">
				Calculation
			</header>
	        <div id="result_area">
		        <div class="row qt_border" id="param" name="param">
		            <ifvm:inputNew type="text" id="paramNm" names="paramNm" label="Result" nuc="true" labelClass="2" conClass="2"/>
		            <ifvm:inputNew type="text" id="paramVal" names="paramVal" conClass="6" />
		            <ifvm:inputNew type="button" className="btn_pop_white" text="Add" nuc="true" id="resultAddBtn"  btnFunc="resultAddBtn" />
		        </div>
	        </div>
        </div>
        
		<div id="transaction_area">
	        <header class="temp_title_bb">
				Transaction
			</header>
			<div id="ouput_area">
				<div class="row qt_border">
					<ifvm:inputNew type="select" id="tranTypeCd" names="tranTypeCd" label="Type" nuc="true" labelClass="2" conClass="4"/>
				</div>
		        <div class="row qt_border" id="outputParam" name="outputParam">
		            <ifvm:inputNew type="text" id="paramNm" names="paramNm" label="Output" nuc="true" labelClass="2" conClass="2" disabled="true" values="rsltCd" />
		            <ifvm:inputNew type="text" id="paramVal" names="paramVal" conClass="8" disabled="true" />
		        </div>
		        <div class="row qt_border" id="outputParam" name="outputParam">
		            <ifvm:inputNew type="text" id="paramNm" names="paramNm" label="Output" nuc="true" labelClass="2" conClass="2" disabled="true" values="rsltVal" />
		            <ifvm:inputNew type="text" id="paramVal" names="paramVal" conClass="8" disabled="true" />
		        </div>
			</div>
			<div id="input_area">
			<%-- 
		        <div class="row qt_border" id="inputParam" name="inputParam">
		            <ifvm:inputNew type="text" id="paramNm" names="paramNm" label="Input" nuc="true" labelClass="2" conClass="2"/>
		            <ifvm:inputNew type="text" id="paramVal" names="paramVal" conClass="6" />
		            <ifvm:inputNew type="button" className="btn_pop_white" text="Add" nuc="true" id="inputAddBtn"  btnFunc="inputAddBtn" />
		        </div>
		     --%>
	        </div>
	    </div>
	    
		<div id="return_area">
	        <header class="temp_title_bb">
				Return
			</header>
			<div id="returnVal_area">
		        <div class="row qt_border" id="returnParam" name="returnParam">
		            <ifvm:inputNew type="text" id="paramNm" names="paramNm" label="Return Val." nuc="true" labelClass="2" conClass="2"/>
		            <ifvm:inputNew type="text" id="paramVal" names="paramVal" conClass="6" />
		            <ifvm:inputNew type="button" className="btn_pop_white" text="Add" nuc="true" id="returnValAddBtn"  btnFunc="returnValAddBtn" />
		        </div>
			</div>
		</div>
        
        <div class="row qt_border" style="display:none;">
            <label class="col-xs-2 control-label"><spring:message code="M01875"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="textarea" rows="2" id="desctxt" />
            </div>
        </div>
		<div class="pop_btn_area" style="padding-top:20px;">
		    <button class="btn btn-sm btn_gray" id="actionInfoPopSaveBtn">
		        <i class="glyphicon glyphicon-check"></i>
		        <spring:message code="M00137"/>
		    </button> 
		    <button class="btn btn-sm btn_lightGray2" id="actionInfoPopCloseBtn">         
		        <spring:message code="M00441"/>
		    </button> 
		</div>
	</div>
</div>

<div id="campaignLgcCompListPopup" class="popup_container"></div>
<div id="benefitsOfferListPopup" class="popup_container"></div>
<div id="functionListPopup" class="popup_container"></div>