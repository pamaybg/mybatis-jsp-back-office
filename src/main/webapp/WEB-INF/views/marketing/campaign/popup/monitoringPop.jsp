<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var monitoringResultGrid;
var monitoringPopData = {
    responseTypeCode: [],
    targetCustCount: 0,
    targetControlGroupCount: 0,
    campaignMonitoring: {},
    campaignROIReturnList: []
};

//dialog close
function closeMonitoringPop(args) {
    cDialog._destroy();
}

function monitoringPopInit() {
    cDialog.model.title = '<spring:message code="M00857"/>';
    $("#dialog_title").append('<spring:message code="M00857"/>');
    cDialog.model.width = "1024";
    cDialog.model.close = "closeMonitoringPop";
    
    //반응유형 select box
    getResponseTypeCode();
}

function monitoringPopInitData() {
    //실행결과 목록 그리드 설정
    getMonitoringResultList();
    
    //node data get/reset
    monitoringPopData.campaignMonitoring = {campaignROIReturnList: []};
    if ($.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignMonitoring) 
            && $.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignMonitoring.campaignROIReturnList)) {
        //ROI Return 정보 목록
        $.each(diagram._selectedObject.data.campaignMonitoring.campaignROIReturnList, function(index, data){
        	monitoringPopData.campaignMonitoring.campaignROIReturnList.push(data);
        });
    } else {
        diagram._selectedObject.data.campaignMonitoring = {campaignROIReturnList: [] };
    }
    
    //캠페인 ID
    campaign.id = diagram._selectedObject.actualTaskId;
    
    //call 모니터링 ROI Return 정보
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignMonitoringROI"/>', {
        campaignId: campaign.id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
        	monitoringPopData.campaignMonitoring = result;
        }
    });
    
    //유형설정
    //diagram._selectedObject.taskType = "MONITORING";
    
    //고객수(대상자) 추출
    getTargetCustCount();
    
    //ROI 실행결과 설정
    setRoiReturnList();
}

//실행결과 목록 그리드 설정
function getMonitoringResultList(){
    
    var jqGridOption = {
        onSelectRow : function (data) {
            
        },
        loadComplete : function (data) {
        	setResponseTypeAndTargetCount(data);
        },
        serializeGridData : function( data ){
            data.campaignId = campaign.id;
            
            return data;
        },
        url : '<ifvm:action name="getExecutionResultList"/>',
        colNames:[ '#',
                   '<spring:message code="M00859" />',
                   '<spring:message code="M00860" />',
                   '<spring:message code="M00595" />',
                   '<spring:message code="M00600" />',
                 ],
        colModel:[
            { name:'exeSeq', index:'eii.EXE_SEQ', resizable : false , width : 60, align : "center" },
            { name:'exeDate', index:'eii.EXE_DT', resizable : false, width : 150, align : "center" },
            { name:'exeTargetAmt', index:'eii.EXE_TGT_AMT', resizable : false, width : 100, align : 'right' },
            { name:'exeInfoStatusCodeName', index:'c2.MARK_NAME', resizable : false, width : 100, align : "center" },
            { name:'exeInfoDesc', index:'eii.EXE_INFO_DESC', resizable : false, width : 120 },
        ],
        sortname: 'eii.EXE_SEQ',
        sortorder: "desc",
        radio: true,
        tempId : 'totalTemplate',
        rowList : [3],
    };
    monitoringResultGrid = $("#monitoringResultGrid").ifvGrid({ jqGridOption : jqGridOption });
    
}

