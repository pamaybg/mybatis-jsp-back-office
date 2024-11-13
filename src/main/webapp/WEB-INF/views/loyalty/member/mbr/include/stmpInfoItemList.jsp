<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpItemList;

function getStmpItemList(){
    var ejGridOption = {
    	recordDoubleClick : function (args) {
    		var stmpStatus = $('#stmpStatus').val();
    		if(stmpStatus != 'A') {
	    		goStmpItemDetailPop();
    		}
        },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpItemList"/>',
        columns:[
        	{
	      		  field : 'itemNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsi.ITEM_NO' }
	      	  },{
	      		  field : 'stmpAmt', headerText : '구매금액', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'lsi.STMP_AMT' }
	      	  },{
	      		  field : 'stmpCnt', headerText : '구매횟수', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'lsi.STMP_CNT' }
	      	  },{
	      		  field : 'camNo', headerText : '캠페인코드', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsi.CAM_NO' }
	      	  },{
	      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'mcm.CAM_NM' }
	      	  },{
	      		  field : 'itemBnftNm', headerText : '혜택명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'itemBnftNm', searchable : false, sortable : false }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lsi.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lsi.ITEM_NO',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpItemList = $("#stmpItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	getStmpItemList();
});
</script>

<div id="stmpItemListGrid" class="white_bg grid_bd0"></div>
