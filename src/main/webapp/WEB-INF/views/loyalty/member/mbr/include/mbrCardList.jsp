<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tabContent;
var objPop;

function mbrCardList_init() {
	mbrCardList();
}

var page;

//프로그램 목록
function mbrCardList(page){
    
    page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(mbr_rid)) {
                data.ridMbr = mbr_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
       
        url : '<ifvm:action name="getMbrCardList"/>',
    
        colNames:[ 
                   '<spring:message code="L00414"/>',
                   '<spring:message code="L00368"/>',
                   '<spring:message code="L00090"/>',
                   '<spring:message code="L00415"/>',
                   '<spring:message code="L00390"/>',
                   'ridMbr',
                   'rid'                   
                 ],
        colModel:[
            { name:'cardNo', 		index:'a.card_no', 		width:'120px', 	align: 'center', 	resizable : true },
            { name:'issueDate',     index:'a.issue_date', 	width:'120px', 	align: 'center', 	resizable : true },
            { name:'statNm', 	    index:'cd.mark_name', 	width:'80px', 	align: 'center', 	resizable : true },
            { name:'stat',			index:'a.stat', 			hidden : true } ,
            { name:'statSeq', 		index:'cd.seq', 			hidden : true } ,
            { name:'ridMbr', 		index:'a.ridMbr', 			hidden : true } ,
            { name:'rid', 			index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.issue_date',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    tabContent = $("#tabContent").ifvGrid({ jqGridOption : jqGridOption });
}


function mbrCardStatEditPopClose(closeFlag) {

	if(closeFlag == true) {
		mbrCardList(page);
	}

	popupClose();
}


</script>

<div>
	
</div>