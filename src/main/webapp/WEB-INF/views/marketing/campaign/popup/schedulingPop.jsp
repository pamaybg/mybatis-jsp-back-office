<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
    .radio_padding_left {
        margin-left: 15px;
    }

    #selectMonthArea {
        display: none;
    }

    .scheduling_left .control-label.label_txt, .scheduling_right .control-label.label_txt {
        text-align: left;
    }

    .scheduling_left {
        width: 65%;
        display: inline-block;
        float: left
    }

    .scheduling_right {
        width: 35%;
        display: inline-block;
        float: left
    }

    .scheduling_right .grid_scroll3 .ui-jqgrid .ui-jqgrid-bdiv {
        max-height: 1000px;
    }

    .scheduling_guide_head {
        height: 56px;
    }

    .scheduling_guide_body {
        padding: 0px 10px;
    }

    .scheduling_right span.error_txt {
        color: #9b9b9b;
    }

    .scheduling_right .ifv_simple_pager > ul {
        padding-top: 34px;
    }

</style>

<script>
    var schedulingType = "ONCE";

    //grid
    var campaignRunListGrid;
    var gridIdcampaignRunListGrid;

    // var contsSendableTimeGrid;
    var gridIdcontsSendableTimeGrid;

    //tab
    var schedulingRunTab;

    //model
    var campaignExecutionInfo;
    var executionInfoItemList;
    var targetTotalCount = 0;
    var targetSendCount = 0;
    var targetRestCount = 0;
    var tgtGroupId;

    var schedulingPopData = {
        campaignType: ''
    };

    //validation
    var schedulingRunOnceValidation;
    var schedulingRunRepeatValidation;
    var schedulingRunLaterValidation;
    var campaignTypeCodeCheck;

    var campaignExecPermitStartTimeHour =null;
    var campaignExecPermitEndTimeHour = null;
    var campaignExecPermitStartTimeMinute =null;
    var campaignExecPermitEndTimeMinute = null;

    //혜택 목록
    function campaignRunList() {
        var jqGridOption = {
            loadComplete: function (obj) {
                initPopupHeight();
            },
            serializeGridData: function (data) {
            },
            data: executionInfoItemList,
            datatype: 'clientSide',
            colNames: [
                '<spring:message code="M00889"/>',
                '<spring:message code="M00877"/>',
                '<spring:message code="M00881"/>',
                '<spring:message code="M00891"/>',
                '<spring:message code="M00883"/>'
            ],
            colModel: [
                {name: 'exeSeq', index: 'exeSeq', width: "60", resizable: false, align: "center", sorttype: 'int'},
                {name: 'exeDate', index: '', width: "150", resizable: true, align: "center"},
                {name: 'exeTargetAmt', index: '', width: "100", resizable: false, align: "center", formatter: 'integer'},
                {name: 'exeInfoStatusCodeName', width: "50", index: '', resizable: false, align: "center"},
                {name: 'exeInfoDesc', index: '', resizable: false}
            ],
            sortname: 'exeSeq',
            sortorder: "asc",
            rowList: [10, 25, 50, 100],
            multiselect: true,
            tempId: 'ifvGridSimplePageTemplete',
        };
        campaignRunListGrid = $("#campaignRunListGrid").ifvGrid({jqGridOption: jqGridOption});
        gridIdcampaignRunListGrid = $("#gridIdcampaignRunListGrid");
    }

    /**
     * 캠페인 시작일시, 종료일시 조회
     */
    function getCampaignDate() {

        //캠페인 정보
        var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");

        //캠페인 기간 출력
        $('#camTerm').text(campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignStartDate + ' ~ ' + campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignEndDate);
    }

    /**
     * 채널별 발송 가능 시간 출력
     */
    function contsSendableTimeGrid() {
        // var chnlCheckList = diagram._nodes;
        // var chnlTypeData = null;
        //
        // chnlCheckList.forEach(function(chnlData){
        //     if(chnlData.addInfo.paletteTypeCode == 'CHANNEL'){
        //         chnlTypeData = chnlData.addInfo.taskType;
        //     }
        // })

        $.ifvSyncPostJSON('<ifvm:action name="getSchedulingPermitTime"/>', {},
            function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    $('#camTime').text(result.campaignExecPermitStartTime + ' ~ ' + result.campaignExecPermitEndTime);
                    campaignExecPermitStartTimeHour = result.campaignExecPermitStartTime.split(":")[0];
                    campaignExecPermitStartTimeMinute = result.campaignExecPermitStartTime.split(":")[1];
                    campaignExecPermitEndTimeHour = result.campaignExecPermitEndTime.split(":")[0]
                    campaignExecPermitEndTimeMinute = result.campaignExecPermitEndTime.split(":")[1];
                }
            });