//반응유형 및 대상자수 Total 설정
function setResponseTypeAndTargetCount(data) {
    if ($.fn.ifvmIsNotEmpty(data)) {
        var width = 0;
        var totalTargetAmt = 0;
        
        //data 확인
        if ($.fn.ifvmIsNotEmpty(monitoringResultGrid.opt.data.rows)) {
        	//반응유형 및 대상자수 테이블 초기화
            $("#responseResultTb_colgroup").empty();
            $("#responseResultTb_thead_tr").empty();
            $("#responseResultTb_tfoot_tr").empty();
            $("#responseResultTb_tbody").empty();
        	
	        $.each(monitoringResultGrid.opt.data.rows, function(index, data) {
	            var idx = index;
	            var temp;
	            
	            //tbody tr 생성
	            var tr = "";
	            tr = "responseResultTb_tbody_tr_" + idx;
	            temp = '<tr id="' + tr +'" class="table_border_bottom"></tr>';
	            $("#responseResultTb_tbody").append(temp);
	            
	            //반응유형 및 대상자수 td 생성
	            if ($.fn.ifvmIsNotEmpty(data.exeResponseCountList)) {
	                $.each(data.exeResponseCountList, function(index, res) {
	                    if (idx == 0) {
	                    	
	                    	//table colgroup 생성
	                    	temp = "<col class='total_td'>";
	                    	$("#responseResultTb_colgroup").append(temp);
	                    	
	                        //thead td 생성
	                        temp = "<td>" + res.responseName + "</td>";
	                        $("#responseResultTb_thead_tr").append(temp);
	                        
	                        //tfoot td 생성
	                        temp = "<td id='responseResultTb_tfoot_td_" + index + "' >0</td>";
	                        $("#responseResultTb_tfoot_tr").append(temp);
	                        
	                        //thead title td colspan
	                        $("#responseResultTb_title").attr("colspan", index+1);
	                        
	                        //table width
	                        width += 100;
	                    }
	                    
	                    //tbody td 생성
	                    temp = "<td>" + res.responseCount + "</td>";
	                    $("#" + tr).append(temp);
	                    
	                    //total count
	                    var thisCount = Number(res.responseCount);
	                    var totalCount = Number($("#responseResultTb_tfoot_td_" + index).text());
	                    $("#responseResultTb_tfoot_td_" + index).text(thisCount + totalCount);
	                });
	                
	                //table width 설정
	                $("#responseResultTb").css("width", width + "px");
	                
	            } else {
	            	
	            	temp = "<td>&nbsp;</td>";
	            	if (idx == 0) {
	            		//table colgroup 생성
	                    var tmp = "<col class='total_td'>";
	                    $("#responseResultTb_colgroup").append(tmp);
	            		
		            	//thead td 생성
		            	$("#responseResultTb_thead_tr").append(temp);
		            	
		            	//tfoot td 생성
		            	$("#responseResultTb_tfoot_tr").append(temp);
		            	
		            	//table width 설정
		                $("#responseResultTb").css("width", "100%");
	            	}
	            	
	            	//tbody td 생성
	                $("#" + tr).append(temp);
	            }
	            
	            //Total
	            totalTargetAmt += Number(data.exeTargetAmt);
	            $("#totalTargetAmt").text(totalTargetAmt);
	        });
        }
    }
}

//반응 유형
function getResponseTypeCode() {
    //input Select 공통코드 option 생성
    $.ifvSyncPostJSON('/system/commcode/getCommCondLIst.do',{
        groupCode : "MKT_ROI_RSPNS_TYPE"
        , enableNA : true
    },function(result) {    
        if ($.fn.ifvmIsNotEmpty(result.rows)) {
            monitoringPopData.responseTypeCode = result.rows;
        }
    });
    
    //select bosx 설정
    var rowDiv = ["AFTP_T", "AFTR_T", "AFTR_C"];
    $.each(rowDiv, function(index,data) {
        var temp = $("#responseTypeCodeTemplate").tmpl(monitoringPopData.responseTypeCode);
        $("#" + data + " #responseTypeCode").append(temp);
    });
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
                		monitoringPopData.targetCustCount = Math.ceil(Number(result.finalCount));
                        monitoringPopData.targetControlGroupCount = Math.ceil(Number(result.controlGroupCount));
                	} else {
                		monitoringPopData.targetCustCount = Number(result.finalCount);
                        monitoringPopData.targetControlGroupCount = Number(result.controlGroupCount);
                	} 
                } else {
                	    monitoringPopData.targetCustCount = 0;
                	if(window.lang == "ko") {
                		monitoringPopData.targetControlGroupCount = Math.ceil(Number(result.controlGroupCount));
                	} else {
                		monitoringPopData.targetControlGroupCount = Number(result.controlGroupCount);
                	}
                }
            }
        });
    }
    
    
}

