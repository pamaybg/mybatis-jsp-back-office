<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />

<!-- css -->
<style>
.description_guide dl {margin-bottom: 0px}
</style>
<!-- css END -->

<script>
var validation;
var tierUpMatrixDtlListGrid;
var gridIdtierUpMatrixDtlListGrid;
var newFlag = false;
var nextFlag = false;
var tierDataArr;
var delRidRierupMatrixDtl = [];
var andFlag = false;

var tierUpMatrixDtlPopData = {
		etCampaignCond: {
			condValList: []
		}
		, tierUpMatrixRid : ""
		, rsltBasTypeCdCdList: []
		, logicOperCodeList: ['', 'AND', 'OR']
		, selRowData: {}
}

function tierPopupClose() {
	dialog._destroy();

	if($.fn.ifvmIsNotEmpty(tierDataArr)){
		if(newFlag){
			$("#nowTierNm").val(tierDataArr[0].tierNm);
			$("#nowTierNm").text(tierDataArr[0].rid);
			newFlag = false;
			return;
		}

		if(nextFlag){
			$("#nextTierNm").val(tierDataArr[0].tierNm);
			$("#nextTierNm").text(tierDataArr[0].rid);
			nextFlag = false;
			return;
		}
	}
}
// 공통 조회
function getCommCodeList(){
	// 승급상태
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIERUP_STAT_CD', enableNA : true
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#tierUpMatrixStatus").append(temp);
	});
	// 실적기준 유형

	//구매금액과 구매횟수 의 경우 PUR_BASE,PUR_CNT_BASE
	if(ruleBasType=="PUR_AND_CNT"){
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIERUP_BASE_CD', enableNA : true
		},function(result) {
			$.each(result.rows, function(index, data) {
				if (data.parCodeId == "PUR_BASE" || data.parCodeId == "PUR_CNT_BASE"){
					tierUpMatrixDtlPopData.rsltBasTypeCdCdList.push(data);
				}
			});
		});
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIERUP_BASE_CD', enableNA : true, parCodeId : ruleBasType
		},function(result) {
			tierUpMatrixDtlPopData.rsltBasTypeCdCdList = result.rows;
		});
	}

};

//등급목록 조회
function getTierUpMatrix(){

	$.ifvSyncPostJSON('<ifvm:action name="getTierUpMatrix"/>',{tierupMatrixRid : tierupMatrixRid }
	,function(result) {

		if ($.fn.ifvmIsNotEmpty(result)){
			$("#nowTierNm").text(result.ridTierCur);
			$("#nowTierNm").val(result.ridTierCurNm);
			$("#nextTierNm").text(result.ridTierNext);
			$("#nextTierNm").val(result.ridTierNextNm);
			$("#tierUpMatrixStatus").val(result.tierupStatCd);

			if ($.fn.ifvmIsNotEmpty(result.condValList)){
				andFlag = true;
				tierUpMatrixDtlPopData.etCampaignCond = result;
			}else{
				andFlag = false;
				tierUpMatrixDtlPopData.etCampaignCond.condValList = [];
			}

		}
	},function(result) {
	}
	);
	// 상세 조회
	getTierUpMatrixDtl();
	setFirstRow();

}


