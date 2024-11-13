<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="cafe24MbrHistGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">

var cafe24MbrHistGrid;

function getCafe24MbrCamHist(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.userId = userId;
			return data;
		},
   		recordDoubleClick : function (args) {
        },

        dataUrl : '<ifvm:action name="getCafe24MbrCamHist"/>',

        columns : [
        	{
      		  field : 'dispNo', headerText : '캠페인번호', headerTextAlign : 'center', textAlign : 'center'
      	  },{
    		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'camTypeNm', headerText : '캠페인 구분', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'camStatusNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'camStartDt', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'camEndDt', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'chnlNm', headerText : '발송채널', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'sendStatus', headerText : '발송결과', headerTextAlign : 'center', textAlign : 'center'
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
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    cafe24MbrHistGrid = $("#cafe24MbrHistGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getCafe24MbrCamHist();
	
});
</script>

