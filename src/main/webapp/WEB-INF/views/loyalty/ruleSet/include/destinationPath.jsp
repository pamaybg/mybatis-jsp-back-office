<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var destinationPathListGrid;
var gridIddestinationPathListGrid;
var destinationPathInfoPopupOpenType;
var selDestinationPathData;

function initDestinationPath() {
}

function initDestinationPathData() {
	//그리드 설정
	setDestinationPathListGrid();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setDestinationPathListGrid() {
	var _promSubType = $("#promSubType").val();
	
	//colnames
	var colNames = [];
	
	//colmodel
	var colModel = [];
	
	colNames.push("<spring:message code='L00630'/>");
	colNames.push("<spring:message code='L00564'/>");
	colNames.push("<spring:message code='L00613'/>");
	colNames.push('rid');
	colNames.push('ridChnl');
	colNames.push('ouTypeCd');
	
	colModel.push({name:'ouTypeCdNm', index:'ouTypeCdNm', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'chnlCd',     index:'chnlCd',     resizable : false, align:'center', width:'80px'});
	colModel.push({name:'chnlNm',     index:'chnlNm',     resizable : false, align:'center', width:'100px'});
	colModel.push({name:'rid',        index:'rid',        resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'ridChnl',   index:'ridChnl',   resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'ouTypeCd',   index:'ouTypeCd',   resizable : false, hidden : true,  searchable : false});
	
	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
        },
	    data: ruleSetData.rulesetLimitPathList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
	    radio: true,
        tempId : 'ifvGridSimplePageTemplete'
	};
	
    destinationPathListGrid = $("#destinationPathListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIddestinationPathListGrid = $("#gridIddestinationPathListGrid");
}

//구매가맹점 정보 팝업 열기
function destinationPathInfoPopupOpen(type) {
	
    destinationPathInfoPopupOpenType = type;
    
	if (type == "E") {
        var len = destinationPathListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
            selDestinationPathData = destinationPathListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selDestinationPathData = {};
	}
	
    $("#destinationPathInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="destinationPathInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02462'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initDestinationPathInfoPopData(selDestinationPathData);
        	}
        },
        close : 'destinationPathInfoPopupClose'
    });
}

//구매가맹점 정보 팝업 저장
function destinationPathInfoPopupSave() {
	if (destinationPathInfoPopValidation.confirm()) {
		var data = {};
		data.ouTypeCd = $.fn.ifvmIsEmpty($("#destinationPathInfoPop #ouTypeCd").val()) ? null : $("#destinationPathInfoPop #ouTypeCd").val();
		data.ouTypeCdNm = $.fn.ifvmIsEmpty($("#destinationPathInfoPop #ouTypeCd option:selected").text()) ? null : $("#destinationPathInfoPop #ouTypeCd option:selected").text();
		data.chnlNm = $.fn.ifvmIsEmpty($("#chnlNm").val()) ? null : $("#chnlNm").val();
		data.chnlCd = $.fn.ifvmIsEmpty($("#chnlCd").val()) ? null : $("#chnlCd").val();
		data.ridChnl = $.fn.ifvmIsEmpty($("#ridChnl").val()) ? null : $("#ridChnl").val();
		
        // 단건 등록 설정 일 경우 한건만 등록가능
        if (chkGridFullCheck(destinationPathListGrid.getDataRows(), $("#promSubType").val(), 0)) {
            return false;
        }
        
        // 중복체크
        var popSave_strCheckedRid = destinationPathInfoPopupOpenType == "E" ? destinationPathListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;
        var popSave_getGridArry = destinationPathListGrid.getDataRows();
        
        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = popSave_getGridArry[i].rid == null ? "" : popSave_getGridArry[i].rid;
            
            // 신규이거나 수정이고 아이디가 다른경우
            if ( destinationPathInfoPopupOpenType == 'N'
                    || (destinationPathInfoPopupOpenType == 'E' && popSave_strCheckedRid != popSave_getGridArry_rid) ) {
                
                //가맹점코드와 가맹점 명이 모두 같은가?
                if ( popSave_getGridArry[i].ouTypeCd == data.ouTypeCd 
                        && popSave_getGridArry[i].chnlCd == data.chnlCd ) {
                    alert("<spring:message code='M02464'/>");
                    return false; 
                }
            }
        }
		
		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selDestinationPathData)) {
			selDestinationPathData.ouTypeCd = data.ouTypeCd;
			selDestinationPathData.ouTypeCdNm = data.ouTypeCdNm;
			selDestinationPathData.chnlNm = data.chnlNm;
			selDestinationPathData.chnlCd = data.chnlCd;
			selDestinationPathData.ridChnl = data.ridChnl;
			
			destinationPathListGrid.setRowDatas(selDestinationPathData);
		}
		else {
		    destinationPathListGrid.addLocalTr(data);
		}

        //전역변수에 값 매핑 
        ruleSetData.rulesetLimitPathList = destinationPathListGrid.getAllRowData();

		//close popup
		destinationPathInfoPopupClose();
	}
}

//구매가맹점 정보 팝업 닫기
function destinationPathInfoPopupClose() {
	destinationPathInfoPopup._destroy();
}

//삭제
function destinationPathRemove() {
    var len = destinationPathListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
        destinationPathListGrid.delRowData();
        
        // 전역변수에 값 매핑 
        ruleSetData.rulesetLimitPathList = destinationPathListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 구매가맹점 초기화
 */
function resetRuleSetLimitPathList() {
    if (destinationPathListGrid.opt.data != null
            && destinationPathListGrid.opt.data.rows.length > 0 ) {
        destinationPathListGrid.removeAll();
        
        //전역변수에 값 매핑
        ruleSetData.rulesetLimitPathList = destinationPathListGrid.getAllRowData();
    }
}
$(document).ready(function() {
	initDestinationPath();
	initDestinationPathData();
	
    //저장
    $('#destinationPathNewBtn').on('click', function() {
    	destinationPathInfoPopupOpen('N');
    });
    
    //수정
    $("#destinationPathEditBtn").on('click', function() {
    	destinationPathInfoPopupOpen('E');
    });
    
    //삭제
    $("#destinationPathRemoveBtn").on('click', function() {
    	destinationPathRemove();
    });
});
</script>

<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="destinationPathNewBtn">
                <spring:message code="M01852"/>
            </button> 
            <button class="btn btn-sm" id='destinationPathEditBtn'>
                <spring:message code="M01853"/>
            </button> 
            <button class="btn btn-sm" id='destinationPathRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="destinationPathListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="destinationPathInfoPopup"></div>
