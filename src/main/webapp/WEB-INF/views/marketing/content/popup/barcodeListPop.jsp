<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var barcodeListPopGrid;

function getBarcode(number,start,end){
	offerClick = true;
	barNumber = number;
	barstart = start;    
	barend = end;	
	if(window.lang == "ko") {
		$("#barcodimg").attr('src','/resources/images/marketing/content/barcode_sample2.gif');
	} else {
		$("#barcodimg").attr('src','/resources/images/marketing/content/barcode_sample2_en.gif');
	}
    $('#remove_barcord').show();
    mmsFormNewPopClose();
	
}

/* 조건 목록 */
function barcodeListPop() {
	var text =$("#barType option:selected").val().split('NO');
	
	var jqGridOption = {
	
		onSelectCell : function (data) {
		},
		serializeGridData : function(data){
			data.type = text[0];
			return data
		},
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'mmsFormNewPop',
				contentsId : 'barcodeListArea'
			});
		
			new ifvm.PopupCenter({
	               popupDivId : 'mmsFormNewPop'
			});
		},
        url : '<ifvm:action name="getCouponList"/>',
        colNames:[ 
                   '<spring:message code="M00313"/>',
                   '<spring:message code="M00314"/>',
                   '<spring:message code="M00346"/>',
                   '<spring:message code="M00348"/>',
                   '<spring:message code="M00349"/>',
                   'id'
                   ],
        colModel:[
      	        {name:'offerNo',width:200,index:'mom.offer_no', resizable : false},
      	      {name:'offerName',width:200,index:'mom.offer_nm', resizable : false},  
    	        {name:'idfyNO', index:'mom.type_idfy_no', resizable : false},      
    	        {name:'applyStrDate',index:'mom.aply_start_dd', resizable : false , hidden : true,  searchable : false},
    	        {name:'applyEndDate',index:'mom.aply_end_dd', resizable : false , hidden : true,  searchable : false},
      	        {name:'id',index:'mom.id', resizable : false , hidden : true,  searchable : false}
   	        ],
        sortname: 'mom.offer_no',
        sortorder: "desc",
        radio : true,
        tempId : 'ifvGridOriginTemplete',
        caption: '<spring:message code="M00346"/>'       
        
    }; 
	barcodeListPopGrid = $("#barcodeListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	barcodeListPop();
	
	$("#addBarcodeListBtn").on("click",  function(){
		if(barcodeListPopGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = barcodeListPopGrid.getCheckedGridData();
    		getBarcode(dataArr[0].idfyNO, dataArr[0].applyStrDate, dataArr[0].applyEndDate);
    		$("#imgBarCnt").val(1)
    	}
	});
	
	$("#cancelBarcodeListBtn").on("click",  function(){
		mmsFormNewPopClose();
	});
});
</script>

<div id="barcodeListArea">
	<div class="pop_inner_wrap">	
		<div id="barcodeListPopGrid" class="con_size bp0"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addBarcodeListBtn">   
			<i class="glyphicon glyphicon-check"></i> 
			<spring:message code="M00282" />
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="cancelBarcodeListBtn">         
			<spring:message code="M00284" />
		</button> 
	</div>
</div>