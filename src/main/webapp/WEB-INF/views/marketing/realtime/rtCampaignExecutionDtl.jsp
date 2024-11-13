<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>


<style>
    .underline .qt_border {
        padding: 10px;
    }
</style>

<script>

    var eventTriggerRid = '<%= cleanXss(request.getParameter("rid")) %>';
    var detail = false;

    var eventTriggerValidation;

    function inNumber() {
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }

    /**
     * 상세 조회
     */
    function idCheck() {

        if ($.fn.ifvmIsNotEmpty(eventTriggerRid)) {

            $.ifvPostJSON('<ifvm:action name="getRealTimeCampaignExecutionDetail"/>', {
                rid: eventTriggerRid
            }, function (result) {

                if ($.fn.ifvmIsNotEmpty(result)) {
                    detail = true;
                    $('#newORdetail').text("상세");
                    $('#rid').val(result.rid);
                    $('#processNm').val(result.processNm);
                    $('#processCd').val(result.processCd);
                    $('#processStatus').val(result.processStatus);
                    $('#triggerType').val(result.triggerType);
                    $('#minWorker').val(result.minWorker);
                    $('#maxWorker').val(result.maxWorker);
                    $('#hndlMq').val(result.hndlMq);
                    $('#waitMq').val(result.waitMq);
                    $('#errMq').val(result.errMq);
					$('#svcExeMq').val(result.svcExeMq);
					$('#cachePort').val(result.cachePort);
                }
            });
        }
    }

    /**
     * 이벤트 트리거 데이터 유형 팝업 열기
     */
    function intactTypePopupOpen() {
        $("#intactTypePopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="intactTypePop"/>',
            contentType: "ajax",
            title: '<spring:message code="M02313"/>',
            width: 700,
            close: 'intactTypePopupClose'
        });
    }

    /**
     * 이벤트 트리거 데이터 유형 팝업 닫기
     */
    function intactTypePopupClose() {
        intactTypePopup._destroy();
    }

    /**
     * 이벤트 트리거 데이터 유형 선택
     */
    function selectIntactType() {
        var rowId = gridIdintactTypePopGrid.getGridParam("selrow");
        var rowData = gridIdintactTypePopGrid.getRowData(rowId);

        if ($.fn.ifvmIsNotEmpty(rowId)) {
            $("#triggerType").val(rowData.rid);
            $("#triggerTypeNm").val(rowData.intactType_2CdNm);

            //팝업 닫기
            intactTypePopupClose();
        }
    }

    /**
     * 이벤트 트리거 상세 저장
     */
    function saveEventTrigger() {
        if (eventTriggerValidation.confirm()) {
			var dataObject = {
				processNm: $('#processNm').val()
				, processCd: $('#processCd').val()
				, processStatus: $('#processStatus').val()
				, triggerType: $('#triggerType').val()
				, minWorker: $('#minWorker').val()
				, maxWorker: $('#maxWorker').val()
				, hndlMq: $('#hndlMq').val()
				, waitMq: $('#waitMq').val()
				, errMq: $('#errMq').val()
				, svcExeMq: $('#svcExeMq').val()
				, cachePort: $('#cachePort').val()
			};

            // 수정
            if (detail) {

				dataObject.rid = eventTriggerRid;

                $.ifvPostJSON('<ifvm:action name="editRealCampaigExecution"/>', dataObject, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result) && result.success) {
                            alert('<spring:message code="M00106"/>');

                            //location.href = '<ifvm:url name="rtCampaignExecution"/>';
                            qtjs.href('<ifvm:url name="rtCampaignExecution"/>');
                    } else {
                    	alert(result.message);
					}
                }, function(resData) {
                	alert(resData.message);
				});
            }
            //등록
            else {
                $.ifvPostJSON('<ifvm:action name="addRealCampaigExecution"/>', dataObject, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result) && result.success) {
                            alert('<spring:message code="C00094"/>');

                            //location.href = '<ifvm:url name="rtCampaignExecution"/>';
                            qtjs.href('<ifvm:url name="rtCampaignExecution"/>');
                    }else {
						alert(result.message);
					}
				}, function(resData) {
					alert(resData.message);
				});
            }
        }
    }

    $(document).ready(function () {
        $.ifvmLnbSetting('eventExecutionList');

        $.fn.ifvmSetSelectOptionCommCode("orderby", "EVT_PROCESS_ORDERBY", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("processStatus", "EVT_PROCESS_STATUS", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("triggerType", "MKT_INTACT_TYPE", null, null, true);

        idCheck();

        //이벤트 트리거 유형 팝업 버튼
        $('#intactTypePopupBtn').on('click', function () {
            intactTypePopupOpen();
        });

        //저장 버튼
        $('#eventSaveBtn').on('click', function () {
            saveEventTrigger();
        });


        $("#btnList").click(function () {
            qtjs.href('<ifvm:url name="rtCampaignExecution"/>');
        });


        $("#minWorker, #maxWorker").on("keyup", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, ""));
        });


        eventTriggerValidation = $("#eventTriggerForm").ifvValidation();
    });

