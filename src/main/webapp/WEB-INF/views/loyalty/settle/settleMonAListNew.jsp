<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonAGrid;

//등급그룹 목록 조회
function getSettleMonAList(){
    var ejGridOption = {
    	recordDoubleClick : function(data){
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
       	dataUrl : '<ifvm:action name="getSettleMonAList"/>',
       	columns:[
        	  {
	      		  field : 'settleMonth', headerText : '<spring:message code="M02040"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.SETTLE_MONTH' }/* */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M02041"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.CHNL_NM' }/* */
	      	  },{
	      		  field : 'occuAmtBfr', headerText : '<spring:message code="M02042"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.OCCU_AMT_BFR' }/* */
	      	  },{
	      		  field : 'occuAmt', headerText : '<spring:message code="M02043"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.OCCU_AMT' }/* */
	      	  },{
	      		  field : 'accrualAmtBfr', headerText : '<spring:message code="M02044"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.ACCRUAL_AMT_BFR' }/* */
	      	  },{
	      		  field : 'accrualAmtCur', headerText : '<spring:message code="M02045"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsm.ACCRUAL_AMT_CUR' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'lsm.rid' }/* */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lsm.create_date',
	      	  sord : 'desc',
	      	  _search : false
	        },
		rowList : [10,25,50,100],
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleMonAGrid = $("#settleMonAGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
