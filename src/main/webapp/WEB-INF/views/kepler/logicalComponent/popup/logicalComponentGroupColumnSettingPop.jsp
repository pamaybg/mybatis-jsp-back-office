<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
.grp_col_height {
	max-height: 300px;
	overflow-y: auto;
}
</style>

<div class="pop_inner_wrap">
	<div class="form-horizontal underline">
		<div class="row qt_border">
			<div class="col-xs-12">
				<label class="radio-inline"> <ifv:input type="radio" names="lgcGrpColFlag" values="N" checked="true" id="lgcGrpColFlag" /> 그룹 함수 사용 안함
				</label> <label class="radio-inline"> <ifv:input type="radio" names="lgcGrpColFlag" values="Y" id="lgcGrpColFlag" /> 그룹 함수 사용
				</label>
			</div>
		</div>
	</div>

	<div class="form-horizontal grp_col_height" id="tblGrpColList"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="lgCompGrpColConfirmBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="lgcCompGrpColCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	var setMeasureColList = function(colList, grpColFlag) {
		if ($.fn.ifvmIsNotEmpty(colList)) {
			var grpFuncList = $("#tblGrpColList").data("grpFuncList");

			$.each(colList, function(dataIdx, dataObject) {
				var colUseType = dataObject.columnUseType;

				if (colUseType === "MEASURE") {
					var grpFuncTmpl = $("#grpFuncCodeList").tmpl(grpFuncList);

					var colListTmpl = $("#lgcCompGrpColList").tmpl(dataObject);
					$("#tblGrpColList").append(colListTmpl);

					var colMstId = dataObject.columnMstId;
					$("#" + colMstId + "_grpCd").append(grpFuncTmpl);

					var grpFuncTypeCd = dataObject.grpFuncTypeCd;
					if ($.fn.ifvmIsNotEmpty(grpFuncTypeCd)) {
						$("#" + colMstId + "_grpCd").val(grpFuncTypeCd);
					}
				}
			});

			if (!grpColFlag) {
				$("#tblGrpColList").find("select").attr("disabled", true);
				$("#lgcGrpColFlag[value='N']").prop("checked", true);
			} else {
				$("#tblGrpColList").find("select").attr("disabled", false);
				$("#lgcGrpColFlag[value='Y']").prop("checked", true);
			}
		}
	};

	$(document).ready(function() {
		$.ifvSyncPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : "ANL_GROUP_FUNC_TYPE",
			enableNA : false
		}, function(resList) {
			$("#tblGrpColList").data("grpFuncList", resList.rows);
		});

		$("[name='lgcGrpColFlag']").change(function(evt) {
			var val = this.value;

			if (val === "N") {
				$("#tblGrpColList").find("select").attr("disabled", true);
			} else {
				$("#tblGrpColList").find("select").attr("disabled", false);
			}
		});

		$("#lgCompGrpColConfirmBtn").click(function(evt) {
			var tblGrpColList = $("#tblGrpColList").children();

			if (tblGrpColList.length > 0) {
				var lgcGrpColFlag = $("#lgcGrpColFlag:checked").val();

				if (lgcGrpColFlag === "Y") {
					diagram.selectionList[0].addInfo.data.grpColFlag = true;
					var columnList = diagram.selectionList[0].addInfo.data.columnList;

					$.each(tblGrpColList, function(grpColDataIdx, grpColDataObject) {
						var grpFuncTypeCd = $(grpColDataObject).find("[id*='_grpCd']").val();
						var colId = $(grpColDataObject).find("[id*='_colId']").data("colId");

						$.each(columnList, function(colDataIdx, colDataObject) {
							if (colId === colDataObject.columnMstId) {
								colDataObject.grpFuncTypeCd = grpFuncTypeCd;
								return false;
							}
						});
					});

					$(this).closest(".popup_container").data("ejDialog").close();
				} else {
					$.each(columnList, function(colDataIdx, colDataObject) {
						var columnUseType = colDataObject.columnUseType;

						if (columnUseType === "MEASURE") {
							colDataObject.grpFuncTypeCd = null;
						}
					});
				}
			} else {
				$(this).closest(".popup_container").data("ejDialog").close();
			}
		});

		$("#lgcCompGrpColCancelBtn").click(function(evt) {
			$(this).closest(".popup_container").data("ejDialog").close();
		});
	});
</script>

<script id="lgcCompGrpColList" type="text/x-jquery-tmpl">
<div class="row qt_border">
	<div class="col-xs-6 control_content">
		<ifv:inputNew type="select" id="\${columnMstId}_grpCd" />
	</div>
	<div class="col-xs-6 control_content">
		<input type="text" id="\${columnMstId}_colId" data-col-id="\${columnMstId}" data-grp-col-id="\${grpColId}" disabled="true" value="\${columnName}">
	</div>
</div>
</script>

<script id="grpFuncCodeList" type="text/x-jquery-tmpl">
    <option value="\${codeName}">\${markName}</option>
</script>