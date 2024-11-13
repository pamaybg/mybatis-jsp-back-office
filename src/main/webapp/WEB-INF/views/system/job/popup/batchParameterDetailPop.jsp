<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
    <div class="pop_inner_wrap" >
        <div class="temp_title_bb">
          	파라미터 정보
        </div>
    </div>
    <div class="form-horizontal" id="batchParameterForm">
        <div class="row">
            <ifvm:inputNew type="text" id="paramNm" dto="paramNm" required="true" label="파라미터 명" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
            <ifvm:inputNew type="select" id="paramType" dto="paramType" required="true" label="유형" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
    	   <div id="normal">
	          <ifvm:inputNew type="text" id="paramVal" dto="paramVal" required="true" label="파라미터 값" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
			</div>
	        <div id="date">
            <ifvm:inputNew type="select" id="paramSubType" dto="paramSubType" required="true" label="상세 유형" nuc="true" labelClass="3" conClass="9"  maxLength="66"/>
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
            btnFunc="saveBatchParameter" objCode="saveBatchParameterDetailPopSave_OBJ"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="batchParameterDtlPop.close()" objCode="batchParameterDetailPopClose_OBJ"/>
</div>

<script>
    //지역변수
    var jobStepFormVali = $("#batchParameterForm").ifvValidation();

    var isBatchParameter = gParamRid && !isBatchParameterNew;
    //전역변수

    batchParameterDetailSelectSet();

    if (isBatchParameter) {
        getBatchParameterDetail();
    }

    //Job 저장
    function saveBatchParameter() {
        if (jobStepFormVali.confirm()) {
            var sendData = $("#batchParameterForm").getSubmitData();
            sendData.ridJob = gJobRid;

            var url = !(isBatchParameter) ? "<ifvm:action name='addBatchParameter'/>" : "<ifvm:action name='editBatchParameter'/>";
            if (isBatchParameter) {
                sendData.rid = gParamRid;
            }
            var confirmMsg = !(isBatchParameter) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                	batchParameterDtlPop.close();
                	makeBatchParameterGrid();
                    alert(confirmMsg);
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
        }
    }

    //Job 상세 조회
    function getBatchParameterDetail() {
        var url = "<ifvm:action name='getBatchParameterDtl'/>";
        var sendData = {};
        sendData.rid = gParamRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#batchParameterForm").dataSetting(_result, null, false, [])

                $('#paramType').change();
            }, null, "#jobPopup", "bigsize_progressRoll include_progress"
        );
    }

	function batchParameterDetailSelectSet(){
		$.ifvGetCommCodeList('select', 'paramType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_JOB_PARAM_TYPE', 'loy', false, true, true);
		$.ifvGetCommCodeList('select', 'paramSubType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_JOB_PARAM_SUB_TYPE', 'loy', false, true, true);

		$('#date').hide();

		$('#paramType').change(function() {
			if($('#paramType').val() === 'DATE'){
				$('#paramVal').val(null);
				$('#paramVal').attr('required', false);
				$('#paramVal').attr('disabled', true);

				$('#paramSubType').attr('required', true);
				$('#paramSubType').attr('disabled', false);
				
				
				$('#normal').hide();
				$('#date').show();

			}else {
				$('#paramSubType').val(null)
				$('#paramVal').attr('required', true);
				$('#paramVal').attr('disabled', false);

				$('#paramSubType').attr('required', false);
				$('#paramSubType').attr('disabled', true);

				$('#normal').show();
				$('#date').hide();

			}
		});
    }

</script>