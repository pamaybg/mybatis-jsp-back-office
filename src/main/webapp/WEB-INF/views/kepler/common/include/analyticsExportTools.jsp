<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	/**/
	/**
	 * 분석 파일 Export 관련 전역 변수
	 * */
	var ANALYTICS_EXPORT_OPTIONS = {};
	ANALYTICS_EXPORT_OPTIONS.EXPORT_TIMER = null;
	// 	ANALYTICS_EXPORT_OPTIONS.DEFAULT_CHART_SIZE = 1920;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_CHART_WIDTH = 600;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_CHART_HEIGHT = 800;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_CELL_HEIGHT = 30;
	ANALYTICS_EXPORT_OPTIONS.EXPORT_DATA_NAME = "exportData";
	ANALYTICS_EXPORT_OPTIONS.COMPLETE_FLAG_NAME = "completeFlag";
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_WIDTH_PADDING = 5;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_HEIGHT_PADDING = 15;
	ANALYTICS_EXPORT_OPTIONS.TEXT_Y = 10;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_HTML_WIDTH = 800;
	ANALYTICS_EXPORT_OPTIONS.DEFAULT_HTML_HEIGHT = 600;

	/**
	 * 분석 파일 Export 공통 함수
	 * Export 지원 대상
	 *  - Word
	 *  - Excel
	 *  - PDF
	 *  - HWP(HML), HWP의 경우 한컴에서 지원하는 XML포맷 형태로 만듦 => 삭제 예정
	 *
	 * @param exportType
	 * @param targetName
	 *			- Export 대상 분석/대시보드명. 
	 *			- 파일명으로 사용 됨.
	 * @param targetObject
	 *			- Export 대상 리스트 혹은 객체.
	 *			- 분석인 경우, 현재 실행해놓은 테이블/차트를 Export 함.
	 * */
	$.QTAnalyticsExport = function(exportType, targetName, targetObject) {
		$.ifvProgressControl(true);

		if ($.fn.ifvmIsEmpty(targetName)) {
			targetName = "TEMP";
		}

		var thisObjectList = new Array();
		if (targetObject instanceof Array) {
			thisObjectList = targetObject;
		} else {
			thisObjectList.push(targetObject);
		}

		if (exportType !== "PDF") {
			var exportDataList = new Array();
			var imageCnt = 0;

			for (var idx = 0; idx < thisObjectList.length; idx++) {
				var exportData = null;

				var thisId = thisObjectList[idx].targetId;
				var thisObject = document.getElementById(thisId);
				var thisChildObject = thisObject.children[0];

				if ($.fn.ifvmIsNotEmpty(thisChildObject) && thisChildObject.children.length > 0) {
					// 					var analyticsData = Object.assign({}, {}, $(thisChildObject).data("analysisData"));
					var analyticsData = $.extend(true, {}, $(thisChildObject).data("analysisData"));
					var analyticsTypeCode = analyticsData.analysisTypeCode;

					if (analyticsTypeCode === "TABLE") {
						exportData = $.QTAnalyticsTableExport(thisChildObject.children[0]);
					} else {
						exportData = $.QTAnalyticsChartExport(thisChildObject.children[0]);
						exportData.imageId = ++imageCnt;
					}

					exportData.targetName = thisObjectList[idx].targetName;
					exportData.analyticsTypeCode = analyticsTypeCode;

					exportDataList.push(exportData);
				}
			}

			if ($.fn.ifvmIsNotEmpty(exportDataList)) {
				$.ifvProgressControl(false);

				var exportReqData = {
					fileName : targetName,
					imageCnt : imageCnt,
					exportType : exportType,
					exportDataList : exportDataList
				};

				$.ifvPostJSON("<ifv:action name='getAnalyticsExportData' />", exportReqData, function(resData) {
					var resBlob = $.fn.ifvmConvertB64ToBlob(resData.fileDataStream, "application/octet-stream");
					var fileName = resData.fileName;

					if (window.navigator.msSaveOrOpenBlob) {
						window.navigator.msSaveBlob(resBlob, fileName);
					} else {
						var a = document.createElement("a");
						a.href = window.URL.createObjectURL(resBlob);
						a.download = fileName;
						a.click();
					}
				});
			} else {
				alert("<spring:message code='C00035' />");
				$.ifvProgressControl(false);

				return;
			}
		} else {
			$.QTAnalyticsPDFExport(targetName, thisObjectList);
		}
	};

	$.QTAnalyticsTableExport = function(targetTable) {
		var rowList = targetTable.getElementsByTagName("tr");
		var sheetRowList = 10000000;
		var range = {
			start : {
				row : 0,
				col : 0
			},
			end : {
				row : 0,
				col : 0
			}
		};
		var merges = new Array();
		var midx = 0;
		var rowInfo = new Array();

		var sheetDataList = new Array();

		var totalColCnt = 0;

		var _row = 0, row = 0, _col = 0, col = 0, rowSpan, colSpan;
		for (; _row < rowList.length && row < sheetRowList; ++_row) {
			var curRow = rowList[_row];
			var colList = (curRow.children);

			if (totalColCnt < colList.length) {
				totalColCnt = colList.length;
			}

			for (_col = col = 0; _col < colList.length; ++_col) {
				var curCol = colList[_col];
				var colValue = curCol.innerText;

				for (midx = 0; midx < merges.length; ++midx) {
					var merge = merges[midx];
					if (merge.start.col == col && merge.start.row <= row && row <= merge.end.row) {
						col = merge.end.col + 1;
						midx = -1;
					}
				}

				colSpan = +curCol.getAttribute("colspan") || 1;
				if ((rowSpan = +curCol.getAttribute("rowspan")) > 1 || colSpan > 1) {
					merges.push({
						start : {
							row : row,
							col : col
						},
						end : {
							row : row + (rowSpan || 1) - 1,
							col : col + colSpan - 1
						}
					});
				}

				var object = {
					colValue : colValue,
					rowAddr : row,
					colAddr : col,
					rowSpan : 0,
					colSpan : 0,
					colWidth : (colValue.length * 20),
					colHeight : ANALYTICS_EXPORT_OPTIONS.DEFAULT_CELL_HEIGHT
				};

				if ("TH" === curCol.tagName || curCol.className.indexOf("summary") > -1 || curCol.className.indexOf("rowheader") > -1) {
					object.strongFlag = true;
				} else {
					object.strongFlag = false;
				}

				if (curCol.className.indexOf("value") > -1) {
					object.alignFlag = true;
				} else {
					object.alignFlag = false;
				}

				if (!sheetDataList[row]) {
					sheetDataList[row] = new Array();
				}
				sheetDataList[row].push(object);

				if (range.end.col < col) {
					range.end.col = col;
				}
				col += colSpan;
			}

			++row;
		}

		if (merges.length) {
			for (midx = 0; midx < merges.length; midx++) {
				var merge = merges[midx];

				var rowList = sheetDataList[merge.start.row];
				for (var rowIdx = 0; rowIdx < rowList.length; rowIdx++) {
					var colData = rowList[rowIdx];

					if (colData.colAddr === merge.start.col) {
						colData.rowSpan = merge.end.row - merge.start.row;
						colData.colSpan = merge.end.col - merge.start.col;

						break;
					}
				}
			}
		}

		range.end.row = row - 1;

		return {
			totalWidth : parseInt(targetTable.style.width || 1, 10),
			totalHeight : ANALYTICS_EXPORT_OPTIONS.DEFAULT_CELL_HEIGHT * rowList.length,
			totalRowCnt : sheetDataList.length,
			totalColCnt : totalColCnt,
			tableRowList : sheetDataList
		};
	};

	$.QTAnalyticsChartExport = function(targetChart) {
		var thisCanvas = document.createElement("canvas");
		var thisContext = thisCanvas.getContext("2d");
		thisCanvas.width = parseInt(targetChart.querySelector("svg:not([id^='legend'])").style.width, 10);
		thisCanvas.height = parseInt(targetChart.querySelector("svg:not([id^='legend'])").style.height, 10);

		$.each(targetChart.querySelectorAll("svg"), function(thisSVGIdx, thisSVG) {
			var thisSVGId = thisSVG.id;
			var thisSVGData = new XMLSerializer().serializeToString(thisSVG);

			var thisSVGWidth = parseInt(thisSVG.style.width, 10);
			var thisSVGHeight = parseInt(thisSVG.style.height, 10);

			var posX = 0, posY = 0;

			if (thisSVGId.toUpperCase().indexOf("LEGEND") > -1) {
				posX = parseInt($(thisSVG).closest("[id='" + thisSVG.id.substr(0, thisSVG.id.lastIndexOf("_svg")) + "']").css("left"), 10);
				posY = parseInt($(thisSVG).closest("[id='" + thisSVG.id.substr(0, thisSVG.id.lastIndexOf("_svg")) + "']").css("top"), 10);
			}

			thisContext.drawSvg(thisSVGData, posX, posY, thisSVGWidth, thisSVGHeight);
		});

		var thisDataURL = thisCanvas.toDataURL();
		var imageExtension = thisDataURL.substring(thisDataURL.indexOf("/") + 1, thisDataURL.indexOf(";"));
		var imageEncoding = thisDataURL.substring(thisDataURL.indexOf(";") + 1, thisDataURL.indexOf(","));
		var imageBinaryData = thisDataURL.substring(thisDataURL.indexOf(",") + 1);
		var imageSize = imageBinaryData.length;
		imageEncoding = imageEncoding.charAt(0).toUpperCase() + imageEncoding.substring(1);

		return {
			imageWidth : thisCanvas.width,
			imageHeight : thisCanvas.height,
			imageExtension : imageExtension,
			imageEncoding : imageEncoding,
			imageBinaryData : imageBinaryData,
			imageSize : imageSize,
			imageData : thisDataURL
		};
	};

	$.QTAnalyticsPDFExport = function(targetName, thisObjectList) {
		var hiddenDivId = "ANALYTICS_TEMP_DIV_";
		var hiddenDiv = document.createElement("div");
		hiddenDiv.id = hiddenDivId;
		hiddenDiv.style.width = 0;
		hiddenDiv.style.height = 0;
		hiddenDiv.style.overflow = "hidden";

		var firstElement = document.getElementById("content").querySelector("div");
		document.getElementById("content").insertBefore(hiddenDiv, firstElement);

		var exportDataList = new Array();
		for (var idx = 0; idx < thisObjectList.length; idx++) {
			var thisId = thisObjectList[idx].targetId;
			var thisObject = document.getElementById(thisId);
			var thisChildObject = thisObject.children[0];

			if ($.fn.ifvmIsNotEmpty(thisChildObject) && thisChildObject.children.length > 0) {
				exportDataList.push({
					completeFlag : false
				});

				// 				var analyticsData = Object.assign({}, {}, $(thisChildObject).data("analysisData"));
				var analyticsData = $.extend(true, {}, $(thisChildObject).data("analysisData"));
				var analyticsTypeCode = analyticsData.analysisTypeCode;

				if (analyticsTypeCode === "TABLE") {
					var thisCloneObject = thisChildObject.cloneNode(true);
					thisCloneObject.setAttribute("idx", idx);
					thisCloneObject.id = thisCloneObject.id + "_HIDDEN";
					hiddenDiv.appendChild(thisCloneObject);
					
					var tableObject = thisCloneObject.querySelector("table");
					var tableWidth = $(tableObject).width();
					var tableHeight = $(tableObject).height();
					
					$(thisCloneObject).width(tableWidth);
					$(thisCloneObject).height(tableHeight);

					// 					var thisCanvas = document.createElement("canvas");
					// 					thisCanvas.width = tableWidth;
					// 					thisCanvas.height = tableHeight;
					// 					var thisContext = thisCanvas.getContext("2d");

					var rowList = tableObject.getElementsByTagName("tr");
					for (var rowIdx = 0; rowIdx < rowList.length; rowIdx++) {
						var colList = rowList[rowIdx].children;

						for (var colIdx = 0; colIdx < colList.length; colIdx++) {
							var colObject = colList[colIdx];

							if (colObject.classList.contains("colheader") || colObject.classList.contains("rowheader")) {
								colObject.style.textAlign = "left";
								colObject.style.fontWeight = "bold";
								colObject.style.padding = "6px 16px 6px 2px";
							} else {
								colObject.style.textAlign = "right";
								colObject.style.padding = "6px 6px 6px 16px";
							}

							colObject.style.fontSize = "11px";
							colObject.style.border = "#C8C8C8 1px solid";
						}
					}

					html2canvas($(thisCloneObject), {
						logging: true,
						onrendered : function(thisCanvas) {
							var thisDataURL = thisCanvas.toDataURL();
							var imageExtension = thisDataURL.substring(thisDataURL.indexOf("/") + 1, thisDataURL.indexOf(";"));
							var imageEncoding = thisDataURL.substring(thisDataURL.indexOf(";") + 1, thisDataURL.indexOf(","));
							var imageBinaryData = thisDataURL.substring(thisDataURL.indexOf(",") + 1);
							var imageSize = imageBinaryData.length;
							imageEncoding = imageEncoding.charAt(0).toUpperCase() + imageEncoding.substring(1);

							exportDataList[thisCloneObject.getAttribute("idx")] = {
								imageWidth : thisCanvas.width,
								imageHeight : thisCanvas.height,
								imageExtension : imageExtension,
								imageEncoding : imageEncoding,
								imageBinaryData : imageBinaryData,
								imageSize : imageSize,
								imageData : thisDataURL,
								analyticsTypeCode : analyticsTypeCode,
								targetName : thisObjectList[thisCloneObject.getAttribute("idx")].targetName,
								completeFlag : true
							};
							
							hiddenDiv.appendChild(thisCanvas);
						}
					});

					// 					var svgData = "<svg xmlns='http://www.w3.org/2000/svg' width='" + tableWidth + "' height='" + tableHeight + "'>";
					// 					svgData += "<foreignObject width='100%' height='100%'>";
					// 					svgData += "<div xmlns='http://www.w3.org/1999/xhtml' class='e-pivotgrid' style='width: " + tableWidth + "px;height : " + tableHeight + "px;'>";
					// 					svgData += new XMLSerializer().serializeToString(thisCloneObject);
					// 					svgData += "</div>";
					// 					svgData += "</foreignObject>";
					// 					svgData += "</svg>";

					// 					var svgImage = document.createElement("img");
					// 					hiddenDiv.appendChild(svgImage);

					// 					svgImage.width = tableWidth;
					// 					svgImage.height = tableHeight;
					// 					$(svgImage).load(function() {
					// 						thisContext.drawImage(svgImage, 0, 0);

					// 						var thisDataURL = thisCanvas.toDataURL();
					// 						var imageExtension = thisDataURL.substring(thisDataURL.indexOf("/") + 1, thisDataURL.indexOf(";"));
					// 						var imageEncoding = thisDataURL.substring(thisDataURL.indexOf(";") + 1, thisDataURL.indexOf(","));
					// 						var imageBinaryData = thisDataURL.substring(thisDataURL.indexOf(",") + 1);
					// 						var imageSize = imageBinaryData.length;
					// 						imageEncoding = imageEncoding.charAt(0).toUpperCase() + imageEncoding.substring(1);

					// 						exportDataList[thisCanvas.getAttribute("idx")] = {
					// 							imageWidth : thisCanvas.width,
					// 							imageHeight : thisCanvas.height,
					// 							imageExtension : imageExtension,
					// 							imageEncoding : imageEncoding,
					// 							imageBinaryData : imageBinaryData,
					// 							imageSize : imageSize,
					// 							imageData : thisDataURL,
					// 							analyticsTypeCode : analyticsTypeCode,
					// 							targetName : thisObjectList[thisCanvas.getAttribute("idx")].targetName,
					// 							completeFlag : true
					// 						};
					// 					});
					// 					// 					svgImage.onload =;
					// 					svgImage.src = "data:image/svg+xml," + svgData;
				} else {
					var exportData = $.QTAnalyticsChartExport(thisChildObject.children[0]);

					exportData.analyticsTypeCode = analyticsTypeCode;
					exportData.targetName = thisObjectList[idx].targetName;
					exportData.completeFlag = true;

					exportDataList[idx] = exportData;
				}
			}
		}

		if ($.fn.ifvmIsNotEmpty(exportDataList)) {
			var exportPDFTimer = setInterval(function() {
				var completeCount = 0;
				for (var idx = 0; idx < exportDataList.length; idx++) {
					var exportData = exportDataList[idx];

					if (exportData.completeFlag) {
						completeCount++;
					}
				}

				if (exportDataList.length === completeCount) {
					clearInterval(exportPDFTimer);

					var thisPDF = new jsPDF("A4");
					var imageSize = thisPDF.internal.pageSize.width;
					imageSize = imageSize - (ANALYTICS_EXPORT_OPTIONS.DEFAULT_WIDTH_PADDING * 2);

					for (var idx = 0; idx < exportDataList.length; idx++) {
						if (idx !== 0) {
							thisPDF.addPage();
						}

						var exportData = exportDataList[idx];
						var analyticsTypeCode = exportData.analyticsTypeCode;
						thisPDF.text(exportData.targetName, ANALYTICS_EXPORT_OPTIONS.DEFAULT_WIDTH_PADDING, ANALYTICS_EXPORT_OPTIONS.TEXT_Y);

						if (analyticsTypeCode === "TABLE") {
							thisPDF.addImage(exportData.imageData, ANALYTICS_EXPORT_OPTIONS.DEFAULT_WIDTH_PADDING, ANALYTICS_EXPORT_OPTIONS.DEFAULT_HEIGHT_PADDING);
						} else {
							thisPDF.addImage(exportData.imageData, exportData.imageExtension, ANALYTICS_EXPORT_OPTIONS.DEFAULT_WIDTH_PADDING, ANALYTICS_EXPORT_OPTIONS.DEFAULT_HEIGHT_PADDING, imageSize, imageSize);
						}
					}

					var fileName = targetName + "_" + $.ifvGetNewDate().newDate + ".PDF";
					thisPDF.save(fileName);

					$.ifvProgressControl(false);
				}
			}, 1000);
		} else {
			alert("<spring:message code='C00035' />");
			$.ifvProgressControl(false);

			return;
		}
	};
</script>


<script id="analyticsExportHTMLTemplate" type="text/x-jquery-tmpl">
	<div class="dashboard_box_type1">
		<div class="header_chart">
			<p class="tit_chart">${'${'}targetName}</p>
		</div>
		<div class="chart_area" id="${'${'}targetId}" style="background: #FFFFFF;"></div>
	</div>
</script>