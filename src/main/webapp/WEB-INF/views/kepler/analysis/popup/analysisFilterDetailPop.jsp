<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var FILTER_DETAIL_CONFIG = {};
	FILTER_DETAIL_CONFIG.FILTER_ID = null;
	FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ID = null;
	FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ALIAS = null;
	FILTER_DETAIL_CONFIG.COLUMN_TYPE_CODE = null;
	FILTER_DETAIL_CONFIG.COLUMN_DATA_TYPE = null;
	FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG = null;
	FILTER_DETAIL_CONFIG.BEFORE_OPERATION_VALUE = null;

	FILTER_DETAIL_CONFIG.GROUP_FUNC_TYPE_LIST = null;
	FILTER_DETAIL_CONFIG.SERC_OPRT_TYPE_LIST = null;

	FILTER_DETAIL_CONFIG.GROUP_FUNC_TYPE = "ANL_GROUP_FUNC_TYPE";
	FILTER_DETAIL_CONFIG.MKT_TARGET_SERC_OPRT_TYPE = "MKT_TARGET_SERC_OPRT_TYPE";
	FILTER_DETAIL_CONFIG.MKT_DT_DEFAULT = "MKT_DT_DEFAULT";

	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE = {};
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.EQUAL = "=";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.NOT_EQUAL = "!=";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.LIKE = "LIKE";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN = "BETWEEN";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.GREATER = ">";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.LESS = "<";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.GREATER_THAN = ">=";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.LESS_THAN = "<=";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.IN = "IN";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.NOT_IN = "NOT IN";
	FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF = "CUSTDTDEF";

	FILTER_DETAIL_CONFIG.BETWEEN_FLAG = false;

	FILTER_DETAIL_CONFIG.TARGET_TAG = null;

	var FILTER_SINGLE_QUTATION = "";
	var groupFuncCheckFlag = false;

	var analysisFilterValueList = null;
	var groupFuncFocusPos = null;

	var getAnalysisFilterDetail = function(filterObj) {
		FILTER_DETAIL_CONFIG.FILTER_ID = filterObj.filterId;
		FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ID = filterObj.atribGroupColumnId;
		FILTER_DETAIL_CONFIG.COLUMN_TYPE_CODE = filterObj.columnTypeCode;
		FILTER_DETAIL_CONFIG.COLUMN_DATA_TYPE = filterObj.columnDataType;
		FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ALIAS = filterObj.atribGroupColumnAlias;
		FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG = filterObj.singleQuoteFlag;

		var groupFuncTypeCode = filterObj.groupFuncTypeCode;
		setAnalysisFilterDetail(!$.fn.ifvmIsNotEmpty(groupFuncTypeCode) ? 0 : 1);
		setAnalysisFilterDetailData(filterObj);
	};

	var setAnalysisFilterDetail = function(targetValue) {
		var groupFuncTypeList = null;
		var filterAreaTemplate = null;

		if (targetValue === 0) {
			// 그룹 함수 미사용 중
			$("#filterTypeCode[value='NON_GROUP_FUNC']").attr("checked", true);
			filterAreaTemplate = $("#groupFilterNonTemplate").tmpl();
			groupFuncCheckFlag = false;
		} else {
			// 그룹 함수 사용 중
			$("#filterTypeCode[value='GROUP_FUNC']").attr("checked", true);
			filterAreaTemplate = $("#groupFilterTemplate").tmpl();
			groupFuncTypeList = $("#analysisOptionTypeCodeTemplate").tmpl(FILTER_DETAIL_CONFIG.GROUP_FUNC_TYPE_LIST);
			groupFuncCheckFlag = true;
		}

		$("#filterArea").append(filterAreaTemplate);

		var sercOperatorTypeList = $("#analysisOptionTypeCodeTemplate").tmpl(FILTER_DETAIL_CONFIG.SERC_OPRT_TYPE_LIST);
		$("#operatorCode").append("<option></option>");
		$("#operatorCode").append(sercOperatorTypeList);
		$("#operatorCode").change(setOperatorCodeChange);

		if ($.fn.ifvmIsNotEmpty(groupFuncTypeList)) {
			$("#groupFuncCode").append("<option></option>");
			$("#groupFuncCode").append(groupFuncTypeList);

			if (FILTER_DETAIL_CONFIG.COLUMN_TYPE_CODE === ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION) {
				$("#groupFuncCode").find("option[value='" + ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.SUM + "']").remove();
				$("#groupFuncCode").find("option[value='" + ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.AVERAGE + "']").remove();
			}

			$("#groupFuncCode").change(function(evt) {
				setAttributeGroupColumnValueList();
			});
		}

		$("#filterArea input[type=text]").focus(function(evt) {
			FILTER_DETAIL_CONFIG.TARGET_TAG = $(this);
		});
	};

	var setAnalysisFilterDetailData = function(targetObj) {
		var operationTypeCode = targetObj.operationTypeCode;
		FILTER_DETAIL_CONFIG.BEFORE_OPERATION_VALUE = operationTypeCode;
		$("#operatorCode").val(operationTypeCode);

		if ($.fn.ifvmIsNotEmpty($("#groupFuncCode"))) {
			$("#groupFuncCode").val(targetObj.groupFuncTypeCode);
		}

		var filterValue = targetObj.filterValue;
		filterValue = filterValue.replace(/\'/g, "");
		if (operationTypeCode === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN) {
			var valueList = filterValue.split("AND");

			filterValue = $.trim(valueList[0]);
			$("#between").show();
			$("#andValue").val($.trim(valueList[1]));
		}

		$("#filterValue").val(filterValue);

		var codeValue = targetObj.codeValue;
		if ($.fn.ifvmIsNotEmpty(codeValue)) {
			$("#codeValue").val(codeValue);
		}
	};

	var setAttributeGroupColumnValueList = function() {
		var groupFuncTypeCodeFlag = $.fn.ifvmIsNotEmpty($("#groupFuncCode").val());
		var operationTypeCode = $("#operatorCode").val();

		if (groupFuncTypeCodeFlag) {
			$.ifvPostJSON("<ifv:action name='getAnalysisColumnList' />", {
				analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
				analysisMasterFlag : "N",
				columnTypeCode : ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION
			}, function(resData) {
				var colNames = new Array();
				var colModel = new Array();

				$.each(resData, function(dataIdx, dataObject) {
					colNames.push(dataObject.columnDisplayName);
					colModel.push({
						name : dataObject.columnAlias,
						index : dataObject.columnAlias,
						align : "center"
					});
				});

				colNames.push("<spring:message code='L00313' />");
				colModel.push({
					name : "colValue",
					index : "colValue",
					align : "center"
				});

				var postData = new Object();
				postData.atribGroupColumnId = FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ID;
				postData.groupFuncTypeCode = groupFuncTypeCodeFlag ? $("#groupFuncCode").val() : null;
				postData.analysisId = ANALYSIS_CONFIG.ANALYSIS_ID;
				postData.pagingFlag = true;

				setAnalysisFilterValueList("<ifv:action name='getAnalysisAtribGroupColumnValueList' />", colNames, colModel, postData);
			});
		} else if ($.fn.ifvmIsEmpty(operationTypeCode) || operationTypeCode !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF) {
			var colNames = new Array();
			colNames.push("<spring:message code='L00313' />");

			var colModel = new Array();
			colModel.push({
				name : "colValue",
				index : "colValue",
				align : "center"
			});

			var postData = new Object();
			postData.atribGroupColumnId = FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ID;
			postData.groupFuncTypeCode = groupFuncTypeCodeFlag ? $("#groupFuncCode").val() : null;
			postData.analysisId = ANALYSIS_CONFIG.ANALYSIS_ID;
			postData.pagingFlag = true;

			setAnalysisFilterValueList("<ifv:action name='getAnalysisAtribGroupColumnValueList' />", colNames, colModel, postData);
		} else {
			var colNames = new Array();
			colNames.push("<spring:message code='M01206' />");
			colNames.push("<spring:message code='M01233' />");
			colNames.push("<spring:message code='M01725' />");

			var colModel = new Array();
			colModel.push({
				name : "codeName",
				index : "codeName",
				hidden : true
			});
			colModel.push({
				name : "markName",
				index : "markName",
				align : "center"
			});
			colModel.push({
				name : "funcValue",
				index : "funcValue",
				align : "center"
			});

			setAnalysisFilterValueList("<ifv:action name='getCommonDateCodeList' />", colNames, colModel, new Object());
		}
	};

	var setAnalysisFilterValueList = function(targetURL, colNames, colModel, postData) {
		var jqGridOption = {
			url : targetURL,
			colNames : colNames,
			colModel : colModel,
			sortname : "1",
			sortorder : "asc",
			multiselect : true,
			tempId : "ifvGridOriginTemplete",
			serializeGridData : function(data) {
				data = $.extend(data, postData);
			}
		};

		analysisFilterValueList = $("#analysisFilterValueList").ifvGrid({
			jqGridOption : jqGridOption
		});
	};

	var setChangeFilterArea = function(targetValue) {
		var groupFuncCode = $("#groupFuncCode").val();

		$("#filterArea").empty();
		setAnalysisFilterDetail(targetValue);

		if (targetValue === 0 && $.fn.ifvmIsNotEmpty(groupFuncCode)) {
			setAttributeGroupColumnValueList();
		}
	};

	var setOperatorCodeChange = function(evt) {
		$("#filterValue").val("");

		var thisValue = $(this).val();
		if (FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN === thisValue) {
			$("#between").show();
		} else {
			$("#between").hide();
		}

		// 이전이 CUSTDEF 인데, thisValue 는 CUSTDEF 가 아닐 때
		// 이전이 CUSTDEF 가 아닌데, thisValue 가 CUSTDEF 일 때
		if ((FILTER_DETAIL_CONFIG.BEFORE_OPERATION_VALUE === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF && thisValue !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF) || (FILTER_DETAIL_CONFIG.BEFORE_OPERATION_VALUE !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF && thisValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF)) {
			FILTER_DETAIL_CONFIG.BEFORE_OPERATION_VALUE = thisValue;
			setAttributeGroupColumnValueList();
		}

		$("#andValue").val("");
		FILTER_DETAIL_CONFIG.BETWEEN_FLAG = false;
	};

	var setSelectField = function() {
		var checkedList = analysisFilterValueList.getCheckedList();
		var operatorValue = $("#operatorCode").val();

		if ($.fn.ifvmIsNotEmpty(checkedList)) {
			// 조건이 IN, NOT IN, BETWEEN 인데 선택한 갯수가 1개 이상이라면 false
			if ((operatorValue !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.IN && operatorValue !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.NOT_IN && operatorValue !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN) && checkedList.length > 1) {
				if (checkedList.length > 2) {
					alert("<spring:message code='M01627' />");
				} else {
					alert("<spring:message code='M01628' />");
				}

				analysisFilterValueList.resetChecked();
			} else {
				setSelectFieldDetail(operatorValue, checkedList);
			}
		} else {
			alert("<spring:message code='M00004' />");
		}
	};

	var setSelectFieldDetail = function(operatorValue, checkedList) {
		var filterObj = null;
		var filterValue = null;
		var targetId = null;

		if (operatorValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF) {
			filterObj = checkedList[0];
			filterValue = filterObj.markName;

			$("#codeValue").val(filterObj.codeName);
			targetId = "filterValue";
		} else if ((operatorValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.IN || operatorValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.NOT_IN)) {
			filterValue = "";

			checkedList.forEach(function(thisObj, idx) {
				if ("Y" !== FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG) {
					filterValue += FILTER_SINGLE_QUTATION + thisObj.colValue + FILTER_SINGLE_QUTATION;
				} else {
					filterValue += thisObj["colValue"];
				}

				if ((idx + 1) !== checkedList.length) {
					filterValue += ", ";
				}
			});

			filterValue = "( " + filterValue + " )";
			targetId = "filterValue";
		} else if (operatorValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN) {
			if (checkedList.length === 1) {
				filterObj = checkedList[0];
				if ("Y" !== FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG) {
					filterValue = FILTER_SINGLE_QUTATION + filterObj.colValue + FILTER_SINGLE_QUTATION;
				} else {
					filterValue = filterObj["colValue"];
				}

				if (FILTER_DETAIL_CONFIG.BETWEEN_FLAG === false) {
					targetId = "filterValue";
					FILTER_DETAIL_CONFIG.BETWEEN_FLAG = true;
				} else {
					targetId = "andValue";
					FILTER_DETAIL_CONFIG.BETWEEN_FLAG = false;
				}
			} else if (checkedList.length === 2) {
				var andObj = checkedList[0];
				var andValue;
				if ("Y" !== FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG) {
					andValue = FILTER_SINGLE_QUTATION + andObj["colValue"] + FILTER_SINGLE_QUTATION;
				} else {
					andValue = andObj["colValue"];
				}

				filterObj = checkedList[1];
				if ("Y" !== FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG) {
					filterValue = FILTER_SINGLE_QUTATION + filterObj["colValue"] + FILTER_SINGLE_QUTATION;
				} else {
					filterValue = filterObj["colValue"];
				}

				// FILTER 값이 AND 값보다 크다면
				if (filterValue > andValue) {
					var tempValue = andValue;
					andValue = filterValue;
					filterValue = tempValue;
				}

				FILTER_DETAIL_CONFIG.TARGET_TAG = $("#filterValue");
				FILTER_DETAIL_CONFIG.BETWEEN_FLAG = false;
				$("#andValue").val(andValue);
			} else {
				alert("<spring:message code='M01629' />");
				analysisFilterValueList.resetChecked();
				return;
			}
		} else if (operatorValue === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.LIKE) {
			filterObj = checkedList[0];

			filterValue = FILTER_SINGLE_QUTATION + "%" + filterObj["colValue"] + "%" + FILTER_SINGLE_QUTATION;
			targetId = "filterValue";
		} else {
			filterObj = checkedList[0];

			if ("Y" !== FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG) {
				filterValue = FILTER_SINGLE_QUTATION + filterObj["colValue"] + FILTER_SINGLE_QUTATION;
			} else {
				filterValue = filterObj["colValue"];
			}

			targetId = "filterValue";
		}

		if ($.fn.ifvmIsNotEmpty(FILTER_DETAIL_CONFIG.TARGET_TAG)) {
			FILTER_DETAIL_CONFIG.TARGET_TAG.val(filterValue);
		} else {
			$("#" + targetId).val(filterValue);
		}
	};

	var getAnalysisFilterDetailCheck = function() {
		var filterValue = $("#filterValue").val();
		var codeValue = $("#codeValue").val();
		var operationTypeCode = $("#operatorCode").val();
		var groupFuncTypeCode = $.fn.ifvmIsNotEmpty($("#groupFuncCode").val()) ? $("#groupFuncCode").val() : null;
		var andValue = $("#andValue");

		if (operationTypeCode !== FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.CUSTDTDEF) {
			filterValue = filterValue.replace(/\'/g, "");
			filterValue = filterValue.replace(/\%/g, "");
			filterValue = filterValue.replace(/\(/g, "");
			filterValue = filterValue.replace(/\)/g, "");

			if (operationTypeCode === FILTER_DETAIL_CONFIG.SERC_OPRT_CODE.BETWEEN) {
				andValue = andValue.val();
				andValue = andValue.replace(/\'/g, "");
				andValue = andValue.replace(/\%/g, "");
				andValue = andValue.replace(/\(/g, "");
				andValue = andValue.replace(/\)/g, "");
			} else {
				andValue = null;
			}
		} else {
			andValue = null;
		}

		var targetObj = {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			logicalCompId : ANALYSIS_CONFIG.LOGICAL_COMP_ID,
			filterId : FILTER_DETAIL_CONFIG.FILTER_ID,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG,
			atribGroupColumnId : FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ID,
			atribGroupColumnAlias : FILTER_DETAIL_CONFIG.ATRIB_GROUP_COLUMN_ALIAS,
			operationTypeCode : operationTypeCode,
			filterValue : filterValue,
			andValue : andValue,
			codeValue : codeValue,
			groupFuncTypeCode : groupFuncTypeCode,
			singleQuoteFlag : FILTER_DETAIL_CONFIG.SINGLE_QUOTE_FLAG
		};

		$.ifvPostJSON("<ifv:action name='getAnalysisFilterCheck' />", targetObj, function(rst) {
			targetObj.filterValue = rst.filterValue;
			targetObj.groupFuncCheckFlag = groupFuncCheckFlag;

			setFilterDetailObj(targetObj);
		}, function(rst) {
			var message = rst.message;
			alert(message);
		});
	};

	$(document).ready(function() {
		$.ifvSyncPostJSON("<ifv:action name='getAnalysisFilterDetailBase' />", {
			groupFuncCode : FILTER_DETAIL_CONFIG.GROUP_FUNC_TYPE,
			sercOperatorCode : FILTER_DETAIL_CONFIG.MKT_TARGET_SERC_OPRT_TYPE
		}, function(rst) {
			// 1-1. 가져온 데이터를 저장한다.
			FILTER_DETAIL_CONFIG.GROUP_FUNC_TYPE_LIST = rst.groupFuncCodeList;
			FILTER_DETAIL_CONFIG.SERC_OPRT_TYPE_LIST = rst.sercOperatorCodeList;
		});

		$("input[name=filterTypeCode]").change(function(evt) {
			var targetIdx = $(this).closest("label").index();
			setChangeFilterArea(targetIdx);
		});

		$("#selectField").click(function(evt) {
			setSelectField();
		});

		$("#cancleField").click(function(evt) {
			analysisFilterValueList.resetChecked();
		});

		$("#analysisFilterDetailCloseBtn").click(function(evt) {
			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_DETAIL_POP).data("ejDialog").close();
		});

		$("#analysisFilterDetailSaveBtn").click(function(evt) {
			var validObj = $("#filterArea").ifvValidation();
			if (validObj.confirm()) {
				getAnalysisFilterDetailCheck();
			}
		});
	});
</script>

<div class="import_form_area pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row">
			<div class="col-xs-12">
				<div class="temp_title">
					<label class="radio-inline">
						<ifv:input type="radio" names="filterTypeCode" values="NON_GROUP_FUNC" checked="true" id="filterTypeCode" />
						<spring:message code="M01478" />
					</label>
					<label class="radio-inline">
						<ifv:input type="radio" names="filterTypeCode" values="GROUP_FUNC" id="filterTypeCode" />
						<spring:message code="M01479" />
					</label>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-4 pr5">
				<div class="left-box-no-border" id="filterArea">
				</div>
			</div>

			<div class="col-xs-8 pl5">
				<div class="right-box-no-border">
					<div class="temp_title">
						<spring:message code="M01476" />
	
						<div class="pop_top_btn">
							<button class="btn_pop_white" id="selectField">
								<img src="<ifv:image name='ico_check' />" alt="">
								<spring:message code="M00282" />
							</button>
		
							<button class="btn_pop_white" id="cancleField">
								<img src="<ifv:image name='btn_delete' />" alt="">
								<spring:message code="M00284" />
							</button>
						</div>
					</div>
	
					<div id="analysisFilterValueList" class="grid_bd0 con_size"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisFilterDetailSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M01320" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisFilterDetailCloseBtn">
		<spring:message code="M01322" />
	</button>
</div>

<script id="groupFilterNonTemplate" type="text/x-jquery-tmpl">
<div class="temp_title">
	<spring:message code="M01232" />
</div>
<div class="group_box_bg2 group_func">
	<div class="row row_bottom">
		<label class="filter_label text-right">
			<spring:message code="M01232" />
		</label>
		<ifv:input type="select" className="filter_input" required="true" id="operatorCode" names="operatorCode" />
	</div>

	<div class="row row_bottom">
		<label class="filter_label text-right">
			<spring:message code="M01233" />
		</label>
		<ifv:input type="hidden" id="codeValue" names="codeValue" />
		<ifv:input type="text" className="long_text" required="true" id="filterValue" names="filterValue" />
	</div>
	<div class="row between" id="between" style="display: none;">
		<label class="filter_label text-right">
			<spring:message code="M01234" />
		</label>
		<ifv:input type="text" className="long_text" id="andValue" names="andValue" />
	</div>
</div>
</script>

<script id="groupFilterTemplate" type="text/x-jquery-tmpl">
<div class="temp_title">
	<spring:message code="M01232" />
</div>
<div class="group_box_bg2 group_func">
	<div class="row row_bottom">
		<label class="filter_label text-right">
			<spring:message code="M01237" />
		</label>
		<ifv:input type="select" className="filter_input" required="true" id="groupFuncCode" names="groupFuncCode" />
	</div>

	<div class="row row_bottom">
		<label class="filter_label text-right">
			<spring:message code="M01463" />
		</label>
		<ifv:input type="hidden" id="codeValue" names="codeValue" />
		<ifv:input type="select" className="filter_input" required="true" id="operatorCode" names="operatorCode" />
	</div>

	<div class="row row_bottom">
		<label class="filter_label text-right">
			<spring:message code="M01233" />
		</label>
		<ifv:input type="text" className="long_text" required="true" id="filterValue" names="filterValue" />
	</div>

	<div class="row between" id="between" style="display: none;">
		<label class="filter_label text-right">
			<spring:message code="M01234" />
		</label>
		<ifv:input type="text" className="long_text" id="andValue" names="andValue" />
	</div>
</div>
</script>