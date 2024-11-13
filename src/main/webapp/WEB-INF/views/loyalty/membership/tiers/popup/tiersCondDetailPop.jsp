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
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />

<!-- css -->
<style>
#tiersCondListGrid td {text-align:center}
.description_guide dl {margin-bottom: 0px}
</style>
<!-- css END -->

<script>

var ridTier = '<%= cleanXss(request.getParameter("ridTier")) %>';
var condType = '<%= cleanXss(request.getParameter("type")) %>';
ridTier = ridTier === 'null' ? null : ridTier;

var validation;
var tiersCondListGrid;
var gridIdtiersCondListGrid;
var newFlag = false;
var nextFlag = false;
var tierDataArr;
var andFlag = false;

var tiersCondData = {
		ridTier : ridTier
		, tierCd : ''
		, tierNm : ''
		, tierCondDetail : []
		, tierCondDetailRemove : []
		, rsltBasTypeCdCdList : []
		, logicOperCodeList: ['', 'AND', 'OR']
}

function tierPopupClose() {
	dialog._destroy();

	if($.fn.ifvmIsNotEmpty(tierDataArr)){
		if(newFlag){
			$("#curTierNm").val(tierDataArr[0].tierNm);
			$("#curTierNm").text(tierDataArr[0].rid);
			
			ridTier = tierDataArr[0].rid;
			getTiersCond();
			tiersCondListGrid.searchGrid();
			
			newFlag = false;
			return;
		}
	}
}

// 공통 조회
function getCommCodeList(){
	//구매금액과 구매횟수 의 경우 PUR_BASE,PUR_CNT_BASE
	if(ruleBasType=="PUR_AND_CNT") {
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_TIERUP_BASE_CD'
			, enableNA : true
		}, function(result) {
			$.each(result.rows, function(index, data) {
				if (data.parCodeId == "PUR_BASE" || data.parCodeId == "PUR_CNT_BASE"){
					tiersCondData.rsltBasTypeCdCdList.push(data);
				}
			});
		});
	} else {
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_TIERUP_BASE_CD'
			, enableNA : true
			, parCodeId : ruleBasType
		}, function(result) {
			tiersCondData.rsltBasTypeCdCdList = result.rows;
		});
	}
};

//등급목록 조회
function getTiersCond() {
	if($.fn.ifvmIsNotEmpty(ridTier)) {
		$.ifvSyncPostJSON('<ifvm:action name="getTiersCond"/>', {
			ridTier : ridTier
			, type : condType
		}, function(result) {
			tiersCondData = result;
			tiersCondData.rsltBasTypeCdCdList = [];
			tiersCondData.tierCondDetailRemove = [];
			tiersCondData.logicOperCodeList = ['', 'AND', 'OR'];
			
			if ($.fn.ifvmIsNotEmpty(tiersCondData.ridTier)){
				$('#curTierNm').val(tiersCondData.tierNm);
				$('#curTierNm').text(tiersCondData.ridTier);

				if ($.fn.ifvmIsNotEmpty(tiersCondData.tierCondDetail)){
					andFlag = true;
				} else {
					andFlag = false;
				}
			}
		});
		// 상세 조회
		setTiersCondDetailList();
		setFirstRow();
	}
}


//등급목록 수정
function modifyTiersCond(){
	validation = $("#tiersCondDetailPopForm").ifvValidation();
	if(validation.confirm()){
		var _tierCondDetail = getGridAllData();
		var setType = "ONLY_PUR";
		
		// 구매일 경우 유형 처리
		if(ruleBasType == "PUR_BASE"){
			if($.fn.ifvmIsNotEmpty(_tierCondDetail)){
				if(_tierCondDetail[0].logicOper == "" && _tierCondDetail[0].rsltBasTypeCd == "01"){
					setType = "ONLY_PUR";

					if(_tierCondDetail.length > 1){
						if(_tierCondDetail[1].logicOper == "AND" && _tierCondDetail[1].rsltBasTypeCd == "03"){
							setType = "PUR_A_CNT";
						}else if(_tierCondDetail[1].logicOper == "OR" && _tierCondDetail[1].rsltBasTypeCd == "03"){
							setType = "PUR_O_CNT";
						}
					}
				}else if(_tierCondDetail[0].logicOper == "" && _tierCondDetail[0].rsltBasTypeCd == "03"){
					setType = "ONLY_CNT";

					if(_tierCondDetail.length > 1){
						if(_tierCondDetail[1].logicOper == "AND" && _tierCondDetail[1].rsltBasTypeCd == "01"){
							setType = "PUR_A_CNT";
						}else if(_tierCondDetail[1].logicOper == "OR" && _tierCondDetail[1].rsltBasTypeCd == "01"){
							setType = "PUR_O_CNT";
						}
					}
				}
			}

		} else {
			setType = "PNT_ACRL";
		}
		
		var requestData = {
				ridTier : $("#curTierNm").text(),
				dataStatus : "U",
				tierCondDetail	: _tierCondDetail,
				tierCondDetailRemove : tiersCondData.tierCondDetailRemove,
				type : condType
		}
		
		if(_tierCondDetail.length > 1){
			if(_tierCondDetail[0].rsltBasTypeCd == _tierCondDetail[1].rsltBasTypeCd ){
				alert('<spring:message code="M01990" />');
				return;
			}
		}

	 	$.ifvSyncPostJSON('<ifvm:action name="editTiersCond"/>'
	 	, requestData
		, function(result) {
			alert('<spring:message code="M00624"/>');
			tiersCondList.searchGrid();
			tierCondDetailPop._destroy();
		});
	}
}


