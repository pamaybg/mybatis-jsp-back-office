<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var getPromotionGrid; 

function getPromotionGrid(){
	var ejGridOption = {
		serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
      		data.camTypeCd = 'EVENT'
            return data;
		},
	    dataUrl:'<ifvm:action name="getPromotionPopUpList"/>',
	    columns:[
	    	{
	      		  field : 'ID', headerText : '', visible : false ,
	      		  customAttributes : {
	      			  index : 't1.ID' }/* */
	      	  },{
	      		  field : 'dispNo', headerText : '캠페인 번호', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 't1.disp_no' }/* 캠페인 번호 */
	      	  },{
	      		  field : 'camNm', headerText : '캠페인 명', headerTextAlign : 'center', textAlign : 'left',
	      		  customAttributes : {
	      			  index : 't1.CAM_NM' }/* 캠페인 명*/
	      	  },{
	      		  field : 'startDd', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 't1.CAM_START_DD' }/* 시작일 */
	      	  },{
	      		  field : 'endDd', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 't1.CAM_END_DD' }/* 종료일*/
	      	  },{
	      		  field : 'offerType', headerText : '오퍼유형', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 't6.MARK_NAME' }/* 오퍼유형*/
	      	  },{
	      		  field : 'selfTotAmt', headerText : '포인트', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 't4.self_tot_amt' }/* 포인트*/
	      	  }
	    ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 't1.CAM_START_DD',
	      	  sord : 'desc',
	      	  _search : false
	    },
	   	 rowList : [10,25,50,100],
     	 autowidth : true,
     	 radio : true
     };
	
	getPromotionGrid = $("#promotionGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getPromotionGrid();
	
	//선택 클릭시
    $('#selectPromBtn').on('click', function(){
    	if(getPromotionGrid.opt.gridControl.getSelectedRecords()[0] == null){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		selectProm = getPromotionGrid.opt.gridControl.getSelectedRecords()[0].camNm;
    		selectPromRid = getPromotionGrid.opt.gridControl.getSelectedRecords()[0].id;
    		$("#camNm").val(selectProm);
    		promotionPopUp2Close();
    	}
    });
	
  	//취소 클릭시
    $("#cancelPromBtn").on("click", function(){
    	promotionPopUp2Close();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="promotionGrid" class="white_bg grid_bd0"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectPromBtn">
	        <i class="glyphicon glyphicon-check"></i><spring:message code="L00123"/><!-- 선택 -->
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelPromBtn"><spring:message code="L00124"/><!-- 취소 -->   
	    </button> 
	</div>
</div>