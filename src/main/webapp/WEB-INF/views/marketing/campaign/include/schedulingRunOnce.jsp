<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
    .campaign_group_bg {
        background-color: #fff;
    }
</style>
<script>

    /**
     * 달력
     */
    function setChannelCalendar() {
        var exeDdDate = $('#schedulingRunOnce #exeDd');

        //캠페인 정보
        var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");

        if (isNotEmpty(campaignInfo)) {
            exeDdDate.val(campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignStartDate);
        } else {
            exeDdDate.val($.ifvGetTodayDate());
        }
        exeDdDate.ifvDateChecker({});

        $('#exeTime').timepicker({
            showMeridian: false,
            defaultTime: '00:00',
            showSeconds: false,
            minuteStep: 5,
            secondStep: 1,
        });
    }

    /**
     * 한번 실행 input reset
     */
    function resetSchedulingRunOnceDiv() {

        $("#schedulingRunOnce #exeDd").val('');
        $("#schedulingRunOnce #exeTargetUnit").val('C');
        $("#schedulingRunOnce #exeTargetAmt").val('');
        $("#schedulingRunOnce #exeInfoDesc").val('');

        //$("#schedulingRunOnce #exeTime").val('00:00');

        // 달력 설정
        setChannelCalendar();

        //target count
        targetCount();
    }

    /**
     * 한번 실행 등록
     */
    function schedulingRunOnceAdd() {
        var checkDate = false;
        var prTime = new Date($.ifvGetTodayDate());
        var neTime = new Date($.ifvGetTodayDate());
        var exDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체
        var targetLeft = parseInt($('#targetRestCount').val().replace(/,/, ''));

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

        if (targetLeft > 0) {
            /*$('#exeTargetAmt').val(targetLeft);*/

        } else {
            alert("잔여 대상자가 부족합니다.");
            return false;
        }

        if (checkDate == true) {
            var exeHour = $('#exeTime').val().split(':', 2)[0];
            var exeMinute = $('#exeTime').val().split(':', 2)[1];

            //실행일자
            var exeDate = getDateJoin($("#schedulingRunOnce #exeDd").val(), exeHour, exeMinute);
            var isValid = schedulingRunOnceValidation.confirm();

            //캠페인 기간 확인 & check validation
            if (isValid && checkPeriodCampaign(exeDate, null, "O")) {

                //소수점값  내림 설정
                var digits = Math.pow(10, 0);
                var num = Math.floor(getExeTargetAmt() * digits) / digits;
                var exeTargetAmt = num;

                //분할옵션
                var optionYN = $('input[name=exeDdOption]:checked').val();

                //사용함.
                if (optionYN == 'Y') {
                    var exeDt = new Date(exeDate);
                    var splitUnit = $('#splitUnit').val();
                    var splitValue = splitUnit == 'hour' ? $('#splitValue').val()*60 : $('#splitValue').val();

                    var _total = $("#targetTotalCount").val();

                    // 숫자 표현방식인 ,추가로 인해 버그발생으로 인한 수정
                    _total = _total.replaceAll(',', '');
                    _total = Number(_total);

                    var _send = 0;
                    $.each(executionInfoItemList, function (index, data) {
                        _send += Number(data.exeTargetAmt);
                    });
                    var _rest = Number(_total) - Number(_send);

                    for (var i = 0; ; i++) {
                        if(_rest < exeTargetAmt) exeTargetAmt = _rest;
                        _rest = _rest - exeTargetAmt;

                        exeDate = exeDt.format("yyyy-mm-dd HH:MM");

                        var data = {
                            exeSeq: executionInfoItemList.length + 1,
                            exeDate: exeDate,
                            exeTargetAmt: exeTargetAmt,
                            exeInfoDesc: $("#schedulingRunOnce #exeInfoDesc").val(),
                            exeInfoStatusCode: "W", //상태: 작업중
                            exeInfoStatusCodeName: '<spring:message code="M00910"/>'
                        };

                        executionInfoItemList.push(data);

                        if (_rest <= 0) {
                            break;
                        }
                        var exeDtTemp = new Date(exeDt);
                        var exeDtTempAdd = new Date(exeDt);
                        exeDtTempAdd.setMinutes(exeDtTemp.getMinutes() + Number(splitValue));
                        var tempAddHH24MM = exeDtTempAdd.getHours().toString() + (exeDtTempAdd.getMinutes() > 9 ? exeDtTempAdd.getMinutes().toString() : '0' + exeDtTempAdd.getMinutes().toString());
                        if(Number(campaignExecPermitStartTimeHour + campaignExecPermitStartTimeMinute) <= Number(tempAddHH24MM) && Number(tempAddHH24MM) <= Number(campaignExecPermitEndTimeHour + campaignExecPermitEndTimeMinute)) {
                            exeDt.setMinutes(Number(exeDt.getMinutes()) + Number(splitValue));
                        } else {
                            executionInfoItemList = [];
                            alert('캠페인 발송 가능 시간은 '+campaignExecPermitStartTimeHour+':'+campaignExecPermitStartTimeMinute+' ~ '+campaignExecPermitEndTimeHour+':'+campaignExecPermitEndTimeMinute+'까지 입니다. 발송시간을 확인해주세요.');
                            return false;
                        }

                    }
                }
                //사용안함
                else {
                    //exeTargetAmt == targetLeft
                    var data = {
                        exeSeq: executionInfoItemList.length + 1,
                        exeDate: exeDate,
                        exeTargetAmt: targetLeft,
                        exeInfoDesc: $("#schedulingRunOnce #exeInfoDesc").val(),
                        exeInfoStatusCode: "W", //상태: 작업중
                        exeInfoStatusCodeName: '<spring:message code="M00910"/>'
                    };

                    executionInfoItemList.push(data);
                }

                //차수 설정
                setSchedulingRunSeq();

                //input 값들 초기화
                resetSchedulingRunOnceDiv();

                //그리드 데이터 clear 후 데이터 재설정
                gridIdcampaignRunListGrid.clearGridData();
                gridIdcampaignRunListGrid.setGridParam({data: executionInfoItemList}).trigger("reloadGrid");

                //popup 높이 맞추기
                cDialog.refresh();

                campaignRunList();
            }
        } else {
            alert('<spring:message code="M03025"/>');
        }
    }

    /**
     * 화면 설정
     */
    function initSchedulingRunOnce() {

        schedulingType = "ONCE";

        //target count
        targetCount();

        //발송단위
        $.fn.ifvmSetSelectOptionCommCode("exeTargetUnit", "MKT_CNTRL_GRP_UOM");
        $("#exeTargetUnit").val("C");

        //분할시간단위
        var splitUnitArry = [
            {code: 'hour', name: '시간'},
            {code: 'minute', name: '분'},
        ];
        var temp = $("#CommonListTemp").tmpl(splitUnitArry);
        $("#schedulingRunOnce #splitUnit").html(temp);

        // 달력 설정
        setChannelCalendar();

        //본사&매장 체크
        setTimeout(function(){
            //context menu 생성
            empTypeChk();
        }, 100);



        //validation
        schedulingRunOnceValidation = $("#schedulingRunOnce").ifvValidation();

    }

    /**
     * 분할옵션 사용여부 선택시 화면 설정
     */
    function setSplitOption() {

        var optionYN = $('input[name=exeDdOption]:checked').val();

        if ($.fn.ifvmIsEmpty(optionYN)) {
            $('input[name=exeDdOption][value=N]').prop('checked', true);
            optionYN = 'N';
        }

        //사용함
        if (optionYN == 'Y') {
            $('#optionSplitTimeDiv').show();
            $('#optionSplitTimeDiv').find('input').attr('required', true);
            $('#optionSplitTimeDiv').find('select').attr('required', true);

        }
        //사용안함
        else {
            $('#optionSplitTimeDiv').hide();
            $('#optionSplitTimeDiv').find('input').removeAttr('required');
            $('#optionSplitTimeDiv').find('select').removeAttr('required');
        }

        // validation 재 설정
        schedulingRunOnceValidation = $("#schedulingRunOnce").ifvValidation();
    }

    function empTypeChk(){
        if(empType != 'H'){
            $('#exeDdOptionArea').hide();
        }
    }

    function addFormData() {

    }

    $(document).ready(function () {

        initSchedulingRunOnce();

        //대상수 계산
        $("#schedulingRunOnce #exeTargetAmt").on('change', function () {
            targetCount();
        });

        var addBtnClickCnt = 0;

        //한번 실행-등록 버튼
        $('#schedulingRunOnceAddBtn').unbind("click");
        $('#schedulingRunOnceAddBtn').on('click', function () {
            schedulingRunOnceAdd();
        });

        //분할옵션 사용여부
        $('input[name=exeDdOption]').on('click', function () {
            setSplitOption();
        });

        setSplitOption();

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

        $("#splitValue").onlyNumber();

        //팝업 높이 맞추기
        initPopupHeight();
    });


