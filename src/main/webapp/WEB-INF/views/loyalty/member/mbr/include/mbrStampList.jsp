<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="스탬프" /></span>
	</div>
</div>
    <div id="mbrAlterHistListGrid" class="white_bg grid_bd0"></div>
 



<script type="text/javascript">
function getAlterHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getAlterHistList"/>',

        columns : [
        	{
      		  field : 'actionDt', headerText : '스탬프 유형', headerTextAlign : 'center', textAlign : 'center',
      	  },{
    		  field : 'msgTypeNm', headerText : '스탬프명', headerTextAlign : 'center', textAlign : 'left',  customAttributes : {index : 'msgType'}

    	  },{
    		  field : 'chnlNm', headerText : '스탬프 수', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}

    	  },{
    		  field : 'msg', headerText : '참여일자', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}

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
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridNotSearchTemplete'
    };
    

    mbrAlterHistListGrid = $("#mbrAlterHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getAlterHistList();

});

</script>