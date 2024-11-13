<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">

var noticeListGrid;
function getNoticeList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		data.rid = mbr_rid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getAlertList"/>',
	        columns:[ 
	        	 {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'lbam.rid' }
		      	  },{ 
		      		  field : 'nType', headerText : '유형', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'lbam.MSG_TYPE'} 
		      	  },{
		      		  field : 'msg', headerText : '알림 메시지', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'lbam.msg'}
		      	  },{
		      		  field : 'showYn', headerText : '사용자 확인여부', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'lbam.showYn'}
		      	  },{
		      		  field : 'actionDt', headerText : '발생일', headerTextAlign : 'center', textAlign : 'center',  width:'80px',
		      		  customAttributes : {
		      			  index : 'lbam.actionDt'}
	      	  	  },{
	      		 	 field : 'confirmDt', headerText : '확인일시', headerTextAlign : 'center', textAlign : 'center',  width:'100px',
	      		  	 customAttributes : {
	      			 	  index : 'lbam.CONFIRM_DT'}
	      	  		}
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'actionDt',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	noticeListGrid = $("#noticeListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}



$(document).ready(function() {


	getNoticeList();



	
});

</script>

    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
			<span>조회 결과</span>    
    	</div>
     
    </div>
<div class ="row white_bg">

</div>

<div id="noticeListGrid" class="white_bg grid_bd0"></div>


