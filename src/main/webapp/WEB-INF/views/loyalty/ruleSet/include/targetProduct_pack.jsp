<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var targetProductListGrid;
var gridIdtargetProductListGrid;
var targetProductInfoPopupOpenType;
var selTargetProductData;

function initTargetProduct() {
	//패키지유형
	$.fn.ifvmSetSelectOptionCommCode("packType", "LOY_PROD_TYPE", null, null, true);
	$("#packType").val("PROD_GP");
}

function initTargetProductData() {
	//패키지 데이터 설정
	if ($.fn.ifvmIsNotEmpty(ruleSetData.ruleSetPack)) {
		$("#packType").val(ruleSetData.ruleSetPack.packType);
		$("#minQty").val(ruleSetData.ruleSetPack.minQty);
		$("#minAmt").val(ruleSetData.ruleSetPack.minAmt);
	}

	//그리드 설정
	setTargetProductListGrid();
}

//대상상품 목록 그리드 설정
function setTargetProductListGrid() {
//	var _promSubType = $("#promSubType").val();
	var _promSubType = $("#promTypeCd").val();

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	//상품별포인트
	if (_promSubType == "P007") {
		colNames.push("<spring:message code='L00198'/>");
		colNames.push("<spring:message code='M00365'/>");
		colNames.push("<spring:message code='L00199'/>");
		colNames.push("<spring:message code='L00200'/>");
		colNames.push("<spring:message code='L00201'/>");
		colNames.push("<spring:message code='L00202'/>");
		colNames.push('rid');
		colNames.push('prodType');

		colModel.push({name:'prodTypeNm',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'brdId',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'prodCate',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'prodCd',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : numberFormat});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
		colModel.push({name:'prodType', index:'', resizable : false,  hidden : true,  searchable : false});

		$("#packArea").hide();
	}

// 	//패키지포인트
// 	else if (_promSubType == "P008") {
// 		colNames.push("<spring:message code='L00199'/>");
// 		colNames.push("<spring:message code='L00200'/>");
// 		colNames.push("<spring:message code='L00201'/>");
// 		colNames.push("<spring:message code='L00202'/>");
// 		colNames.push('rid');

// 		colModel.push({name:'prodCate',index:'', width:'100px', align:'center', resizable : false});
// 		colModel.push({name:'prodCd',index:'', width:'100px', align:'center', resizable : false});
// 		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : numberFormat});
// 		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
// 		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});

// 		$("#packArea").show();
// 	}

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
	    data: ruleSetData.ruleSetProdList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};

    targetProductListGrid = $("#targetProductListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdtargetProductListGrid = $("#gridIdtargetProductListGrid");
}

//대상상품 정보 팝업 열기
function targetProductInfoPopupOpen(type) {

    targetProductInfoPopupOpenType = type;

	if (type == "E") {

        var len = targetProductListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
            selTargetProductData = targetProductListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00204'/>");
			return false;
		}
	}
	else {
		//초기화
		selTargetProductData = {};
	}

    $("#targetProductInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetProductInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00205'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initTargetProductInfoPopData(selTargetProductData);
        	}
        },
        close : 'targetProductInfoPopupClose'
    });
}