</script>
<!-- <spring:message code="M00274"/> -->
<div class="page-title">
    <h1>
        실시간캠페인 실행관리 &gt;<span id="newORdetail">신규</span>
    </h1>
</div>

<div class="well">
<div class="page_btn_area" id="headForm">

    <div class="col-xs-7">
        <span>실시간캠페인 실행관리</span>
    </div>
    <div class="col-xs-5 searchbtn_r">

        <%-- 저장버튼 --%>
        <button class="btn btn-sm" id="eventSaveBtn" objCode="eventSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00573"/>
        </button>
        <button class="btn btn-sm" id="btnList" objCode="btnList_OBJ"><spring:message code="M00002"/></button>

    </div>
</div>

<div class="well form-horizontal underline top_well" id="eventTriggerForm">
    <div class="row qt_border">
        <!-- 서비스명  -->
        <ifvm:inputNew type="text" id="processNm" names="processNm" dto="processNm" label="M01440" labelClass="1" conClass="2" required="true"/>
        <!-- 서비스코드 -->
        <ifvm:inputNew type="text" id="processCd" dto="processCd" label="M02931" labelClass="2" conClass="2" required="true"/>
        <!-- 서비스상태 -->
        <ifvm:inputNew type="select" id="processStatus" names="processStatus" dto="processStatus" label="M02932" labelClass="2" conClass="2" required="true"/>
    </div>

    <div class="row qt_border">
        <!-- 이벤트 유형 -->
        <ifvm:inputNew type="select" id="triggerType" names="triggerType" dto="triggerType" label="E00021" labelClass="1" conClass="2" required="true"/>
        <!-- 최저 worker-->
        <ifvm:inputNew type="text" id="minWorker" names="minWorker" dto="minWorker" label="M02933" labelClass="2" conClass="2" required="true"/>
        <!-- 최대 worker-->
        <ifvm:inputNew type="text" id="maxWorker" names="maxWorker" dto="maxWorker" label="M02934" labelClass="2" conClass="2" required="true"/>
    </div>
    <div class="row qt_border">
        <!-- 핸들MQ-->
        <ifvm:inputNew type="text" id="hndlMq" dto="hndlMq" label="M02935" labelClass="1" conClass="2" required="true"/>
        <!-- 대기MQ  -->
        <ifvm:inputNew type="text" id="waitMq" dto="waitMq" label="M02936" labelClass="2" conClass="2" required="true"/>
        <!-- 에러MQ -->
        <ifvm:inputNew type="text" id="errMq" names="errMq" dto="errMq" label="M02937" labelClass="2" conClass="2" required="true"/>
    </div>

	<div class="row qt_border">
		<!-- 핸들MQ-->
		<ifvm:inputNew type="text" id="svcExeMq" dto="svcExeMq" label="실행제어RK" labelClass="1" conClass="2" required="true" nuc="true"/>
		<!-- 대기MQ  -->
		<ifvm:inputNew type="number" id="cachePort" dto="cachePort" label="캐시 포트" labelClass="2" conClass="2" required="true" nuc="true"/>
	</div>

</div>
 </div>

<div id="intactTypePopup"></div>
