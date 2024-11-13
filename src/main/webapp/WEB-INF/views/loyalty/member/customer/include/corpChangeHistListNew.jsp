<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="변경이력" /></span>
	</div>
</div>
    <div id="custChangeHistListGrid" class="white_bg grid_bd0"></div>




<script type="text/javascript">
function getCustChangeHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChangeHistList"/>',

        columns : [
        	{
      		  field : 'createDate', headerText : '변경일시', headerTextAlign : 'center', textAlign : 'center',
      	  },{
    		  field : 'chgColNm', headerText : '변경항목', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chgCol'}
    	  },{
    		  field : 'bchngData', headerText : '변경전', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'bchngData'}
    	  },{
    		  field : 'achngData', headerText : '변경후', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'achngData'}
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
    };

    custChangeHistListGrid = $("#custChangeHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCustChangeHistList();

});

</script>