</script>

<div id="schedulingRunOnce" class="schedulingPopConditionArea">
    <header class="temp_title_bb">
        <spring:message code="M00908"/>
        <button class="btn_pop_white pop_top_btn" id="schedulingRunOnceAddBtn">
            <img src="<ifvm:image name='ico_input'/>" alt=""/>
            <spring:message code="M00767"/>
        </button>
    </header>
    <div class="row form-horizontal">
        <div class="col-xs-6">

            <!-- 실행일자 -->
            <div class="row half_bottom">
                <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00877"/></label>
                <div class="col-xs-9">
                    <ifvm:input type="date" required="true" id="exeDd"/>
                </div>
            </div>

            <!-- 분할옵션 -->
            <div class="row half_bottom" id="exeDdOptionArea">
                <label class="col-xs-3 control-label"><spring:message code="M02468"/></label>
                <div class="col-xs-9 control_content">
                    <label class="radio-inline">
                        <ifvm:input type="radio" names="exeDdOption" values="Y"/>
                        <spring:message code="M02418"/>
                    </label>
                    <label class="radio-inline">
                        <ifvm:input type="radio" names="exeDdOption" values="N"/>
                        <spring:message code="M02419"/>
                    </label>
                </div>
            </div>

            <%-- 분할옵션 선택시 활성영역 --%>
            <div id="optionSplitTimeDiv">
                <div class="row half_bottom">
                    <label class="col-xs-2 control-label">&nbsp;</label>

                    <%-- 분할 시간 단위 --%>
                    <label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02466"/></label>
                    <div class="col-xs-6">
                        <ifvm:input type="select" id="splitUnit"/>
                    </div>
                </div>
                <div class="row half_bottom">

                    <label class="col-xs-2 control-label">&nbsp;</label>

                    <%-- 분할 시간 값 --%>
                    <label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02467"/></label>
                    <div class="col-xs-6">
                        <ifvm:input type="number" id="splitValue"/>
                    </div>
                </div>

                <!-- 발송단위 -->
                <div class="row half_bottom">
                    <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00880"/></label>
                    <div class="col-xs-9">
                        <ifvm:input type="select" id="exeTargetUnit" names="exeTargetUnit"/>
                    </div>
                </div>

                <!-- 대상자수 -->
                <div class="row half_bottom">
                    <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00881"/></label>
                    <div class="col-xs-7">
                        <ifvm:input type="number" required="true" valiItem="number" id="exeTargetAmt"/>
                    </div>
                    <div class="col-xs-2 control-label">
                        <spring:message code="M00882"/>
                    </div>
                </div>

            </div>

        </div>
        <div class="col-xs-6">
            <div class="row half_bottom">

                <%-- 실행일자의 시간 --%>
                <div class="col-xs-6 control_content" style="padding:0px">
                    <ifvm:inputNew type="time" id="exeTime"/>
                </div>
            </div>
            <div class="campaign_group_bg">

                <%-- 전체티켓 대상자 --%>
                <div class="row half_bottom">
                    <label class="col-xs-6 control-label"><spring:message code="M00884"/></label>
                    <div class="col-xs-5">
                        <ifvm:input type="text" disabled="true" className="text-right subjectColor" id="targetTotalCount"/>
                    </div>
                    <div class="col-xs-1 control-label">
                        <spring:message code="M00887"/>
                    </div>
                </div>

                <%-- 계획완료 대상자 --%>
                <div class="row half_bottom">
                    <label class="col-xs-6 control-label"><spring:message code="M00885"/></label>
                    <div class="col-xs-5">
                        <ifvm:input type="text" disabled="true" className="text-right subjectColor" id="targetSendCount"/>
                    </div>
                    <div class="col-xs-1 control-label">
                        <spring:message code="M00887"/>
                    </div>
                </div>

                <%-- 잔여 --%>
                <div class="row half_bottom">
                    <label class="col-xs-6 control-label"><spring:message code="M00886"/></label>
                    <div class="col-xs-5">
                        <ifvm:input type="text" disabled="true" className="text-right" id="targetRestCount"/>
                    </div>
                    <div class="col-xs-1 control-label">
                        <spring:message code="M00887"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
