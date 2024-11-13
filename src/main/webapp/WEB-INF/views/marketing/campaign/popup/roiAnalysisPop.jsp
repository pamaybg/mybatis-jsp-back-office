<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var roiAnalysisCostGrid;
var gridIdroiAnalysisCostGrid;
//model
var campaignROI;

var responseTypeCode;
var costInputType;
var targetCustCount = 0;
var targetControlGroupCount = 0;

var costDescPop;
var costDesc;


//dialog close
function closeRoiAnalysisPop(args) {
	cDialog._destroy();
}

function roiAnalysisPopInit() {
    cDialog.model.title = '<spring:message code="M00912"/>';
    $("#dialog_title").append('<spring:message code="M00912"/>');
    cDialog.model.width = "1224";
    cDialog.model.close = "closeRoiAnalysisPop";
}

//반응 유형
function getResponseTypeCode() {
	//input Select 공통코드 option 생성
    $.ifvSyncPostJSON('/system/commcode/getCommCondLIst.do',{
        groupCode : "MKT_ROI_RSPNS_TYPE"
        , enableNA : true
    },function(result) {    
        if ($.fn.ifvmIsNotEmpty(result.rows)) {
        	responseTypeCode = result.rows;
        }
    });
	
	//select bosx 설정
    var rowDiv = ["BFR_T", "BFR_C", "AFTP_T", "AFTR_T", "AFTR_C"];
    $.each(rowDiv, function(index,data) {
    	var temp = $("#responseTypeCodeTemplate").tmpl(responseTypeCode);
        $("#" + data + " #responseTypeCode").append(temp);
    });
}

//비용 입력 유형
function getCostInputType() {
	//input Select 공통코드 option 생성
    $.ifvSyncPostJSON('/system/commcode/getCommCondLIst.do',{
        groupCode : "MKT_ROI_INPUT_TYPE"
        , enableNA : true
    },function(result) {	
    	if ($.fn.ifvmIsNotEmpty(result.rows)) {
    		costInputType = result.rows;
    	}
    });
}

//비용 입력 유형 select box 설정
function selectFormat(cellvalue, options, rowObjec){
	var select = "<select class='costInputType' id='" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(costInputType, function(index, data){
		if (data.codeName == cellvalue) {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "' selected >"+ data.markName +"</option>";
		} else {
			select += "<option codeId='" + data.codeId + "' value='" + data.codeName + "'>"+ data.markName +"</option>";
		}
	});
    select += "</select>";
    return select;
}

function textFormat(cellvalue, options, rowObjec){
	var html;
	var value = $.fn.ifvmIsEmpty(cellvalue) ? "" : cellvalue;
	if (options.colModel.name == "costName") {
		html = '<input id="" type="text" value="' + value + '"/>';
	} else if (options.colModel.name == "costAmt") {
		html = '<input id="" type="text" value="' + value + '" readOnly />';
	} else {
		html = '<input id="" type="number" value="' + value + '"/>';
	}
	
	return html;
}

//비용 상세 format
function costDescFormat(cellvalue, options, rowObjec){
	var value = $.fn.ifvmIsEmpty(cellvalue) ? "" : cellvalue;
    var html;
    html = '<input id="costDescInput" type="hidden" value="'+ value +'" />'
            + '<input id="costDescInputText" type="text" value="'+ value +'" onclick="costDescPopOpen(this)" readonly />';
    
    return html;
}

//비용 상세 팝업
function costDescPopOpen(node) {
	costDesc = node.parentElement.childNodes[0].value;
    
    $("#costDescPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="roiCostDescPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01391"/>',
        width: 320,
        Close : 'costDescPopClose',
        open : function(){
            new ifvm.PopupCenter({
                popupDivId : 'costDescPop'
            });
        }
    });
   
    costDescPop = $("#costDescPop").data("ejDialog");
}

