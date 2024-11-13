<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="채널관계"/></span>
	</div>
</div>
    <div id="ChnlRelHistListGrid" class="white_bg grid_bd0"></div>
	 



<script type="text/javascript">
function getChnlRelHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlRelHistList"/>',

        columns : [
        	{
      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left', customAttributes : {searchable : true}
      	  },{
    		  field : 'chnlRelTypeNm', headerText : '관계유형', headerTextAlign : 'center', textAlign : 'center',customAttributes : {index : 'chnlRelTypeCd'}

    	  },{
    		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',

    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };

    ChnlRelHistListGrid = $("#ChnlRelHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getChnlRelHistList();

});

</script>