<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<script>
var validation;
var tiersCondListGrid;
var gridIdtiersCondListGrid;
var newFlag = false;
var nextFlag = false;
var tierDataArr;
var andFlag = false;

var tempRidTier;
var tempfieldDesc;
var tempTiermNm;
var tempType;
var rowDsNmIndex;
var rowDsDescIndex;
var rowRidIndex;

var tiersCondData = {
		ridTier : ridTier
		, tierCd : ''
		, tierNm : ''
		, tierCondDetail : []
		, tierCondDetailRemove : []
		, rsltBasTypeCdCdList : []
		, logicOperCodeList: ['', 'AND', 'OR']
}

function setFirstRow() {
	var firstFilterRowObjId = gridIdtiersCondListGrid.getDataIDs()[0];

	if(andFlag){
		if( $.fn.ifvmIsNotEmpty( $( "#logicOper_1" ) )) {
			/* $( "#logicOper_1" ).attr("disabled",true); */
		}
	}else{
		if( $.fn.ifvmIsNotEmpty( $( "#logicOper_" + firstFilterRowObjId ) ) || $.fn.ifvmIsNotEmpty( $( "#logicOper_1" ) )) {
			/* $( "#logicOper_" + firstFilterRowObjId ).attr("disabled",true); */
			/* $( "#logicOper_1" ).attr("disabled",true); */
		}
	}
}

//조건상세 Grid 추가
function addTiersCondListGridTr(){
	var _tierCondDetail = tiersCondData.tierCondDetail;
	var rowData = {};
	//_tierCondDetail.push(rowData);
	
    //추가
    tiersCondListGrid.addLocalTr();

    setFirstRow();

    //popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});

}

