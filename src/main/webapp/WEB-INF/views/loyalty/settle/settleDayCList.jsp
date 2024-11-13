<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleDayCGrid;

//등급그룹 목록 조회
function getSettleDayCList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       	},
        onSelectRow : function (data) {
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},		
       	loadComplete : function(obj){
       	},	
        url : '<ifvm:action name="getSettleDayCList"/>',
        colNames:[ 
                   '<spring:message code="M02031" />',
                   '<spring:message code="M02032" />',
                   '<spring:message code="M02033" />',
                   '<spring:message code="M02034" />',
                   '<spring:message code="M02035" />',
                   '<spring:message code="M02036" />',
                   '<spring:message code="M02037" />',
                   'rid'
                 ],
        colModel:[
            { name:'settleDt', index:'lsd.SETTLE_DT', resizable : false, align: 'center' },
            { name:'settleDtlTypeNm', index:'cc2.MARK_NAME', resizable : false, align: 'center'},
            { name:'chnlNm', index:'lsd.CHNL_NM', resizable : false},
            { name:'occuAmtBfr', index:'lsd.OCCU_AMT_BFR', resizable : false, align: 'right'},
            { name:'occuAmt', index:'lsd.OCCU_AMT', resizable : false, align: 'right'},
            { name:'accrualAmtBfr', index:'lsd.ACCRUAL_AMT_BFR', resizable : false, align: 'right'},
            { name:'accrualAmtCur', index:'lsd.ACCRUAL_AMT_CUR', resizable : false, align: 'right'},
            { name:'rid', index:'lsd.rid', hidden : true}
        ],
        sortname: 'lsd.create_date',
        autowidth : true , sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleDayCGrid = $("#settleDayCGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function settleDayCListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleDayCSearchList","PLOY_402");
}

//공통 조회 호출
function settleDayCListSearch() {
    $.fn.ifvmSubmitSearchCondition("settleDayCSearchList", getSettleDayCList);
} 


$(document).ready(function() {
	getSettleDayCList();
    
    //공통 조회 조건 목록 설정
    settleDayCListSearchInit();
    
    //조회
    $('#settleDayCListSearchBtn').on('click', function(){
    	settleDayCListSearch();
    });
    
    //초기화
    $("#settleDayCListSearchInitBtn").on('click', function(){
    	settleDayCListSearchInit();
    });
    
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02038" /> 
        &gt; <spring:message code="M02039" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleDayCListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleDayCListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleDayCSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="settleDayCGrid" class="white_bg grid_bd0"></div>     
</div>
