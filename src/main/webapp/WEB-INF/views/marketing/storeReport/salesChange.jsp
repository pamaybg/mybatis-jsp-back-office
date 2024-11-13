<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/WEB-INF/views/marketing/storeReport/include/sumoSelect.jsp" %>

<style>
	.sumo_tierType{ display: table-row; }
	.sumo_ageType{ display: table-row; }
	.sumo_clubType{ display: table-row; }
	.sumo_proGolfType{ display: table-row; }
	#ageType { height: 25px; }
	#tierType { height: 25px; }
	#clubType { height: 25px; }
	#proGolfType { height: 25px; }
</style>
<div class="page-title">
    <h1>
		매장용 리포트 > 최근 12개월 매출 추이
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="M00607"/></label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="year" names="year" dto="year"/>
			</div>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month"/>
			</div>
			<button class="btn btn-sm" id="reportSearchBtn" objCode="salesChangeSearch_OBJ">
				<i class="fa fa-search"></i><spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="reportSearchInitBtn" objCode="salesChangeSearchInit_OBJ">
				<spring:message code="M00278" />
			</button>
			<%@ include file="/WEB-INF/views/marketing/storeReport/include/searchBrandStore.jsp" %>
		 </div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"> 회원 유형 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="memberType" names="memberType" dto="memberType" />
			</div>
			<label class="col-xs-1 control-label tierType"> 회원 등급 </label>
			<div class="col-xs-1 control_content divSumo">
				<select id="tierType" name="tierType" multiple="multiple" class="sumoselect_multiple tierType">
				</select>
			</div>
			<label class="col-xs-1 control-label clubType"> 유료 멤버십 </label>
			<div class="col-xs-1 control_content divSumo">
				<select id="clubType" name="clubType" multiple="multiple" class="sumoselect_multiple clubType">
				</select>
			</div>
			<label class="col-xs-1 control-label proGolfType"> 프로 골퍼 </label>
			<div class="col-xs-2 control_content" style="display: table;">
					<select id="proGolfType" name="proGolfType" multiple="multiple" class="sumoselect_multiple proGolfType">
					</select>
			</div>
<%--			<div class="col-xs-1 control_content">--%>
<%--				<ifvm:inputNew type="select" id="tierType" names="tierType" dto="tierType" />--%>
<%--			</div>--%>
		</div>
		<div class="row qt_border mbrCond">
<%--			<label class="col-xs-1 control-label mbrCond"></label>--%>
<%--			<div class="col-xs-1 control_content mbrCond"></div>--%>
			<label class="col-xs-1 control-label sexType"> 성별 </label>
			<div class="col-xs-1 control_content sexType">
				<ifvm:inputNew type="select" id="sexType" names="sexType" dto="sexType"/>
			</div>
			<label class="col-xs-1 control-label ageType"> 연령대 </label>
			<div class="col-xs-1 control_content divSumo" style="width: 11%">
				<select id="ageType" name="ageType" multiple="multiple" class="sumoselect_multiple ageType">
				</select>
			</div>
		</div>
	</div>
</div>

<%-- 그리드 영역 --%>
<div class="qt_border">
<%--    <div class="page_btn_area" >--%>

<%--        <div class="col-xs-7">--%>
<%--            <span><spring:message code="M00277" /></span>--%>
<%--        </div>--%>
<%--        <div class="col-xs-5 searchbtn_r">--%>
<%--            <button class="btn btn-sm" id="excelExportBtn" objCode="ordProdListExcel_OBJ">--%>
<%--                <spring:message code="M01218" />--%>
<%--            </button>--%>
<%--        </div>--%>
<%--    </div>--%>
	<div id="chart_area" class="white_bg grid_bd0"></div>
</div>


<script type="text/javascript">
var chart;
var chartHeight = $('#chart_area').parent('div').height() + 300;
var chartWidth = $('#chart_area').parent('div').width() - 300;

function setCategory() {
	var category = [];
	var property = '';
	var year =  $("#year").val();
	var month = $("#month").val();
	while(category.length < 12) {
		if(month == 0) {
			year -= 1;
			month = '12';
		}
		// property = year + '.' + month;
		property = month + '월';
		category.push(property);
		month -= 1;
		month = month >= 10 ? month : '0' + month;
	}
	return category.reverse();
}

function columnChart_init() {
	const el = document.getElementById('chart_area');
	const data = {
		categories: setCategory(),
		series: [
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
			{ name: '', data: [0] },
		],
	};
	const options = {
		chart: { title: '최근 12개월 매출 추이', width: $('#chart_area').parent('div').width() - 300, height: $('#chart_area').parent('div').height()+350},
		//series: { stack: true, dataLabels: {visible: true}}
		//series: { stack: {type: 'percent' }, dataLabels: { visible: true }}
		series: {
			stack: {type: 'normal', connector: false },
			dataLabels: {
				visible: true,
				stackTotal: {
					visible: true,
				    formatter: (value) => {return value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '천원'}
				},
				formatter: (value) => {return ''}
				}
		},
		tooltip: {
		   formatter: (value, tooltipDataInfo) => {
		     return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '천원';
		   },
		 },
		legend: {
			visible: true
		}
	}

	chart = toastui.Chart.columnChart({ el, data, options});

	$(window).bind('resize', function (e) {
		chart.resize({
			width: ($('#chart_area').parent('div').width() - 300),
			height: chartHeight
		});
	});
}


// 조회 조건 초기화
function searchCondInit(all) {
	var _all = $.fn.ifvmIsNotEmpty(all) ? all : true;
	if(_all){
		pageObjectSalesChange.sysdateSet();
		$("#memberType").val("ALL").prop("selected", true);
	}
	// $("#tierType").val("").prop("selected", true);
	$("#sexType").val("").prop("selected", true);
	$(".SumoSelect .reset-all").trigger("click");
	$('.mbrCond').attr("hidden", false);
	$('.sexType').attr("hidden", false);
	$('.clubType').attr("hidden", false);
	$('.proGolfType').attr("hidden", false);
	$('.ageType').attr("hidden", false);
	$('.tierType').attr("hidden", false);
}


