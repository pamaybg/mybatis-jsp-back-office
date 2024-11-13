<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var loyPgmGridCon;


//조직정보 리스트
function loyPgmGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.rid = rid;
			return data;
		},
	    url: '<ifvm:action name="getLoyPgmListPop"/>', 
	    colNames:[ 
                  '<spring:message code="L00036"/>',
                  '<spring:message code="L00077"/>',
                  '<spring:message code="L00090"/>',
                  'rid'
                ],
       colModel:[
			{ name:'pgmNo', 		index:'lp.pgm_no', 			searchable : true,		resizable : false },
			{ name:'pgmNm',			index:'lp.pgm_nm',			searchable : true, 		resizable : false },            
			{ name:'pgmStat', 		index:'lp.pgm_stat', 		searchable : true, 		resizable : false },
			{ name:'rid', 			index:'lp.rid', 			hidden : true },
       ],        
       sortname: 'lp.pgm_no',
       sortorder: "desc",
       radio: true,
       tempId: 'ifvGridOriginTemplete'
	};
	loyPgmGridCon = $("#loyPgmGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	loyPgmGrid();
	
	//선택 클릭시
    $('#selectLoyPgmBtn').on('click', function(){
    	if(loyPgmGridCon.getCheckedGridData() == ''){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		var dataArr = loyPgmGridCon.getCheckedGridData();
    		$('#ridLoyPgm').val(dataArr[0].rid);
    		$('#loyPgmNm').val(dataArr[0].pgmNm);
    		loyPgmPopupClose();	
    	}
    	
    });
	
  	//취소 클릭시
    $('#cancelLoyPgmBtn').on('click', function(){
    	loyPgmPopupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="loyPgmGrid" class=""></div>
	</div>
	
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectLoyPgmBtn">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelLoyPgmBtn">
	    <spring:message code="L00124"/>         
	    </button> 
	</div>
</div>
