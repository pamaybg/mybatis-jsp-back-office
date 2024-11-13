<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var condTimeListGrid;
var condTimeData;
var condTimePopupOpenType;
var selCondTimeData;

/**
 * 거래시간 그리드 세팅
 */
function setCondTimeListGrid() {

	var colNames = [];
	var colModel = [];

	colNames.push("<spring:message code='M02473'/>");	/* 시작시간 */
 	colNames.push("<spring:message code='M02474'/>");	/* 종료시간 */
	colNames.push('timeRid');

	colModel.push({name:'startTime', index:'startTime', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'endTime'  , index:'endTime'  , resizable : false, align:'center', width:'80px'});
	colModel.push({name:'ridLoyRulesetTime', index:'ridLoyRulesetTime', resizable: false, hidden: true,  searchable: false});

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	timePopupOpen('E');
        },
	    data: ruleSetData.rulesetCondTimeList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
	    radio: true,
        sortname: 'lrt.CREATE_DATE',
		sortorder: "asc",
        tempId : 'ifvGridSimplePageTemplete'
	};

	condTimeListGrid = $("#condTimeListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 거래시간 입력 팝업 열기
 */
function timePopupOpen(type) {
	
	condTimePopupOpenType = type;
	
	if (type == "E") {
        var len = condTimeListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selCondTimeData = condTimeListGrid.getSelectedRowData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selCondTimeData = {};
	}
	
    $("#timeInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condTimeInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00352'/>",
        width: '500px',
        close : 'condTimeInfoPopupClose',
    });
}

/**
 * 거래시간 추가
 */
function condTimeInfoPopupSave() {
	var isValid = true;

	//1.시간대 유효 체크
	var st = $('#condTimePopDiv #startTime').val();
	var et = $('#condTimePopDiv #endTime').val();
	if(st >= et) {
		alert('<spring:message code="S00069"/>');
		isValid = false;
		return false;
	}
	
	var saveData = {startTime:st, endTime:et};
	var _rulesetCondTimeList = $.extend([], ruleSetData.rulesetCondTimeList);
	if(condTimePopupOpenType === 'E') { //수정인 경우
		//수정대상 데이터를 제외하고 시간대 중복체크한다.
		$.each(ruleSetData.rulesetCondTimeList, function(i, e) {
			if(e.startTime === selCondTimeData.startTime && e.endTime === selCondTimeData.endTime) {
				_rulesetCondTimeList.remove(i);
			}
		});
	}
	
	//2.시간대 중복 체크
	$.each(_rulesetCondTimeList, function(i, e) {
		//시작 or 종료 시간 중복
		if(e.startTime === saveData.startTime || e.endTime === saveData.endTime) {
			alert('<spring:message code="M00258"/>');
			isValid = false;
			return false;
		}
		
		/**
		 * saveData :: ㅇ
		 * e 		:: ㅁ
		*/
		//--ㅇ--ㅁ--ㅇ--ㅁ--
		if(e.startTime > saveData.startTime && saveData.startTime < e.endTime && saveData.endTime < e.endTime) {
			alert('<spring:message code="M00258"/>');
			isValid = false;
			return false;
		}
		
		//--ㅁ--ㅇ--ㅇ--ㅁ--
		if(e.startTime < saveData.startTime && saveData.endTime < e.endTime) {
			alert('<spring:message code="M00258"/>');
			isValid = false;
			return false;
		}
		
		//--ㅁ--ㅇ--ㅁ--ㅇ--
		if(e.startTime < saveData.startTime && saveData.startTime < e.endTime && e.endTime < saveData.endTime) {
			alert('<spring:message code="M00258"/>');
			isValid = false;
			return false;
		}
	});
	
	if(isValid) {
		//수정 or 등록 여부 확인
		if($.fn.ifvmIsNotEmpty(selCondTimeData)) {
			selCondTimeData.startTime = st;
			selCondTimeData.endTime = et;
			
			var idx = condTimeListGrid.getRadioSelectedRowId();
			ruleSetData.rulesetCondTimeList.splice(idx-1, 1, selCondTimeData);
		} else {
			var data = {};
			data.startTime = st;
			data.endTime = et;
			condTimeListGrid.addLocalTr(data);
			ruleSetData.rulesetCondTimeList.push(data);
		}
		
		setCondTimeListGrid();
	}
	
	//condTimeInfoPopupClose();
}

/**
 * 거래시간 입력 팝업 닫기
 */
function condTimeInfoPopupClose() {
	timeInfoPopup._destroy();
}

/**
 * 거래시간 삭제
 */
function timeInfoRemove() {
	var idx = condTimeListGrid.getRadioSelectedRowId();
    var len = idx.length;
    if (len > 0) {
    	condTimeListGrid.delRowData();
        ruleSetData.rulesetCondTimeList.remove(idx-1+((condTimeListGrid.opt.page.currentNum-1)*condTimeListGrid.jqGridOption.rowNum));
        setCondTimeListGrid();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 거래시간 초기화
 */
function resetCondTimeList() {
	condTimeListGrid.removeAll();
	ruleSetData.rulesetCondTimeList = [];
	
	//초기값 세팅
	var initData = {startTime:'00', endTime:'24'};
	condTimeListGrid.addLocalTr(initData);
	ruleSetData.rulesetCondTimeList.push(initData);
	setCondTimeListGrid();
}

$(document).ready(function() {
	setCondTimeListGrid();
	 setFormAllDisabled();
	 
	//저장된 거래시간 없을 경우 00-24시 초기세팅
	if($.fn.ifvmIsEmpty(ruleSetData.rulesetCondTimeList)) {
		resetCondTimeList();
	}

    //신규
    $('#timeNewBtn').on('click', function() {
    	timePopupOpen('N');
    });

    //삭제
    $("#timeInfoRemoveBtn").on('click', function() {
    	timeInfoRemove();
    });
    
    //초기화
    $("#timeInfoResetBtn").on('click', function() {
    	resetCondTimeList();
    });
    
});
</script>



<%--  <div class="well mg_bt0 underline form-horizontal" id="condProdInfoDiv">
        <div class="row qt_border">
            기념일
            <label class="col-xs-2 span control-label">제한유형</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="type" names="type" />
                </div>
            </div>

            비교연산자
            <label class="col-xs-2 span control-label">대상</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="targetType" names="targetType"/>
                </div>
            </div>
        </div>
    </div>
 --%>
<div>
	<div class="page_btn_area" id=''>
	    <div class="col-xs-12 searchbtn_r">
	        <button class="btn btn-sm" id="timeNewBtn">
	            <spring:message code="M01852"/>
	        </button>
	        <button class="btn btn-sm" id='timeInfoRemoveBtn'>
	            <spring:message code="M01854"/>
	        </button>
	        <button class="btn btn-sm" id='timeInfoResetBtn'>
	            <spring:message code="L00031"/>
	        </button>
	    </div>
	</div>
</div>
<div id="condTimeListGrid" class="white_bg grid_bd0"></div>
<div id="timeInfoPopup" class ="popup_container"></div>
