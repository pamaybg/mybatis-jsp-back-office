<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonCGrid;

//등급그룹 목록 조회
function getSettleMonCList(){
	
    var ejGridOption = {
//         recordDoubleClick : function(data){
//        	},
//         rowSelected : function (data) {
//        	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},		
       	loadComplete : function(obj){
       	},	
        dataUrl : '<ifvm:action name="getSettleMonCList"/>',
        columns:[ 
        	{
	      		  field : 'settleMonth', headerText : '<spring:message code="M02048"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.SETTLE_MONTH' }
	      	  },{
	      		  field : 'settleDtlTypeNm', headerText : '<spring:message code="M02049"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.MARK_NAME' }
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M02050"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.CHNL_NM' }
	      	  },{
	      		  field : 'occuAmtBfr', headerText : '<spring:message code="M02051"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.OCCU_AMT_BFR' }
	      	  },{
	      		  field : 'occuAmt', headerText : '<spring:message code="M02052"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.OCCU_AMT' }
	      	  },{
	      		  field : 'accrualAmtBfr', headerText : '<spring:message code="M02053"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.ACCRUAL_AMT_BFR' }
	      	  },{
	      		  field : 'accrualAmtCur', headerText : '<spring:message code="M02054"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.ACCRUAL_AMT_CUR' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'lsm.rid' }
	      	  }
	      	  
		],
		requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lsm.create_date',
	      	  sord : 'desc',
	      	  _search : false
	        },
        autowidth : true , 
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleMonCGrid = $("#settleMonCGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function settleMonCListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleMonCSearchList","PLOY_404");
}

//공통 조회 호출
function settleMonCListSearch() {
    $.fn.ifvmSubmitSearchCondition("settleMonCSearchList", getSettleMonCList);
} 


$(document).ready(function() {
	
	getSettleMonCList();
    
    //공통 조회 조건 목록 설정
    settleMonCListSearchInit();
    
    //조회
    $('#settleMonCListSearchBtn').on('click', function(){
    	settleMonCListSearch();
    });
    
    //초기화
    $("#settleMonCListSearchInitBtn").on('click', function(){
    	settleMonCListSearchInit();
    });
    
});

</script>

<div class="page-title">
    <h1>
    <spring:message code="M02055" />
        &gt; <spring:message code="M02056" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleMonCListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleMonCListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleMonCSearchList" >
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
    <div id="settleMonCGrid" class="white_bg grid_bd0"></div>     
</div>
