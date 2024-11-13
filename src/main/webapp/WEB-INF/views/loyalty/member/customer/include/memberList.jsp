<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L00856" /></span>
	</div>
</div>
<div id="custMemGrid"></div>

<script>
var custMemGrid;

//프로그램 목록
function getMemberList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
    		    	
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(cust_rid)) {
                data.rid = cust_rid;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
       
        url : '<ifvm:action name="getMemberList"/>',
    
        colNames:[ // '회원 ID', '가입 채널',  '가입일자', '회원 유형', '상태',  '로열티프로그램', '등급', 'rid'
                   '<spring:message code="L00432"/>',
                   '<spring:message code="L00312"/>',
                   '<spring:message code="L00311"/>',
                   '<spring:message code="L00434"/>', 
                   '<spring:message code="L00090"/>',
                   '<spring:message code="L00077"/>',
                   '<spring:message code="L00324"/>',
                   'rid'                   
                 ],
        colModel:[
            { name:'mbrNo', 	    index:'a.mbr_no', 		width:'80px', 	align: 'center', 	resizable : true },
            { name:'chnlNm', 		index:'c.chnl_nm', 		width:'200px', 	align: 'center', 	resizable : true },
            { name:'joinDate', 	    index:'a.join_date', 	width:'80px', 	align: 'center', 	resizable : true  },
            { name:'mbrTypeNm', 	index:'cd.mark_name', 	width:'80px', 	align: 'center', 	resizable : true  },
            { name:'mbrStatNm', 	index:'cd1.mark_name', 	width:'80px', 	align: 'center', 	resizable : true  },            
            { name:'pgmNm', 		index:'b.pgm_nm', 		width:'200px', 	align: 'left', 		resizable : true  },            
            { name:'tierNm', 		index:'d.tier_nm', 		width:'80px', 	align: 'center', 		resizable : true  },            
            { name:'rid', 			index:'a.rid', 			hidden : true } 
        ],
        sortname: 'a.join_date',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete',
        rowList: [5,10,15]
    };
    
    custMemGrid = $("#custMemGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	getMemberList();
});
</script>
