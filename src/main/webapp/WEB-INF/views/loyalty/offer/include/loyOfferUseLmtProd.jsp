<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var loyOfferUseLmtProdListGrid;
var gridIdloyOfferUseLmtProdListGrid;
var loyOfferUseLmtProdInfoPopupOpenType;
var selLoyOfferUseLmtProdData;

function initLoyOfferUseLmtProd() {
}

function initLoyOfferUseLmtProdData() {
	//그리드 설정
	setLoyOfferUseLmtProdListGrid();
}

//대상상품 목록 그리드 설정
function setLoyOfferUseLmtProdListGrid(){
	//colnames
	var colNames = [];
	
	//colmodel
	var colModel = [];
	
	//상품별포인트
	colNames.push("<spring:message code='L00289'/>");
	colNames.push("<spring:message code='L00290'/>");
	colNames.push("<spring:message code='L00291'/>");
	colNames.push("<spring:message code='L00292'/>");
	colNames.push("<spring:message code='L00293'/>");
	colNames.push('rid');
	
	colModel.push({name:'basGrpNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'brdNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'catNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'prodId',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'prodNm',index:'', width:'100px', align:'center', resizable : false});
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
	    data: loyOfferData.useLmtProdList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete',
	};
	
    loyOfferUseLmtProdListGrid = $("#loyOfferUseLmtProdListGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyOfferUseLmtProdListGrid = $("#gridIdloyOfferUseLmtProdListGrid");
}

//포인트 정보 팝업 열기
function loyOfferUseLmtProdInfoPopupOpen(type) {
	
	if (type == "E") {
		if ($.fn.ifvmIsNotEmpty(loyOfferUseLmtProdListGrid.getCheckedList())) {
			selLoyOfferUseLmtProdData = loyOfferUseLmtProdListGrid.getCheckedList()[0];
		} else {
			alert("<spring:message code='L00294'/>");
			
			return false;
		}
	} else {
		//초기화
		selLoyOfferUseLmtProdData = {};
	}
	
    $("#loyOfferUseLmtProdInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyOfferUseLmtProdInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00295'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initLoyOfferUseLmtProdInfoPopData(selLoyOfferUseLmtProdData);
        	}
        },
        close : 'loyOfferUseLmtProdInfoPopupClose'
    });
}

//대상상품 정보 팝업 저장
function loyOfferUseLmtProdInfoPopupSave() {
	if (loyOfferUseLmtProdInfoPopValidation.confirm()) {
		var data = {};
		data.basGrpCd = $.fn.ifvmIsEmptyNull($("#basGrpCd").val());
		data.basGrpNm = $.fn.ifvmIsEmptyNull($("#basGrpCd option:selected").text());
		
		data.ridBrdCat = $.fn.ifvmIsEmptyNull($("#ridBrdCat").val());
		data.brdId = $.fn.ifvmIsEmptyNull($("#brdId").val());
		data.brdNm = $.fn.ifvmIsEmptyNull($("#brdNm").val());
		
		data.ridProdCat = $.fn.ifvmIsEmptyNull($("#ridProdCat").val());
		data.catId = $.fn.ifvmIsEmptyNull($("#catId").val());
		data.catNm = $.fn.ifvmIsEmptyNull($("#catNm").val());
		
		data.ridBrdCat = $.fn.ifvmIsEmptyNull($("#ridProd").val());
		data.prodId = $.fn.ifvmIsEmptyNull($("#prodId").val());
		data.prodNm = $.fn.ifvmIsEmptyNull($("#prodNm").val());
		
		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selLoyOfferUseLmtProdData)) {
			selLoyOfferUseLmtProdData.basGrpCd = data.basGrpCd;
			selLoyOfferUseLmtProdData.basGrpNm = data.basGrpNm;
			
			selLoyOfferUseLmtProdData.ridBrdCat = data.ridBrdCat;
			selLoyOfferUseLmtProdData.brdId = data.brdId;
			selLoyOfferUseLmtProdData.brdNm = data.brdNm;
			
			selLoyOfferUseLmtProdData.ridProdCat = data.ridProdCat;
			selLoyOfferUseLmtProdData.catId = data.catId;
			selLoyOfferUseLmtProdData.catNm = data.catNm;
			
			selLoyOfferUseLmtProdData.ridProd = data.ridProd;
			selLoyOfferUseLmtProdData.prodId = data.prodId;
			selLoyOfferUseLmtProdData.prodNm = data.prodNm;
			
			var _curr = $.fn.ifvmGridSelRowIndex(loyOfferUseLmtProdListGrid);
			
			loyOfferUseLmtProdListGrid.opt.data.rows[_curr] = selLoyOfferUseLmtProdData;
		} else {
			loyOfferUseLmtProdListGrid.opt.data.rows.push(data);
		}
		
		loyOfferData.useLmtProdList = loyOfferUseLmtProdListGrid.opt.data.rows;
		
		//그리드 재설정
		gridIdloyOfferUseLmtProdListGrid.clearGridData();
		gridIdloyOfferUseLmtProdListGrid.setGridParam({data: loyOfferData.useLmtProdList}).trigger("reloadGrid");
		
		//close popup
		loyOfferUseLmtProdInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function loyOfferUseLmtProdInfoPopupClose() {
	loyOfferUseLmtProdInfoPopup._destroy();
}

//삭제
function loyOfferUseLmtProdRemove() {
    //삭제할 row id 및 index 찾기
    var _curr = $.fn.ifvmGridSelectRowIndex("gridIdloyOfferUseLmtProdListGrid");
    
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	loyOfferData.useLmtProdList.splice(_curr, 1);
    } else {
    	alert('<spring:message code="L00249"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdloyOfferUseLmtProdListGrid.clearGridData();
	gridIdloyOfferUseLmtProdListGrid.setGridParam({data: loyOfferData.useLmtProdList}).trigger("reloadGrid");
}

$(document).ready(function() {
	initLoyOfferUseLmtProd();
	initLoyOfferUseLmtProdData();
	
    //저장
    $('#loyOfferUseLmtProdNewBtn').on('click', function(){
    	loyOfferUseLmtProdInfoPopupOpen('N');
    });
    
    //수정
    $("#loyOfferUseLmtProdEditBtn").on('click', function(){
    	loyOfferUseLmtProdInfoPopupOpen('E');
    });
    
    //삭제
    $("#loyOfferUseLmtProdRemoveBtn").on('click', function(){
    	loyOfferUseLmtProdRemove();
    });
});
</script>

<div id="loyOfferUseLmtProdWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="loyOfferUseLmtProdNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferUseLmtProdEditBtn'>
                <spring:message code="M01853"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferUseLmtProdRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="loyOfferUseLmtProdListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="loyOfferUseLmtProdInfoPopup"></div>
