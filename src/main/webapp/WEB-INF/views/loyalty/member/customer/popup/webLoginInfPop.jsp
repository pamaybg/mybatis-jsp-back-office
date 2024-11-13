<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div id="custLoginInfoListGrid" class="white_bg grid_bd0"></div>
</div>


<script type="text/javascript">
var agreRid=null;
var agreTypeCd=null;
function getCustLoginInfo(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
		rowSelected : function(args) {
		},
        dataUrl : '<ifvm:action name="getCustLoginInfo"/>',

        columns : [
        	{
      		  field : 'loginTypeCd', headerText : '로그인 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'loginTypeCd'}
      	  },{
    		  field : 'userId', headerText : '유저 아이디', headerTextAlign : 'center', textAlign : 'left'
    	  },{
    		  field : 'failCnt', headerText : '로그인실패횟수', headerTextAlign : 'center', textAlign : 'right', customAttributes :{searchable : true}
    	  },{
    		  field : 'failDate', headerText : '로그인실패일시', headerTextAlign : 'center', textAlign : 'center',
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '4',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    custLoginInfoListGrid = $("#custLoginInfoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	getCustLoginInfo();
});

</script>