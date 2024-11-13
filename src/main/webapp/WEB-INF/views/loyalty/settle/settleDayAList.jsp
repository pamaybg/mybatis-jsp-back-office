<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleDayAGrid;

//등급그룹 목록 조회
function getSettleDayAList(){
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
        url : '<ifvm:action name="getSettleDayAList"/>',
        colNames:[ 
                   '<spring:message code="M02023" />',
                   '<spring:message code="M02024" />',
                   '<spring:message code="M02025" />',
                   '<spring:message code="M02026" />',
                   '<spring:message code="M02027" />',
                   '<spring:message code="M02028" />',
                   'rid'
                 ],
        colModel:[
            { name:'settleDt', index:'lsd.SETTLE_DT', resizable : false, align: 'center' },
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
    
    settleDayAGrid = $("#settleDayAGrid").ifvGrid({ jqGridOption : jqGridOption });
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
	 listurl = settleDayAGrid.jqGridOption.url;
	 $.ifvSyncPostJSON( listurl, 
			 {item: requestitem ,
		      strOrderby : settleDayAGrid.jqGridOption.sortname ,		      
		      rows : 99999999 },  
			 function(result){
		    	  $.ifvSyncPostJSON( '<ifvm:action name="excelExport"/>' , 		    			  	
		 				 { fileName : 'settelDay' ,
		 		  		   header: settleDayAGrid.jqGridOption.colModel  ,
		 		  		   headerName : settleDayAGrid.jqGridOption.colNames ,
		 			       data : result.rows }, 
		 				 function(result){
		 			    	  
		 			    	  qtjs.href(result.message );
		 			    	   	 	
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
