<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/KPRNodeTree.jsp" />

<script type="text/javascript">
	var analysisListGrid;
	
	function divideScreen() {
		$('.analysis_wrap').split({orientation:'vertical', limit:120, position:'18%'});
		
		$('#vsplitter').attr(" z-index : 999");
		$('.dashboard_wrap').on('resize', function(event){
			analysisListGrid.setWidth();
		});
	}
	
	var showPreviewPop = function( rowData ) {
		var typeCode = rowData.typeCode;

		var previewContainerPopId = "previewPopContainer";
		var previewContainerPop = $( "#" + previewContainerPopId );

		if( $.fn.ifvmIsNotEmpty( previewContainerPop ) ) {
			previewContainerPop.remove();
		}

		var tempPopObj = $( "<div class='popup_container' />" );
		tempPopObj.attr( "id", previewContainerPopId );
		
		if( typeCode === "ANALYSIS" ) {
			tempPopObj.ifvsfPopup({
				enableModal: true
				, enableResize: false
				, contentUrl: "<ifv:url name='analysisPreviewPop'/>"
				, contentType: "ajax"
				, title: "<spring:message code='M01620' />" + " | " + rowData.analysisName
				, width: "800px"
				, beforeOpen: function( args ) {
					getAnalysisPreviewDetail({
						analysisId: rowData.analysisId
						, analysisPreviewPopId: previewContainerPopId
						, analysisMasterFlag: "Y"
					});
				}
			});
		} else {
			tempPopObj.ifvsfPopup({
				enableModal: true
				, enableResize: false
				, contentUrl: "<ifv:url name='dashboardPreviewPop'/>"
				, contentType: "ajax"
				, title: "<spring:message code='M01528' />" + " | " + rowData.analysisName
				, width: "1000px"
				, beforeOpen: function( args ) {
					getDashboardPreviewDetail({
						dashboardId: rowData.analysisId
						, dashboardPreviewPopId: previewContainerPopId
						, analysisMasterFlag: "Y"
					});
				}
			});
		}
	};
	
	var setProgramRegist = function( rowData ) {
		var typeCode = rowData.typeCode;
		
		if( typeCode === "DASHBOARD" ) {			
			var dashboardProgRegSetPopId = "dashboardProgRegSetPop";
			var dashboardProgRegSetPop = $("#" + dashboardProgRegSetPopId);
			
			if ($.fn.ifvmIsEmpty(dashboardProgRegSetPop)) {
				dashboardProgRegSetPop = $("<div class='popup_container' />");
				dashboardProgRegSetPop.attr("id", dashboardProgRegSetPopId);
			}
			
			dashboardProgRegSetPop.data("dashboardData", rowData);
			dashboardProgRegSetPop.ifvsfPopup({
				enableModal: true
				, enableResize: false
				, contentUrl: "<ifv:url name='dashboardProgRegSetPop' />"
				, contentType: "ajax"
				, title : ""
			});
		} else {
			var analysisProgRegSetPop = $( "#analysisProgRegSetPop" );
			var tempPopObj = null;
			
			if( !$.fn.ifvmIsNotEmpty( analysisProgRegSetPop ) ) {
				tempPopObj = $( "<div class='popup_container' />" );
				tempPopObj.attr( "id", "analysisProgRegSetPop" );
			} else {
				tempPopObj = analysisProgRegSetPop;
			}
			
			tempPopObj.ifvsfPopup({
				enableModal: true
				, enableResize: false
				, contentUrl: "<ifv:url name='analysisProgRegSetPop'/>"
				, contentType: "ajax"
				, title: ""
				, beforeOpen: function( args ) {
					getAnalysisProgRegiData( rowData );
				}
			});
		}
	};
	
	var setAnalysisExternalReqeust = function( rowData ) {
		var analysisId = rowData.analysisId;
		var typeCode = rowData.typeCode;
		var analysisExternalRequestPop = $( "#analysisExternalRequestPop" );
		var tempPopObj = null;
		
		if( !$.fn.ifvmIsNotEmpty( analysisExternalRequestPop ) ) {
			tempPopObj = $( "<div class='popup_container' />" );
			tempPopObj.attr( "id", "analysisExternalRequestPop" );
		} else {
			tempPopObj = analysisExternalRequestPop;
		}
		
		// 분석/대시보드 링크 필요 외부 url prompt 체크 로직
		if( typeCode === "ANALYSIS" ) {
			var targetId = rowData.analysisId;
			$.ifvPostJSON("<ifv:action name='selectAnalysisPromptCheck' />", {
				analysisId : targetId
			}, function(rst) {
 				if( rst  != null && rst != '') {
 					
 					$.each(rst, function(index, data) {
	 					if(data.promptTypeCode != "LIST_BOX"){
							tempPopObj.ifvsfPopup({
								enableModal: true
								, enableResize: false
								, contentUrl: "<ifv:url name='analysisExternalRequestPop'/>"
								, contentType: "ajax"
								, title: "<spring:message code='M01790' />"
								, beforeOpen: function( args ) {
									var analysisType = ( typeCode === "ANALYSIS" ) ? typeCode : null;
					
									getAnalysisExternalRequestBase( analysisId, analysisType );
								}
							});
							return false;
						}else{
							alert( "<spring:message code='M02976' />" );
							return false;
						}
 				  	});
				}else{
					alert( "<spring:message code='M02975' />" );
				}

			});
		} else {
			var targetId = rowData.analysisId;

			$.ifvPostJSON("<ifv:action name='selectDashBoardPromptCheck'/>", {
				dashboardId : String(targetId)
			}, function(result){
				if( $.fn.ifvmIsNotEmpty(result)) {
						tempPopObj.ifvsfPopup({
							enableModal: true
							, enableResize: false
							, contentUrl: "<ifv:url name='analysisExternalRequestPop'/>"
							, contentType: "ajax"
							, title: "<spring:message code='M01790' />"
							, beforeOpen: function( args ) {
								var analysisType = ( typeCode === "ANALYSIS" ) ? typeCode : null;
				
								getAnalysisExternalRequestBase( analysisId, analysisType );
							}
						});				
				}else{
					alert( "<spring:message code='M02975' />" );
				}
			});
		}
	};

	var locationMove = function( rowObj ) {
		var typeCode = rowObj.typeCode;
		var targetId = rowObj.analysisId;
		var targetDataSet = new Object();
		var targetUrl = null;

		// 분석/대시보드 링크 필요
		if( typeCode === "ANALYSIS" ) {
			targetDataSet.analysisId = targetId;
			targetUrl = "<ifv:url name='analysisDetail' />" + "?analysisId=";
		} else {
			targetDataSet.dashboardId = targetId;
			targetUrl = "<ifv:url name='dashboardDetail' />" + "?dashboardId=";
		}
		
		$.ifvPostJSON( "<ifv:action name='getAnalysisModifyCheck' />"
		, targetDataSet
		, function( resData ) {
			// 생성자 여부 체크
			var createrFlag = resData.createrFlag;
			
			// 동일 생성자
			if( createrFlag === true ) {
				targetUrl += targetId;

				var message = resData.message;
				var moveFlag = false;

				if( !$.fn.ifvmIsNotEmpty( message ) ) {
					moveFlag = true;
				} else {
					if( confirm( message ) ) {
						moveFlag = true;
					}
				}

				if( moveFlag === true ) {
					qtjs.href(targetUrl);
				}
			// 다른 생성자
			} else {
				if( typeCode === "ANALYSIS" ) {
					// 분석
					$.ifvPostJSON( "<ifv:action name='editAnalysisDetailCopy' />", {
						analysisId: targetId
					}, function( resData ) {
						var analysisId = resData.analysisId;
						targetUrl += analysisId;
						qtjs.href(targetUrl);
					});
				} else {
					// 대시보드
					$.ifvPostJSON( "<ifv:action name='editDashboardDetailCopy' />", {
						dashboardId: targetId
					}, function( resData ) {
						var dashboardId = resData.dashboardId;
						targetUrl += dashboardId;
						qtjs.href(targetUrl);
					});
				}
			}
		});
	};
	function numFormat( cellvalue, options, rowObject ){
		cellvalue = cellvalue.substr(0,19);
		return cellvalue;
	}

	var createAnalysisList = function() {
		var jqGridOptions = {
			ondblClickRow: function( rowId ) {
				var rowObj = analysisListGrid.getRowDatas( rowId );
				locationMove( rowObj );
			}
			, url : "<ifv:action name='getAnalysisList'/>"
			, colNames: [
				"<spring:message code='M01548' />"
				, "<spring:message code='M00180' />"
				, "<spring:message code='M00221' />"
				, "<spring:message code='M00326' />"
				, "<spring:message code='M00250' />"
				, "<spring:message code='M00251' />"
				, "analysisId"
				, "type"
			]
			, colModel: [
				{ name: "analysisName", index: "analysisName", resizable: false }
				, { name: "typeName", index: "typeName", resizable: false }
				, { name: "createName", index: "createName", resizable: false }
				, { name: "createDate", index: "createDate", resizable: false , editable: true, formatter : numFormat }
				, { name: "modifyName", index: "modifyName", resizable: false }
				, { name: "modifyDate", index: "modifyDate", resizable: false , editable: true, formatter : numFormat }
				, { name: "analysisId", hidden: true }
				, { name: "typeCode", hidden: true }
			]
			, sortname: "createDate"
			, sortorder: "desc"
			, tempId: "ifvGridOriginTemplete"
			, radio: true

		};
		
		analysisListGrid = $( "#analysisListGrid" ).ifvGrid({
			jqGridOption: jqGridOptions
		});
	};

	$( document ).ready(function() {
		$(".analysis_wrap").height(900);
	 	divideScreen();
		
		//$( "#nodeMenu" ).ifvsfAccordion();
		$( "#nodeTreeView" ).ifvmCreateKPRNodeTree({
			targetId: "nodeTreeView"
			, reportFlag: "N"
			, setBtn: {
				add: true
				, mod: true
				, del: true
			}
			, nodeClick: function( args ) {
				var target = $( args.currentElement );
				var targetId = target.closest( "li[id]" ).attr( "id" );

				if( $.fn.ifvmIsNotEmpty( targetId ) ) {
					var idIdx = targetId.indexOf( "nodeTreeView_" );
					
					if( idIdx > -1 ) {
						targetId = targetId.substring( ( "nodeTreeView_" ).length );
					}
						//analysisListGrid.opt.grid.setGridParam({ url: "<ifv:action name='getAnalysisList'/>" });
						analysisListGrid.requestData({
							nodeId: targetId
						});
					
				}
			}
			, template : "#baseTreeTemplate"
		});
		$( "#nodeTreeView" ).ifvmKPRNodeTreeSetButton();
		createAnalysisList();

		
		$( "#analysisNew" ).click(function( evt ) {
			qtjs.href("<ifv:url name='analysisDetail' />");
		});
		
		$( "#dashboardNew" ).click(function( evt ) {
			qtjs.href("<ifv:url name='dashboardDetail' />");
		});
		
		$( "#previewRequest" ).click(function( evt ) {
			var rowDataList = analysisListGrid.getRowData();
			
			if( $.fn.ifvmIsNotEmpty( rowDataList ) ) {
				var checkedList = analysisListGrid.getCheckedList();
				
				if( $.fn.ifvmIsNotEmpty( checkedList ) ) {
					showPreviewPop( checkedList[0] );
				} else {
					alert( "<spring:message code='M00004' />" );
				}
				
			} else {
				alert( "<spring:message code='M00004' />" );
			}
		});
		
		$( "#externalRequest" ).click(function( evt ) {
			var rowDataList = analysisListGrid.getRowData();
			
			if( $.fn.ifvmIsNotEmpty( rowDataList ) ) {
				var checkedList = analysisListGrid.getCheckedList();
				
				if( $.fn.ifvmIsNotEmpty( checkedList ) ) {
					setAnalysisExternalReqeust( checkedList[0] );
				} else {
					alert( "<spring:message code='M00004' />" );
				}
			} else {
				alert( "<spring:message code='M00004' />" );
			}
		});
		
		$( "#programRegist" ).click(function( evt ) {
			var rowDataList = analysisListGrid.getRowData();
			
			if( $.fn.ifvmIsNotEmpty( rowDataList ) ) {
				var checkedList = analysisListGrid.getCheckedList();
				
				if( $.fn.ifvmIsNotEmpty( checkedList ) ) {
					setProgramRegist( checkedList[0] );
				} else {
					alert( "<spring:message code='M00004' />" );
				}
			} else {
				alert( "<spring:message code='M00004' />" );
			}
		});
	});
