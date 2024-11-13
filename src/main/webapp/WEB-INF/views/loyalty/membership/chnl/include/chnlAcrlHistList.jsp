<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tabContent;

function chnlAcrlHistList_init() {
	chnlAcrlHistList();
}


//목록
function chnlAcrlHistList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	
        	if ($.fn.ifvmIsNotEmpty(chnl_rid)) {
                data.rid = chnl_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
       
        url : '<ifvm:action name="getChnlAcrlHistList"/>',
    
        colNames:[ //'가능여부', '적용 일자', '생성자', '생성일자', 'rid'       
                   '<spring:message code="L00310"/>',
                   '<spring:message code="L00399"/>',
                   '<spring:message code="L00093"/>',
                   '<spring:message code="L00092"/>', 
                   'rid'                   
                 ],
        colModel:[
            { name:'acrlPsblYnNm', 	index:'cd.mark_name', 		width:'80px', 	align: 'center', 	resizable : true },
            { name:'applyDate',     index:'a.apply_date', 		width:'90px', 	align: 'center', 	resizable : true },
            { name:'createBy', 	    index:'em.name', 			width:'200px', 	align: 'center', 		resizable : true  },
            { name:'createDate',	index:'a.create_date', 		width:'200px', 	align: 'center', 		resizable : true  },
            { name:'rid', 			index:'a.rid', 				hidden : true } 
        ],
        sortname: 'a.create_date',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    tabContent = $("#tabContent").ifvGrid({ jqGridOption : jqGridOption });
}


</script>

<div>
	
</div>