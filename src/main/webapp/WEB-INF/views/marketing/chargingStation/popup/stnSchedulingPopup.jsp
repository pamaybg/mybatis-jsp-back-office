<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.radio_padding_left {margin-left:15px;}
#selectMonthArea {display:none;}
.scheduling_left .control-label.label_txt,.scheduling_right .control-label.label_txt {text-align: left;}

.scheduling_left  {width: 65%; display: inline-block; float: left}
.scheduling_right {width: 35%; display: inline-block; float: left}
.scheduling_right .grid_scroll3 .ui-jqgrid .ui-jqgrid-bdiv {max-height: 200px;}
.scheduling_guide_head {height: 28px; background-color: #e3dede;}
.scheduling_guide_body {padding: 0px 10px;}
.scheduling_right span.error_txt {color: #9b9b9b;}

</style>

<script>

//grid
var campaignRunListGrid;
var gridIdcampaignRunListGrid;

var contsSendableTimeGrid;
var gridIdcontsSendableTimeGrid;

//tab
var schedulingRunTab;

//model
var campaignExecutionInfo;
var executionInfoItemList;
var targetTotalCount = 0;
var targetSendCount = 0;
var targetRestCount = 0;

var schedulingPopData = {
	campaignType: ''
};

//validation
var schedulingRunOnceValidation;
var schedulingRunRepeatValidation;
var schedulingRunLaterValidation;

//혜택 목록
function campaignRunList() {
    var jqGridOption = {
 		loadComplete : function(obj) {
 		},
	    serializeGridData : function(data) {
	    },
	    data: executionInfoItemList,
	    datatype: 'clientSide',
	    colNames:[
	               '<spring:message code="M00889"/>',
	               '<spring:message code="M00877"/>',
	               '<spring:message code="M00881"/>',
	               '<spring:message code="M00891"/>',
	               '<spring:message code="M00883"/>'
	             ],
	    colModel:[
            { name:'exeSeq', index:'exeSeq', width : "60", resizable : false, align: "center",sorttype:'int'},
	        { name:'exeDate', index:'', width : "150", resizable : true, align: "center"},
	        { name:'exeTargetAmt', index:'', width : "100",  resizable : false, align: "center"},
	        { name:'exeInfoStatusCodeName', width : "50",  index:'', resizable : false, align: "center"},
	        { name:'exeInfoDesc', index:'', resizable : false}
	    ],
	    sortname: 'exeSeq',
        sortorder: "asc",
	    rowList : [100000],
	    multiselect: true,
        tempId : 'ifvGridSimpleTemplete',
	};
    campaignRunListGrid = $("#campaignRunListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdcampaignRunListGrid = $("#gridIdcampaignRunListGrid");
}

/**
 * 프로모션 시작일시, 종료일시 조회
 */
function getPromotionDate() {
//     $.ifvSyncPostJSON('<ifvm:action name="getCampaignPromotonDate"/>', {
//         camId: campaign.id
//     },
//     function(result) {
//         if ($.fn.ifvmIsNotEmpty(result)) {
//             //프로모션 등록정보가 있음.
//             if ($.fn.ifvmIsNotEmpty(result.rulesetId)) {
//                 $('#promTerm').text(result.promStartDt + ' ~ ' + result.promEndDt);
//             }
//             //프로모션 등록정보가 없음
//             else {
//                 $('#promTerm').html('<span class="error_txt"><spring:message code="M02475"/></span>');
//             }
//         }
//     });

    //캠페인 정보
//     var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    
    //캠페인 기간 출력
    $('#promTerm').text($("#camStDate").val() + ' ~ ' + $("#camEdDate").val());
}

/**
 * 채널별 발송 가능 시간 출력
 */
function contsSendableTimeGrid() {
    
    var jqGridOption = {
        loadComplete : function(obj) {
        	
        },
//         serializeGridData : function(data) {
//             if(requestitem != null && requestitem.length > 0){
//                 data.item = requestitem;
//             }
//             return data;
//         },
        url: '<ifvm:action name="getChannel"/>',
        colNames:[
            '<spring:message code="M00462"/>',
            '<spring:message code="M02473"/>',
            '<spring:message code="M02474"/>',
        ],
        colModel:[
            {name:'chnlName',          index:'mc.chnl_nm',             resizable: false, align: 'left', },
            {name:'sendableStartTime', index:'mc.sendable_start_time', resizable: false, align: 'center', width: '80px', formatter: schedulingTimeFormat },
            {name:'sendableEndTime',   index:'mc.sendable_end_time',   resizable: false, align: 'center', width: '80px', formatter: schedulingTimeFormat },
        ],
        sortname: 'mc.chnl_nm',
        sortorder: "desc",
        rowList: [100000],
        tempId: 'ifvGridSimpleTemplete',
    };
    contsSendableTimeGrid = $("#contsSendableTimeGrid").ifvGrid({ jqGridOption: jqGridOption });
    gridIdcontsSendableTimeGrid = $("#gridIdcontsSendableTimeGrid");
}

/**
 * 시간 format
 */
function schedulingTimeFormat(data) {
    var rtnData;
    if ($.fn.ifvmIsNotEmpty(data) && data.length == 6) {
        rtnData = data.substr(0, 2) + ':' + data.substr(2, 2) + ':' + data.substr(4, 2); 
    }
    else {
        rtnData = data;
    }
    return rtnData;
}

function targetCount() {
    
	//전체 타겟 대상자
    $("#targetTotalCount").val(targetTotalCount);
	
	//계획 완료 대상자
	targetSendCount = 0;
	$.each(executionInfoItemList, function(index, data) {
		targetSendCount += Number(data.exeTargetAmt);
	});
	
	//잔여
	targetRestCount = Number(targetTotalCount) - Number(targetSendCount);
    $("#targetRestCount").val(targetRestCount - getExeTargetAmt());
    
    //계획 완료 대상자
    $("#targetSendCount").val(targetSendCount + getExeTargetAmt());
}

function getInitExtTime(kind) {
    if (kind == 'D') {
        var exeDay = [];
        for (var i=1; i <= 31; i++ ) {
            exeDay.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
        }
        return exeDay; 
    }
    else if (kind == 'H') {
        var hour = [];
        for (var i=1; i <= 24; i++ ) {
            hour.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
        }
        return hour ;
    }
    else if (kind == 'M') {

        var minute = [];
        for (var i=0; i < 6; i++ ) {
            minute.push({code: $.fn.ifvmStr_pad(i*10, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i*10, 2, '0', "LEFT")});
        }
        return minute ;
    }
}

//캠페인/대상자 먼저 등록 되어야 한다.
//고객수(대상자) 추출
function getTargetTotalCount() {
    var campaignId = camId;
    if ($.fn.ifvmIsNotEmpty(campaignId)) {
        $.ifvSyncPostJSON('<ifvm:action name="getCampaignTargetTotalCount"/>', {
            campaignId: campaignId
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                //대상자 수
                if ($.fn.ifvmIsNotEmpty(result)) {
                	targetTotalCount = Math.ceil(Number(result.finalCount));
                }
                else {
                	targetTotalCount = 0;
                }
            }
        });
    }
}

function schedulingPopInitData() {
    
	//node data 추출
	//캠페일 실행정보
    campaignExecutionInfo = {};
    executionInfoItemList = [];
    
    var campaignId = camId;
    
    if(campaignId == null || campaignId == "" || campaignId == "null") {
    	alert('<spring:message code="C00147"/>');
    	schedulingPopupClose();
    	return true;
    }
    
    //call 캠페인 실행정보 조회
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignExecutionInfo"/>', {
        campaignId: campaignId
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
        	campaignExecutionInfo = result;
        	executionInfoItemList = result.executionInfoItemList;
        }
        
        if(camStatusCd != 'W' 
			&& (camStatusCd == 'A' //활성
				|| camStatusCd == 'I' //비활성
				|| camStatusCd == 'S' //중지
				|| camStatusCd == 'C' //취소
				|| camStatusCd == 'E' //완료
				|| camStatusCd == '010' //결재진행중
				|| camStatusCd == '090' //승인완료 
				|| camStatusCd == '091')) {
        	$("#schedulingPopSaveBtn").off('click');
        	$("#schedulingPopSaveBtn").hide();
        	
//         	$("#schedulingPopSaveBtn").on('click', function() {
//         		alert("결재진행중이거나 결재완료된 캠페인은 수정할 수 없습니다.");
//         		return 0;
//         	});
        }
    });
    
    //고객수 추출
    getTargetTotalCount();
    
    //유형설정
