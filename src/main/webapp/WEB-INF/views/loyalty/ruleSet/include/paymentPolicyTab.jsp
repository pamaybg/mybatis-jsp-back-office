<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var paymentPolicyListGrid;
var paymentPolicyInfoPopupOpenType;
var selPaymentPolicyData;


function initPaymentPolicyData() {
	
	//그리드 설정
	setPaymentPolicyListGrid();
}

/**
 * 구매 가맹점 그리드 출력
 */
function setPaymentPolicyListGrid() {
	
	//팝업 변수 설정
	switch($("#promSubType").val()){
	
	case "P012" : //가구화 프로모션
		paymentPolicyInfoPopupOpenType = "F";
		break;
	case "P009" : //금액대별(판매)
		paymentPolicyInfoPopupOpenType = "S";
		break;
	case "P013" : //구매금액횟수(누적)포인트
		paymentPolicyInfoPopupOpenType = "A";
		break;
	case "P002" : //등급가산 포인트
		paymentPolicyInfoPopupOpenType = "T";
		break;
	case "P014" : //등급별포인트
		paymentPolicyInfoPopupOpenType = "T";
		break;
	case "P003" : //승급업 포인트
		paymentPolicyInfoPopupOpenType = "T";
		break;
	case "P006" : //추천인포인트-피추천인
		paymentPolicyInfoPopupOpenType = "T";
		break;
	case "P017" : //기기등록 추천인
		paymentPolicyInfoPopupOpenType = "T";
		break;
	default : 
		paymentPolicyInfoPopupOpenType = "N";
	}
	

	//colnames
	var colNames = [];

	//colmodel
	var colModel = [];

	/* colNames.push("<spring:message code='L00235'/>");	/* 등급 코드 */
	/* colNames.push("<spring:message code='L00236'/>");	/* 등급명 */
	switch (paymentPolicyInfoPopupOpenType){
	case "F" : //가구화 프로모션
		colNames.push("인원");
		colNames.push("구매금액");
		colNames.push("구매횟수");
		colModel.push({name:'mbrCnt',     index:'mbrCnt',     resizable : false, align:'center', width:'100px', sortable:false}); 
		colModel.push({name:'minAmt',     index:'minAmt',     resizable : false, align:'center', width:'100px', sortable:false , formatter : 'integer'});
		colModel.push({name:'minCnt',     index:'minCnt',     resizable : false, align:'center', width:'100px', sortable:false , formatter : 'integer'});
		break;
	case "S" : //금액대별 판매
		colNames.push("구매금액");
		colModel.push({name:'minAmt',     index:'minAmt',     resizable : false, align:'center', width:'100px', sortable:false});
		break;
	case "A" : //구매금액횟수(누적)포인트
		colNames.push("구매금액");
		colNames.push("구매횟수");
		colModel.push({name:'minAmt',     index:'minAmt',     resizable : false, align:'center', width:'100px', sortable:false});
		colModel.push({name:'minCnt',     index:'minCnt',     resizable : false, align:'center', width:'100px', sortable:false});
		break;
	case "T" : //등급가산, 승급업 포인트
		colNames.push("회원 등급");
		colModel.push({name:'tierNm',     index:'tierNm',     resizable : false, align:'center', width:'100px', sortable:false});
		break;
	}
	
	colNames.push("적립구분");	/* 적립 구분*/
	colNames.push("적립금액/적립률");	/* 적립금액/적립률 */
	/* colNames.push('tierRid'); */
	/* colNames.push('ridRulesetMbr'); */
	colNames.push('acrlType');
	colNames.push('rid');

	/* colModel.push({name:'custGradeCd', index:'custGradeCd', resizable : false, align:'center', width:'80px'});
	colModel.push({name:'tierNm',     index:'tierNm',     resizable : false, align:'center', width:'80px'}); */
	colModel.push({name:'acrlTypeNm',     index:'acrlTypeNm',     resizable : false, align:'center', width:'100px', sortable:false});
	colModel.push({name:'acrlAmt',     index:'acrlAmt',     resizable : false, align:'right', width:'100px' ,formatter : 'number', sortable:false});
	/* colModel.push({name:'tierRid',        index:'tierRid',        resizable : false, hidden : true,  searchable : false}); */
	/* colModel.push({name:'ridRulesetMbr',   index:'ridRulesetMbr',   resizable : false, hidden : true,  searchable : false}); */
	colModel.push({name:'acrlType',   index:'acrlType',   resizable : false, hidden : true,  searchable : false});
	colModel.push({name:'rid',   index:'rid',   resizable : false, hidden : true,  searchable : false});

	var jqGridOption = {
 		loadComplete : function(obj) {
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
	    	paymentPolicyInfoPopupOpen(paymentPolicyInfoPopupOpenType, 'Y');
        },
	    data: ruleSetData.rulesetPymntPolicyList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [10],
        sortname: 'lrm.CREATE_DATE',
		sortorder: "desc",
	    radio: true,
        tempId : 'ifvGridSimplePageTemplete'
	};

	paymentPolicyListGrid = $("#paymentPolicyListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//구매가맹점 정보 팝업 열기
function paymentPolicyInfoPopupOpen(type, isEdit) {

	//if( type != "E" && ruleSetData.rulesetPymntPolicyList.length === 1) {
	//	alert('부여기준은 하나만 등록할 수 있습니다.');
	//	return false;
	//}
	
	
	//paymentPolicyInfoPopupOpenType = type;

	//수정일시,
	if (isEdit == "Y") {
        var len = paymentPolicyListGrid.getRadioSelectedRowId().length;
        if (len > 0) {
        	selPaymentPolicyData = paymentPolicyListGrid.getSelectedRowData();
        }
		else {
			alert("<spring:message code='L00168'/>");
			return false;
		}
	}
	//초기화
	else {
		selPaymentPolicyData = {};
	}

    $("#paymentPolicyInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="paymentPolicyInfoPop"/>'+'?paymentPolicyOpenType='+type+'&isEdit='+isEdit,
        contentType: "ajax",
        title: '<spring:message code="L00160"/>',
        width: '500px',
/*         open: function (args) {
        	if (type == "E") {
        		initPaymentPolicyInfoPopData(selPaymentPolicyData);
        	}
        }, */
        close : 'paymentPolicyInfoPopupClose'
    });
}

//구매가맹점 정보 팝업 저장
function paymentPolicyInfoPopupSave() {

	if (paymentPolicyInfoPopValidation.confirm()) {
		var data = {};
		/* data.custGradeCd = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierCd").val()) ? null : $("#paymentPolicyInfoPopDiv #tierCd").val();
		data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val(); */
		data.acrlTypeNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #saveDiv option:selected").text()) ? null : $("#paymentPolicyInfoPopDiv #saveDiv option:selected").text();
		data.acrlType = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #saveDiv").val()) ? null : $("#paymentPolicyInfoPopDiv #saveDiv").val();
		data.acrlAmt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #amount").val()) ? null : $("#paymentPolicyInfoPopDiv #amount").val();
		
		//가구화프로모션 일 시, 인원 / 구매금액 / 구매 횟수 추가
		switch($("#promSubType").val()){
		case "P012" : //가구화프로모션
			data.mbrCnt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #familyCnt").val()) ? null : $("#paymentPolicyInfoPopDiv #familyCnt").val();
			data.minAmt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #purchaseAmt").val()) ? null : $("#paymentPolicyInfoPopDiv #purchaseAmt").val();
			data.minCnt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #purchaseCnt").val()) ? null : $("#paymentPolicyInfoPopDiv #purchaseCnt").val();
			
			if($.fn.ifvmIsEmpty(data.minAmt) && $.fn.ifvmIsEmpty(data.minCnt)){
				alert("구매금액과 구매횟수 중 하나이상은 필수입니다.");
				return;
			}
			
			break;
		case "P009" : //금액대별(판매)
			data.minAmt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #purchaseAmt").val()) ? null : $("#paymentPolicyInfoPopDiv #purchaseAmt").val();
			break;
		case "P013" : //구매금액횟수(누적)포인트
			data.minAmt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #purchaseAmt").val()) ? null : $("#paymentPolicyInfoPopDiv #purchaseAmt").val();
			data.minCnt = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #purchaseCnt").val()) ? null : $("#paymentPolicyInfoPopDiv #purchaseCnt").val();
			
			if($.fn.ifvmIsEmpty(data.minAmt) && $.fn.ifvmIsEmpty(data.minCnt)){
				alert("구매금액과 구매횟수 중 하나 이상은 필수값입니다.");
				return;
			}
			
			break;
		case "P002" : //등급가산 포인트
			data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").text()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").text();
			data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val();
			break;
		case "P014" : //등급별포인트
			data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").text()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").text();
			data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val();
			break;
		case "P003" : //승급업 포인트
			data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").text()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").text();
			data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val();
			break;
		case "P006" : //추천인포인트-피추천인
			data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").text()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").text();
			data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val();
			break;
		case "P017" : //기기등록 추천인
			data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").text()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").text();
			data.tierNm = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierNm").val()) ? null : $("#paymentPolicyInfoPopDiv #tierNm").val();
			break;
		default :
			break;
		}
		
		
		/* data.tierRid = $.fn.ifvmIsEmpty($("#paymentPolicyInfoPopDiv #tierRid").val()) ? null : $("#paymentPolicyInfoPopDiv #tierRid").val(); */
        // 단건 등록 설정 일 경우 한건만 등록가능
  /*       if (chkGridFullCheck(rulesetPymntPolicyList.getDataRows(), $("#promSubType").val(), 0)) {
            return false;
        } */

        // 중복체크
 	     var popSave_strCheckedRid = paymentPolicyInfoPopupOpenType == "E" ? paymentPolicyListGrid.getCheckedGridData()[0].rid : null;
            popSave_strCheckedRid = $.fn.ifvmIsEmpty(popSave_strCheckedRid) ? null : popSave_strCheckedRid;
        var popSave_getGridArry = ruleSetData.rulesetPymntPolicyList;
        for ( var i = 0 ; i < popSave_getGridArry.length ; i++ ) {

            var popSave_getGridArry_rid = popSave_getGridArry[i].rid == null ? "" : popSave_getGridArry[i].rid;

            // 신규이거나 수정이고 아이디가 다른경우
            if ( paymentPolicyInfoPopupOpenType == 'N'
                    || (paymentPolicyInfoPopupOpenType == 'E' && popSave_strCheckedRid != popSave_getGridArry_rid) ) {

            }

            /* if ( paymentPolicyInfoPopupOpenType =='N' && popSave_getGridArry[i].custGradeCd == data.custGradeCd) {
                alert("등급이 중복됩니다.");
                return false;
            } */
        }

		//수정 or 등록 여부 확인
		if ($.fn.ifvmIsNotEmpty(selPaymentPolicyData)) {
			/* selPaymentPolicyData.custGradeCd = data.custGradeCd;
			selPaymentPolicyData.tierNm = data.tierNm; */
			selPaymentPolicyData.acrlType = data.acrlType;
			selPaymentPolicyData.acrlTypeNm = data.acrlTypeNm;
			selPaymentPolicyData.acrlAmt = data.acrlAmt;
			selPaymentPolicyData.minAmt = data.minAmt;
			selPaymentPolicyData.minCnt = data.minCnt;
			selPaymentPolicyData.mbrCnt = data.mbrCnt;
			selPaymentPolicyData.tierRid = data.tierRid;
			selPaymentPolicyData.tierNm = data.tierNm;
			/* selPaymentPolicyData.tierRid = data.tierRid; */
			
			for(var i=0; i<ruleSetData.rulesetPymntPolicyList.length; i++){
				if(ruleSetData.rulesetPymntPolicyList[i].rid == selPaymentPolicyData.rid){
					ruleSetData.rulesetPymntPolicyList[i] = selPaymentPolicyData;
					ruleSetData.rulesetPymntPolicyList.splice(i, 1, selPaymentPolicyData);
					break;
				}
			}
			//ruleSetData.rulesetPymntPolicyList = [];
			//ruleSetData.rulesetPymntPolicyList.push(selPaymentPolicyData);
			
			/* paymentPolicyListGrid.setRowDatas(selPaymentPolicyData); */
		}
		else {
			paymentPolicyListGrid.addLocalTr(data);
			ruleSetData.rulesetPymntPolicyList.push(data);
		}
        //전역변수에 값 매핑
        /* ruleSetData.rulesetPymntPolicyList = paymentPolicyListGrid.getAllRowData(); */
        setPaymentPolicyListGrid();
        
		//close popup
		paymentPolicyInfoPopupClose();
	}

}

