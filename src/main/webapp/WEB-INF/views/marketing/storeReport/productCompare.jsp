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

    .tui-grid-cell-header {
        white-space: pre;
    }

    .half_content {
        margin-bottom: 5px;
    }

    #regionType { height: 25px; }
    #martType { height: 25px; }
    .sumo_regionType{display:table-row;}
    .sumo_martType{display:table-row;}
</style>

<div class="page-title">
    <h1>
        <spring:message code="매장용 리포트"/>  &gt; <spring:message code="상품군비교"/>
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
        <div class="row qt_border">
            <ifvm:inputNew type="dateTerm" startDto="vaildStartDt" endDto="vaildEndDt" startId="vaildStartDt" endId="vaildEndDt" label="M00607" labelClass="1" conClass="3"/>
            <label class="col-xs-1 control-label" id="mbrTab"><spring:message code="회원 구분"/></label>
            <div class="col-xs-2 control_content">
                <ifvm:inputNew type="select" id="mbrDiv" names="mbrDiv" dto="mbrDiv" />
            </div>
            <button class="btn btn-sm" id='proComSearch' objCode="proComSearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135"/></button>
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
            <label class="col-xs-1 control-label sexType"> 성별 </label>
            <div class="col-xs-1 control_content sexType">
                <ifvm:inputNew type="select" id="sexType" names="sexType" dto="sexType"/>
            </div>
            <ifvm:inputNew type="text" id="itemCode" className="itemCode" label="아이템 코드" labelClass="1" conClass="1"/>
        </div>
    </div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="half_content half_left qt_border">
        <div class="page_btn_area">
            <div>
                <span id="empName"></span>
                <span id="empNo"></span>
            </div>

        </div>
    </div>

    <div class="half_content half_right">
        <div class="page_btn_area">
            <div>
                <span id="brandName"></span>
            </div>
        </div>
    </div>

    <div class="half_wrap top_well">
        <div class="half_content half_left qt_border">
            <div id="shop_gender_chart" class="half_content half_left"></div>
            <div id="chart_area" class="half_content half_right"></div>
        </div>
        <div class="half_content half_left">
            <div id="brand_gender_chart" class="half_content half_left"></div>
            <div id="chart_area2" class="half_content half_right"></div>
        </div>
    </div>

    <div class="half_wrap top_well">
        <div class="half_content half_left">
            <div class="content_control" id="allTopItem" style="width:31%; float:left; margin-right: 10px; margin-bottom: 5px"></div>    <%--전체 Top 아이템 5개--%>
            <div class="content_control" id="allTopProduct" style="width:31%; float:left; margin-right: 10px; margin-bottom: 5px"></div>    <%--전체 Top 상품 5개--%>
            <div class="content_control" id="clothTopProduct" style="width:31%; float:left;"></div>   <%--의류 Top 상품 5개--%>
            <div class="half_content half_left">
                <div class="half_content half_left" id="brdItemTop"></div>    <%--브랜드 평균 아이템 판매율 대비 상위 5개--%>
                <div class="half_content half_right" id="brdItemTop2"></div>   <%--브랜드 평균 아이템 판매율 대비 하위 5개--%>
            </div>
            <div class="half_content half_right">
                <div class="half_content half_left" id="shoesTopProduct"></div>   <%--신발 TOP 상품 5개--%>
                <div class="half_content half_right" id="supTopProducts"></div>   <%--용품 Top 상품 5개--%>
            </div>
        </div>

        <div class="half_content half_right" style="padding-left: 0px;">
            <div class="control_content" id="brdAllTopItem" style="width: 33%; float:left;"></div>      <%--전체 TOP 아이템 10개(브랜드)--%>
            <div class="control_content" id="brdAllTopProduct" style="width: 33%; float:left; margin-bottom:5px;"></div>      <%--전체 TOP 상품 5개(브랜드)--%>
            <div class="control_content" id="brdClothTopProduct" style="width: 33%; float:left; margin-bottom:5px;"></div>     <%--의류 TOP 상품 5개(브랜드)--%>
            <div class="half_content half_left" id="brdShoesTopProduct" style="width: 33%; margin-left:5px;"></div>      <%--신발 TOP 상품 5개(브랜드)--%>
            <div class="half_content half_right" id="brdSupTopProducts" style="width: 32%; padding-left:0px;"></div>     <%--용품 Top 상품 5개(브랜드)--%>
        </div>
    </div>

