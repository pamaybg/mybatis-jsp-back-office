<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignCompanyPopGrid; 

function campaignCompanyPopGrid(){
	var ejGridOption = {
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'channelPopCon',
				contentsId : 'channelOrgArea'
			});
		},
		dataUrl:'<ifvm:action name="getChannelOrg"/>',
		columns:[
	    	  {
	      		  field : 'accName', headerText : '<spring:message code="M00465"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'accStatus', headerText : '<spring:message code="M00464"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'accNumber', headerText : '<spring:message code="M00486"/>', headerTextAlign : 'center',
	      	  },{
	      		  field : 'id', headerText : 'id', headerTextAlign : 'center', visible :false ,
	      	  }
	    ],
	    requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'accNumber',
	    	  sord : 'desc',
	      	  _search : false
	        },
	    rowList : [10,25,50,100],
	    radio: true,
      	tempId : 'ifvGridOriginTemplete',
  	};
	campaignCompanyPopGrid = $("#campaignCompanyPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	campaignCompanyPopGrid();
	
	//선택
	$("#channelOrgSelectBtn").on("click", function(){
		if(campaignCompanyPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = campaignCompanyPopGrid.getCheckedList();
    		$("#companyName").val(dataArr[0].accName).text(dataArr[0].id);
    		channelPopupClose();
    	}
	});
	
	//취소
	$("#channelOrgCancelBtn").on("click", function(){
		channelPopupClose();
	});
});
</script>

<div id="channelOrgArea">
	<div class="pop_inner_wrap">
		<div id="campaignCompanyPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="channelOrgSelectBtn" objCode="channelOrgSelectBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="channelOrgCancelBtn" objCode="channelOrgCancelBtn_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>