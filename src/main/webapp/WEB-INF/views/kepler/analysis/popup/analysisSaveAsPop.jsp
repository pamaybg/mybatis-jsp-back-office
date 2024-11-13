<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/KPRNodeTree.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		$("#analysisTreeMenu").ifvsfAccordion();
		$("#analysisTreeView").ifvmCreateKPRNodeTree({
			targetId : "analysisTreeView",
			reportFlag : "N",
			setBtn : {
				add : true,
				mod : true,
				del : true
			}
		});
		$("#analysisTreeView").ifvmKPRNodeTreeSetButton();

		$("#analysisSaveAsBtn").click(function(evt) {
			var analysisName = $("#pAnalysisName").val();
			if (!$.fn.ifvmIsNotEmpty(analysisName)) {
				alert("<spring:message code='M01550' />");
				return;
			}

			var treeViewData = $("#analysisTreeView").data("ejTreeView");
			var selectNode = treeViewData.getSelectedNode();
			var folderId = null;

			if (!$.fn.ifvmIsNotEmpty(selectNode)) {
				alert("<spring:message code='M01526' />");
				return;
			} else {
				var parentNode = treeViewData.getParent(selectNode);

				if (!$.fn.ifvmIsNotEmpty(parentNode)) {
					alert("<spring:message code='M01685' />");
					return;
				} else {
					folderId = selectNode.attr("id");
					folderId = folderId.substring(("analysisTreeView_").length);
				}
			}

			var saveFlag = confirm("<spring:message code='M01633' />");

			if (saveFlag === true) {
				$.ifvPostJSON("<ifv:action name='editAnalysisDetailSaveAs' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisName : analysisName,
					folderId : folderId,
					dashboardId : ANALYSIS_CONFIG.DASHBOARD_ID,
					analysisMasterFlag : $.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.DASHBOARD_ID) ? "N" : "Y"
				}, function(rst) {
					alert("<spring:message code='C00094' />");

					if (!$.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.DASHBOARD_ID)) {
						qtjs.href("<ifv:url name='analysisList' />");
					} else {
						qtjs.href("<ifv:url name='dashboardDetail' />" + "?dashboardId=" + ANALYSIS_CONFIG.DASHBOARD_ID);
					}
				}, function(rst) {
					var errorType = rst.errorType;
					if ($.errorChecker(errorType) && errorType !== 0) {
						$.messageCheckr(rst.message);
					} else {
						alert(rst.message);
					}
				});
			}
		});

		$("#analysisSaveAsCancelBtn").click(function(evt) {
			ANALYSIS_SAVE_AS_POP._destroy();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div>
		<label><spring:message code="M01548" /></label>
		<ifv:input type="text" required="true" id="pAnalysisName" maxLength="100" />
	</div>

	<label><spring:message code="M01549" /></label>
	<div id="analysisTreeMenu">
		<h3>
			<spring:message code="M01536" />
		</h3>
		<div id="analysisTreeView"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisSaveAsBtn" objCode="analysisSaveAsBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisSaveAsCancelBtn" objCode="analysisSaveAsCancelBtn_OBJ">
		<spring:message code="C00040" />
	</button>
</div>