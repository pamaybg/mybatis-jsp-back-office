<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="brandNmGrid" class="white_bg grid_bd0"></div>
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
var getBrandNmGrid;

function brandNmGrid(){
	var ejGridOption = {
			serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }     
	            return data;
			},
		    dataUrl:'<ifvm:action name="getBrandNmList"/>',
		    columns:[
		    	  {
		      		  field : 'brdId', headerText : '브랜드 ID', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'BRD_ID' }/* 브랜드 ID*/
		      	  },{
		      		  field : 'brdNm', headerText : '브랜드명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'BRD_NM' }/* 브랜드명 */
		      	  },{
		      		  field : 'brdDescTxt', headerText : '브랜드설명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'BRD_DESCTXT' }/* 브랜드설명*/
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
		
	getBrandNmGrid = $("#brandNmGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	brandNmGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	var brandGrid = getBrandNmGrid.opt.gridControl.getSelectedRecords()[0];
    	if(brandGrid == null){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		$('#brandNm').val(brandGrid.brdNm);
    		brdRid = brandGrid.rid;
    		brandNmListPopClose();
    	}
    });
	
  	//취소 클릭시
    $("#cancelBtn").on("click", function(){
    	brandNmListPopClose();
    });
});

</script>