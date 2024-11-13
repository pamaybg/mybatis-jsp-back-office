<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var childOfferGrid;
var childOfferGridDiv;

var childOfferDtlValidation;
var selChildOfferDtlData;    //수정 데이터

var childOfferType = '';     // E : 수정 , N : 등록
var childOfferDtlPopup;      //할인/교환 상품 등록&수정 팝업

function initChildOffer() {

    //그리드 설정
    setChildOfferGrid();

    childOfferDtlValidation = $("#childOfferDtlPop").ifvValidation();
}

/**
 * 하위오퍼 그리드 그리기
 */
function setChildOfferGrid() {

    //colnames
    var colNames = [];

    //colmodel
    var colModel = [];

    //하위오퍼
    colNames.push("<spring:message code='E00004'/>");
    colNames.push("<spring:message code='E00005'/>");
    colNames.push("<spring:message code='E00006'/>");
    colNames.push("<spring:message code='E00007'/>");
    colNames.push("<spring:message code='E00008'/>");
    colNames.push("<spring:message code='E00009'/>");
    colNames.push('childOfferId');

    colModel.push({name:'offerNo',     		index:'', resizable:false, align:'center'});
    colModel.push({name:'offerNm',     		index:'', resizable:false, align:'center'});
    colModel.push({name:'offerTypeCd', 		index:'', resizable:false, align:'center'});
    colModel.push({name:'offerSubTypeCd',  	index:'', resizable:false, align:'center'});
    colModel.push({name:'selfAmt', 			index:'', resizable:false, align:'center', formatter: setSelfAmt});
    colModel.push({name:'selfGiftAmt', 		index:'', resizable:false, align:'center', formatter: $.fn.comma});
    colModel.push({name:'childOfferId',     index:'', resizable:false, hidden : true,  searchable : false});

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
        data: offerData.childOfferList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };

    offerChildOfferGrid = $("#offerChildOfferGrid").ifvGrid2({ jqGridOption : jqGridOption });
    offerChildOfferGridDiv = $("#offerChildOfferGridDiv");
}

function setSelfAmt(cellvalue, options, rowObjec){
    var selfMinAmt = rowObjec.selfMinAmt;
    var selfMaxAmt = rowObjec.selfMaxAmt;
    
   	return (selfMinAmt === undefined || selfMinAmt == null || selfMinAmt.length <= 0) ? "" : selfMinAmt + "~" + selfMaxAmt;
}

/**
 * 하위오퍼 추가 및 수정을 위한 팝업 오픈
 */
function childOfferDtlPopupOpen(type) {

	childOfferType = type;

    if (type == "E") {
        //선택 확인
        var len = offerChildOfferGrid.getRadioSelectedRowId().length;

        if (len > 0) {
            selChildOfferDtlData = offerChildOfferGrid.getSelRadioData();
        }
        else {
            alert("<spring:message code='L00262'/>");
            return false;
        }
    }
    else {
        //초기화
        selChildOfferDtlData = {};
    }

    childOfferDtlPopup = $("#childOfferDtlPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="childOfferDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='E00011'/>",
        width: 500,
        open: function (args) {
            if (type == "E") {
                initChildOfferDtlPopData(selChildOfferDtlData);
            }
        },
        close : 'childOfferDtlPopClose'
    });
}

/**
 * 하위오퍼 수정 팝업 닫기
 */
function childOfferDtlPopClose() {
	childOfferDtlPopup.ejDialog('destroy');
}

/**
 * 하위오퍼 그리드에 추가
 */
function childOfferAdd() {
    
	childOfferDtlValidation = $("#childOfferDtlPop").ifvValidation();
    
    if (childOfferDtlValidation.confirm()) {
        var data = {};
        
        data.parentOfferId 	= $.fn.ifvmIsEmptyNull(offerid);											//상위오퍼 아이디
        data.childOfferId  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #childOfferId").val());		//하위오퍼 아이디
        
        data.offerNo  		= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #offerNo").val());			//오퍼번호
        data.offerNm  		= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #offerNm").val());			//오퍼명
        data.offerTypeCd  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #offerTypeCd").val());		//오퍼유형
        data.offerSubTypeCd = $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #offerSubTypeCd").val());	//오퍼유형상세
        data.selfMinAmt  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #selfMinAmt").val());		//최소 해택 범위
        data.selfMaxAmt  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #selfMaxAmt").val());		//최대 해택 범위
        data.selfUnitCd  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #selfUnitCd").val());		//단위
        data.selfGiftAmt  	= $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #selfGiftAmt").val());		//사은품금액
        data.selfValueRate  = $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #selfValueRate").val());	//가치 비율
        
        //수정 or 등록 여부 확인
        if ($.fn.ifvmIsNotEmpty(selChildOfferDtlData)) {

            data.rid  = $.fn.ifvmIsEmptyNull($("#childOfferDtlPopWrap #rid").val());
            selChildOfferDtlData = data;

            //그리드 row 수정
            offerChildOfferGrid.setRowDatas(data);
        }
        else {
            //그리드 row 추가
            offerChildOfferGrid.addLocalTr(data);
        }

        //전역변수에 값 매핑
        offerData.childOfferList = offerChildOfferGrid.getAllRowData();

        // 그리드 재설정
        setChildOfferGrid();

        //close popup
        childOfferDtlPopClose();
    }
}

/**
 * 현재 그리드에 채널이 저장되어있는지 체크 한다
 *
 * @param checkedData
 * @returns
 */
function chkProductList(_checkedData) {
    for (var i = 0; i < offerData.childOfferList.length; i++) {
        var deskData = offerData.childOfferList[i];
        if (deskData.dataStatus != "D"
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 하위오퍼 삭제
 */
function childOfferInfoRemove() {

    var checkedList = offerChildOfferGrid.getCheckedList();
    if (checkedList.length > 0) {
    	offerChildOfferGrid.delRowData();
    }

    // 전역변수에 값 매핑
    offerData.childOfferList = offerChildOfferGrid.getAllRowData();

    // 그리드 재설정
    setChildOfferGrid();
}

$(document).ready(function() {

    initChildOffer();

    // 신규
    $('#childOfferNewBtn').on('click', function() {
    	childOfferDtlPopupOpen('N');
    });

    // 수정
    $('#childOfferEditBtn').on('click', function() {
    	childOfferDtlPopupOpen('E');
    });

    // 삭제
    $("#childOfferRemoveBtn").on('click', function() {
    	childOfferInfoRemove();
    });

});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="childOfferNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id="childOfferEditBtn">
                <spring:message code="M00259"/>
            </button>
            <button class="btn btn-sm" id='childOfferRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="offerChildOfferGrid" class="white_bg grid_bd0"></div>
</div>
<div id="childOfferDtlPopup"></div>
