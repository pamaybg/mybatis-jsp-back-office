<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="categoryPopList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCatPopSelect" objCode="addCategorySelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCatPopCancel" objCode="addCategoryCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script>
var categoryPopList;

function getCategoryList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
       	},		
       	dataUrl : '/common/view/getCategoryListPop.do',
       	columns:[ 
       		  { 
				 type : "checkbox", width : 60, headerText: '선택',customAttributes :{sortable :  false }
			  },{
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
        radio: false,
        tempId : 'ifvGridOriginTemplete'
    };
    
    categoryPopList = $("#categoryPopList").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCategoryList();
	
	$("#btnCatPopSelect").click(function(){
		var add_rid = [];
    		var checkedList = categoryPopList.opt.gridControl.getSelectedRecords();
    		if (checkedList.length == 0) {
    			alert('<spring:message code="M00285"/>');
    		}else{
    			for(var i = 0; i < checkedList.length; i++){
    				var rowData = {
    						catRid : checkedList[i].rid
    				};
    				add_rid.push(rowData);
    			}
    		}
    		 $.ifvSyncPostJSON('/loyalty/prodgrp/addCategory.do', {
 		        prodGrpRid : prodGrp_Rid,
 		    	ridList : add_rid
 		    }, function(result) {
 		    	alert(result.message);
 		    	$.fn.ifvmPopupClose();
 		    	categoryListGrid._doAjax();

 		    });

	});
	
	$("#btnCatPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>