// 승급 상세 조회
function setTiersCondDetailList() {
	var jqGridOption = {
	   		loadComplete : function(obj){
	   		},
			data : tiersCondData.tierCondDetail,
			datatype: 'clientSide',
		    colNames:[
		              'AND/OR',
		              '(',
		              '<spring:message code="M01991" />',
		              '<spring:message code="M01992" />',
		              ')',
		              'rid',
		              'seq'
		              ],
		    colModel:[
		        {name:'logicOper',index:'', resizable : false, width: "80", formatter: logicOperFormat},
		        {name:'frntBrktYn',index:'', resizable : false, width: "10", formatter: frntBrktYnFormat},
		        {name:'rsltBasTypeCd',index:'', resizable : false, width: "80", formatter: rsltBasTypeCdFormat},
		        {name:'sectStartVal',index:'', resizable : false, width: "80", formatter: sectStartValFormat},
		        {name:'backBrktYn',index:'', resizable : false, width: "10", formatter: backBrktYnFormat},
		        {name:'rid', index:'', hidden : true },
		        {name:'seq', index:'', hidden : true }
		    ],
		    radio : true,
		    rowList : [10000],
		    tempId : 'ifvGridSimpleTemplete'
		};

	tiersCondListGrid = $("#tiersCondListGrid").ifvGrid({ jqGridOption : jqGridOption });
	tiersCondListGrid.opt.postData= {page: 1};
	gridIdtiersCondListGrid = $("#gridIdtiersCondListGrid");
}

 function logicOperFormat(cellValue, options, rowdata){
 	if (typeof cellValue == "undefined") cellValue = "";
 	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;

 	var select = "<select class='logicOper' id='logicOper_" + options.rowId + "' name='logicOper_" + options.rowId + "'>"  ;
 	//option
 	$.each(tiersCondData.logicOperCodeList, function(index, data){
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
	getCommCodeList();
	
	//option
	$.each(tiersCondData.rsltBasTypeCdCdList, function(index, data){
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
 function addTiersCondListGridTr(){
 	var _tierCondDetail = tiersCondData.tierCondDetail;
 	var rowData = {};

 	_tierCondDetail.push(rowData);

     //추가
     tiersCondListGrid.addLocalTr();

     setFirstRow();

     //popup 높이 맞추기
 	new ifvm.PopupHeight({
 		popupDivId : 'dialog',
 		contentsId : 'dialogPopupWrap'
 	});

 }


 //조건 상세 Grid row 삭제
 function delTiersCondListGridTr(_this) {

 	var _curr = $.fn.ifvmGridSelectRowIndex("gridIdtiersCondListGrid");
 	var _tierCondDetail = getGridAllData();

 	//작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	tiersCondData.tierCondDetailRemove.push({rid : _tierCondDetail[_curr].rid});
     	_tierCondDetail.splice(_curr, 1);
    } else {
    	alert('<spring:message code="M00911"/>');
    }

     //그리드 데이터 clear 후 데이터 재설정
    gridIdtiersCondListGrid.clearGridData();
    gridIdtiersCondListGrid.setGridParam({data: _tierCondDetail}).trigger("reloadGrid");

    setFirstRow();
     //popup 높이 맞추기
 	new ifvm.PopupHeight({
 		popupDivId : 'dialog',
 		contentsId : 'dialogPopupWrap'
 	});
 }

//그리드 rowdata 추출
 function getGridRowData(rowid, index) {
 	var data = tiersCondListGrid.getRowDatas(rowid);

 	var rid = data.rid;
 	var sectStartVal = $("#sectStartVal_" + rowid).val();
 	var sectEndVal = $("#sectEndVal_" + rowid).val();
 	var rsltBasTypeCd = $("#rsltBasTypeCd_" + rowid).val();
 	var rsltBasTypeNm = $("#rsltBasTypeCd_" + rowid + " option:selected").text();
 	var logicOper = $("#logicOper_" + rowid).val();

	var frntBrktYn = $("#frntBrktYn_" + rowid).is(":checked");
 	frntBrktYn = frntBrktYn ? "1" : "0";

 	var backBrktYn = $("#backBrktYn_" + rowid).is(":checked");
 	backBrktYn = backBrktYn ? "1" : "0";

 	var rowData = {
 		rid : rid,
 		sectStartVal : sectStartVal,
 		rsltBasTypeCd : rsltBasTypeCd,
 		rsltBasTypeNm : rsltBasTypeNm,
 		logicOper : logicOper,
		frntBrktYn : frntBrktYn,
 		backBrktYn : backBrktYn,
 		seq : index+1
 	};

 	return rowData;
 }

//그리드 전체 데이터 추출
function getGridAllData() {
 	var rowIds = tiersCondListGrid.getAllRowIds();
 	var rtnDatas = [];

 	$.each(rowIds, function(index, rowid) {
 		rtnDatas.push(getGridRowData(rowid, index));
 	});

 	return rtnDatas;
 }

function setFirstRow() {
	var firstFilterRowObjId = gridIdtiersCondListGrid.getDataIDs()[0];

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
	// 공통코드 조회
	getCommCodeList();

	// 등급상세 조회
	getTiersCond();

	// 취소 버튼
	$("#tiersCondDetailPopCancel").on("click", function() {
		tierCondDetailPop._destroy();
	});

	// 저장 버튼
 	$("#tiersCondSaveBtn").on("click", function(){
		modifyTiersCond();
	});

    //추가 클릭시
    $('#tiersCondAddBtn').on('click', function(){
    	if(tiersCondData.rsltBasTypeCdCdList.length > 1){
    		if(gridIdtiersCondListGrid.getGridParam("reccount") > 1){
    			alert('<spring:message code="M01994" />');
    			return;
    		}else{
    			addTiersCondListGridTr();
    		}
    	}else{
    		if(gridIdtiersCondListGrid.getGridParam("reccount") > 0){
    			alert('<spring:message code="M01995" />');
    			return;
    		}else{
    			addTiersCondListGridTr();
    		}
    	}


    });

    //삭제 클릭시
    $('#tiersCondDelBtn').on('click', function(){
    	var selectData = tiersCondListGrid.getCheckedGridData();

    	if( selectData.length == 0 ){
    		alert('<spring:message code="M00004" />');
    	}else{
    		delTiersCondListGridTr();
    	}
    });

	// 현재 등급명 버튼
	$('#tierListPopBtn').on('click', function(){
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
});
</script>


<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='tiersCondDetailPopForm'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01981" /></label>
	        <div class="col-xs-3 control_content">
	        	<div class="input-group">
	            	<ifvm:input type="text" id="curTierNm" readonly="true"/>
	            	<span class="input-group-addon" id="tierListPopBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	    </div>
        <header class="temp_title">
			<button class="btn_pop_white pop_top_btn" style="right:70px;" id="tiersCondAddBtn" objCode="tiersCondAddBtn_OBJ">
				<img src="<ifvm:image name='btn_plus'/>" alt="" />
				<spring:message code="M00166"/>
			</button>
			<button class="btn_pop_white pop_top_btn" id="tiersCondDelBtn" objCode="tiersCondDelBtn_OBJ">
				<img src="<ifvm:image name='btn_minus'/>" alt="" />
				<spring:message code="M00165"/>
			</button>
		</header>
       	<div id="tiersCondListGrid" class="grid_bd0"></div>
       	<div class="description_guide">
            <dl>
    			<dt><spring:message code="M01997" /></dt>
    			<dt><spring:message code="M01998" /></dt>
    			<dd><spring:message code="M01999" /></dd>
    			<dd><spring:message code="M02000" /></dd>
            </dl>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tiersCondSaveBtn" objCode="tiersCondSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tiersCondDetailPopCancel" objCode="tiersCondDetailPopCancel_OBJ">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="dialog" class="popup_container"></div>