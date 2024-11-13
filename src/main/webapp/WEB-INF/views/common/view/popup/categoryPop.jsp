<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var categoryPopList;

function getCategoryPopList(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
    		var dataArr = categoryPopList.opt.gridControl.getSelectedRecords();
    		catDataArr = dataArr;
    		catPopupClose();
       	},
      	serializeGridData : function( data ){
       	},		
       	dataUrl : '/common/view/getCategoryListPop.do',
       	columns:[ 
        	{
          		  field : 'catId', headerText : '<spring:message code="M01962"/>', textAlign : 'center',  customAttributes : {searchable: true, index : 'lpc1.CAT_ID'}
          	  },{
          		  field : 'catNm', headerText : '<spring:message code="L00291"/>', textAlign : 'left',  customAttributes : {searchable: true, index : 'lpc1.CAT_NM'}
          	  },{
          		  field : 'catDesctxt', headerText : '<spring:message code="M01964"/>', textAlign : 'left',  customAttributes : {searchable: true, index : 'lpc1.CAT_DESCTXT'}
          	  },{
          		  field : 'parCatId', headerText : '<spring:message code="M01960"/>', textAlign : 'center', customAttributes : {searchable: true, index : 'lpc2.CAT_ID'}
        	  },{
          		  field : 'parCatNm', headerText : '<spring:message code="M01961"/>', textAlign : 'center',  customAttributes : {searchable: true, index : 'lpc2.CAT_NM'}
          	  },{
          		  field : 'rid', headerText : 'rid', visible : false ,
          	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'lpc2.cat_id, lpc1.cat_id',
        	  sord : 'asc',
        	  _search : false
        },
        allowSorting: true,
        rowList : [10,25,50,100],
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    categoryPopList = $("#categoryPopList").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function() {
	getCategoryPopList();
	
	$("#btnSelect").on('click', function(){
		if(categoryPopList.opt.gridControl.getSelectedRecords() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		// 부모화면에 변수 처리 필요 catDataArr
    		var dataArr = categoryPopList.opt.gridControl.getSelectedRecords();
    		catDataArr = dataArr;
    		catPopupClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		catDataArr = null;
		catPopupClose();
	}); 
});
</script>

<div>
	<div id="categoryPopList"></div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSelect" objCode="categoryPopbtnSelect_OBJ">     
			<i class="glyphicon glyphicon-check" ></i>    
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="categoryPopbtnCancel_OBJ">         
			<spring:message code="M00284"/>
	    </button> 
	</div>
</div>
