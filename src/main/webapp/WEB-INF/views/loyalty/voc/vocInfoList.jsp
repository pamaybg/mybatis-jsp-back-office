<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<script type="text/javascript">
var vocInfoList;

//포인트 소멸자  조회
function getDromancyList() {
	var ejGridOption = {
// 		recordDoubleClick : function(args) {
// 			var data = args.data;
// 			rid = data.rid;
// 		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		dataUrl : '<ifvm:action name="getVocInfoList"/>',
		columns : [
		{
			field : 'vocReqby', headerText : '<spring:message code="D10208"/>', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//voc 요청자
				index : 'EMP.NAME'
			}
		}, {
			field : 'occuDate', headerText : '<spring:message code="L00369"/>', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : { //발생일자
				index : 'liv.OCCU_DATE'
			}
		}, {
			field : 'chnlNm', headerText : '<spring:message code="D10209"/>', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//발생매장
				index : 'lch.CHNL_NM'
			}
		}, {
			field : 'reptNo', headerText : '<spring:message code="D10054"/>', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//영수증번호
				index : 'liv.RCPT_NO'
			}
		}, {
			field : 'vocReqAmt', headerText : '<spring:message code="D10210"/>',headerTextAlign : 'center',format : '{0:n0}',textAlign : 'right',
			customAttributes : {//VOC금액
				index : 'liv.VOC_REQ_AMT'
			}
		}, {
			field : 'vocDesc', headerText : '<spring:message code="D10211"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//voc내용
				index : 'liv.VOC_DESC'
			}
		},{
			field : 'custNm', headerText : '<spring:message code="L00320"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//고객명
				index : 'LC.CUST_NM'
			}
		},{
			field : 'pntTxnType', headerText : '<spring:message code="L00505"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//포인트 거래유형
				index : 'c1.MARK_NAME'
			}
		},{
			field : 'pntTxnDtlType', headerText : '<spring:message code="D10212"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//포인트 거래상세 유형
				index : 'c2.MARK_NAME'
			}
		},{
			field : 'camNm', headerText : '<spring:message code="L00152"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'MCM.CAM_NM'
			}
		},{
			field : 'rid', headerText : 'rid', visible : false,
			customAttributes : {
				index : ''
			}
		},{
			field : 'ridMbr', headerText : 'ridMbr', visible : false,
			customAttributes : {
				index : ''
			}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 'liv.OCCU_DATE',
			sord : 'desc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
// 		gridDataInit: false,
		tempId : 'ifvGridSimplePageTemplete2'
	};

	vocInfoList = $("#vocInfoListGrid").ifvsfGrid({
		ejGridOption : ejGridOption
	});
}

//공통 조회 조건 목록 설정
function termsListSearchInit() {
	$.fn.ifvmSetCommonCondList("vocListSearchList", "VOC_INFO_DATA_01");
}
//공통 조회 호출
function vocListSearch() {
	$.fn.ifvmSubmitSearchCondition("vocListSearchList",
			getDromancyList);
}

//공통 조회 호출
// function vocListSearch() {

// 	$.fn.ifvmSubmitSearchCondition_NoAllSearch("vocListSearchList", function() {
//     	if ($.fn.ifvmIsNotEmpty(requestitem)) {
//     		vocInfoList.searchGrid({item: requestitem});
//     	} else {
//     		alert('최소 1개의 조회조건을 입력해주세요.');
//     	}
//     });

// }
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(vocInfoList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = vocInfoList.opt.gridControl.getSelectedRecords()[0].ridMbr;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = vocInfoList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.mbrNm);
        });
    }
}

$(document).ready(function() {
	$.ifvmLnbSetting('vocInfoList');

	//공통 조회 조건 목록 설정
	termsListSearchInit();
	getDromancyList();
// 	vocListSearch();
	//조회
	$('#ListSearchBtn').on('click', function() {
		vocListSearch();
	});

	//초기화
	$("#SearchInitBtn").on('click', function() {
		termsListSearchInit();
	});

	  //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
//     $("#excelListBtn").on('click', function() {

//       	$.ifvExcelDn('/loyalty/voc/exeTest.do','vocInfoListGrid' );
//     });
});
</script>

<!-- <style> -->
<!-- /* #hideFile { */ -->
<!-- /* 	display: none */ -->
<!-- /* } */ -->
<!-- </style> -->

<div class="page-title">
	<h1>
		CS 포인트 이력
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="ListSearchBtn" objCode="vocListSearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="SearchInitBtn" objCode="vocSearchInitBtn_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="vocListSearchList">
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00930" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn"  text="D10091" objCode="vocclearMaskBtn_OBJ"/>
<!-- 			<button class="btn btn-sm" id="excelListBtn"> -->
<%--              <spring:message code="M01218" /> --%>
<!--          	</button> -->
		</div>
	</div>
	<div id="vocInfoListGrid" class="white_bg grid_bd0"></div>
</div>
