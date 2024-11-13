<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
    .gridClass{
        background-color: #f9f9f9;
    }
</style>


<div class="page-title">
    <h1>
    	매장용 리포트 > 등급별 회원 & 매출 성과
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
	<div class="form-horizontal underline top_well">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="M00607"/></label>
            <div class="col-xs-1 control_content">
                <ifvm:inputNew type="select" id="year" names="year" dto="year"/>
            </div>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month"/>
			</div>
            <button class="btn btn-sm" id="salesPerfSearchBtn" objCode="salesPerformanceSearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135" /></button>
            <%@ include file="/WEB-INF/views/marketing/storeReport/include/searchBrandStore.jsp" %>
		 </div>
	</div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area">

        <div class="col-xs-7">
            <span><spring:message code="등급별 회원 & 매출 성과" /></span>
        </div>
<%--        <div class="col-xs-5 searchbtn_r">--%>
<%--            <button class="btn btn-sm" id="excelExportBtn" objCode="ordProdListExcel_OBJ">--%>
<%--                <spring:message code="M01218" />--%>
<%--            </button>--%>
<%--        </div>--%>
    </div>
		<div id="grid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var grid;

function chart_init() {
	grid = new tui.Grid({
		el: document.getElementById('grid'),
		scrollX: false,
		scrollY: false,
		rowHeight: 35,
		header: {
			height: 80,
			complexColumns: [
				{
					header: '구분',
					name: 'mbr',
					childNames: ['mbrYn', 'mbrTear'],
				},
				{
					header: '당월',
					name: 'mergeColumn1',
					childNames: ['cntMbr', 'salAmt']
				},
				{
					header: '전월',
					name: 'mergeColumn2',
					childNames: ['cntMbr1', 'salAmt1']
				},
                {
                    header: '전년',
                    name: 'mergeColumn0',
                    childNames: ['cntMbr0', 'salAmt0']
                },
				{
					header: '전월 대비(%)',
					name: 'mergeColumn3',
					childNames: ['cntMbr2', 'salAmt2']
				},
				{
					header: '전년 동월 대비(%)',
					name: 'mergeColumn4',
					childNames: ['cntMbr3', 'salAmt3']
				}
			]
		},
		data: [
			{
				mbrYn: '회원',
				mbrTear: 'VIP',
				cntMbr: '0',
				salAmt: '0',
				cntMbr1: '0',
				salAmt1: '0',
                cntMbr0: '0',
                salAmt0: '0',
				cntMbr2: '0%',
				salAmt2: '0%',
				cntMbr3: '0%',
				salAmt3: '0%',
				_attributes: {
					// deprecated
					rowSpan: { // Merge rows
						mbrYn: 4
					}
				}
			},
			{
				mbrTear: 'Gold',
				cntMbr: '0',
				salAmt: '0',
				cntMbr1: '0',
				salAmt1: '0',
                cntMbr0: '0',
                salAmt0: '0',
				cntMbr2: '0%',
				salAmt2: '0%',
				cntMbr3: '0%',
				salAmt3: '0%'
			},
			{
				mbrTear: 'Silver',
				cntMbr: '0',
				salAmt: '0',
				cntMbr1: '0',
				salAmt1: '0',
                cntMbr0: '0',
                salAmt0: '0',
				cntMbr2: '0%',
				salAmt2: '0%',
				cntMbr3: '0%',
				salAmt3: '0%'
			},
			{
				mbrTear: 'Bronze',
				cntMbr: '0',
				salAmt: '0',
				cntMbr1: '0',
				salAmt1: '0',
                cntMbr0: '0',
                salAmt0: '0',
				cntMbr2: '0%',
				salAmt2: '0%',
				cntMbr3: '0%',
				salAmt3: '0%'
			},
			{
				mbrYn: '',
				mbrTear: '합계',
				cntMbr: '0',
				salAmt: '0',
				cntMbr1: '0',
				salAmt1: '0',
                cntMbr0: '0',
                salAmt0: '0',
				cntMbr2: '0%',
				salAmt2: '0%',
				cntMbr3: '0%',
				salAmt3: '0%'
			}
		],
		columns: [
			{
				header: ' ',
				name: 'mbrYn',
				width: 60,
				className: 'gridClass',
				align: 'center'
			},
			{
				header: ' ',
				name: 'mbrTear',
				width: 60,
				className: 'gridClass',
				align: 'center'
			},
			{
				header: '회원수',
				name: 'cntMbr',
				align: 'center'
			},
			{
				header: '매출액',
				name: 'salAmt',
				align: 'center'
			},
			{
				header: '회원수',
				name: 'cntMbr1',
				align: 'center'
			},
			{
				header: '매출액',
				name: 'salAmt1',
				align: 'center'
			},
            {
                header: '회원수',
                name: 'cntMbr0',
                align: 'center'
            },
            {
                header: '매출액',
                name: 'salAmt0',
                align: 'center'
            },
            {
				header: '회원수',
				name: 'cntMbr2',
				align: 'center'
			},
			{
				header: '매출액',
				name: 'salAmt2',
				align: 'center'
			},{
				header: '회원수',
				name: 'cntMbr3',
				align: 'center'
			},
			{
				header: '매출액',
				name: 'salAmt3',
				align: 'center'
			},
		],
/* 		summary: {
	        height: 40,
	        align: 'right',
	        position: 'bottom', // or 'top'
	        columnContent: {
				cntMbr: {
					align: 'center',
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				salAmt: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				cntMbr1: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				salAmt1: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				cntMbr2: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				salAmt2: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				cntMbr3: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    },
				salAmt3: {
		            template: function(summary) {
			              return 'TOTAL: ' + summary.sum;
			            }
			    }
	        }
		}, */
	});

	grid.getData().forEach(row => {
		grid.addCellClassName(row.rowKey, 'name', 'gridClass');
	});
}