//ROI 실행결과 설정
function setRoiReturnList() {
    $.each(monitoringPopData.campaignMonitoring.campaignROIReturnList, function(index, data){
        var rowDiv = data.campaignDataDivCode + "_" + data.targetBaseGroupCode;
        if ($("#" + rowDiv)) {
            $("#" + rowDiv).attr("rowid", data.id);
            //대상군
            if (data.campaignDataDivCode != "BFR") {
                $("#" + rowDiv + " #campaignDataDivCodeName").text(data.campaignDataDivCodeName.substr(-2));
            }
            $("#" + rowDiv + " #targetBaseGroupCodeName").text(data.targetBaseGroupCodeName);
            $("#" + rowDiv + " #targetCustCount").text(targetCustCount);
            $("#" + rowDiv + " #responseTypeCode").val(data.responseTypeCode);
            $("#" + rowDiv + " #responseCustCount").val(Number(data.responseCustCount));
            $("#" + rowDiv + " #totalResponseAmt").val(data.totalResponseAmt);
            
            if(window.lang == "ko") {
            	$("#" + rowDiv + " #totalResponseAmt").val(Number(data.totalResponseAmt).toFixed(0));
        	} 
        }
    });
    
    //ROI 실행결과 계산  
    setRoiReturnCalculation();
}