//비용 상세 팝업 닫기
function costDescPopClose() {
	costDescPop._destroy();
	costDesc = "";
}

//비용 상세 팝업 확인
function costDescPopConBtn() {
    var selRowid =roiAnalysisCostGrid.getRadioSelectedRowId();
    var selCostDescInput = $("#" + selRowid).find("#costDescInput")[0];
    var selCostDescInput2 = $("#" + selRowid).find("#costDescInputText")[0];
    var costDescTextArea = $("#costDescTextarea").val();
    
    //해당 row의 비용상세에 값 입력
    $(selCostDescInput).val(costDescTextArea);
    $(selCostDescInput2).val(costDescTextArea);
    
    //close popup
    costDescPopClose();
}

//ROI Return 정보 설정
function setRoiReturnList() {
    $.each(campaignROI.campaignROIReturnList, function(index, data){
    	var rowDiv = data.campaignDataDivCode + "_" + data.targetBaseGroupCode;
    	$("#" + rowDiv).attr("rowid", data.id);
    	//대상군
    	if (data.campaignDataDivCode != "BFR") {
    		$("#" + rowDiv + " #campaignDataDivCodeName").text(data.campaignDataDivCodeName.substr(-2));
    	}
        $("#" + rowDiv + " #targetBaseGroupCodeName").text(data.targetBaseGroupCodeName);
        $("#" + rowDiv + " #targetCustCount").text(targetCustCount);
        $("#" + rowDiv + " #responseTypeCode").val(data.responseTypeCode);
        $("#" + rowDiv + " #responseCustCount").val(data.responseCustCount);
        $("#" + rowDiv + " #totalResponseAmt").val(data.totalResponseAmt);
    });
    
    //ROI Return 정보 계산 
    setRoiReturnCalculation();
}

//ROI Return 정보 계산 
function setRoiReturnCalculation() {
    var rowDiv = ["BFR_T", "BFR_C", "AFTP_T", "AFTR_T", "AFTR_C"];
    $.each(rowDiv, function(index,data) {
    	var custCount = 0;
    	
    	if (data.match("_T")) {
    		//대상군
	    	custCount = Number(targetCustCount);
    	} else {
    		//비교군
            custCount = Number(targetControlGroupCount);
    	}
    	
    	//고객수
    	$("#" + data + " #targetCustCount").text(custCount);
        
        //반응률
        var responseRate = (Number($("#" + data + " #responseCustCount").val()) / custCount) * 100 | 0;
        if(window.lang == "ko") {
        	$("#" + data + " #responseRate").text(responseRate.toFixed(0));
    	} else {
    		$("#" + data + " #responseRate").text(responseRate.toFixed(2));
    	}
        
        
        //인당 금액(전체)
        var priceAll = Number($("#" + data + " #totalResponseAmt").val()) / custCount | 0;
        if(window.lang == "ko") {
        	$("#" + data + " #priceAll").text(priceAll.toFixed(0));
    	} else {
    		$("#" + data + " #priceAll").text(priceAll.toFixed(2));
    	}
        
        
        //인당 금액(반응자)
        var priceResponse = Number($("#" + data + " #totalResponseAmt").val()) / Number($("#" + data + " #responseCustCount").val()) | 0;
        if(window.lang == "ko") {
        	$("#" + data + " #priceResponse").text(priceResponse.toFixed(0));
    	} else {
    		$("#" + data + " #priceResponse").text(priceResponse.toFixed(2));
    	}
        
    });
}

