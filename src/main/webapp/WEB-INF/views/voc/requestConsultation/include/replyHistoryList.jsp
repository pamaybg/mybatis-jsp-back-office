<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var actyHistoryGrid;
var data = {};

function actyHistoryList(){
	var ejGridOption = {
		rowSelected : function (data) {
	    	actyHistoryData = null;
	    	actyHistoryData = data;
	    	console.log(data);
	  
		},
		serializeGridData : function( data ){
			if(rid != "null"){
				data.rid = rid;
			}
		},
	 	loadComplete : function(data) {
	 		if(opener){
	 			opener.parent.setParentIframeHeight();
	 		}else{
	 			parent.setParentIframeHeight();
	 		}
		},
		dataUrl : '<ifvm:action name="getReplyHistoryList"/>',

        columns : [
        	{
      		  field : 'writer', headerText : '답변자', headerTextAlign : 'center', width:'80px' ,textAlign : 'center', customAttributes :{index : 'atvyType'}
      	  },{
    		  field : 'prodNo', headerText : '상품번호', headerTextAlign : 'center', textAlign : 'center',  width:'50px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'prodNm', headerText : '상품명', textAlign : 'center',width:'130px' , headerTextAlign : 'center'
    	  },{
    		  field : 'reContent', headerText : '답변내용',width:'260px' ,headerTextAlign : 'center', textAlign : 'left', customAttributes :{index : 'chnlSendDt'}
    	  },{
    		  field : 'adminDate', headerText : '답변일시',width:'100px',headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlRpyDt'}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '5',
      	  sord : 'desc',
        },
        radio: true,	
    };
	
	actyHistoryGrid = $("#actyHistoryList").ifvsfGrid({ ejGridOption : ejGridOption });
}





function init(){
	//$("#emailBtn ,#smsBtn, #msgBtn").prop("disabled",true);
	actyHistoryList();
}


$(document).ready(function(){
	init();

	
});
</script>

<div class="page_btn_area">
	<div class="col-xs-2">
	<span><spring:message code="답변내역" /></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		
	</div>
</div>
<div id="actyHistoryList" class="white_bg grid_bd0"></div>

<!-- 활동내역 신규 팝업 -->
<div id="actyHistoryPop"></div>
<!-- 활동내역 메시지 팝업 -->
<div id="actyHistoryMsgPop"></div>
