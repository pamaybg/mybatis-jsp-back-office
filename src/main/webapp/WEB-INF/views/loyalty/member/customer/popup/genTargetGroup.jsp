<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="genTargetGroupPop_wrap" class="popup_container">
    <div class="pop_inner_wrap">
        <div class="row qt_border">
    		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01490"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" required="true" maxLength="25" id="targetGroupName" names="targetGroupName" />
            </div>
        </div>
        <div class="row qt_border">
    		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00324"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" required="true" maxLength="100" id="targetGroupDesc" names="targetGroupDesc" />
            </div>
        </div>
	</div>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_gray" id="genTargetGroupPopSaveBtn">  
    		<i class="glyphicon glyphicon-check"></i>       
    		<spring:message code="M00137"/>
    	</button>
       	<button class="btn btn-sm btn_lightGray2" id="genTargetGroupPopCloseBtn">         
    		<spring:message code="M01322"/>
    	</button>
    </div> 
</div>

<script type="text/javascript">
	var genTargetGroupPopValidation;
	function saveTargetGroup() {
		if (genTargetGroupPopValidation.confirm()) {

			var gridOption = $("#gridId"+"cafe24MemListGrid").data("ejGrid").option();
			var reqData = gridOption.requestGridData
			reqData.tgtGroupNm = $("#targetGroupName").val();
			reqData.tgtGroupDesc = $("#targetGroupDesc").val();
			
			$.ifvSyncPostJSON('<ifvm:action name="saveCf24TargetGroup"/>', reqData,
				function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						if (result.success) {
							alert("저장되었습니다.");
							genTargetGroupPopupClose();
						} else {
							alert("실패");
							genTargetGroupPopupClose();
						}
					}
				});
		}

	}

	$(document).ready(
			function() {
				genTargetGroupPopValidation = $("#genTargetGroupPop_wrap")
						.ifvValidation();

				//저장 클릭시
				$('#genTargetGroupPopSaveBtn').on('click', function() {
					saveTargetGroup();
				});
				//닫기 클릭시
				$('#genTargetGroupPopCloseBtn').on('click', function() {
					genTargetGroupPopupClose();
				});

			});
</script>