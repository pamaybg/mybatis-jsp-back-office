<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="L02783"/></span>
        </div>

    </div>
    <div id="chnlMbrRelListGrid" class="white_bg grid_bd0"></div>
</div>



<script type="text/javascript">
function getChnlMbrRelList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = channelDetail_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getChnlMbrRelList"/>',

        columns : [
        	{
      		  field : 'pgmNm', headerText : '로열티프로그램', headerTextAlign : 'center', width:'300px', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlRelTypeCdNm', headerText : '관계유형', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'chnlRelTypeCd'}
    	  }
          // ,{
    		//   field : 'seqNo', headerText : '순위', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  // }
          ,{
    		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'mbrStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'mbrStatCd'}
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false
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

    chnlMbrRelListGrid = $("#chnlMbrRelListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getChnlMbrRelList();

});

</script>