//ROI Cost Grid 설정
function setRoiAnalysisCostList(){
    var jqGridOption = {
        onSelectRow : function (data) {
            
        },
        serializeGridData : function( data ){
            
        },
        data: campaignROI.campaignROICostList,
        datatype: 'clientSide',
        colNames:[ 
                   '<spring:message code="M00755" />',
                   '<spring:message code="M00917" />',
                   '<spring:message code="M01391" />',
                   '<spring:message code="M00918" />',
                   '<spring:message code="M00919" />',
                   '<spring:message code="M00920" />',
                   'id'
                 ],
        colModel:[
            { name:'costTypeCode', index:'', resizable : false, sortable : false, width : 100, formatter : selectFormat},
            { name:'costName', index:'', resizable : false, sortable : false, width : 70, formatter : textFormat },
            { name:'costDesc', index:'', resizable : false, sortable : false, width : 65, formatter : costDescFormat },
            { name:'costUcost', index:'', resizable : false, sortable : false, width : 65, formatter : textFormat },
            { name:'costCount', index:'', resizable : false, sortable : false, width : 65, formatter : textFormat },
            { name:'costAmt', index:'', resizable : false, sortable : false, width : 65, formatter : textFormat},
            { name:'id', index:'', hidden : true }
        ],
        radio: true,
        tempId : 'costTotalTemplate',
        rowList : [100]
    };
    roiAnalysisCostGrid = $("#roiAnalysisCostGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdroiAnalysisCostGrid = $("#gridIdroiAnalysisCostGrid");
    
    //비용 Total 계산
    setCostTotalAmt();
}

//비용 Total 계산
function setCostTotalAmt() {
	var costList = getRoiAnalysisCostList();
	if ($.fn.ifvmIsNotEmpty(costList)) {
		var totalAmt = 0;
		$.each(costList, function(index, data) {
			if ($.fn.ifvmIsNotEmpty(data.costAmt)) {
			    totalAmt += Number(data.costAmt);
			}
		});
		
		$("#costTotalAmt").text(totalAmt);
	}
}

//ROI 계산
function setROI() {
	var before = 0;
	var after = 0;
	var diff = 0;
	var cost = 0;
	var rate = 0;
	
    //비용
    var costList = getRoiAnalysisCostList();
    $.each(costList, function(index, data){
    	cost += Number(data.costAmt) | 0;
    });
    
    /* 예측 start*/
	//반응건수
	before = Number($("#BFR_T #responseCustCount").val()) | 0;
	after = Number($("#AFTP_T #responseCustCount").val()) | 0;
	diff = after - before;
	rate = (100 * diff / cost).toFixed(2) | 0;
	$("#roi_p_1_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
	$("#roi_p_1_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
	$("#roi_p_1_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
	$("#roi_p_1_4").text( "-" );    //비용
	$("#roi_p_1_5").text( "-" );    //ROI Rate(100*C/D)
/* 	$("#roi_p_1_4").text( cost );    //비용
	$("#roi_p_1_5").text( rate );    //ROI Rate(100*C/D) */
	
	//반응액-전체
    before = Number($("#BFR_T #totalResponseAmt").val()) | 0;
    after = Number($("#AFTP_T #totalResponseAmt").val()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_p_2_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_p_2_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_p_2_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_p_2_4").text( $.fn.ifvmNumberWithCommas(String(cost)) );    //비용
    $("#roi_p_2_5").text( $.fn.ifvmNumberWithCommas(String(rate)) );    //ROI Rate(100*C/D)
    
    //반응액-인당평균(전체)
    before = Number($("#BFR_T #priceAll").text()) | 0;
    after = Number($("#AFTP_T #priceAll").text()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_p_3_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_p_3_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_p_3_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_p_3_4").text( "-" );    //비용
    $("#roi_p_3_5").text( "-" );    //ROI Rate(100*C/D)
/*     $("#roi_p_3_4").text( cost );    //비용
    $("#roi_p_3_5").text( rate );    //ROI Rate(100*C/D) */
    
    //반응액-인당평균(반응자)
    before = Number($("#BFR_T #priceResponse").text()) | 0;
    after = Number($("#AFTP_T #priceResponse").text()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_p_4_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_p_4_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_p_4_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_p_4_4").text( "-" );    //비용
    $("#roi_p_4_5").text( "-" );    //ROI Rate(100*C/D)
/*     $("#roi_p_4_4").text( cost );    //비용
    $("#roi_p_4_5").text( rate );    //ROI Rate(100*C/D) */
    /* 예측 end */    
    
    /* 실제 start*/
    //반응건수
    before = Number($("#BFR_T #responseCustCount").val()) | 0;
    after = Number($("#AFTR_T #responseCustCount").val()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_r_1_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_r_1_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_r_1_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_r_1_4").text( "-" );    //비용
    $("#roi_r_1_5").text( "-" );    //ROI Rate(100*C/D)
/*     $("#roi_r_1_4").text( cost );    //비용
    $("#roi_r_1_5").text( rate );    //ROI Rate(100*C/D) */
    
    //반응액-전체
    before = Number($("#BFR_T #totalResponseAmt").val()) | 0;
    after = Number($("#AFTR_T #totalResponseAmt").val()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_r_2_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_r_2_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_r_2_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_r_2_4").text( $.fn.ifvmNumberWithCommas(String(cost)) );    //비용
    $("#roi_r_2_5").text( $.fn.ifvmNumberWithCommas(String(rate)) );    //ROI Rate(100*C/D)
    
    //반응액-인당평균(전체)
    before = Number($("#BFR_T #priceAll").text()) | 0;
    after = Number($("#AFTR_T #priceAll").text()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_r_3_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_r_3_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_r_3_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_r_3_4").text( "-" );    //비용
    $("#roi_r_3_5").text( "-" );    //ROI Rate(100*C/D)
/*     $("#roi_r_3_4").text( cost );    //비용
    $("#roi_r_3_5").text( rate );    //ROI Rate(100*C/D) */
    
    //반응액-인당평균(반응자)
    before = Number($("#BFR_T #priceResponse").text()) | 0;
    after = Number($("#AFTR_T #priceResponse").text()) | 0;
    diff = after - before;
    rate = (100 * diff / cost).toFixed(2) | 0;
    $("#roi_r_4_1").text( $.fn.ifvmNumberWithCommas(String(before)) );    //실행전(A)
    $("#roi_r_4_2").text( $.fn.ifvmNumberWithCommas(String(after)) );    //실행후(B)
    $("#roi_r_4_3").text( $.fn.ifvmNumberWithCommas(String(diff)) );    //차이(B-A)
    $("#roi_r_4_4").text( "-" );    //비용
    $("#roi_r_4_5").text( "-" );    //ROI Rate(100*C/D)
/*     $("#roi_r_4_4").text( cost );    //비용
    $("#roi_r_4_5").text( rate );    //ROI Rate(100*C/D) */
    /* 실제 end */
}

//캠페인/대상자 먼저 등록 되어야 한다.
//고객수(대상자) 추출
function getTargetCustCount() {
  var campaignId = campaign.id;
  if ($.fn.ifvmIsNotEmpty(campaignId)) {
      $.ifvSyncPostJSON('<ifvm:action name="getCampaignTargetTotalCount"/>', {
          campaignId : campaignId
      },
      function(result) {
          if ($.fn.ifvmIsNotEmpty(result)) {
              //대상자 수
              if ($.fn.ifvmIsNotEmpty(result)) {
            	if(window.lang == "ko") {
            		 targetCustCount = Math.ceil(Number(result.finalCount));
                	 targetControlGroupCount = Math.ceil(Number(result.controlGroupCount));
              	} else {
              		targetCustCount = Number(result.finalCount);
              	    targetControlGroupCount = Number(result.controlGroupCount);
              	}
            	  
            	  
              } else {
            	targetCustCount = 0;
            	if(window.lang == "ko") {
            		 targetControlGroupCount = Math.ceil(Number(result.controlGroupCount));
               	} else {
               		targetControlGroupCount = Number(result.controlGroupCount);
               	}
            	 
            	  
              }
          }
      });
  }
}

//ROI Data 설정
function roiAnalysisPopInitData() {
	//node data 추출
    campaignROI = {campaignROIReturnList: [], campaignROICostList: []};
    
    //ROI Return 정보
    if ($.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignROI) 
            && $.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignROI.campaignROIReturnList)) {
        //ROI Return 정보 목록
        $.each(diagram._selectedObject.data.campaignROI.campaignROIReturnList, function(index, data){
        	campaignROI.campaignROIReturnList.push(data);
        });
    } else {
        diagram._selectedObject.data.campaignROI = $.extend(campaignROI, {campaignROIReturnList: [] });
    }
    
    //ROI Cost
    if ($.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignROI) 
            && $.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignROI.campaignROICostList)) {
        //ROI Cost 목록
        $.each(diagram._selectedObject.data.campaignROI.campaignROICostList, function(index, data){
        	campaignROI.campaignROICostList.push(data);
        });
    } else {
        diagram._selectedObject.data.campaignROI = $.extend(campaignROI, {campaignROICostList: [] });
    }
    
    //캠페인 ID
    campaign.id = diagram._selectedObject.actualTaskId;
    
    //call 캠페인 ROI
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignROI"/>', {
        campaignId: campaign.id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            $.each(result.campaignROIReturnList, function(index, data) {
            	if(window.lang == "ko") {
            		data.totalResponseAmt =  Math.ceil(data.totalResponseAmt);
              	} else {
              		data.totalResponseAmt =  data.totalResponseAmt;
              	}
            	
            });
        	
        	campaignROI = result;
        }
    });
    
    //고객수 추출
    getTargetCustCount();
    
    //유형설정
    //diagram._selectedObject.taskType = "ROI";
    
    //비용 입력 유형
    getCostInputType();
    
    //반응 유형
    getResponseTypeCode();
    
    //ROI Return 정보 설정
    setRoiReturnList();
    
    //ROI Cost 설정
    setRoiAnalysisCostList();
    
    //ROI 계산
    setROI();
    
}

//비용 Grid 추가
function addGridTr(){
	roiAnalysisCostGrid.addLocalTr();
}

//비용 Grid 삭제
function removeGridTr(){
	roiAnalysisCostGrid.delCheckedRow();
	
	//ROI 계산
	setROI();
	
	//Total 계산
	setCostTotalAmt();
}

//ROI Return 정보 추출
function getRoiReturnList() {
	var campaignROIReturnList = [];
	var rowDiv = ["BFR_T", "BFR_C", "AFTP_T", "AFTR_T", "AFTR_C"];
	$.each(rowDiv, function(index,data) {
		var rowData = {};
		var div = data.split("_")[0];
		var group = data.split("_")[1];
		rowData.id = $("#" + data).attr("rowid");
		rowData.campaignDataDivCode = div;
		if (div != "BFR") {
			rowData.campaignDataDivCodeName = $("#" + data + " #campaignDataDivCodeName").text();
        }
		rowData.targetBaseGroupCode = group;
		rowData.targetBaseGroupCodeName = $("#" + data + " #targetBaseGroupCodeName").text();
		rowData.targetCustCount = $("#" + data + " #targetCustCount").text();
		rowData.responseTypeCode = $("#" + data + " #responseTypeCode").val();
		rowData.responseCustCount = $("#" + data + " #responseCustCount").val();
		rowData.totalResponseAmt = $("#" + data + " #totalResponseAmt").val();
		
		campaignROIReturnList.push(rowData);
	});
	
	return campaignROIReturnList;
}

//ROI Cost 추출
function getRoiAnalysisCostList() {
	var campaignROICostList = [];
	var dataIDs = gridIdroiAnalysisCostGrid.getDataIDs();
	$.each(dataIDs, function(index, data) {
		var rowData = {};
		rowData.id = gridIdroiAnalysisCostGrid.getRowData(data).id; 
		rowData.costTypeCode = $("#" + data + " td")[1].firstChild.value;
		rowData.costName = $("#" + data + " td")[2].firstChild.value;
		rowData.costDesc = $("#" + data + " td")[3].firstChild.value;
		rowData.costUcost = $("#" + data + " td")[4].firstChild.value;
		rowData.costCount = $("#" + data + " td")[5].firstChild.value;
		
        if (isNotEmpty(rowData.costUcost) && isNotEmpty(rowData.costCount)) {
            var costAmt = Number(rowData.costUcost) * Number(rowData.costCount);
            $("#" + data + " td")[6].firstChild.value = costAmt;
        }
		
		rowData.costAmt = $("#" + data + " td")[6].firstChild.value;
		
		campaignROICostList.push(rowData);
	});
	
	return campaignROICostList;
}

//저장
function roiAnalysisPopSaveBtn() {
	campaignROI.campaignROIReturnList = getRoiReturnList();
	campaignROI.campaignROICostList = getRoiAnalysisCostList();
	campaignROI.dataStatus = getTaskStatusCode(campaignROI);
	campaignROI.campaignId = campaign.id;
	
    diagram._selectedObject.data.campaignROI = campaignROI;
    diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignROI);
    
    //call 캠페인 ROI
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignROI"/>', 
    	campaignROI,
    function(result) {
      	//save workflow
        saveWorkflow();
    	
    	//close popup
    	closeRoiAnalysisPop();
    });
}


$(function () {
	roiAnalysisPopInit();
	roiAnalysisPopInitData();
	
	//추가
	$("#roiCostGridAddBtn").on("click", function(){
		addGridTr();
	});
	
	//삭제
	$("#roiCostGridRemoveBtn").on("click", function(){
		removeGridTr();
	});
	
	//취소
	$("#roiAnalysisCloseBtn").on("click", function(){
		closeRoiAnalysisPop();
	});
	
	//저장 클릭시
    $('#roiAnalysisPopSaveBtn').on('click', function(){
    	roiAnalysisPopSaveBtn();
    });
	
    //draft 클릭시
    $('#roiAnalysisPopDraftBtn').on('click', function(){
    	roiAnalysisPopSaveBtn();
    });
    
    //ROI Return 정보 입력시 금액 계산 
    $("#tb_beforeMarketing input").on('change', function(){
        setRoiReturnCalculation();
        setROI();
    });
    
    //ROI Return 정보 입력시 금액 계산
    $("#tb_afterMarketing input").on('change', function(){
        setRoiReturnCalculation();
        setROI();
    });
    
    //Cost 변경시 ROI 계산 및 Total 계산
    $("#gridIdroiAnalysisCostGrid").on('change', function(){
        setROI();
        setCostTotalAmt();
    });
    
    $(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
	$('.title_tooltip').hover(function(){
        // Hover over code
        var title = $(this).attr('title');
        $(this).data('tipText', title).removeAttr('title');
        $('<p class="tooltip"></p>')
        .text(title)
        .appendTo('body')
        .fadeIn('slow');
	}, function() {
	        // Hover out code
	        $(this).attr('title', $(this).data('tipText'));
	        $('.tooltip').remove();
	}).mousemove(function(e) {
	        var mousex = e.pageX + 20; //Get X coordinates
	        var mousey = e.pageY + 10; //Get Y coordinates
	        $('.tooltip')
	        .css({ top: mousey, left: mousex });
	});
  
});
</script>

<script id="responseTypeCodeTemplate" type="text/x-jquery-tmpl">
    <option id="${'${'}codeId}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="costTotalTemplate" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="grid_con">
			{grid}
			
		</div>
        <table class="grid_total">
			<tr>
				<td>Total</td>
				<td class="total_td input_pd_right" style="width:66px;" id="costTotalAmt"></td>
			</tr>
		</table>
	</div>
</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal">
        <div>
			<div class="temp_title">
				<spring:message code="M00913"/>
			</div>
			<table class="table_wrap" id="tb_beforeMarketing" ><!-- 마케팅 활동 전 -->
				<thead>
					<tr>
					    <td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00865"/></td>
					    <td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00866"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00755"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00867"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00868"/></td>
						<td colspan="3" class="total_td table_border_bottom"><spring:message code="M00869"/></td>
					</tr>
					<tr>
						<td class="table_border_bottom"><spring:message code="M00870"/></td>
						<td class="total_td table_border_bottom"><spring:message code="M00871"/></td>
						<td class="total_td table_border_bottom"><spring:message code="M00872"/></td>
					</tr>
				</thead>
				<tbody>
					<tr id="BFR_T" rowId=""><!-- 대상군 -->
						<td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg text-right"><spring:message code="M00936"/></td>
						<td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
						<td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
						<td  class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="responseCustCount" /></td>
						<td class="total_td table_border_bottom td_bg" id="responseRate"></td>
						<td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="totalResponseAmt" /></td>
						<td class="total_td table_border_bottom td_bg text-right" id="priceAll"></td>
						<td class="total_td table_border_bottom td_bg text-right" id="priceResponse"></td>
					</tr>
					<tr id="BFR_C" rowId=""><!-- 비교군 -->
						<td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg text-right"><spring:message code="M00846"/></td>
						<td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
                        <td  class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="responseCustCount" /></td>
                        <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="totalResponseAmt" /></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceAll"></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceResponse"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="multi_description">
			<div class="temp_title">
				<spring:message code="M00914"/>
			</div>
			<table class="table_wrap" id="tb_afterMarketing"><!-- 마케팅 활동 후 -->
				<thead>
					<tr>
						<td rowspan="2" class="table_border_bottom"><spring:message code="M00864"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00865"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00866"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00755"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00867"/></td>
						<td rowspan="2" class="total_td table_border_bottom"><spring:message code="M00868"/></td>
						<td colspan="3" class="total_td table_border_bottom"><spring:message code="M00869"/></td>
					</tr>
					<tr>
						<td class="table_border_bottom"><spring:message code="M00870"/></td>
						<td class="total_td table_border_bottom"><spring:message code="M00871"/></td>
						<td class="total_td table_border_bottom"><spring:message code="M00872"/></td>
					</tr>
				</thead>
				<tbody>
					<tr id="AFTP_T" rowId=""><!-- 예측/대상군 -->
						<td id="campaignDataDivCodeName" class="table_border_bottom td_bg"><spring:message code="M00922"/></td>
						<td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg"><spring:message code="M00936"/></td>
						<td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
						<td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
						<td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="responseCustCount" /></td>
						<td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="totalResponseAmt" /></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceAll"></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceResponse"></td>
					</tr>
					<tr id="AFTR_T" rowId=""><!-- 실제/대상군 -->
						<td id="campaignDataDivCodeName" class="table_border_bottom td_bg"><spring:message code="M00923"/></td>
                        <td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg"><spring:message code="M00936"/></td>
                        <td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="responseCustCount" /></td>
                        <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="totalResponseAmt" /></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceAll"></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceResponse"></td>
					</tr>
					<tr id="AFTR_C" rowId=""><!-- 실제/비교군 -->
						<td id="campaignDataDivCodeName" class="table_border_bottom td_bg"><spring:message code="M00923"/></td>
                        <td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg"><spring:message code="M00846"/></td>
                        <td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="responseCustCount" /></td>
                        <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                        <td class="total_td table_border_bottom"><ifvm:input type="number" className="text-right" id="totalResponseAmt" /></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceAll"></td>
                        <td class="total_td table_border_bottom td_bg text-right" id="priceResponse"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="row multi_description">
			<div class="col-xs-5">
				<div class="temp_title">
					<spring:message code="M00915"/>
					<div class="pop_top_btn">
						<button class="btn_pop_white" id="roiCostGridAddBtn">
					        <img src="<ifvm:image name='btn_plus'/>" alt="" />
					        <spring:message code="M00935"/>
					    </button> 
					    <button class="btn_pop_white" id="roiCostGridRemoveBtn">
					        <img src="<ifvm:image name='btn_delete'/>" alt="" />
					        <spring:message code="M00275"/>
					    </button> 
					</div>
				</div>
				<div id="roiAnalysisCostGrid" class="roiAnalysis_grid"></div>
			</div>
			<div class="col-xs-7 pd_left_23">
				<div class="temp_title">
					<spring:message code="M00916"/>
				</div>
				<table class="table_wrap">
					<thead>
						<tr>
							<td class="total_td table_border_bottom"><spring:message code="M00864"/></td>
							<td class="total_td table_border_bottom"><spring:message code="M00921"/></td>
							<td class="total_td table_border_bottom title_tooltip" title='<spring:message code="M00928"/>'><spring:message code="M00928"/></td>
							<td class="total_td table_border_bottom title_tooltip" title='<spring:message code="M00929"/>'><spring:message code="M00929"/></td>
							<td class="total_td table_border_bottom title_tooltip" title='<spring:message code="M00931"/>'><spring:message code="M00930"/></td>
							<td class="total_td table_border_bottom title_tooltip" title='<spring:message code="M00932"/>'><spring:message code="M00932"/></td>
							<td class="total_td table_border_bottom title_tooltip" title='<spring:message code="M00933"/>'><spring:message code="M00934"/></td>
						</tr>
					</thead>
					<tbody>
						<!-- 예측 -->
						<tr id="roi_p_1">
							<td class="total_td table_border_bottom" rowspan="4"><spring:message code="M00922"/></td>
							<td class="total_td table_border_bottom text-left"><spring:message code="M00924"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_1_1"></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_1_2"></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_1_3"></td>
							<td class="total_td table_border_bottom td_bg" id="roi_p_1_4"></td>
							<td class="total_td table_border_bottom td_bg" id="roi_p_1_5"></td>
						</tr>
						<tr id="roi_p_2">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00925"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_2_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_2_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_2_3"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_2_4"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_2_5"></td>
						</tr>
						<tr id="roi_p_3">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00926"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_3_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_3_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_3_3"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_p_3_4"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_p_3_5"></td>
						</tr>
						<tr id="roi_p_4">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00927"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_p_4_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_4_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_p_4_3"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_p_4_4"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_p_4_5"></td>
						</tr>
						<!-- 실제 -->
						<tr id="roi_r_1">
							<td class="total_td table_border_bottom" rowspan="4"><spring:message code="M00923"/></td>
							<td class="total_td table_border_bottom text-left"><spring:message code="M00924"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_r_1_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_1_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_1_3"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_1_4"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_1_5"></td>
						</tr>
						<tr id="roi_r_2">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00925"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_r_2_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_2_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_2_3"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_2_4"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_2_5"></td>
						</tr>
						<tr id="roi_r_3">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00926"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_r_3_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_3_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_3_3"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_3_4"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_3_5"></td>
						</tr>
						<tr id="roi_r_4">
							<td class="total_td table_border_bottom text-left"><spring:message code="M00927"/></td>
							<td class="total_td table_border_bottom text-right" id="roi_r_4_1"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_4_2"></td>
                            <td class="total_td table_border_bottom text-right" id="roi_r_4_3"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_4_4"></td>
                            <td class="total_td table_border_bottom td_bg" id="roi_r_4_5"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	
	</div>
	<div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="roiAnalysisPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button> 
        <%-- <button class="btn btn-sm btn_gray" id="roiAnalysisPopDraftBtn">
            <spring:message code="M00775"/>
        </button>  --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="roiAnalysisCloseBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
<div id="costDescPop"></div>
