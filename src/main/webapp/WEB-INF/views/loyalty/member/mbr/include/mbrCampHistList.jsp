<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tabContent;

function mbrCampHistList_init() {
	mbrCampHistList();
}


//프로그램 목록
function mbrCampHistList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(mbr_rid)) {
                data.ridMbr = mbr_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
       
        url : '<ifvm:action name="getMbrCampHistList"/>',
        colNames:[ //'적용일자' ,'캠페인 번호','캠페인명','캠페인유형','오퍼명','프로모션 혜택','지급 기준','시작일자','종료일자','캠페인상태'
                   '<spring:message code="L00399"/>'
                  ,'<spring:message code="L00417"/>'
                  ,'<spring:message code="L00416"/>'
                  ,'<spring:message code="L00419"/>'
                  ,'<spring:message code="L00382"/>' 
                  ,'<spring:message code="L00427"/>'
                  ,'<spring:message code="L00403"/>'
                  ,'<spring:message code="L00377"/>'
                  ,'<spring:message code="L00402"/>'
                  ,'<spring:message code="L00418"/>'
                 ],
        colModel:[
            { name:'applyDate',     index:'applyDate', 	    width:'80px', 	align: 'center', 	resizable : true },
            { name:'camNo', 		index:'camNo', 			width:'80px', 	align: 'center', 	resizable : true },
            { name:'camNm', 		index:'camNm', 			width:'120px', 	align: 'left', 		resizable : true },
            { name:'camTypeNm', 	index:'camTypeNm', 		width:'80px', 	align: 'center', 	resizable : true },
            { name:'offerNm', 		index:'offerNm', 		width:'150px', 	align: 'left', 		resizable : true },
            { name:'promTypeNm', 	index:'promTypeNm', 	width:'80px', 	align: 'center', 	resizable : true },
            { name:'promSubTypeNm', index:'promSubTypeNm', 	width:'80px', 	align: 'center', 	resizable : true },
            { name:'camStartDd', 	index:'camStartDd', 	width:'90px', 	align: 'center', 	resizable : true },
            { name:'camEndDd', 		index:'camEndDd', 		width:'90px', 	align: 'center', 	resizable : true },
            { name:'camStatusNm', 	index:'camStatusNm', 	width:'80px', 	align: 'center', 	resizable : true }
        ],
        sortname: 'createDate',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    tabContent = $("#tabContent").ifvGrid({ jqGridOption : jqGridOption });
}


</script>

<div>
	
</div>