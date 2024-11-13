<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/marketing/fullcalendar.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/marketing/fullcalendar.css" rel="stylesheet" type="text/css"/>


<script id="rowGridTemplete" type="text/ifvGrid-tmpl">
	<div class="body_row" id="${'${'}campaignId +','+ camTypeCodeName}" onclick="selectCell(id)">
		<table>
			<tbody>
				<tr>
					<td class="campaign_cell"><div>${'${'}title}</div></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
					<td class="month_cell"></td>
				</tr>
			</tbody>
		</table>
		<div class="data_tr" id="${'${'}campaignId}Data" title="${'${'}title}"
		style="width:${'${'}barWidth}px; right:${'${'}barRight}px; background-color: ${'${'}colorClass};
		{{if barWidth == 0}}
			display: none;
		{{/if}}">${'${'}campaignPeriod}</div>
	</div>

</script>

<script>

    var todayTemp = new Date();		//오늘날짜
    var calendarToday = new Date(); //년달력의 년도를 기억하고있는 변수
    var thisYear;					//달력에 설정되어있는 년도
    var campaignList = [];			//캠페인 유형에 따른 캠페인 리스트

    var monthFlag;

    //권한 관련
    var empId;
    var authType;
    var brandCd;
    var empType;


    //캠페인 유형 설정
    function campaignTypeSelect(select) {

        $.ifvSyncPostJSON('<ifvm:action name="getCampaignType"/>',
            {},
            function (result) {
                $(select).append($('<option/>').text('<spring:message code="M01083"/>').val(""));
                //
                $(result.rows).each(function (index, item) {
                    //console.log(item);
                    $(select).append($('<option/>').text(item.campaignTypeCodeName).val(item.campaignTypeCode));
                });
            });

        getCampaign();	//캠페인 설정


    }

    //캠페인 권한 얻기
    function campaignAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            authType = result.rows[0].authType;
            brandCd = result.rows[0].brandCd;
            empType = result.rows[0].empType;
        });
    }

    //캠페인 리스트 얻기
    function getCampaign() {
        //var row = new Array();
        campaignList = [];

        //캠페인 유형과 상태값에 따라 조회
        $.ifvSyncPostJSON('<ifvm:action name="getCampaignInCalendar"/>',
            {
                campaignTypeCode: $('#campaignType').val(),
                campaignStatusCode: $('#statusType').val(),
                thisYear: thisYear,
                targetMonth : $('#targetMonth').val(),
                camNm : $('#camNm').val(),
                brandCd : brandCd,
                empId : empId,
                authType : authType
            },

            function (result) {

                $('#yearCalendar_year').text(thisYear);

                $(result.rows).each(function (index, item) {

                    //DB에 00:00:00으로 들어가있는 날짜를 아래와 같이 추가해서 정상적인 달력 출력
                    var endDate = item.end.split(' ');
                    item.end = endDate[0] + " 23:59:59";
                    campaignList.push(item);
                });
            }
        );
    }


    //year달력 셀 선택 이벤트
    function selectCell(id) {

        var idData = id.split(",");	//캠페인 id  + , +  캠페인 유형명 (code_name)
        var camId = idData[0];		//캠페인 id
        var camTypeCodeName = idData[1];	//캠페인 유형명(code_name)
        $('.tooltip').remove();
        //퀵캠페인이면 퀵캠페인 화면으로
        if (camTypeCodeName == 'QUICK') {
            qtjs.href('<ifvm:url name="quickCampaign"/>?type=MKT&id=' + camId);

        } else if (camTypeCodeName == 'TRIGGER') {

            qtjs.href('<ifvm:url name="campaignRuleWorkFlow"/>?type=RUL&id=' + camId);

        }
        //퀵캠페인 아닌경우는 캠페인 워크플로우 화면으로.
        else {
            qtjs.href('<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=' + camId);
        }
    }

    function setMonthCalendar() {
        monthFlag = true;
        getCampaign();
        //월 캘린더 초기화
        $('#monthCalendar').fullCalendar('removeEvents');
        $('#monthCalendar').fullCalendar('addEventSource', campaignList);

        //월 캘린더 설정
        $('#monthCalendar').fullCalendar({
            header: {
                left: '',
                center: 'prev,title,next',		//왼쪽화살표  ,xxxx년도 ,오른쪽 화살표
                right: ''
            },
            defaultDate: new Date(),
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: campaignList,

            eventClick: function (event) {
                $('.tooltip').remove();

                //클릭시 처리부분
                if (event.camTypeCodeName == 'QUICK')	//퀵캠페인이면 퀵캠페인 화면으로
                {

                    qtjs.href('<ifvm:url name="quickCampaign"/>?type=MKT&id=' + event.campaignId);
                } else if (event.camTypeCodeName == 'TRIGGER') {

                    qtjs.href('<ifvm:url name="campaignRuleWorkFlow"/>?type=RUL&id=' + event.campaignId);

                }
                //퀵캠페인 아닌경우는 캠페인 워크플로우 화면으로.
                else {

                    qtjs.href('<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=' + event.campaignId);
                }
            },
            viewRender: function (view, element) {
                //월 이동시에 today 체크
                var b = $('#monthCalendar').fullCalendar('getDate');
                checkToday(b.format('L'));
            },
            eventMouseover: function () {
                var camType = "";
                var camStart = "";
                var camEnd = "";
                for (var i = 0; i < campaignList.length; i++) {
                    if (campaignList[i].campaignId == $(this).attr('campaignid')) {
                        camType = campaignList[i].campaignTypeCode;
                        camStart = campaignList[i].start.split(' ')[0];
                        camEnd = campaignList[i].end.split(' ')[0];
                        break;
                    }
                }

                var contents = '<spring:message code="L00419"/>' + " : " + camType + "<br>" + '<spring:message code="M00969"/>' + " : " + camStart + " ~ " + camEnd;


                $(this).data('tipText', contents).removeAttr('title');
                $(this).mouseover(function (e) {
                    $('<p class="tooltip"></p>')
                        .html(contents)
                        .appendTo('body')
                        .fadeIn('slow');
                }).mousemove(function (e) {
                    var mousex = e.pageX + 20; //Get X coordinates
                    var mousey = e.pageY + 10; //Get Y coordinates
                    $('.tooltip')
                        .css({top: mousey, left: mousex})
                });
            },
            eventMouseout: function () {
                $(this).attr('title', $(this).data('tipText'));
                $('.tooltip').remove();
            }
        });
    }


    function setYearCalendar() {

        monthFlag = false;
        $('#yearTable #yearData').empty();
        getCampaign();


        for (var i = 0; i < campaignList.length; i++) {
            //thisYear = $('#yearCalendar_year').text();
            var barWidth = 0;				//바의 길이
            var barRight = 0;				//오른쪽 여백의 길이
            var monthCellWidth = 83;		//월당 길이

            var rowHtml = '';
            var tempData = campaignList[i];
            var startDate = campaignList[i].start;
            var startYear = startDate.substr(0, 4);
            var startMonth = startDate.substr(5, 2);
            var startDay = startDate.substr(8, 2);
            var endDate = campaignList[i].end;
            var endYear = endDate.substr(0, 4);
            var endMonth = endDate.substr(5, 2);
            var endDay = endDate.substr(8, 2);


            //연달력 title 설정

            //시작년도와 달 , 끝년도와 달이 같으면  일자로만 표시
            if (startMonth == endMonth && startYear == endYear) {
                campaignList[i].campaignPeriod = startDay; /* + '~'+ endDay */
            }
            //시작 월/일 ~ 끝 월/일
            else {
                campaignList[i].campaignPeriod = startMonth + '/' + startDay + '~' + endMonth + '/' + endDay;
            }

            var camPeriodTemp = campaignList[i].campaignPeriod;


            if (startYear < thisYear && endYear > thisYear) {
                barWidth = monthCellWidth * 12;

            } else if (startYear < thisYear && endYear == thisYear) {
                barRight = (12 - endMonth) * monthCellWidth;
                barWidth = endMonth * monthCellWidth;
            } else if (startYear == thisYear && endYear > thisYear) {
                barWidth = (12 - startMonth + 1) * monthCellWidth;

            } else if (startYear == thisYear && endYear == thisYear) {
                barRight = (12 - endMonth) * monthCellWidth;
                barWidth = (endMonth - startMonth + 1) * monthCellWidth;
            }

            tempData.barWidth = barWidth;
            tempData.barRight = barRight;

            rowHtml = $("#rowGridTemplete").tmpl(tempData);
            $("#yearTable #yearData").append(rowHtml);

            campaignList[i].campaignPeriod = camPeriodTemp;

            //연 달력 툴팁 설정
            $('#' + tempData.campaignId + 'Data').hover(function () {
                // Hover over code
                var title = $(this).attr('title');
                var camType = "";
                var camStart = "";
                var camEnd = "";
                for (var i = 0; i < campaignList.length; i++) {
                    if (campaignList[i].campaignId == $(this).attr('id').split('Data')[0]) {
                        camType = campaignList[i].campaignTypeCode;
                        camStart = campaignList[i].start.split(' ')[0];
                        camEnd = campaignList[i].end.split(' ')[0];
                        break;
                    }
                }

                var contents = '<spring:message code="L00419"/>' + " : " + camType + "<br>" + '<spring:message code="M00969"/>' + " : " + camStart + " ~ " + camEnd;

                $(this).data('tipText', contents).removeAttr('title');
                $('<p class="tooltip"></p>')
                    .html(contents)
                    .appendTo('body')
                    .fadeIn('slow');
            }, function () {
                // Hover out code
                $(this).attr('title', $(this).data('tipText'));
                $('.tooltip').remove();
            }).mousemove(function (e) {
                var mousex = e.pageX + 20; //Get X coordinates
                var mousey = e.pageY + 10; //Get Y coordinates
                $('.tooltip')
                    .css({top: mousey, left: mousex})
            });

        }

        checkToday(calendarToday);
    }

    function checkToday(date) {

        if (monthFlag == true) {

            if (date.substr(0, 2) == (todayTemp.getMonth() + 1) && date.substr(6, 4) == todayTemp.getFullYear()) {
                $('#goToday').addClass('active');
            } else {
                $('#goToday').removeClass('active');
            }
        } else {
            if (date.getFullYear() == todayTemp.getFullYear()) {
                $('#goToday').addClass('active');
            } else {

                $('#goToday').removeClass('active');
            }
        }
    }

    function camNmSearchFun() {
        getCampaign();		//목록 업데이트

        if (monthFlag) {
            setMonthCalendar();
        } else {
            setYearCalendar();
        }
    }

    function targetTingDate() {
        getCampaign();		//목록 업데이트

        var rtnDate;
        if($('#targetYear').val() != null && $('#targetYear').val() != '') {
            calendarToday.setFullYear($('#targetYear').val());
            $('#yearCalendar_year').text($('#targetYear').val());
            thisYear = $('#yearCalendar_year').text();
        } else {
            calendarToday.setFullYear(calendarToday.getFullYear());
            $('#yearCalendar_year').text(calendarToday.getFullYear());
            thisYear = $('#yearCalendar_year').text();
        }

        if($('#targetMonth').val() != null && $('#targetMonth').val() != '') {
            rtnDate = new Date(thisYear + '-' + $('#targetMonth').val() + '-01');
        } else {
            var now = new Date();	// 현재 날짜 및 시간
            var month = now.getMonth()+1;	// 월
            rtnDate = new Date(thisYear + '-' + month + '-01');
        }

        if (monthFlag) {
            $('#monthCalendar').fullCalendar('gotoDate', rtnDate);
            var b = $('#monthCalendar').fullCalendar('getDate');
            checkToday(b.format('L'));
        } else {
            setYearCalendar();
        }
    }

    $(document).ready(function () {

        //캠페인 권한 불러오기
        campaignAuth();

        $('#camNm').attr("disabled", false);

        //캠페인 상태조회
        $.fn.ifvmSetSelectOptionCommCode("statusType", "MKT_CAM_STAT");
        $("#statusType").append("<option value='ALL'>전체</option>")
        $("#statusType").val("ALL");
        $('#statusType').children("[value='']").remove();	//첫번째 빈 Option 삭제
        //$('#statusType').val('A');

        $("#statusType").val("A").prop("selected", true);

        campaignTypeSelect('#campaignType');	//캠페인 유형 조회

        $('#yearCalendar_year').text(calendarToday.getFullYear());

        thisYear = $('#yearCalendar_year').text();

        $.fn.ifvmSetSelectOptionCommCode("targetYear", "SETTLE_YEAR");
        $.fn.ifvmSetSelectOptionCommCode("targetMonth", "SETTLE_MONTH");


        //초기화면은 월달력으로
        //$('#yearCalendar').hide();
        //setMonthCalendar();

        //초기화면은 년달력으로
        $('#monthCalendar').hide();
        setYearCalendar();
        $("#targetMonth").attr('disabled','disabled').show();

        var todayM = new Date();
        var yearM = todayM.getFullYear();
        $("#targetYear option[value="+yearM+"]").prop("selected", true);

        //오늘 날짜로 이동
        $('#goToday').on('click', function () {
            $("#targetMonth option:eq(0)").prop("selected", true);
            $("#targetYear option:eq(0)").prop("selected", true);
            $("#camNm").val(null);

            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth()+1;
            var monthFilter = (("00"+month.toString()).slice(-2));

            if (monthFlag == true) {
                $('#monthCalendar').fullCalendar('gotoDate', new Date());
                //calendarToday = new Date();
                var b = $('#monthCalendar').fullCalendar('getDate');
                checkToday(b.format('L'));
                $("#targetMonth option[value="+monthFilter+"]").prop("selected", true);
                $("#targetYear option[value="+year+"]").prop("selected", true);
            } else {
                calendarToday = new Date();
                /* 	$('#monthCalendar').fullCalendar('today'); */
                $('#yearCalendar_year').text(calendarToday.getFullYear());
                thisYear = $('#yearCalendar_year').text();
                setYearCalendar();
                $("#targetYear option[value="+year+"]").prop("selected", true);
            }

        });

        $('#goMonth').on('click', function () {
            $("#targetMonth option:eq(0)").prop("selected", true);
            $("#targetYear option:eq(0)").prop("selected", true);
            $("#camNm").val(null);
            $("#targetMonth").removeAttr('disabled').show();

            //$('#monthCalendar').fullCalendar('gotoDate', calendarToday);	//년달력의 날짜와 같게
            thisYear = null;
            $('#goYear').removeClass('active');

            $(this).addClass('active');


            $('#yearCalendar').hide();
            $('#monthCalendar').show();

            getCampaign();
            setMonthCalendar();

            $('#monthCalendar').fullCalendar('gotoDate', new Date());

            //년달력에서 월달력 이동시에 today체크
            var monDate = $('#monthCalendar').fullCalendar('getDate');
            checkToday(monDate.format('L'));

            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth()+1;
            var monthFilter = (("00"+month.toString()).slice(-2));

            $("#targetMonth option[value="+monthFilter+"]").prop("selected", true);
            $("#targetYear option[value="+year+"]").prop("selected", true);

        });

        $('#goYear').on('click', function () {
            $("#targetYear option:eq(0)").prop("selected", true);
            $("#targetMonth option:eq(0)").prop("selected", true);
            $("#camNm").val(null);
            $("#targetMonth").attr('disabled','disabled').show();

            $('#yearCalendar_year').text(new Date().getFullYear());
            thisYear = $('#yearCalendar_year').text();
            $('#goMonth').removeClass('active');
            $(this).addClass('active');

            setYearCalendar();
            $('#monthCalendar').hide();
            $('#yearCalendar').show();

            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth()+1;
            var monthFilter = (("00"+month.toString()).slice(-2));

            $("#targetYear option[value="+year+"]").prop("selected", true);
        });

        $('#yearPrev').on('click', function () {
            var prevDate = calendarToday.getFullYear() - 1;
            calendarToday.setFullYear(prevDate);	//년달력  year-1
            thisYear = $('#yearCalendar_year').text(calendarToday.getFullYear());
            thisYear = $('#yearCalendar_year').text();

            setYearCalendar();
        });

        $('#yearNext').on('click', function () {
            var nextDate = calendarToday.getFullYear() + 1;
            calendarToday.setFullYear(nextDate);	//년달력 year+1
            $('#yearCalendar_year').text(calendarToday.getFullYear());
            thisYear = $('#yearCalendar_year').text();

            setYearCalendar();
        });


        //캠페인 유형 변경 이벤트
        $('#campaignType').change(function () {
            getCampaign();		//목록 업데이트

            if (monthFlag) {
                setMonthCalendar();
            } else {
                setYearCalendar();
            }
        });
        //캠페인 상태 변경 이벤트
        $('#statusType').change(function () {
            getCampaign();		//목록 업데이트

            if (monthFlag) {
                setMonthCalendar();
            } else {
                setYearCalendar();
            }
        });

        $('#targetYear').change(function () {
            targetTingDate();
        });

        $('#targetMonth').change(function () {
            targetTingDate();
        });

    });
