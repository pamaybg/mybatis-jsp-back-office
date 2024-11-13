<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//파일업로드 이력 조회
function getExcelUpfinalList(){
    var jqGridOption = {
        ondblClickRow : function(data){
        },
        onSelectRow : function (data) {
        },
   		serializeGridData : function( data ){
   			data.id = excelResultId;
   		},		
   		loadComplete : function(obj){
   		},
   		url : '<ifvm:action name="getExcelUpResultList"/>',
   		colNames:[ '<spring:message code="M00443"/>',
		 	       '<spring:message code="M01757"/>',
		 	       '<spring:message code="M01758"/>',
		 	       '<spring:message code="M01759"/>',
		 	       '<spring:message code="M01760"/>',
		 	       'id'
		          ],
	    colModel:[
	       { name:'fileNm', index:'aur.file_nm',  resizable : false },
	       { name:'allCnt', index:'aur.all_cnt', align: 'right', formatter:'integer', resizable : false },
	       { name:'okCnt', index:'aur.ok_cnt', align: 'right', formatter:'integer', resizable : false },
	       { name:'noCnt', index:'aur.no_cnt', align: 'right', formatter:'integer', resizable : false },
	       { name:'uploadTime', index:'aur.upload_time', align: 'right', resizable : false },
	       { name:'id', index:'aur.id', hidden : true } 
        ],
        tempId : 'fileUpPopTemplete'
    };
    
    excelUpfinalGrid = $("#excelUpfinalGrid").ifvGrid({ jqGridOption : jqGridOption });
    
}

$(document).ready(function(){
	getExcelUpfinalList();
});

</script>
<style type="text/css">
	.description_content{
		padding-top:15px;
	}
</style>
<div class="row">
	<label class="col-xs-10 description_title"><spring:message code="M01781"/></label>
</div>
<div id="excelUpfinalGrid" class="white_bg grid_bd0"></div>
<div class="row">
	<label class="col-xs-10 description_content"><span class="asterisk">※<spring:message code="M01782"/></span></label>
	<%-- <label class="col-xs-12 description_content"><spring:message code="M01783"/></label> --%>
</div>