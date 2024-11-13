<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonAGrid;

//등급그룹 목록 조회
function getSettleMonAList(){
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
        url : '<ifvm:action name="getSettleMonAList"/>',
        colNames:[ 
                   '<spring:message code="M02040" />',
                   '<spring:message code="M02041" />',
                   '<spring:message code="M02042" />',
                   '<spring:message code="M02043" />',
                   '<spring:message code="M02044" />',
                   '<spring:message code="M02045" />',
                   'rid'
                 ],
        colModel:[
            { name:'settleMonth', index:'lsm.SETTLE_MONTH', resizable : false, align: 'center' },
            { name:'chnlNm', index:'lsm.CHNL_NM', resizable : false},
            { name:'occuAmtBfr', index:'lsm.OCCU_AMT_BFR', resizable : false, align: 'right'},
            { name:'occuAmt', index:'lsm.OCCU_AMT', resizable : false, align: 'right'},
            { name:'accrualAmtBfr', index:'lsm.ACCRUAL_AMT_BFR', resizable : false, align: 'right'},
            { name:'accrualAmtCur', index:'lsm.ACCRUAL_AMT_CUR', resizable : false, align: 'right'},
            { name:'rid', index:'lsm.rid', hidden : true}
        ],
        sortname: 'lsm.create_date',
        autowidth : true , sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleMonAGrid = $("#settleMonAGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function settleMonAListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleMonASearchList","PLOY_403");
}

//공통 조회 호출
function settleMonAListSearch() {
    $.fn.ifvmSubmitSearchCondition("settleMonASearchList", getSettleMonAList);
} 


$(document).ready(function() {
	getSettleMonAList();
    
    //공통 조회 조건 목록 설정
    settleMonAListSearchInit();
    
    //조회
    $('#settleMonAListSearchBtn').on('click', function(){
    	settleMonAListSearch();
    });
    
    //초기화
    $("#settleMonAListSearchInitBtn").on('click', function(){
    	settleMonAListSearchInit();
    });
    
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02046" /> 
        &gt; <spring:message code="M02047" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleMonAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleMonAListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleMonASearchList" >
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
    <div id="settleMonAGrid" class="white_bg grid_bd0"></div>     
</div>
