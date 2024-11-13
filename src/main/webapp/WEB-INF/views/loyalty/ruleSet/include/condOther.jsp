<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var condOtherListGrid;
var condOtherType;
var selCondOtherData;




function initCondOtherData() {
	//그리드 설정
	setCondOtherListGrid();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setCondOtherListGrid() {

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	colNames.push("유형");	/* 속성 유형 */
	colNames.push("구분");	/* 속성 값*/
	colNames.push("구분값");	/* 적립 구분*/
	colNames.push('rid');
	colNames.push('rulsetEtcCd');
	colNames.push('type');

	colModel.push({name:'rulsetEtcCdNm', index:'rulsetEtcCdNm', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'typeNm',     index:'typeNm',     resizable : false, align:'center', width:'80px'});
	colModel.push({name:'rulsetEtcVal',     index:'rulsetEtcVal',     resizable : false, align:'center', width:'100px'});
	colModel.push({name:'rid',        index:'rid',        resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'rulsetEtcCd',   index:'rulsetEtcCd',   resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'type',   index:'type',   resizable : false, hidden : true,  searchable : false});

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	otherPopupOpen('E');
        },
	    data: ruleSetData.rulesetCondOtherList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
        sortname: 'lre.CREATE_DATE',
		sortorder: "desc",
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};

	condOtherListGrid = $("#condOtherListGrid").ifvGrid2({ jqGridOption : jqGridOption });
}

//구매가맹점 정보 팝업 열기
function otherPopupOpen(type) {

	condOtherType = type;

	if (type == "E") {
        var len = condOtherListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selCondOtherData = condOtherListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selCondOtherData = {};
	}

    $("#otherInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="condOtherInfoPop"/>'+'?otherOpenType='+type,
        contentType: "ajax",
        title: "조건 기타 상세",
        width: '500px',
/*         open: function (args) {
        	if (type == "E") {
        		initDestinationPathInfoPopData(selCondOtherData);
        	}
        }, */
        close : 'otherInfoPopupClose'
    });
}

//구매가맹점 정보 팝업 저장
function otherInfoPopupSave() {
	if (condOtherInfoPopValidation.confirm()) {

		var data = {};
		data.rulsetEtcCdNm = $.fn.ifvmIsEmpty($("#condOtherInfoPopDiv #rulsetEtcCd option:selected").text()) ? null : $("#condOtherInfoPopDiv #rulsetEtcCd option:selected").text();
		data.rulsetEtcCd = $.fn.ifvmIsEmpty($("#condOtherInfoPopDiv #rulsetEtcCd").val()) ? null : $("#condOtherInfoPopDiv #rulsetEtcCd").val();
		data.rulsetEtcVal = $.fn.ifvmIsEmpty($("#condOtherInfoPopDiv #rulsetEtcVal").val()) ? null : $("#condOtherInfoPopDiv #rulsetEtcVal").val();
		data.typeNm = $.fn.ifvmIsEmpty($("#condOtherInfoPopDiv #type option:selected").text()) ? null : $("#condOtherInfoPopDiv #type option:selected").text();
		data.type = $.fn.ifvmIsEmpty($("#condOtherInfoPopDiv #type").val()) ? null : $("#condOtherInfoPopDiv #type").val();


        // 단건 등록 설정 일 경우 한건만 등록가능
  /*       if (chkGridFullCheck(condOtherListGrid.getDataRows(), $("#promSubType").val(), 0)) {
            return false;
        } */

        // 중복체크
        var popSave_strCheckedRid = condOtherType == "E" ? condOtherListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;
        var popSave_getGridArry = condOtherListGrid.getDataRows();

        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = popSave_getGridArry[i].rid == null ? "" : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 아이디가 다른경우
            if ( condOtherType == 'N'
                    || (condOtherType == 'E' && popSave_strCheckedRid != popSave_getGridArry_rid) ) {

            }
        }

		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selCondOtherData)) {
			selCondOtherData.rulsetEtcCdNm = data.rulsetEtcCdNm;
			selCondOtherData.rulsetEtcCd = data.rulsetEtcCd;
			selCondOtherData.rulsetEtcVal = data.rulsetEtcVal;
			selCondOtherData.typeNm = data.typeNm;
			selCondOtherData.type = data.type;

			condOtherListGrid.setRowDatas(selCondOtherData);
		}
		else {
			condOtherListGrid.addLocalTr(data);
		}

        //전역변수에 값 매핑
        ruleSetData.rulesetCondOtherList = condOtherListGrid.getAllRowData();

		//close popup
		otherInfoPopupClose();
	}
}

//구매가맹점 정보 팝업 닫기
function otherInfoPopupClose() {
	otherInfoPopup._destroy();
}

//삭제
function otherInfoRemove() {
    var len = condOtherListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	condOtherListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.rulesetCondOtherList = condOtherListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

/**
 * 구매가맹점 초기화
 */
function resetRulesetCondOtherList() {
    if (condOtherListGrid.opt.data != null
            && condOtherListGrid .opt.data.rows.length > 0 ) {
    	condOtherListGrid.removeAll();

        //전역변수에 값 매핑
        ruleSetData.rulesetCondOtherList = condOtherListGrid.getAllRowData();
    }
}
$(document).ready(function() {
	initCondOtherData();

    //저장
    $('#otherNewBtn').on('click', function() {
    	otherPopupOpen('N');
    });


    //삭제
    $("#otherInfoRemoveBtn").on('click', function() {
    	otherInfoRemove();
    });
});
</script>



<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="otherNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='otherInfoRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="condOtherListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="otherInfoPopup"></div>
