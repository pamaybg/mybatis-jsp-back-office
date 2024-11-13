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
		<spring:message code="매장용 리포트"/>  &gt; <spring:message code="재구매 & 이탈 분석"/>
	</h1>
</div>

<%-- 조회조건 영역 --%>
<div>
	<div class="form-horizontal underline top_well" id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="D10031"/></label>
			<ifvm:inputNew type="date" id="standardDate" conClass="1" />
			<button class="btn btn-sm" id="reportSearchBtn" objCode="repeatBreakawaySearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135" /></button>
			<%@ include file="/WEB-INF/views/marketing/storeReport/include/searchBrandStore.jsp" %>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label martType"> 매장유형 </label>
			<div class="col-xs-1 control_content divSumo">
				<select id="martType" name="martType" multiple="multiple" class="sumoselect_multiple martType">
				</select>
			</div>
			<label class="col-xs-1 control-label regionType"> 지역 </label>
			<div class="col-xs-1 control_content divSumo" style="width: 11%">
				<select id="regionType" name="regionType" multiple="multiple" class="sumoselect_multiple regionType">
				</select>
			</div>
			<label class="col-xs-1 control-label"> 매장운영유형 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="shopType" names="shopType" dto="shopType" />
			</div>
		</div>

	</div>
</div>

<%-- 회원가치 영역 --%>
<div class="control_content">
	<div class="page_btn_area">
		<div class="col-xs-6">
			<span><spring:message code="회원 가치"/></span>
		</div>
	</div>

	<div class="page_btn_area" style="border-bottom-color:#AFAFAF;">
		<div class="col-xs-1">
			<span><spring:message code="본인 매장"/></span>
		</div>
		<div class="row" >
			<ifvm:inputNew type="text" id="repeatCnt" dto="repeatCnt" label="재구매자 수" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="repeatRate" dto="repeatRate" label="재구매율" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="customerChurnCnt" dto="customerChurnCnt" label="이탈 예상 고객 (3개월 기준)" labelClass="2" conClass="1" disabled="true"/>
			<div class="col-xs-3" style="margin-left:20px;">
				<spring:message code="재구매자 : 조회 시점 기준 이전 1년 내 2회 이상 구매한 이력이 있는 고객"/>
				<br><spring:message code="재구매율 : 재구매자/이전 1년 구매 이력이 있는 고객수"/>
			</div>
		</div>
	</div>
	<div class="page_btn_area" style="border-bottom-color:#AFAFAF;">
		<div class="col-xs-1">
			<span><spring:message code="브랜드 평균"/></span>
		</div>
		<div class="row" >
			<ifvm:inputNew type="text" id="brandRepeatCnt" dto="brandRepeatCnt" label="재구매자 수" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="brandRepeatRate" dto="brandRepeatRate" label="재구매율" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="brandCustomerChurnCnt" dto="brandCustomerChurnCnt" label="이탈 예상 고객 (3개월 기준)" labelClass="2" conClass="1" disabled="true"/>
		</div>
	</div>
	<div class="page_btn_area" style="border-bottom: none;">
		<div class="col-xs-1">
			<span><spring:message code="대비율"/></span>
		</div>
		<div class="row" >
			<ifvm:inputNew type="text" id="repeatCntRatio" dto="repeatCntRatio" label="재구매자 수" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="repeatRateRatio" dto="repeatRateRatio" label="재구매율" labelClass="1" conClass="1" disabled="true"/>
			<ifvm:inputNew type="text" id="customerChurnCntRatio" dto="customerChurnCntRatio" label="이탈 예상 고객 (3개월 기준)" labelClass="2" conClass="1" disabled="true"/>
		</div>
	</div>
