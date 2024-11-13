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
.sumo_regionType{display:table-row;}
.sumo_martType{display:table-row;}
#regionType { height: 25px; }
#martType { height: 25px; }

</style>

<div class="page-title">
    <h1>
       <spring:message code="매장용 리포트"/>  &gt; <spring:message code="회원비교"/>
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="M00607"/></label>
			<ifvm:inputNew type="date" id="startDate" conClass="2" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="endDate" conClass="2" />
			<button class="btn btn-sm" id="reportSearchBtn" objCode="mbrCompareSearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135" /></button>
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

<%-- 그리드 영역 --%>
<div>
	<div class="half_content half_left qt_border">
	    <div class="page_btn_area">
	        <div>
	            <!-- <span id="chnlNo"></span><span id="empName"></span> -->
				<span id="empName"></span>
				<span id="empNo"></span>
	        </div>
	    </div>
    </div>

	<div class="half_content half_right">
	    <div class="page_btn_area">
	        <div>
	            <span id="brandName"></span>
				<button class="btn btn-sm" id="explainTextPopBtn" objCode="mbrCompareExplain_OBJ" style="float: right"><spring:message code="멤버십 등급기준" /></button>
	        </div>
	    </div>
    </div>    
    
	<div class="row qt_border">
	    <div class="half_wrap top_well">
	        <div class="half_content half_left qt_border">
	            <div class="page_btn_area">
	                <div class="col-xs-1">
	                    <span><spring:message code="전체"/></span>
	                </div>
	                <div class="row">
						<ifvm:inputNew type="text" id="shop_total_sales" dto="shop_total_sales" label="매출(천원)" labelClass="1" conClass="2" disabled="true" title="매출(천원)"/>
		                <ifvm:inputNew type="text" id="shop_unit_sales" dto="shop_unit_sales" label="판매수량" labelClass="1" conClass="2" disabled="true" title="판매수량"/>
		                <ifvm:inputNew type="text" id="shop_unit_sales_price" dto="shop_unit_sales_price" label="판매당 단가(원)" labelClass="2" conClass="2" disabled="true" title="판매당 단가(원)"/>
	                </div>
				</div>
	        </div>
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-1">
						<span><spring:message code="전체"/></span>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="brand_total_sales" dto="brand_total_sales" label="매출(천원)" labelClass="1" conClass="2" disabled="true" title="매출(천원)"/>
						<ifvm:inputNew type="text" id="brand_unit_sales" dto="brand_unit_sales" label="판매수량" labelClass="1" conClass="2" disabled="true" title="판매수량"/>
						<ifvm:inputNew type="text" id="brand_unit_sales_price" dto="brand_unit_sales_price" label="판매당 단가(원)" labelClass="2" conClass="2" disabled="true" title="판매당 단가(원)"/>
					</div>
				</div>
			</div>
			<%-- 브랜드 대비 비율 --%>
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-1">
						<span><spring:message code="대비"/></span>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="shop_total_sales_ratio" dto="shop_total_sales_ratio" label="매출" labelClass="1" conClass="2" disabled="true" title="매출(천원)"/>
						<ifvm:inputNew type="text" id="shop_unit_sales_ratio" dto="shop_unit_sales_ratio" label="판매수량" labelClass="1" conClass="2" disabled="true" title="판매수량"/>
						<ifvm:inputNew type="text" id="shop_unit_sales_price_ratio" dto="shop_unit_sales_price_ratio" label="판매당 단가" labelClass="2" conClass="2" disabled="true" title="판매당 단가(원)"/>
					</div>
				</div>
			</div>
	        <div class="form-horizontal top_well underline"></div>
	    </div>
    </div>
    
	<div class="row">
	    <div class="half_wrap top_well">
	        <div class="half_content half_left qt_border">
	            <div class="page_btn_area">
	                <div class="col-xs-1">
	                    <span><spring:message code="회원"/></span>
	                    <span><spring:message code="(비중)"/></span>
	                </div>
	                <div class="row">
	                    <ifvm:inputNew type="text" id="shop_mem_sales" dto="shop_mem_sales" label="회원매출(N%)" labelClass="1" conClass="1" disabled="true" title="회원매출(N%)"/>
	                    <ifvm:inputNew type="text" id="shop_total_mem_cnt" dto="shop_total_mem_cnt" label="현재회원수" labelClass="2" conClass="2" disabled="true" title="전체회원수"/>
	                    <ifvm:inputNew type="text" id="shop_new_mem_cnt" dto="shop_new_mem_cnt" label="신규가입수" labelClass="2" conClass="2" disabled="true" title="신규가입수"/>
	                </div>	   
	                <div class="row">
	                    <ifvm:inputNew type="text" id="shop_customer_cnt" dto="shop_customer_cnt" label="구매고객수" labelClass="2" conClass="1" disabled="true" title="구매고객수"/>
	                    <ifvm:inputNew type="text" id="shop_average_cnt" dto="shop_average_cnt" label="객수량" labelClass="2" conClass="2" disabled="true" title="객수량"/>
	                    <ifvm:inputNew type="text" id="shop_average_price" dto="shop_average_price" label="객단가(원)" labelClass="2" conClass="2" disabled="true" title="객단가(원)"/>
	                </div>
				</div>
	        </div>
			<div class="half_content half_right">
	            <div class="page_btn_area">
	                <div class="col-xs-1">
	                    <span><spring:message code="회원"/></span>
	                    <span><spring:message code="(비중)"/></span>
	                </div>
	                <div class="row">
	                    <ifvm:inputNew type="text" id="brand_mem_sales" dto="brand_mem_sales" label="회원매출(N%)" labelClass="1" conClass="1" disabled="true" title="회원매출(N%)"/>
	                    <ifvm:inputNew type="text" id="brand_total_mem_cnt" dto="brand_total_mem_cnt" label="현재회원수" labelClass="2" conClass="2" disabled="true" title="전체회원수"/>
	                    <ifvm:inputNew type="text" id="brand_new_mem_cnt" dto="brand_new_mem_cnt" label="신규가입수" labelClass="2" conClass="2" disabled="true" title="신규가입수"/>
	                </div>
	                <div class="row">
	                    <ifvm:inputNew type="text" id="brand_customer_cnt" dto="brand_customer_cnt" label="구매고객수" labelClass="2" conClass="1" disabled="true" title="구매고객수"/>
	                    <ifvm:inputNew type="text" id="brand_average_cnt" dto="brand_average_cnt" label="객수량" labelClass="2" conClass="2" disabled="true" title="객수량"/>
	                    <ifvm:inputNew type="text" id="brand_average_price" dto="brand_average_price" label="객단가(원)" labelClass="2" conClass="2" disabled="true" title="객단가(원)"/>
	                </div>	                
	            </div>
	        </div>
			<%-- 브랜드 대비 비율 --%>
			<div class="half_content half_left qt_border">
				<div class="page_btn_area">
					<div class="col-xs-1">
						<span><spring:message code="대비"/></span>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="shop_mem_sales_ratio" dto="shop_mem_sales_ratio" label="회원매출" labelClass="1" conClass="1" disabled="true" title="회원매출(N%)"/>
						<ifvm:inputNew type="text" id="shop_total_mem_cnt_ratio" dto="shop_total_mem_cnt_ratio" label="현재회원수" labelClass="2" conClass="2" disabled="true" title="전체회원수"/>
						<ifvm:inputNew type="text" id="shop_new_mem_cnt_ratio" dto="shop_new_mem_cnt_ratio" label="신규가입수" labelClass="2" conClass="2" disabled="true" title="신규가입수"/>
					</div>
					<div class="row">
						<ifvm:inputNew type="text" id="shop_customer_cnt_ratio" dto="shop_customer_cnt_ratio" label="구매고객수" labelClass="2" conClass="1" disabled="true" title="구매고객수"/>
						<ifvm:inputNew type="text" id="shop_average_cnt_ratio" dto="shop_average_cnt_ratio" label="객수량" labelClass="2" conClass="2" disabled="true" title="객수량"/>
						<ifvm:inputNew type="text" id="shop_average_price_ratio" dto="shop_average_price_ratio" label="객단가" labelClass="2" conClass="2" disabled="true" title="객단가(원)"/>
					</div>
				</div>
			</div>
	    </div>
    </div>    
	