//구매가맹점 정보 팝업 닫기
function paymentPolicyInfoPopupClose() {
	paymentPolicyInfoPopup._destroy();

}

//삭제
function paymentPolicyInfoRemove() {
	var idx = paymentPolicyListGrid.getRadioSelectedRowId();
    var len = idx.length;
    if (len > 0) {
    	paymentPolicyListGrid.delRowData();
    	ruleSetData.rulesetPymntPolicyList.remove(idx-1+((paymentPolicyListGrid.opt.page.currentNum-1)*paymentPolicyListGrid.jqGridOption.rowNum));
    	setPaymentPolicyListGrid();
    }
    else {
    	alert('<spring:message code="L00249"/>');
    }
}

$(document).ready(function() {
	initPaymentPolicyData();
	setFormAllDisabled();
    //저장
    $('#paymentPolicyInfoNewBtn').on('click', function() {
    	paymentPolicyInfoPopupOpen(paymentPolicyInfoPopupOpenType, 'N');
    });


    //삭제
    $("#paymentPolicyInfoRemoveBtn").on('click', function() {
    	paymentPolicyInfoRemove();
    });
});
</script>

<div id="destinationPathWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="paymentPolicyInfoNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id='paymentPolicyInfoRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="paymentPolicyListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="paymentPolicyInfoPopup"></div>