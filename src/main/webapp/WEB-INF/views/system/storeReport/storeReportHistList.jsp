<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="000217" />
		&gt; <spring:message code="L00030" />
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="storeReportHistListSearchBtn" objCode="storeReportHistListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="storeReportHistListSearchInitBtn" objCode="storeReportHistListSearchInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="storeReportHistListSearchList">
	</div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="storeReportHistExcelExportBtn" objCode="storeReportHistListExcelDwn_OBJ">
				<i class="glyphicon glyphicon-check"></i>
				<spring:message code="M01218" />
			</button>
		</div>
	</div>
	<div id="storeReportHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
var storeReportHistList;
var rid;

// 매장용 리포트 조회 이력 리스트
function getstoreReportHistListSearch() {
	
	var ejGridOption = {
   		recordDoubleClick : function(args){
    		var dataArr = storeReportHistList.opt.gridControl.getSelectedRecords();
    		getSystemAlertDetail(dataArr.rid);
       	},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		rowSelected : function (args) {
			rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getStoreReportHistList"/>',
		columns : [
		 	{
				field : 'pgmNm', headerText : '<spring:message code="M03092"/>',  textAlign : 'left', customAttributes :{searchable : true}
			}, {
				field : 'name', headerText : '<spring:message code="M02880"/>',  width:'150px', textAlign : 'center', customAttributes :{searchable : true}
			}, {
				field : 'userId', headerText : '<spring:message code="M03091"/>',width:'300px' , textAlign : 'center', customAttributes :{searchable : true}
			}, {
				field : 'createDate', headerText : '<spring:message code="M02882"/>',  textAlign : 'center'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'createDate',
			sord : 'desc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
		/* tempId : 'ifvGridNotSearchTemplete' */
	};

	storeReportHistList = $("#storeReportHistListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

//공통 조회 조건 목록 설정
function storeReportHistListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("storeReportHistListSearchList", "REPORT_HIST_LIST", gridId);
	startDateInitialize();
}

//공통 조회 호출
function storeReportHistListSearch() {

	var searchValidation = true;
	//조회 일시 여부 확인
	if ($.fn.ifvmIsEmpty($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val())) {
		alert('조회 일시를 입력해주세요.');
		return;
	}

	var startDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val());
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	var todayDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체
	startDate.setHours(0, 0, 0, 0);
	EndDate.setHours(0, 0, 0, 0);
	todayDate.setHours(0, 0, 0, 0);


	var year = EndDate.getFullYear();
	var month = EndDate.getMonth();
	var day = EndDate.getDate();
	var d = new Date(); // 1개월 전 기준 날짜 d
	d.setHours(0, 0, 0, 0);
	d.setYear(year);
	d.setMonth(month - 1);
	d.setDate(day);
	if (startDate < d) { // 시작날짜가 3개월전을 초과 시
		alert('최대 1개월 까지만 조회가 가능합니다.');
		searchValidation = false;
		return;
	}

	if (startDate > todayDate) { // 시작날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}

	if (EndDate > todayDate) { // 끝 날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}

	if (searchValidation) {
		$.fn.ifvmSubmitSearchCondition("storeReportHistListSearchList", getstoreReportHistListSearch);
	} else {
		alert('최소 1개의 조회조건을 입력해주세요.');
		return;
	}

}

//판매일자 startDate를 1개월 날짜값으로 초기화해주기
function startDateInitialize() {
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());

	var month = EndDate.getMonth();
	var year = EndDate.getFullYear();
	var day = EndDate.getDate();
	EndDate.setHours(0, 0, 0, 0);

	var dates = new Date();
	dates.setYear(year);
	dates.setMonth(month - 1);
	dates.setDate(day);
	dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);

	$('.changeTypeAreaCode .start_date input').val(dates)
}

function getFormatDate(date) {
	var year = date.getFullYear();              //yyyy
	var month = (1 + date.getMonth());          //M
	month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	var day = date.getDate();                   //d
	day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	return year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}




$(document).ready(function() {

	//공통 조회 조건 목록 설정
	storeReportHistListSearchInit();
	storeReportHistListSearch();
	//조회
	$('#storeReportHistListSearchBtn').on('click', function() {
		storeReportHistListSearch();
	});

	//초기화
	$("#storeReportHistListSearchInitBtn").on('click', function() {
		storeReportHistListSearchInit('storeReportHistList');
	});

	//액셀 다운로드
	$('#storeReportHistExcelExportBtn').on('click', function(){
		$.ifvExcelDn('<ifvm:action name="getStoreReportHistExcelDown"/>', 'storeReportHistListGrid');
	});


});
</script>