//등급목록 수정
function modifyTierUpMatrix(){
	var obj = {};
	validation = $("#tierUpMatrixDtlPopFormArea").ifvValidation();

	if(validation.confirm()){
		var ridTierCur = $("#nowTierNm").text();
		var ridTierNext = $("#nextTierNm").text();
		var tierupStatCd = $("#tierUpMatrixStatus").val();
		var condValList = getGridAllData();
		var setType = "ONLY_PUR";
		// 구매일 경우 유형 처리
		if(ruleBasType == "PUR_BASE"){
			if($.fn.ifvmIsNotEmpty(condValList)){
				if(condValList[0].logicOper == "" && condValList[0].rsltBasTypeCd == "01"){
					setType = "ONLY_PUR";

					if(condValList.length > 1){
						if(condValList[1].logicOper == "AND" && condValList[1].rsltBasTypeCd == "03"){
							setType = "PUR_A_CNT";
						}else if(condValList[1].logicOper == "OR" && condValList[1].rsltBasTypeCd == "03"){
							setType = "PUR_O_CNT";
						}
					}
				}else if(condValList[0].logicOper == "" && condValList[0].rsltBasTypeCd == "03"){
					setType = "ONLY_CNT";

					if(condValList.length > 1){
						if(condValList[1].logicOper == "AND" && condValList[1].rsltBasTypeCd == "01"){
							setType = "PUR_A_CNT";
						}else if(condValList[1].logicOper == "OR" && condValList[1].rsltBasTypeCd == "01"){
							setType = "PUR_O_CNT";
						}
					}
				}
			}

		}else{
			setType = "PNT_ACRL";
		}
		var requestData = {
				ridTierupMatrix : tierupMatrixRid,
				ridTierGroup 	: ridTierGroup,
				ridTierCur		: ridTierCur,
				ridTierNext		: ridTierNext,
				tierupStatCd	: tierupStatCd,
				condValList		: condValList,
				delRidRierupMatrixDtl : delRidRierupMatrixDtl,
				dataStatus		: "U",
				tierupMtxSetType: setType,
				type			: tierMatrixType
		}
		if(condValList.length > 1){
			if(condValList[0].rsltBasTypeCd == condValList[1].rsltBasTypeCd ){
				alert('<spring:message code="M01990" />');
				return;
			}
		}

	 	$.ifvSyncPostJSON('<ifvm:action name="editTierUpMatrix"/>',requestData
		,function(result) {
			alert('<spring:message code="M00624"/>');
			tierupMatrixListInit();
			tiersDtlPopClose();
		});
	}
}


// 승급 상세 조회
function getTierUpMatrixDtl(){
	var jqGridOption = {
	   		loadComplete : function(obj){
	   		},
			data : tierUpMatrixDtlPopData.etCampaignCond.condValList,
			datatype: 'clientSide',
		    colNames:[
		              'AND/OR',
		              '<spring:message code="M01991" />',
		              '<spring:message code="M01992" />',
		              '<spring:message code="M01993" />',
		              'rid',
		              'seq'
		              ],
		    colModel:[
		        {name:'logicOper',index:'', resizable : false, width: "100", formatter: logicOperFormat},
		        {name:'rsltBasTypeCd',index:'', resizable : false, width: "100", formatter: rsltBasTypeCdFormat},
		        {name:'sectStartVal',index:'', resizable : false, width: "100", formatter: sectStartValFormat},
		        {name:'sectEndVal',index:'', resizable : false, width: "100", formatter: sectEndValFormat},
		        {name:'rid', index:'', hidden : true },
		        {name:'seq', index:'', hidden : true }
		    ],
		    radio : true,
		    rowList : [10000],
		    tempId : 'ifvGridSimpleTemplete'
		};

	tierUpMatrixDtlListGrid = $("#tierUpMatrixDtlListGrid").ifvGrid({ jqGridOption : jqGridOption });
	tierUpMatrixDtlListGrid.opt.postData= {page: 1};
	gridIdtierUpMatrixDtlListGrid = $("#gridIdtierUpMatrixDtlListGrid");
}


