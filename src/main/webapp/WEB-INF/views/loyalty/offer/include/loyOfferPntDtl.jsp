<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var loyOfferPntDtlListGrid;
var gridIdloyOfferPntDtlListGrid;
var loyOfferPntDtlInfoPopupOpenType;
var selLoyOfferPntDtlData;

function initLoyOfferPntDtl() {
}

function initLoyOfferPntDtlData() {
	//그리드 설정
	setLoyOfferPntDtlListGrid();
}

//대상상품 목록 그리드 설정
function setLoyOfferPntDtlListGrid(){
	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	//상품별포인트
	colNames.push("<spring:message code='L00258'/>");
	colNames.push("<spring:message code='L00259'/>");
	colNames.push("<spring:message code='L00260'/>");
	colNames.push('rid');

	colModel.push({name:'validStartdtBasNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'validStartDtnum',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'validEndDtnum',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});

	var jqGridOption = {
 		loadComplete : function(obj){
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
        },
	    data: loyOfferData.pntDtlList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete',
	};

    loyOfferPntDtlListGrid = $("#loyOfferPntDtlListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdloyOfferPntDtlListGrid = $("#gridIdloyOfferPntDtlListGrid");
}

//포인트 정보 팝업 열기
function loyOfferPntDtlInfoPopupOpen(type) {

	if (type == "E") {
		//선택 확인
		var len = loyOfferPntDtlListGrid.getRadioSelectedRowId().length;

		if (len > 0) {
			selLoyOfferPntDtlData = loyOfferPntDtlListGrid.getSelRadioData();
		} else {
			alert("<spring:message code='L00262'/>");

			return false;
		}
	} else {
		//초기화
		selLoyOfferPntDtlData = {};
	}

    $("#loyOfferPntDtlInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyOfferPntDtlInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00263'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initLoyOfferPntDtlInfoPopData(selLoyOfferPntDtlData);
        	}
        },
        close : 'loyOfferPntDtlInfoPopupClose'
    });
}

//대상상품 정보 팝업 저장
function loyOfferPntDtlInfoPopupSave() {
	if (loyOfferPntDtlInfoPopValidation.confirm()) {
		var data = {};
		data.validStartdtBasCd = $.fn.ifvmIsEmptyNull($("#validStartdtBasCd").val());
		data.validStartdtBasNm = $.fn.ifvmIsEmptyNull($("#validStartdtBasCd option:selected").text());
		data.validStartDtnum = $.fn.ifvmIsEmptyNull($("#validStartDtnum").val());
		data.validEndDtnum = $.fn.ifvmIsEmptyNull($("#validEndDtnum").val());
		data.rdmSeq = $.fn.ifvmIsEmptyNull($("#rdmSeq").val());

		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selLoyOfferPntDtlData)) {
			selLoyOfferPntDtlData.validStartdtBasCd = data.validStartdtBasCd;
			selLoyOfferPntDtlData.validStartdtBasNm = data.validStartdtBasNm;
			selLoyOfferPntDtlData.validStartDtnum = data.validStartDtnum;
			selLoyOfferPntDtlData.validEndDtnum = data.validEndDtnum;
			selLoyOfferPntDtlData.rdmSeq = data.rdmSeq;

			//그리드 row 수정
			loyOfferPntDtlListGrid.setRowDatas(selLoyOfferPntDtlData);
		} else {
			//그리드 row 추가
			loyOfferPntDtlListGrid.addLocalTr(data);
		}

		//전역변수에 값 매핑
		loyOfferData.pntDtlList = loyOfferPntDtlListGrid.getAllRowData();

		//close popup
		loyOfferPntDtlInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function loyOfferPntDtlInfoPopupClose() {
	loyOfferPntDtlInfoPopup._destroy();
}

//삭제
function loyOfferPntDtlRemove() {
    //삭제할 row id 및 index 찾기
    var len = loyOfferPntDtlListGrid.getRadioSelectedRowId().length;

    //작업중 일 경우만 삭제 가능
    if (len >= 0) {
    	//그리드 row 삭제
    	loyOfferPntDtlListGrid.delRowData();

    	//전역변수에 값 매핑
		loyOfferData.pntDtlList = loyOfferPntDtlListGrid.getAllRowData();

    } else {
    	alert('<spring:message code="L00249"/>');
    }
}

$(document).ready(function() {
	initLoyOfferPntDtl();
	initLoyOfferPntDtlData();
    //저장
    $('#loyOfferPntDtlNewBtn').on('click', function(){
    	loyOfferPntDtlInfoPopupOpen('N');
    });

    //수정
    $("#loyOfferPntDtlEditBtn").on('click', function(){
    	loyOfferPntDtlInfoPopupOpen('E');
    });

    //삭제
    $("#loyOfferPntDtlRemoveBtn").on('click', function(){
    	loyOfferPntDtlRemove();
    });
});
</script>

<div id="loyOfferPntDtlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="loyOfferPntDtlNewBtn" objCode="loyOfferPntDtlNewBtn_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='loyOfferPntDtlEditBtn' objCode="loyOfferPntDtlEditBtn_OBJ">
                <spring:message code="M01853"/>
            </button>
            <button class="btn btn-sm" id='loyOfferPntDtlRemoveBtn' objCode="loyOfferPntDtlRemoveBtn_OBJ">
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="loyOfferPntDtlListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="loyOfferPntDtlInfoPopup"></div>
