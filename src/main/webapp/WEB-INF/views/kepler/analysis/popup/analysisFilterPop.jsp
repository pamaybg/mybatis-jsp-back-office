<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var FILTER_CONFIG = {};
	FILTER_CONFIG.LGC_OPRT_TYPE_CD_LIST;
	FILTER_CONFIG.ATRIB_GROUP_COL_LIST;

	FILTER_CONFIG.LGC_OPRT_GROUP_CODE = "LGC_OPRT_TYPE_CD";
	
	var setPlusButtonClick = function( evt ) {
		var filterContainer = $( "#analysisFilterContainer" );
		var filterList = filterContainer.children();
		
		var firstRow = filterList[0];
		var emptyRowFlag = $( firstRow ).data( "emptyRow" );
		
		if( filterList.length === 1 && $.fn.ifvmIsNotEmpty( emptyRowFlag ) ) {
			filterContainer.empty();
		}

		createFilterRow();
		setFirstRow();

		$( "#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_POP ).data( "ejDialog" ).refresh();
	};
	
	var setMinusButtonClick = function( evt ) {
		var filterContainer = $( "#analysisFilterContainer" );
		var filterList = filterContainer.children();
		
		if( filterList.length === 1 ) {
			filterContainer.empty();

			createFilterRow();
			setDefaultFirstRow();
		} else {
			$( this ).closest( "div[id]" ).remove();
			setFirstRow();
		}

		$( "#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_POP ).data( "ejDialog" ).refresh();
	};
	
	var setFilterDetailSet = function( evt ) {
		var targetId = $( this ).attr( "id" );
		var underbarIndex = targetId.indexOf( "_" );
		targetId = targetId.substring( 0, underbarIndex );
		
		var thisObj = getFilterObj( targetId, 0 );

		var analysisFilterDetailPop = $( "#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_DETAIL_POP );
		var tempPopObj = null;
		
		if( !$.fn.ifvmIsNotEmpty( analysisFilterDetailPop ) ) {
			tempPopObj = $( "<div class='popup_container' />" );
			tempPopObj.attr( "id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_DETAIL_POP );
		} else {
			tempPopObj = analysisFilterDetailPop;
		}
		
		tempPopObj.ifvsfPopup({
			enableModal: true
			, enableResize: false
			, contentUrl: "<ifv:url name='analysisFilterDetailPop'/>"
			, contentType: "ajax"
			, title: "<spring:message code='M01230' />"
			, width: "920px"
			, ajaxSuccess: function( evt ) {
				getAnalysisFilterDetail( thisObj );
			}
			, open: function( evt ) {
				setAttributeGroupColumnValueList( thisObj.operationTypeCode );
			}
		});
	};
	
	var createFilterRow = function() {
		var filterObj = new Object();
		filterObj.filterId = $.ifvmGetRowID();

		setAnalysisFilterData( filterObj );
	};
	
	var setFilterObjId = function( filterObj ) {
		var objList = filterObj.find( "input, select" );
		var objListLength = objList.length;
		
		for( var idx = 0; idx < objListLength; idx++ ) {
			var filterTagObj = $( objList[idx] );
			var filterTagObjId = filterTagObj.attr( "id" );
			
			filterTagObj.attr( "filterObjId", filterTagObjId.substring( filterTagObjId.indexOf( "_" ) + 1, filterTagObjId.length ) );
		}
	};

	var setAnalysisFilterData = function( filterObj ) {
		var temp = $( "#analysisFilterTemplate" ).tmpl( filterObj );
		setFilterObjId( temp );
		$( "#analysisFilterContainer" ).append( temp );

		var andOrFlagTemplate = $( "#analysisOptionTypeCodeTemplate" ).tmpl( FILTER_CONFIG.LGC_OPRT_TYPE_CD_LIST );
		var andOrFlag = $( "#_andOrFlag" );
		andOrFlag.attr( "filterObjId", "andOrFlag" );
		andOrFlag.append( andOrFlagTemplate );
		if( $.fn.ifvmIsNotEmpty( filterObj.andOrFlag ) ) {
			andOrFlag.val( filterObj.andOrFlag );
		}

		var atribGroupTemplate = $( "#analysisFilterAtribGroupColumnListTemplate" ).tmpl( FILTER_CONFIG.ATRIB_GROUP_COL_LIST );
		var atribGroupColumnId = $( "#_atribGroupColumnId" );
		atribGroupColumnId.append( atribGroupTemplate );
		if( $.fn.ifvmIsNotEmpty( filterObj.atribGroupColumnId ) ) {
			atribGroupColumnId.val( filterObj.atribGroupColumnId );
		}
		atribGroupColumnId.change( atribGroupColumnChange );
		
		var leftBrktFlag = $( "#_leftBrktFlag" );
		if( $.fn.ifvmIsNotEmpty( filterObj.leftBrktFlag ) ) {
			leftBrktFlag.val( filterObj.leftBrktFlag );
		}
		
		var rightBrktFlag = $( "#_rightBrktFlag" );
		if( $.fn.ifvmIsNotEmpty( filterObj.rightBrktFlag ) ) {
			rightBrktFlag.val( filterObj.rightBrktFlag );
		}
		
		var operationTypeCode = $( "#_operationTypeCode" );
		if( $.fn.ifvmIsNotEmpty( filterObj.operationTypeCode ) ) {
			operationTypeCode.val( filterObj.operationTypeCode );
		}
		
		var filterValue = $( "#_filterValue" );
		if( $.fn.ifvmIsNotEmpty( filterObj.filterValue ) ) {
			filterValue.val( filterObj.filterValue );
		}
		
		var codeValue = $( "#_codeValue" );
		if( $.fn.ifvmIsNotEmpty( filterObj.codeValue ) ) {
			codeValue.val( filterObj.codeValue );
		}
		
		var groupFuncTypeCode = $( "#_groupFuncTypeCode" );
		if( $.fn.ifvmIsNotEmpty( filterObj.groupFuncTypeCode ) ) {
			groupFuncTypeCode.val( filterObj.groupFuncTypeCode );
		}
		
		$( "#_plusBtn" ).click( setPlusButtonClick );
		$( "#_minusBtn" ).click( setMinusButtonClick );
		$( "#_filterDetailSet" ).click( setFilterDetailSet );

		var filterId = filterObj.filterId;
		var childList = $( "#" + filterId ).find( "[id*=_]" );
		var childListLength = childList.length;
		
		for( var idx = 0; idx < childListLength; idx++ ) {
			var tag = childList[idx];
			var tagId = $( tag ).attr( "id" );
			$( tag ).attr( "id", filterId + tagId );
		}
	};
	
	var atribGroupColumnChange = function( evt ) {
		var parentDiv = $( this ).closest( "div[id]" );
		
		parentDiv.find( "[id*=_operationTypeCode]" ).val( "" );
		parentDiv.find( "[id*=_filterValue]" ).val( "" );
		parentDiv.find( "[id*=_codeValue]" ).val( "" );
		parentDiv.find( "[id*=_groupFuncTypeCode]" ).val( "" );
		parentDiv.find( "[id*=_groupFuncDetail]" ).val( "" );
	};
	
	var setFirstRow = function() {
		var childList = $( "#analysisFilterContainer" ).children();
		var firstFilterRowObj = childList.eq(0);
		var firstFilterRowObjId = firstFilterRowObj.attr( "id" );

		if( $.fn.ifvmIsNotEmpty( $( "#" + firstFilterRowObjId + "_andOrFlag" ) ) ) {
			$( "#" + firstFilterRowObjId + "_andOrFlag" ).remove();
		}
	};
	
	var setDefaultFirstRow = function() {
		var analysisFilterContainer = $( "#analysisFilterContainer" );
		var firstFilterRow = analysisFilterContainer.children();
		var firstFilterRowChildren = firstFilterRow.children();
		var firstFilterRowChildrenLength = firstFilterRowChildren.length;
		
		for( var idx = 0; idx < firstFilterRowChildrenLength; idx++ ) {
			if( idx !== 0 ) {
				$( firstFilterRowChildren[idx] ).remove();
			}
		}
		
		firstFilterRow.find( "[id*=_minusBtn]" ).remove();
		firstFilterRow.data( "emptyRow", "Y" );
	};
	
	var getFilterObj = function( targetId, seq ) {
		var objList = $( "#" + targetId ).find( "input, select" );
		var objListLength = objList.length;
		var rstObj = new Object();
		rstObj.filterId = targetId;
		rstObj.seq = seq + 1;
		rstObj.analysisId = ANALYSIS_CONFIG.ANALYSIS_ID;
		
		for( var idx = 0; idx < objListLength; idx++ ) {
			var thisObj = objList[idx];
			var _this = $( thisObj );
			
			rstObj[ _this.attr( "filterObjId" ) ] = $.fn.ifvmIsNotEmpty( _this.val() ) ? _this.val() : null ;
		}
		
		var atribGroupColumnId = $( "#" + targetId ).find( "[id*=_atribGroupColumnId]" );
		var atribGroupColumnIdValue = atribGroupColumnId.val();
		var columnTypeCode = $( atribGroupColumnId ).find( "option[value='" + atribGroupColumnIdValue + "']" ).attr( "columnTypeCode" );
		var columnDataType = $( atribGroupColumnId ).find( "option[value='" + atribGroupColumnIdValue + "']" ).attr( "columnDataType" );
		var aliasName = $( atribGroupColumnId ).find( "option[value='" + atribGroupColumnIdValue + "']" ).attr( "aliasName" );
		var singleQuoteFlag = $( atribGroupColumnId ).find( "option[value='" + atribGroupColumnIdValue + "']" ).attr( "singleQuoteFlag" );
		rstObj.columnTypeCode = columnTypeCode;
		rstObj.columnDataType = columnDataType;
		rstObj.atribGroupColumnAlias = aliasName;
		rstObj.singleQuoteFlag = singleQuoteFlag;
		
		return rstObj;
	};
	
	var setAnalysisFilterSave = function( evt ) {
		var analysisFilterContainer = $( "#analysisFilterContainer" );
		var filterTagList = analysisFilterContainer.children();
		var filterList = new Array();
		
		var brktFlag = 0;
		var settingFlag = 0;
		var message = "";
		
		var emptyRow = $( filterTagList[0] ).data( "emptyRow" );
		
		if( !$.fn.ifvmIsNotEmpty( emptyRow ) ) {
			for( var idx = 0; idx < filterTagList.length; idx++ ) {
				var filterTagObj = filterTagList[idx];
				var filterTagObjId = $( filterTagObj ).attr( "id" );
				var filterObj = getFilterObj( filterTagObjId, idx );
				var groupFuncCheckFlag = $( "#" + filterTagObjId + "_groupFuncTypeCode" ).data( "groupFuncCheckFlag" );
				
				// Index 가 0이라면 andOrFlag를 0으로 처리
				if( idx === 0 ) {
					filterObj.andOrFlag = null;
				}
				
				// 괄호 관련 Flag 값이 0 인데, 우괄호가 나오면 에러
				if( brktFlag === 0 && filterObj.rightBrktFlag === "1" ) {
					brktFlag = -1;
					message = "<spring:message code='M01630' />";
					break;
				}
				
				if( filterObj.leftBrktFlag === "1" ) {
					brktFlag = brktFlag + 1;
				}
				
				if( filterObj.rightBrktFlag === "1" ) {
					brktFlag = brktFlag - 1;
				}
				
				// hidden 필드 값 체크 추가
				if( !$.fn.ifvmIsNotEmpty( filterObj.operationTypeCode ) ) {
					settingFlag = -1;
					message += "<spring:message code='M01631' />".cFormat( [ filterObj.seq ] );
					break;
				}
				
				if( !$.fn.ifvmIsNotEmpty( filterObj.filterValue ) ) {
					settingFlag = -1;
					message += "<spring:message code='M01631' />".cFormat( [ filterObj.seq ] );
					break;
				}
				
				if( groupFuncCheckFlag == true && !$.fn.ifvmIsNotEmpty( filterObj.groupFuncTypeCode ) ) {
					settingFlag = -1;
					message += "<spring:message code='M01631' />".cFormat( [ filterObj.seq ] );
					break;
				}
				
				filterList.push( filterObj );
			}
		}

		if( brktFlag === 0 && settingFlag === 0 ) {
			var saveFlag = confirm( "<spring:message code='M01632' />" );
			
			if( saveFlag === true ) {
				$.ifvPostJSON( "<ifv:action name='saveAnalysisFilterList' />", {
					analysisId: ANALYSIS_CONFIG.ANALYSIS_ID
					, analysisMasterFlag: ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
					, filterList: filterList
				}, function( rst ) {
					alert( "<spring:message code='C00094' />" );

					ANALYSIS_CONFIG.FILTER_COUNT = filterList.length;
					ANALYSIS_FILTER_POP._destroy();
				});
			}
		} else {
			alert( message );
		}
	};
	
	var setFilterDetailObj = function( targetObj ) {
		var filterId = targetObj.filterId;

		$( "#" + filterId + "_operationTypeCode" ).val( targetObj.operationTypeCode );
		$( "#" + filterId + "_filterValue" ).val( targetObj.filterValue );
		$( "#" + filterId + "_codeValue" ).val( targetObj.codeValue );
		$( "#" + filterId + "_groupFuncTypeCode" ).val( targetObj.groupFuncTypeCode );
		$( "#" + filterId + "_groupFuncTypeCode" ).data( "groupFuncCheckFlag", targetObj.groupFuncCheckFlag );
		
		ANALYSIS_FILTER_DETAIL_POP._destroy();
	};

	$(document).ready(function() {
		// 1. 로지컬 컴포넌트 필드 리스트와 AND, OR를 가져온다.
		$.ifvSyncPostJSON( "<ifv:action name='getAnalysisFilterBase' />", {
			analysisId: ANALYSIS_CONFIG.ANALYSIS_ID
			, logicalCompId: ANALYSIS_CONFIG.LOGICAL_COMP_ID
			, operationGroupCode: FILTER_CONFIG.LGC_OPRT_GROUP_CODE
		}, function( rst ) {
			// 1-1. 가져온 데이터를 저장한다.
			FILTER_CONFIG.LGC_OPRT_TYPE_CD_LIST = rst.operationCodeList; // 공통 코드 리스트
			FILTER_CONFIG.ATRIB_GROUP_COL_LIST = rst.atribGroupColumnIdList; // 어트리뷰트 그룹 컬럼 아이디 리스트
		});

		// 2. 선택한 분석아이디로 설정된 Filter가 있는지 검색한다.
		$.ifvSyncPostJSON( "<ifv:action name='getAnalysisFilterList' />", {
			analysisId: ANALYSIS_CONFIG.ANALYSIS_ID
			, analysisMasterFlag: ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function( rst ) {
			if( $.fn.ifvmIsNotEmpty( rst ) ) {
				// 2-1. 설정된 Filter가 있다면, 해당 Filter로 데이터를 세팅해준다.
				rst.forEach(function( filterObj, idx ) {
					setAnalysisFilterData( filterObj );
				});

				// 첫번째 Row에서 -버튼을 안보이게 하고, andOrFlag Select 박스를 제거한다.
				setFirstRow();
			} else {
				// 2-2. 설정된 Filter가 없다면, 초기 하나의 Row를 생성해준다.
				createFilterRow();
				setDefaultFirstRow();
			}
		});
		
		$( "#analysisFilterSaveBtn" ).click(function( evt ) {
			setAnalysisFilterSave();
		});

		$( "#analysisFilterCancelBtn" ).click(function( evt ) {
			ANALYSIS_FILTER_POP._destroy();
		});
	});
</script>

<div class="pop_inner_wrap" style="max-height: 210px;overflow-y: auto;">
	<div id="analysisFilterContainer"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisFilterSaveBtn">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisFilterCancelBtn"><spring:message code="C00040" /></button>
</div>

<script id="analysisFilterTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border SearchCondition" id=${'${'}filterId}>
	<div class="flex_btn_area">
		<button class="common_analysis_btn" id="_plusBtn"><img src="<ifv:image name='btn_plus'/>" alt="" /></button>
		<button class="common_analysis_btn" id="_minusBtn"><img src="<ifv:image name='btn_minus'/>" alt="" /></button>
	</div>
	<div class="col-xs-2 mkt_input_pd_rt">
		<ifv:input type="select" id="_andOrFlag" />
	</div>
	<div class="col-xs-1 mkt_input_pd_rt">
		<select id="_leftBrktFlag">
			<option value="0"></option>
			<option value="1">(</option>
		</select>
	</div>
	<div class="col-xs-3 mkt_input_pd_rt">
		<ifv:input type="select" id="_atribGroupColumnId" />
	</div>
	<div class="col-xs-1 mkt_input_pd_rt">
		<select id="_rightBrktFlag">
			<option value="0"></option>
			<option value="1">)</option>
		</select>
	</div>
	<div class="col-xs-2 analysisFilterBtn">
		<ifv:input type="hidden" id="_operationTypeCode" />
		<ifv:input type="hidden" id="_codeValue" />
		<ifv:input type="hidden" id="_filterValue" />
		<ifv:input type="hidden" id="_groupFuncTypeCode" />
		<button class="analysisFilterDetail" id="_filterDetailSet"><spring:message code="M01230" /></button>
	</div>
</div>
</script>

<script id="analysisFilterAtribGroupColumnListTemplate" type="text/x-jquery-tmpl">
    <option value=${'${'}atribGroupColumnId} columnTypeCode=${'${'}columnTypeCode} columnDataType=${'${'}columnDataType} aliasName="${'${'}aliasName}" singleQuoteFlag=${'${'}singleQuoteFlag}>${'${'}displayName}</option>
</script>