function setCondByMemberType(){
	if($('#memberType').val() === 'NMBR'){
		searchCondInit(false);
		$('.mbrCond').attr("hidden", true);
		$('.sexType').attr("hidden", true);
		$('.clubType').attr("hidden", true);
		$('.proGolfType').attr("hidden", true);
		$('.ageType').attr("hidden", true);
		$('.tierType').attr("hidden", true);
	} else {
		$('.mbrCond').attr("hidden", false);
		$('.sexType').attr("hidden", false);
		$('.clubType').attr("hidden", false);
		$('.proGolfType').attr("hidden", false);
		$('.ageType').attr("hidden", false);
		$('.tierType').attr("hidden", false);
	}
}


var pageObjectSalesChange = {
	    init: function () {
			this.sysdateSet();
			this.userInfoSetting();
	    	this.commcodeSetting();
	        this.chartInit();
	        //this.getSalesChangeData();
	        //this.getSalesChangeDataTest();
	        
	     	// 조회 이력 추가
			addStoreReportHist("REPORT_SALES_CHANGE");
	    },
	    commcodeSetting: function () {
	 	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		   $.fn.ifvmSetSelectOptionCommCode("sexType", "LOY_GEN_CD", null, null, false, "전체");
		   $.fn.ifvmSetSelectOptionCommCode("memberType", "ANL_CHART_SEARCH_TYPE", null, null, true);
		   setSumoSelect('ageType', 'MART_CUST_AGE_RANGE', '전체');
		   setSumoSelect('tierType', 'MART_CUST_TIER', '전체', ridBrand);
		   setSumoSelect('clubType', 'X_DK_MBR_CLUB_TYPE', '선택');
		   setSumoSelect('proGolfType', 'X_DK_PRO_TYPE', '선택');
		   searchCondInit();
	    },	    
	    sysdateSet: function () {
	    	var d = new Date();
	    	var reqYear = String(d.getFullYear());
	    	var reqMonth = d.getMonth() + 1;
	    	reqMonth = reqMonth >= 10 ? reqMonth : '0' + reqMonth;
	    	$("#year").val(reqYear);
	    	$("#month").val(reqMonth);
	    },
	    chartInit: function () {
			columnChart_init();
	    },
	    userInfoSetting: function () {
			pageName = 'salesChange';
			if(!$.fn.ifvmIsEmpty(shopCode)
			&& !$.fn.ifvmIsEmpty(ridBrand)
			&& !$.fn.ifvmIsEmpty(brandCode)
			&& !$.fn.ifvmIsEmpty(brandName)) return true;

			shopCode = ifvmUserInfo.empNo;
			setBrandCode();
			// setShopCnt();
	    },
		condIsAllDefault: function () {
			if($.fn.ifvmIsEmpty($('#sexType').val())
			&& $.fn.ifvmIsEmpty($('#tierType').val())
			&& $.fn.ifvmIsEmpty($('#ageType').val())
			&& $.fn.ifvmIsEmpty($('#clubType').val())
			&& $.fn.ifvmIsEmpty($('#proGolfType').val())) return true;
			else return false;
		},
	    getSalesChangeDataTest: function () {
			console.log($('#ageType').val());
	    },			    
	    getSalesChangeData: function () {
			if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 1;
	    	var inputYear =  $("#year").val();
	    	var inputMonth =  $("#month").val();
	    	var day;
	    	var current = new Date();
	    	var currentMonth = current.getMonth()+1;
			var memberType;
	    	currentMonth = currentMonth >= 10 ? currentMonth : '0' + currentMonth;

	    	if(inputMonth === currentMonth) {
				day = current.getDate() >= 10 ? current.getDate() : '0' + current.getDate();
			}
	    	else day = new Date(inputYear, inputMonth,0).getDate();

	    	var endDate = inputYear+inputMonth+day;

			if(this.condIsAllDefault()) memberType = $('#memberType').val();
			else                        memberType = 'MBR';

			beforeSend();
			setShopCnt();

	    	$.ifvMultiplePostJSON('<ifvm:action name="getSalesChange"/>', {
	    		gender: $("#sexType").val()
	    		, endDate: endDate
	    		, ageGroupCode: $("#ageType").val()
	    		, shopCode: shopCode
	    		, brandCode: brandCode
	    		, mbrDiv: memberType
	    		, membershipLevelCode: $("#tierType").val()
				, proCode : $("#proGolfType").val()
				, clubCode : $("#clubType").val()
	    	}, function (response) {
	    		chart.setData({
    				categories: setCategory(),
    				series: response
    			});
				complete('12개월 매출 추이 조회', totalAjax);
	   	    });
	    }
	};


function reloadTier() {
	if($('#memberType').val() === 'NMBR') $('.tierType').attr('hidden', false);
	$('#tierType').html('');
	setSumoSelect('tierType', 'MART_CUST_TIER', '전체', ridBrand);
	$('#tierType').SumoSelect().sumo.reload();
	$(".SumoSelect .reset-all").hide();
	if($('#memberType').val() === 'NMBR') $('.tierType').attr('hidden', true);
}



$(document).ready(function() {

	pageObjectSalesChange.init();

	// 조회
	$("#reportSearchBtn").on('click', function(){
		pageObjectSalesChange.getSalesChangeData();
	});

    // 초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    });

	// 회원 유형 변경
	$("#memberType").on('change', function(){
		setCondByMemberType();
	})
});
</script>