</script>
<style>

    .calendar_wrap {
        width: 100%;
        background-color: #fff;
        padding-top: 15px;
        position: relative;
    }

    .btn_wrap {
        position: absolute;
        top: 13px;
        right: 20px;
    }

    .calendar_wrap .btn_wrap button {
        width: 60px;
        height: 25px;
        border: 1px solid #dddddd;
        background-color: #ffffff;
        font-size: 12px;
        color: #323232;
        font-weight: bold;
        text-align: center;
    }

    .calendar_wrap .btn_wrap button#goToday {
        border-radius: 3px;
    }

    .calendar_wrap .btn_wrap button:hover {
        background-color: #f5f5f5;
    }

    .calendar_wrap .btn_wrap button.first_btn {
        border-top-left-radius: 3px;
        border-bottom-left-radius: 3px;
    }

    .calendar_wrap .btn_wrap button.last_btn {
        border-top-right-radius: 3px;
        border-bottom-right-radius: 3px;
    }

    .calendar_wrap .btn_wrap button.active, .calendar_wrap .btn_wrap button.active:hover {
        background-color: #6e7886;
        color: #fff;
        border: 1px solid #616975;
    }

    #monthCalendar {
        width: 100%;
        margin: 0 auto;
    }

    #yearCalendar {
        overflow-x: auto;
        overflow-y: hidden;
    }

    .fc-center {
        display: block;
        width: 180px;
        margin: 0 auto;
    }

    .fc-center button {
        float: left;
    }

    .fc-center h2 {
        float: left;
        margin: 0 15px;
        color: #323232;
        font-size: 18px;
        font-weight: bold;
        font-family: tahoma;
        line-height: 18px;
    }

    .fc-day-header {
        font-size: 11px;
        font-weight: bold;
        color: #787878;
    }

    .fc-day-number {
        font-size: 11px;
        font-weight: bold;
        color: #787878;
        font-family: tahoma;
    }

    .fc-day-number.fc-sun {
        color: #ed4015;
    }

    .fc-title {
        font-size: 11px;
        color: #fff;
    }

    .fc-right {
        display: none;
    }

    .fc-event {
        border-radius: 10px;
    }

    .table_wrap {
        min-width: 1122px;
        width: 100%;
        border-right: 0;
    }

    .table_wrap table {
        width: 100%;
        border-collapse: collapse;
    }

    .table_wrap table td {
        border-bottom: 1px solid #dddddd;
        border-right: 1px solid #dddddd;
        padding-left: 5px;
        color: #323232;
    }

    .table_wrap .head_row {
        height: 26px;
        text-align: center;
    }

    .table_wrap .head_row .campaign_cell {
        min-width: 126px;
        font-size: 11px;
        font-weight: bold;
        color: #fff;
        background-color: #b7b7b7;
    }

    .table_wrap .head_row .month_cell {
        width: 83px;
        font-size: 11px;
        font-weight: bold;
        color: #787878;
        background-color: #efefef;
    }

    .table_wrap .campaign_row {
        height: 32px;
        position: relative;
    }

    .body_row {
        width: 100%;
        height: 32px;
        position: relative;
    }

    .body_row table {
        width: 100%;
        height: 32px;
    }

    .body_row td.campaign_cell {
        text-align: left;
        padding: 0;
        padding-left: 10px;
        min-width: 126px;
        height: 32px;
        line-height: 32px;
    }

    .body_row td.campaign_cell div {
        width: 100%;
        height: 30px;
        overflow: hidden;
    }

    .body_row td.month_cell {
        width: 83px;
        height: 32px;
    }

    .data_tr {
        position: absolute;
        top: 6px;
        height: 20px;
        line-height: 20px;
        padding: 0 5px;
        color: #fff;
        font-size: 10px;
        font-weight: bold;
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        cursor: pointer;
        border-radius: 8px;
    }

    .tooltip {
        display: none;
        position: absolute;
        border: 1px solid #d8b422;
        background-color: #fffdd7;
        padding: 10px;
        color: #676767;
        font-size: 11px;
        opacity: 100;
        filter: alpha(opacity=100);
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
</style>

<div id="formArea">
    <div class="page-title">
        <h1>
            <spring:message code="M01057"/> &gt; <spring:message code="M01059"/>
        </h1>
    </div>
    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code="M01057"/></span>
            </div>
        </div>
        <div class="well mb0 form-horizontal">
            <div class="row">
                <label class="col-xs-1 control-label"><spring:message code="M01058"/></label>
                <div class="col-xs-5 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="campaignType"/>
                    </div>
                </div>

                <label class="col-xs-1 control-label"><spring:message code="M01082"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="statusType" names="statusType"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <ifvm:inputNew type="select" id="targetYear"  names="targetYear"  label="년" nuc="true" labelClass="1" conClass="2"/>
                <ifvm:inputNew type="select" id="targetMonth"  names="targetMonth"  label="월" nuc="true" labelClass="1" conClass="2"/>
                <ifvm:inputNew type="search" id="camNm" names="camNm" objCode="campaignListBtn_OBJ" dto="camNm" btnFunc="camNmSearchFun" label="캠페인명" labelClass="1" conClass="4"/>
            </div>
        </div>
        <div class="calendar_wrap">
            <div class="btn_wrap">
                <button type="button" id="goToday"><spring:message code="M01060"/></button>
                <button type="button" class="first_btn" id="goMonth"><spring:message code="M01061"/></button>
                <button type="button" class="last_btn active" id="goYear"><spring:message code="M01062"/></button>
            </div>
            <div id='monthCalendar'></div>
            <div id="yearCalendar">
                <div class="fc-toolbar">
                    <div class="fc-center">
                        <div>
                            <button type="button" class="fc-prev-button fc-button fc-state-default" id="yearPrev"><span class="fc-icon fc-icon-left-single-arrow"></span></button>
                            <h2 id="yearCalendar_year"></h2>
                            <button type="button" class="fc-next-button fc-button fc-state-default" id="yearNext"><span class="fc-icon fc-icon-right-single-arrow"></span></button>
                        </div>
                    </div>
                    <div class="fc-clear"></div>
                </div>
                <div class="table_wrap" id="yearTable">
                    <table>
                        <tbody>
                        <tr class="head_row">
                            <td class="campaign_cell"><spring:message code="M01056"/></td>
                            <td class="month_cell"><spring:message code="M01063"/></td>
                            <td class="month_cell"><spring:message code="M01064"/></td>
                            <td class="month_cell"><spring:message code="M01065"/></td>
                            <td class="month_cell"><spring:message code="M01066"/></td>
                            <td class="month_cell"><spring:message code="M01067"/></td>
                            <td class="month_cell"><spring:message code="M01068"/></td>
                            <td class="month_cell"><spring:message code="M01069"/></td>
                            <td class="month_cell"><spring:message code="M01070"/></td>
                            <td class="month_cell"><spring:message code="M01071"/></td>
                            <td class="month_cell"><spring:message code="M01072"/></td>
                            <td class="month_cell"><spring:message code="M01073"/></td>
                            <td class="month_cell"><spring:message code="M01074"/></td>
                        </tr>
                        </tbody>
                    </table>
                    <div id="yearData">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