//     diagram._selectedObject.taskType = "SCHEDULE";
	
	//캠페인 실행 목록
	campaignRunList();
	
    schedulingRunTab.moveTabIndex(0);
//     schedulingRunTab.disabledTab([1,2]);
}

//실행일시 반환
function getDateJoin(dd, hh, mm) {
	var date = dd + " " + hh + ":" + mm;
	return date;
}

//대상자수 반환
function getExeTargetAmt() {
	var result = 0;
	if ($("#schedulingRunOnce #exeTargetUnit").val() == "R") {
		result = (targetRestCount / 100) * Number($("#schedulingRunOnce #exeTargetAmt").val() | '0');
	} else {
		result = Number($("#schedulingRunOnce #exeTargetAmt").val());
	}
	
	return result;
}

//차수 설정
function setSchedulingRunSeq() {
    
    //실행일자순 정렬
    executionInfoItemList.sort(function (a, b) { 
    	return a.exeDate < b.exeDate ? -1 : a.exeDate > b.exeDate ? 1 : 0;  
    });
    
    //차수 설정
	$.each(executionInfoItemList, function(index) {
		this.exeSeq = index + 1;
	});
}

//삭제
function schedulingRemoveBtn() {
    
    var _chkLen = campaignRunListGrid.getCheckedGridData().length;
    var delCnt = 0;
    if (_chkLen >= 0) {
        var _chkIds = campaignRunListGrid.getCheckedRowIds();
        for (var i = (_chkLen - 1); i >= 0 ; i--) {
            for (var j = (executionInfoItemList.length - 1) ; j >= 0 ; j--) {
                var data = executionInfoItemList[j];
                if ((data.id == _chkIds[i] || data.exeSeq == _chkIds[i]) && data.exeInfoStatusCode == 'W') {
                    executionInfoItemList.splice(j, 1);
                    delCnt++;
                    break;
                }
            }
        }
    }
    if (delCnt == 0 ) {
        alert('<spring:message code="M00911"/>'); 
    }
    
    //target count
    targetCount();
    
    //차수 설정
    setSchedulingRunSeq();
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdcampaignRunListGrid.clearGridData();
    gridIdcampaignRunListGrid.setGridParam({data: executionInfoItemList}).trigger("reloadGrid");
    
    //popup 높이 맞추기
	new ifvm.PopupHeight({
		popupDivId : 'dialog',
		contentsId : 'dialogPopupWrap'
	});
}

