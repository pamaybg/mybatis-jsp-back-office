<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleDayAGrid;

//등급그룹 목록 조회
function getSettleDayAList(){
    var ejGridOption = {
//     	recordDoubleClick : function(data){
//        	},
//         rowSelected: function (data) {
//        	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},		
//        	loadComplete : function(obj){
//        	},	
       	dataUrl : '<ifvm:action name="getSettleDayAList"/>',
        columns:[ 
        	  {
	      		  field : 'settleDt', headerText : '<spring:message code="M02023"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.SETTLE_DT' }/**/
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="M02024"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.CHNL_NM' }/**/
	      	  },{
	      		  field : 'occuAmtBfr', headerText : '<spring:message code="M02025"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.OCCU_AMT_BFR' }/**/
	      	  },{
	      		  field : 'occuAmt', headerText : '<spring:message code="M02026"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.OCCU_AMT' }/* */
	      	  },{
	      		  field : 'accrualAmtBfr', headerText : '<spring:message code="M02027"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.ACCRUAL_AMT_BFR' }/* */
	      	  },{
	      		  field : 'accrualAmtCur', headerText : '<spring:message code="M02028"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lsd.ACCRUAL_AMT_CUR' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible :false ,
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
        autowidth : true , 
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleDayAGrid = $("#settleDayAGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function settleDayAListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleDayASearchList","PLOY_401");
}

//공통 조회 호출
function settleDayAListSearch() {
    $.fn.ifvmSubmitSearchCondition("settleDayASearchList", getSettleDayAList);
} 

var success;
var datalist;
var listurl;
// 엑셀 호출 
function getSettleDayAListExport(){
	 listurl = settleDayAGrid.ejGridOption.dataUrl;
	 $.ifvSyncPostJSON( listurl, 
			 {item: requestitem ,
		      strOrderby : settleDayAGrid.ejGridOption.requestGridData.sidx ,		      
		      rows : 999999 },  
			 function(result){
		    	  $.ifvSyncPostJSON( '<ifvm:action name="excelExport"/>' , 		    			  	
		 				 { fileName : 'settelDay' ,
		 		  		   header: settleDayAGrid.ejGridOption.colModel  ,
		 		  		   headerName : settleDayAGrid.ejGridOption.colNames ,
		 			       data : result.rows }, 
		 				 function(result){
		 			    	  console.log(result.message);
// 		 			    	  qtjs.href(result.message );
								location.href = result.message;
		 			    	   	 	
		 			     }
		 			       
		 			     );	 
 			   	   
			 });
	
		
		   
	
	 
  } 		   
		   
$(document).ready(function() {
	getSettleDayAList();
    
    //공통 조회 조건 목록 설정
    settleDayAListSearchInit();
    
    //조회
    $('#settleDayAListSearchBtn').on('click', function(){
    	settleDayAListSearch();
    });
    
    //초기화
    $("#settleDayAListSearchInitBtn").on('click', function(){
    	settleDayAListSearchInit();
    });
  //엑셀 다운로드
    $("#settleDayAListExcelExportBtn").on('click', function(){
    	getSettleDayAListExport();
    });
    
    
    
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02029" /> 
        &gt; <spring:message code="M02030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleDayAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleDayAListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleDayASearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleDayAListExcelExportBtn">
                <spring:message code="M01218" />
            </button> 
        </div>
    </div>
    <div id="settleDayAGrid" class="white_bg grid_bd0"></div>     
</div>
