<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>
var promoGridList;



//스탬프 거래리스트
function getCardDtlListSearch(){
  var jqGridOption = {
  		serializeGridData : function( data ){
	    		var pointRid=  rid;
	       		data.rid = pointRid
	            return data;
	        },
	        loadComplete : function(obj){
	        },
	        url : '<ifvm:action name="getPointTransHistory"/>',
	        colNames:[ 
	                   '<spring:message code="L00589" />',  /*프로모션 유형 */
	                   '<spring:message code="L00590" />',  /*프로모션 코드 */
	                   '<spring:message code="L00591" />',  /*프로모션 명*/
	                   '<spring:message code="L00592" />',  /*적립포인트 */
	                 ],
	        colModel:[ 
	            { name:'tabDispNo',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'tabDispNo',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'tabDispNo',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
	            { name:'tabAcrlAmt',   index:'lpa.ACRL_AMT',  resizable : true, align:'right',    width:'120px', formatter:'integer'  },
	          	
	        ],
	    };
  
  promoGridList = $("#promoDtlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	stampDetailDataLoad(testViewList_rid);
 	$.ifvmLnbSetting('testViewList');
 	getCardDtlListSearch();
});
</script>

<script id="userIdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="userCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>
<div id="promoDtlListGrid" class="white_bg grid_bd0"></div>     

