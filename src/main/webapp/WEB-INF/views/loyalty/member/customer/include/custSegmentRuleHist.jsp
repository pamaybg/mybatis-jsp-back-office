<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="세분화이력" /></span>
	</div>
</div>
    <div id="getCustSegmentRuleListGrid" class="white_bg grid_bd0"></div>



<script type="text/javascript">
function getCustSegmentRuleList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getCustSegmentRuleHist"/>',

        columns : [
        	{
      		  field : 'csegNm', headerText : '고객 세분화 명', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
      	  },{
    		  field : 'csegStageNm', headerText : '고객 세분화 단계', headerTextAlign : 'center', textAlign : 'center', 

    	  },{
    		  field : 'csegTypeNm', headerText : '세분화 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes: {index: 'csegTypeCd'}

    	  },{
    		  field : 'createByName', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center', 

    	  },{
    		  field : 'createDate', headerText : '등록 일시', headerTextAlign : 'center', textAlign : 'center',

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
        radio: true
    };

    custSegmentRuleListGrid = $("#getCustSegmentRuleListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCustSegmentRuleList();

});

</script>