<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var grantedStandardListGrid;
var gridIdgrantedStandardListGrid;
var grantedStandardInfoPopupOpenType;
var selGrantedStandardData;

//부여기준 목록 그리드 설정
function setGrantedStandardListGrid(){
	var _promSubType = $("#promTypeCd").val();

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	//가산포인트 - 부여기준
	if (_promSubType == "P001") {
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

	//등급가산포인트 || 등급별포인트 - 부여기준
	else if (_promSubType == "P002" || _promSubType == "P014") {
		colNames.push("<spring:message code='L00180'/>");
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'tierNm',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

	//승급업포인트 - 부여기준
	else if (_promSubType == "P003") {
		colNames.push("<spring:message code='L00180'/>");
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'tierNm',index:'', width:'100px', align:'center', resizable : false});
		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

	//웰컴포인트 - 부여기준
	else if (_promSubType == "P004") {
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

	//금액대별포인트(판매) - 부여기준, 대상경로
	else if (_promSubType == "P005") {
		colNames.push("<spring:message code='L00181'/>");
		colNames.push("<spring:message code='L00182'/>");
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'minAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'maxAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

	//금액대별포인트(결제) - 부여기준, 대상경로, 결제기준
	else if (_promSubType == "P006") {
		colNames.push("<spring:message code='L00181'/>");
		colNames.push("<spring:message code='L00182'/>");
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'minAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'maxAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}else{
		colNames.push("<spring:message code='L00178'/>");
		colNames.push("<spring:message code='L00179'/>");
		colNames.push('rid');

		colModel.push({name:'acrlAmt',index:'', width:'100px', align:'center', resizable : false, formatter : 'integer'});
		colModel.push({name:'acrlTypeNm',index:'', width:'100px', align:'center',resizable : false});
		colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	}

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
	    data: ruleSetData.ruleSetMstList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
        sortname : 'acrlAmt',
        sortorder : "asc",
	    radio: true,
        tempId : 'ifvGridSimpleTemplete',
	};

    grantedStandardListGrid = $("#grantedStandardListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdgrantedStandardListGrid = $("#gridIdgrantedStandardListGrid");
}

//부여기준 정보 팝업 열기
function grantedStandardInfoPopupOpen(type) {

    grantedStandardInfoPopupOpenType = type;

	if (type == "E") {
        var len = grantedStandardListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
            selGrantedStandardData = grantedStandardListGrid.getSelRadioData();
        }
		else {
			alert("<spring:message code='L00183'/>");
			return false;
		}
	}
	//초기화
	else {
		selGrantedStandardData = {};
	}

    $("#grantedStandardInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="grantedStandardInfoPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00184'/>",
        width: '500px',
        open: function (args) {
        	if (type == "E") {
        		initGrantedStandardInfoPopData(selGrantedStandardData);
        	}
        },
        close : 'grantedStandardInfoPopupClose'
    });
}

//부여기준 정보 팝업 저장
function grantedStandardInfoPopupSave() {
	if (grantedStandardInfoPopValidation.confirm()) {
		var data = {};
		data.tierNm = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop #tierNm").val()) ? null : $("#grantedStandardInfoPop  #tierNm").val();
		data.ridTiers = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #ridTiers").val()) ? null : $("#grantedStandardInfoPop  #ridTiers").val();
		data.acrlType = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #acrlType").val()) ? null : $("#grantedStandardInfoPop  #acrlType").val();
		data.acrlTypeNm = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #acrlType option:selected").text()) ? null : $("#grantedStandardInfoPop  #acrlType option:selected").text();
		data.acrlAmt = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #acrlAmt").val()) ? null : $("#grantedStandardInfoPop  #acrlAmt").val();
		data.maxAmt = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #maxAmt").val()) ? null : $("#grantedStandardInfoPop  #maxAmt").val();
		data.minAmt = $.fn.ifvmIsEmpty($("#grantedStandardInfoPop  #minAmt").val()) ? null : $("#grantedStandardInfoPop  #minAmt").val();

		var _promSubType = $("#promTypeCd").val();

        //단건 등록 설정 일 경우 한건만 등록가능
        if (grantedStandardInfoPopupOpenType == "N"
                && chkGridFullCheck(grantedStandardListGrid.getDataRows(), _promSubType, 0)) {
            return false;
        }

		//정률일경우 max 100
		if (data.acrlType == "RATE" && Number(data.acrlAmt) > 100) {
			alert("<spring:message code='L00446'/>");
			return false;
		}

		//이상 미만 겹치는지 확인
		if (data.maxAmt != null && data.minAmt != null) {
			var rtnFlag = false;
			$.each(grantedStandardListGrid.getDataRows(), function(index, dat) {
				if (Number(dat.minAmt) < Number(data.maxAmt)
						&& Number(dat.maxAmt) > Number(data.minAmt)) {
					rtnFlag = true;
					return false;
				}
			});

			if (rtnFlag == true) {
				alert("<spring:message code='L00461'/>");
				return false;
			}
		}

		if ($.fn.ifvmIsNotEmpty(selGrantedStandardData)) {
			selGrantedStandardData.tierNm = data.tierNm;
			selGrantedStandardData.ridTiers = data.ridTiers;
			selGrantedStandardData.acrlType = data.acrlType;
			selGrantedStandardData.acrlTypeNm = data.acrlTypeNm;
			selGrantedStandardData.acrlAmt = data.acrlAmt;
			selGrantedStandardData.maxAmt = data.maxAmt;
			selGrantedStandardData.minAmt = data.minAmt;

			grantedStandardListGrid.setRowDatas(selGrantedStandardData);
		}
		else {
			grantedStandardListGrid.addLocalTr(data);
		}

        //전역변수에 값 매핑
        ruleSetData.ruleSetMstList = grantedStandardListGrid.getAllRowData();

		//close popup
		grantedStandardInfoPopupClose();
	}
}

//부여기준 정보 팝업 닫기
function grantedStandardInfoPopupClose() {
	grantedStandardInfoPopup._destroy();
}

//삭제
function grantedStandardRemove() {
    var len = grantedStandardListGrid.getRadioSelectedRowId().length;
    if (len > 0) {
        grantedStandardListGrid.delRowData();

        // 전역변수에 값 매핑
        ruleSetData.ruleSetMstList = grantedStandardListGrid.getAllRowData();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

function grantedStandardAllRemove() {
    var len = grantedStandardListGrid.getAllRowData().length;
    if (len > 0) {
        grantedStandardListGrid.delAllRowData();
        // 전역변수에 값 매핑
        ruleSetData.ruleSetMstList = grantedStandardListGrid.getAllRowData();
    }

}


/**
 * 부여기준 초기화
 */
function resetRuleSetMstList() {
    if (grantedStandardListGrid.opt.data != null
            && grantedStandardListGrid.opt.data.rows.length > 0 ) {
        grantedStandardListGrid.removeAll();

        //전역변수에 값 매핑
        ruleSetData.ruleSetMstList = grantedStandardListGrid.getAllRowData();
    }
}

$(document).ready(function() {
	setGrantedStandardListGrid();

    //저장
    $('#grantedStandardNewBtn').on('click', function() {
    	grantedStandardInfoPopupOpen('N');
    });

    //수정
    $("#grantedStandardEditBtn").on('click', function() {
    	grantedStandardInfoPopupOpen('E');
    });

    //삭제
    $("#grantedStandardRemoveBtn").on('click', function() {
    	grantedStandardRemove();
    });
});
</script>

<div id="grantedStandardWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="grantedStandardNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='grantedStandardEditBtn'>
                <spring:message code="M01853"/>
            </button>
            <button class="btn btn-sm" id='grantedStandardRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="grantedStandardListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="grantedStandardInfoPopup"></div>