//저장
function schedulingPopSaveBtn() {
    	
    campaignExecutionInfo.executionInfoItemList = executionInfoItemList;
    campaignExecutionInfo.camContsChnlRelId = "b15c3cd38ccf11e58f090200";    //콘텐츠 채널 rel ID
    campaignExecutionInfo.dataStatus = "I"; //기존 정보 모두 지우고 새로 insert
    campaignExecutionInfo.campaignId = camId;
    
//     diagram._selectedObject.data.campaignExecutionInfo = campaignExecutionInfo;
//     diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignExecutionInfo);
    
    //call 예산 및 자원 정보 저장
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignExecutionInfo"/>',
        campaignExecutionInfo,
    function(result) {
    	if(result.errorType == 0) {
    		alert('<spring:message code="I00741"/>');
    		$("#schedulingPopCancelBtn").trigger('click');
//     		$("#camApproBtn").trigger('click');
    	} else {
    		alert('<spring:message code="I00742"/>');
    	}
//     	//set actual task ID
//         diagram._selectedObject.actualTaskId = campaign.id;
    	
//         //set campaign ID
//         diagram._selectedObject.campaignId = campaign.id;
        
//         //set old campaign ID
//         diagram._selectedObject.oldCampaignId = campaign.id;
    	
//       	//save workflow
//         saveWorkflow();
    	
    	//close popup
//     	schedulingPopupClose();
    });
}

