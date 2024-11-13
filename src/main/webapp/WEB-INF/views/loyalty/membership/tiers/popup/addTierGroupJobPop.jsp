<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="tierGrpJobAddForm">
<br>	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="등급심사 유형"/></label>
		<div class="col-xs-5 control_content">
			<ifvm:inputNew type="select" required="true" id="tierBatchJobCd" dto="tierBatchJobCd" names="tierBatchJobCd"/>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="실행 주기"/></label>
		<div class="col-xs-5 control_content">
			<ifvm:inputNew type="select" required="true" id="execCycle" dto="execCycle" names="execCycle"/>
		</div>
	</div>
	
	<div class="row qt_border">
			<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="실행 월" /></label>
			<div class="col-sm-9 control_content">
				<div id="tierGrpJob" class="input-group" >
				<label class="radio-inline"><spring:message code="M01063"/>
				<ifvm:input type="checkbox"  id="execMm1myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01064"/>
				<ifvm:input type="checkbox"  id="execMm2myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01065"/>
				<ifvm:input type="checkbox"  id="execMm3myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01066"/>
				<ifvm:input type="checkbox"  id="execMm4myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01067"/>
				<ifvm:input type="checkbox"  id="execMm5myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01068"/>
				<ifvm:input type="checkbox"  id="execMm6myn"/>
				</label>
				<br>
				<label class="radio-inline"><spring:message code="M01069"/>
				<ifvm:input type="checkbox"  id="execMm7myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01070"/>
				<ifvm:input type="checkbox"  id="execMm8myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01071"/>
				<ifvm:input type="checkbox"  id="execMm9myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01072"/>
				<ifvm:input type="checkbox"  id="execMm10myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01073"/>
				<ifvm:input type="checkbox"  id="execMm11myn"/>
				</label>
				<label class="radio-inline"><spring:message code="M01074"/>
				<ifvm:input type="checkbox"  id="execMm12myn"/>
				</label>
				</div>
			</div>

		</div>

	<div class="row qt_border">
	<br>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="사용여부"/></label>
		<div class="col-xs-5 control_content">
			<ifvm:inputNew type="select" required="true" id="useYn" dto="useYn" names="useYn"/>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="saveTierGrpJob" objCode="saveTierGrpJob_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_lightGray2" id="tierGrpJobCancle" objCode="cancleTierGrpJob_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<script type="text/javascript">
var tierGrpJob_isNew;

	function tierGrpJobDetailInit() {
		if (typeof tierGrpJobRid === 'undefined' || tierGrpJobRid == null) {
			tierGrpJob_isNew = true;
		} else {
			tierGrpJob_isNew = false;
			getTierGrpJobDetail();
		}
	}
	
	function getTierGrpJobDetail() {
		$.ifvSyncPostJSON('<ifvm:action name="getTierGrpJobDetail"/>', {
			rid : tierGrpJobRid
		}, function(result) {
			 $("#tierBatchJobCd").val(result.tierBatchJobCd);
			 $("#execCycle").val(result.execCycle);
			 $("#useYn").val(result.useYn);
			 tierupAplyMmSetting(result.execMm);
		});
	}
	
	function tierupAplyMmSetting(tierupAplyMm) {
		for(var i = 0; i < tierupAplyMm.length; i++){
			 var index = i+1;
			if(tierupAplyMm[i] == "1"){
				$("input:checkbox[id='execMm"+index+"myn']").attr("checked", true);
			}else{
				$("input:checkbox[id='execMm"+index+"myn']").attr("checked", false);
			}
		}
	}

	function saveTierGrpJob() {
		/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
			alert("작성중일때만 수정할수 있습니다.");
			return;
		} */
		
		if(tierupAplyCheck() == $("input:checkbox").length){
			alert('<spring:message code="M02003" />');
			return;
		}
		
		var validation = $("#tierGrpJobAddForm").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = tierGrpJob_isNew ? '<ifvm:action name="saveTierGrpJob"/>'
					: '<ifvm:action name="modifyTierGrpJob"/>';
			var varData = null;
			varData = {
				rid 		   : tierGrpJobRid,
				tierGroupRid   : tierGroupDetail_rid,
				tierBatchJobCd : $("#tierBatchJobCd").val(),
				useYn		   : $("#useYn").val(),
				execCycle      : $("#execCycle").val(),
				execMm		   : execMm1myn() + execMm2myn() + execMm3myn() + execMm4myn() + execMm5myn() + execMm6myn()
				  				+execMm7myn() + execMm8myn() + execMm9myn() + execMm10myn() + execMm11myn() + execMm12myn()
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addTierGrpJobClosePop();
					tierGroupJobGridList._doAjax();
					tierGrpJob_isNew = false;
				}
			}, function(result) {
				if (result.message != null)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
		}
	}
	
	function tierupAplyCheck(){
		cnt = 0;
		for(var i=0; i<$("input:checkbox").length; i++){
			var chk = $("input:checkbox")[i].checked;
			if(!chk){
				cnt++;
			}
		}
		return cnt;
	}
	
	function execMm1myn(){
		if($("#execMm1myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm2myn(){
		if($("#execMm2myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm3myn(){
		if($("#execMm3myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm4myn(){
		if($("#execMm4myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm5myn(){
		if($("#execMm5myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm6myn(){
		if($("#execMm6myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm7myn(){
		if($("#execMm7myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm8myn(){
		if($("#execMm8myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm9myn(){
		if($("#execMm9myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm10myn(){
		if($("#execMm10myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm11myn(){
		if($("#execMm11myn").is(":checked")) return "1";
		else return "0";
	}
	function execMm12myn(){
		if($("#execMm12myn").is(":checked")) return "1";
		else return "0";
	}

	$(document).ready(function() {
		$.fn.ifvmSetSelectOptionCommCode("tierBatchJobCd", "LOY_TIER_BATCH_JOB_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("execCycle", "LOY_TIER_BATCH_JOB_EXEC_CYLE_CD", null, null, false);
		
		tierGrpJobDetailInit();

		$("#saveTierGrpJob").click(function() {
			saveTierGrpJob();
		});

		$("#tierGrpJobCancle").click(function() {
			addTierGrpJobClosePop();
		});

	});
</script>