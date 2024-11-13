<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="멤버십카드" /></span>
	</div>
</div>
    <div id="mbrMemberCardListGrid" class="white_bg grid_bd0"></div>
	 



<script type="text/javascript">
function getMemberCardList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getMemberCardList"/>',

        columns : [
        	{
      		  field : 'cardTypeCdNm', headerText : '카드 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'cardTypeCd'}
      	  },{
    		  field : 'cardKindNm', headerText : '카드명', headerTextAlign : 'center', textAlign : 'left', customAttributes :{searchable : true}

    	  },{
    		  field : 'cardNo', headerText : '카드번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}

    	  },{
    		  field : 'cardStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'cardStatCd'}

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

    mbrMemberCardListGrid = $("#mbrMemberCardListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getMemberCardList();

});

</script>