//캠페인 기간 확인
function checkPeriodCampaign(exeStartDate, exeEndDate, type) {
    var rtnValue = true;
    
    //캠페인 정보
//     var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    if ( (camId != null && camId != "" && camId != "null" && type != 'A') ||
            (camId != null && camId != "" && camId != "null" && type == 'A' && executionInfoItemList.length > 0) ) {
        
        //캠페인 시작일
        var campaignStartDate = $("#camStDate").val();
        var campaignEndDate = $("#camEdDate").val();
        
        var firstDate = "";	 //실행정보 첫번째 실행일자
        var lastDate = "";   //실행정보 마지막 실행일자
        
        //한번실행
        if (type == "O") {
            firstDate = exeStartDate;
            lastDate = exeStartDate;
        }
        //반복실행
        else if (type == "R") {
            firstDate = exeStartDate;
            lastDate = exeEndDate;
        }
        //기존확인
        else if (type == "A") {
            firstDate = executionInfoItemList[executionInfoItemList.length-1].exeDate;
            lastDate = executionInfoItemList[0].exeDate;
        }
        
        //캠페인 기간 이전인지 확인
        if (campaignStartDate > firstDate || campaignEndDate < lastDate) {
            if (type == "A") {
                alert("<spring:message code='M02392'/> (" + campaignStartDate + "~" + campaignEndDate + ")");
            }
            else {
                if(!confirm("<spring:message code='M02392'/> <spring:message code='M02393'/> (" + campaignStartDate + "~" + campaignEndDate + ")")) rtnValue = false;
            }
        }
    }
    
    return rtnValue;
}

$(function () {

	pageSetUp();

    // 탭 설정
    initTab();
    
	schedulingPopInitData();

    getPromotionDate();
    
    //채널별 발송가능 시간 출력
    contsSendableTimeGrid();
    
    //삭제 클릭시
    $('#schedulingRemoveBtn').on('click', function(){
    	schedulingRemoveBtn();
    });
    
    //저장 클릭시
    $('#schedulingPopSaveBtn').on('click', function(){
    	schedulingPopSaveBtn();
    });
    
    //draft 클릭시
    $('#schedulingPopDraftBtn').on('click', function(){
    	schedulingPopSaveBtn();
    });
       
    //취소 클릭시
    $('#schedulingPopCancelBtn').on('click', function(){
        schedulingPopupClose();
    });

	$("#exeTargetAmt").keyup(function (event) {
    	if($("#exeTargetUnit").val() == 'R') { //비율
    		if($("#exeTargetAmt").val() > 100) {
    			$("#exeTargetAmt").val("100");
    		}
    	} else {
    		if($("#exeTargetAmt").val() > 2147483647) {
    			$("#exeTargetAmt").val("2147483647");
    		}
    	}
	});
});

/**
 * 탭 설정
 */
function initTab() {
    
    schedulingRunTab = $('#schedulingRunTabDiv').DrawTab({
        item: [
            {label: '<spring:message code="M00875"/>', href: '<ifvm:url name="stnSchedulingRunOnce"/>'},
//             {label: '<spring:message code="M00876"/>', href: '<ifvm:url name="schedulingRunRepeat"/>'},
//             {label: '<spring:message code="M02384"/>', href: '<ifvm:url name="schedulingRunLater"/>'},
        ]
    });
    
    $('#schedulingRunTabDiv .tab-list').css('width', '');
}

</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}code}>${'${'}name}</option>
</script>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal">
        
        <div class="scheduling_left">
            <div id="schedulingRunTabDiv"></div>
            <header class="temp_title">
                <spring:message code="M00888"/>
                <button class="btn_pop_white pop_top_btn" id="schedulingRemoveBtn">
                    <img src="<ifvm:image name='btn_delete'/>" alt="" />
                    <spring:message code="M00275"/>
                </button>
            </header>
            <div id="campaignRunListGrid" class="con_size grid_scroll3"></div>
        </div>
        
        <%-- 프로모션 시간 & 채널별 발송제한 시간 가이드 영역 --%>
        <div class="scheduling_right">
        
            <div class="scheduling_guide_head">&nbsp;</div>
            <div class="scheduling_guide_body">
                <div class="row form-horizontal">
                    <header class="temp_title_bb"><spring:message code="M00969"/></header>
                    <div class="col-xs-12">
                        <div class="row qt_border">
                            <ifvm:input type="hidden" id="rulesetId" />
                            <ifvm:input type="hidden" id="promStartDt" />
                            <ifvm:input type="hidden" id="promEndDt" />
                            <label class="col-xs-12 control-label label_txt" id="promTerm"></label>
                        </div>
                    </div>
                </div>
                <div class="row form-horizontal">
                    <header class="temp_title"><spring:message code="M02477"/></header>
                    <div class="col-xs-12 form-horizontal">
                        <div id="contsSendableTimeGrid" class="grid_scroll3" style="width: 287px"></div>
                    </div>
                </div>
            </div>
        </div>
	</div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="schedulingPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2 cancel" id="schedulingPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