//삭제 formatter
 function delFormat(cellValue, options, rowdata){
 	var html = '<button class="analysisFilterRowMinusBtn" id="del_' + options.rowId + '" onClick="deltierUpMatrixDtlListGridTr(this)"><img src="/resources/images/marketing/common/btn_minus.gif" alt=""></button>';

 	return html;
 }

 //and/or formatter
 function logicOperFormat(cellValue, options, rowdata){
 	if (typeof cellValue == "undefined") cellValue = "";
 	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;

 	var select = "<select class='logicOper' id='logicOper_" + options.rowId + "' name='logicOper_" + options.rowId + "'>"  ;
 	//option
 	$.each(tierUpMatrixDtlPopData.logicOperCodeList, function(index, data){
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
 function frntBrktYnFormat(cellValue, options, rowdata){
 	if (typeof cellValue == "undefined") cellValue = "";
 	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
 	var id = "frntBrktYn_" + options.rowId;

 	var html = "<input id='" + id + "' type='checkbox'>"

 	if (value == "1") {
 		html = "<input id='" + id + "' type='checkbox' checked>"
 	}

 	return html;
 }

 //) formatter
 function backBrktYnFormat(cellValue, options, rowdata){
 	if (typeof cellValue == "undefined") cellValue = "";
 	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
 	var id = "backBrktYn_" + options.rowId;

 	var html = "<input id='" + id + "' type='checkbox'>"

 	if (value == "1") {
 		html = "<input id='" + id + "' type='checkbox' checked>"
 	}

 	return html;
 }


//실적기준유형 formatter
function rsltBasTypeCdFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var select = "<select class='rsltBasTypeCd' id='rsltBasTypeCd_" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(tierUpMatrixDtlPopData.rsltBasTypeCdCdList, function(index, data){
		if (data.codeName == value) {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "' selected >"+ data.markName +"</option>";
		} else {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "'>"+ data.markName +"</option>";
		}
	});
   select += "</select>";
   return select;
}

//구간 시작 값 formatter
function sectStartValFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;

	var html = '<div class="input-group">'
        	+'<input type="number" id="sectStartVal_' + options.rowId + '" class="search_input" value="' + value + '">'
            +'</div>'

	return html;
}

//구간 종료 값 formatter
function sectEndValFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;

	var html = '<div class="input-group">'
        	+'<input type="number" id="sectEndVal_' + options.rowId + '" class="search_input" value="' + value + '">'
            +'</div>'

	return html;
}

//조건상세 Grid 추가
 function addtierUpMatrixDtlListGridTr(){
 	var condValList = tierUpMatrixDtlPopData.etCampaignCond.condValList;
 	var rowData = {};

 	condValList.push(rowData);

     //추가
     tierUpMatrixDtlListGrid.addLocalTr();

     setFirstRow();

     //popup 높이 맞추기
 	new ifvm.PopupHeight({
 		popupDivId : 'dialog',
 		contentsId : 'dialogPopupWrap'
 	});

 }


 //조건 상세 Grid row 삭제
 function deltierUpMatrixDtlListGridTr(_this) {

 	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdtierUpMatrixDtlListGrid");
 	var condValList = getGridAllData();

 	//작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	delRidRierupMatrixDtl.push(condValList[_curr].rid);
     	condValList.splice(_curr, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }

     //그리드 데이터 clear 후 데이터 재설정
    gridIdtierUpMatrixDtlListGrid.clearGridData();
    gridIdtierUpMatrixDtlListGrid.setGridParam({data: condValList}).trigger("reloadGrid");

    setFirstRow();
     //popup 높이 맞추기
 	new ifvm.PopupHeight({
 		popupDivId : 'dialog',
 		contentsId : 'dialogPopupWrap'
 	});
 }

//그리드 rowdata 추출
 function getGridRowData(rowid, index) {
 	var data = tierUpMatrixDtlListGrid.getRowDatas(rowid);

 	var rid = data.rid;
 	var sectStartVal = $("#sectStartVal_" + rowid).val();
 	var sectEndVal = $("#sectEndVal_" + rowid).val();
 	var rsltBasTypeCd = $("#rsltBasTypeCd_" + rowid).val();
 	var rsltBasTypeNm = $("#rsltBasTypeCd_" + rowid + " option:selected").text();
 	var logicOper = $("#logicOper_" + rowid).val();

 	var rowData = {
 		rid : rid,
 		sectStartVal : sectStartVal,
 		sectEndVal : sectEndVal,
 		rsltBasTypeCd : rsltBasTypeCd,
 		rsltBasTypeNm : rsltBasTypeNm,
 		logicOper : logicOper,
 		seq : index+1
 	};

 	return rowData;
 }

//그리드 전체 데이터 추출
function getGridAllData() {
 	var rowIds = tierUpMatrixDtlListGrid.getAllRowIds();
 	var rtnDatas = [];

 	$.each(rowIds, function(index, rowid) {
 		rtnDatas.push(getGridRowData(rowid, index));
 	});

 	return rtnDatas;
 }