//ROI 실행결과 계산 
function setRoiReturnCalculation() {
    var rowDiv = ["AFTP_T", "AFTR_T", "AFTR_C"];
    $.each(rowDiv, function(index,data) {
        var custCount = 0;
        
        if (data.match("_T")) {
            //대상군
            custCount = Number(monitoringPopData.targetCustCount);
        } else {
            //비교군
            custCount = Number(monitoringPopData.targetControlGroupCount);
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

//ROI Return 정보 추출
function getRoiReturnList() {
    var campaignROIReturnList = [];
    var rowDiv = ["AFTP_T", "AFTR_T", "AFTR_C"];
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

//저장
function monitoringSaveBtn() {
	monitoringPopData.campaignMonitoring.campaignROIReturnList = getRoiReturnList();
	monitoringPopData.campaignMonitoring.dataStatus = getTaskStatusCode(monitoringPopData.campaignMonitoring);
	monitoringPopData.campaignMonitoring.campaignId = campaign.id;
	
    diagram._selectedObject.data.campaignMonitoring = monitoringPopData.campaignMonitoring;
    diagram._selectedObject.taskDataStatus = getTaskStatusCode(monitoringPopData.campaignMonitoring);
    
    //call 모니터링 저장
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignMonitoringROI"/>', 
    		monitoringPopData.campaignMonitoring,
    function(result) {
      	//save workflow
        saveWorkflow();
    	
    	//close popup
    	closeMonitoringPop();
    });
}

$(function () {
    monitoringPopInit();
    monitoringPopInitData();
    
    //저장 클릭시
    $('#monitoringSaveBtn').on('click', function(){
        monitoringSaveBtn();
    });
    
    //draft 클릭시
    $('#monitoringDraftBtn').on('click', function(){
        monitoringSaveBtn();
    });
    
    //취소 클릭시
    $('#monitoringCancelBtn').on('click', function(){
        closeMonitoringPop();
    });
    
    //ROI 실행결과 입력시 금액 계산
    $("#tb_afterMarketing input").on('change', function(){
        setRoiReturnCalculation();
    });
    
    $("#gridIdmonitoringResultGrid tbody").on('ready', '', function(){
        setResponseTypeAndTargetCount();
    });
    
});
</script>

<script id="totalTemplate" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}

        <div class="filter_area">
            <div class="left">
                {searchBox}
            </div>
        </div>
    
        <div class="grid_con">
            {grid}
            <table class="grid_total">
                <tr>
                    <td>Total</td>
                    <td class="total_td" style="width:102px; text-align:right; padding-right: 5px;" id="totalTargetAmt"></td>
                    <td class="total_td" style="width:101px;"></td>
                    <td class="total_td" style="width:121px;"></td>
                </tr>
            </table>
        </div>
        <div class="page">
            {page}
            <div class="total_area">{total}</div>   
        <div>
    </div>
</script>

<script id="responseTypeCodeTemplate" type="text/x-jquery-tmpl">
    <option id="${'${'}codeId}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap form-horizontal">
        <div class="temp_title_bb monitoring_title">
            <spring:message code="M00858"/>
        </div>
        <div id="monitoringResultGrid" class="monitoring_grid"></div>
        <div class="monitoring_table_wrap">
            <table class="table_wrap monitoring_table" id="responseResultTb"><!-- data 추가시 table width 변경 -->
                <colgroup id="responseResultTb_colgroup"><!-- col tag 추가 -->
                    <col class="total_td">
                </colgroup>
                <thead>
                    <tr>
                        <td id="responseResultTb_title" colspan="1" class="total_td table_border_bottom"><spring:message code="M00873"/></td><!-- colspan 변경 -->
                    </tr>
                    <tr class="table_border_bottom" id="responseResultTb_thead_tr">
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tfoot class="grid_total">
                    <tr id="responseResultTb_tfoot_tr" class="table_border_bottom">
                       <td>&nbsp;</td>
                    </tr>
                </tfoot>
                <tbody id="responseResultTb_tbody">
                    <tr id="responseResultTb_tfoot_tr" class="table_border_bottom">
                        <td>&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="temp_title roi_title">
            <spring:message code="M00863"/>
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
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="responseCustCount" /></td>
                    <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="totalResponseAmt" /></td>
                    <td class="total_td table_border_bottom td_bg" id="priceAll"></td>
                    <td class="total_td table_border_bottom td_bg" id="priceResponse"></td>
                </tr>
                <tr id="AFTR_T" rowId=""><!-- 실제/대상군 -->
                    <td id="campaignDataDivCodeName" class="table_border_bottom td_bg"><spring:message code="M00923"/></td>
                    <td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg"><spring:message code="M00936"/></td>
                    <td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="responseCustCount" /></td>
                    <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="totalResponseAmt" /></td>
                    <td class="total_td table_border_bottom td_bg" id="priceAll"></td>
                    <td class="total_td table_border_bottom td_bg" id="priceResponse"></td>
                </tr>
                <tr id="AFTR_C" rowId=""><!-- 실제/비교군 -->
                    <td id="campaignDataDivCodeName" class="table_border_bottom td_bg"><spring:message code="M00923"/></td>
                    <td id="targetBaseGroupCodeName" class="total_td table_border_bottom td_bg"><spring:message code="M00846"/></td>
                    <td id="targetCustCount" class="total_td table_border_bottom td_bg text-right"></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="select" id="responseTypeCode" /></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="responseCustCount" /></td>
                    <td class="total_td table_border_bottom td_bg" id="responseRate"></td>
                    <td class="total_td table_border_bottom"><ifvm:input type="text" className="text-right" id="totalResponseAmt" /></td>
                    <td class="total_td table_border_bottom td_bg" id="priceAll"></td>
                    <td class="total_td table_border_bottom td_bg" id="priceResponse"></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="monitoringSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button> 
        <%-- <button class="btn btn-sm btn_gray" id="monitoringDraftBtn">
            <spring:message code="M00775"/>
        </button>  --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="monitoringCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>