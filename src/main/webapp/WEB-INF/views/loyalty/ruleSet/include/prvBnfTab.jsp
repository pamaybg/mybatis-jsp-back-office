<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var prvBnfGrid;
var prvBnfGridDiv;

var prvBnfDtlPopup;
var prvBnfDtlType = {};

var selectPrvBnfData;

function initPrvBnfGrid() {

    //colnames
    var colNames = [];
    
    //colmodel
    var colModel = [];
    
    //상품별포인트
    colNames.push("<spring:message code='M02340'/>");
    colNames.push("<spring:message code='M02341'/>");
    colNames.push('acrlType');
    colNames.push('rid');
    
    colModel.push({name:'acrlTypeNm', index:'', resizable:false, align:'center'});
    colModel.push({name:'acrlAmt',    index:'', resizable:false, align:'center'});
    colModel.push({name:'acrlType',   index:'', resizable:false, hidden : true,  searchable : false});
    colModel.push({name:'rid',        index:'', resizable:false, hidden : true,  searchable : false});
    
    var jqGridOption = {
        loadComplete : function(obj) {

        },
        ondblClickRow : function (id) {
        },
        data: ruleSetData.rulesetPrvBnfList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };
    
    prvBnfGrid = $("#prvBnfGridDiv").ifvGrid2({ jqGridOption : jqGridOption });
    prvBnfGridDiv = $("#prvBnfGridDiv");
    
}

/**
 * 혜택수량 상세 팝업 호출
 */
function prvBnfDtlPopupOpen(type) {
    
    prvBnfDtlType = type;
    
    if (type == 'E') {
        var len = prvBnfGrid.getRadioSelectedRowId().length;

        if (len > 0) {
            selectPrvBnfData = prvBnfGrid.getSelRadioData();
        }
        else {
            alert("<spring:message code='L00262'/>");
            return false;
        }
    }
    else {
        selectPrvBnfData = {};
        
        var len = prvBnfGrid.getDataRows().length;
        if (len >= 1) {
            alert("<spring:message code='M02342'/>");
            return;
        }
    }
    
    prvBnfDtlPopup = $("#prvBnfDtlPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prvBnfDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00282'/>",
        width: '500px',
        open: function (args) {
            if (type == "E") {
                initPrvBnfDtl(selectPrvBnfData);
            }
        },
        close : 'prvBnfDtlPopupClose'
    });
}

/**
 * 혜택수량 상세 팝업 닫기
 */
function prvBnfDtlPopupClose() {
    prvBnfDtlPopup.ejDialog('destroy');
}

/**
 * 혜택수량 상세 내용 등록 및 수정 
 */
function addPrvBnfDtl() {

    prvBnfDtlValidation = $("#prvBnfDtlPop").ifvValidation();

    if (prvBnfDtlValidation.confirm()) {
        var data = {};
        
        data.acrlType = $.fn.ifvmIsEmptyNull($("#prvBnfDtlPop #acrlType").val());
        data.acrlTypeNm = $.fn.ifvmIsEmptyNull($("#prvBnfDtlPop #acrlType option:selected").text());
        data.acrlAmt = $.fn.ifvmIsEmptyNull($("#prvBnfDtlPop #acrlAmt").val());

        //수정 or 등록 여부 확인
        if ($.fn.ifvmIsNotEmpty(selectPrvBnfData)) {

            data.rid  = $.fn.ifvmIsEmptyNull($("#prvBnfDtlPop #rid").val());
            selectPrvBnfData = data;

            //그리드 row 수정
            prvBnfGrid.setRowDatas(data);
        }
        else {
            //그리드 row 추가
            prvBnfGrid.addLocalTr(data);
        }

        //전역변수에 값 매핑
        ruleSetData.rulesetPrvBnfList = prvBnfGrid.getAllRowData();

        // 그리드 재설정
        initPrvBnfGrid();

        //close popup
        prvBnfDtlPopupClose();
    }
}

/**
 * 혜택수량 목록에서 선택한 항목 삭제
 */
function removePrvBnfDtl() {
    
    var checkedList = prvBnfGrid.getCheckedList();
    if (checkedList.length > 0) {
        prvBnfGrid.delRowData();
    }

    // 전역변수에 값 매핑
    ruleSetData.rulesetPrvBnfList = prvBnfGrid.getAllRowData();

    // 그리드 재설정
    initPrvBnfGrid();
}

$(document).ready(function() {
    
    initPrvBnfGrid();
    
    // 신규
    $('#prvBnfNewBtn').on('click', function() {
        prvBnfDtlPopupOpen('N');
    });
    
    // 수정
    $('#prvBnfEditBtn').on('click', function() {
        prvBnfDtlPopupOpen('E');
    });
    
    // 삭제
    $('#prvBnfRemoveBtn').on('click', function() {
        removePrvBnfDtl();
    });

});

</script>
<div id="prvBnfListWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="prvBnfNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id="prvBnfEditBtn">
                <spring:message code="M01853"/>
            </button>
            <button class="btn btn-sm" id='prvBnfRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="prvBnfGridDiv" class="white_bg grid_bd0"></div>     
</div>
<div id="prvBnfDtlPopup"></div>
