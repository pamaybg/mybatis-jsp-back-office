<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var ANALYSIS_EXPORT_OPTION = {};
	ANALYSIS_EXPORT_OPTION.PAGE_A4_WIDTH = 793;
	ANALYSIS_EXPORT_OPTION.PAGE_A4_HEIGHT = 1121;
	ANALYSIS_EXPORT_OPTION.DEFAULT_WIDTH_PADDING = 5;
	ANALYSIS_EXPORT_OPTION.DATA_HEIGHT_PADDING = 15;
	ANALYSIS_EXPORT_OPTION.TEXT_Y = 10;
	ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE = 1500;
	
	var analysisExportExcelTimer = null;
	$.fn.KPRAnalysisExportExcel = function( targetName, targetList ) {
		$.ifvProgressControl(true);
		
		if( !$.fn.ifvmIsNotEmpty( targetName ) ) {
			targetName = "TEMP";
		}
		
		var ANALYSIS_EXCEL = "ANALYSIS_EXCEL";
		var analysisExportExcel = $( "<div></div>" );
		analysisExportExcel.attr( "id", ANALYSIS_EXCEL );
		$( "body" ).append( analysisExportExcel );
	
		var targetListLength = targetList.length;
		for( var tIdx = 0; tIdx < targetListLength; tIdx++ ) {
			var targetObj = targetList[ tIdx ];
			var targetId = targetObj.targetId;
	
			var targetSaveDiv = $( "<div></div>" );
			var targetSaveDivId = ANALYSIS_EXCEL + "_" + targetId + "_" + tIdx;
			targetSaveDiv.attr( "id", targetSaveDivId );
			targetSaveDiv.css( "display", "none" );
			targetSaveDiv.css( "visibility", "hidden" );
			targetSaveDiv.css( "width", "0px" );
			targetSaveDiv.css( "height", "0px" );
			targetSaveDiv.data( "sheetName", targetObj.targetName );
			
			$( "#" + ANALYSIS_EXCEL ).append( targetSaveDiv );
	
			$.fn.KPRAnalysisCreateReport({
				targetId: targetSaveDivId
				, analysisId: targetId
				, analysisMasterFlag: "N"
				, analysisTypeCode: "TABLE"
				, targetSaveDivId: targetSaveDivId
				, analysisExportFlag: "Y"
			}, "getAnalysisExportExcelCallbackFunction" );
		}
		
		// 2초마다 타이머 체크
		analysisExportExcelTimer = setInterval(function() {
			var _targetList = targetList;
			var _targetDivList = $( "#" + ANALYSIS_EXCEL ).children();
			var _targetDivListLength = _targetDivList.length;
			
			if( _targetList.length === _targetDivListLength ) {
				var analysisExportFlag = true;
				for( var dIdx = 0; dIdx < _targetDivListLength; dIdx++ ) {
					var thisDiv = $( _targetDivList[ dIdx ] );
					var thisDivCompleteFlag = thisDiv.data( "COMPLETE_FLAG" );
					
					if( !$.fn.ifvmIsNotEmpty( thisDivCompleteFlag ) ) {
						analysisExportFlag = false;
						break;
					}
				}
				
				if( analysisExportFlag === true ) {
					clearInterval( analysisExportExcelTimer );
					var analysisExportExcelDataList = new Array();
					var dataEmptyCount = -1;
					
					for( var dIdx = 0; dIdx < _targetDivListLength; dIdx++ ) {
						var thisDiv = $( _targetDivList[ dIdx ] );
						var thisExcelData = thisDiv.data( "exportExcelData" );
						var thisSheetName = thisDiv.data( "sheetName" );
						var thisExcelDataList = thisExcelData.excelDataList;
						
						if( !$.fn.ifvmIsNotEmpty( thisSheetName ) ) {
							thisSheetName = "TEMP";
						}
						
						if( $.fn.ifvmIsNotEmpty( thisExcelDataList ) ) {
							dataEmptyCount++;
						}
						
						analysisExportExcelDataList.push({
							sheetName: thisSheetName
							, excelDataList: thisExcelDataList
							, mergeDataList: thisExcelData.mergeDataList
						});
					}
					
					if( dataEmptyCount !== -1 ) {
						$.ifvPostJSON( "<ifv:action name='getAnalysisExportExcel' />", {
							excelName: targetName
							, sheetDataList: analysisExportExcelDataList
						}, function( rst ) {
							// 요청이 끝나면
							$.ifvProgressControl(false);
							$( "#" + ANALYSIS_EXCEL ).remove();
		
							qtjs.href("<ifv:action name='getAnalysisExportDownload' />" + "?fileName=" + encodeURI( encodeURI( rst.fileName ) ));
						}, function( rst ) {
							$.ifvProgressControl(false);
							$( "#" + ANALYSIS_EXCEL ).remove();						
						});
					} else {
						$.ifvProgressControl(false);
						$( "#" + ANALYSIS_EXCEL ).remove();
						alert( "<spring:message code='C00035' />" );
					}
				}
			}
		}, 2000 );
	};
	
	var getAnalysisExportExcelCallbackFunction = function( rst ) {
		var targetId = rst.targetSaveDivId;
		var targetExcelDataList = new Array();
		var targetExcelMergeList = new Array();
	
		// 생성된 Table 의 th, td 리스트를 가져온다.
		var targetTag = $( "#" + targetId );
		var targetTagList = targetTag.find( "th, td" );
		var tempDataList = new Array();
		var rowNumCount = -1;
		$.each(targetTagList, function( idx, thisTag ) {
			var tag = $( thisTag );
			
			if( tag.css( "display" ) !== "none" && tag.parent().css( "display" ) !== "none" ) {
				// Excel Cell Data 설정
				var excelData = new Object();
	
				var cellValue = tag.find( "span[class=cellValue]" ).text();
				excelData.cellValue = cellValue;
				
				var cellType = null;
				// false 라면 일반
				if( tag.hasClass( "summary" ) === false ) {
					// value가 없다면 헤더
					if( tag.hasClass( "value" ) === false ) {
						cellType = "NH";
					} else {
						cellType = "NV";
					}
				} else {
					// value가 없다면 헤더
					if( tag.hasClass( "value" ) === false ) {
						cellType = "SH";
					} else {
						cellType = "SV";
					}
				}
				excelData.cellType = cellType;
				
				var coord = tag.attr( "p" );
				var coordList = coord.split( "," );
				var pointX = Number( coordList[0] ) + 1;
				var pointY = Number( coordList[1] ) + 1;
				
				excelData.pointX = pointX;
				excelData.pointY = pointY;
				
				if( rowNumCount !== pointY ) {
					if( idx !== 0 ) {
						targetExcelDataList.push( tempDataList );
					}
					
					rowNumCount = pointY;
					tempDataList = new Array();
				}
	
				tempDataList.push( excelData );
	
				var rowSpan = Number( tag.attr( "rowspan" ) ) - 1;
				var colSpan = Number( tag.attr( "colspan" ) ) - 1;
				
				if( colSpan > 0 || rowSpan > 0 ) {
					var endX = pointX;
					var endY = pointY;
	
					// C: Column Merge, R: Row Merge, M: Column/Row Merge
					// M
					if( colSpan > 0 && rowSpan > 0 ) {
						endX += colSpan;
						endY += rowSpan;
					// C
					} else if( colSpan > 0 && rowSpan === 0 ) {
						endX += colSpan; 
					// R
					} else {
						endY += rowSpan;
					}
					
					targetExcelMergeList.push({
						startX: pointX
						, startY: pointY
						, endX: endX
						, endY: endY
					});
				}
			}
		});
		
		targetExcelDataList.push( tempDataList );
		
		targetTag.data( "exportExcelData", {
			rowNumCount: rowNumCount
			, excelDataList: targetExcelDataList
			, mergeDataList: targetExcelMergeList
		});
		
		targetTag.data( "COMPLETE_FLAG", "Y" );
	};
	
	var analysisExportPDFTimer = null;
	$.fn.KPRAnalysisExportPDF = function( targetName, targetList ) {
		$.ifvProgressControl(true);
		
		if( !$.fn.ifvmIsNotEmpty( targetName ) ) {
			targetName = "TEMP";
		}
		
		var dataEmptyCount = -1;
		
		var ANALYSIS_PDF = "ANALYSIS_PDF";
		var COMPLETE_FLAG = "COMPLETE_FLAG";
	
		var iFrameName = "analysisExportPDFFrame";
	
		var iFrameTag = $( "<iframe></iframe>" );
		iFrameTag.attr( "id", iFrameName );
		iFrameTag.css( "width", "0px" );
		iFrameTag.css( "height", "0px" );
		
		$( "body" ).append( iFrameTag );
		$( "link[type='text/css']" ).clone().appendTo( $( "#" + iFrameName ).contents().find( "head" ) ); // CSS 파일 Import
		$( "script[type='text/javascript']" ).clone().appendTo( $( "#" + iFrameName ).contents().find( "head" ) ); // Javascript 파일 Import
	
		var iFrameDocument = iFrameTag[0].contentWindow.document;
		iFrameDocument.setAnalysisTableDraw = function( targetId ) {
			var targetSaveDiv = $( "#" + iFrameName ).contents().find( "#" + targetId );
			var targetTable = targetSaveDiv.find( "table" );
			
			html2canvas( targetTable, {
				useCORS: true
				, proxy: '/etc/proxy_image'
				, onrendered: function(canvas) {
					var canvasContext = canvas.getContext( "2d" );
					var canvasWidth = canvas.width;
					var canvasHeight = canvas.height;
					
					var tempCanvas = $( "<canvas></canvas>" );
					tempCanvas.attr( "width", canvasWidth );
					tempCanvas.attr( "height", canvasHeight );
					
					var tempCanvasContext = tempCanvas[0];
					tempCanvasContext.getContext( "2d" ).drawImage( canvas, 0, 0 );
					
					var resizeCanvas = getResizeCanvas( canvasWidth, canvasHeight );
					canvas.width = resizeCanvas[0].width;
					canvas.height = resizeCanvas[0].height;
					
					canvasContext.drawImage( tempCanvasContext, 0, 0, tempCanvasContext.width, tempCanvasContext.height, 0, 0, canvas.width, canvas.height );
	
					$( "#" + iFrameName ).contents().find( "#" + targetId ).data( COMPLETE_FLAG, "Y" );
					$( "#" + iFrameName ).contents().find( "#" + targetId ).append( canvas );
		        }
			});
		};
	
		// 파라메터로 받아온 targetList 를 돌아가며 처리,
		var targetListLength = targetList.length;
		for( var tIdx = 0; tIdx < targetListLength; tIdx++ ) {
			var target = targetList[ tIdx ];
			var targetId = target.targetId;
			
			// 부모 태그 체크
			var parentTag = $( "#" + targetId );
			if( $.fn.ifvmIsNotEmpty( parentTag ) ) {
				var targetTag = parentTag.children( "div[id^='CHART'], div[id^='TABLE']" );
				
				// 실제 Table, Chart 를 가지고 있는 태그 체크
				if( $.fn.ifvmIsNotEmpty( targetTag ) ) {
					var targetTagId = targetTag.attr( "id" );
					
					// 아이디에 TABLE 있다면 TABLE 그 외에는 차트
					if( targetTagId.toUpperCase().indexOf( "TABLE" ) > -1 ) {
						var targetTagClone = targetTag.clone();
						var targetTagCloneId = targetTagClone.attr( "id" ) + "_CLONE";
						var targetTagChildCloneId = targetTagClone.children().eq( 0 ).attr( "id" ) + "_CLONE";
						
						targetTagClone.attr( "id", targetTagCloneId );
						targetTagClone.children().eq( 0 ).attr( "id", targetTagChildCloneId );
						
						var targetSaveDiv = $( "<div></div>" );
						var targetSaveDivId = ANALYSIS_PDF + "_" + targetId + "_" + tIdx;
						targetSaveDiv.attr( "id", targetSaveDivId );
						targetSaveDiv.data( "headerName", target.targetName );
						targetSaveDiv.append( targetTagClone );
						
						$( "#" + iFrameName ).contents().find( "body" ).append( targetSaveDiv );
						
						iFrameDocument.setAnalysisTableDraw( targetSaveDivId );
					} else {
						var targetSvgList = targetTag.find( "svg" );
						var tempCanvasList = new Array();
						var resultWidth = 0;
						var resultHeight = 0;
						
						for( var sIdx = 0; sIdx < targetSvgList.length; sIdx++ ) {
							var svgElement = targetSvgList[ sIdx ];
							var targetSvg = $( svgElement ).clone();
							var targetSvgId = targetSvg.attr( "id" ) + "_CLONE";
							targetSvg.attr( "id", targetSvgId );
							
							var targetSvgWidth = targetSvg.width();
							var targetSvgHeight = targetSvg.height();
							
							resultHeight = resultHeight + targetSvgHeight;
							
							var targetTempSaveCanvas = $( "<canvas></canvas>" );
							targetTempSaveCanvas.attr( "width", targetSvgWidth );
							targetTempSaveCanvas.attr( "height", targetSvgHeight );
							
							if( targetSvgId.toUpperCase().indexOf( "LEGEND" ) > -1 ) {
								targetTempSaveCanvas.data( "legendFlag", "Y" );
							} else {
								targetTempSaveCanvas.data( "legendFlag", null );
								resultWidth = targetSvgWidth;
							}
							
							var xmlData = new XMLSerializer().serializeToString( targetSvg[0] );
							xmlData = xmlData.replace( /xmlns=\"http:\/\/www\.w3\.org\/2000\/svg\"/, '' );
							
							canvg( targetTempSaveCanvas[0], xmlData );
							tempCanvasList.push( targetTempSaveCanvas );
						}
						
						var tempCanvas = $( "<canvas></canvas>" );
						var tempCanvasContext = tempCanvas[0].getContext( "2d" );
						tempCanvas.attr( "width", resultWidth );
						tempCanvas.attr( "height", resultHeight );
						
						for( var cIdx = 0; cIdx < tempCanvasList.length; cIdx++ ) {
							var canvasTag = tempCanvasList[ cIdx ];
							var legendFlag = $( canvasTag ).data( "legendFlag" );
							
							// Legend Flag 가 없다면 실제 차트 Canvas 임으로
							if( !$.fn.ifvmIsNotEmpty( legendFlag ) ) {
								tempCanvasContext.drawImage( canvasTag[0], 0, 0 );
							} else {
								var startWidth = ( resultWidth / 2 ) - ( canvasTag.width() / 2 );
								var startHeight = resultHeight - canvasTag.height();
								
								tempCanvasContext.drawImage( canvasTag[0], startWidth, startHeight );
							}
						}
	
						var targetSaveCanvas = getResizeCanvas( resultWidth, resultHeight );
						var targetSaveCanvasContext = targetSaveCanvas[0].getContext( "2d" );
						var targetSaveCanvasId = targetTag.attr( "id" ) + "_CLONE";
						targetSaveCanvas.attr( "id", targetSaveCanvasId );
						
						targetSaveCanvasContext.drawImage( tempCanvas[0], 0, 0, resultWidth, resultHeight, 0, 0, targetSaveCanvas[0].width, targetSaveCanvas[0].height );
						
						var targetSaveDiv = $( "<div></div>" );
						var targetSaveDivId = ANALYSIS_PDF + "_" + targetId + "_" + tIdx;
						targetSaveDiv.attr( "id", targetSaveDivId );
						targetSaveDiv.data( "headerName", target.targetName );
						targetSaveDiv.append( targetSaveCanvas );
						targetSaveDiv.data( COMPLETE_FLAG, "Y" );
						
						$( "#" + iFrameName ).contents().find( "body" ).append( targetSaveDiv );
					}
	
					dataEmptyCount++;
				} else {
					var targetSaveDiv = $( "<div></div>" );
					var targetSaveDivId = ANALYSIS_PDF + "_" + targetId + "_" + tIdx;
					targetSaveDiv.attr( "id", targetSaveDivId );
					targetSaveDiv.data( COMPLETE_FLAG, "Y" );
					
					$( "#" + iFrameName ).contents().find( "body" ).append( targetSaveDiv );
				}
			}
		}
		
		if( dataEmptyCount !== -1 ) {
			// 2초마다 타이머 체크
			analysisExportPDFTimer = setInterval(function() {
				var _targetList = targetList;
				var _targetDivList = $( "#" + iFrameName ).contents().find( "[id*='" + ANALYSIS_PDF + "']" );
				var _targetDivListLength = _targetDivList.length;
				
				// 리스트로 넘어온 ID 리스트와 생성된 DIV 리스트가 같다면
				if( _targetList.length === _targetDivListLength ) {
					var analysisExportFlag = true;
					var exportTargetList = new Array();
					for( var dIdx = 0; dIdx < _targetDivListLength; dIdx++ ) {
						var thisDiv = $( _targetDivList[ dIdx ] );
						var thisDivData = thisDiv.data( COMPLETE_FLAG );
						
						if( $.fn.ifvmIsNotEmpty( thisDivData ) ) {
							var targetCanvas = thisDiv.find( "canvas" );
							
							if( $.fn.ifvmIsNotEmpty( targetCanvas ) ) {
								targetCanvas.data( "headerName", thisDiv.data( "headerName" ) );
								exportTargetList.push( targetCanvas );
							}
						} else {
							analysisExportFlag = false;
							break;
						}
					}
					
					if( analysisExportFlag === true ) {
						clearInterval( analysisExportPDFTimer );
		
						var analysisExportPDF = new jsPDF();
						var exportTargetListLength = exportTargetList.length;
						for( var eIdx = 0; eIdx < exportTargetListLength; eIdx++ ) {
							var targetCanvas = exportTargetList[ eIdx ];
							
							// 루프 시작 지점이 0이 아니라면 페이지 추가
							if( eIdx !== 0 ) {
								analysisExportPDF.addPage();
							}
							
							var headerName = targetCanvas.data( "headerName" );
							analysisExportPDF.text( headerName, ANALYSIS_EXPORT_OPTION.DEFAULT_WIDTH_PADDING, ANALYSIS_EXPORT_OPTION.TEXT_Y );
		
							var imageData = targetCanvas[0].toDataURL();
							analysisExportPDF.addImage( imageData, ANALYSIS_EXPORT_OPTION.DEFAULT_WIDTH_PADDING, ANALYSIS_EXPORT_OPTION.DATA_HEIGHT_PADDING );
						}
						
						$.ifvProgressControl(false);
						$( "#" + iFrameName ).remove();
						analysisExportPDF.save( targetName + "_" + $.ifvGetNewDate().newDate + ".pdf" );
					}
				}
			}, 2000 );
		} else {
			$.ifvProgressControl(false);
			$( "#" + iFrameName ).remove();
			alert( "<spring:message code='C00035' />" );
		}
	};
	
	var getResizeCanvas = function( targetWidth, targetHeight ) {
		// 페이지 사용 가능 영역 처리
		var PAGE_A4_WIDTH = ANALYSIS_EXPORT_OPTION.PAGE_A4_WIDTH - ANALYSIS_EXPORT_OPTION.DEFAULT_WIDTH_PADDING;
		var PAGE_A4_HEIGHT = ANALYSIS_EXPORT_OPTION.PAGE_A4_HEIGHT - ANALYSIS_EXPORT_OPTION.DATA_HEIGHT_PADDING;
		
		var finalWidth = 0;
		var finalHeight = 0;
	
		var thisCanvas = $( "<canvas></canvas>" );
		
		// 1. Width, Height 둘 다 a4보다 작을 때
		if( targetWidth < PAGE_A4_WIDTH && targetHeight < PAGE_A4_HEIGHT ) {
			finalWidth = targetWidth;
			finalHeight = targetHeight;
		// 2. Width 값이 a4보다 클 때
		} else if ( targetWidth > PAGE_A4_WIDTH && targetHeight < PAGE_A4_HEIGHT ) {
			finalWidth = targetWidth * ( PAGE_A4_WIDTH / targetWidth );
			finalHeight = targetHeight;
		// 3. Height 값이 a4보다 클 때
		} else if ( targetWidth < PAGE_A4_WIDTH && targetHeight > PAGE_A4_HEIGHT ) {
			finalWidth = targetWidth;
			finalHeight = targetHeight * ( PAGE_A4_HEIGHT / targetHeight );
		// 4. 둘 다 값이 클 때
		} else {
			finalWidth = targetWidth * ( PAGE_A4_WIDTH / targetWidth );
			finalHeight = targetHeight * ( PAGE_A4_HEIGHT / targetHeight );
		}
		
		thisCanvas.attr( "width", finalWidth );
		thisCanvas.attr( "height", finalHeight );
		
		return thisCanvas;
	};
	
	var analysisExportHWPTimer = null;
	$.fn.KPRAnalysisExportHWP = function( targetName, targetList ) {
		$.ifvProgressControl(true);

		if( !$.fn.ifvmIsNotEmpty( targetName ) ) {
			targetName = "TEMP";
		}
		
		var tableData = new Object();
		var chartData = new Object();
		var hideDivName = "ANLSYSIS_HIDE_";
		var hideDiv = $( "<div id='" + hideDivName + "'></div>" );
		hideDiv.width( "0" );
		hideDiv.height( "0" );
		hideDiv.css( "overflow", "hidden" );
		// hideDiv.hide();
		$( "body" ).append( hideDiv );
		
		var dataEmptyCount = -1;
		var chartIdx = 1;
		if( $.fn.ifvmIsNotEmpty( targetList ) ) {
			$.each(targetList, function( targetIdx, targetObj ) {
				var targetId = targetObj.targetId;
				var targetTag = $( "#" + targetId );
				var childrenTag = targetTag.children();
				
				if( $.fn.ifvmIsNotEmpty( childrenTag ) ) {
					var analysisData = childrenTag.data().analysisData;
					analysisData.targetId = hideDivName;
					
					var tempAnalysisId = hideDivName + analysisData.analysisId;
					
					if( targetId === "TABLE" ) {
						analysisData.analysisId = tempAnalysisId;
						analysisData.exportFlag = true;
						
						$.fn.KPRAnalysisCreateTable( analysisData );
						
						var tempTableAnalysisId = "TABLE_" + tempAnalysisId + "_";
						var tableTag = $( "#" + tempTableAnalysisId );
						var tableTrTagList = tableTag.find( "tr" );
						
						var numberRegExp = new RegExp( "[^0-9]", "g" );
						var totalWidth = tableTag.children().css( "width" ).replace( numberRegExp, "" );
						var totalHeight = tableTag.children().css( "height" ).replace( numberRegExp, "" );
						var rowCount = tableTrTagList.length;
						var colCount = 0;
						var tableRowList = new Array();
						
						$.each( tableTrTagList, function( trTagIdx, tableTrTagList ) {
							var colList = new Array();
							
							var tableTdTagList = $( tableTrTagList ).find( "th, td" );
							if( colCount < tableTdTagList.length ) {
								colCount = tableTdTagList.length;
							}
							
							$.each( tableTdTagList, function( tdTagIdx, tableTdTag ) {
								var tempTableTdTag = $( tableTdTag );

								var addressList = tempTableTdTag.attr( "p" ).split( "," );
								var colAddr = addressList[0];
								var rowAddr = addressList[1];
								
								var colSpan = tempTableTdTag.attr( "colSpan" );
								var rowSpan = tempTableTdTag.attr( "rowSpan" );
								
								var width = tempTableTdTag.css( "width" ).replace( numberRegExp, "" );
								var height = tempTableTdTag.css( "height" ).replace( numberRegExp, "" );
								
								var value = tempTableTdTag.find( ".cellValue" ).text();
								
								var strongFlag = false;
								if( tempTableTdTag.prop( "tagName" ) === "TH" || tempTableTdTag.hasClass( "summary" ) || tempTableTdTag.hasClass( "rowheader" ) ) {
									strongFlag = true;
								}
								
								var alignFlag = false;
								if( tempTableTdTag.hasClass( "value" ) ) {
									alignFlag = true;
								}
								
								colList.push({
									colAddr: colAddr
									, rowAddr: rowAddr
									, colSpan: colSpan
									, rowSpan: rowSpan
									, width: width
									, height: height
									, strongFlag: strongFlag
									, alignFlag: alignFlag
									, value: value
								});
							});
							
							tableRowList.push( colList );
						});
						
						var tableData = {
							targetName: targetObj.targetName
							, analysisTypeCode: analysisData.analysisTypeCode
							, totalWidth: totalWidth
							, totalHeight: totalHeight
							, rowCount: rowCount
							, colCount: colCount
							, tableRowList: tableRowList
						};
						
						tableTag.data( "tableData", tableData );
						tableTag.data( "COMPLETE_FLAG", true );
					} else {
						analysisData.analysisId = tempAnalysisId;
						analysisData.chartWidth = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						analysisData.chartHeight = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						
						$.fn.KPRAnalysisCreateChart( analysisData );

						var tempChartAnalysisId = "CHART_" + tempAnalysisId + "_";
						var chartCanvas = $( "<canvas>" )[0];
						var chartContext = chartCanvas.getContext( "2d" );
						
						chartCanvas.width = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						chartCanvas.height = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						
						var chartTag = $( "#" + tempChartAnalysisId );
						var chartSvgList = chartTag.find( "svg" );
						$.each(chartSvgList, function( chartSvgIdx, chartSvgObj ) {
							var chartImgData = new XMLSerializer().serializeToString( chartSvgObj );

							var numberRegExp = new RegExp( "[^0-9]", "g" );
							var tempChartImgWidth = chartSvgObj.style.width.replace( numberRegExp, "" );
							var tempChartImgHeight = chartSvgObj.style.height.replace( numberRegExp, "" );

							var tempChartImg = new Image();
							tempChartImg.width = tempChartImgWidth;
							tempChartImg.height = tempChartImgHeight;
							tempChartImg.onload = function() {
								var chartSvgObjId = chartSvgObj.id;
								if( chartSvgObjId.indexOf( "legend" ) > -1 ) {
									var legendX = (ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE - tempChartImgWidth) / 2;
									var legendY = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE - tempChartImgHeight;

									chartContext.drawImage( tempChartImg, legendX, legendY );
								} else {
									chartContext.drawImage( tempChartImg, 0, 0 );
								}
								
								if( (chartSvgIdx + 1) === chartSvgList.length ) {
									var dataURL = chartCanvas.toDataURL();

									var width = chartCanvas.width;
									var height = chartCanvas.height;
									var imageExt = dataURL.substring( dataURL.indexOf( "/" ) + 1, dataURL.indexOf( ";" ) );
									var imageEncoding = dataURL.substring( dataURL.indexOf( ";" ) + 1, dataURL.indexOf( "," ) );
									var imageBinaryData = dataURL.substring( dataURL.indexOf( "," ) + 1 );
									var imageSize = imageBinaryData.length;
									
									imageEncoding = imageEncoding.charAt(0).toUpperCase() + imageEncoding.substring( 1 );
									
									var chartData = {
										targetName: targetObj.targetName
										, analysisTypeCode: analysisData.analysisTypeCode
			 							, imageId: chartIdx++
			 							, imageExt: imageExt
			 							, width: width
			 							, height: height
			 							, imageEncoding: imageEncoding
			 							, imageBinaryData: imageBinaryData
			 							, imageSize: imageSize
									};
									chartTag.data( "chartData", chartData );

									chartTag.data( "COMPLETE_FLAG", true );
								}
							};
							tempChartImg.src = "data:image/svg+xml;Base64," + chartImgData;
						});
					}

					dataEmptyCount++;
				}
			});
		}
		
		if( dataEmptyCount !== -1 ) {
			analysisExportHWPTimer = setInterval(function() {
				var hideDivTagChildren = hideDiv.children();
				
				var completeFlagCnt = 0;
				$.each(hideDivTagChildren, function( idx, childObj ) {
					var completeFlag = $( childObj ).data( "COMPLETE_FLAG" );
					
					if( $.fn.ifvmIsNotEmpty( completeFlag ) && completeFlag ) {
						completeFlagCnt++;
					}
				});
				
				if( hideDivTagChildren.length === completeFlagCnt ) {
					clearInterval( analysisExportHWPTimer );
					
					var exportDataList = new Array();
					var imageCnt = 0;
					
					$.each(hideDivTagChildren, function( idx, childObj ) {
						var childObjId = childObj.id;
						var exportData;
						
						if( childObjId.indexOf( "TABLE" ) > -1 ) {
							exportData = $( childObj ).data().tableData;
						} else {
							imageCnt++;
							exportData = $( childObj ).data().chartData;
						}
						exportDataList.push( exportData );
					});
					
					$.ifvPostJSON( "<ifv:action name='getAnalysisExportHWP' />", {
						fileName: targetName
						, imageCnt: imageCnt
						, exportDataList: exportDataList
					}, function( rst ) {
						$.ifvProgressControl(false);
						$( "#" + hideDivName ).remove();

						qtjs.href("<ifv:action name='getAnalysisExportDownload' />" + "?fileName=" + encodeURI( encodeURI( rst.fileName ) ));
					}, function( rst ) {
						$.ifvProgressControl(false);
						$( "#" + hideDivName ).remove();
					});
					
					$.ifvProgressControl(false);
				}
			});
		} else {
			$.ifvProgressControl(false);
			$( "#" + hideDivName ).remove();
			alert( "<spring:message code='C00035' />" );
		}
	};
	
	var analysisExportWordTimer = null;
	$.fn.KPRAnalysisExportWord = function( targetName, targetList ) {
		$.ifvProgressControl(true);

		if( !$.fn.ifvmIsNotEmpty( targetName ) ) {
			targetName = "TEMP";
		}
		
		var tableData = new Object();
		var chartData = new Object();
		var hideDivName = "ANLSYSIS_HIDE_";
		var hideDiv = $( "<div id='" + hideDivName + "'></div>" );
		hideDiv.width( "0" );
		hideDiv.height( "0" );
		hideDiv.css( "overflow", "hidden" );
		// hideDiv.hide();
		$( "body" ).append( hideDiv );
		
		var dataEmptyCount = -1;
		var chartIdx = 1;
		if( $.fn.ifvmIsNotEmpty( targetList ) ) {
			$.each(targetList, function( targetIdx, targetObj ) {
				var targetId = targetObj.targetId;
				var targetTag = $( "#" + targetId );
				var childrenTag = targetTag.children();
				
				if( $.fn.ifvmIsNotEmpty( childrenTag ) ) {
					var analysisData = childrenTag.data().analysisData;
					analysisData.targetId = hideDivName;
					
					var tempAnalysisId = hideDivName + analysisData.analysisId;
					
					if( targetId === "TABLE" ) {
						analysisData.analysisId = tempAnalysisId;
						analysisData.exportFlag = true;
						
						$.fn.KPRAnalysisCreateTable( analysisData );
						
						var tempTableAnalysisId = "TABLE_" + tempAnalysisId + "_";
						var tableTag = $( "#" + tempTableAnalysisId );
						var tableTrTagList = tableTag.find( "tr" );
						
						var numberRegExp = new RegExp( "[^0-9]", "g" );
						var totalWidth = tableTag.children().css( "width" ).replace( numberRegExp, "" );
						var totalHeight = tableTag.children().css( "height" ).replace( numberRegExp, "" );
						var rowCount = tableTrTagList.length;
						var colCount = 0;
						var tableRowList = new Array();
						
						$.each( tableTrTagList, function( trTagIdx, tableTrTagList ) {
							var colList = new Array();
							
							var tableTdTagList = $( tableTrTagList ).find( "th, td" );
							if( colCount < tableTdTagList.length ) {
								colCount = tableTdTagList.length;
							}
							
							$.each( tableTdTagList, function( tdTagIdx, tableTdTag ) {
								var tempTableTdTag = $( tableTdTag );

								var addressList = tempTableTdTag.attr( "p" ).split( "," );
								var colAddr = addressList[0];
								var rowAddr = addressList[1];
								
								var colSpan = tempTableTdTag.attr( "colSpan" );
								var rowSpan = tempTableTdTag.attr( "rowSpan" );
								
								var width = tempTableTdTag.css( "width" ).replace( numberRegExp, "" );
								var height = tempTableTdTag.css( "height" ).replace( numberRegExp, "" );
								
								var value = tempTableTdTag.find( ".cellValue" ).text();
								
								var strongFlag = false;
								if( tempTableTdTag.prop( "tagName" ) === "TH" || tempTableTdTag.hasClass( "summary" ) || tempTableTdTag.hasClass( "rowheader" ) ) {
									strongFlag = true;
								}
								
								var alignFlag = false;
								if( tempTableTdTag.hasClass( "value" ) ) {
									alignFlag = true;
								}
								
								colList.push({
									colAddr: colAddr
									, rowAddr: rowAddr
									, colSpan: colSpan
									, rowSpan: rowSpan
									, width: width
									, height: height
									, strongFlag: strongFlag
									, alignFlag: alignFlag
									, value: value
								});
							});
							
							tableRowList.push( colList );
						});
						
						var tableData = {
							targetName: targetObj.targetName
							, analysisTypeCode: analysisData.analysisTypeCode
							, totalWidth: totalWidth
							, totalHeight: totalHeight
							, rowCount: rowCount
							, colCount: colCount
							, tableRowList: tableRowList
						};
						
						tableTag.data( "tableData", tableData );
						tableTag.data( "COMPLETE_FLAG", true );
					} else {
						analysisData.analysisId = tempAnalysisId;
						analysisData.chartWidth = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						analysisData.chartHeight = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						
						$.fn.KPRAnalysisCreateChart( analysisData );

						var tempChartAnalysisId = "CHART_" + tempAnalysisId + "_";
						var chartCanvas = $( "<canvas>" )[0];
						var chartContext = chartCanvas.getContext( "2d" );
						
						chartCanvas.width = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						chartCanvas.height = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE;
						
						var chartTag = $( "#" + tempChartAnalysisId );
						var chartSvgList = chartTag.find( "svg" );
						$.each(chartSvgList, function( chartSvgIdx, chartSvgObj ) {
							var chartImgData = new XMLSerializer().serializeToString( chartSvgObj );

							var numberRegExp = new RegExp( "[^0-9]", "g" );
							var tempChartImgWidth = chartSvgObj.style.width.replace( numberRegExp, "" );
							var tempChartImgHeight = chartSvgObj.style.height.replace( numberRegExp, "" );

							var tempChartImg = new Image();
							tempChartImg.width = tempChartImgWidth;
							tempChartImg.height = tempChartImgHeight;
							tempChartImg.onload = function() {
								var chartSvgObjId = chartSvgObj.id;
								if( chartSvgObjId.indexOf( "legend" ) > -1 ) {
									var legendX = (ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE - tempChartImgWidth) / 2;
									var legendY = ANALYSIS_EXPORT_OPTION.DEFAULT_SIZE - tempChartImgHeight;

									chartContext.drawImage( tempChartImg, legendX, legendY );
								} else {
									chartContext.drawImage( tempChartImg, 0, 0 );
								}
								
								if( (chartSvgIdx + 1) === chartSvgList.length ) {
									var dataURL = chartCanvas.toDataURL();

									var width = chartCanvas.width;
									var height = chartCanvas.height;
									var imageExt = dataURL.substring( dataURL.indexOf( "/" ) + 1, dataURL.indexOf( ";" ) );
									var imageEncoding = dataURL.substring( dataURL.indexOf( ";" ) + 1, dataURL.indexOf( "," ) );
									var imageBinaryData = dataURL.substring( dataURL.indexOf( "," ) + 1 );
									var imageSize = imageBinaryData.length;
									
									imageEncoding = imageEncoding.charAt(0).toUpperCase() + imageEncoding.substring( 1 );
									
									var chartData = {
										targetName: targetObj.targetName
										, analysisTypeCode: analysisData.analysisTypeCode
			 							, imageId: chartIdx++
			 							, imageExt: imageExt
			 							, width: width
			 							, height: height
			 							, imageEncoding: imageEncoding
			 							, imageBinaryData: imageBinaryData
			 							, imageSize: imageSize
									};
									chartTag.data( "chartData", chartData );

									chartTag.data( "COMPLETE_FLAG", true );
								}
							};
							tempChartImg.src = "data:image/svg+xml;Base64," + chartImgData;
						});
					}

					dataEmptyCount++;
				}
			});
		}
		
		if( dataEmptyCount !== -1 ) {
			analysisExportHWPTimer = setInterval(function() {
				var hideDivTagChildren = hideDiv.children();
				
				var completeFlagCnt = 0;
				$.each(hideDivTagChildren, function( idx, childObj ) {
					var completeFlag = $( childObj ).data( "COMPLETE_FLAG" );
					
					if( $.fn.ifvmIsNotEmpty( completeFlag ) && completeFlag ) {
						completeFlagCnt++;
					}
				});
				
				if( hideDivTagChildren.length === completeFlagCnt ) {
					clearInterval( analysisExportHWPTimer );
					
					var exportDataList = new Array();
					var imageCnt = 0;
					
					$.each(hideDivTagChildren, function( idx, childObj ) {
						var childObjId = childObj.id;
						var exportData;
						
						if( childObjId.indexOf( "TABLE" ) > -1 ) {
							exportData = $( childObj ).data().tableData;
						} else {
							imageCnt++;
							exportData = $( childObj ).data().chartData;
						}
						exportDataList.push( exportData );
					});
					
					$.ifvPostJSON( "<ifv:action name='getAnalysisExportWord' />", {
						fileName: targetName
						, imageCnt: imageCnt
						, exportDataList: exportDataList
					}, function( rst ) {
						$.ifvProgressControl(false);
						$( "#" + hideDivName ).remove();

						qtjs.href("<ifv:action name='getAnalysisExportDownload' />" + "?fileName=" + encodeURI( encodeURI( rst.fileName ) ));
					}, function( rst ) {
						$.ifvProgressControl(false);
						$( "#" + hideDivName ).remove();
					});
					
					$.ifvProgressControl(false);
				}
			});
		} else {
			$.ifvProgressControl(false);
			$( "#" + hideDivName ).remove();
			alert( "<spring:message code='C00035' />" );
		}
	};
</script>