</script>

<div class="page-title">
	<h1><spring:message code="M01545" /> &gt; <spring:message code="M00135" /></h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="previewRequest" objCode="previewRequest_OBJ">
				<spring:message code="M00392" />
			</button>
			<button class="btn btn-sm" id="externalRequest" objCode="externalRequest_OBJ">
				<spring:message code="M01790" />
			</button>
			<button class="btn btn-sm" id="programRegist" objCode="programRegist_OBJ">
				<spring:message code="M00766" />
			</button>
			<button class="btn btn-sm" id="analysisNew" objCode="analysisNew_OBJ">
				<spring:message code="M01533" />
			</button>
			<button class="btn btn-sm" id="dashboardNew" objCode="dashboardNew_OBJ">
				<spring:message code="M01534" />
			</button>
		</div>
	</div>
</div>
<div class="analysis_wrap">
	<div class="analysis_tree">
		<div id="nodeMenu" class="h100">
			<h3 class="acdn_title"><spring:message code="M01536" /></h3>
			<div id="nodeTreeView" class="left_tree_view"></div>
		</div>
	</div>

	<div class="dashboard_wrap">
		<div id="analysisListGrid" class="white_bg grid_bd0"></div>
	</div>
</div>

<script id="analysisOptionTypeCodeTemplate" type="text/x-jquery-tmpl">
    <option value="${'${'}codeName}">${'${'}markName}</option>
</script>