</div>

<script type="text/javascript">
    var shop_gender_chart;
    var brand_gender_chart;
    var shop_category_chart;
    var brand_category_chart;


    var barWidth = $('#chart_area').parent('div').width() / 2 - 80;
    var barWidth2 = $('#chart_area2').parent('div').width() / 2 - 80;
    var pieWidth = ($('#shop_gender_chart').parent('div').width()) / 2 - 40;
    var chartHeight = 400;

    var allTopItem;
    var allLowItem;
    var allTopProduct;
    var clothTopProduct;
    var brdItemTop;
    var brdItemTop2;
    var shoesTopProduct;
    var supTopProducts;
    var brdAllTopItem;
    var brdAllLowItem;
    var brdAllTopProduct;
    var brdClothTopProduct;
    var brdShoesTopProduct;
    var brdSupTopProducts;

    var categories = [];

    var gridData = [
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
    ];

    var gridData2 = [
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
        {
            productName: '',
            cnt: ''
        },
    ];

    function setAllTopItem() {

        allTopItem = new tui.Grid({
            el: document.getElementById('allTopItem'),
            scrollX: false,
            scrollY: false,
            rowHeight: 30,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '전체 TOP\n아이템 5개',
                    name: 'productName',
                    align: 'center',
                    height: 40
                },
                {
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center'
                    // ,formatter({ row, column, value}) {
                    //     return value
                    // }
                }
            ]
        });

        allTopItem.getData().forEach(row => {
            allTopItem.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setAllLowItem() {

        allLowItem = new tui.Grid({
            el: document.getElementById('allLowItem'),
            scrollX: false,
            scrollY: false,
            rowHeight: 30,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '전체 LOW\n아이템 5개',
                    name: 'productName',
                    align: 'center',
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        allLowItem.getData().forEach(row => {
            allLowItem.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setAllTopProduct() {

        allTopProduct = new tui.Grid({
            el: document.getElementById('allTopProduct'),
            scrollX: false,
            scrollY: false,
            rowHeight: 30,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '전체 TOP\n상품 5개',
                    name: 'productName',
                    align: 'center',
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        allTopProduct.getData().forEach(row => {
            allTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setClothTopProduct() {

        clothTopProduct = new tui.Grid({
            el: document.getElementById('clothTopProduct'),
            scrollX: false,
            scrollY: false,
            rowHeight: 30,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '의류 TOP\n상품 5개',
                    name: 'productName',
                    align: 'center',
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        clothTopProduct.getData().forEach(row => {
            clothTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdItemTop() {

        brdItemTop = new tui.Grid({
            el: document.getElementById('brdItemTop'),
            scrollX: false,
            scrollY: false,
            rowHeight: 50,
            align: 'center',
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '브랜드 평균\n아이템 판매율\n대비 상위 5개',
                    name: 'productName',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
                ,{
                    header: '판매율\n(브랜드 평균\n대비 차이)',
                    name: 'cnt',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
            ]
        });

        brdItemTop.getData().forEach(row => {
            brdItemTop.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdItemTop2() {

        brdItemTop2 = new tui.Grid({
            el: document.getElementById('brdItemTop2'),
            scrollX: false,
            scrollY: false,
            rowHeight: 50,
            align: 'center',
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '브랜드 평균\n아이템 판매율\n대비 하위 5개',
                    name: 'productName',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
                ,{
                    header: '판매율\n(브랜드 평균\n대비 차이)',
                    name: 'cnt',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
            ]
        });

        brdItemTop2.getData().forEach(row => {
            brdItemTop2.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setShoesTopProduct() {

        shoesTopProduct = new tui.Grid({
            el: document.getElementById('shoesTopProduct'),
            scrollX: false,
            scrollY: false,
            rowHeight: 50,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '신발 TOP\n상품 5개',
                    name: 'productName',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                    // editor: 'text'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
            ],
            columnOptions: {
                resizable: true
            }
        });

        shoesTopProduct.getData().forEach(row => {
            shoesTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setSupTopProducts() {

        supTopProducts = new tui.Grid({
            el: document.getElementById('supTopProducts'),
            scrollX: false,
            scrollY: false,
            rowHeight: 50,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    header: '용픔 TOP\n상품 5개',
                    name: 'productName',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                    whiteSpace: 'pre-wrap'
                }
            ]
        });

        supTopProducts.getData().forEach(row => {
            supTopProducts.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdAllTopItem() {

        brdAllTopItem = new tui.Grid({
            el: document.getElementById('brdAllTopItem'),
            scrollX: false,
            scrollY: false,
            align: 'center',
            rowHeight: 47,
            data: gridData2,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '전체 TOP\n아이템 10개',
                    name: 'productName',
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',

                }
            ]
        });

        brdAllTopItem.getData().forEach(row => {
            brdAllTopItem.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdAllLowItem() {

        brdAllLowItem = new tui.Grid({
            el: document.getElementById('brdAllLowItem'),
            scrollX: false,
            scrollY: false,
            align: 'center',
            rowHeight: 45,
            data: gridData2,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '전체 LOW\n아이템 10개',
                    name: 'productName'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        brdAllLowItem.getData().forEach(row => {
            brdAllLowItem.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }



    function setBrdAllTopProduct() {

        brdAllTopProduct = new tui.Grid({
            el: document.getElementById('brdAllTopProduct'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
            rowHeight: 30,
            minBodyHeight: 90,
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '전체 TOP\n상품 5개',
                    name: 'productName'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        brdAllTopProduct.getData().forEach(row => {
            brdAllTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdClothTopProduct() {

        brdClothTopProduct = new tui.Grid({
            el: document.getElementById('brdClothTopProduct'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
            rowHeight: 30,
            align: 'center',
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '의류 TOP\n상품 5개',
                    name: 'productName'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        brdClothTopProduct.getData().forEach(row => {
            brdClothTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdShoesTopProduct() {

        brdShoesTopProduct = new tui.Grid({
            el: document.getElementById('brdShoesTopProduct'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
            rowHeight: 30,
            align: 'center',
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '신발 TOP\n상품 5개',
                    name: 'productName'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        brdShoesTopProduct.getData().forEach(row => {
            brdShoesTopProduct.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function setBrdSupTopProducts() {

        brdSupTopProducts = new tui.Grid({
            el: document.getElementById('brdSupTopProducts'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
            rowHeight: 30,
            align: 'center',
            data: gridData,
            header: {
                height: 60
            },
            columns: [
                {
                    align: 'center',
                    header: '용품 TOP\n상품 5개',
                    name: 'productName'
                }
                ,{
                    header: '매출\n(수량)',
                    name: 'cnt',
                    align: 'center',
                }
            ]
        });

        brdSupTopProducts.getData().forEach(row => {
            brdSupTopProducts.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }

    function shopPieChart(series) {
        const el = document.getElementById('shop_gender_chart');
        const data = {
            categories: [''],
            series: [{
                name: '기타',
                data: 100,
            }]
        };
        const options = {
            chart: {title: '클래스별 비중', width: pieWidth, height: chartHeight},
            series: {
                dataLabels: {
                    visible: true,
                    pieSeriesName: {
                        visible: true,
                    }
                },
            },
            tooltip: {
                formatter: (value, tooltipDataInfo) => {
                    return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                },
            }
        };

        shop_gender_chart = toastui.Chart.pieChart({el, data, options});
        $(window).bind('resize', function (e) {
            shop_gender_chart.resize({
                width: ($('#shop_gender_chart').parent('div').width()) / 2 - 40,
                height: chartHeight
            });
        });
    }

    function brdPieChart() {
        const el = document.getElementById('brand_gender_chart');
        const data = {
            categories: ['클래스별 비중'],
            series: [{
                name: '기타',
                data: 100,
            }],
        };
        const options = {
            chart: {title: '브랜드 클래스별 비중', width: pieWidth, height: chartHeight},
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

        brand_gender_chart = toastui.Chart.pieChart({el, data, options});
        $(window).bind('resize', function (e) {
            brand_gender_chart.resize({
                width: ($('#brand_gender_chart').parent('div').width()) / 2 - 40,
                height: chartHeight
            });
        });
    }

    function setGenderChart(series, type) {
        console.log('=====series: ' + series);
        if (type < 10) {
            shop_gender_chart.setData({
                series: series
            });
        } else {
            brand_gender_chart.setData({
                series: series
            });
        }
    }

    function setShopGenderChart1(series) {
        shop_gender_chart.setData({
            //categories: categories,
            series: series
        });
    }

    function setShopGenderChart2(series) {
        brand_gender_chart.setData({
            //categories: categories,
            series: series
        });
    }

    function setShopCategoryChart(series) {
        var category = [];
        var data = [];
        var obj = {};
        obj.name = '판매수량';
        obj.data = [];

        if(!$.fn.ifvmIsEmpty(series)) {
            $.each(series, function (index, item) {
                category.push(item.name);
                obj.data.push(item.data);
            })
            data.push(obj);
        }

        shop_category_chart.setData({
            categories: category,
            series: data
        });
    }

    function setBrandCategoryChart(series) {
        var category = [];
        var data = [];
        var obj = {};
        obj.name = '판매수량';
        obj.data = [];

        if(!$.fn.ifvmIsEmpty(series)) {
            $.each(series, function (index, item) {
                category.push(item.name);
                obj.data.push(item.data);
            })
            data.push(obj);
        }

        brand_category_chart.setData({
            categories: category,
            series: data
        });
    }

    function setGridData(grid, data, dummy) {
        if($.fn.ifvmIsEmpty(data)) grid.resetData(dummy);
        else {
            var number = dummy.length - data.length;
            while(number > 0) {
                data.push({
                    productName: '',
                    cnt: ''
                });
                number--;
            }
            grid.resetData(data);
        }
    }



    var pageObjectProductCompare = {
        init: function () {
            this.sysdateSet();
            this.userInfoSetting();
            this.commcodeSetting();
            this.textSetting();
            this.chartInit();
            //this.getInitProductCompareData();
            //this.getInitProductCompareDataTest();

            // 조회 이력 추가
            addStoreReportHist("REPORT_PRODUCT_COMPARE");
        },
        sysdateSet: function () {
            var vaildStartDt = $("#vaildStartDt");
            var vaildEndDt = $("#vaildEndDt");
            vaildStartDt.val($.ifvGetNewDate('d', -7).newDateS);
            vaildEndDt.val($.ifvGetNewDate('d', -1).newDateS);
            vaildStartDt.ifvDateChecker({});
            vaildEndDt.ifvDateChecker({});
        },
        userInfoSetting: function () {
            pageName = 'productCompare';
            if(!$.fn.ifvmIsEmpty(shopCode)
                && !$.fn.ifvmIsEmpty(ridBrand)
                && !$.fn.ifvmIsEmpty(brandCode)
                && !$.fn.ifvmIsEmpty(brandName)) return true;

            shopCode = ifvmUserInfo.empNo;
            setBrandCode();
            // setShopCnt();
        },
        commcodeSetting: function() {
            $.fn.ifvmSetSelectOptionCommCode("mbrDiv", "ANL_CHART_SEARCH_TYPE", null, null, true);
            $.fn.ifvmSetSelectOptionCommCode("shopType", "X_DK_MART_OPR_TYPE", null, null, false, "전체");
            $.fn.ifvmSetSelectOptionCommCode("sexType", "LOY_GEN_CD", null, null, false, "전체");
            setSumoSelect('martType', 'X_DK_OFFLINE_TYPE', '전체');
            setSumoSelect('regionType', 'X_DK_REGION_TYPE', '전체');
        },
        chartInit: function() {
            //chart
            shopBarChart();
            brdBarChart();
            shopPieChart();
            brdPieChart();

            //grid
            setAllTopItem();
            // setAllLowItem();
            setAllTopProduct();
            setClothTopProduct();

            setBrdItemTop();
            setBrdItemTop2();
            setShoesTopProduct();
            setSupTopProducts();

            setBrdAllTopItem();
            // setBrdAllLowItem();
            setBrdAllTopProduct();
            setBrdClothTopProduct();
            setBrdShoesTopProduct();
            setBrdSupTopProducts();
        },
        textSetting: function () {
            if($.fn.ifvmIsEmpty(brandName)) brandName = '브랜드';
            if($.fn.ifvmIsEmpty(shopName)) $('#empName').html($.ifvReplaceStr(ifvmUserInfo.empName));
            else                           $('#empName').html($.ifvReplaceStr(shopName));

            $('#empNo').html('(' + $.ifvReplaceStr(shopCode) + ')');
            $('#brandName').html(brandName + ' 평균');
        },
        prdGridTitleSetting: function(selectRow) {
            $('#empName').html($.ifvReplaceStr(selectRow.employeeName));
            $('#empNo').html('(' + $.ifvReplaceStr(selectRow.employeeNo) + ')');
            $('#brandName').html(selectRow.brandName + ' 평균');
        },
        getInitProductCompareDataTest: function () {
            var startDate = $('#vaildStartDt').val();
            var endDate = $('#vaildEndDt').val();

            var mbrDiv = $('#mbrDiv').val()
            if(mbrDiv != 'MBR' && mbrDiv != 'NMBR'){
                mbrDiv = '';
            }
            beforeSend();

            //브랜드 평균 아이템판매율 대비 그리드 조회
            $.ifvPostJSON('<ifvm:action name="getProductCompareSalesRatioItemGrid"/>', {
                startDate: startDate,
                endDate: endDate,
                shopCode: shopCode,
                brandCode: brandCode,
                martType: martType,
                regionType: regionType,
                martOprType: shopType,
                shopCnt: shopCnt,
                mbrDiv: mbrDiv
            }, function (response) {
                console.log(response);
                if (response.salesRatioTopItemGrid.length > 0 )
                    brdItemTop.resetData(response.salesRatioTopItemGrid);

                if (response.salesRatioLowItemGrid.length > 0 )
                    brdItemTop2.resetData(response.salesRatioLowItemGrid);

                complete('브랜드 평균 아이템판매율 대비 그리드 조회');
            });

        },
        getInitProductCompareData: function () {
            if($.fn.ifvmIsEmpty(brandCode)) return true;
            var totalAjax = 16;
            var mbrDiv = $('#mbrDiv').val()
            if(mbrDiv != 'MBR' && mbrDiv != 'NMBR'){
                mbrDiv = '';
            }

            var objData = {
                startDate: $('#vaildStartDt').val(),
                endDate: $("#vaildEndDt").val(),
                shopCode: shopCode,
                brandCode: brandCode,
                martType: $('#martType').val(),
                regionType: $('#regionType').val(),
                shopTypeCode: $('#shopType').val(),
                shopCnt: "",
                mbrDiv: mbrDiv,
                productClass: "",
                type: "",
                gender: $('#sexType').val(),
                itemCode: $('#itemCode').val()
            }

            beforeSend();
            // 상품군 비교 브랜드 조회용 매장수 조회
            $.ifvSyncPostJSON('<ifvm:action name="getProductShopCnt"/>', {
                brandCode: objData.brandCode,
                martType: objData.martType,
                regionType: objData.regionType,
                shopTypeCode: objData.shopTypeCode,
                startDate: objData.startDate,
                endDate: objData.endDate,
                mbrDiv: objData.mbrDiv,
                gender: objData.gender,
                itemCode: objData.itemCode
                //, shopCode: shopCode
            }, function (response) {
                shopCnt = response;
            });
            objData.shopCnt = shopCnt;

            //브랜드 평균 아이템판매율 대비 그리드 조회 Top
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareSalesRatioTopItemGrid"/>', objData, function (response) {
                // brdItemTop.resetData(response.salesRatioTopItemGrid);
                setGridData(brdItemTop, response.salesRatioTopItemGrid, gridData);
                complete('브랜드 평균 아이템판매율 대비 그리드 조회 Top', totalAjax);
            });

            //브랜드 평균 아이템판매율 대비 그리드 조회 Low
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareSalesRatioLowItemGrid"/>', objData, function (response) {
                // brdItemTop2.resetData(response.salesRatioLowItemGrid);
                setGridData(brdItemTop2, response.salesRatioLowItemGrid, gridData);
                complete('브랜드 평균 아이템판매율 대비 그리드 조회 Low', totalAjax);
            });
            /* ========  shop  ======= */
            objData.type = "shop";

            // 전체 Top 아이템 그리드 조회 (shop)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopItemGrid"/>', objData, function (response) {
                // console.log('전체 Top 아이템 그리드 조회'+response.shopTopItemGrid)
                // allTopItem.resetData(response.shopTopItemGrid);
                setGridData(allTopItem, response.shopTopItemGrid, gridData);
                complete('전체 Top 아이템 그리드 조회', totalAjax);
            });

            //shop 등급별 구성비 차트 조회 (shop)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareClassChart"/>', objData, function (response) {
                // console.log('shop 등급별 구성비 차트 조회'+response.shopClassChart)
                setShopGenderChart1(response.shopClassChart);
                complete('shop 등급별 구성비 차트 조회', totalAjax);
            });

            //상품 카테고리별 비중 차트 조회 (shop)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareCategoryChart"/>', objData, function (response) {
                // console.log('상품 카테고리별 비중 차트 조회'+response.shopCategoryChart)
                setShopCategoryChart(response.shopCategoryChart);
                complete('상품 카테고리별 비중 차트 조회', totalAjax);
            });

            // 전체 Top 상품 그리드 조회 (shop)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('전체 Top 상품 그리드 조회'+response.shopTopProductGrid)
                // allTopProduct.resetData(response.shopTopProductGrid);
                setGridData(allTopProduct, response.shopTopProductGrid, gridData);
                complete('전체 Top 상품 그리드 조회', totalAjax);
            });

            // 의류 Top 상품 그리드 조회 (shop)
            objData.productClass = 1;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('의류 Top 상품 그리드 조회'+response.shopTopProductGrid)
                // clothTopProduct.resetData(response.shopTopProductGrid);
                setGridData(clothTopProduct, response.shopTopProductGrid, gridData);
                complete('의류 Top 상품 그리드 조회', totalAjax);
            });

            // 용품 Top 상품 그리드 조회 (shop)
            objData.productClass = 2;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('용품 Top 상품 그리드 조회'+response.shopTopProductGrid)
                // supTopProducts.resetData(response.shopTopProductGrid);
                setGridData(supTopProducts, response.shopTopProductGrid, gridData);
                complete('용품 Top 상품 그리드 조회', totalAjax);
            });

            // 신발 Top 상품 그리드 조회 (shop)
            objData.productClass = 3;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('신발 Top 상품 그리드 조회'+response.shopTopProductGrid)
                // shoesTopProduct.resetData(response.shopTopProductGrid);
                setGridData(shoesTopProduct, response.shopTopProductGrid, gridData);
                complete('신발 Top 상품 그리드 조회', totalAjax);
            });

            // 전체 LOW 아이템 그리드 조회 (shop)
            objData.productClass = "";
            <%--$.ifvMultiplePostJSON('<ifvm:action name="getProductCompareLowItemGrid"/>', objData, function (response) {--%>
            <%--    allLowItem.resetData(response.shopLowItemGrid);--%>
            <%--    complete('전체 LOW 아이템 그리드 조회', totalAjax);--%>
            <%--});--%>

            /* ========  brand  ======= */
            objData.type = "brand";

            //brand 등급별 구성비 차트 조회 (brand)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareClassChart"/>', objData, function (response) {
                // console.log('brand 등급별 구성비 차트 조회'+response.brandClassChart)
                setShopGenderChart2(response.brandClassChart);
                complete('brand 등급별 구성비 차트 조회', totalAjax);
            });

            //브랜드 카테고리별 비중 차트 조회 (brand)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareCategoryChart"/>', objData, function (response) {
                // console.log('브랜드 카테고리별 비중 차트 조회'+response.brandCategoryChart);
                setBrandCategoryChart(response.brandCategoryChart);
                complete('브랜드 카테고리별 비중 차트 조회', totalAjax);
            });


            //전체 Top 아이템 10 (brand)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopItemGrid"/>', objData, function (response) {
                // console.log('전체 Top 아이템 10'+response.brandTopItemGrid);
                // brdAllTopItem.resetData(response.brandTopItemGrid);
                setGridData(brdAllTopItem, response.brandTopItemGrid, gridData2);
                complete('전체 Top 아이템 10', totalAjax);
            });

            // 브랜드 전체 Top 상품 그리드 조회 (brand)
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('브랜드 전체 Top 상품 그리드 조회'+response.brandTopProductGrid);
                // brdAllTopProduct.resetData(response.brandTopProductGrid);
                setGridData(brdAllTopProduct, response.brandTopProductGrid, gridData);
                complete('브랜드 전체 Top 상품 그리드 조회', totalAjax);
            });

            // 브랜드 의류 Top 상품 그리드 조회 (brand)
            objData.productClass = 1;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // console.log('브랜드 의류 Top 상품 그리드 조회'+response.brandTopProductGrid);
                // brdClothTopProduct.resetData(response.brandTopProductGrid);
                setGridData(brdClothTopProduct, response.brandTopProductGrid, gridData);
                complete('브랜드 의류 Top 상품 그리드 조회', totalAjax);
            });

            // 용품 Top 상품 그리드 조회 (brand)
            objData.productClass = 2;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // brdSupTopProducts.resetData(response.brandTopProductGrid);
                setGridData(brdSupTopProducts, response.brandTopProductGrid, gridData);
                complete('용품 Top 상품 그리드 조회', totalAjax);
            });

            // 산벌 Top 상품 그리드 조회 (brand)
            objData.productClass = 3;
            $.ifvMultiplePostJSON('<ifvm:action name="getProductCompareTopProductGrid"/>', objData, function (response) {
                // brdShoesTopProduct.resetData(response.brandTopProductGrid);
                setGridData(brdShoesTopProduct, response.brandTopProductGrid, gridData);
                complete('신발 Top 상품 그리드 조회', totalAjax);
            });

            //전체 Low 아이템 10 (brand)
            objData.productClass = "";
            <%--$.ifvMultiplePostJSON('<ifvm:action name="getProductCompareLowItemGrid"/>', objData, function (response) {--%>
            <%--    brdAllLowItem.resetData(response.brandLowItemGrid);--%>
            <%--    complete('전체 Low 아이템 10', totalAjax);--%>
            <%--});--%>
        },
    };

    function shopBarChart() {
        const el = document.getElementById('chart_area');
        const data = {
            categories: categories,
            series: [
                { name: '판매수량', data: [] },
            ],
        };
        const options = {
            chart: {title: '매장 판매 상위 카테고리', width: barWidth, height: chartHeight},
            series: {
                stack: {
                    type: 'normal',
                },
                dataLabels: {
                    visible: true,
                    stackTotal: {
                        visible: true,
                        formatter: (value) => {return value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")}
                    },
                    formatter: (value) => {return ''}
                },
            },
            tooltip: {
                formatter: (value, tooltipDataInfo) => {
                    return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                },
            },
            legend: {
                visible: false
            }
        };

        shop_category_chart = toastui.Chart.columnChart({el, data, options});
        $(window).bind('resize', function (e) {
            shop_category_chart.resize({
                width: barWidth,
                height: $('#chart_area2').parent('div').height() - 5
            });
        });
    }

    function brdBarChart(barData) {
        const el = document.getElementById('chart_area2');
        const data = {
            categories: categories,
            series: [
                {
                    name: '판매수량',
                    data: [],
                }
            ],
        };
        const options = {
            chart: {title: '브랜드 판매 상위 카테고리', width: barWidth2, height: chartHeight},
            series: {
                stack: {
                    type: 'normal',
                },
                dataLabels: {
                    visible: true,
                    stackTotal: {
                        visible: true,
                        formatter: (value) => {return value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")}
                    },
                    formatter: (value) => {return ''}
                },
            },
            tooltip: {
                formatter: (value, tooltipDataInfo) => {
                    return tooltipDataInfo.value.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                },
            },
            legend: {
                visible: false
            }
        };

        brand_category_chart = toastui.Chart.columnChart({el, data, options});
        $(window).bind('resize', function (e) {
            brand_category_chart.resize({
                width: barWidth2,
                height: chartHeight
            });
        });
    }


    //조회 버튼
    function proComSearch(){
        pageObjectProductCompare.getInitProductCompareData();
    }




    $(document).ready(function () {
        pageObjectProductCompare.init();

        $('#proComSearch').on('click', function(){
            proComSearch();
        });

    });
</script>