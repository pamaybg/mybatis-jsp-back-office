<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="App이력" /></span>
	</div>
</div>
    <div id="custAppHistListGrid" class="white_bg grid_bd0"></div>




<script type="text/javascript">
function getCustAppHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getAppSvrHistList"/>',

        columns : [
        	{
      		  field : 'regDate', headerText : '일시', headerTextAlign : 'center', textAlign : 'center',
      	  },{
    		  field : 'mobileDeviceCdNm', headerText : '디바이스', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'verNo', headerText : '버전', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'tokenVal', headerText : '토큰', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lmah.reg_date',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    custAppHistListGrid = $("#custAppHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCustAppHistList();

});

</script>