<!--     <div class="white_bg grid_bd0">
    	<div class="half_content half_left qt_border">
    		<div id="gender_chart" style="float: left"></div>
        	<div id="age_chart" style="float: left"></div>
    	</div>
    </div> -->
    
    <div class="half_wrap top_well">
	    <div class="half_content half_left qt_border">
	    	<div style="font-weight: bold"><spring:message code="[회원 현황]"/></div>
	   		<div id="shop_gender_chart" style="float: left"></div>
	       	<div id="shop_age_chart" style="float: left"></div>
	    </div>
	    <div class="half_content half_right">
	    	<div style="font-weight: bold"><spring:message code="[브랜드 회원 현황]"/></div>
			<div id="brand_gender_chart" style="float: left"></div>
	       	<div id="brand_age_chart" style="float: left"></div>    
	    </div>
	</div>
	
	<div class="half_wrap top_well">
	    <div class="half_content half_left qt_border">
	    	<div style="font-weight: bold"><spring:message code="[회원 등급별 비중]"/></div><br>
	    	<div id="shop_non_mbr_grid"></div>
			<div id="shop_gender_grid"></div>
	     	<div id="shop_age_grid"></div>	        
	    </div>
	    <div class="half_content half_right">
	    	<div style="font-weight: bold"><spring:message code="[브랜드 회원 등급별 비중]"/></div><br>
	    	<div id="brand_non_mbr_grid"></div>
			<div id="brand_gender_grid"></div>
	     	<div id="brand_age_grid"></div>   
	    </div>
	</div>
    
