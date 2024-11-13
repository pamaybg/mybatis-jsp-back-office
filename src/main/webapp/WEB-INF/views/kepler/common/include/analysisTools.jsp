<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	/**
	 * Analytics 테이블/차트 생성 함수
	 *
	 *
	 * */
	$.fn.KPRAnalysisCreateReport = function(targetObj, callbackFunction) {
		$.ifvProgressControl(true);
		var targetId = targetObj.targetId;
		var analysisId = targetObj.analysisId;
		var analysisTypeCode = targetObj.analysisTypeCode;

		if ($.fn.ifvmIsNotEmpty(targetId) && $.fn.ifvmIsNotEmpty(analysisId) && $.fn.ifvmIsNotEmpty(analysisTypeCode)) {
			var analysisMasterFlag = $.fn.ifvmIsNotEmpty(targetObj.analysisMasterFlag) ? targetObj.analysisMasterFlag : "N";
			var previewFlag = $.fn.ifvmIsNotEmpty(targetObj.previewFlag) ? targetObj.previewFlag : "";
			var publishFlag = $.fn.ifvmIsNotEmpty(targetObj.publishFlag) ? targetObj.publishFlag : false;
			var promptDataMap = $.fn.ifvmIsNotEmpty(targetObj.promptDataMap) ? targetObj.promptDataMap : null;
			var fieldGroupColumnId = $.fn.ifvmIsNotEmpty(targetObj.fieldGroupColumnId) ? targetObj.fieldGroupColumnId : null;
			var currentDrillDownGroupList = $.fn.ifvmIsNotEmpty(targetObj.currentDrillDownGroupList) ? targetObj.currentDrillDownGroupList : null;
			var dashboardPromptDataMap = $.fn.ifvmIsNotEmpty(targetObj.dashboardPromptDataMap) ? targetObj.dashboardPromptDataMap : null;

			var externalFlag = $.fn.ifvmIsNotEmpty(targetObj.externalFlag) ? targetObj.externalFlag : false;
			var targetUrl = null;
			if (!externalFlag) {
				targetUrl = "<ifv:action name='getAnalysisPublishReport' />";
			} else {
				targetUrl = "<ifv:action name='getExternalAnalysisPublishReport' />";
			}

			var _targetObj = $.extend({}, targetObj);

			$.ifvPostJSON(targetUrl, {
				analysisId : analysisId,
				analysisMasterFlag : analysisMasterFlag,
				analysisTypeCode : analysisTypeCode,
				publishFlag : publishFlag,
				fieldGroupColumnId : fieldGroupColumnId,
				promptDataMap : promptDataMap,
				currentDrillDownGroupList : currentDrillDownGroupList,
				dashboardPromptDataMap : dashboardPromptDataMap
			}, function(result) {

				result.targetId = targetId;
				result.analysisId = analysisId;
				result.previewFlag = previewFlag;
				result.analysisMasterFlag = analysisMasterFlag;
				result.analysisTypeCode = analysisTypeCode;

				result.callbackFuntion = callbackFunction;

				try {
					if (analysisTypeCode === "CHART") {
						var targetObj = $("#" + targetId);
						result.chartWidth = targetObj.width().toString();
						result.chartHeight = targetObj.height().toString();

						$.fn.KPRAnalysisCreateChart(result);
					} else {
						result.valueCellClick = _targetObj.valueCellClick;

						$.fn.KPRAnalysisCreateTable(result);
					}

					$.ifvProgressControl(false);
					if ($.fn.ifvmIsNotEmpty(callbackFunction)) {
						eval(callbackFunction)(result);
					} else {
						getAnalysisDataDefaultCallback(result);
					}
				} catch (error) {
					alert("<spring:message code='M02463' />".cFormat([ analysisTypeCode ]));
					$.ifvProgressControl(false);

					$("#" + targetId).empty();
				}
			}, function(result) {
				$.ifvProgressControl(false);
				$.messageCheckr(result.message);
			});
		}
	};

	$.fn.KPRAnalysisCreateTable = function(dataObj) {
		if ($.fn.ifvmIsNotEmpty(dataObj)) {
			var thisId = "TABLE_" + dataObj.analysisId + "_" + dataObj.previewFlag;
			var currentTag = $("#" + thisId);
			var targetId = dataObj.targetId;

			if ($.fn.ifvmIsNotEmpty(currentTag)) {
				currentTag.remove();
			}

			currentTag = $("<div />");
			currentTag.attr("id", thisId);
			$("#" + targetId).append(currentTag);

			currentTag.data("analysisData", dataObj);

			var columnNameList = dataObj.columnNameList;
			var rowNameList = dataObj.rowNameList;
			var valueNameList = dataObj.valueNameList;
			var martDataList = dataObj.martDataList;

			if (!$.fn.ifvmIsNotEmpty(martDataList)) {
				dataObj.noDataFlag = true;
				return;
			}

			$.each(valueNameList, function(idx, valueName) {
				$.each(martDataList, function(idx, martData) {
					var value = martData[valueName["fieldName"]];
					if (value == null) {
						martData[valueName["fieldName"]] = 0;
					} else {
						martData[valueName["fieldName"]] = Number(value);
					}
				});
			});

			var measureLoc = dataObj.measureLoc;

			var dataOptions = {
				dataSource : {
					data : martDataList,
					columns : columnNameList,
					rows : rowNameList,
					values : valueNameList
				},
				/**
				 * 2018. 04. 18. 이기오 수정
				 * 기존 - isResponsive : true
				 * */
				isResponsive : false,
				enableToolTip : false,
				/** 20218. 04. 18. 이기오 수정 */
				enableDrillThrough : false,
				enableGrandTotal : true,
				enableColumnGrandTotal : false,
				enableRowGrandTotal : false,
				hyperlinkSettings : {
					enableValueCellHyperlink : true
				},
				renderSuccess : "setTableRenderSuccess",
				valueCellHyperlinkClick : function(args) {
					if ($.fn.ifvmIsNotEmpty(dataObj.valueCellClick)) {
						var valueCellClick = dataObj.valueCellClick;
						args.analysisData = dataObj;

						eval(valueCellClick)(args);
					}
				}
			};

			currentTag.ifvsfPivotGrid(dataOptions);
			currentTag.parent().css("overflow", "auto");
			currentTag.parent().css("height", "");
			currentTag.data("ejWaitingPopup").destroy();

			// 			$(".summary.rgtot:not(.calc)").html("<span style='margin-left: 10px'></span>합계");
			$(".summary.rstot:not(.calc)").each(function(idx, item) {
				item.innerText = item.innerText.replace("Total", "합계");
			});

			// 			$(".summary.cgtot:not(.calc)").html("평균");
			$(".summary.cstot:not(.calc)").each(function(idx, item) {
				item.innerText = item.innerText.replace("Total", "합계");
			});
			
			var colTotalTypeCode = dataObj.colTotalTypeCode;
			if ($.fn.ifvmIsNotEmpty(colTotalTypeCode)) {
				for (var colIdx = 0; colIdx < columnNameList.length; colIdx++) {
					var colNameObject = columnNameList[colIdx];
					if (colNameObject.fieldName !== "MEASURE" && colIdx < columnNameList.length) {
						if (colNameObject.showSubTotal) {
							var lastTotalList = currentTag.find("[p$='," + colIdx + "']");
							var prevLastTotal = lastTotalList[lastTotalList.length - 2];
							var lastTotal = lastTotalList[lastTotalList.length - 1];
							
							var colSpan = lastTotal.getAttribute("colspan");
							var posY = lastTotal.getAttribute("p").split(",")[0];
							posY = parseInt(posY, 0);
							
							var prevColSpan = prevLastTotal.getAttribute("colspan");
							var prevPosY = prevLastTotal.getAttribute("p").split(",")[0];
							prevPosY = parseInt(prevPosY, 10);
							
							for (var idx = 0; idx < colSpan; idx++) {
								currentTag.find("[p^='" + (posY + idx) + ",']").remove();
							}

							for (var idx = 0; idx < colIdx; idx++) {
								var curColSpan = currentTag.find("[p^='" + (prevPosY + idx) + "']").attr("colSpan");
								currentTag.find("[p^='" + (prevPosY + idx) + "," + idx + "']").attr("colSpan", curColSpan - colSpan);
							}
							
							if (colIdx === 0) {
								for (var idx = 0; idx < (prevColSpan + 1); idx++) {
									currentTag.find("[p^='" + (prevPosY + idx) + "']").addClass("summary");
								}
							}
						}
					} else {
						break;
					}
				}
			}

			var rowTotalTypeCode = dataObj.rowTotalTypeCode;
			if ($.fn.ifvmIsNotEmpty(rowTotalTypeCode)) {
				for (var rowIdx = 0; rowIdx < rowNameList.length; rowIdx++) {
					var rowNameObject = rowNameList[rowIdx];
					var lastTotalList = currentTag.find("[p^='" + rowIdx + ",']");
					var prevLastTotal = lastTotalList[lastTotalList.length - 2];

					if (rowNameObject.fieldName !== "MEASURE" && rowIdx < (rowNameList.length - 1)) {
						if (rowNameObject.showSubTotal) {
							if (rowNameList.length > 1) {
								var posX = prevLastTotal.getAttribute("p").split(",")[1];

								for (var posIdx = 0; posIdx < rowIdx; posIdx++) {
									var rowSpan = currentTag.find("[p^='" + posIdx + "," + posX + "']").attr("rowspan");
									currentTag.find("[p^='" + posIdx + "," + posX + "']").attr("rowspan", rowSpan - 1);
								}
							}

							$(lastTotalList[lastTotalList.length - 1].parentElement).remove();
						}
					} else {
						break;
					}
				}
				
				if (rowNameList[0].fieldName !== "MEASURE") {
					var parentTotal = currentTag.find("[p^='0,']").last().parent();
					while($.fn.ifvmIsNotEmpty(parentTotal)) {
						parentTotal.find(".value").addClass("summary");
						
						parentTotal = parentTotal.next();
					}
				}
			}
		}
	};

	var setTableRenderSuccess = function(args) {
		var dataList = args.getJSONRecords();
		for (var dataIdx = 0; dataIdx < dataList.length; dataIdx++) {
			var data = dataList[dataIdx];
			var dataCss = data.CSS.toUpperCase();

			if ((dataCss === "VALUE" || dataCss.indexOf("SUMMARY") > -1) && dataCss !== "NONE" && data.Value === "") {
				data.Value = "0";
			}

			if (dataCss === "VALUE" || dataCss.indexOf("SUMMARY") > -1) {
				var dataValue = data.Value;

				if (dataCss.indexOf("SUMMARY") > -1) {
					if (/[.]/i.test(dataValue)) {
						dataValue = dataValue.toFixed(2);
					}
				}

				data.Value = $.ifvNumberFormat(dataValue);
			}
		}

		this.renderControlFromJSON();

		var thisElement = args.element;
		var analysisData = thisElement.data("analysisData");
		var valueNameList = analysisData.valueNameList;
		if (valueNameList.length === 1 && valueNameList[0].fieldName === "VALUE") {
			thisElement.find("thead tr:last").css("display", "none");
			var rowSpan = thisElement.find("thead tr:first th:first").attr("rowSpan");
			thisElement.find("thead tr:first th:first").attr("rowSpan", rowSpan - 1);
		}

		thisElement.find("tr[style*='display: none'], th[style*='display: none'], td[style*='display: none']").remove();
	};

	$.fn.KPRAnalysisCreateChart = function(dataObj) {
		if ($.fn.ifvmIsNotEmpty(dataObj)) {
			var thisId = "CHART_" + dataObj.analysisId + "_" + dataObj.previewFlag;
			var currentTag = $("#" + thisId);
			var targetId = dataObj.targetId;

			if ($.fn.ifvmIsNotEmpty(currentTag)) {
				currentTag.remove();
			}

			currentTag = $("<div />");
			currentTag.attr("id", thisId);
			$("#" + targetId).append(currentTag);

			currentTag.data("analysisData", dataObj);

			var columnNameList = dataObj.columnNameList;
			var rowNameList = dataObj.rowNameList;
			var valueNameList = dataObj.valueNameList;
			var martDataList = dataObj.martDataList;

			if (!$.fn.ifvmIsNotEmpty(martDataList)) {
				dataObj.noDataFlag = true;
				return;
			}

			var measureList = dataObj.measureList;

			var chartInformation = dataObj.chartInformation;
			var chartTypeCode = chartInformation.chartTypeCode;

			var is3DChart = (chartInformation != null && chartInformation.chartTypeAttrib02 != null) ? (chartInformation.chartTypeAttrib02 === '3D') : false;

			// 3D 차트인 경우
			if (is3DChart == true) {
				chartTypeCode = chartTypeCode.replace("_3D", "");
				chartInformation.chartTypeCode = chartTypeCode;
				currentTag.data("is3DChart", true);
			}

			var chartLeftLabelTypeCode = chartInformation.chartLeftLabelTypeCode;
			var chartRightLabelTypeCode = chartInformation.chartRightLabelTypeCode;

			$.each(martDataList, function(martDataIdx, martData) {
				var columnValue = $.fn.ifvmIsNotEmpty(martData["columnValue"]) ? martData["columnValue"] : "";
				var rowValue = $.fn.ifvmIsNotEmpty(martData["rowValue"]) ? martData["rowValue"] : "";

				$.each(measureList, function(measureIdx, measureDto) {
					var columnDisplayName = measureDto.columnDisplayName;

					var correctionValue = 1;
					if (chartTypeCode === "COMBINATION") {
						var combColumnTypeCode = measureDto.combColumnTypeCode;

						if ((chartLeftLabelTypeCode === "PERCENTAGE" && combColumnTypeCode === "COLUMN") || (chartRightLabelTypeCode === "PERCENTAGE" && combColumnTypeCode === "LINE")) {
							correctionValue = 100;
						} else {
							correctionValue = 1;
						}
					} else if (!(chartTypeCode === "PIE" || chartTypeCode === "DOUGHNUT") && chartLeftLabelTypeCode === "PERCENTAGE") {
						correctionValue = 100;
					} else {
						correctionValue = 1;
					}

					if (columnValue.indexOf(columnDisplayName) > -1 || rowValue.indexOf(columnDisplayName) > -1) {
						$.each(valueNameList, function(valueNameIdx, valueNameData) {
							var martDataValue = martData[valueNameData["fieldName"]] * correctionValue;
							martDataValue = martDataValue.toFixed(2);
							martData[valueNameData["fieldName"]] = Number(martDataValue);
						});
					} else {
						var martDataValue = martData[columnDisplayName] * correctionValue;
						martDataValue = martDataValue.toFixed(2);
						martData[columnDisplayName] = Number(martDataValue);
					}
				});
			});

			var legendPositionTypeCode = chartInformation.chartLegendPositionTypeCode;
			var legendVisibleFlag = null;
			if ($.fn.ifvmIsNotEmpty(legendPositionTypeCode)) {
				if (legendPositionTypeCode !== "NONE") {
					legendVisibleFlag = true;
				} else {
					legendVisibleFlag = false;
				}
			} else {
				legendVisibleFlag = true;
				legendPositionTypeCode = "BOTTOM";
			}

			var chartLeftVerticalName = $.fn.ifvmIsNotEmpty(chartInformation.chartLeftVerticalName) ? chartInformation.chartLeftVerticalName : "";
			var chartHorizontalName = $.fn.ifvmIsNotEmpty(chartInformation.chartHrizontalName) ? chartInformation.chartHrizontalName : "";

			var dataOptions = {
				dataSource : {
					data : martDataList,
					columns : columnNameList,
					rows : rowNameList,
					values : valueNameList
				},
				commonSeriesOptions : {
					enableAnimation : true,
					tooltip : {
						visible : true,
						fill : "#FFFFFF",
						font : {
							color : "#000000"
						},
						border : {
							width : 1,
							color : "#000000"
						}
					},
					type : chartTypeCode === "COMBINATION" ? "COLUMN" : chartTypeCode,
					marker : {
						shape : "CIRCLE",
						visible : true,
						size : {
							width : 5,
							height : 5
						},
						border : {
							width : 1,
							color : "WHITE"
						},
						/*
						dataLabel : {
							visible : false,
							shape : "NONE",
							connectorLine : {
								type : "BEZIER",
								color : "BLACK"
							}
						}*/
						dataLabel : {
							font : {
								size : '9px',
								fontFamily : 'Malgun Gothic',
								fontStyle : 'Normal',
								fontWeight : 'regular'
							},
							textPosition : 'top',

							visible : true,
							enableContrastColor : true
						}
					}
				},
				legend : {
					visible : legendVisibleFlag,
					position : legendPositionTypeCode
				},
				primaryXAxis : {
					labelRotation : -45,
					name : "horizontalAxis",
					title : {
						visible : true,
						text : chartHorizontalName,
						font : {
							size : "10px"
						}
					}
				},
				primaryYAxis : {
					name : "leftVerticalAxis",
					labelFormat : "n0",
					title : {
						visible : true,
						text : chartLeftVerticalName,
						font : {
							size : "10px"
						}
					}
				},
				preRender : "setChartPreRender",
				seriesRendering : "setSeriesRendering",
				axesLabelRendering : "setAxesLabelRendering",
				displayTextRendering : "setDisplayTextRendering",
				toolTipInitialize : "setChartTooltipInitialize",
				pointRegionClick : "setChartPointRegionClick"
			};

			if (chartTypeCode === "PIE" || chartTypeCode === "DOUGHNUT") {
				dataOptions.commonSeriesOptions.marker.dataLabel.visible = true;

				dataOptions.commonSeriesOptions.labelPosition = "outsideExtended";
				dataOptions.commonSeriesOptions.enableSmartLabels = true;
			}

			var chartWidth = dataObj.chartWidth;
			var chartHeight = dataObj.chartHeight;

			if (!($.fn.ifvmIsNotEmpty(chartWidth) && $.fn.ifvmIsNotEmpty(chartHeight))) {
				chartWidth = currentTag.parent().width() !== 0 ? currentTag.parent().width() : "0";
				chartHeight = currentTag.parent().height() !== 0 ? currentTag.parent().height() : "0";
			}

			dataOptions.size = {
				width : chartWidth + "px",
				height : chartHeight + "px"
			};

			currentTag.ifvsfPivotChart(dataOptions);
			currentTag.data("ejWaitingPopup").destroy();
			setChartChildrenData(thisId);

			setDrillDownMenu(currentTag, dataObj);

			// 3D 차트 옵션 추가
			// 			set3DChartOption(thisId, is3DChart);
		}
	};

	var setChartChildrenData = function(thisId) {
		$("#" + thisId).data("renderingFlag", true);

		var chartChildData = $("#" + thisId).children().data("ejChart");
		chartChildData.zoomed = true;
		chartChildData.resetZoom();

		$("#" + thisId).removeData("renderingFlag");
	};

	/**
	 * 3D 차트 옵션 추가
	 *  ( 사용자가 3D 차트를 선택했을 때에 동작 )
	 *
	 * @date 2017. 8. 1.
	 * @author jh.kim
	 * @param thisId
	 * @param chart3D 3D차트 선택 여부
	 * @returns
	 */
	// 	var set3DChartOption = function(thisId, is3DChart) {
	// 		if (is3DChart == true) {
	// 			$("#" + thisId).children().data("ejChart").setModel({
	// 				dataOption : {
	// 					enable3D : true						// 3D 차트 활성화
	// 					, enableRotation : true				// 차트 회전 가능
	// 					, rotation : 20						// 차트 회전 각도
	// 					, sideBySideSeriesPlacement : true	// 데이터 출력 방향
	// 				}
	// 			});
	// 		}
	// 	}
	var setChartPreRender = function(args) {
		var thisElement = this.element;
		var renderingFlag = thisElement.parent().data("renderingFlag");

		if ($.fn.ifvmIsEmpty(renderingFlag)) {
			var analysisData = thisElement.parent().data("analysisData");
			var measureList = analysisData.measureList;
			var measureListFlag = $.fn.ifvmIsNotEmpty(measureList);

			var chartInformation = analysisData.chartInformation;
			var chartTypeCode = chartInformation.chartTypeCode;

			var chartLeftLabelTypeCode = chartInformation.chartLeftLabelTypeCode;
			var chartRightLabelTypeCode = chartInformation.chartRightLabelTypeCode;

			var thisModel = this.model;
			var seriesList = thisModel.series;

			$.each(seriesList, function(seriesIdx, seriesData) {
				var seriesName = seriesData.name;
				seriesData.opacity = 0.75;
				seriesData.border = {
					width : 1,
					color : "WHITE"
				};

				var seriesNameList = seriesName.split(" - ");
				if (measureListFlag && chartTypeCode === "COMBINATION") {
					var axesAddFlag = false;
					$.each(measureList, function(measureIdx, measureDto) {
						var columnDisplayName = measureDto.columnDisplayName;

						var seriesNameFlag = false;
						$.each(seriesNameList, function(seriesNameIdx, seriesName) {
							if (seriesName === columnDisplayName) {
								seriesNameFlag = true;
								return false;
							}
						});

						if (seriesNameFlag) {
							var combColumnTypeCode = seriesData.type = measureDto.combColumnTypeCode;

							if (combColumnTypeCode === "COLUMN") {
								seriesData.yAxisName = "leftVerticalAxis";
							} else {
								axesAddFlag = true;
								seriesData.yAxisName = "rightVerticalAxis";
							}

							return false;
						}
					});

					if (axesAddFlag === true) {
						var chartRightVerticalName = chartInformation.chartRightVerticalName;
						var axesData = {
							majorGridLines : {
								visible : false
							},
							orientation : "VERTICAL",
							opposedPosition : true,
							axisLine : {
								visible : false
							},
							rangePadding : "NORMAL",
							name : "rightVerticalAxis"
						};

						if ($.fn.ifvmIsNotEmpty(chartRightVerticalName)) {
							axesData.title = {
								visible : true,
								text : chartRightVerticalName,
								font : {
									size : "10px"
								}
							};
						}

						thisModel.axes = [ axesData ];
					}
				}
			});

			// 2017. 09. 05. 이기오
			// set3DChartOption 을 호출하여 처리 시
			// PreRender 함수가 한번 더 호출하기 때문에 여기서 처리하는 방식으로 수정
			var is3DChart = thisElement.parent().data("is3DChart");
			if (is3DChart) {
				thisModel.enable3D = true;
				thisModel.enableRotation = true;
				thisModel.rotation = 30;
				thisModel.sideBySideSeriesPlacement = true;

				thisModel.loaded = "setChartLoaded";
				// 				thisModel.chartMouseMove = "setChartMouseMove";
			}
		}
	};

	var setSeriesRendering = function(args) {
		// 차트 조건 색상을 지정할 때 사용
	};

	// 가로, 세로 축 LABEL 설정.
	// 해당 폰트 설정은 이 부분에서 처리하시면 됩니다.
	var setAxesLabelRendering = function(args) {
		var renderingFlag = this.element.data("renderingFlag");
		var resizeFlag = this.element.parent().data("resizeFlag");

		var setFont_leftVerticalAxis = false;
		var setFont_rightVerticalAxis = false;
		var setFont_horizontalAxis = false;

		if ($.fn.ifvmIsNotEmpty(renderingFlag) || $.fn.ifvmIsEmpty(resizeFlag)) {
			var analysisData = this.element.data("analysisData");
			var chartInformation = analysisData.chartInformation;
			var chartTypeCode = chartInformation.chartTypeCode;
			chartTypeCode = chartTypeCode.replace("_3D", "");

			var thisText = args.data.label.Text;
			var thisAxis = args.data.axis.name;

			args.data.axis.font.size = "10px";

			if (thisAxis === "leftVerticalAxis") {
				if (setFont_leftVerticalAxis == false) {
					var chartFontInfo = chartInformation.chartLabelFontInfo.V1;
					if ($.fn.ifvmIsNotEmpty(chartFontInfo)) {
						// 폰트 타입 설정
						var fontType = chartFontInfo.fontTypeAttrib01;
						if ($.fn.ifvmIsNotEmpty(fontType)) {
							args.data.axis.title.font.fontFamily = fontType;
						}

						// 폰트 스타일 설정
						var fontStyle01 = chartFontInfo.fontStyleAttrib01;
						var fontStyle02 = chartFontInfo.fontStyleAttrib02;
						if ($.fn.ifvmIsNotEmpty(fontStyle01) && $.fn.ifvmIsNotEmpty(fontStyle02)) {
							args.data.axis.title.font.fontWeight = fontStyle01;
							args.data.axis.title.font.fontStyle = fontStyle02;
						}

						args.data.axis.title.font.color = chartFontInfo.fontColor;
						args.data.axis.title.font.size = chartFontInfo.fontSize + "px";
						setFont_leftVerticalAxis = true;
					}
				}

				// 100% Stacked Bar / 100% Stacked Column 일 경우 처리하지 않음.
				if (chartTypeCode.indexOf("100") === -1) {
					var chartLeftLabelTypeCode = chartInformation.chartLeftLabelTypeCode;
					var chartLeftLabelPrefix = chartInformation.chartLeftLabelPrefix;
					var chartLeftLabelSuffix = chartInformation.chartLeftLabelSuffix;

					if (chartLeftLabelTypeCode !== "DEFAULT" && chartLeftLabelTypeCode !== "PERCENTAGE") {
						thisText = isNaN(thisText) ? $.ifvStringFormat(thisText) : thisText;
						
						thisText = thisText / chartInformation.chartLeftLabelValue;
						thisText = $.ifvNumberFormat(thisText);
						thisText = thisText + chartLeftLabelTypeCode;
					} else {
						thisText = isNaN(thisText) ? $.ifvStringFormat(thisText) : thisText;
						
						thisText = $.ifvNumberFormat(thisText);
					}

					if ($.fn.ifvmIsNotEmpty(chartLeftLabelPrefix)) {
						thisText = chartLeftLabelPrefix + thisText;
					}

					if ($.fn.ifvmIsNotEmpty(chartLeftLabelSuffix)) {
						thisText = thisText + chartLeftLabelSuffix;
					}
				}
			} else if (thisAxis === "rightVerticalAxis") {
				if (setFont_rightVerticalAxis == false) {
					var chartFontInfo = chartInformation.chartLabelFontInfo.V2;
					if ($.fn.ifvmIsNotEmpty(chartFontInfo)) {
						// 폰트 타입 설정
						var fontType = chartFontInfo.fontTypeAttrib01;
						if ($.fn.ifvmIsNotEmpty(fontType)) {
							args.data.axis.title.font.fontFamily = fontType;
						}

						// 폰트 스타일 설정
						var fontStyle01 = chartFontInfo.fontStyleAttrib01;
						var fontStyle02 = chartFontInfo.fontStyleAttrib02;
						if ($.fn.ifvmIsNotEmpty(fontStyle01) && $.fn.ifvmIsNotEmpty(fontStyle02)) {
							args.data.axis.title.font.fontWeight = fontStyle01;
							args.data.axis.title.font.fontStyle = fontStyle02;
						}

						args.data.axis.title.font.color = chartFontInfo.fontColor;
						args.data.axis.title.font.size = chartFontInfo.fontSize + "px";
						setFont_rightVerticalAxis = true;
					}
				}

				// 100% Stacked Bar / 100% Stacked Column 일 경우 처리하지 않음.
				if (chartTypeCode.indexOf("100") === -1) {
					var chartRightLabelTypeCode = chartInformation.chartRightLabelTypeCode;
					var chartRightLabelPrefix = chartInformation.chartRightLabelPrefix;
					var chartRightLabelSuffix = chartInformation.chartRightLabelSuffix;

					if (chartRightLabelTypeCode !== "DEFAULT" && chartRightLabelTypeCode !== "PERCENTAGE") {
						thisText = isNaN(thisText) ? $.ifvStringFormat(thisText) : thisText;
						
						thisText = thisText / chartInformation.chartRightLabelValue;
						thisText = $.ifvNumberFormat(thisText);
						thisText = thisText + chartRightLabelTypeCode;
					} else {
						thisText = isNaN(thisText) ? $.ifvStringFormat(thisText) : thisText;
						
						thisText = $.ifvNumberFormat(thisText);
					}

					if ($.fn.ifvmIsNotEmpty(chartRightLabelPrefix)) {
						thisText = chartRightLabelPrefix + thisText;
					}

					if ($.fn.ifvmIsNotEmpty(chartRightLabelSuffix)) {
						thisText = thisText + chartRightLabelSuffix;
					}
				}
			} else {
				if (thisText.length > 10) {
					thisText = thisText.substring(0, 10) + "...";
				}

				if (setFont_horizontalAxis == false) {
					var chartFontInfo = chartInformation.chartLabelFontInfo.H;
					if ($.fn.ifvmIsNotEmpty(chartFontInfo)) {
						// 폰트 타입 설정
						var fontType = chartFontInfo.fontTypeAttrib01;
						if ($.fn.ifvmIsNotEmpty(fontType)) {
							args.data.axis.title.font.fontFamily = fontType;
						}

						// 폰트 스타일 설정
						var fontStyle01 = chartFontInfo.fontStyleAttrib01;
						var fontStyle02 = chartFontInfo.fontStyleAttrib02;
						if ($.fn.ifvmIsNotEmpty(fontStyle01) && $.fn.ifvmIsNotEmpty(fontStyle02)) {
							args.data.axis.title.font.fontWeight = fontStyle01;
							args.data.axis.title.font.fontStyle = fontStyle02;
						}

						args.data.axis.title.font.color = chartFontInfo.fontColor;
						args.data.axis.title.font.size = chartFontInfo.fontSize + "px";
						setFont_horizontalAxis = true;
					}
				}
			}
			args.data.label.Text = thisText;
		}
	};

	// PIE, DOUGHT 일 경우 LABEL 설정.
	var setDisplayTextRendering = function(args) {
		var parentElement = this.element.parent();
		var renderingFlag = parentElement.data("renderingFlag");

		if ($.fn.ifvmIsEmpty(renderingFlag)) {
			var analysisData = parentElement.data("analysisData");
			var chartInformation = analysisData.chartInformation;
			var chartTypeCode = chartInformation.chartTypeCode;

			if (chartTypeCode === "PIE" || chartTypeCode === "DOUGHNUT") {
				var chartDisplayTypeCode = chartInformation.chartDisplayTypeCode;
				var pointIdx = args.data.pointIndex;
				var seriesObj = args.data.series;

				var pointObj = seriesObj.visiblePoints[pointIdx];
				var pointX = pointObj.x;
				var pointY = pointObj.y;
				var text = "";

				if (chartDisplayTypeCode !== "NM") {
					var chartLeftLabelTypeCode = chartInformation.chartLeftLabelTypeCode;
					var chartLeftLabelPrefix = chartInformation.chartLeftLabelPrefix;
					var chartLeftLabelSuffix = chartInformation.chartLeftLabelSuffix;

					if (chartLeftLabelTypeCode === "PERCENTAGE") {
						var startAngle = pointObj.start;
						var endAngle = pointObj.end;
						var degreeValue = (endAngle - startAngle) * 180 / Math.PI / 360 * 100;

						pointY = degreeValue.toFixed(2);
						pointY = $.ifvNumberFormat(pointY);
					} else if (chartLeftLabelTypeCode !== "DEFAULT") {
						pointY = pointY / chartInformation.chartLeftLabelValue;
						pointY = $.ifvNumberFormat(pointY);
						pointY = pointY + chartLeftLabelTypeCode;
					} else {
						pointY = $.ifvNumberFormat(pointY);
					}

					if ($.fn.ifvmIsNotEmpty(chartLeftLabelPrefix)) {
						pointY = chartLeftLabelPrefix + pointY;
					}

					if ($.fn.ifvmIsNotEmpty(chartLeftLabelSuffix)) {
						pointY = pointY + chartLeftLabelSuffix;
					}
				}

				if (chartDisplayTypeCode === "NM") {
					text = pointX;
				} else if (chartDisplayTypeCode === "VAL") {
					text = pointY;
				} else {
					text = pointX + ", " + pointY;
				}

				seriesObj.dataSource[pointIdx].text = text;
			}
		}
	};

	var setChartTooltipInitialize = function(args) {
		var seriesIdx = args.data.seriesIndex;
		var pointIdx = args.data.pointIndex;

		var seriesObj = args.model.series[seriesIdx];
		var pointObj = seriesObj.points[pointIdx];

		var tooltipText = "";
		tooltipText += "Column : " + seriesObj.name + "<br />";
		tooltipText += "Row : " + pointObj.x + "<br />";
		tooltipText += "Value : " + $.ifvNumberFormat(pointObj.y);

		args.data.currentText = tooltipText;
	};

	var setChartLoaded = function(args) {
		setChartXAxisLabelRotation(this.element);
	};

	// 3D Chart 일 시, Label Rotation 처리 함수
	var setChartXAxisLabelRotation = function($this) {
		var $thisParent = $this.parent();
		var renderingFlag = $thisParent.data("renderingFlag");
		var is3DChart = $thisParent.data("is3DChart");

		if ($.fn.ifvmIsNotEmpty(renderingFlag) && is3DChart) {
			var analyticsData = $thisParent.data("analysisData");
			var chartTypeCode = analyticsData.chartInformation.chartTypeCode;

			var thisId = $this.attr("id");
			var moveFlag = true;
			if (chartTypeCode.indexOf("BAR") > -1) {
				var targetId = thisId + "_svgvertical";
				moveFlag = false;
			} else {
				var targetId = thisId + "_svghorizontal";
			}

			var targetList = $this.find("text[id^='" + targetId + "']");
			$.each(targetList, function(targetIdx, target) {
				var $target = $(target);
				var posX = Number($target.attr("x"));
				var posY = Number($target.attr("y"));

				if (moveFlag) {
					posX = posX + 15;
				}

				var rotate = "rotate(-45, " + posX + ", " + posY + ")";
				$(target).attr("transform", rotate);
			});
		}
	};

	// 차트 Point 클릭 시 실행 함수
	// Drill Down Group 처리
	var setChartPointRegionClick = function(args) {
		var mousePos = $(this.element).data("mousePos");
		var menuId = $(this.element).data("analysisContextMenuId");

		var seriesIdx = args.data.region.SeriesIndex;
		var pointsIdx = args.data.region.Region.PointIndex;

		$(this.element).data("drillDownGroupTargetData", {
			seriesIdx : seriesIdx,
			pointsIdx : pointsIdx
		});

		$("#" + menuId).data("ejMenu").show(mousePos.posX, mousePos.posY, this.element);
	};

	var setDrillDownMenu = function(currentTag, analysisData) {
		var metaDrillDownGroupList = analysisData.metaDrillDownGroupList;
		var metaDrillDownGroupListFlag = $.fn.ifvmIsNotEmpty(metaDrillDownGroupList);

		if (metaDrillDownGroupListFlag) {
			currentTag.mousemove(function(evt) {
				$(this).data("mousePos", {
					posX : evt.clientX,
					posY : evt.clientY
				});
			});

			var currentDrillDownGroupList = analysisData.currentDrillDownGroupList;

			var currentDrillDownGroupId = null;
			var currentDrillDownGroup = $.fn.ifvmIsNotEmpty(currentDrillDownGroupList) ? currentDrillDownGroupList[currentDrillDownGroupList.length - 1] : null;
			if (currentDrillDownGroup != null) {
				currentDrillDownGroupId = currentDrillDownGroup.levelColumnId;
			} else {
				currentDrillDownGroupId = metaDrillDownGroupList[0].columnId;
			}

			var thisId = currentTag.attr("id");
			var menuId = thisId + "_menu";
			var menuTag = $("#" + menuId);
			if ($.fn.ifvmIsNotEmpty(menuTag)) {
				menuTag.remove();
			}
			menuTag = $("<ul id='" + menuId + "' class='right_mou_list' />");

			var drillDownGroupId = null;
			$.each(metaDrillDownGroupList, function(dataIdx, dataObject) {
				if (dataObject.lowerColumnId === currentDrillDownGroupId || dataObject.upperColumnId === currentDrillDownGroupId) {
					var thisText = dataObject.drillDownGroupName + " (" + dataObject.columnDisplayName + ")";
					var liTag = null;

					var relativeValue = null;
					var liTagStr = "<li";

					if (drillDownGroupId !== null && drillDownGroupId !== dataObject.drillDownGroupId) {
						liTagStr += " style='border-top:1px dashed #c8c8c8;'";
					}
					drillDownGroupId = dataObject.drillDownGroupId;

					liTagStr += "><a>";
					if (dataObject.lowerColumnId === currentDrillDownGroupId) {
						relativeValue = true;
						liTagStr += "<i class='fa fa-arrow-up'></i> ";
					}

					if (dataObject.upperColumnId === currentDrillDownGroupId) {
						relativeValue = false;
						liTagStr += "<i class='fa fa-arrow-down'></i> ";
					}
					liTagStr += thisText + "</a></li>";
					liTag = $(liTagStr);
					liTag.data("drillDownGroupData", dataObject);
					liTag.data("relativeValue", relativeValue);

					menuTag.append(liTag);
				}
			});

			menuTag.append("<li id='" + (menuId + "_exit") + "' style='border-top:1px solid #c8c8c8;'><a>닫기</a></li>");

			$("body").append(menuTag);
			currentTag.data("analysisContextMenuId", menuId);

			menuTag.data("targetId", currentTag.attr("id"));
			menuTag.ifvsfContextMenu({
				menuType : ej.MenuType.ContextMenu,
				openOnClick : false,
				click : "analysisContextMenuClick"
			});
		}
	};

	var analysisContextMenuClick = function(args) {
		// ID가 존재하면 닫기 버튼을 클릭한 것이므로 실행하지 않는다.
		var thisId = args.ID;
		if ($.fn.ifvmIsEmpty(thisId)) {
			var relativeValue = $(args.element).data("relativeValue");
			var thisDrillDownGroupData = $(args.element).data("drillDownGroupData");
			var columnAlias = thisDrillDownGroupData.columnAlias;

			var targetId = $(this.element).data("targetId");
			var target = $("#" + targetId);

			var analysisData = target.data("analysisData");
			var currentDrillDownGroupList = analysisData.currentDrillDownGroupList;

			if ($.fn.ifvmIsEmpty(currentDrillDownGroupList)) {
				currentDrillDownGroupList = new Array();
			}

			// Down 일 경우 실제 데이터를 찾아야함.
			if (!relativeValue) {
				var originAnalysisData = analysisData.analysisDataMap;
				var metaDrillDownGroupList = analysisData.metaDrillDownGroupList;

				var drillDownGroupTargetData = target.data("drillDownGroupTargetData");
				var seriesIdx = drillDownGroupTargetData.seriesIdx;
				var pointsIdx = drillDownGroupTargetData.pointsIdx;

				var chartData = target.children().data("ejChart");
				var seriesData = chartData.model.series[seriesIdx];
				var pointsData = seriesData.points[pointsIdx];
				var dataDivision = " - ";
				var filterValue = "";

				var originNameList = originAnalysisData.columnNameList;
				var nameIdx = -1;
				if ($.fn.ifvmIsNotEmpty(originNameList)) {
					$.each(originNameList, function(dataIdx, dataObject) {
						if (dataObject.fieldCaption === columnAlias) {
							nameIdx = dataIdx;
							return false;
						}
					});
				}

				if (nameIdx !== -1) {
					var seriesName = seriesData.name;
					var seriesNameList = seriesName.split(dataDivision);

					filterValue = seriesNameList[nameIdx];
				} else {
					originNameList = originAnalysisData.rowNameList;
					if ($.fn.ifvmIsNotEmpty(originNameList)) {
						$.each(originNameList, function(dataIdx, dataObject) {
							if (dataObject.fieldCaption === columnAlias) {
								nameIdx = dataIdx;
								return false;
							}
						});
					}

					if (nameIdx !== -1) {
						var pointsName = pointsData.x;
						var pointsNameList = pointsName.split(dataDivision);

						filterValue = pointsNameList[nameIdx];
					} else {
						var seriesName = seriesData.name;
						var seriesNameList = seriesName.split(dataDivision);

						filterValue = seriesNameList[seriesNameList.length - 1];
					}
				}

				thisDrillDownGroupData.filterValue = filterValue;
				currentDrillDownGroupList.push(thisDrillDownGroupData);
				// UP일 경우 여러가지 상황 발생
				// 1. 없는 상태에서 DrillUp 할 경우, 값은 필요 없이 그룹핑 값만 변경
				// 2. 여러 단계 거친 후의 DrillUp 일 경우, 마지막 값을 Pop
				// 3. 리스트에 한개만 있을 경우, 0번째 인덱스에 있는 값만 변경
			} else {
				thisDrillDownGroupData.filterValue = "";

				var currentDrillDownGroupListLength = currentDrillDownGroupList.length;
				if (currentDrillDownGroupListLength === 0) {
					currentDrillDownGroupList.push(thisDrillDownGroupData);
				} else if (currentDrillDownGroupListLength === 1) {
					currentDrillDownGroupList[0] = thisDrillDownGroupData;
				} else {
					currentDrillDownGroupList.pop();
				}
			}

			analysisData.currentDrillDownGroupList = currentDrillDownGroupList;
			$.fn.KPRAnalysisCreateReport({
				targetId : analysisData.targetId,
				analysisId : analysisData.analysisId,
				analysisMasterFlag : analysisData.analysisMasterFlag,
				analysisTypeCode : analysisData.analysisTypeCode,
				publishFlag : analysisData.publishFlag,
				fieldGroupColumnId : analysisData.fieldGroupColumnId,
				promptDataMap : analysisData.promptDataMap,
				currentDrillDownGroupList : currentDrillDownGroupList
			}, analysisData.callbackFuntion);
		}
	};

	$.fn.KPRAnalysisPublishChartResize = function(targetId) {
		var $target = $("#" + targetId);
		$target.data("resizeFlag", true);

		var analysisData = $("#" + targetId).children().data("analysisData");
		var chartWidth = $target.width();
		var chartHeight = $target.height();

		analysisData.chartWidth = chartWidth;
		analysisData.chartHeight = chartHeight;
		$.fn.KPRAnalysisCreateChart(analysisData);
		$target.removeData("resizeFlag");
	};

	var getAnalysisDataDefaultCallback = function(dataObj) {
		var targetId = dataObj.targetId;

		if (dataObj.noDataFlag === true) {
			$("#" + targetId + " #emptyDiv").remove();
			$("#" + targetId).append("<div id='emptyDiv'><spring:message code='M01712' /></div>");
		} else {
			$("#" + targetId + " #emptyDiv").remove();
		}
	};

	$.fn.KPRAnalysisSettingPop = function(targetObj, callbackFunction) {
		var targetTag = $("#" + targetObj.targetId).children();
		var analysisData = targetTag.data("analysisData");

		var fieldGroupFlag = analysisData.fieldGroupFlag;
		var promptFlag = analysisData.promptFlag;

		if (fieldGroupFlag === true || promptFlag === true) {
			var thisObj = $.extend(targetObj, analysisData);

			var thisId = targetObj.instFlag + analysisData.analysisId;
			var analysisId = analysisData.analysisId;
			var analysisSetupPop = $("#" + thisId);
			var tempPopObj = null;

			if ($.fn.ifvmIsEmpty(analysisSetupPop)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", thisId);
			} else {
				tempPopObj = analysisSetupPop;
			}

			var externalFlag = targetObj.externalFlag;
			var targetUrl = null;
			if ($.fn.ifvmIsNotEmpty(externalFlag) && externalFlag === true) {
				targetUrl = "<ifv:url name='externalAnalysisSetupPop' />";
			} else {
				targetUrl = "<ifv:url name='analysisSetupPop' />";
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : targetUrl,
				contentType : "ajax",
				title : "<spring:message code='M01542' />",
				ajaxSuccess : function(evt) {
					setAnalysisSetupDetail(thisObj);
				},
				beforeClose : function(evt) {
					var dataFlag = tempPopObj.data("dataFlag");

					if ($.fn.ifvmIsNotEmpty(dataFlag) && dataFlag) {
						var analysisData = tempPopObj.data("analysisData");

						if ($.fn.ifvmIsNotEmpty(callbackFunction)) {
							eval(callbackFunction)(analysisData);
						} else {
							$.fn.KPRAnalysisCreateReport(analysisData);
						}
					}
				}
			});
		} else {
			alert("<spring:message code='M01646' />");
		}
	};

	/**
	 * 차트 Resize 관련 함수
	 * */
	$.fn.resizeEnd = function(execFunction) {
		var _this = this;
		var interval = 100;
		var timeOut = false;

		var currentTime;
		var thisResizeEnd = function() {
			if (new Date() - currentTime < interval) {
				setTimeout(thisResizeEnd, interval);
			} else {
				execFunction(_this);

				timeOut = false;
			}
		};

		_this.resize(function(evt) {
			if (!timeOut) {
				timeOut = true;
				currentTime = new Date();
				setTimeout(thisResizeEnd, interval);
			}
		});
	};
</script>