//     var jqGridOption = {
//         loadComplete : function(obj) {
//             initPopupHeight();
//         },
//         serializeGridData : function(data) {
//             if(requestitem != null && requestitem.length > 0){
//                 data.item = requestitem;
//             }
//             data.workflowFlag = 'Y';
//             return data; 
//         },
//         url: '<ifvm:action name="getChannel"/>',
//         colNames:[
//             '<spring:message code="M00462"/>',
//             '<spring:message code="M02473"/>',
//             '<spring:message code="M02474"/>',
//         ],
//         colModel:[
//             {name:'chnlName',          index:'mc.chnl_nm',             resizable: false, align: 'left', },
//             {name:'sendableStartTime', index:'mc.sendable_start_time', resizable: false, align: 'center', width: '80px', formatter: schedulingTimeFormat },
//             {name:'sendableEndTime',   index:'mc.sendable_end_time',   resizable: false, align: 'center', width: '80px', formatter: schedulingTimeFormat },
//         ],
//         sortname: 'mc.chnl_nm',
//         sortorder: "desc",
//         rowList: [20],
//         tempId : 'ifvGridSimpleTemplete2'
//     };
//     contsSendableTimeGrid = $("#contsSendableTimeGrid").ifvGrid({ jqGridOption: jqGridOption });
//     gridIdcontsSendableTimeGrid = $("#gridIdcontsSendableTimeGrid");
    }

    /**
     * 시간 format
     */
    function schedulingTimeFormat(data) {
        var rtnData;
        if ($.fn.ifvmIsNotEmpty(data) && data.length == 6) {
            rtnData = data.substr(0, 2) + ':' + data.substr(2, 2) + ':' + data.substr(4, 2);
        } else {
            rtnData = data;
        }
        return rtnData;
    }

    //dialog close
    function closeSchedulingPop(args) {
        cDialog._destroy();
    }

    //popup 높이 맞추기
    function initPopupHeight() {
        setTimeout(function () {
            new ifvm.PopupHeight({
                popupDivId: 'dialog',
                contentsId: 'dialogPopupWrap'
            });
            cDialog.refresh();
        }, 300);
    }

    function targetCount() {

        var splitTargetTotCount = targetTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        //전체 타겟 대상자
        $("#targetTotalCount").val(splitTargetTotCount);

        //계획 완료 대상자
        targetSendCount = 0;
        $.each(executionInfoItemList, function (index, data) {
            targetSendCount += Number(data.exeTargetAmt);
        });

        //잔여
        targetRestCount = Number(targetTotalCount) - Number(targetSendCount);
        var totResetCount = targetRestCount - getExeTargetAmt()
        var totSendCount = targetSendCount + getExeTargetAmt()

        $("#targetRestCount").val(totResetCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

        //계획 완료 대상자
        $("#targetSendCount").val(totSendCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function getInitExtTime(kind) {
        if (kind == 'D') {
            var exeDay = [];
            for (var i = 1; i <= 31; i++) {
                exeDay.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
            }
            return exeDay;
        } else if (kind == 'H') {
            var hour = [];
            for (var i = 1; i <= 24; i++) {
                hour.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
            }
            return hour;
        } else if (kind == 'M') {

            var minute = [];
            for (var i = 0; i < 6; i++) {
                minute.push({code: $.fn.ifvmStr_pad(i * 10, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i * 10, 2, '0', "LEFT")});
            }
            return minute;
        }
    }

    //대상자 count
    function schedulingPopInit() {

        pageSetUp();

        cDialog.model.title = '<spring:message code="M00874"/>';
        $("#dialog_title").append('<spring:message code="M00874"/>');
        cDialog.model.width = "1000";
        cDialog.model.close = "closeSchedulingPop";

        // 탭 설정
        initTab();
    }

    //캠페인/대상자 먼저 등록 되어야 한다.
    //고객수(대상자) 추출
    function getTargetTotalCount(campaignTypeCode) {
        var campaignId = campaign.id;

        //타겟 캠페인
        if (campaignTypeCode == "TARGET" || campaignTypeCode == "MULTISTAGE" || campaignTypeCode == "REGULAR") {
            if ($.fn.ifvmIsNotEmpty(campaignId)) {
                $.ifvSyncPostJSON('<ifvm:action name="getCampaignTargetTotalCount"/>', {
                        campaignId: campaignId
                    },
                    function (result) {
                        if ($.fn.ifvmIsNotEmpty(result)) {
                            //대상자 수
                            if ($.fn.ifvmIsNotEmpty(result)) {
                                targetTotalCount = Math.ceil(Number(result.finalCount));
                                tgtGroupId = result.tgtGroupId;
                            } else {
                                targetTotalCount = 0;
                            }
                        }
                    });
            }
        }
        //Mass 캠페인
        else if (campaignTypeCode == "MASS") {
            $.ifvSyncPostJSON('<ifvm:action name="getMassCampaignTargetCount"/>', {
                    id: campaignId
                },
                function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        //대상자 수
                        if ($.fn.ifvmIsNotEmpty(result)) {
                            targetTotalCount = Math.ceil(Number(result));
                        } else {
                            targetTotalCount = 0;
                        }
                    }
                });
        }
    }

    function schedulingPopInitData() {

        $.ifvProgressControl(true);

        //node data 추출
        //캠페일 실행정보
        campaignExecutionInfo = {};
        executionInfoItemList = [];

        //캠페인 기본정보와 연결이 되어있는지 확인
        var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
        if (isNotEmpty(campaignInfo)) {
            //캠페인 ID
            campaign.id = campaignInfo[0].addInfo.actualTaskId;
        } else {
            alert('<spring:message code="C00148"/>');
            //close popup
            closeSchedulingPop();
            return false;
        }

        var campaignId = diagram._selectedObject.actualTaskId;

        //call 캠페인 실행정보 조회
        $.ifvSyncPostJSON('<ifvm:action name="getCampaignExecutionInfo"/>', {
                campaignId: campaignId
            },
            function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    campaignExecutionInfo = result;
                    executionInfoItemList = result.executionInfoItemList;
                }

                //캠페인 실행 목록
                campaignRunList();

            });

        //유형설정
        diagram._selectedObject.taskType = "SCHEDULE";

        //tab disabled 설정
        var campaignTypeCode = campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignTypeCode;
        campaignTypeCodeCheck = campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignTypeCode;

        setTimeout(function () {

            //정기 캠페인
            if (campaignTypeCode == "REGULAR") {
                schedulingRunTab.disabledTab([0, 2]);
                schedulingRunTab.moveTabIndex(1);
            }
            //타겟 캠페인
            else if (campaignTypeCode == "TARGET" || campaignTypeCode == "MASS") {
                schedulingRunTab.disabledTab([1, 2]);
                schedulingRunTab.moveTabIndex(0);
            }
            //멀티 캠페인
            else if (campaignTypeCode == "MULTISTAGE") {
                schedulingRunTab.disabledTab([1, 2]);
                schedulingRunTab.moveTabIndex(0);
            }
            //그 외
            else {
                schedulingRunTab.disabledTab([0, 1, 2]);
                setPopupFormAllDisabled("dialog");
            }

            //현재 탭 reload
            // schedulingRunTab.reloadCurrentTab();

            //캠페인 기간 확인
            checkPeriodCampaign(null, null, "A");

            //고객수 추출
            getTargetTotalCount(campaignTypeCode);
            $.ifvProgressControl(false);
        }, 2000);
    }

    //실행일시 반환
    function getDateJoin(dd, hh, mm) {
        var date = dd + " " + hh + ":" + mm;
        return date;
    }

    //대상자수 반환
    function getExeTargetAmt() {
        var result = 0;
        //비율
        if ($("#schedulingRunOnce #exeTargetUnit").val() == "R") {
            if (Number($("#schedulingRunOnce #exeTargetAmt").val() | '0') == 100) {
                result = targetRestCount;
            } else {
                result = (targetRestCount / 100) * Number($("#schedulingRunOnce #exeTargetAmt").val() | '0');
                result = Math.floor(result)
            }
        }
        //건수
        else {
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
        $.each(executionInfoItemList, function (index) {
            this.exeSeq = index + 1;
        });
    }

    //삭제
    function schedulingRemoveBtn() {
        var _chkLen = campaignRunListGrid.getCheckedGridData().length;
        var delCnt = 0;
        if (_chkLen >= 0) {
            var _chkDatas = campaignRunListGrid.getCheckedGridData();
            for (var i = 0; i < _chkDatas.length; i++) {
                for (var j = (executionInfoItemList.length - 1); j >= 0; j--) {
                    var data = executionInfoItemList[j];
                    if ((data.exeSeq == _chkDatas[i].exeSeq) && data.exeInfoStatusCode == 'W') {
                        executionInfoItemList.splice(j, 1);
                        delCnt++;
                        break;
                    }
                }
            }
        }
        if (delCnt == 0) {
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
            popupDivId: 'dialog',
            contentsId: 'dialogPopupWrap'
        });

        campaignRunList();
    }

    //전체삭제
    function schedulingAllRemoveBtn() {

        if (confirm('<spring:message code="C00079"/>')) {
            executionInfoItemList = [];

            //target count
            targetCount();

            //그리드 데이터 clear 후 데이터 재설정
            gridIdcampaignRunListGrid.clearGridData();
            gridIdcampaignRunListGrid.setGridParam({data: executionInfoItemList}).trigger("reloadGrid");

            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId: 'dialog',
                contentsId: 'dialogPopupWrap'
            });
        }

        campaignRunList();
    }

    //저장
    function schedulingPopSaveBtn() {
        var checkDate = false;
        var prTime = new Date($.ifvGetTodayDate());
        var neTime = new Date($.ifvGetTodayDate());
        var exDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체

        var PermitStartTime = '';
        var PermitEndTime = '';

        $.ifvSyncPostJSON('<ifvm:action name="getSchedulingPermitTime"/>', {},
            function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    PermitStartTime = result.campaignExecPermitStartTime;
                    PermitEndTime = result.campaignExecPermitEndTime;
                }
            });

        var permitSplitStartTime = PermitStartTime.split(':');
        var permitSplitEndTime = PermitEndTime.split(':');

        prTime.setHours(permitSplitStartTime[0], permitSplitStartTime[1], permitSplitStartTime[2], 0);
        neTime.setHours(permitSplitEndTime[0], permitSplitEndTime[1], permitSplitEndTime[2], 0);
        var edDateSplit = $('#exeTime').val().split(':');

        exDate.setHours(edDateSplit[0], edDateSplit[1], 0, 0);

        if(prTime.getTime() <= exDate.getTime() && exDate.getTime() <= neTime.getTime())
            checkDate = true;

        if (checkDate == true) {

            var rowData = gridIdcampaignRunListGrid.getRowData();

            $.ifvProgressControl(true);

            addFormData();

            if ($.fn.ifvmIsEmpty(rowData) && campaignTypeCodeCheck == 'TARGET') {
                alert("실행일자 및 대상자를 등록하셔야 됩니다.");
                $.ifvProgressControl(false);
            } else {
                //gridIdcampaignRunListGrid 의 0번 컬럼이 없으면 등록 불가

                campaignExecutionInfo.executionInfoItemList = executionInfoItemList;
                //campaignExecutionInfo.camContsChnlRelId =     //콘텐츠 채널 rel ID
                campaignExecutionInfo.dataStatus = getTaskStatusCode(campaignExecutionInfo);
                campaignExecutionInfo.campaignId = campaign.id;
                campaignExecutionInfo.type = schedulingType;    //일정 유형

                diagram._selectedObject.data.campaignExecutionInfo = campaignExecutionInfo;
                diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignExecutionInfo);

// 			if(checkDate == true){

                //call 예산 및 자원 정보 저장
                $.ifvPostJSON('<ifvm:action name="saveCampaignExecutionInfo"/>',
                    campaignExecutionInfo,
                    function (result) {
                        //set actual task ID
                        diagram._selectedObject.actualTaskId = campaign.id;

                        //set campaign ID
                        diagram._selectedObject.campaignId = campaign.id;

                        //set old campaign ID
                        diagram._selectedObject.oldCampaignId = campaign.id;

                        //save workflow
                        saveWorkflow();

                        //close popup
                        closeSchedulingPop();

                        $.ifvProgressControl(false);
                    });
            }
        } else {
            alert('<spring:message code="M03025"/>');
        }
    }

    //캠페인 기간 확인
    function checkPeriodCampaign(exeStartDate, exeEndDate, type) {
        var rtnValue = true;

        //캠페인 정보
        var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
        if ((isNotEmpty(campaignInfo) && type != 'A') ||
            (isNotEmpty(campaignInfo) && type == 'A' && executionInfoItemList.length > 0)) {

            //캠페인 시작일
            var campaignStartDate = campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignStartDate;
            var campaignEndDate = campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignEndDate;

            var firstDate = "";  //실행정보 첫번째 실행일자
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
                firstDate = executionInfoItemList[executionInfoItemList.length - 1].exeDate;
                lastDate = executionInfoItemList[0].exeDate;
            }
            if (campaignStartDate.length <= 10) campaignStartDate = campaignStartDate + ' 00:00';
            if (campaignEndDate.length <= 10) campaignEndDate = campaignEndDate + ' 23:59';
            if (firstDate.length <= 10) firstDate = firstDate + ' 00:00';
            if (lastDate.length <= 10) lastDate = lastDate + ' 23:59';

            //캠페인 기간 이전인지 확인
            if (campaignStartDate > firstDate || campaignEndDate < lastDate) {
                if (type == "A") {
                    alert("<spring:message code='M02392'/> (" + campaignStartDate + "~" + campaignEndDate + ")");
                } else {
                    if (!confirm("<spring:message code='M02392'/> <spring:message code='M02393'/> (" + campaignStartDate + "~" + campaignEndDate + ")")) rtnValue = false;
                }
            }
        }

        return rtnValue;
    }

    function strToDate(strDate) {
        var a = strDate.split(" ");
        var d = a[0].split("-");
        var t = ['00', '00', '00'];
        if ($.fn.ifvmIsNotEmpty(a[1])) {
            t = a[1].split(":");
            if (t.length == 2) {
                t[2] = '00'
            }
        }
        var date = new Date(d[0], (d[1] - 1), d[2], t[0], t[1], t[2]);
        return date.getTime();
    }

    $(function () {

        schedulingPopInit();
        schedulingPopInitData();

        //캠페인 기간
        getCampaignDate();

        //채널별 발송가능 시간 출력
        contsSendableTimeGrid();

        //삭제 클릭시
        $('#schedulingRemoveBtn').on('click', function () {
            schedulingRemoveBtn();
        });

        //전체삭제 클릭시
        $('#schedulingAllRemoveBtn').on('click', function () {
            schedulingAllRemoveBtn();
        });

        //저장 클릭시
        $('#schedulingPopSaveBtn').on('click', function () {
            schedulingPopSaveBtn();
        });

        //draft 클릭시
        $('#schedulingPopDraftBtn').on('click', function () {
            schedulingPopSaveBtn();
        });

        //취소 클릭시
        $('#schedulingPopCancelBtn').on('click', function () {
            closeSchedulingPop();
        });

        $("#exeTargetAmt").keyup(function (event) {
            if ($("#exeTargetUnit").val() == 'R') { //비율
                if ($("#exeTargetAmt").val() > 100) {
                    $("#exeTargetAmt").val("100");
                }
            } else {
                if ($("#exeTargetAmt").val() > 2147483647) {
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
                {label: '<spring:message code="M00875"/>', href: '<ifvm:url name="schedulingRunOnce"/>'},
                {label: '<spring:message code="M00876"/>', href: '<ifvm:url name="schedulingRunRepeat"/>'},
                //{label: '<spring:message code="M02384"/>', href: '<ifvm:url name="schedulingRunLater"/>'},
            ]
        });

        $('#schedulingRunTabDiv .tab-list').css('width', '');
        $('#schedulingRunTabDiv .btn-open-tab').remove();
        $('#schedulingRunTabDiv .scroll-control').remove();
    }

</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}code}>${'${'}name}</option>




