<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="자격 포인트" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" text="엑셀 다운로드" nuc="true" id="mbrOnBoardExcelList"  btnFunc="mbrOnBoardExcelList" />
     </div>
</div>
    <div id="mbrOnBoardHistListGrid" class="white_bg grid_bd0"></div>	


<script type="text/javascript">
function getMbrOnBoardHistList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getMbrOnBoardHistList"/>',

        columns : [
        	{
      		  field : 'bDate', headerText : '거래일자', headerTextAlign : 'center', textAlign : 'center', 
      	  },{
    		  field : 'airTypeNm', headerText : '국내/국제', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'airType'}

    	  },{
    		  field : 'origin', headerText : '출발지', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'desti', headerText : '도착지', headerTextAlign : 'center', textAlign : 'center',

    	  },{
    		  field : 'flight', headerText : '항공편번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}

    	  },{
    		  field : 'seatclass', headerText : '좌석클래스', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'class'}

    	  },{
    		  field : 'mile', headerText : '포인트', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}'

    	  },{
    		  field : 'bCnt', headerText : '탑승횟수', headerTextAlign : 'center', textAlign : 'right'

    	  },{
    		  field : 'ticket', headerText : '티켓번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}

    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc'

        },
        radio: true,
    };

    mbrOnBoardHistListGrid = $("#mbrOnBoardHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function mbrOnBoardExcelList() {
	$.ifvExcelDn('/loyalty/member/mbr/mbrOnBoardHistExcelListGrid.do','mbrOnBoardHistListGrid');
}



$(document).ready(function(){
	
	getMbrOnBoardHistList();
	

});

</script>