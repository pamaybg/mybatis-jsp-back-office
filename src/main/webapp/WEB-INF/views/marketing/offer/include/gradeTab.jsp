<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var offerGradeGrid;
var offerGradeGridDiv;

var gradeDtlValidation;
var selGradeDtlData;    //수정 데이터

var gradeDtlPopup;      //등급차감 등록&수정 팝업
var gradeType = '';     // E : 수정 , N : 등록

function initGrade() {

    //그리드 설정
    setGradeGrid();

    gradeDtlValidation = $("#gradeDtlPop").ifvValidation();
}

/**
 * 등급차감 그리드 그리기
 */
function setGradeGrid() {

    //colnames
    var colNames = [];

    //colmodel
    var colModel = [];

    //상품별포인트
    colNames.push("<spring:message code='M00180'/>");
    colNames.push("<spring:message code='L00324'/>");
    colNames.push("<spring:message code='M02284'/>");
    colNames.push('rid');
    colNames.push('ridTier');
    colNames.push('type');

    colModel.push({name:'typeNm',  index:'', resizable:false, align:'center'});
    colModel.push({name:'tierNm',  index:'', resizable:false, align:'center'});
    colModel.push({name:'stblAmt', index:'', resizable:false, align:'center'});
    colModel.push({name:'rid',     index:'', resizable:false, hidden : true,  searchable : false});
    colModel.push({name:'ridTier', index:'', resizable:false, hidden : true,  searchable : false});
    colModel.push({name:'type',    index:'', resizable:false, hidden : true,  searchable : false});

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
        data: offerData.gradeList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };

    offerGradeGrid = $("#offerGradeGrid").ifvGrid2({ jqGridOption : jqGridOption });
    offerGradeGridDiv = $("#offerGradeGridDiv");
}

/**
 * 등급 추가 및 수정을 위한 팝업 오픈
 */
function gradeDtlPopupOpen(type) {

    gradeType = type;
    if (type == "E") {
        //선택 확인
        var len = offerGradeGrid.getRadioSelectedRowId().length;

        if (len > 0) {
            selGradeDtlData = offerGradeGrid.getSelRadioData();
        }
        else {
            alert("<spring:message code='L00262'/>");
            return false;
        }
    }
    else {
        //초기화
        selGradeDtlData = {};
    }

    gradeDtlPopup = $("#gradeDtlPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="gradeDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02281'/>",
        width: 500,
        open: function (args) {
            if (type == "E") {
                initGradeDtlPopData(selGradeDtlData);
            }
        },
        close : 'gradeDtlPopClose'
    });
}

/**
 * 등급 수정 팝업 닫기
 */
function gradeDtlPopClose() {
    gradeDtlPopup.ejDialog('destroy');
}

/**
 * 등급차감 그리드에 추가
 */
function gradeAdd() {

    gradeDtlValidation = $("#gradeDtlPop").ifvValidation();
    
    if (gradeDtlValidation.confirm()) {
        var data = {};
        data.type    = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #type").val());
        data.typeNm  = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #type option:selected").text());
        data.tierNm  = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #tierNm").val());
        data.gradeCd  = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #gradeCd").val());
        data.ridTier = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #ridTier").val());
        data.stblAmt = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #stblAmt").val());

        //수정 or 등록 여부 확인
        if ($.fn.ifvmIsNotEmpty(selGradeDtlData)) {

            data.rid  = $.fn.ifvmIsEmptyNull($("#gradeDtlPop #rid").val());
            selGradeDtlData = data;

            //그리드 row 수정
            offerGradeGrid.setRowDatas(data);
        }
        else {
            //그리드 row 추가
            offerGradeGrid.addLocalTr(data);
        }

        //전역변수에 값 매핑
        offerData.gradeList = offerGradeGrid.getAllRowData();

        // 그리드 재설정
        setGradeGrid();

        //close popup
        gradeDtlPopClose();
    }
}

/**
 * 현재 그리드에 채널이 저장되어있는지 체크 한다
 *
 * @param checkedData
 * @returns
 */
function chkGradeList(_checkedData) {
    for (var i = 0; i < offerData.gradeList.length; i++) {
        var deskData = offerData.gradeList[i];
        if (deskData.dataStatus != "D"
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 등급 삭제
 */
function gradeInfoRemove() {

    var checkedList = offerGradeGrid.getCheckedList();
    if (checkedList.length > 0) {
        offerGradeGrid.delRowData();
    }

    // 전역변수에 값 매핑
    offerData.gradeList = offerGradeGrid.getAllRowData();

    // 그리드 재설정
    setGradeGrid();
}

$(document).ready(function() {

    initGrade();

    // 신규
    $('#gradeNewBtn').on('click', function() {
        gradeDtlPopupOpen('N');
    });

    // 수정
    $('#gradeEditBtn').on('click', function() {
        gradeDtlPopupOpen('E');
    });

    // 삭제
    $("#gradeRemoveBtn").on('click', function() {
        gradeInfoRemove();
    });

});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="gradeNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id="gradeEditBtn">
                <spring:message code="M00259"/>
            </button>
            <button class="btn btn-sm" id='gradeRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="offerGradeGrid" class="white_bg grid_bd0"></div>
</div>
<div id="gradeDtlPopup"></div>