</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap form-horizontal">

        <div class="scheduling_left">
            <div id="schedulingRunTabDiv"></div>
            <div id="schedulingGridDiv" style="padding:20px 20px 0">
                <header class="temp_title_bb">
                    <spring:message code="M00888"/>
                    <div class="pop_top_btn">
                        <button class="btn-sm btn_pop_white" id="schedulingRemoveBtn" objCode="schedulingRemoveBtn_OBJ">
                            <img src="<ifvm:image name='btn_delete'/>" alt=""/>
                            <spring:message code="M00275"/>
                        </button>
                        <button class="btn-sm btn_pop_white" id="schedulingAllRemoveBtn" objCode="schedulingAllRemoveBtn_OBJ">
                            <img src="<ifvm:image name='btn_delete'/>" alt=""/>
                            <spring:message code="C00037"/><spring:message code="M00275"/>
                        </button>
                    </div>
                </header>
                <div id="campaignRunListGrid" class="con_size grid_scroll5"></div>
            </div>

            <%-- <header class="temp_title">
                <spring:message code="M00888"/>
                <button class="btn_pop_white" style="align-text:left;" id="schedulingRemoveBtn">
                    <img src="<ifvm:image name='btn_delete'/>" alt="" />
                    <spring:message code="M00275"/>
                </button>
                <button class="btn_pop_white" style="align-text:left;" id="schedulingAllRemoveBtn">
                    <img src="<ifvm:image name='btn_delete'/>" alt="" />
                    <spring:message code="C00037"/><spring:message code="M00275"/>
                </button>
            </header>
            <div id="campaignRunListGrid" class="con_size grid_scroll5"></div> --%>
        </div>

        <%-- 프로모션 시간 & 채널별 발송제한 시간 가이드 영역 --%>
        <div class="scheduling_right">
            <div class="scheduling_guide_head">&nbsp;</div>
            <div class="scheduling_guide_body">
                <div class="schedulingPopGetDateArea">
                    <div class="row form-horizontal">

                        <%-- 캠페인 기간 --%>
                        <header class="temp_title_bb"><spring:message code="M00969"/></header>
                        <div class="col-xs-12">
                            <div class="row qt_border">
                                <ifvm:input type="hidden" id="rulesetId"/>
                                <ifvm:input type="hidden" id="promStartDt"/>
                                <ifvm:input type="hidden" id="promEndDt"/>
                                <label class="col-xs-12 control-label label_txt" id="camTerm"></label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row form-horizontal">

                    <%-- 채널별 발송 가능 시간 --%>
                    <header class="temp_title_bb"><spring:message code="M02477"/></header>
                    <div class="col-xs-12 form-horizontal" style="padding-top:0px;">
                        <div class="row qt_border">
                            <label class="col-xs-12 control-label label_txt" id="camTime"></label>
                        </div>
                        <!--                             <div id="contsSendableTimeGrid" class="grid_scroll3" style="width: 287px"></div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="schedulingPopSaveBtn" objCode="schedulingPopSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <button class="btn btn-sm btn_lightGray2 cancel" id="schedulingPopCancelBtn" objCode="schedulingPopCancelBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
