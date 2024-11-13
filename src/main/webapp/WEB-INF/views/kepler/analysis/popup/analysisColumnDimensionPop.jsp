<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var COLUMN_DIMENSION_CONFIG = {};
	COLUMN_DIMENSION_CONFIG.COLUMN_ID = null;
	COLUMN_DIMENSION_CONFIG.COLUMN_DIMENSION_VALUE_LIST = null;
	COLUMN_DIMENSION_CONFIG.THIS_OBJ = null;

	var getAnalysisColumnDimensionDetail = function getAnalysisColumnDimensionDetail(columnId) {
		COLUMN_DIMENSION_CONFIG.COLUMN_ID = columnId;
		$.ifvPostJSON('<ifv:action name="getAnalysisColumnDetail" />', {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnId : COLUMN_DIMENSION_CONFIG.COLUMN_ID,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(resData) {
			COLUMN_DIMENSION_CONFIG.THIS_OBJ = resData;

			$("#orderTypeCode").val(resData.orderTypeCode);
			$("#columnDisplayName").val(resData.columnDisplayName);

			if ($.fn.ifvmIsNotEmpty(resData.combColumnTypeCode)) {
				$("#combColumnTypeCode").val(resData.combColumnTypeCode);
			}

			if ($.fn.ifvmIsNotEmpty(resData.groupFuncTypeCode)) {
				$("input[name='columnTypeFlag'][value='Y']").attr("checked", true);
				$("#dataFomatDiv").show();
				$("#analysisGroupFunc").show();
				$("#dimensionArea").hide();

				$("#groupFuncTypeCode").val(resData.groupFuncTypeCode);
			} else {
				$("input[name='columnTypeFlag'][value='N']").attr("checked", true);
				$("#dataFomatDiv").hide();
				$("#analysisGroupFunc").hide();
				$("#dimensionArea").show();

				$("#groupFuncTypeCode").val("");
			}

			var orderDetailList = resData.orderDetailList;
			if ($.fn.ifvmIsNotEmpty(orderDetailList)) {
				$("#orderDetailArea").show();
				$("input[name='orderDetailFlag'][value='Y']").attr("checked", true);

				setAnalysisColumnDimensionValue(orderDetailList);
			} else {
				$("#orderDetailArea").hide();
				$("input[name='orderDetailFlag'][value='N']").attr("checked", true);
			}

			$("#subTotalFlag").prop("checked", "Y" === resData.subTotalFlag ? true : false);
			$("#negativeFlag").prop("checked", "Y" === resData.negativeFlag ? true : false);
			$("#decimalPlaces").val($.fn.ifvmIsNotEmpty(resData.decimalPlaces) ? resData.decimalPlaces : 0);

			$.ifvPostJSON("<ifv:action name='getAnalysisSameTableColumnList' />", {
				analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
				columnId : COLUMN_DIMENSION_CONFIG.COLUMN_ID,
				analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
			}, function(resData) {
				$("#orderAtribGroupColumnId").append(new Option());

				var tmpl = $("#analysisAtribGroupColumnDimensionTemplate").tmpl(resData);
				$("#orderAtribGroupColumnId").append(tmpl);

				var orderAtribGroupColumnId = COLUMN_DIMENSION_CONFIG.THIS_OBJ.orderAtribGroupColumnId;
				$("#orderAtribGroupColumnId").val(orderAtribGroupColumnId);
			});
		});
	};

	var refreshAnalysisColumnDimensionValue = function(thisOperation, thisBtn) {
		var parentDiv = $(thisBtn).parent("div");
		var cloneDiv = parentDiv.clone(true);

		switch (thisOperation) {
		case "FU":
			$("#orderDetailList").prepend(cloneDiv);
			parentDiv.remove();
			break;

		case "OU":
			if ($.fn.ifvmIsNotEmpty(parentDiv.prev())) {
				parentDiv.prev().before(cloneDiv);
				parentDiv.remove();
			}

			break;

		case "OD":
			if ($.fn.ifvmIsNotEmpty(parentDiv.next())) {
				parentDiv.next().after(cloneDiv);
				parentDiv.remove();
			}
			break;

		case "LD":
			$("#orderDetailList").append(cloneDiv);
			parentDiv.remove();
			break;

		default:
			return false;
		}
	};

	var setAnalysisColumnDimensionValue = function(valueList) {
		COLUMN_DIMENSION_CONFIG.COLUMN_DIMENSION_VALUE_LIST = valueList;

		$("#orderDetailList").empty();
		var tmpl = $("#analysisColumnDimensionValueTemplate").tmpl(valueList);
		$("#orderDetailList").append(tmpl);

		$(".btnDoubleUp").click(function(evt) {
			refreshAnalysisColumnDimensionValue("FU", this);
		});

		$(".btnUp").click(function(evt) {
			refreshAnalysisColumnDimensionValue("OU", this);
		});

		$(".btnDown").click(function(evt) {
			refreshAnalysisColumnDimensionValue("OD", this);
		});

		$(".btnDoubleDown").click(function(evt) {
			refreshAnalysisColumnDimensionValue("LD", this);
		});
	};

	var setAnalysisColumnDimensionDetailSave = function() {
		var tempOrderDetailList = new Array();
		var columnTypeFlag = $("input[name=columnTypeFlag]:checked").val() === "Y";

		if (!columnTypeFlag) {
			var orderAtribGroupColumnId = $("#orderAtribGroupColumnId").val();
			var orderTypeCode = $("#orderTypeCode").val();

			if (($.fn.ifvmIsNotEmpty(orderAtribGroupColumnId) && $.fn.ifvmIsEmpty(orderTypeCode)) || ($.fn.ifvmIsEmpty(orderAtribGroupColumnId) && $.fn.ifvmIsNotEmpty(orderTypeCode))) {
				alert("<spring:message code='M02376' />");
				return false;
			}

			var orderDetailList = $("#orderDetailList").children();
			if ($.fn.ifvmIsNotEmpty(orderDetailList)) {
				$.each(orderDetailList, function(detailIdx, detailObject) {
					var value = $(detailObject).find(".value_info_box").text().trim();

					tempOrderDetailList.push({
						orderIndex : detailIdx,
						orderValue : value
					});
				});
			}
		}

		var thisObject = {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG,
			columnId : COLUMN_DIMENSION_CONFIG.COLUMN_ID,
			columnDisplayName : $("#columnDisplayName").val(),
			subTotalFlag : $("#subTotalFlag").is(":checked") ? "Y" : "N"
		};

		var columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;
		if (columnTypeFlag) {
			columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;

			thisObject = $.extend({
				groupFuncTypeCode : $("#groupFuncTypeCode").val(),
				combColumnTypeCode : ANALYSIS_CONFIG.CHART_TYPE_CD === ANALYSIS_CONFIG.COMBINATION ? $("#combColumnTypeCode").val() : null,
				columnTypeCode : columnTypeCode
			}, thisObject);

			thisObject.negativeFlag = $("#negativeFlag").is(":checked") ? "Y" : "N";

			var decimalPlaces = $("#decimalPlaces").val();
			if ($.fn.ifvmIsNotEmpty(decimalPlaces) && /^[0-9]*$/.test(decimalPlaces)) {
				thisObject.decimalPlaces = decimalPlaces;
			} else {
				alert("소수 자리수는 숫자만 입력 가능합니다.");
				$.ifvProgressControl(false);
				return false;
			}
		} else {
			columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;

			thisObject = $.extend({
				orderAtribGroupColumnId : $("#orderAtribGroupColumnId").val(),
				orderDetailList : tempOrderDetailList,
				orderTypeCode : $("#orderTypeCode").val(),
				columnTypeCode : columnTypeCode
			}, thisObject);
		}

		// 수정 전 Column Type Code 와 현재 Column Type Code 가 다르면 실행
		if (COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnTypeCode !== columnTypeCode) {
			// 현재 수정 중인 컬럼의 아이디를 가진 노드를 삭제
			var columnTree = $("#columnTree").data("ejTreeView");
			columnTree.removeNode(COLUMN_DIMENSION_CONFIG.COLUMN_ID);
			var columnDataSource = $.fn.ifvmIsNotEmpty(columnTree.dataSource()) ? columnTree.dataSource() : new Array();

			var rowTree = $("#rowTree").data("ejTreeView");
			rowTree.removeNode(COLUMN_DIMENSION_CONFIG.COLUMN_ID);
			var rowDataSource = $.fn.ifvmIsNotEmpty(rowTree.dataSource()) ? rowTree.dataSource() : new Array();

			// Measure 의 위치를 체크
			var measureLoc = null;
			var measureIdx = -1;
			var columnUseTypeCode = COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnUseTypeCode;

			$.each(columnDataSource, function(dataIdx, dataObject) {
				if (dataObject.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					measureLoc = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;

					if (dataIdx > measureIdx) {
						measureIdx = dataIdx;
					}
				}
			});

			$.each(rowDataSource, function(dataIdx, dataObject) {
				if (dataObject.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					measureLoc = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;

					if (dataIdx > measureIdx) {
						measureIdx = dataIdx;
					}
				}
			});

			// 수정 후 코드가 Measure 라면
			if (ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE === columnTypeCode) {
				if (measureIdx === -1) {
					if ($.fn.ifvmIsEmpty(measureLoc) || measureLoc === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) {
						measureIdx = columnDataSource.length;
						columnDataSource.push(getParentMeasureNode());
					} else {
						measureIdx = rowDataSource.length;
						rowDataSource.push(getParentMeasureNode());
					}
				} else {
					measureIdx++;
				}

				thisObject.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;

				COLUMN_DIMENSION_CONFIG.THIS_OBJ.parNodeId = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.nodeText = $("#columnDisplayName").val();
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.seq = measureIdx + 1;

				if ($.fn.ifvmIsEmpty(measureLoc) || measureLoc === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) {
					thisObject.columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;
					COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;

					columnDataSource.splice(measureIdx, 0, COLUMN_DIMENSION_CONFIG.THIS_OBJ);
					columnTree.dataSource(columnDataSource);
				} else {
					thisObject.columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;
					COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;

					rowDataSource.splice(measureIdx, 0, COLUMN_DIMENSION_CONFIG.THIS_OBJ);
					rowTree.dataSource(rowDataSource);
				}
			} else {
				var thisDataSource = null;
				var thisTree = null;

				if (measureIdx === -1) {
					columnTree.removeNode(ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE);
					rowTree.removeNode(ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE);
				}

				if (ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN === columnUseTypeCode) {
					thisTree = columnTree;
				} else {
					thisTree = rowTree;
				}
				thisDataSource = thisTree.dataSource();

				thisObject.columnUseTypeCode = columnUseTypeCode;
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnUseTypeCode = columnUseTypeCode;

				thisObject.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;

				COLUMN_DIMENSION_CONFIG.THIS_OBJ.parNodeId = null;
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.nodeText = $("#columnDisplayName").val();
				COLUMN_DIMENSION_CONFIG.THIS_OBJ.seq = thisDataSource.length + 1;
				thisDataSource.push(COLUMN_DIMENSION_CONFIG.THIS_OBJ);

				thisTree.dataSource(thisDataSource);
			}

			columnTree.refresh();
			rowTree.refresh();
		}

		$.ifvPostJSON("<ifv:action name='editAnalysisColumnDetail' />", thisObject, function(resData) {
			setColumnNodeTextUpdate(COLUMN_DIMENSION_CONFIG.COLUMN_ID, $("#columnDisplayName").val());
			setNodeSequence(COLUMN_DIMENSION_CONFIG.THIS_OBJ.columnUseTypeCode);

			delete COLUMN_DIMENSION_CONFIG;

			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_DIMENSION_POP).data("ejDialog").close();
		}, function(resData) {
			alert(resData.message);
		});
	};

	$(document).ready(function() {
		$("#dataFomatDiv").hide();
		$("#orderDetailArea").hide();
		$("#analysisGroupFunc").hide();
		$.fn.ifvmSetSelectOptionCommCode("orderTypeCode", "ANL_ORDER_TYPE_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("groupFuncTypeCode", "ANL_GROUP_FUNC_TYPE", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("combColumnTypeCode", "COMB_COL_TYPE_CD", null, null, false);

		$("#groupFuncTypeCode").find("option[value='" + ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.SUM + "']").remove();
		$("#groupFuncTypeCode").find("option[value='" + ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.AVERAGE + "']").remove();

		if (ANALYSIS_CONFIG.CHART_TYPE_CD !== ANALYSIS_CONFIG.COMBINATION) {
			$("#combColumnTypeDiv").hide();
		}

		$("#orderAtribGroupColumnId").change(function(evt) {
			var orderDetailFlag = $("input[name=orderDetailFlag]:checked").val() === "Y" ? true : false;

			if (orderDetailFlag) {
				var thisValue = this.value;

				if ($.fn.ifvmIsNotEmpty(thisValue)) {
					$.ifvPostJSON("<ifv:action name='getAnalysisAtribGroupColumnValueList' />", {
						atribGroupColumnId : thisValue,
						pagingFlag : false
					}, function(resData) {
						setAnalysisColumnDimensionValue(resData.rows);
					});
				}
			}
		});

		$("input[name=orderDetailFlag]").change(function(evt) {
			var value = this.value;

			if (value === "Y") {
				$("#orderDetailArea").show();
				$("#orderAtribGroupColumnId").trigger("change");
			} else {
				$("#orderDetailArea").hide();
				$("#orderDetailList").empty();
			}
		});

		$("input[name=columnTypeFlag]").change(function(evt) {
			var value = this.value;

			if (value === "Y") {
				$("#dataFomatDiv").show();
				$("#analysisGroupFunc").show();

				$("#dimensionArea").hide();
			} else {
				$("#dataFomatDiv").hide();
				$("#analysisGroupFunc").hide();
				$("#groupFuncTypeCode").val("");

				$("#dimensionArea").show();
			}
		});

		$("#analysisColumnSaveBtn").click(function(evt) {
			setAnalysisColumnDimensionDetailSave();
		});

		$("#analysisColumnCancelBtn").click(function(evt) {
			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_DIMENSION_POP).data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="analysis_setup_prompt form-horizontal temp_title_underline">
		<label class="radio-inline"> <ifv:input type="radio" names="columnTypeFlag" values="N" checked="true" id="columnTypeFlag" /> <spring:message code="M01478" />
		</label> <label class="radio-inline"> <ifv:input type="radio" names="columnTypeFlag" values="Y" id="columnTypeFlag" /> <spring:message code="M01479" />
		</label>
	</div>

	<div id="measureArea">
		<div class="temp_title_bb">
			<spring:message code="M01454" />
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M01231" /></label>
				<div class="col-xs-4 control_content">
					<ifv:input type="text" id="columnDisplayName" names="columnDisplayNames" />
				</div>

				<label class="col-xs-2 control-label text-right">소계 표시</label>
				<div class="col-xs-4 control_content">
					<span class="icheckbox"> <label> <ifv:input type="checkbox" names="subTotalFlag" values="Y" id="subTotalFlag" />
					</label>
					</span>
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal" id="dataFomatDiv">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"> 소수 자리수 </label>
				<ifv:inputNew type="text" id="decimalPlaces" names="decimalPlaces" conClass="4" maxLength="1" minNum="0" values="0" />

				<label class="col-xs-2 control-label text-right">음수 표시</label>
				<div class="col-xs-4 control_content">
					<span class="icheckbox"> <label> <ifv:input type="checkbox" names="negativeFlag" values="Y" id="negativeFlag" />
					</label>
					</span>
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal" id="analysisGroupFunc">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M01624" /></label>
				<div class="col-xs-10 control_content">
					<ifv:input type="select" id="groupFuncTypeCode" names="groupFuncTypeCode" />
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal" id="combColumnTypeDiv">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M01625" /></label>
				<div class="col-xs-10 control_content">
					<ifv:input type="select" id="combColumnTypeCode" names="combColumnTypeCode" />
				</div>
			</div>
		</div>
	</div>

	<div id="dimensionArea">
		<div class="temp_title_bb">정렬 설정</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"></label>
				<div class="col-xs-10 control_content">
					<label class="radio-inline"> <ifv:input type="radio" names="orderDetailFlag" values="N" checked="true" id="orderDetailFlag" /> <spring:message code="M02371" />
					</label> <label class="radio-inline"> <ifv:input type="radio" names="orderDetailFlag" values="Y" id="orderDetailFlag" /> <spring:message code="M02372" />
					</label>
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M02373" /></label>
				<div class="col-xs-10">
					<ifv:input type="select" id="orderAtribGroupColumnId" names="orderAtribGroupColumnId" />
				</div>
			</div>
		</div>

		<div id="orderDetailArea" class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M02374" /></label>
				<div id="orderDetailList" class="col-xs-10 order_box"></div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-2 control-label text-right"><spring:message code="M02375" /></label>
				<div class="col-xs-10">
					<ifv:input type="select" id="orderTypeCode" names="orderTypeCode" />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisColumnSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisColumnCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>

<script id="analysisColumnDimensionValueTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border">
	<button class="common_analysis_btn btnDoubleUp">
		<i class="fa fa-angle-double-up btn_inner_text_font"></i>
	</button>
	<button class="common_analysis_btn btnUp">
		<i class="fa fa-angle-up btn_inner_text_font"></i>
	</button>
	<button class="common_analysis_btn btnDown">
		<i class="fa fa-angle-down btn_inner_text_font"></i>
	</button>
	<button class="common_analysis_btn btnDoubleDown">
		<i class="fa fa-angle-double-down btn_inner_text_font"></i>
	</button>
	<div class="col-xs-8 value_info_box">
		${'${'}}
	</div>
</div>
</script>

<script id="analysisAtribGroupColumnDimensionTemplate" type="text/x-jquery-tmpl">
    <option value="${'${'}orderAtribGroupColumnId}">${'${'}orderDisplayName}</option>
</script>