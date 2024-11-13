<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="이벤트 이력" /></span>
	</div>
</div>
    <div id="mbrEventHistListGrid" class="white_bg grid_bd0"></div>
	 
<script type="text/javascript">
function getMbrEventHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			data.intRidMbr = mbr_rid;
			data.mbrStatCd = $("#mbrStatCd").val();
			return data;
		},
        dataUrl : '<ifvm:action name="getMbrEventHistListNew"/>',

        columns : [
        	{
      		  field : 'evtNm', headerText : '이벤트명', headerTextAlign : 'center', textAlign : 'left', customAttributes : {searchable : true}
      	  },{
    		  field : 'evtTypeCdNm', headerText : '이벤트 유형', headerTextAlign : 'center', textAlign : 'center',customAttributes : {index : 'evtTypeCd'}

    	  },{
    		  field : 'applyStartDt', headerText : '시작일시', headerTextAlign : 'center', textAlign : 'center', 

    	  },{
    		  field : 'applyEndDt', headerText : '종료일시', headerTextAlign : 'center', textAlign : 'center', 

    	  },{
    		  field : 'applctDt', headerText : '참여일시', headerTextAlign : 'center', textAlign : 'center', 

    	  },{
    		  field : 'winYn', headerText : '당첨여부', headerTextAlign : 'center', textAlign : 'center',

    	  }/* ,{
    		  field : 'bnfNo', headerText : '혜택번호', headerTextAlign : 'center', textAlign : 'center',

    	  } */
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

    mbrEventHistListGrid = $("#mbrEventHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getMbrEventHistList();

});

</script>