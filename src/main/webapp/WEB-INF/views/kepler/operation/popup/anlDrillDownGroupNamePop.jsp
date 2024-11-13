<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ifv" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="pop_inner_wrap">
	<div id="chartLabelDetailArea" class="analysis_setup_prompt form-horizontal">
		<div class="row">
			<label class="col-xs-3 control-label text-right"><spring:message code="M02267" /></label>

			<div class="col-xs-9 control_content">
				<ifv:input type="text" id="metaDrillDownGroupName" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="anlDrillDownGroupNameConfirm">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="anlDrillDownGroupNameCancel">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	var setDrillDownGroupName = function(thisNodeData) {
		var thisNodeName = thisNodeData.nodeName;
		if ($.fn.ifvmIsNotEmpty(thisNodeName)) {
			$("#metaDrillDownGroupName").val(thisNodeName);
		}

		$("#metaDrillDownGroupName").data("nodeData", thisNodeData);
	};

	$(document).ready(function() {
		$("#anlDrillDownGroupNameConfirm").click(function() {
			var thisDrillDownGroupName = $("#metaDrillDownGroupName").val();

			if ($.fn.ifvmIsNotEmpty(thisDrillDownGroupName)) {
				var nodeData = $("#metaDrillDownGroupName").data("nodeData");
				nodeData.nodeName = thisDrillDownGroupName;

				setDrillDownGroup(nodeData);
			} else {
				alert("<spring:message code='M02268' />");
			}
		});
		
		$("#anlDrillDownGroupNameCancel").click(function() {
			$("#anlDrillDownGroupNamePop").data("ejDialog").close();
		});
	});
</script>