<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>

    </div>
    <div id="mbrCustListGrid" class="white_bg grid_bd0"></div>
</div>



<script type="text/javascript">
function getMbrCustListList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getmbrCustList"/>',

        columns : [
        	{
      		  field : 'actionDt', headerText : '알림 발생일시', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
    		  field : 'msgType', headerText : '알림유형', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '2'
    		  }
    	  },{
    		  field : 'chnlNm', headerText : '채널', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '3'
    		  }
    	  },{
    		  field : 'msg', headerText : '알림 메시지', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '4'
    		  }
    	  },{
    		  field : 'showYn', headerText : '사용자 확인여부', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : '5'
    		  }
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lmam.ACTION_DT',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    mbrCustListListGrid = $("#mbrCustListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getMbrCustListList();

});

</script>