<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id='addBlackMbrsDetailForm'>

	<div class="pop_inner_wrap form-horizontal">

	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><spring:message code="상태"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:inputNew type="select" dto="blsStatCd" required="true" names="blsStatCd" id="blsStatCd" />
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="설명"/></label>
	        <div class="col-xs-10 control_content">
					<ifvm:inputNew type="textarea" maxLength="150" id="blsContetns" dto="blsContetns" labelClass="2" conClass="15" rows="3"/>
	        </div>
	        
	    </div>

	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveBlackMbrsBtn" objCode="addTierPopTierSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="blackMbrsCancelBtn">
		<spring:message code="L01781"/>
		
	</button>
</div>

<div id="MbrsPop" class="popup_container"></div>

<script type="text/javascript">
	function addBlackRulDetailInit() {
			$.fn.ifvmSetSelectOptionCommCode("blsStatCd", "LOY_BL_MEM_STAT_CD", null,null,true);
			getBlackMbrsDetail();
		
	}
	
	function getBlackMbrsDetail() {
		$.ifvSyncPostJSON('/loyalty/blackTxnRule/getBlackMbrDetail.do', {
			rid : blackMbrRid
		}, function(result) {
			 $("#blsContetns").val(result.contents);
			 $("#blsStatCd").val(result.statCd);
			 if(result.statCd == 'CONF') {
				 $("#blsStatCd").attr("disabled",true);
			 } else{
				 $("#blsStatCd").attr("disabled",false);
			 }
			 
		});
	}

	function saveBlackMbrs() {

		var validation = $("#addBlackMbrsDetailForm").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = '<ifvm:action name="modifyBlStat"/>';
			var varData = null;
			varData = {
				rid 		 : blackMbrRid,
				blackMbrRid : blackMbrRid,
				contents    : $("#blsContetns").val(),
				statCd    : $("#blsStatCd").val(),
				periodMm : periodMm
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					modifyStatCdClosePop();
					blackMbrList._doAjax();
				}
			}, function(result) {
				if (result.message != null)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
		}
	}


	$(document).ready(function() {
		addBlackRulDetailInit();

		$("#saveBlackMbrsBtn").click(function() {
			saveBlackMbrs();
		});

		$("#blackMbrsCancelBtn").click(function() {
			modifyStatCdClosePop();
		});

	});
</script>