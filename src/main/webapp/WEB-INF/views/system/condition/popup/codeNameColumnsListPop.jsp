<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var columnListPopGrid; 

function columnListPopGrid(){	
	 var selectedTableId;
	 var ejGridOption = {
		    	serializeGridData : function(data) {
					data.tblEngNm = conditionGroupCode;
					//페이지 설정
					return data;
				},
		    	
		        dataUrl : '<ifvm:action name="getDropDownListColumList"/>',

		        columns : [
		        	{
		      		  field : 'colEngNm', headerText : '<spring:message code="M00538"/>', customAttributes : {searchable : true}
		      	  },{
		    		  field : 'colKorNm', headerText : '<spring:message code="M00539"/>',  customAttributes : { searchable : true}
		    	  },{
		    		  field : 'srchCondDesc', headerText : '<spring:message code="M00540"/>',  customAttributes : { searchable : true}
		    	  }
		        ],

		        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : '1',
		      	  sord : 'ASC',
		      	  _search : false,

		        },
		        rowList : [10,25,50,100],
		        gridDataInit: true,
		        radio: true
		    };

	 columnListPopGrid = $("#columnListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	columnListPopGrid();
	
	//선택
	$("#columnListSelectBtn").on("click", function(){
		if(columnListPopGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = columnListPopGrid.opt.gridControl.getSelectedRecords()[0];
    		/* srcColId = dataArr.id; */
    		ddlVwCnCol = dataArr.colEngNm;
    		//srcColId = dataArr.id;
    		$("#dropDownCodeName").val(dataArr.colEngNm);
    		popupClose();
    	}
	});
	
	//취소
	$("#columnListCancelBtn").on("click", function(){
		popupClose();
	});
});
</script>

<div id="columnListArea">
	<div class="pop_inner_wrap">
		<div id="columnListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="columnListSelectBtn" objCode="columnListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="columnListCancelBtn" objCode="columnListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>