//대상상품 정보 팝업 저장
function targetProductInfoPopupSave() {
	if (targetProductInfoPopValidation.confirm()) {
		var data = {};
		data.prodType = $.fn.ifvmIsEmpty($("#prodType").val()) ? null : $("#prodType").val();
		data.prodTypeNm = $.fn.ifvmIsEmpty($("#prodType option:selected").text()) ? null : $("#prodType option:selected").text();
		data.acrlType = $.fn.ifvmIsEmpty($("#acrlType").val()) ? null : $("#acrlType").val();
		data.acrlTypeNm = $.fn.ifvmIsEmpty($("#acrlType option:selected").text()) ? null : $("#acrlType option:selected").text();
		data.acrlAmt = $.fn.ifvmIsEmpty($("#acrlAmt").val()) ? null : $("#acrlAmt").val();
		data.prodCate = $.fn.ifvmIsEmpty($("#prodCate").val()) ? null : $("#prodCate").val();
		data.brdId = $.fn.ifvmIsEmpty($("#brdId").val()) ? null : $("#brdId").val();
		data.prodCd = $.fn.ifvmIsEmpty($("#prodCd").val()) ? null : $("#prodCd").val();

        // 중복체크
        var popSave_strCheckedRid = targetProductInfoPopupOpenType == "E" ? targetProductListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;

        var popSave_getGridArry = targetProductListGrid.getDataRows();

        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = $.fn.ifvmIsEmpty(popSave_getGridArry[i].rid) ? null : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 id가 다를 경우
            if ( targetProductInfoPopupOpenType == 'N'
                    || (targetProductInfoPopupOpenType == 'E' && popSave_strCheckedRid != popSave_getGridArry[i].rid) ) {

                // 브랜드, 카테고리, 상품이 모두 같은가?
                if ( popSave_getGridArry[i].brdId == data.brdId
                        && popSave_getGridArry[i].prodCate == data.prodCate
                        && popSave_getGridArry[i].prodCd == data.prodCd ) {
                    alert("<spring:message code='M02207'/>");
                    return false;
                }
            }
        }

		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selTargetProductData)) {
			selTargetProductData.prodType = data.prodType;
			selTargetProductData.acrlType = data.acrlType;
			selTargetProductData.acrlTypeNm = data.acrlTypeNm;
			selTargetProductData.acrlAmt = data.acrlAmt;
			selTargetProductData.prodCate = data.prodCate;
			selTargetProductData.brdId = data.brdId;
			selTargetProductData.prodCd = data.prodCd;

            targetProductListGrid.setRowDatas(selTargetProductData);
		}
		else {
            targetProductListGrid.addLocalTr(data);
		}

        //전역변수에 값 매핑
        ruleSetData.ruleSetProdList = targetProductListGrid.getAllRowData();

		//close popup
		targetProductInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function targetProductInfoPopupClose() {
	targetProductInfoPopup._destroy();
}

//삭제
function targetProductRemove() {

    var len = targetProductListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
        targetProductListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.ruleSetProdList = targetProductListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

//패키지 유형 설정
function setpackType() {

	//설정 변경시 대상상품 초기화
	if (confirm("<spring:message code='L00462'/>")) {
	    resetRuleSetProdList();
	}
}

/**
 * 대상상품 초기화
 */
function resetRuleSetProdList() {
    if (targetProductListGrid.opt.data != null
            && targetProductListGrid.opt.data.rows.length > 0 ) {
        targetProductListGrid.removeAll();

        //전역변수에 값 매핑
        ruleSetData.ruleSetProdList = targetProductListGrid.getAllRowData();
    }
}

$(document).ready(function() {
	initTargetProduct();
	initTargetProductData();

    //저장
    $('#targetProductNewBtn').on('click', function() {
    	targetProductInfoPopupOpen('N');
    });

    //수정
    $("#targetProductEditBtn").on('click', function() {
    	targetProductInfoPopupOpen('E');
    });

    //삭제
    $("#targetProductRemoveBtn").on('click', function() {
    	targetProductRemove();
    });

	//패키지유형
	$("[name='packType']").on('change', function() {
		setpackType();
    });
});
</script>

<div id="targetProductWrap">
	<div class="well mg_bt0 underline form-horizontal" id="packArea">
		<div class="row qt_border">
           <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code='L00206'/></label>
           <div class="col-xs-2 control_content">
               <ifvm:input type="select" required="true" id="packType" names="packType" />
        	</div>
    	</div>
    	<div class="row qt_border">
           <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code='L00207'/></label>
           <div class="col-xs-2 control_content">
               <ifvm:input type="text" required="true" id="minQty" names="minQty" />
        	</div>
        	<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code='L00208'/></label>
           	<div class="col-xs-2 control_content">
               <ifvm:input type="text" required="true" id="minAmt" names="minAmt" />
        	</div>
    	</div>
    </div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="targetProductNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='targetProductEditBtn'>
                <spring:message code="M01853"/>
            </button>
            <button class="btn btn-sm" id='targetProductRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="targetProductListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="targetProductInfoPopup"></div>
