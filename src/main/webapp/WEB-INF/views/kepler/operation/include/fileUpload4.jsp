<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

// 실제 테이블 업로드
function setReExcelUpload(){
	$.ifvProgressControl(true);
	$.ifvPostJSON('<ifvm:action name="setReExcelUpload"/>',{ tableId : tableId , importType : importType, fileNm : fileName} 
	,function(result) {
		$.ifvProgressControl(false);
		//excelResultId = result.id;
		alert(result.message);
	}
	,function(result) {
		$.ifvProgressControl(false);
		alert('<spring:message code="M01779"/>');
		excelResultId = result.id;
		getExcelUpfinalList();
	});
} 

//파일업로드 이력 조회
function getExcelUpResultList(){
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
    
    excelUpResultGrid = $("#excelUpResultGrid").ifvGrid({ jqGridOption : jqGridOption });
    
}

$(document).ready(function(){
	
});

</script>
	

<div class="row">
	<label class="col-xs-12 description_title"><spring:message code="M01780"/></label>
</div>
<div id="excelUpResultGrid" class="white_bg grid_bd0"></div>
