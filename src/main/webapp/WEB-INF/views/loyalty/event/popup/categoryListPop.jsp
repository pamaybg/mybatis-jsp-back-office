<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="categoryNmGrid" class="white_bg grid_bd0"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn">
	        <i class="glyphicon glyphicon-check"></i><spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn"><spring:message code="L00124"/>   
	    </button> 
	</div>
</div>
<script>
var getCategoryGrid;

function categoryNmGrid(){
	var ejGridOption = {
			serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }     
	            return data;
			},
		    dataUrl:'<ifvm:action name="categoryList"/>',
		    columns:[
		    	  {
		      		  field : 'catNm', headerText : '카테고리 명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'CAT_NM' }/* 카테고리 명 */
		      	  },{
		      		  field : 'catDescTxt', headerText : '카테고리 설명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'CAT_DESCTXT' }/* 카테고리 설명 */
		      	  },{
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'rid' }  /* rid */
		      	  }
		    ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'create_date',
		      	  sord : 'desc',
		      	  _search : false
		    },
		   	 rowList : [10,25,50,100],
	     	 autowidth : false, 
	     	 radio : true
	     };
		
	getCategoryGrid = $("#categoryNmGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	categoryNmGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	var categoryGrid = getCategoryGrid.opt.gridControl.getSelectedRecords()[0];
    	if(categoryGrid == null){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		$('#categoryNm').val(categoryGrid.catNm);
    		categoryRid = categoryGrid.rid;
    		categoryListPopClose();
    	}
    });
	
  	//취소 클릭시
    $("#cancelBtn").on("click", function(){
    	categoryListPopClose();
    });
});

</script>