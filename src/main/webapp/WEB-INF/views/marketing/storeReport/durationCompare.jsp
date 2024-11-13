<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/WEB-INF/views/marketing/storeReport/include/sumoSelect.jsp" %>

<style>
	.fixed-width-200 {
		width: 80%;
	}
	.gridClass{
		background-color: #f9f9f9;
	}

	#regionType { height: 25px; }
	#martType { height: 25px; }
	.sumo_regionType{display:table-row;}
	.sumo_martType{display:table-row;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="매장용 리포트"/>  &gt; <spring:message code="기간 비교"/>
	</h1>
</div>

<%-- 조회조건 영역 --%>
<div>
	<div class="form-horizontal underline top_well" id="durationSearchCondition">
		<div class="row qt_border">
			<ifvm:inputNew type="dateTerm" startDto="stdStartDt" endDto="stdEndDt" startId="stdStartDt" endId="stdEndDt" label="기준 기간" labelClass="1" conClass="3"/>
			<ifvm:inputNew type="dateTerm" startDto="cmpStartDt" endDto="cmpEndDt" startId="cmpStartDt" endId="cmpEndDt" label="비교 기간" labelClass="1" conClass="3"/>
			<button class="btn btn-sm" id="durationSearchBtn" objCode="durationSearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135" /></button>
			<%@ include file="/WEB-INF/views/marketing/storeReport/include/searchBrandStore.jsp" %>
		</div>
	</div>
</div>

<%-- 그리드 영역 --%>
<div>
	<div class="half_wrap top_well">
		<div class="half_content half_left qt_border">
			<div id="chartGrid" class="row qt_border">
				<div>
					<div style="font-weight: bold" class="half_content half_left">
						<spring:message code="[기준 기간]"/>
					</div>
					<div style="font-weight: bold" class="half_content half_right">
						<spring:message code="[비교 기간]"/>
					</div>
				</div>
				<div id="std_pie_chart" class="half_content half_left"></div>
				<div id="cmp_pie_chart" class="half_content half_right"></div>
				<div id="std_age_chart" class="half_content half_left"></div>
				<div id="cmp_age_chart" class="half_content half_right"></div>
				<div style="font-weight: bold"><spring:message code="[전체 성과]"/></div>
				<div id="sales_total_grid"></div>
				<div style="font-weight: bold"><spring:message code="[회원 성과]"/></div>
				<div id="sales_mbr_grid"></div>
			</div>
		</div>
		<div class="half_content half_right">
			<div style="font-weight: bold"><spring:message code="[아이템 TOP 10개 성과 비교]"/></div>
			<div id="item_top10_grid"></div>
			<div style="font-weight: bold"><spring:message code="[상품 TOP 10개 성과 비교]"/></div>
			<div id="product_top10_grid"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var std_pie_chart;
	var cmp_pie_chart;

	var std_age_chart;
	var cmp_age_chart;

	var sales_total_grid;
	var sales_mbr_grid;
	
	var item_top10_grid;
	var product_top10_grid;

	var pieChartWidth = ($('#std_pie_chart').parent('div').width()) / 2 - 40;
	var ageChartWidth = $('#std_age_chart').parent('div').width() / 2 - 5;
	var chartHeight = 300;

	var categories = ['19세 이하', '20 ~ 24세', '25 ~ 29세', '30 ~ 34세', '35 ~ 39세', '40 ~ 44세', '45 ~ 49세', '50 ~ 54세', '55 ~ 59세', '60세 이상'];


	function std_pie_chart_init(){
		const el = document.getElementById('std_pie_chart');
		const data = {
			categories: ['상품종류'],
			series: [
				{
					name: '의류',
					data: 33,
				},
				{
					name: '신발',
					data: 33,
				},
				{
					name: '용품',
					data: 33,
				}
			]
		};
		const options = {
			chart: {title: '클래스별 비중', width: pieChartWidth, height: chartHeight},
			series: {
				dataLabels: {
					visible: true,
					pieSeriesName: {
						visible: true,
					},
				},
			},
			tooltip: {
				formatter: (value, tooltipDataInfo) => {
					return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				},
			}
		};

		std_pie_chart = toastui.Chart.pieChart({el, data, options});

		$(window).bind('resize', function (e) {
			std_pie_chart.resize({
				width: ($('#std_pie_chart').parent('div').width()) / 2 - 40,
				height: chartHeight
			});
		});
	}

	function cmp_pie_chart_init(){
		const el = document.getElementById('cmp_pie_chart');
		const data = {
			categories: ['상품종류'],
			series: [
				{
					name: '의류',
					data: 33,
				},
				{
					name: '신발',
					data: 33,
				},
				{
					name: '용품',
					data: 33,
				}
			]
		};
		const options = {
			chart: {title: '클래스별 비중', width: pieChartWidth, height: chartHeight},
			series: {
				dataLabels: {
					visible: true,
					pieSeriesName: {
						visible: true,
					},
				},
			},
			tooltip: {
				formatter: (value, tooltipDataInfo) => {
					return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				},
			}
		};

		cmp_pie_chart = toastui.Chart.pieChart({el, data, options});

		$(window).bind('resize', function (e) {
			cmp_pie_chart.resize({
				width: ($('#cmp_pie_chart').parent('div').width()) / 2 - 40,
				height: chartHeight
			});
		});
	}

	function std_age_chart_init() {
		const el = document.getElementById('std_age_chart');
		const data = {
			categories: categories,
			series: [
				{
					name: '남성',
					data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					stackGroup: '남성',
				},
				{
					name: '여성',
					data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					stackGroup: '여성',
				}
			],
		};
		const options = {
			chart: {title: '회원의 성별 연령', width: ageChartWidth, height: chartHeight},
			//chart: {title: '회원의 성별 연령', width: 'auto', height: 'auto'},
			yAxis: {
				title: '연령', align: 'center'
			},
			series: {
				stack: true,
				diverging: true,
			},
		};

		std_age_chart = toastui.Chart.barChart({el, data, options});

		$(window).bind('resize', function (e) {
			std_age_chart.resize({
				width: $('#std_age_chart').parent('div').width() / 2 - 5,
				height: chartHeight
			});
		});
	}

	function cmp_age_chart_init() {
		const el = document.getElementById('cmp_age_chart');
		const data = {
			categories: categories,
			series: [
				{
					name: '남성',
					data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					stackGroup: '남성',
				},
				{
					name: '여성',
					data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					stackGroup: '여성',
				}
			],
		};
		const options = {
			chart: {title: '회원의 성별 연령', width: ageChartWidth, height: chartHeight},
			//chart: {title: '회원의 성별 연령', width: 'auto', height: 'auto'},
			yAxis: {
				title: '연령', align: 'center'
			},
			series: {
				stack: true,
				diverging: true,
			},
		};

		cmp_age_chart = toastui.Chart.barChart({el, data, options});

		$(window).bind('resize', function (e) {
			cmp_age_chart.resize({
				width: $('#cmp_age_chart').parent('div').width() / 2 - 5,
				height: chartHeight
			});
		});
	}

	function sales_total_grid_init() {

		sales_total_grid = new tui.Grid({
			el: document.getElementById('sales_total_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			rowHeight: 50,
			minBodyHeight: 90,
			data: [
				{
					colNm: '기준기간',
					ordCnt: '0',
					purCnt: '0',
					sales: '0',
					avgOrdSales: '0'
				},
				{
					colNm: '비교기간',
					ordCnt: '0',
					purCnt: '0',
					sales: '0',
					avgOrdSales: '0'
				}
			],
			columns: [
				{
					header: ' ',
					name: 'colNm',
					align: 'center',
				},
				{
					align: 'center',
					header: '총 주문수',
					name: 'ordCnt'
				},
				{
					align: 'center',
					header: '총 판매수량',
					name: 'purCnt'
				},
				{
					align: 'center',
					header: '총 매출',
					name: 'sales'
				},
				{
					align: 'center',
					header: '총 주문당 단가',
					name: 'avgOrdSales'
				}
			]
		});

		sales_total_grid.getData().forEach(row => {
			sales_total_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}

	function sales_mbr_grid_init() {

		sales_mbr_grid = new tui.Grid({
			el: document.getElementById('sales_mbr_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			rowHeight: 50,
			minBodyHeight: 90,
			data: [
				{
					colNm: '기준기간',
					newMbrCnt: '0',
					mbrCnt: '0',
					ordCnt: '0',
					purCnt: '0',
					sales: '0',
					avgOrdSales: '0',
					avgPurCnt: '0',
					avgMbrSales: '0'
				},
				{
					colNm: '비교기간',
					newMbrCnt: '0',
					mbrCnt: '0',
					ordCnt: '0',
					purCnt: '0',
					sales: '0',
					avgOrdSales: '0',
					avgPurCnt: '0',
					avgMbrSales: '0'
				}
			],
			columns: [
				{
					header: ' ',
					name: 'colNm',
					align: 'center',
				},
				{
					align: 'center',
					header: '가입 회원수',
					name: 'newMbrCnt'
				},
				{
					align: 'center',
					header: '주문 회원수',
					name: 'mbrCnt'
				},
				{
					align: 'center',
					header: '회원 주문수',
					name: 'ordCnt'
				},
				{
					align: 'center',
					header: '회원 판매수량',
					name: 'purCnt'
				},
				{
					align: 'center',
					header: '회원 매출',
					name: 'sales'
				},
				{
					align: 'center',
					header: '회원 주문당 단가',
					name: 'avgOrdSales'
				},
				{
					align: 'center',
					header: '회원 객수량',
					name: 'avgPurCnt'
				},
				{
					align: 'center',
					header: '회원 객단가',
					name: 'avgMbrSales'
				}
			],
			columnOptions: {
				resizable: true
			}
		});

		sales_mbr_grid.getData().forEach(row => {
			sales_mbr_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}

	function item_top10_grid_init() {

		item_top10_grid = new tui.Grid({
			el: document.getElementById('item_top10_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			//rowHeight: document.getElementById('chartGrid').clientHeight / 6,
			rowHeight: document.getElementById('chartGrid').clientHeight / 20,
			align: 'center',
			header: {
				height: 60,
				complexColumns: [
					{
						header: ' ',
						name: 'header1',
						childNames: [],
					},
					{
						header: '기준기간',
						name: 'stdPeriodHeader',
						childNames: ['stdPurCnt', 'stdSales']
					},
					{
						header: '비교기간',
						name: 'cmpPeriodHeader',
						childNames: ['cmpPurCnt', 'cmpSales']
					},
					{
						header: '증감율',
						name: 'varianceHeader',
						childNames: ['purCntRate', 'salesRate']
					}
				]
			},columns: [
				{
					header: '아이템 코드',
					name: 'itemCode',
					width: 80,
					className: 'gridClass',
					align: 'center'
				},
				{
					header: '판매수량',
					name: 'stdPurCnt',
					align: 'center'
				},
				{
					header: '매출',
					name: 'stdSales',
					align: 'center'
				},
				{
					header: '판매수량',
					name: 'cmpPurCnt',
					align: 'center'
				},
				{
					header: '매출',
					name: 'cmpSales',
					align: 'center'
				},{
					header: '판매수량',
					name: 'purCntRate',
					align: 'center'
				},
				{
					header: '매출',
					name: 'salesRate',
					align: 'center'
				}
			],
			data: [
				{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				}
			]
		});

		item_top10_grid.getData().forEach(row => {
			item_top10_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}

	function product_top10_grid_init() {

		product_top10_grid = new tui.Grid({
			el: document.getElementById('product_top10_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			//rowHeight: document.getElementById('chartGrid').clientHeight / 6,
			rowHeight: document.getElementById('chartGrid').clientHeight / 20,
			align: 'center',
			header: {
				height: 60,
				complexColumns: [
					{
						header: ' ',
						name: 'header1',
						childNames: [],
					},
					{
						header: '기준기간',
						name: 'stdPeriodHeader',
						childNames: ['stdPurCnt', 'stdSales']
					},
					{
						header: '비교기간',
						name: 'cmpPeriodHeader',
						childNames: ['cmpPurCnt', 'cmpSales']
					},
					{
						header: '증감율',
						name: 'varianceHeader',
						childNames: ['purCntRate', 'salesRate']
					}
				]
			},columns: [
				{
					header: '상품코드',
					name: 'productCode',
					width: 80,
					className: 'gridClass',
					align: 'center'
				},
				{
					header: '판매수량',
					name: 'stdPurCnt',
					align: 'center'
				},
				{
					header: '매출',
					name: 'stdSales',
					align: 'center'
				},
				{
					header: '판매수량',
					name: 'cmpPurCnt',
					align: 'center'
				},
				{
					header: '매출',
					name: 'cmpSales',
					align: 'center'
				},{
					header: '판매수량',
					name: 'purCntRate',
					align: 'center'
				},
				{
					header: '매출',
					name: 'salesRate',
					align: 'center'
				}
			], data: [
				{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				},{
					itemCode: '',
					stdPurCnt: '',
					stdSales: '',
					cmpPurCnt: '',
					cmpSales: '',
					purCntRate: '',
					salesRate: ''
				}
			]
		});

		product_top10_grid.getData().forEach(row => {
			product_top10_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}


	function setStdPieChart(series) {
		std_pie_chart.setData({
			//categories: categories,
			series: series
		});
	}

	function setCmpPieChart(series) {
		cmp_pie_chart.setData({
			//categories: categories,
			series: series
		});
	}

	function setStdAgeChart(series) {
		std_age_chart.setData({
			categories: categories,
			series: series
		});
	}

	function setCmpAgeChart(series) {
		cmp_age_chart.setData({
			categories: categories,
			series: series
		});
	}

	function setSalesTotalGrid(data) {
		sales_total_grid.resetData(data);
	}

	function setSalesMbrGrid(data) {
		sales_mbr_grid.resetData(data);
	}

	function setItemTop10Grid(data) {
		item_top10_grid.resetData(data);
	}

	function setProductTop10Grid(data) {
		product_top10_grid.resetData(data);
	}


	var pageObjectDurationCompare = {
		init: function () {
			this.sysdateSet();
			this.userInfoSetting();
			this.chartInit();

			// 조회 이력 추가
			addStoreReportHist("REPORT_DURATION_COMPARE");
		},
		sysdateSet: function () {
			var stdStartDt = $("#stdStartDt");
			var stdEndDt = $("#stdEndDt");
			var cmpStartDt = $("#cmpStartDt");
			var cmpEndDt = $("#cmpEndDt");

			stdStartDt.val($.ifvGetNewDate('m', -1).newDateS);
			stdEndDt.val($.ifvGetNewDate().newDateS);
			stdStartDt.ifvDateChecker({});
			stdEndDt.ifvDateChecker({});

			cmpStartDt.val($.ifvGetNewDate('m', -1).newDateS);
			cmpEndDt.val($.ifvGetNewDate().newDateS);
			cmpStartDt.ifvDateChecker({});
			cmpEndDt.ifvDateChecker({});
		},
		userInfoSetting: function () {
			pageName = 'durationCompare';
			if(!$.fn.ifvmIsEmpty(shopCode)
					&& !$.fn.ifvmIsEmpty(ridBrand)
					&& !$.fn.ifvmIsEmpty(brandCode)
					&& !$.fn.ifvmIsEmpty(brandName)) return true;

			shopCode = ifvmUserInfo.empNo;
			setBrandCode();
		},
		chartInit: function () {
			//chart
			std_pie_chart_init();
			cmp_pie_chart_init();
			std_age_chart_init();
			cmp_age_chart_init();
			//grid
			sales_total_grid_init();
			sales_mbr_grid_init()
			item_top10_grid_init();
			product_top10_grid_init();
		},

		getDurationCompareData: function () {
			if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 7;

			var objData = {
				startDate: $('#stdStartDt').val(),
				endDate: $("#stdEndDt").val(),
				cmpStartDate: $('#cmpStartDt').val(),
				cmpEndDate: $("#cmpEndDt").val(),
				shopCode: shopCode,
				brandCode: brandCode
			}

			beforeSend();

			// 기준 기간 파이 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpPieChart"/>', {
				startDate: $('#stdStartDt').val(),
				endDate: $("#stdEndDt").val(),
				shopCode: shopCode,
				brandCode: brandCode
			}, function (response) {
				console.log(response);
				setStdPieChart(response.durCmpPieChart);
				complete('기준 기간 파이 차트 조회', totalAjax);
			});
			// 비교 기간 파이 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpPieChart"/>', {
				startDate: $('#cmpStartDt').val(),
				endDate: $("#cmpEndDt").val(),
				shopCode: shopCode,
				brandCode: brandCode
			}, function (response) {
				console.log(response);
				setCmpPieChart(response.durCmpPieChart);
				complete('비교 기간 파이 차트 조회', totalAjax);
			});
			// 기준 기간 성별 연령 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpAgeChart"/>', {
				startDate: $('#stdStartDt').val(),
				endDate: $("#stdEndDt").val(),
				shopCode: shopCode,
				brandCode: brandCode
			}, function (response) {
				console.log(response);
				setStdAgeChart(response.durCmpAgeChart);
				complete('기준 기간 성별 연령 차트 조회', totalAjax);
			});
			// 비교 기간 성별 연령 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpAgeChart"/>', {
				startDate: $('#cmpStartDt').val(),
				endDate: $("#cmpEndDt").val(),
				shopCode: shopCode,
				brandCode: brandCode
			}, function (response) {
				console.log(response);
				setCmpAgeChart(response.durCmpAgeChart);
				complete('비교 기간 성별 연령 차트 조회', totalAjax);
			});
			// 전체성과 기간 비교 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpPurTotalGrid"/>', objData, function (response) {
				console.log(response);
				setSalesTotalGrid(response.durCmpPurTotalGrid);
				complete('전체성과 기간 비교 그리드 조회', totalAjax);
			});
			// 회원성과 기간 비교 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpPurMbrGrid"/>', objData, function (response) {
				console.log(response);
				setSalesMbrGrid(response.durCmpPurMbrGrid);
				complete('회원성과 기간 비교 그리드 조회', totalAjax);
			});
			// 아이템 TOP 10개 성과 비교 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpTopItemGrid"/>', objData, function (response) {
				console.log(response);
				setItemTop10Grid(response.durCmpTopItemGrid);
				complete('아이템 TOP 10개 성과 비교 그리드 조회', totalAjax);
			});
			// 상품 TOP 10개 성과 비교 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getDurCmpTopProductGrid"/>', objData, function (response) {
				console.log(response);
				setProductTop10Grid(response.durCmpTopProductGrid);
				complete('상품 TOP 10개 성과 비교 그리드 조회', totalAjax);
			});
		},
	};


	$(document).ready(function () {
		pageObjectDurationCompare.init();

		// 조회
		$("#durationSearchBtn").on('click', function(){
			pageObjectDurationCompare.getDurationCompareData();
		});
	});
</script>