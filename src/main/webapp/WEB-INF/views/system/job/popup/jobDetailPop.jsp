<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap" >
        <div class="temp_title_bb">
            Batch 정보
        </div>
    </div>
    <div class="form-horizontal" id="jobForm">
        <div class="row">
            <ifvm:inputNew
                    type="text"
                    id="jobNm"
                    dto="jobNm"
                    required="true"
                    label="Batch 명"
                    nuc="true"
                    labelClass="2"
                    conClass="9"
                    maxLength="66"/>
        </div>

        <div class="row none" id="pgmNmForm">
            <ifvm:inputNew
                    type="text"
                    id="jobDesc"
                    dto="jobDesc"
                    required="true"
                    label="설명"
                    nuc="true"
                    labelClass="2"
                    conClass="9"
                    maxLength="100"/>
        </div>

		  <div class="row none" id="execCycleForm">
            <ifvm:inputNew
                    type="select"
                    id="useYn"
                    dto="useYn"
                    required="true"
                    label="사용 유무 "
                    nuc="true"
                    labelClass="2"
                    conClass="9"
                    maxLength="100"/>
        </div>


        <div class="row none" id="execCycleForm">
            <ifvm:inputNew
                    type="text"
                    id="execCycle"
                    dto="execCycle"
                    required="true"
                    label="cron 표현식 "
                    nuc="true"
                    labelClass="2"
                    conClass="9"
                    maxLength="100"/>
        </div>

           <div class="row none" id="execCycleDescForm">
            <ifvm:inputNew
                    type="text"
                    id="execCycleDesc"
                    dto="execCycleDesc"
                    required="true"
                    label="cron 표현식설명 "
                    nuc="true"
                    labelClass="2"
                    conClass="9"
                    maxLength="100"/>
        </div>
    </div>
</div>
<br/>

<div class="pop_btn_area">
    <ifvm:inputNew
            type="button"
            btnType="save"
            text="저장"
            nuc="true"
            btnFunc="saveJob" objCode="jobDetailPopSave_OBJ"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="jobDetailPopDiv.close()" objCode="jobDetailPopClose_OBJ"/>
</div>
<div id="execParamDetailPopDiv" class="popup_container"></div>

<script>
    //지역변수
    var jobFormVali = $("#jobForm").ifvValidation();
    var execParamGrid = null;
    var isOldJob = gJobRid && !isJobNew;
    //전역변수
    var gExecParamRid = "";
    var isExecParamNew = true;

    jobDetailSelectSet();
    changeDiviDisplay();



    $("#jobDiviVal").change(changeDiviDisplay);

    if (isOldJob) {
        $("#execParamDiv").removeAttr("hidden");
        getJobDetail();
    }


    //Job 구분 값에 따른 화면 변경 처리
    function changeDiviDisplay() {
        switch ($("#jobDiviVal").val()) {
            case "배치":
                $("#pgmNmForm").removeClass("none");
                pgmNm.setAttribute("required", true);
                break;
            case "실시간":
                $("#pgmNmForm").addClass("none");
                pgmNm.removeAttribute("required");
                break;
        }
    }

    //Job 저장
    function saveJob() {
        if (jobFormVali.confirm()) {
            var sendData = $("#jobForm").getSubmitData();
            var url = !(isOldJob) ? "<ifvm:action name='addJob'/>" : "<ifvm:action name='editJob'/>";
            if (isOldJob) {
                sendData.rid = gJobRid;
            }
            var confirmMsg = !(isOldJob) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                	// jobDetailPopDiv.close();
                    if (isOldJob) {
                        var curPageNum = jobGrid.opt.postData.page;
                       // jobGrid.requestData({"page": curPageNum});
                        jobListApp.fnSearch();
                    } else {
                    	jobListApp.fnSearch();
                       // jobGrid.requestData();
                    }
                    alert(confirmMsg);
                    $.fn.ifvmPopupClose();
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
            jobListApp.fnSearch();
            alert(confirmMsg);
            $.fn.ifvmPopupClose();
        }
    }

    //Job 상세 조회
    function getJobDetail() {
        var url = "<ifvm:action name='getJobDetail'/>";
        var sendData = {};
        sendData.rid = gJobRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#jobForm").dataSetting(_result, null, false, [])
                changeDiviDisplay();
            }, null, "#jobPopup", "bigsize_progressRoll include_progress"
        );
    }




    function jobDetailSelectSet(){
    	$.ifvGetCommCodeList('select', 'useYn', '<ifvm:action name="getCommCodeList"/>', 'YES_NO_FLAG', 'loy', false, false, true);
    }

</script>