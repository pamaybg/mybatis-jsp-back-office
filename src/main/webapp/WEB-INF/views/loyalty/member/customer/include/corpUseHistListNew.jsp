<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="이용내역" /></span>
	</div>
</div>
    <div id="custSvrHistListGrid" class="white_bg grid_bd0"></div>



<script type="text/javascript">
function getCustSvrHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
		rowSelected : function(args) {
		},
        dataUrl : '<ifvm:action name="getCustSvrHistList"/>',

        columns : [
        	{
      		  field : 'svrTypeCdNm', headerText : '서비스항목', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'svrTypeCd'}
      	  },{
    		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'chnlTypeCdNm', headerText : '채널 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlTypeCd'}
    	  },{
    		  field : 'svrDt', headerText : '이용일', headerTextAlign : 'center', textAlign : 'center', 
    	  }
        ],

        requestGridData : {
      	  sidx : '4',
      	  sord : 'desc',

        },
        gridDataInit: true,
        radio: true
    };

    custSvrHistListGrid = $("#custSvrHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCustSvrHistList();

});

</script>