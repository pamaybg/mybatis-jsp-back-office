<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<script type="text/javascript">
var pointDropList;
var gridPointDropList;
var rid;
var setDropDay =null;

//포인트 소멸자  조회
function getPointDropListSearch() {
	var ejGridOption = {
// 		recordDoubleClick : function(args) {
// 			var data = args.data;
// 			rid = data.rid;
// 		},
		loadComplete : function(obj){
			//고정된 조회조건 세팅
			var conds = new Array();
			var cond = {};
			cond.rid = $('#yesar').parent().prev().text().trim();
			conds.push(cond);

        	//로그 저장
    		$.fn.ifvmFixedCondLogging("PNT_DROP_01", pointDropList.opt.data.records, conds);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.years = $("#yesar").val();
			return data;
		},
		dataUrl : '<ifvm:action name="getPointDropList"/>',
		columns : [
		{
			field : 'mbrNo', headerText : '<spring:message code="L00797" />', headerTextAlign : 'center',textAlign : ej.TextAlign.Center,
			customAttributes : {
				index : 'lm.MBR_NO' //회원번호
			}
		}, {
			field : 'custNm', headerText : '<spring:message code="L00798" />', headerTextAlign : 'center',
			customAttributes : {
				index : 'lc.CUST_NM' //회원명
			}
		}, {
			field : 'expPoint', headerText : '<spring:message code="L00853" />', headerTextAlign : 'center', format : '{0:n0}',textAlign : 'right',
			customAttributes : {
				index : 'EXPM.EXPIRING_POINT'
			}
		}, {
			field : 'expDate', headerText : '<spring:message code="L02195" />', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'EXPM.BASE_DATE'
			}
		},
// 		{
// 			field : 'expDate', headerText : '<spring:message code="D10031" />',headerTextAlign : 'center',textAlign : ej.TextAlign.right,
// 			customAttributes : {
// 				index : 'epm.BASE_DATE'
// 			}
// 		},
		{
			field : 'expyymm', headerText : 'expyymm', visible : false,
			customAttributes : {
				index : 'EXPM.EXPIRING_YYYYMM'
			}
		},
		{
			field : 'rid', headerText : 'rid', visible : false,
			customAttributes : {
				index : ''
			}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 'EXPM.SEQ_NO',
			sord : 'desc',
			_search : false
		},
		rowList : [ 10, 100,500,1000,5000 ],
		radio : true,
		tempId : 'ifvGridSimplePageTemplete2'
	};

	pointDropList = $("#pointDropListGrid").ifvsfGrid({
		ejGridOption : ejGridOption
	});
	gridPointDropList = $("#gridPointDropList");
}

//공통 조회 조건 목록 설정
function termsListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("TermsListSearchList", "PNT_DROP_01",gridId);
}

//공통 조회 호출
function termsListSearch() {
	$.fn.ifvmSubmitSearchCondition("TermsListSearchList",
			getPointDropListSearch);
}
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(pointDropList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = pointDropList.opt.gridControl.getSelectedRecords()[0].rid;
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
        	var gridObj = pointDropList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.mbrNm);
        });
    }
}
function dropMonth(){
	var dt= new Date();

	for(var i=0; i<3; i++){
		var month =dt.getMonth()+2+i;
		var year = dt.getFullYear();
		if (month == 13){
			year +=1;
			month = 1;
		}

		var yearText = year+'년'+month+'월';
		if(month<10){
			month = '0'+month;
		}
		var yearVal =  year+''+month;
		$('#yesar').append("<option value="+yearVal+">"+yearText+"</option>");
	}


}

$(document).ready(function() {
	dropMonth();
	$.ifvmLnbSetting('pointDisappearList');

	//공통 조회 조건 목록 설정
	termsListSearchInit();

	termsListSearch();
	//조회
	$('#termsListSearchBtn').on('click', function() {
		termsListSearch();
	});

	//초기화
	$("#termsListSearchInitBtn").on('click', function() {
		termsListSearchInit('pointDropListGrid');
	});

	 //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
	$("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/loyalty/pointdrop/getPointDropDown.do','pointDropListGrid' );
    });

});
</script>

<style>
#hideFile {
	display: none
}
</style>

<div class="page-title">
	<h1>
		<spring:message code="L02352" />
		&gt; <spring:message code="M00135" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
 			<div class="col-xs-5 searchbtn_r">
 				<button class="btn btn-sm" id="termsListSearchBtn" objCode="termsListSearchBtn_OBJ">
 					<i class="fa fa-search"></i>
 					<spring:message code="M00135" />
 				</button>
	 			<button class="btn btn-sm" id="termsListSearchInitBtn" objCode="termsListSearchInitBtn_OBJ">
	 				<spring:message code="M00278" />
	 			</button>
 		</div>
	</div>
<!-- 	<div class="well form-horizontal well_bt5" id="TermsListSearchList"> -->
	 <div class="row well form-horizontal" id ="term">
	 	<ifvm:inputNew type="select" id="yesar" dto="yesar"
	 	 label="D10043" labelClass="2" conClass="4" />
     </div>
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00930" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn"  text="D10091" objCode="pointDisapclearMaskBtn_OBJ"/>
			<button class="btn btn-sm" id="excelListBtn" objCode="pointDisapexcelListBtn_OBJ">
             <spring:message code="M01218" />
         	</button>
		</div>
	</div>
	<div id="pointDropListGrid" class="white_bg grid_bd0"></div>
</div>
