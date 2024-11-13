<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>
var custSrchDateGrid;


custSrchDateList = {
	init : function(){
		custSrchDateGrid = $("#custSrchDateGrid").ifvGrid({ jqGridOption : custSrchDateList.jqGridOption });
	},
	jqGridOption : {
		serializeGridData : function( data ){
			data.columnId = 'b7cf9748178511e8a271002248051344';
			data.pagingFlag = true;
        },
        ondblClickRow : function (rowNo) {
        	
        },
        onSelectRow : function (data) {
        	
        },
        loadComplete : function(result){
        	
        },
        url: "<ifvm:action name='getCommonColumnValueList' />",
        colNames:[
					"<spring:message code='M01233' />"
                ],
       colModel:[
           			{ name:"colValue", index:"colValue", width: "200px", align: "center", resizable : false }
       ],
        sortname: '1',
        sortorder: "1",
        radio : true
	}
}

$(document).ready(function(){
	custSrchDateList.init();
});

</script>



<div class="pop_inner_wrap">
	<div id="custSrchDateGrid" class="grid_bd0 con_size"></div>
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" id=""  text="V00003" btnType="plus" btnFunc=""/>
	<ifvm:inputNew type="button" id=""  text="M00805" btnType="" btnFunc=""/>
</div>