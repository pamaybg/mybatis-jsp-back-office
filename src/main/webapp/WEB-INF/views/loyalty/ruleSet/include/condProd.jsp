<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var condProdListGrid;
var condProdType;
var selCondProdData;


function prodSelectBoxSetting(){
	$.fn.ifvmSetSelectOptionCommCode("type", "RULESET_TYPE", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("targetType", "RULESET_TARGET_TYPE", null, null, true);
}


function initPaymentPolicyData() {
	//그리드 설정
	setCondProdListGrid();
	prodSelectBoxSetting();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setCondProdListGrid() {

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	colNames.push("제한유형");	/* 상품 코드 */
	colNames.push("대상");	/* 상품 코드 */
	colNames.push("<spring:message code='L00200'/>");	/* 상품 코드 */
 	colNames.push("<spring:message code='L00232'/>");   /* 상품명  */
	colNames.push('type');
	colNames.push('targetType');
	colNames.push('prodRid');
	colNames.push('rid');

	colModel.push({name:'typeNm', index:'typeNm', resizable : false, align:'center', width:'80px' });
	colModel.push({name:'targetTypeNm', index:'targetTypeNm', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'prodCd', index:'prodCd', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'prodNm', index:'prodNm', resizable : false, align:'left', width:'100px'});
	colModel.push({name:'type',        index:'type',        resizable : false, hidden : true,  searchable : false} );
	colModel.push({name:'targetType',   index:'targetType',        resizable : false, hidden : true,  searchable : false} );
	colModel.push({name:'prodRid',   index:'prodRid',        resizable : false, hidden : true,  searchable : false} );
	colModel.push({name:'rid',        index:'rid',        resizable : false, hidden : true,  searchable : false} );

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	prodPopupOpen('E');

        },
	    data: ruleSetData.rulesetCondProdList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        sortname: 'lrp.CREATE_DATE',
		sortorder: "desc",
        tempId : 'ifvGridSimpleTemplete'
	};

	condProdListGrid = $("#condProdListGrid").ifvGrid2({ jqGridOption : jqGridOption });
}

//구매가맹점 정보 팝업 열기
function prodPopupOpen(type) {

	condProdType = type;

	if (type == "E") {
        var len = condProdListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selCondProdData = condProdListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selCondProdData = {};
	}

    $("#prodInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condProdInfoPop"/>'+'?prodOpenType='+type,
        contentType: "ajax",
        title: "조건-상품",
        width: '500px',
/*         open: function (args) {
        	if (type == "E") {
        		initCondProdInfoPopData(selCondProdData);
        	}
        }, */
        close : 'condProdInfoPopupClose',
    });
}

//구매가맹점 정보 팝업 저장
function condProdInfoPopupSave() {

	if (condProdInfoPopValidation.confirm()) {
		var data = {};
		data.type = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #type").val()) ? null : $("#condProdInfoPopDiv #type").val();
		data.typeNm = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #type option:selected").text()) ? null : $("#condProdInfoPopDiv #type option:selected").text();
		data.targetType = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #targetType").val()) ? null : $("#condProdInfoPopDiv #targetType").val();
		data.targetTypeNm = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #targetType option:selected").text()) ? null : $("#condProdInfoPopDiv #targetType option:selected").text();
		data.prodCd = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #prodId").val()) ? null : $("#condProdInfoPopDiv #prodId").val();
		data.prodNm = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #prodNm").val()) ? null : $("#condProdInfoPopDiv #prodNm").val();
		data.prodRid = $.fn.ifvmIsEmpty($("#condProdInfoPopDiv #prodRid").val()) ? null : $("#condProdInfoPopDiv #prodRid").val();
		// 단건 등록 설정 일 경우 한건만 등록가능
  /*       if (chkGridFullCheck(rulesetCondProdList.getDataRows(), $("#promSubType").val(), 0)) {
            return false;
        } */


        // 중복체크
        var popSave_strCheckedRid = condProdType == "E" ? condProdListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;
        var popSave_getGridArry = condProdListGrid.getDataRows();

        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = popSave_getGridArry[i].rid == null ? "" : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 아이디가 다른경우
            if ( condProdType == 'N'
                    || (condProdType == 'E' && popSave_strCheckedRid != popSave_getGridArry_rid) ) {

            }

            if ( condProdType =='N' && popSave_getGridArry[i].prodCd == data.prodCd) {
                alert("상품이 중복됩니다.");
                return false;
            }
        }



		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selCondProdData)) {
			selCondProdData.targetType = data.targetType;
			selCondProdData.targetTypeNm = data.targetTypeNm;
			selCondProdData.type = data.type;
			selCondProdData.typeNm = data.typeNm;
			selCondProdData.prodCd = data.prodCd;
			selCondProdData.prodNm = data.prodNm;
			selCondProdData.prodRid = data.prodRid;

			condProdListGrid.setRowDatas(selCondProdData);
		}
		else {
			condProdListGrid.addLocalTr(data);
		}
        //전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = condProdListGrid.getAllRowData();

		//close popup
		condProdInfoPopupClose();
	}
}

//구매가맹점 정보 팝업 닫기
function condProdInfoPopupClose() {
	prodInfoPopup._destroy();
}

//삭제
function prodInfoRemove() {
    var len = condProdListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	condProdListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = condProdListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 구매가맹점 초기화
 */
function resetrulesetCondProdList() {
    if (condProdListGrid.opt.data != null
            && condProdListGrid.opt.data.rows.length > 0 ) {
    	condProdListGrid.removeAll();

        //전역변수에 값 매핑
        ruleSetData.rulesetCondProdList = condProdListGrid.getAllRowData();
    }
}



$(document).ready(function() {
	initPaymentPolicyData();

    //저장
    $('#prodNewBtn').on('click', function() {
    	prodPopupOpen('N');
    });


    //삭제
    $("#prodInfoRemoveBtn").on('click', function() {
    	prodInfoRemove();
    });
});
</script>



<%--  <div class="well mg_bt0 underline form-horizontal" id="condProdInfoDiv">
        <div class="row qt_border">
            기념일
            <label class="col-xs-2 span control-label">제한유형</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="type" names="type" />
                </div>
            </div>

            비교연산자
            <label class="col-xs-2 span control-label">대상</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="targetType" names="targetType"/>
                </div>
            </div>
        </div>
    </div>
 --%>
<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="prodNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='prodInfoRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="condProdListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="prodInfoPopup"></div>
