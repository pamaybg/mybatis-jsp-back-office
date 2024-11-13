<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="storeListGrid" class="white_bg grid_bd0"></div>
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
var getStoreListGrid; 

function getStoreGrid(){
	var ejGridOption = {
		serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
		},
		rowSelected : function(args){
		},
	    dataUrl:'<ifvm:action name="getEventStoreList"/>',
	    columns:[ 
      	  {
	      		  field : 'storeRid', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.RID' }/* SHOP RID */
	      	  },{
	      		  field : 'storeTypeCd', headerText : '<spring:message code="L02562"/>', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.STORE_TYPE' }/* SHOP 유형 코드 */
	      	  },{
	      		  field : 'storeType', headerText : '<spring:message code="L02563"/>', headerTextAlign : 'center', textAlign : 'center', width : '100px' ,
	      		  customAttributes : {
	      			  index : 'cc1.MARK_NAME' }/* SHOP 유형 */
	      	  },{
	      		  field : 'storeEvtNm', headerText : '<spring:message code="L02564"/>', headerTextAlign : 'center', textAlign : 'left', width : '200px' ,
	      		  customAttributes : {
	      			  index : 'ls.STORE_EVT_NM' }/* 이달의 SHOP 명 */
	      	  },{
	      		  field : 'storeStatusCd', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.STORE_STATUS_CD' }/* 상태 코드 */
	      	  },{
	      		  field : 'storeStatus', headerText : '<spring:message code="L02559"/>', headerTextAlign : 'center', textAlign : 'center', width : '50px' ,
	      		  customAttributes : {
	      			  index : 'cc2.MARK_NAME' }/* 상태 */
	      	  },{
	      		  field : 'actStartDt', headerText : '<spring:message code="L02565"/>', headerTextAlign : 'center', textAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'ls.ACT_START_DT', searchable : false }/* 시작일시 */
	      	  },{
	      		  field : 'actEndDt', headerText : '<spring:message code="L02566"/>', headerTextAlign : 'center', textAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'ls.ACT_END_DT', searchable : false }/* 종료일시 */
	      	  }
      ],
        requestGridData : {
        	nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : "decode(ls.STORE_STATUS_CD, 'A', 1, 2), ls.ACT_START_DT",
	      	  sord : 'desc',
	      	  _search : false
	    },
	   	 rowList : [10,25,50,100],
     	 autowidth : true,
     	 radio : true
     };
	
	getStoreListGrid = $("#storeListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getStoreGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	if(getStoreListGrid.opt.gridControl.getSelectedRecords()[0] == null){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		store = getStoreListGrid.opt.gridControl.getSelectedRecords()[0].storeEvtNm;
    		storeRid = getStoreListGrid.opt.gridControl.getSelectedRecords()[0].storeRid;
    		$("#storeNm").val(store);
    		storePopupClose();
    	}
    });
	
  	//취소 클릭시
    $("#cancelBtn").on("click", function(){
    	storePopupClose();
    });
});
</script>