function setGrid(data) {
    data[0].mbrYn = '회원';
    data[0]._attributes = {
        rowSpan: {
            mbrYn: 4
        }
    }
	grid.resetData(data);
}


var pageObjectSalesPerformance = {
	    init: function () {
			$.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
			
	        this.sysdateSet();
	        this.userInfoSetting();
	        this.chartInit();
	        //this.getSalesPerformanceData();
	        
	     	// 조회 이력 추가
			addStoreReportHist("REPORT_TIER_MBR_SALES_PERFM");
	    },
	    sysdateSet: function () {
	       var d = new Date();
	       var reqYear = String(d.getFullYear());
	       var reqMonth = d.getMonth() + 1;
	       reqMonth = reqMonth >= 10 ? reqMonth : '0' + reqMonth;
	       $("#year").val(reqYear);
	       $("#month").val(reqMonth);
	    },
	    userInfoSetting: function () {
            pageName = 'salesPerformance';
            if(!$.fn.ifvmIsEmpty(shopCode)
            && !$.fn.ifvmIsEmpty(ridBrand)
            && !$.fn.ifvmIsEmpty(brandCode)
            && !$.fn.ifvmIsEmpty(brandName)) return true;

            shopCode = ifvmUserInfo.empNo;
            setBrandCode();
            // setShopCnt();
	    },
	    chartInit: function () {
	    	chart_init();
	    },	    
	    getSalesPerformanceData: function () {
            if($.fn.ifvmIsEmpty(brandCode)) return true;
            var totalAjax = 1;
	    	var inputYear =  $("#year").val();
	    	var inputMonth =  $("#month").val();
	    	var day;
	    	var current = new Date();
	    	var currentMonth = current.getMonth()+1;
	    	currentMonth = currentMonth >= 10 ? currentMonth : '0' + currentMonth;

            if(inputMonth === currentMonth) {
                day = current.getDate() >= 10 ? current.getDate() : '0' + current.getDate();
            }
	    	else day = new Date(inputYear, inputMonth,0).getDate();

	    	var endDate = inputYear+inputMonth+day;	    	
	    	//테스트용
	    	//shopCode = "S3007";

            beforeSend();
            setShopCnt();

	    	//전체 조회
	     	$.ifvMultiplePostJSON('<ifvm:action name="getSalesPerformance"/>', {
	     		endDate: endDate
	            , shopCode: shopCode
	            , brandCode: brandCode
	     	}, function (response) {
                if(response.length > 0) setGrid(response);
                else {
                    grid.destroy();
                    chart_init();
                }

                complete('등급별 회원 & 매출 성과 조회', totalAjax);
	        });
	    },		
};

$(document).ready(function() {
	pageObjectSalesPerformance.init();

	// 조회
	$("#salesPerfSearchBtn").on('click', function(){
		pageObjectSalesPerformance.getSalesPerformanceData();
	});

    // 초기화
    // $("#reportSearchInitBtn").on('click', function(){
    // 	pageObjectSalesPerformance.sysdateSet();
    // });
	
});
</script>