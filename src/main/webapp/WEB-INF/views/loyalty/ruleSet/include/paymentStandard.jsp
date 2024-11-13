<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var paymentStandardListGrid;
var gridIdpaymentStandardListGrid;
var paymentStandardInfoPopupOpenType;
var selPaymentStandardData;

function initPaymentStandard() { }

function initPaymentStandardData() {

	//그리드 설정
	setPaymentStandardListGrid();
}

//결제기준 목록 그리드 설정
function setPaymentStandardListGrid(){
	var _promSubType = $("#promTypeCd").val();

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	//상품별포인트
	colNames.push('적립구분');
	colNames.push('적립금액');
	colNames.push("<spring:message code='L00192'/>");
	/* colNames.push("<spring:message code='L00193'/>"); */
	colNames.push('cardType');
	colNames.push('acrlType');
	colNames.push('rid');

	colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center', resizable : false, sortable:false});
	colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, sortable:false});
	colModel.push({name:'cardTypeNm',index:'', width:'100px', align:'center', resizable : false, sortable:false});
	colModel.push({name:'acrlType', index:'', resizable : false,  hidden : true,  searchable : false});
	colModel.push({name:'cardType', index:'', resizable : false,  hidden : true,  searchable : false});
	/* colModel.push({name:'allianCardYn',index:'', width:'100px', align:'center', resizable : false}); */
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
	    	paymentStandardInfoPopupOpen('E');
        },
	    data: ruleSetData.rulesetPymntStandardList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
	    radio: true,
        tempId : 'ifvGridSimplePageTemplete',
	};

    paymentStandardListGrid = $("#paymentStandardListGrid").ifvGrid({ jqGridOption : jqGridOption });
	//gridIdpaymentStandardListGrid = $("#gridIdpaymentStandardListGrid");
}

//결제기준 정보 팝업 열기
function paymentStandardInfoPopupOpen(type) {

    paymentStandardInfoPopupOpenType = type;

	if (type == "E") {
        var len = paymentStandardListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
            selPaymentStandardData = paymentStandardListGrid.getSelectedRowData();
        }
		else {
			alert("<spring:message code='L00194'/>");

			return false;
		}
	}
	//초기화
	else {
		selPaymentStandardData = {};
	}

    $("#paymentStandardInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="paymentStandardInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00195'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initPaymentStandardInfoPopData(selPaymentStandardData);
        	}
        },
        close : 'paymentStandardInfoPopupClose'
    });
}

//결제기준 정보 팝업 저장
function paymentStandardInfoPopupSave() {
	if (paymentStandardInfoPopValidation.confirm()) {
		var data = {};
		data.cardTypeNm = $.fn.ifvmIsEmpty($("#cardType option:selected").text()) ? null : $("#cardType option:selected").text();
		data.cardType = $.fn.ifvmIsEmpty($("#cardType").val()) ? null : $("#cardType").val();
		data.acrlTypeNm = $.fn.ifvmIsEmpty($("#saveDiv option:selected").text()) ? null : $("#saveDiv option:selected").text();
		data.acrlType = $.fn.ifvmIsEmpty($("#saveDiv").val()) ? null : $("#saveDiv").val();
		data.acrlAmt = $.fn.ifvmIsEmpty($("#amount").val()) ? null : $("#amount").val();
		/* data.allianCardYn = $("input:checkbox[id='allianCardYn']").is(":checked") ? "Y" : "N"; */

        // 단건 등록 설정 일 경우 한건만 등록가능
        /* if (paymentStandardInfoPopupOpenType == "N"
            && chkGridFullCheck(paymentStandardListGrid.getDataRows(), $("#promTypeCd").val(), 0)) {
            return false;
        } */

		// 중복데이터가 존재하는지 체크
		if (paymentStandardInfoPopupOpenType != 'E' && $.fn.ifvmCheckJsonArrayValue(ruleSetData.rulesetPymntStandardList, "cardType", data.cardType)) {
            //alert("<spring:message code='M02205'/>");
            alert('중북된 결제수단입니다.');
            return false;
        }

		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selPaymentStandardData)) {
			selPaymentStandardData.cardTypeNm = data.cardTypeNm;
			selPaymentStandardData.cardType = data.cardType;
			selPaymentStandardData.acrlTypeNm = data.acrlTypeNm;
			selPaymentStandardData.acrlType = data.acrlType;
			selPaymentStandardData.acrlAmt = data.acrlAmt;
			/* selPaymentStandardData.allianCardYn = data.allianCardYn; */

			var idx = paymentStandardListGrid.getRadioSelectedRowId();
			ruleSetData.rulesetPymntStandardList.splice(idx-1, 1, selPaymentStandardData);
			//paymentStandardListGrid.setRowDatas(selPaymentStandardData);
		}
		else {
			paymentStandardListGrid.addLocalTr(data);
			ruleSetData.rulesetPymntStandardList.push(data);
		}

        //전역변수에 값 매핑
        //ruleSetData.ruleSetLimitCardList = paymentStandardListGrid.getAllRowData();
		setPaymentStandardListGrid();
        
		//close popup
		paymentStandardInfoPopupClose();
	}
}

//결제기준 정보 팝업 닫기
function paymentStandardInfoPopupClose() {
	paymentStandardInfoPopup._destroy();
}

//삭제
function paymentStandardRemove() {
	var idx = paymentStandardListGrid.getRadioSelectedRowId();
    var len = idx.length;
    if (len > 0) {
    	paymentStandardListGrid.delRowData();
    	ruleSetData.rulesetPymntStandardList.remove(idx-1+((paymentStandardListGrid.opt.page.currentNum-1)*paymentStandardListGrid.jqGridOption.rowNum));
    	setPaymentStandardListGrid();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

//전체 삭제
function paymentStandardAllRemove() {
	var idx = paymentStandardListGrid.getRadioSelectedRowId();
    var len = idx.length;
    if (len > 0) {
    	paymentStandardListGrid.delRowData();
    	ruleSetData.rulesetPymntStandardList.remove(idx-1+((paymentStandardListGrid.opt.page.currentNum-1)*paymentStandardListGrid.jqGridOption.rowNum));
    	setPaymentStandardListGrid();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 결제기준 초기화
 */
/* function resetRuleSetLimitCardList() {
    if (paymentStandardListGrid.opt.data != null
            && paymentStandardListGrid.opt.data.rows.length > 0 ) {
        paymentStandardListGrid.removeAll();

        //전역변수에 값 매핑
        ruleSetData.ruleSetLimitCardList = paymentStandardListGrid.getAllRowData();
    }
} */

$(document).ready(function() {

	initPaymentStandard();
	initPaymentStandardData();
	setFormAllDisabled();
	
    //저장
    $('#paymentStandardNewBtn').on('click', function() {
    	paymentStandardInfoPopupOpen('N');
    });

    //수정
    /* $("#paymentStandardEditBtn").on('click', function() {
    	paymentStandardInfoPopupOpen('E');
    }); */

    //삭제
    $("#paymentStandardRemoveBtn").on('click', function() {
    	paymentStandardRemove();
    });
});
</script>

<div id="paymentStandardWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="paymentStandardNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <%-- <button class="btn btn-sm" id='paymentStandardEditBtn'>
                <spring:message code="M01853"/>
            </button> --%>
            <button class="btn btn-sm" id='paymentStandardRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="paymentStandardListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="paymentStandardInfoPopup"></div>
