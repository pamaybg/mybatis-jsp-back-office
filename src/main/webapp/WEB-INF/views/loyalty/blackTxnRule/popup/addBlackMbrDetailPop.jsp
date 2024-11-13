<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id='addBlackMbrDetailForm'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="기준유형"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" dto="basType" required="true" names="basType" id="basType" />
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="횟수"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="number" dto="gtOrEt" id="gtOrEt" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="추출기간"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" dto="basDayMmCd" required="true" names="basDayMmCd" id="basDayMmCd" />
	        </div>
	        
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="기준일/월"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="number" dto="basDayCnt" id="basDayCnt" required="true" />
	        </div>
	        
	    </div>

	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveBlackMbrBtn" objCode="addTierPopTierSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="blackMbrCancelBtn">
		<spring:message code="L01781"/>
	</button>
</div>

<script type="text/javascript">
	var addBlackMbr_isNew;

	function addBlackRulDetailInit() {
		$.fn.ifvmSetSelectOptionCommCode("basType", "LOY_BL_BAS_TYPE", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("basDayCnt", "LOY_BLCK_Mbr_PER_CD", null, null, true);
		
		if (typeof blackMbrRid === 'undefined' || blackMbrRid == null) {
			addBlackMbr_isNew = true;
		} else {
			addBlackMbr_isNew = false;
			getBlackMbrDetail();
		}
	}
	
	function getBlackMbrDetail() {
		$.ifvSyncPostJSON('<ifvm:action name="getBlackMbrDetail"/>', {
			rid : blackMbrRid
		}, function(result) {
			 $("#basType").val(result.basType);
			 $("#gtOrEt").val(result.gtOrEt);
			 $("#basDayMmCd").val(result.basDayMmCd);
			 $("#basDayCnt").val(result.basDayCnt);

		});
	}

	function saveBlackMbr() {

		var validation = $("#addBlackMbrDetailForm").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = addBlackMbr_isNew ? '<ifvm:action name="saveBlackMbr"/>'
					: '<ifvm:action name="modifyBlackMbr"/>';
			var varData = null;
			varData = {
				rid 		 : blackMbrRid,
				blackMbrRid :  blackMbrRid,
				blackTxnRid :  blackMbrDetail_rid,
				blackMstRid   : blackMbrDetail_rid,
				basType 		 : $("#basType").val(),
				gtOrEt   : 	$("#gtOrEt").val(),
				basDayMmCd 		 : $("#basDayMmCd").val(),
				basDayCnt : $("#basDayCnt").val(),
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addBlackMbrDetailClosePop();
					addBlackMbr_isNew = false;
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

		$("#saveBlackMbrBtn").click(function() {
			saveBlackMbr();
		});

		$("#blackMbrCancelBtn").click(function() {
			addBlackMbrDetailClosePop();
		});

	});
</script>