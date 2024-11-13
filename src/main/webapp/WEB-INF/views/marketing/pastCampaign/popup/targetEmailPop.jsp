<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
function getPromoListSearch(){
    var jqGridOption = {
    		serializeGridData : function( data ){
	        },
	        loadComplete : function(obj){
	        },
	        url : '<ifvm:action name="getEmsilSendList"/>',
	        colNames:[
	                   '<spring:message code="M02696" />',  /*회원번호 */
	                   '<spring:message code="M02697" />',  /*회원명 */
	                   '<spring:message code="M02705" />',  /*반응일시*/
	                   '<spring:message code="M02706" />',  /*채널명 */
	                   '<spring:message code="M02707" />',  /*수신상태 */
	                   '<spring:message code="M02708" />',  /*Email 알람여부 */
	                   '<spring:message code="M02709" />',  /*실패사유 */
	                 ],
	        colModel:[
	            { name:'mbrNo',   		index:'t1.mbr_no',  		resizable : true, align:'center',    width:'100px' },
	            { name:'custNm',   		index:'lc.cust_nm', 		resizable : true, align:'center',    width:'100px' },
	            { name:'asgnDt',   		index:'t1.ASGN_DT ',  		resizable : true, align:'center',    width:'100px' },
	            { name:'trtName',  		index:'t1.TRT_NAME',  		resizable : true, align:'right',     width:'120px'  },
	            { name:'commMethodNm',  index:'t1.COMM_METHOD_NM',  resizable : true, align:'right',     width:'120px'  },
	            { name:'ofcrDirFlg',   	index:'t1.OFCR_DIR_FLG',  	resizable : true, align:'right',     width:'120px'  },
	            { name:'descText',   	index:'t1.DESC_TEXT',  		resizable : true, align:'right',     width:'120px'  },
	        ],
	    };

    emailList = $("#emailListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	getPromoListSearch();

});

</script>

<div>
    <div id="emailListGrid" class="white_bg grid_bd0"></div>
</div>

