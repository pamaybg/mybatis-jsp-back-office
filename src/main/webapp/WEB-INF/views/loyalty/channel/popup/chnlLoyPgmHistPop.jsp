<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div id="chnlLoyPgmHistListGrid" class="white_bg grid_bd0"></div>
</div>



<script type="text/javascript">
function getChnlLoyPgmHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.chnlRid = channelDetail_rid;
			data.pgmRid  = pgmRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlLoyPgmHist"/>',

        columns : [
        	{
      		  field : 'pgmNo', headerText : '프로그램ID', headerTextAlign : 'center', textAlign : 'center', width:'80px', customAttributes :{searchable : true}
      	  },{
    		  field : 'pgmNm', headerText : '프로그램명', headerTextAlign : 'center', width:'100px', customAttributes : {searchable : true}
    	  },{
    		  field : 'useYn', headerText : '사용여부', headerTextAlign : 'center', textAlign : 'center',width:'80px', customAttributes :{searchable : true}
    	  },{
    		  field : 'pntAcrlYn', headerText : '포인트적립', headerTextAlign : 'center', textAlign : 'center',width:'70px', customAttributes :{searchable : true}
    	  },{
    		  field : 'pntRdmYn', headerText : '포인트사용', headerTextAlign : 'center', textAlign : 'center',width:'70px', customAttributes :{searchable : true}
    	  }
    	  ,{
    		  field : 'evtYn', headerText : '이벤트참여', headerTextAlign : 'center', textAlign : 'center',width:'70px', customAttributes :{searchable : true}
    	  }
          ,{
              field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center',width:'140px', customAttributes :{searchable : true}
          }
          ,{
              field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center',width:'100px', customAttributes :{searchable : true}
          }
    	  ,{
    		  field : 'pgmRid', headerText : 'pgmRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'ASC',
      	  _search : false,
          
        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    chnlLoyPgmHistListGrid = $("#chnlLoyPgmHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getChnlLoyPgmHistList();

});

</script>