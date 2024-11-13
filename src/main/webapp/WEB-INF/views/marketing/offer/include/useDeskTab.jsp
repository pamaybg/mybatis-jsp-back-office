<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var useDeskGrid;
var gridIduseDeskGrid;

var useDeskInfoPopup;

function initUseDesk() {
    
    //그리드 설정
    setTimeout(setUseDeskGrid, 100);
}

/**
 * 사용처 그리드 그리기 
 */
function setUseDeskGrid() {
    
    //colnames
    var colNames = [];
    
    //colmodel
    var colModel = [];
    
    //상품별포인트
//  colNames.push("<spring:message code='L00630'/>");
    colNames.push("<spring:message code='L00564'/>");
    colNames.push("<spring:message code='V00022'/>");
//  colNames.push("<spring:message code='M02283'/>");
    colNames.push("<spring:message code='L00621'/>");
//  colNames.push("<spring:message code='L00626'/>");
    colNames.push('ridChnl');
    
//  colModel.push({name:'ouTypeCd',      index:'', resizable:false, align:'center'});
    colModel.push({name:'chnlNo',        index:'', resizable:false, align:'center'});
    colModel.push({name:'chnlNm',        index:'', resizable:false, align:'center'});
//  colModel.push({name:'stnMgmtDiv',    index:'', resizable:false, align:'center'});
    colModel.push({name:'parChnlNm',     index:'', resizable:false, align:'center'});
//  colModel.push({name:'pointContType', index:'', resizable:false, align:'center'});
    colModel.push({name:'ridChnl',       index:'', resizable:false, hidden : true,  searchable : false});
    
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
        data: offerData.useDeskList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        multiselect: true,
        tempId : 'ifvGridSimpleTemplete',
    };
    
    useDeskGrid = $("#useDeskGrid").ifvGrid2({ jqGridOption : jqGridOption });
    gridIduseDeskGrid = $("#useDeskGrid");
    gridIduseDeskGrid.resize();
}

/**
 * 사용처 추가를 위한 채널 팝업 오픈
 */
function useDeskInfoPopupOpen() {
    
    $("#useDeskInfoPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="useDeskPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02429'/>",
        width: 800,
        close : 'useDeskPopClose'
    });
}

/**
 * 채널 팝업 닫기 
 */
function useDeskPopClose() {
    useDeskInfoPopup._destroy();
}

/**
 * 채널을 사용처 그리드에 추가 
 */
function useDeskAdd() {
    
    // 중복되지 않는 데이터만 사용처 그리드에 추가 
    var checkedList = useDeskChannelList.getCheckedList();
    for (var i = 0; i < checkedList.length; i++) {

        var checkedData = checkedList[i];
        checkedData.ridChnl = checkedData.rid;
        
        // 수정 : U
        if (chkUseDeskList(checkedData) == true) {
            useDeskGrid.setRowDatas(checkedData);
        }
        // 추가 : I 
        else {
            checkedData.rid = '';
            useDeskGrid.addLocalTr(checkedData);
        }
    }
    
    if (offerData.useDeskList == null) {
        offerData.useDeskList = [];
    }
    
    offerData.useDeskList = useDeskGrid.getAllRowData();
    
    // 그리드 재설정
    setUseDeskGrid();
    
    // close popup
    useDeskPopClose();
}

/**
 * 현재 사용처 그리드에 채널이 저장되어있는지 체크 한다
 * 
 * @param checkedData
 * @returns
 */
function chkUseDeskList(_checkedData) {
    for (var i = 0; i < offerData.useDeskList.length; i++) {
        var deskData = offerData.useDeskList[i];
        if (deskData.dataStatus != "D" 
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 사용처 삭제 
 */
function useDeskInfoRemove() {

    var checkedList = useDeskGrid.getCheckedList();
    if (checkedList.length > 0) {
        useDeskGrid.delRowData();
    }
    
    // 전역변수에 값 매핑
    offerData.useDeskList = useDeskGrid.getAllRowData();
    
    // 그리드 재설정
    setUseDeskGrid();
}

$(document).ready(function() {
    
    // 신규
    $('#useDeskNewBtn').on('click', function() {
        useDeskInfoPopupOpen();
    });

    // 삭제
    $("#useDeskRemoveBtn").on('click', function() {
        useDeskInfoRemove();
    });
    
    initUseDesk();
});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="useDeskNewBtn">
                <spring:message code="M01852"/>
            </button> 
            <button class="btn btn-sm" id='useDeskRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="useDeskGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="useDeskInfoPopup"></div>