</div>
<%-- 그리드 영역 --%>
<div>

	<div class="half_content half_left qt_border">
		<div class="page_btn_area">
			<div>
				<span><spring:message code="1.재구매 회원 상세"/></span>
			</div>

		</div>
	</div>

	<div class="half_content half_right">
		<div class="page_btn_area">
			<div>
				<span><spring:message code="2.이탈 예상 고객수"/></span>
				<spring:message code="( 최근 1년 내 구매한 이력이 있으나 3/6/9개월 간 구매 미발생 고객 )"/>
			</div>
		</div>
	</div>

	<div class="half_wrap top_well">
		<div class="half_content half_left qt_border">
			<div id="chartGrid" class="row qt_border">
				<div id="rb_pie_tier_chart" class="half_content half_left"></div>
				<div id="rb_center_y_age_chart" class="half_content half_right"></div>
				<div id="rb_gender_grid"></div>
				<div id="rb_age_grid"></div>
			</div>
		</div>
		<div class="half_content half_right" >
			<div id="break_away_grid"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var rb_pie_tier_chart;
	var rb_center_y_age_chart;
	var rb_gender_grid;
	var rb_age_grid;
	var break_away_grid;

	var genderChartWidth = ($('#rb_pie_tier_chart').parent('div').width()) / 2 - 40;
	var ageChartWidth = $('#rb_center_y_age_chart').parent('div').width() / 2 - 5;
	var chartHeight = 400;

	var categories = ['19세 이하', '20 ~ 24세', '25 ~ 29세', '30 ~ 34세', '35 ~ 39세', '40 ~ 44세', '45 ~ 49세', '50 ~ 54세', '55 ~ 59세', '60세 이상'];

	function rb_gender_grid_init() {

		rb_gender_grid = new tui.Grid({
			el: document.getElementById('rb_gender_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			rowHeight: 30,
			minBodyHeight: 90,
			data: [
				{
					colNm: '남성',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '여성',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				}
			],
			columns: [
				{
					header: '구분',
					name: 'colNm',
					align: 'center',
				},
				{
					align: 'center',
					header: '합계',
					name: 'total'
				},
				{
					align: 'center',
					header: 'VIP',
					name: 'vip'
				},
				{
					align: 'center',
					header: 'Gold',
					name: 'aGrade'
				},
				{
					align: 'center',
					header: 'Silver',
					name: 'bGrade'
				},
				{
					align: 'center',
					header: 'Bronze',
					name: 'cGrade'
				}
			]
		});

		rb_gender_grid.getData().forEach(row => {
			rb_gender_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}

	function rb_age_grid_init() {

		rb_age_grid = new tui.Grid({
			el: document.getElementById('rb_age_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			rowHeight: 30,
			align: 'center',
			data: [
				{
					colNm: '19세 이하',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '20 ~ 24세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '25 ~ 29세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '30 ~ 34세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '35 ~ 39세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '40 ~ 44세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '45 ~ 49세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '50 ~ 54세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '55 ~ 59세',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				},
				{
					colNm: '60세 이상',
					total: '0'+'%',
					vip: '0'+'%',
					aGrade: '0'+'%',
					bGrade: '0'+'%',
					cGrade: '0'+'%'
				}
			],
			columns: [
				{
					align: 'center',
					header: '구분',
					name: 'colNm',
				},
				{
					align: 'center',
					header: '합계',
					name: 'total'
				},
				{
					align: 'center',
					header: 'VIP',
					name: 'vip'
				},
				{
					align: 'center',
					header: 'Gold',
					name: 'aGrade'
				},
				{
					align: 'center',
					header: 'Silver',
					name: 'bGrade'
				},
				{
					align: 'center',
					header: 'Bronze',
					name: 'cGrade'
				}
			]
		});

		rb_age_grid.getData().forEach(row => {
			rb_age_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}


	function break_away_grid_init() {

		break_away_grid = new tui.Grid({
			el: document.getElementById('break_away_grid'),
			scrollX: false,
			scrollY: false,
			//width: 750,
			//rowHeight: document.getElementById('chartGrid').clientHeight / 6,
			rowHeight: document.getElementById('chartGrid').clientHeight / 10,
			align: 'center',
			header: {
				height: 170,
				complexColumns: [
					{
						header: '등급',
						name: 'tierHeader',
						childNames: ['mbrTier'],
					},
					{
						header: '3개월',
						name: 'periodHeader1',
						childNames: ['cntMbr1', 'salRatio1']
					},
					{
						header: '6개월',
						name: 'periodHeader2',
						childNames: ['cntMbr2', 'salRatio2']
					},
					{
						header: '9개월',
						name: 'periodHeader3',
						childNames: ['cntMbr3', 'salRatio3']
					}
				]
			},
			data: [
				{
					mbrTier: '합계',
					cntMbr1: '0',
					salRatio1: '0%',
					cntMbr2: '0',
					salRatio2: '0%',
					cntMbr3: '0',
					salRatio3: '0%'
				},
				{
					mbrTier: 'VIP',
					cntMbr1: '0',
					salRatio1: '0%',
					cntMbr2: '0',
					salRatio2: '0%',
					cntMbr3: '0',
					salRatio3: '0%'
				},
				{
					mbrTier: 'Gold',
					cntMbr1: '0',
					salRatio1: '0%',
					cntMbr2: '0',
					salRatio2: '0%',
					cntMbr3: '0',
					salRatio3: '0%'
				},
				{
					mbrTier: 'Silver',
					cntMbr1: '0',
					salRatio1: '0%',
					cntMbr2: '0',
					salRatio2: '0%',
					cntMbr3: '0',
					salRatio3: '0%'
				},
				{
					mbrTier: 'Bronze',
					cntMbr1: '0',
					salRatio1: '0%',
					cntMbr2: '0',
					salRatio2: '0%',
					cntMbr3: '0',
					salRatio3: '0%'
				}
			],
			columns: [
				{
					header: ' ',
					name: 'mbrTier',
					width: 60,
					className: 'gridClass',
					align: 'center'
				},
				{
					header: '고객수',
					name: 'cntMbr1',
					align: 'center'
				},
				{
					header: '비중',
					name: 'salRatio1',
					align: 'center'
				},
				{
					header: '고객수',
					name: 'cntMbr2',
					align: 'center'
				},
				{
					header: '비중',
					name: 'salRatio2',
					align: 'center'
				},{
					header: '고객수',
					name: 'cntMbr3',
					align: 'center'
				},
				{
					header: '비중',
					name: 'salRatio3',
					align: 'center'
				}
			]
		});

		break_away_grid.getData().forEach(row => {
			break_away_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
		});
	}

	function rb_pie_tier_chart_init(){
		const el = document.getElementById('rb_pie_tier_chart');
		const data = {
			categories: ['등급'],
			series: [
				{
					name: 'VIP',
					data: 25,
				},
				{
					name: 'Gold',
					data: 25,
				},
				{
					name: 'Silver',
					data: 25,
				},
				{
					name: 'Bronze',
					data: 25,
				}
			],
		};
		const options = {
			chart: {title: '등급별 구성비', width: genderChartWidth, height: chartHeight},
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

		rb_pie_tier_chart = toastui.Chart.pieChart({el, data, options});

		$(window).bind('resize', function (e) {
			rb_pie_tier_chart.resize({
				width: ($('#rb_pie_tier_chart').parent('div').width()) / 2 - 40,
				height: chartHeight
			});
		});
	}


	function rb_center_y_age_chart_init() {
		const el = document.getElementById('rb_center_y_age_chart');
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

		rb_center_y_age_chart = toastui.Chart.barChart({el, data, options});

		$(window).bind('resize', function (e) {
			rb_center_y_age_chart.resize({
				width: $('#rb_center_y_age_chart').parent('div').width() / 2 - 5,
				height: chartHeight
			});
		});
	}

	function setGenderChart(series) {
		rb_pie_tier_chart.setData({
			//categories: categories,
			series: series
		});
	}

	function setAgeChart(series) {
		rb_center_y_age_chart.setData({
			categories: categories,
			series: series
		});
	}

	function setGenderGrid(data) {
		rb_gender_grid.resetData(data);
	}

	function setAgeGrid(data) {
		rb_age_grid.resetData(data);
	}

	function setBreakAwayGrid(data) {
		break_away_grid.resetData(data);
	}

	function addComma(value){
		var rtnValue = '';
		if(!$.fn.ifvmIsEmpty(value)) rtnValue = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return rtnValue;
	}

	function setRatioText() {
		<%-- 회원 가치 --%>
		// 재구매자 수
		$('#repeatCntRatio').val(
				calcRatio($('#repeatCnt').val(), $('#brandRepeatCnt').val())
		);
		// 재구매율
		$('#repeatRateRatio').val(
				calcRatio($('#repeatRate').val(), $('#brandRepeatRate').val())
		);
		// 이탈 예상 고객(3개월 기준)
		$('#customerChurnCntRatio').val(
				calcRatio($('#customerChurnCnt').val(), $('#brandCustomerChurnCnt').val())
		);
	}

	function calcRatio(dividend, divisor){
		var rtnRatio = 0;
		if($.fn.ifvmIsEmpty(dividend) || $.fn.ifvmIsEmpty(divisor)) {

		}

		else {
			dividend = parseInt(dividend.replace(/,/g, ''));
			divisor = parseInt(divisor.replace(/,/g, ''));

			if(divisor !== 0) rtnRatio = Math.floor(dividend / divisor * 100 - 100);
		}

		return rtnRatio+'%';
	}


	var pageObjectRepeatBreakaway = {
		init: function () {
			this.sysdateSet();
			this.userInfoSetting();
			this.commcodeSetting();
			this.chartInit();
			// this.getRepeatBreakawayData();
			// this.getRepeatBreakawayDataTest();

			// 조회 이력 추가
			addStoreReportHist("REPORT_REPEAT_BREAKAWAY");
		},
		sysdateSet: function () {
			var standardDate = $('#standardDate');
			standardDate.val($.ifvGetNewDate('d', -1).newDateS);
			standardDate.ifvDateChecker({});
		},
		userInfoSetting: function () {
			pageName = 'repeatBreakaway';
			if(!$.fn.ifvmIsEmpty(shopCode)
					&& !$.fn.ifvmIsEmpty(ridBrand)
					&& !$.fn.ifvmIsEmpty(brandCode)
					&& !$.fn.ifvmIsEmpty(brandName)) return true;

			shopCode = ifvmUserInfo.empNo;
			setBrandCode();
			// setShopCnt();
		},
		commcodeSetting: function() {
			$.fn.ifvmSetSelectOptionCommCode("shopType", "X_DK_MART_OPR_TYPE", null, null, false, "전체");
			setSumoSelect('martType', 'X_DK_OFFLINE_TYPE', '전체');
			setSumoSelect('regionType', 'X_DK_REGION_TYPE', '전체');
		},
		chartInit: function () {
			//chart
			rb_pie_tier_chart_init();
			rb_center_y_age_chart_init();
			//grid
			rb_gender_grid_init();
			rb_age_grid_init();

			break_away_grid_init();
		},
		getRepeatBreakawayDataTest: function () {
			if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 1;

			beforeSend();

			//이탈 예상 고객수 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayGrid"/>', {
				endDate: $("#standardDate").val(),
				shopCode: shopCode,
				brandCode: brandCode,
			}, function (response) {
				//console.log(response);
				if (response.breakawayGrid.length > 0 )
					setBreakAwayGrid(response.breakawayGrid);
				complete('이탈 예상 고객수 그리드 조회', totalAjax);
			});

		},
		getRepeatBreakawayData: function () {
			if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 7;

			var objData = {
				endDate: $("#standardDate").val(),
				shopCode: shopCode,
				brandCode: brandCode,
				martType: $('#martType').val(),
				regionType: $('#regionType').val(),
				shopTypeCode: $('#shopType').val()
			}

			beforeSend();
			setShopCnt(objData.martType, objData.regionType, objData.shopTypeCode);
			objData.shopCnt = shopCnt;

			//이탈 예상 고객수 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayGrid"/>', objData, function (response) {
				//console.log(response);
				setBreakAwayGrid(response.breakawayGrid);
				complete('이탈 예상 고객수 그리드 조회', totalAjax, setRatioText);
			});

			// 본인 매장 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakaway"/>', objData, function (response) {
				//console.log(response);
				$('#repeatCnt').val(addComma(response.repeatCnt));
				$('#repeatRate').val(response.repeatRate + '%');
				$('#customerChurnCnt').val(addComma(response.customerChurnCnt));
				complete('본인 매장 조회', totalAjax, setRatioText);
			});


			// 브랜드 평균 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayBrand"/>', objData, function (response) {
				//console.log(response);
				$('#brandRepeatCnt').val(addComma(response.repeatCnt));
				$('#brandRepeatRate').val(response.repeatRate + '%');
				$('#brandCustomerChurnCnt').val(addComma(response.customerChurnCnt));
				complete('브랜드 평균 조회', totalAjax, setRatioText);
			});

			//연령 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayAgeGrid"/>', objData, function (response) {
				//console.log(response);
				setAgeGrid(response.ageGrid);
				complete('연령 등급 그리드 조회', totalAjax, setRatioText);
			});

			//등급별 구성비 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayGradeChart"/>', objData, function (response) {
				//console.log(response);
				setGenderChart(response.gradeChart);
				complete('등급별 구성비 차트 조회', totalAjax, setRatioText);
			});

			//성별 연령 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayGradeAgeChart"/>', objData, function (response) {
				//console.log(response);
				setAgeChart(response.ageChart);
				complete('성별 연령 차트 조회', totalAjax, setRatioText);
			});

			//성별 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getRepeatBreakawayGenderGrid"/>', objData, function (response) {
				//console.log(response);
				setGenderGrid(response.genderGrid);
				complete('성별 등급 그리드 조회', totalAjax, setRatioText);
			});

		},
	};


	$(document).ready(function () {
		pageObjectRepeatBreakaway.init();

		// 조회
		$("#reportSearchBtn").on('click', function(){
			pageObjectRepeatBreakaway.getRepeatBreakawayData();
		});
	});
</script>