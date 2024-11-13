<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var loyOfferUseLmtChnlListGrid;
var gridIdloyOfferUseLmtChnlListGrid;
var loyOfferUseLmtChnlInfoPopupOpenType;
var selLoyOfferUseLmtChnlData;

function initLoyOfferUseLmtChnl() {
}

function initLoyOfferUseLmtChnlData() {
	//그리드 설정
	setLoyOfferUseLmtChnlListGrid();
}

//대상상품 목록 그리드 설정
function setLoyOfferUseLmtChnlListGrid(){
	//colnames
	var colNames = [];
	
	//colmodel
	var colModel = [];
	
	//상품별포인트
	colNames.push("<spring:message code='L00277'/>");
	colNames.push("<spring:message code='L00278'/>");
	colNames.push("<spring:message code='L00279'/>");
	colNames.push("<spring:message code='L00280'/>");
	colNames.push('rid');
	
	colModel.push({name:'usePsblChnlRangeNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'usePsblChnlSubRangeNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'chnlNo',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'chnlNm',index:'', width:'100px', align:'center', resizable : false});
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
	    data: loyOfferData.useLmtChnlList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete',
	};
	
    loyOfferUseLmtChnlListGrid = $("#loyOfferUseLmtChnlListGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyOfferUseLmtChnlListGrid = $("#gridIdloyOfferUseLmtChnlListGrid");
}

//포인트 정보 팝업 열기
function loyOfferUseLmtChnlInfoPopupOpen(type) {
	
	if (type == "E") {
		if ($.fn.ifvmIsNotEmpty(loyOfferUseLmtChnlListGrid.getCheckedList())) {
			selLoyOfferUseLmtChnlData = loyOfferUseLmtChnlListGrid.getCheckedList()[0];
		} else {
			alert("<spring:message code='L00281'/>");
			
			return false;
		}
	} else {
		//초기화
		selLoyOfferUseLmtChnlData = {};
	}
	
    $("#loyOfferUseLmtChnlInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyOfferUseLmtChnlInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00282'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initLoyOfferUseLmtChnlInfoPopData(selLoyOfferUseLmtChnlData);
        	}
        },
        close : 'loyOfferUseLmtChnlInfoPopupClose'
    });
}

//대상상품 정보 팝업 저장
function loyOfferUseLmtChnlInfoPopupSave() {
	if (loyOfferUseLmtChnlInfoPopValidation.confirm()) {
		var data = {};
		data.usePsblChnlRange = $.fn.ifvmIsEmptyNull($("#usePsblChnlRange").val());
		data.usePsblChnlRangeNm = $.fn.ifvmIsEmptyNull($("#usePsblChnlRange option:selected").text());
		data.usePsblChnlSubRange = $.fn.ifvmIsEmptyNull($("#usePsblChnlSubRange").val());
		data.usePsblChnlSubRangeNm = $.fn.ifvmIsEmptyNull($("#usePsblChnlSubRange option:selected").text());
		data.ridChnl = $.fn.ifvmIsEmptyNull($("#ridChnl").val());
		data.chnlNo = $.fn.ifvmIsEmptyNull($("#chnlNo").val());
		data.chnlNm = $.fn.ifvmIsEmptyNull($("#chnlNm").val());
		
		loyOfferData.useLmtChnlList = loyOfferUseLmtChnlListGrid.opt.data.rows;
		
		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selLoyOfferUseLmtChnlData)) {
			selLoyOfferUseLmtChnlData.usePsblChnlRange = data.usePsblChnlRange;
			selLoyOfferUseLmtChnlData.usePsblChnlRangeNm = data.usePsblChnlRangeNm;
			selLoyOfferUseLmtChnlData.usePsblChnlSubRange = data.usePsblChnlSubRange;
			selLoyOfferUseLmtChnlData.usePsblChnlSubRangeNm = data.usePsblChnlSubRangeNm;
			selLoyOfferUseLmtChnlData.ridChnl = data.ridChnl;
			selLoyOfferUseLmtChnlData.chnlNo = data.chnlNo;
			selLoyOfferUseLmtChnlData.chnlNm = data.chnlNm;
			
			var _curr = $.fn.ifvmGridSelRowIndex(loyOfferUseLmtChnlListGrid);
			
			loyOfferData.useLmtChnlList[_curr] = selLoyOfferUseLmtChnlData;
		} else {
			loyOfferData.useLmtChnlList.push(data);
		}
		
		//그리드 재설정
		gridIdloyOfferUseLmtChnlListGrid.clearGridData();
		gridIdloyOfferUseLmtChnlListGrid.setGridParam({data: loyOfferData.useLmtChnlList}).trigger("reloadGrid");
		
		//close popup
		loyOfferUseLmtChnlInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function loyOfferUseLmtChnlInfoPopupClose() {
	loyOfferUseLmtChnlInfoPopup._destroy();
}

//삭제
function loyOfferUseLmtChnlRemove() {
    //삭제할 row id 및 index 찾기
    var _curr = $.fn.ifvmGridSelRowIndex(loyOfferUseLmtChnlListGrid);
	loyOfferData.useLmtChnlList = loyOfferUseLmtChnlListGrid.opt.data.rows;
    
    //작업중 일 경우만 삭제 가능
    if (_curr >= 0) {
    	loyOfferData.useLmtChnlList.splice(_curr, 1);
    } else {
    	alert('<spring:message code="L00249"/>');
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdloyOfferUseLmtChnlListGrid.clearGridData();
	gridIdloyOfferUseLmtChnlListGrid.setGridParam({data: loyOfferData.useLmtChnlList}).trigger("reloadGrid");
}

$(document).ready(function() {
	initLoyOfferUseLmtChnl();
	initLoyOfferUseLmtChnlData();
	
    //저장
    $('#loyOfferUseLmtChnlNewBtn').on('click', function(){
    	loyOfferUseLmtChnlInfoPopupOpen('N');
    });
    
    //수정
    $("#loyOfferUseLmtChnlEditBtn").on('click', function(){
    	loyOfferUseLmtChnlInfoPopupOpen('E');
    });
    
    //삭제
    $("#loyOfferUseLmtChnlRemoveBtn").on('click', function(){
    	loyOfferUseLmtChnlRemove();
    });
});
</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="loyOfferUseLmtChnlNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferUseLmtChnlEditBtn'>
                <spring:message code="M01853"/>
            </button> 
            <button class="btn btn-sm" id='loyOfferUseLmtChnlRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="loyOfferUseLmtChnlListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="loyOfferUseLmtChnlInfoPopup"></div>
