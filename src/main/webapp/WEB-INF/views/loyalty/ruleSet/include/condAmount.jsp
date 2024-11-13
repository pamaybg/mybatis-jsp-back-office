<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var condAmtListGrid;
var condAmtData;

function condSelectBoxSetting(){
	$("#condAmtInfo #startVal").append("<option value='TARGET'>대상</option>");
	$("#condAmtInfo #startVal").append("<option value='NON_TARGET'>제외</option>");

	$("#condAmtInfo #endVal").append("<option value='ALL'>전체</option>");
	$("#condAmtInfo #endVal").append("<option value='DIV'>부분</option>");
}


function initCondAmtData() {
	//그리드 설정
	setCondAmtListGrid();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setCondAmtListGrid() {

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	colNames.push("시작금액");	/* 시작값 */
	colNames.push("종료금액");	/* 종료값*/
	colNames.push("적립 구분");	/* 종료값*/
	colNames.push('type');
	colNames.push('rid');

	colModel.push({name:'startAmt', index:'startAmt', resizable : false, align:'right', width:'80px' ,formatter : 'integer'});
	colModel.push({name:'endAmt',     index:'endAmt',     resizable : false, align:'right', width:'80px',formatter : 'integer'});
	colModel.push({name:'typeNm',     index:'typeNm',     resizable : false, align:'center', width:'80px'});
	colModel.push({name:'type',   index:'type',   resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'rid',   index:'rid',   resizable :  false, hidden : true,  searchable : false});

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	condAmtInfoPopupOpen('E');
        },
	    data: ruleSetData.rulesetCondAmtList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
        sortname: 'lra.CREATE_DATE',
		sortorder: "desc",
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};

	condAmtListGrid = $("#condAmtListGrid").ifvGrid2({ jqGridOption : jqGridOption });
}

//구매가맹점 정보 팝업 열기
function condAmtInfoPopupOpen(type) {


	if (type == "E") {
        var len = condAmtListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	condAmtData = condAmtListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		condAmtData = {};
	}

    $("#condAmtInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condAmtInfoPop"/>'+'?amtOpenType='+type,
        contentType: "ajax",
        title: "조건 금액",
        width: '500px',
        close : 'condAmtInfoPopupClose'
    });
}

//구매가맹점 정보 팝업 저장
function condAmtInfoPopupSave() {

	if (condAmtInfoPopValidation.confirm()) {
		if($("#condAmtInfoPopDiv #startAmt").val()>$("#condAmtInfoPopDiv #startAmt").val()){

		}

		var data = {};
		data.startAmt = $.fn.ifvmIsEmpty($("#condAmtInfoPopDiv #startAmt").val()) ? null : $("#condAmtInfoPopDiv #startAmt").val();

		data.endAmt = $.fn.ifvmIsEmpty($("#condAmtInfoPopDiv #endAmt").val()) ? null : $("#condAmtInfoPopDiv #endAmt").val();


		data.type = $.fn.ifvmIsEmpty($("#condAmtInfoPopDiv #type").val()) ? null : $("#condAmtInfoPopDiv #type").val();
		data.typeNm = $.fn.ifvmIsEmpty($("#condAmtInfoPopDiv #type option:selected").text()) ? null : $("#condAmtInfoPopDiv #type option:selected").text();


		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(condAmtData)) {
			condAmtData.startAmt = data.startAmt;
			condAmtData.endAmt = data.endAmt;
			condAmtData.typeNm = data.typeNm;
			condAmtData.type = data.type;

			condAmtListGrid.setRowDatas(condAmtData);
		}
		else {
			condAmtListGrid.addLocalTr(data);
		}
        //전역변수에 값 매핑
        ruleSetData.rulesetCondAmtList = condAmtListGrid.getAllRowData();

		//close popup
		condAmtInfoPopupClose();
	}

}

//구매가맹점 정보 팝업 닫기
function condAmtInfoPopupClose() {
	condAmtInfoPopup._destroy();

}

//삭제
function condAmtInfoRemove() {
    var len = condAmtListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	condAmtListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.rulesetCondAmtList = condAmtListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

$(document).ready(function() {
	condSelectBoxSetting();
	initCondAmtData();

    //저장
    $('#condAmtInfoNewBtn').on('click', function() {
    	condAmtInfoPopupOpen('N');
    });


    //삭제
    $("#condAmtInfoRemoveBtn").on('click', function() {
    	condAmtInfoRemove();
    });
});
</script>

<%--     <div class="well mg_bt0 underline form-horizontal" id="condAmtInfo">
        <div class="row qt_border">
            기념일
            <label class="col-xs-2 span control-label">시작값</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="startVal" names="startVal" />
                </div>
            </div>

            비교연산자
            <label class="col-xs-2 span control-label">종료값</label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="endVal" names="endVal"/>
                </div>
            </div>
        </div>
    </div> --%>


<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id=condAmtInfoNewBtn>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='condAmtInfoRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="condAmtListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="condAmtInfoPopup"></div>