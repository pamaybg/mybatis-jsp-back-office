<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var specificDayListGrid;
var specificDayInfoPopupOpenType;
var selSpecificDayData;
//특정일 목록 그리드 설정
function setSpecificDayListGrid() {

	var colNames = [];
    var colModel = [];

    colNames.push("일");
	colModel.push({name:'specificDayName',index:'specificDayName', width:'100px', align:'center', resizable : false});

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
	    data: ruleSetData.rulesetSpecificDayList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete'
	};

	specificDayListGrid = $("#specificDayListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//대상상품 정보 팝업 열기
function specificDayInfoPopupOpen(type) {

	specificDayInfoPopupOpenType = type;

	if (type == "E") {

        var len = targetProductListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selSpecificDayData = specificDayListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00204'/>");
			return false;
		}
	}
	else {
		//초기화
		selSpecificDayData = {};
	}

    $("#specificDayInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="specificDayInfoPop"/>',
        contentType: "ajax",
        title: "특정일",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initSpecificDayInfoPopData(selSpecificDayData);
        	}
        },
        close : 'specificDayInfoPopupClose'
    });
}

//대상상품 정보 팝업 저장
function specificDayInfoPopupSave() {
	specificDayInfoPopValidation = $("#specificDayInfoPopDiv").ifvValidation();
	if (specificDayInfoPopValidation.confirm()) {
		var data = {};
		data.specificDay = $.fn.ifvmIsEmpty($("#specificDayInfoPopDiv #days").val()) ? null : $("#specificDayInfoPopDiv #days").val();
		data.specificDayName = $.fn.ifvmIsEmpty($("#specificDayInfoPopDiv #days option:selected").text()) ? null : $("#specificDayInfoPopDiv #days option:selected").text();
		// 중복체크
        var popSave_strCheckedRid = specificDayInfoPopupOpenType == "E" ? specificDayListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;

        var popSave_getGridArry = specificDayListGrid.getRowDatas();

        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = $.fn.ifvmIsEmpty(popSave_getGridArry[i].rid) ? null : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 id가 다를 경우
            if ( specificDayInfoPopupOpenType == 'N'
                    || (specificDayInfoPopupOpenType == 'E' && popSave_strCheckedRid != popSave_getGridArry[i].rid) ) {

            }
        }
        var dupCheck = false;
        //중복 체크
        ruleSetData.rulesetSpecificDayList.forEach(function (item, index, array){
        	if(item.specificDay == data.specificDay){
        		alert("이미 등록된 일자 입니다.");
        		dupCheck = true;
            	return false;
        	}

        });

        if(dupCheck){
        	return true;
        }

        //All 등록시 초기화
        if(data.specificDay == 'ALL'){
        	ruleSetData.rulesetSpecificDayList = [];
        }else{
        	//ALL상태에서 일자가 선택될 경우 ALL 삭제
        	ruleSetData.rulesetSpecificDayList.forEach(function (item, index, array){
        		if(item.specificDay == 'ALL'){
                	ruleSetData.rulesetSpecificDayList = [];
                	return false;
                }

       		});

        }


        //전역변수에 값 매핑
        ruleSetData.rulesetSpecificDayList.push(data);

        setSpecificDayListGrid();

		//close popup
		specificDayInfoPopupClose();
	}
}

//대상상품 정보 팝업 닫기
function specificDayInfoPopupClose() {
    $('#specificDayInfoPopup').ejDialog('destroy');
}

//삭제
function specificDayRemove() {

    var len = specificDayListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
    	specificDayListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.rulesetSpecificDayList = specificDayListGrid.getRowData();


        if(ruleSetData.rulesetSpecificDayList.length == 0){
        	ruleSetData.rulesetSpecificDayList.push({specificDay : 'ALL'});
        	setSpecificDayListGrid();
        	alert("특정일은 기본값이 ALL입니다.");
        }


    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

$(document).ready(function() {
	setSpecificDayListGrid();
	setFormAllDisabled();

    //저장
    $('#specificDayNewBtn').on('click', function() {
    	specificDayInfoPopupOpen('N');
    });

    //삭제
    $("#specificDayRemoveBtn").on('click', function() {
    	specificDayRemove();
    });


    if(ruleSetData.rulesetSpecificDayList.length == 0){
    	ruleSetData.rulesetSpecificDayList.push({specificDay : 'ALL'});
    	setSpecificDayListGrid();
    }
});
</script>

<div id="specificDayWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="specificDayNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='specificDayRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="specificDayListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="specificDayInfoPopup"></div>
