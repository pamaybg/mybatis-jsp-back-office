<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var expDividGrid;
var expDividGridDiv;

var expDividDtlValidation;
var selExpDividDtlData;  // 수정 데이터

var expDividDtlPopup;    // 재원 등록, 수정 팝업
var expDividType = '';   // E : 수정 , N : 등록

function initExpDivid() {

    //그리드 설정
    setExpDividGrid();

    expDividDtlValidation = $("#expDividDtlPop").ifvValidation();
}

/**
 * 재원 그리드 그리기
 */
function setExpDividGrid() {
    var ejGridOption = {
        loadComplete : function(obj) {
            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId : 'dialog',
                contentsId : 'dialogPopupWrap'
            });
        },
        editSettings: {
        	 allowAdding: true
        	,allowDeleting: true
        },
        dataSource: offerData.expDividList,
        datatype: 'clientSide',

        columns: [
        		{
	      		  field : 'dividorTypeNm', headerText : '<spring:message code="M00690"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'dividor', headerText : '<spring:message code="M02288"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'dividVal', headerText : '<spring:message code="M02289"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'settleTypeNm', headerText : '<spring:message code="M00921"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'dividDesc', headerText : '<spring:message code="L01024"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'dividorTypeCd', headerText : 'dividorTypeCd', visible : false,
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'settleTypeCd', headerText : 'settleTypeCd', visible : false,
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'ridDividorChnl', headerText : 'ridDividorChnl', visible : false,
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'dividUnit', headerText : 'dividUnit', visible : false,
	      		  customAttributes : {
	      			  index : '' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : '' }
	      	  },
        ],
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };

    expDividGrid = $("#expDividGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    expDividGridDiv = $("#expDividGridDiv");
}

/**
 * 할인/교환 상품 추가 및 수정을 위한 팝업 오픈
 */
function expDividDtlPopupOpen(type) {
    expDividType = type;

    if (type == "E") {
        //선택 확인
        var len = expDividGrid.opt.gridControl.getSelectedRecords().length;

        if (len > 0) {
            selExpDividDtlData = expDividGrid.opt.gridControl.getSelectedRecords()[0];
        }
        else {
            alert("<spring:message code='L00262'/>");
            return false;
        }
    }
    else {
        //초기화
        selExpDividDtlData = {};
    }

    expDividDtlPopup = $("#expDividDtlPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="expDividDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02282'/>",
        width: 500,
        open: function (args) {
            if (type == "E") {
                initExpDividDtlPopData(selExpDividDtlData);
            }
        },
        close : 'expDividDtlPopClose'
    });
}

/**
 * 할인/교환 상품 수정 팝업 닫기
 */
function expDividDtlPopClose() {
    expDividDtlPopup.ejDialog('destroy');
}

/**
 * 할인/교환 상품 그리드에 추가
 */
function expDividAdd() {

    var dividorTypeCd = $("#expDividDtlPop #dividorTypeCd").val();
    var chkExpDividDtlValidation = true;

//     // 자사 or 사용자 전체가 아닌 경우 필수 입력값 체크필요
//     if (dividorTypeCd != 'ALL' && dividorTypeCd != 'MYCOM') {
//         chkExpDividDtlValidation = expDividDtlValidation.confirm();
//     }

    if (chkExpDividDtlValidation) {
        var data = {};
        data = $("#expDividDtlPop").getSubmitData();
        data.dividorTypeNm  = $.fn.ifvmIsEmptyNull($("#expDividDtlPop #dividorTypeCd option:selected").text());
        data.settleTypeNm   = $.fn.ifvmIsEmptyNull($("#expDividDtlPop #settleTypeCd option:selected").text());

        //수정 or 등록 여부 확인
        if ($.fn.ifvmIsNotEmpty(selExpDividDtlData)) {
            $.extend(offerData.expDividList[expDividGrid.opt.gridControl.selectedRowsIndexes[0]], data)
			expDividGrid.opt.gridControl._setModel('dataSource', offerData.expDividList);
        }
        else {
            //그리드 row 추가
            expDividGrid.opt.gridControl.addRecord(data);
        }

        //전역변수에 값 매핑
        offerData.expDividList = expDividGrid.opt.gridControl.model.currentViewData;

        // 그리드 재설정
        setExpDividGrid();

        //close popup
        expDividDtlPopClose();
    }
}

/**
 * 현재 그리드에 채널이 저장되어있는지 체크 한다
 *
 * @param checkedData
 * @returns
 */
function chkExpDividList(_checkedData) {
    for (var i = 0; i < offerData.expDividList.length; i++) {
        var deskData = offerData.expDividList[i];
        if (deskData.dataStatus != "D"
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 할인/교환 상품 삭제
 */
function expDividInfoRemove() {

    var checkedList = expDividGrid.opt.gridControl.getSelectedRecords();
    if (checkedList.length > 0) {
//         expDividGrid.delRowData();
        expDividGrid.opt.gridControl.deleteRow();
    }

    // 전역변수에 값 매핑
    //offerData.expDividList = expDividGrid.getAllRowData();
    offerData.expDividList = expDividGrid.opt.gridControl.model.currentViewData;

    // 그리드 재설정
    setExpDividGrid();
}

$(document).ready(function() {

    initExpDivid();

    // 신규
    $('#expDividNewBtn').on('click', function() {
        expDividDtlPopupOpen('N');
    });

    // 수정
    $('#expDividEditBtn').on('click', function() {
        expDividDtlPopupOpen('E');
    });

    // 삭제
    $("#expDividRemoveBtn").on('click', function() {
        expDividInfoRemove();
    });

});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="expDividNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id="expDividEditBtn">
                <spring:message code="M00259"/>
            </button>
            <button class="btn btn-sm" id='expDividRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="expDividGrid" class="white_bg grid_bd0"></div>
</div>
<div id="expDividDtlPopup"></div>