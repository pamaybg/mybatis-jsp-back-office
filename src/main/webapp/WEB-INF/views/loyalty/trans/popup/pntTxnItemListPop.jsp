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
var pntTxnItemList;
var gridPntTxnItemList;
var rid=null ;

var pntTxnRid  = '<%= cleanXss(request.getParameter("rid")) %>' ;

function getPntTxnItemListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      
        },
        
        onSelectRow : function (data) {
        	
        },
     
       serializeGridData : function( data ){
      
        
        if(typeof pntTxnRid != "undefined" && pntTxnRid != "null" ){
        	data.pntTxnRid = pntTxnRid;
    	}
        
        
            return data;
        },  
        loadComplete : function(obj){
        	
        	
        	
        }, 
        url : '<ifvm:action name="getPntTxnItemList"/>',
        colNames:[ 
                   '<spring:message code="L02001" />',
                   '<spring:message code="L02002" />',
                   '<spring:message code="L02003" />',
                   
                   'rid',
                 
                 ],
        colModel:[
             { name:'prodNm',   index:'b.prod_nm',  resizable : true, align:'center',    width:'180px' ,sortable: true},
             { name:'prodQty',   index:'a.prod_qty',  resizable : true, align:'right',    width:'120px',formatter:'integer' ,sortable: true},
             { name:'prodPnt',   index:'a.prod_pnt',  resizable : true, align:'right',    width:'120px',formatter:'integer' ,sortable: true},             
             { name:'rid',    index:'lpt.rid',    hidden : true}
            
        ],
        sortname: 'a.create_date',
		sortorder: "desc",
       	rows:[9999]
    };
    pntTxnItemList = $("#pntTxnItemListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridPntTxnItemList = $("#gridPntTxnItemList");
}




//공통 조회 호출
function pntTxnItemListSearch() {

	
    $.fn.ifvmSubmitSearchCondition("PntTxnItemList", getPntTxnItemListSearch);
} 



	
	
	


$(document).ready(function() {
   
    
    pntTxnItemListSearch(); 
    
    
    
});

</script>



<div>
    
    <div id="pntTxnItemListGrid" class="white_bg grid_bd0"></div>     

</div>
