<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
		<div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="ChnlSettleHistListGrid" class="white_bg grid_bd0"></div>
</div>



<script type="text/javascript">
function getChnlSettleHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.chnlRid = channelDetail_rid;
			data.pgmRid  = pgmRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlSettleHist"/>',

        columns : [
        	{
      		  field : 'pgmNm', headerText : '로열티프로그램', headerTextAlign : 'center', textAlign : 'center', width:'300px', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlSettleTypeCd', headerText : '정산유형', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'chnlRelTypeCd'}
    	  },{
    		  field : 'hqRate', headerText : '본사분담율', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'chnlRate', headerText : '채널분담율', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'settleStartDate', headerText : '정산유효시작일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'mbrStatCd'}
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '6',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    ChnlSettleHistListGrid = $("#ChnlSettleHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getChnlSettleHistList();

});

</script>