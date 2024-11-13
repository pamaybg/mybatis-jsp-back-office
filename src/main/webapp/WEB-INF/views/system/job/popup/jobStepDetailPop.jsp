<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap">
        <div class="temp_title_bb">
            Step 정보
        </div>
    </div>
    <div class="form-horizontal" id="jobStepForm">
        <div class="row">
            <ifvm:inputNew type="text" id="stepNm" dto="stepNm" required="true" label="Step명" nuc="true" labelClass="3" conClass="9" maxLength="66"/>
            <ifvm:inputNew type="text" id="stepDesc" dto="stepDesc" required="true" label="설명" nuc="true" labelClass="3" conClass="9" maxLength="66"/>

            <ifvm:inputNew type="select" id="stepType" dto="stepType" required="true" label="유형" nuc="true" labelClass="3" conClass="9" maxLength="66"/>

            <div id="tasklet">
                <ifvm:inputNew type="text" id="taskletNm" dto="taskletNm" required="true" label="Tasklet 명" nuc="true" labelClass="3" conClass="9" maxLength="66"/>
            </div>

            <div id="item">
                <ifvm:inputNew type="text" id="itemReaderNm" dto="itemReaderNm" required="true" label="Item Reader" nuc="true" labelClass="3" conClass="9" maxLength="66"/>
                <ifvm:inputNew type="text" id="itemWriterNm" dto="itemWriterNm" required="true" label="Item Writer " nuc="true" labelClass="3" conClass="9" maxLength="66"/>
                <ifvm:inputNew type="text" id="itemProcessNm" dto="itemProcessNm" label="Item Process" nuc="true" labelClass="3" conClass="9" maxLength="66"/>
            </div>
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
            btnFunc="saveJobStep" objCode="jobStepDetailPopSave_OBJ"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="jobStepDtlPop.close()" objCode="jobStepDetailPopClose_OBJ"/>
</div>

<script>
    //지역변수
    var jobStepFormVali = $("#jobStepForm").ifvValidation();
    //var execParamGrid = null;
    var isOldJobStep = gStepRid && !isJobStepNew;
    //전역변수
    //var gExecParamRid = "";
    // var isExecParamNew = true;


    // changeDiviDisplay();
    jobStepDetailSelectSet();


    //$("#jobDiviVal").change(changeDiviDisplay);

    if (isOldJobStep) {
        getJobStepDetail();
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
    function saveJobStep() {
        if (jobStepFormVali.confirm()) {
            var sendData = $("#jobStepForm").getSubmitData();
            sendData.ridJob = gJobRid;

            var url = !(isOldJobStep) ? "<ifvm:action name='addJobStep'/>" : "<ifvm:action name='editJobStep'/>";
            if (isOldJobStep) {
                sendData.rid = gStepRid;
            }
            var confirmMsg = !(isOldJobStep) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                    jobStepDtlPop.close();
                    makeJobStepGrid();
                    alert(confirmMsg);
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
        }
    }

    //Job 상세 조회
    function getJobStepDetail() {
        var url = "<ifvm:action name='getJobStepDtl'/>";
        var sendData = {};
        sendData.rid = gStepRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#jobStepForm").dataSetting(_result, null, false, [])
                //changeDiviDisplay();
                $('#stepType').change();
                //#stepType이 change되면서 taskletNm이 리셋되어 밑에 로직을 추가하였습니다. 2020.12.03 hr.noh
                $("#taskletNm").val(_result.taskletNm);
            }, null, "#jobStepGridCon", "bigsize_progressRoll include_progress"
        );
    }

    function jobStepDetailSelectSet() {
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
            groupCode : 'BATCH_STEP_TYPE'
            , schemas: 'loy'
            , enableNA : false
        },function(result) {
            var templates = $('#commCodeTemp').tmpl(result.rows);

            $('#stepType').append(templates);
        });

        $('#item').hide();

        $('#stepType').change(function () {
            if ($('#stepType').val() === 'ITEM_USE') {
                $('#itemReaderNm').attr('required', true);
                $('#itemWriterNm').attr('required', true);
                $('#itemProcessNm').attr('required', true);

                $('#taskletNm').attr('required', false);

                $('#tasklet').hide();
                $('#item').show();
            } else if ($('#stepType').val() === 'DIRECT_TASKELT') {
            	$('#taskletNm').attr('required', true);
                $('#itemReaderNm').attr('required', false);
                $('#itemWriterNm').attr('required', false);
                $('#itemProcessNm').attr('required', false);

                $('#tasklet').show();
                $('#item').hide();
            } else {  //아이템입력이 아닌 경우 입력창 비활성화
                $('#taskletNm').attr('required', true)
                        .val($(this)
                        .find('option:selected').data('attrib01'));

                $('#itemReaderNm').attr('required', false);
                $('#itemWriterNm').attr('required', false);
                $('#itemProcessNm').attr('required', false);

                $('#tasklet').show();
                $('#item').hide();
            }
        });
        
        $('#stepType').change();
    }

</script>

<script id="commCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" data-attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>