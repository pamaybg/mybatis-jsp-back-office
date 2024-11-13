<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap" >
        <div class="temp_title_bb">
            명령어 정보
        </div>
    </div>
    <div class="form-horizontal" id="jobStepCommandForm">
        <div class="row">
            <ifvm:inputNew type="select" id="itemType" dto="itemType" required="true" label="아이템 유형" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="command" dto="command" required="true" label="명령어" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="select" id="commandParamType" dto="commandParamType" required="true" label="명령어 param 유형" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="commandParam" dto="commandParam"  label="명령어 param" nuc="true" labelClass="3" conClass="9"  maxLength="66" desc="명령어 파라미터 구분자는 æ (아스키230번) 입니다."/>
            <ifvm:inputNew type="text" id="workingDirectory" dto="workingDirectory" required="true"  label="명령어 실행경로" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="timeout" dto="timeout" required="true" valiItem="number" label="타임아웃" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
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
            btnFunc="saveJobStepCommand"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="jobStepCommandPopClose"/>
</div>
<div id="execParamDetailPopDiv" class="popup_container"></div>

<script>
    //지역변수
    var jobStepCommandFormVali = $("#jobStepCommandForm").ifvValidation();
    var execParamGrid = null;
//     setCalendar();
    var isOldJobStepCommand = gCommandRid && !isJobStepCommandNew;
    //전역변수
    var gExecParamRid = "";
    var isExecParamNew = true;

    jobStepCommandDetailSelectSet();

//     CommandSelectChangeFn();
    if (isOldJobStepCommand) {
        getJobStepCommandDetail();

    }


    //Job 저장
    function saveJobStepCommand() {
        if (jobStepCommandFormVali.confirm()) {
            var sendData = $("#jobStepCommandForm").getSubmitData();
            sendData.ridStep = gStepRid;

            var url = !(isOldJobStepCommand) ? "<ifvm:action name='addJobStepCommand'/>" : "<ifvm:action name='editJobStepCommand'/>";
            if (isOldJobStepCommand) {
                sendData.rid = gCommandRid;
            }
            var confirmMsg = !(isOldJobStepCommand) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                	jobStepCommandPopClose();
                    makeJobStepCommandGrid();
                    alert(confirmMsg);
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
        }
    }

    //Job 상세 조회
    function getJobStepCommandDetail() {
        var url = "<ifvm:action name='getJobStepCommandDtl'/>";
        var sendData = {};
        sendData.rid = gCommandRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#jobStepCommandForm").dataSetting(_result, null, false, [])
//                 CommandViewValid();
            }, null, "#jobPopup", "bigsize_progressRoll include_progress"
        );
    }
// 	function setCalendar() {
// 	   	 var startDate = $('#condExtrStartdtBefore');
// 	   	 var endDate = $('#condExtrEnddtBefore');
// 	   	 //오늘날짜
// 	   	 startDate.val($.ifvGetTodayDate());
// 	   	 //오늘부터 한달 뒤
// 	   	 endDate.val($.ifvGetNewDate('m', +1).newDateS);

// 	   	 //설정
// 	   	 startDate.ifvDateChecker({
// 	   	  maxDate : endDate
// 	   	 });

// 	   	 endDate.ifvDateChecker({
// 	   	  minDate : startDate
// 	   	 });
//    }
	function jobStepCommandDetailSelectSet(){
		$.ifvGetCommCodeList('select', 'itemType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_ITEM_TYPE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'commandParamType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_COMMAND_PARAM_TYPE', 'loy', false, false, true);
    }

// 	function CommandViewValid(){
// 			checkVal = $("#condExtrApplyYn").val();
// 			if(checkVal=="N"){
// 				$("#condExtrBaseDt").attr("disabled",true);
// 				$("#condExtrBaseDt").val("");
// 				$("#condExtrTerm").attr("disabled",true);
// 				$("#condExtrTerm").val("");
// 			}else{
// 				$("#condExtrBaseDt").attr("disabled",false);
// 				$("#condExtrTerm").attr("disabled",false);
// 			}
// 	}

// 	function CommandSelectChangeFn(){
// 		$("#condExtrApplyYn").change(function(){
// 			CommandViewValid();
// 		})
// 	}
// 	function setCalendar() {
// 	   	 var startDate = $('#condExtrStartdt');
// 	   	 var endDate = $('#condExtrEnddt');
// 	   	 //설정
// 	   	 startDate.ifvDateChecker({
// 	   	  maxDate : endDate
// 	   	 });

// 	   	 endDate.ifvDateChecker({
// 	   	  minDate : startDate
// 	   	 });
//  	}



</script>