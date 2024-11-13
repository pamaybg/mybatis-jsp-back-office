<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpStoreList;

function getStmpStoreList(){
    var ejGridOption = {
//         onSelectRow : function (data) {
//         },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpStoreList"/>',
        columns:[
        	{
	      		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NO' }
	      	  },{
	      		  field : 'chnlTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'right', width : '100px',
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }
	      	  },{
	      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'right', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lss.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lss.MODIFY_DATE',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpStoreList = $("#stmpStoreListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function() {
	getStmpStoreList();
});
</script>

<style>
#hideFile {
	display: none
}
</style>

<div id="test">
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
    </div>
    <div id="stmpStoreListGrid" class="white_bg grid_bd0"></div>
</div>
