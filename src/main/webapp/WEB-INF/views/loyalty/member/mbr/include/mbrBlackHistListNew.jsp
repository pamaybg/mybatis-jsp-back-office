<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="부정이력" /></span>
	</div>
</div>
    <div id="mbrBlackHistListGrid" class="white_bg grid_bd0"></div>
 



<script type="text/javascript">
function getBlackHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getBlackHistList"/>',

        columns : [
        	{
      		  field : 'blNm', headerText : '부정이력 명', headerTextAlign : 'center', textAlign : 'left', customAttributes :{searchable : true}
      	  },{
    		  field : 'blackHistCnt', headerText : '횟수', headerTextAlign : 'center', textAlign : 'center'

    	  },{
    		  field : 'chnlNm', headerText : '발생채널', headerTextAlign : 'center', textAlign : 'left'

    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '2',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };

    mbrBlackHistListGrid = $("#mbrBlackHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getBlackHistList();

});

</script>