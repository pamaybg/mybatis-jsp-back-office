<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap" >
        <div class="temp_title_bb">
            메퍼 정보
        </div>
    </div>
    <div class="form-horizontal" id="jobStepMapperForm">
        <div class="row">
            <ifvm:inputNew type="text" id="mapperId" dto="mapperId" required="true" label="매퍼 ID" nuc="true" labelClass="3" conClass="9"  maxLength="100"/>
            <ifvm:inputNew type="text" id="mapperDesc" dto="mapperDesc" required="true" label="매퍼 설명" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="select" id="itemType" dto="itemType" required="true" label="아이템 유형" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="mapperParam" dto="mapperParam"  label="매퍼 param" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="select" id="condExtrApplyYn" dto="condExtrApplyYn" required="true" label="추출조건 적용유무" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="condExtrBaseDt" dto="condExtrBaseDt"  label="추출조건기준일" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="text" id="condExtrTerm" dto="condExtrTerm"  label="추출조건기간" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
       	<%-- 	<ifvm:inputNew type="dateTerm" startDto="condExtrStartdtBefore" endDto="condExtrEnddtBefore" startId="condExtrStartdtBefore" endId="condExtrEnddtBefore" required="true" label="기간" labelClass="2" conClass="9" nuc="true" /> --%>
            <ifvm:inputNew type="text" id="condExtrUnit" dto="condExtrUnit"  label="조건추출 단위" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="dateTerm" startDto="condExtrStartdt" endDto="condExtrEnddt" startId="condExtrStartdt" endId="condExtrEnddt"  label="기간" labelClass="3" conClass="9" nuc="true" />
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
            btnFunc="saveJobStepMapper"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="jobStepMapperPopClose"/>
</div>
<div id="execParamDetailPopDiv" class="popup_container"></div>

<script>
    //지역변수
    var jobStepMapperFormVali = $("#jobStepMapperForm").ifvValidation();
    var execParamGrid = null;
    setCalendar();
    var isOldJobStepMapper = gMapperRid && !isJobStepMapperNew;
    //전역변수
    var gExecParamRid = "";
    var isExecParamNew = true;

    jobStepMapperDetailSelectSet();

    mapperSelectChangeFn();
    if (isOldJobStepMapper) {
        getJobStepMapperDetail();

    }


    //Job 저장
    function saveJobStepMapper() {
        if (jobStepMapperFormVali.confirm()) {
            var sendData = $("#jobStepMapperForm").getSubmitData();
            sendData.ridStep = gStepRid;

            var url = !(isOldJobStepMapper) ? "<ifvm:action name='addJobStepMapper'/>" : "<ifvm:action name='editJobStepMapper'/>";
            if (isOldJobStepMapper) {
                sendData.rid = gMapperRid;
            }
            var confirmMsg = !(isOldJobStepMapper) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                	jobStepMapperPopClose();
                    makeJobStepMapperGrid();
                    alert(confirmMsg);
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
        }
    }

    //Job 상세 조회
    function getJobStepMapperDetail() {
        var url = "<ifvm:action name='getJobStepMapperDtl'/>";
        var sendData = {};
        sendData.rid = gMapperRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#jobStepMapperForm").dataSetting(_result, null, false, [])
                mapperViewValid();
            }, null, "#jobPopup", "bigsize_progressRoll include_progress"
        );
    }
	function setCalendar() {
	   	 var startDate = $('#condExtrStartdtBefore');
	   	 var endDate = $('#condExtrEnddtBefore');
	   	 //오늘날짜
	   	 startDate.val($.ifvGetTodayDate());
	   	 //오늘부터 한달 뒤
	   	 endDate.val($.ifvGetNewDate('m', +1).newDateS);

	   	 //설정
	   	 startDate.ifvDateChecker({
	   	  maxDate : endDate
	   	 });

	   	 endDate.ifvDateChecker({
	   	  minDate : startDate
	   	 });
   }
	function jobStepMapperDetailSelectSet(){
		$.ifvGetCommCodeList('select', 'itemType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_ITEM_TYPE', 'loy', false, false, true);
    	$.ifvGetCommCodeList('select', 'condExtrApplyYn', '<ifvm:action name="getCommCodeList"/>', 'YES_NO_FLAG', 'loy', false, false, true);
    }

	function mapperViewValid(){
			checkVal = $("#condExtrApplyYn").val();
			if(checkVal=="N"){
				$("#condExtrBaseDt").attr("disabled",true);
				$("#condExtrBaseDt").val("");
				$("#condExtrTerm").attr("disabled",true);
				$("#condExtrTerm").val("");
			}else{
				$("#condExtrBaseDt").attr("disabled",false);
				$("#condExtrTerm").attr("disabled",false);
			}
	}

	function mapperSelectChangeFn(){
		$("#condExtrApplyYn").change(function(){
			mapperViewValid();
		})
	}
	function setCalendar() {
	   	 var startDate = $('#condExtrStartdt');
	   	 var endDate = $('#condExtrEnddt');
	   	 //설정
	   	 startDate.ifvDateChecker({
	   	  maxDate : endDate
	   	 });

	   	 endDate.ifvDateChecker({
	   	  minDate : startDate
	   	 });
 	}



</script>