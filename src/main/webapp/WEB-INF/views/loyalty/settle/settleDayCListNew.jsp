<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleDayCGrid;

//등급그룹 목록 조회
function getSettleDayCList(){
    var ejGridOption = {
//        	ondblClickRow : function(data){
//        	},
//         onSelectRow : function (data) {
//        	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},		
       	loadComplete : function(obj){
       	},	
        dataUrl : '<ifvm:action name="getSettleDayCList"/>',
        columns:[ 
        	  {
	      		  field : 'settleDt', headerText : '<spring:message code="M02031"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.SETTLE_DT' }/* */
	      	  },{
	      		  field : 'settleDtlTypeNm', headerText : '<spring:message code="M02032"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.MARK_NAME' }/* */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M02033"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.CHNL_NM' }/* */
	      	  },{
	      		  field : 'occuAmtBfr', headerText : '<spring:message code="M02034"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.OCCU_AMT_BFR' }/* */
	      	  },{
	      		  field : 'occuAmt', headerText : '<spring:message code="M02035"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.OCCU_AMT' }/* */
	      	  },{
	      		  field : 'accrualAmtBfr', headerText : '<spring:message code="M02036"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.ACCRUAL_AMT_BFR' }/* */
	      	  },{
	      		  field : 'accrualAmtCur', headerText : '<spring:message code="M02037"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.ACCRUAL_AMT_CUR' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'lsd.rid' }/* */
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lsd.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
//         autowidth : true ,
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleDayCGrid = $("#settleDayCGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