//승급 상세 조회
function setTiersCondDetailList() {
	var jqGridOption = {
	   		loadComplete : function(obj){
	   		},
			data : tiersCondData.tierCondDetail,
			datatype: 'clientSide',
		    colNames:[
		    		  'AND/OR',
		    		  '(',
		              '데이터셋명',
		              '항목',
		              '값',
		              ')',
		              'tierGrpDataSetRid',
		              'tierGrpDataSetItemRid',
		              'rid',
		              'seq'
		              ],
		    colModel:[
		    	{name:'logicOper',index:'', resizable : false, width: "80", formatter: logicOperFormat},
		        {name:'frntBrktYn',index:'', resizable : false, width: "25", formatter: frntBrktYnFormat},
		        {name:'dsNm',index:'', resizable : false, width: "80", formatter: searchBoxFormat},
		        {name:'fieldDesc',index:'', resizable : false, width: "60",formatter: searchBoxFormat2},
		        {name:'condVal',index:'', resizable : false, width: "60",formatter: sectStartValFormat},
		        {name:'backBrktYn',index:'', resizable : false, width: "25", formatter: backBrktYnFormat},
		        {name:'tierGrpDataSetRid',index:'',hidden : true,formatter: secDataSetRidFormat},
		        {name:'tierGrpDataSetItemRid',index:'',hidden : true, formatter: secDataSetItemRidFormat},
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

//그리드 전체 데이터 추출
function getGridAllData() {
 	var rowIds = tiersCondListGrid.getAllRowIds();
 	var rtnDatas = [];

 	$.each(rowIds, function(index, rowid) {
 		rtnDatas.push(getGridRowData(rowid, index));
 	});

 	return rtnDatas;
 }
 
function removeComma(str)
{
	n = parseInt(str.replace(/,/g,""));
	return n;
}

 
//그리드 rowdata 추출
function getGridRowData(rowid, index) {
	var data = tiersCondListGrid.getRowDatas(rowid);
	var rid = data.rid;
	var dsNm = $("#tierRuleDsNm" + rowid).val();
	var fieldDesc = $("#fieldDesc" + rowid).val();
	var condVal = $("#sectStartVal" + rowid).val();
	condVal = removeComma(condVal);
	var tierGrpDataSetRid = $("#dataSetRidVal" + rowid).val();
	var tierGrpDataSetItemRid = $("#dataSetItemRidVal" + rowid).val();
	var logicOper = $("#logicOper_" + rowid).val();
	
	var frntBrktYn = $("#frntBrktYn_" + rowid).is(":checked");
 	frntBrktYn = frntBrktYn ? "1" : "0";

 	var backBrktYn = $("#backBrktYn_" + rowid).is(":checked");
 	backBrktYn = backBrktYn ? "1" : "0";

	var rowData = {
			rid  : rid,
			dsNm : dsNm,
			fieldDesc : fieldDesc,
			condVal : condVal,
			logicOper : logicOper,
			frntBrktYn : frntBrktYn,
	 		backBrktYn : backBrktYn,
			tierGrpDataSetRid : tierGrpDataSetRid,
			tierGrpDataSetItemRid : tierGrpDataSetItemRid,
			seqNo : index+1
	};

	return rowData;
}

//등급목록 조회
function getTiersCond() {
	if($.fn.ifvmIsNotEmpty(tiersRulesTierRid)) {
		$.ifvSyncPostJSON('<ifvm:action name="getTierGrpRuleList"/>', {
			ridTier : tiersRulesTierRid,
			tierGrpJobRid : tierGrpJobRid,
			tierBatchJobCd : tierBatchJobCd
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
function searchBoxFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	//var id = "tierTypeCd" + options.rowId;
	rowDsNmIndex = options.rowId;
	var html = '<div class="input-group">';
	html += '<input type="text" disabled="true" id="tierRuleDsNm'+options.rowId+'" value="' + value + '"/>';
	html += '<span id="tierDatasetBtn" onclick="tierDataSet()" class="input-group-addon">';
	html+= '<a><i class="fa fa-search"></i></a></sapn>';
	html+= '</div>';
	return html;
}

 //) formatter
function searchBoxFormat2(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	//var id = "tierTypeCd" + options.rowId;
	rowDsDescIndex = options.rowId;
	var html = '<input type="text" disabled="true" id="fieldDesc'+options.rowId+'" value="' + value + '"/>';
	return html;
}
 
 
function secDataSetRidFormat(cellValue, options, rowdata) {
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	//var id = "tierTypeCd" + options.rowId;
	rowRidIndex = options.rowId;
	var html = '<input type="hidden" disabled="true" id="dataSetRidVal'+options.rowId+'" value="' + value + '"/>';

	return html;
}

function secDataSetItemRidFormat(cellValue, options, rowdata) {
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	//var id = "tierTypeCd" + options.rowId;
	rowRidIndex = options.rowId;
	var html = '<input type="hidden" disabled="true" id="dataSetItemRidVal'+options.rowId+'" value="' + value + '"/>';

	return html;
}

function tierDataSet() {	
	$("#dataSetItemListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="dataSetItemListPop"/>',
        contentType: "ajax",
        title: '데이터셋 조회',
        width: '700px',
        close : 'dataSetItemListClosePop'
    });   
}

function dataSetItemListClosePop() {
	dataSetItemListPop._destroy();
}

//구간 시작 값 formatter
function sectStartValFormat(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	rowIndex = options.rowId;
	var html = '<div class="input-group">'
        	+'<input type="text" onKeyup="inputNumberAutoComma(this)" id="sectStartVal' + options.rowId + '" class="search_input"  style = "text-align:right;" value="' + value + '">'
            +'</div>'

	return html;
}
function inputNumberAutoComma(obj) {
   
    // 콤마( , )의 경우도 문자로 인식되기때문에 콤마를 따로 제거한다.
    var deleteComma = obj.value.replace(/\,/g, "");
    // 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입한다.
    obj.value = inputNumberWithComma(inputNumberRemoveComma(obj.value));
}

// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
function inputNumberWithComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
}

function inputNumberRemoveComma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, "");
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


function tierGrpListPopupClose() {
	dialog._destroy();
	
	var dataArr = tierGrpListPopList.opt.gridControl.getSelectedRecords();
	tierDataArr = dataArr;
	
	if($.fn.ifvmIsNotEmpty(tierDataArr)){
		if(newFlag){
			$("#curTierNm").val(tierDataArr[0].tierNm);
			$("#curTierNm").text(tierDataArr[0].rid);
			
			tiersRulesTierRid = tierDataArr[0].rid;
			getTiersCond();
			tiersCondListGrid.searchGrid();
			
			newFlag = false;
			return;
		}
	}
}

//등급목록 수정
function modifyTiersCond(){
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 가능합니다.");
		return;
	} */
	validation = $("#tiersCondDetailPopForm").ifvValidation();
	if(validation.confirm()){
		var _tierCondDetail = getGridAllData();
		var requestData = {
				tierGrpJobRid :  tierGrpJobRid,
				tierRid			  :  tiersRulesTierRid,
				/* tierGrpDataSetRid : tierGrpDataSetRid,
				tierGrpDataSetItemRid : tierGrpDataSetItemRid, */
				tierCondDetail	: _tierCondDetail,
				tierCondDetailRemove : tiersCondData.tierCondDetailRemove
				/* type : condType */
		}

	 	$.ifvSyncPostJSON('<ifvm:action name="editTiersRule"/>'
	 	, requestData
		, function(result) {
			alert('<spring:message code="M00624"/>');
			tierRuleGridList._doAjax();
			addTierRulePop._destroy();
		});
	}
}

//조건 상세 Grid row 삭제
function delTiersCondListGridTr(_this) {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd == 'S') {
		alert("작성중일때만 삭제 가능합니다.");
		return;
	} */
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


$(document).ready(function(){
	// 등급상세 조회
	getTiersCond();

	// 취소 버튼
	$("#tiersCondDetailPopCancel").on("click", function() {
		addTierRuleClosePopup();
	});

	// 저장 버튼
 	$("#tiersCondSaveBtn").on("click", function(){
		modifyTiersCond();
	});

	
    //추가 클릭시
    $('#tiersCondAddBtn').on('click', function(){
    	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
			alert("작성중일때만 추가할수 있습니다.");
			return;
		} */
    	addTiersCondListGridTr();
    	
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
	        contentUrl: '<ifvm:url name="tierGrpListPop"/>',
	        contentType: "ajax",
	        title: '등급 조회',
	        width: '500px',
	        close : 'tierGrpListPopupClose'
	    });
	});
});

</script>

<div id='tiersCondDetailPopForm'>
<br>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01981" /></label>
	        <div class="col-xs-5 control_content">
	        	<div class="input-group">
	            	<ifvm:input type="text" id="curTierNm" disabled="true"/>
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

	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tiersCondSaveBtn" objCode="tiersCondSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tiersCondDetailPopCancel" objCode="tiersCondDetailPopCancel_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>
<div id="dialog" class="popup_container"></div>
<div id="dataSetItemListPop" class="popup_container"></div>