</div>
<div id="textPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var shop_gender_chart;
var brand_gender_chart;
var shop_age_chart;
var brand_age_chart;
var shop_gender_grid;
var brand_gender_grid;
var shop_age_grid;
var brand_age_grid;
var shop_non_mbr_grid;
var brand_non_mbr_grid;

var categories = ['19세 이하', '20 ~ 24세', '25 ~ 29세', '30 ~ 34세', '35 ~ 39세', '40 ~ 44세', '45 ~ 49세', '50 ~ 54세', '55 ~ 59세', '60세 이상'];

var genderChartWidth = ($('#shop_gender_chart').parent('div').width()) / 2 - 40;
var ageChartWidth = $('#shop_age_chart').parent('div').width() / 2 - 5;
var chartHeight = 400;
var nonMbrGridWidth = $('#shop_non_mbr_grid').parent('div').width() / 2;

function shop_non_mbr_grid_init() {

	shop_non_mbr_grid = new tui.Grid({
        el: document.getElementById('shop_non_mbr_grid'),
        scrollX: false,
        scrollY: false,
        width: nonMbrGridWidth,
        rowHeight: 30,
        minBodyHeight: 90,  
        data: [
            {
                colNm: '비회원',
                total: '100'+'%'
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
            }
        ]
    });

	shop_non_mbr_grid.getData().forEach(row => {
		shop_non_mbr_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
    });
}

