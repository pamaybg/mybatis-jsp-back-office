<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script type="text/javascript">
var promoList;
promoRid=  '<%= cleanXss(request.getParameter("promoRid")) %>'
defaultArchive =  '<%= cleanXss(request.getParameter("defaultArchive")) %>'
function getPromoListSearch(){
    var jqGridOption = {
    		serializeGridData : function( data ){
	    		var pointRid =  promoRid ;
	       		data.rid = pointRid
	       	    if(typeof defaultArchive != "undefined" && defaultArchive != "null" ){
	          	 	data.defaultArchive = defaultArchive;
	      	 	}
	            return data;
	        },
	        loadComplete : function(obj){
	        },
	        url : '<ifvm:action name="getTransPromoList"/>',
	        colNames:[
					'<spring:message code="L00590" />',  /*프로모션 코드 */
					'<spring:message code="L00589" />',  /*프로모션 유형 */
					'<spring:message code="L00591" />',  /*프로모션 명*/
					'<spring:message code="L00592" />',  /*적립포인트 */



	                 ],
	        colModel:[
					{ name:'tabDispNo',   index:'mcm.DISP_NO',  resizable : true, align:'center',    width:'100px' },
					{ name:'camNm',   index:'mcm.cam_nm',  resizable : true, align:'center',    width:'100px' },
					{ name:'offerNm',   index:'mom.offer_nm',  resizable : true, align:'center',    width:'100px' },
					{ name:'tabAcrlAmt',   index:'lpa.ACRL_AMT',  resizable : true, align:'right',    width:'120px', formatter:'integer'  },
	        ],
	    };

    promoList = $("#promoListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	getPromoListSearch();

});

</script>

<div>
    <div id="promoListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stampTxnDetailDialog" class="popup_container"></div>