function setFirstRow() {
	var firstFilterRowObjId = gridIdtierUpMatrixDtlListGrid.getDataIDs()[0];

	if(andFlag){
		if( $.fn.ifvmIsNotEmpty( $( "#logicOper_1" ) )) {
			$( "#logicOper_1" ).attr("disabled",true);
		}
	}else{
		if( $.fn.ifvmIsNotEmpty( $( "#logicOper_" + firstFilterRowObjId ) ) || $.fn.ifvmIsNotEmpty( $( "#logicOper_1" ) )) {
			$( "#logicOper_" + firstFilterRowObjId ).attr("disabled",true);
			$( "#logicOper_1" ).attr("disabled",true);
		}
	}

}

$(document).ready(function(){
	$("#tierUpMatrixDtlPopFormArea").ifvValidation();

	// 공통코드 조회
	getCommCodeList();

	// 등급상세 조회
	getTierUpMatrix();

	// 취소 버튼
	$("#tierUpMatrixPopCancel").on("click", tiersDtlPopClose);

	// 저장 버튼
 	$("#tierUpMatrixSaveBtn").on("click", function(){
		modifyTierUpMatrix();
	});

    //추가 클릭시
    $('#tierUpMatrixDtlAddBtn').on('click', function(){
    	if(tierUpMatrixDtlPopData.rsltBasTypeCdCdList.length > 1){
    		if(gridIdtierUpMatrixDtlListGrid.getGridParam("reccount") > 1){
    			alert('<spring:message code="M01994" />');
    			return;
    		}else{
    			addtierUpMatrixDtlListGridTr();
    		}
    	}else{
    		if(gridIdtierUpMatrixDtlListGrid.getGridParam("reccount") > 0){
    			alert('<spring:message code="M01995" />');
    			return;
    		}else{
    			addtierUpMatrixDtlListGridTr();
    		}
    	}


    });

    //삭제 클릭시
    $('#tierUpMatrixDtlDelBtn').on('click', function(){
    	var selectData = tierUpMatrixDtlListGrid.getCheckedGridData();

    	if( selectData.length == 0 ){
    		alert('<spring:message code="M00004" />');
    	}else{
    		deltierUpMatrixDtlListGridTr();
    	}
    });

	// 현재 등급명 버튼
	$('#nowTierBtn').on('click', function(){
		newFlag = true;
		$("#dialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="tierGrpDtlListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01996" />',
	        width: '700px',
	        close : 'tierPopupClose'
	    });
	});

	// 다음 등급명 버튼
	$('#nextTierBtn').on('click', function(){
		nextFlag = true;
		$("#dialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="tierGrpDtlListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01996" />',
	        width: '700px',
	        close : 'tierPopupClose'
	    });
	});

});
</script>


<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='tierUpMatrixDtlPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01981" /></label>
	        <div class="col-xs-4 control_content">
	        	<div class="input-group">
	            	<ifvm:input type="text" id="nowTierNm" readonly="true"/>
	            	<span class="input-group-addon" id="nowTierBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01982" /></label>
	        <div class="col-xs-4 control_content">
		        <div class="input-group">
		            <ifvm:input type="text" id="nextTierNm" readonly="true"/>
					<span class="input-group-addon" id="nextTierBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01983" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="tierUpMatrixStatus"/>
	        </div>
	    </div>
        <header class="temp_title">
			<button class="btn_pop_white pop_top_btn" style="right:70px;" id="tierUpMatrixDtlAddBtn" >
				<img src="<ifvm:image name='btn_plus'/>" alt="" />
				<spring:message code="M00166"/>
			</button>
			<button class="btn_pop_white pop_top_btn" id="tierUpMatrixDtlDelBtn">
				<img src="<ifvm:image name='btn_minus'/>" alt="" />
				<spring:message code="M00165"/>
			</button>
		</header>
       	<div id="tierUpMatrixDtlListGrid" class="grid_bd0"></div>
       	<div class="description_guide">
            <dl>
    			<dt><spring:message code="M01997" /></dt>
    			<dt><spring:message code="M01998" /></dt>
    			<dd><spring:message code="M01999" /></dd>
    			<dd><spring:message code="M02000" /></dd>
    			<dt><spring:message code="M02001" /></dt>
    			<dd><spring:message code="M02002" /></dd>
            </dl>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tierUpMatrixSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierUpMatrixPopCancel">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="dialog" class="popup_container"></div>