function brand_non_mbr_grid_init() {

	brand_non_mbr_grid = new tui.Grid({
        el: document.getElementById('brand_non_mbr_grid'),
        scrollX: false,
        scrollY: false,
        width: nonMbrGridWidth,
        rowHeight: 30,
        minBodyHeight: 90,  
        data: [
            {
                colNm: '비회원',
                total: '100'+'%'
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
            }
        ]
    });

	brand_non_mbr_grid.getData().forEach(row => {
		brand_non_mbr_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
    });
}

    function shop_gender_grid_init() {

    	shop_gender_grid = new tui.Grid({
            el: document.getElementById('shop_gender_grid'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
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

    	shop_gender_grid.getData().forEach(row => {
    		shop_gender_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }
    
    function shop_age_grid_init() {

    	shop_age_grid = new tui.Grid({
            el: document.getElementById('shop_age_grid'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
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

    	shop_age_grid.getData().forEach(row => {
    		shop_age_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }
    
    function brand_gender_grid_init() {

    	brand_gender_grid = new tui.Grid({
            el: document.getElementById('brand_gender_grid'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
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
                    //className: 'gridClass',
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

    	brand_gender_grid.getData().forEach(row => {
    		brand_gender_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    	
    }
    
    function brand_age_grid_init() {

    	brand_age_grid = new tui.Grid({
            el: document.getElementById('brand_age_grid'),
            scrollX: false,
            scrollY: false,
            //width: 1000,
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

    	brand_age_grid.getData().forEach(row => {
    		brand_age_grid.addCellClassName(row.rowKey, 'name', 'gridClass');
        });
    }    
    
    function shop_gender_chart_init(){
    	const el = document.getElementById('shop_gender_chart');
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
	
 	   shop_gender_chart = toastui.Chart.pieChart({el, data, options});
 	   
       $(window).bind('resize', function (e) {
           shop_gender_chart.resize({
               width: ($('#shop_gender_chart').parent('div').width()) / 2 - 40,
               height: chartHeight
           });
       });
    }
    
    function brand_gender_chart_init(){
	    const el = document.getElementById('brand_gender_chart');
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
	
 	   brand_gender_chart = toastui.Chart.pieChart({el, data, options});
 	   
       $(window).bind('resize', function (e) {
    	   brand_gender_chart.resize({
               width: ($('#shop_gender_chart').parent('div').width()) / 2 - 40,
               height: chartHeight
           });
       }); 	   
    }
    
    function shop_age_chart_init() {
        const el = document.getElementById('shop_age_chart');
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
            yAxis: {
                title: '연령', align: 'center'
            },
            series: {
                stack: true,
                diverging: true,
            },
        };

        shop_age_chart = toastui.Chart.barChart({el, data, options});
        
        $(window).bind('resize', function (e) {
        	shop_age_chart.resize({
                width: $('#shop_age_chart').parent('div').width() / 2 - 5,
                height: chartHeight
            });
        });
    }

    function brand_age_chart_init() {
        const el = document.getElementById('brand_age_chart');
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
            yAxis: {
                title: '연령', align: 'center'
            },
            series: {
                stack: true,
                diverging: true,
            },
        };

        brand_age_chart = toastui.Chart.barChart({el, data, options});
        
        $(window).bind('resize', function (e) {
        	brand_age_chart.resize({
                width: $('#shop_age_chart').parent('div').width() / 2 - 5,
                height: chartHeight
            });
        });        
    }
    
    function setShopNonMbrGrid(total) {
    	var data = [
            {
                colNm: '비회원',
                total: total +'%'
            }
        ];
    	
    	shop_non_mbr_grid.resetData(data);
    }
    
    function setBrandNonMbrGrid(total) {
    	var data = [
            {
                colNm: '비회원',
                total: total +'%'
            }
        ];
    	
    	brand_non_mbr_grid.resetData(data);
    }    
    
    function setShopGenderChart(series) {
    	shop_gender_chart.setData({
       		//categories: categories,     		
            series: series
           });
    }       
    
    function setBrandGenderChart(series) {
       	brand_gender_chart.setData({
       		//categories: categories,    		
            series: series
           });
    }     
    
    function setShopAgeChart(series) {
       	shop_age_chart.setData({
       		categories: categories,     		
            series: series
           });
    }       
    
    function setBrandAgeChart(series) {
       	brand_age_chart.setData({
       		categories: categories,    		
            series: series
           });
    }
    
    function setShopGenderGrid(data) {
    	shop_gender_grid.resetData(data);
    }       
    
    function setBrandGenderGrid(data) {
    	brand_gender_grid.resetData(data);
    }     
    
    function setShopAgeGrid(data) {
       	shop_age_grid.resetData(data);
    }       
    
    function setBrandAgeGrid(data) {
       	brand_age_grid.resetData(data);
    }    
     
	function addComma(value){
        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

	function setRatioText() {
		<%-- 전체 --%>
		// 매출(천원)
		$('#shop_total_sales_ratio').val(
				calcRatio($('#shop_total_sales').val(), $('#brand_total_sales').val())
		);
		// 판매수량
		$('#shop_unit_sales_ratio').val(
				calcRatio($('#shop_unit_sales').val(), $('#brand_unit_sales').val())
		);
		// 판매당 단가(원)
		$('#shop_unit_sales_price_ratio').val(
				calcRatio($('#shop_unit_sales_price').val(), $('#brand_unit_sales_price').val())
		);

		<%-- 회원(비중) --%>
		// 회원매출(N%)
		$('#shop_mem_sales_ratio').val(
				calcRatio($('#shop_mem_sales').val(), $('#brand_mem_sales').val())
		);
		// 현재회원수
		$('#shop_total_mem_cnt_ratio').val(
				calcRatio($('#shop_total_mem_cnt').val(), $('#brand_total_mem_cnt').val())
		);
		// 신규가입수
		$('#shop_new_mem_cnt_ratio').val(
				calcRatio($('#shop_new_mem_cnt').val(), $('#brand_new_mem_cnt').val())
		);
		// 구매고객수
		$('#shop_customer_cnt_ratio').val(
				calcRatio($('#shop_customer_cnt').val(), $('#brand_customer_cnt').val())
		);
		// 객수량
		$('#shop_average_cnt_ratio').val(
				calcRatio($('#shop_average_cnt').val(), $('#brand_average_cnt').val())
		);
		// 객단가(원)
		$('#shop_average_price_ratio').val(
				calcRatio($('#shop_average_price').val(), $('#brand_average_price').val())
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


    var pageObjectMbrCompare = {
	    init: function () {
	        this.sysdateSet();
	        this.userInfoSetting();
			this.commcodeSetting();
			this.textSetting();
	        this.chartInit();
	        //this.getMbrCompareData();
	        //this.getMbrCompareDataTest();
	        
	     	// 조회 이력 추가
			addStoreReportHist("REPORT_PRODUCT_COMPARE");
	    },
	    sysdateSet: function () {
			var startDate = $('#startDate');
			var endDate = $('#endDate');
		    //startDate.val($.ifvGetNewDate('m', -2).newDateS);
			//endDate.val($.ifvGetTodayDate());
			startDate.val($.ifvGetNewDate('d', -1).newDateS);
			endDate.val($.ifvGetNewDate('d', -1).newDateS);
			startDate.ifvDateChecker({});
			endDate.ifvDateChecker({});
	    },
	    userInfoSetting: function () {
	    	//console.log(ifvmUserInfo);
			pageName = 'mbrCompare';
            if(!$.fn.ifvmIsEmpty(shopCode)
			&& !$.fn.ifvmIsEmpty(ridBrand)
			&& !$.fn.ifvmIsEmpty(brandCode)
			&& !$.fn.ifvmIsEmpty(brandName)) return true;

            shopCode = ifvmUserInfo.empNo;
			setBrandCode();
	    	//setShopCnt();
	    },
		commcodeSetting: function() {
			$.fn.ifvmSetSelectOptionCommCode("shopType", "X_DK_MART_OPR_TYPE", null, null, false, "전체");
			setSumoSelect('martType', 'X_DK_OFFLINE_TYPE', '전체');
			setSumoSelect('regionType', 'X_DK_REGION_TYPE', '전체');
		},
		textSetting: function () {
			if($.fn.ifvmIsEmpty(brandName)) brandName = '브랜드';
			if($.fn.ifvmIsEmpty(shopName)) $('#empName').html($.ifvReplaceStr(ifvmUserInfo.empName));
			else                           $('#empName').html($.ifvReplaceStr(shopName));

			$('#empNo').html('(' + $.ifvReplaceStr(shopCode) + ')');
			$('#brandName').html(brandName + ' 평균');
		},
	    chartInit: function () {
	    	//chart
	    	shop_gender_chart_init();
	    	brand_gender_chart_init();
	    	shop_age_chart_init();
	    	brand_age_chart_init();
	    	//grid
	    	shop_non_mbr_grid_init();
	    	brand_non_mbr_grid_init();
	    	shop_gender_grid_init();
	    	brand_gender_grid_init();
	    	shop_age_grid_init();
	    	brand_age_grid_init();
	    },
		mbrGridTitleSetting: function(selectRow) {
			$('#empName').html($.ifvReplaceStr(selectRow.employeeName));
			$('#empNo').html('(' + $.ifvReplaceStr(selectRow.employeeNo) + ')');
			$('#brandName').html(selectRow.brandName + ' 평균');
		},

	    getMbrCompareDataTest: function () {
	    	if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 10;
	    	var startDate = $("#startDate").val();
	    	var endDate = $('#endDate').val();
			var martType = $('#martType').val();
			var regionType = $('#regionType').val();
	    	var type = "shop";

			// 데이터 로드 대기
			beforeSend();
			setShopCnt(martType, regionType);
			//==========================brand 조회
			type = "brand";

			//전체&회원 조회
			$.ifvPostJSON('<ifvm:action name="getMbrCompare"/>', {
				startDate: startDate,
				endDate: endDate,
				shopCode: shopCode,
				brandCode: brandCode,
				martType: martType,
				regionType: regionType,
				shopTypeCode: shopTypeCode,
				type: type,
				shopCnt: shopCnt,
			}, function (response) {
				//console.log(response);
				if($.fn.ifvmIsEmpty(response)){
					$('#brand_total_sales').val(0);
					$('#brand_unit_sales').val(0);
					$('#brand_unit_sales_price').val(0);

					$('#brand_mem_sales').val(0);
					$('#brand_total_mem_cnt').val(0);
					$('#brand_new_mem_cnt').val(0);
					$('#brand_customer_cnt').val(0)
					$('#brand_average_cnt').val(0);
					$('#brand_average_price').val(0);

					setBrandNonMbrGrid([]);
				}
				else {
					$('#brand_total_sales').val(addComma(response.brandTotalSales));
					$('#brand_unit_sales').val(addComma(response.brandUnitSales));
					$('#brand_unit_sales_price').val(addComma(response.brandUnitSalesPrice));

					$('#brand_mem_sales').val(response.brandMemSales);
					$('#brand_total_mem_cnt').val(addComma(response.brandTotalMemCnt));
					$('#brand_new_mem_cnt').val(addComma(response.brandNewMemCnt));
					$('#brand_customer_cnt').val(addComma(response.brandCustomerCnt));
					$('#brand_average_cnt').val(addComma(response.brandAverageCnt));
					$('#brand_average_price').val(addComma(response.brandAveragePrice));

					setBrandNonMbrGrid(response.brandNonMemSales);
				}
				complete('전체회원 조회', totalAjax);
			});
	    	 	
	    },			    
	    getMbrCompareData: function () {
			if($.fn.ifvmIsEmpty(brandCode)) return true;
			var totalAjax = 10;
			var objData = {
				startDate: $("#startDate").val(),
				endDate: $('#endDate').val(),
				shopCode: shopCode,
				brandCode: brandCode,
				martType: $('#martType').val(),
				regionType: $('#regionType').val(),
				shopTypeCode: $('#shopType').val(),
				type: "",
				shopCnt: "",
			}

			// 데이터 로드 대기
			beforeSend();
			setShopCnt(objData.martType, objData.regionType, objData.shopTypeCode);
			//==========================brand 조회
			objData.type = "brand";
			objData.shopCnt = shopCnt;

			//전체&회원 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompare"/>', objData , function (response) {
				//console.log(response);
				if($.fn.ifvmIsEmpty(response)){
					$('#brand_total_sales').val(0);
					$('#brand_unit_sales').val(0);
					$('#brand_unit_sales_price').val(0);

					$('#brand_mem_sales').val(0);
					$('#brand_total_mem_cnt').val(0);
					$('#brand_new_mem_cnt').val(0);
					$('#brand_customer_cnt').val(0);
					$('#brand_average_cnt').val(0);
					$('#brand_average_price').val(0);

					setBrandNonMbrGrid([]);
				}
				else{
					$('#brand_total_sales').val(addComma(response.brandTotalSales));
					$('#brand_unit_sales').val(addComma(response.brandUnitSales));
					$('#brand_unit_sales_price').val(addComma(response.brandUnitSalesPrice));

					$('#brand_mem_sales').val(response.brandMemSales);
					$('#brand_total_mem_cnt').val(addComma(response.brandTotalMemCnt));
					$('#brand_new_mem_cnt').val(addComma(response.brandNewMemCnt));
					$('#brand_customer_cnt').val(addComma(response.brandCustomerCnt));
					$('#brand_average_cnt').val(addComma(response.brandAverageCnt));
					$('#brand_average_price').val(addComma(response.brandAveragePrice));

					setBrandNonMbrGrid(response.brandNonMemSales);
				}
				complete('전체회원 조회', totalAjax, setRatioText);
			});

			//연령 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareAgeGrid"/>', objData, function (response) {
				//console.log(response.shopAgeGrid);
				setBrandAgeGrid(response.brandAgeGrid);
				complete('연령 등급 그리드 조회', totalAjax, setRatioText);
			});

			//성별 연령 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareAgeChart"/>', objData, function (response) {
				//console.log(response.brandAgeChart);
				setBrandAgeChart(response.brandAgeChart);
				complete('성별 연령 차트 조회', totalAjax, setRatioText);
			});

			//성별 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareGenderGrid"/>', objData, function (response) {
				//console.log(response.shopAgeGrid);
				setBrandGenderGrid(response.brandGenderGrid);
				complete('성별 등급 그리드 조회', totalAjax, setRatioText);
			});

			//등급별 구성비 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareGenderChart"/>', objData, function (response) {
				//console.log(response);
				setBrandGenderChart(response.brandGenderChart);
				complete('등급별 구성비 차트 조회', totalAjax, setRatioText);
			});

			objData.type = "shop";

	    	//shop 조회
	    	//전체&회원 조회
	     	$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompare"/>', objData, function (response) {
	     		//console.log(response);
	     		if($.fn.ifvmIsEmpty(response)){
		     		$('#shop_total_sales').val(0);
		     		$('#shop_unit_sales').val(0);
		     		$('#shop_unit_sales_price').val(0);
		     		
		     		$('#shop_mem_sales').val(0);
		     		$('#shop_total_mem_cnt').val(0);
		     		$('#shop_new_mem_cnt').val(0);
		     		$('#shop_customer_cnt').val(0);
		     		$('#shop_average_cnt').val(0);
		     		$('#shop_average_price').val(0);
		     		
		     		setShopNonMbrGrid([]);	     			
				}
				else{
		     		$('#shop_total_sales').val(addComma(response.shopTotalSales));
		     		$('#shop_unit_sales').val(addComma(response.shopUnitSales));
		     		$('#shop_unit_sales_price').val(addComma(response.shopUnitSalesPrice));
		     		
		     		$('#shop_mem_sales').val(response.shopMemSales);
		     		$('#shop_total_mem_cnt').val(addComma(response.shopTotalMemCnt));
		     		$('#shop_new_mem_cnt').val(addComma(response.shopNewMemCnt));
		     		$('#shop_customer_cnt').val(addComma(response.shopCustomerCnt));
		     		$('#shop_average_cnt').val(addComma(response.shopAverageCnt));
		     		$('#shop_average_price').val(addComma(response.shopAveragePrice));
		     		
		     		setShopNonMbrGrid(response.shopNonMemSales);
				}	     		
	     		
				complete('전체 회원 조회', totalAjax, setRatioText);
	        });

			//연령 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareAgeGrid"/>', objData, function (response) {
				//console.log(response.shopAgeGrid);
				setShopAgeGrid(response.shopAgeGrid);
				complete('연령 등급 그리드 조회', totalAjax, setRatioText);
			});

			//성별 연령 차트 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareAgeChart"/>', objData, function (response) {
				//console.log(response.shopAgeChart);
				setShopAgeChart(response.shopAgeChart);
				complete('성별 연령 차트 조회', totalAjax, setRatioText);
			});

			//성별 등급 그리드 조회
			$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareGenderGrid"/>', objData, function (response) {
				//console.log(response.shopAgeGrid);
				setShopGenderGrid(response.shopGenderGrid);
				complete('성별 등급 그리드 조회', totalAjax, setRatioText);
			});

	    	//등급별 구성비 차트 조회
	     	$.ifvMultiplePostJSON('<ifvm:action name="getMbrCompareGenderChart"/>', objData, function (response) {
	     		//console.log(response);  
	     		//console.log('shopGenderChart.length' + response.shopGenderChart.length);
				setShopGenderChart(response.shopGenderChart);
				complete('등급별 구성비 차트 조회', totalAjax, setRatioText);
	        });

	    },		
	};



	
    $(document).ready(function () {
        pageObjectMbrCompare.init();
        
    	// 조회
    	$("#reportSearchBtn").on('click', function(){
    		pageObjectMbrCompare.getMbrCompareData();
    		//pageObjectMbrCompare.getMbrCompareDataTest();
    	});

		$('#explainTextPopBtn').on('click', function() {
			$("#textPopupContainer").ifvsfPopupWidthUp({
				enableModal : true,
				enableResize: false,
				contentUrl: '<ifvm:url name="explainTextPop"/>',
				contentType: "ajax",
				title: '<spring:message code="000223"/>',
				width: 1420,
				close : 'explainTextPopupClose'
			});
		});

    });
</script>