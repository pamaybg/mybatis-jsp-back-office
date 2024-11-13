<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fieldList2;
var fid;
var fname;
function fieldList2(){
	var jqGridOption = {
			onSelectRow: function(data) {
				fid = data.code;
				fname = data.name;
			},
			url: '<ifvm:action name="getGroupCode"/>', 
		    colNames:['<spring:message code="M01181"/>',
		              '<spring:message code="M01182"/>', 
		              'id'
		              ],      
		    colModel:[
		        {name:'name',index:'group_name', resizable : false},	
		        {name:'code',index:'group_code', resizable : false},
		        {name:'id',index:'id', resizable : false, hidden : true}
		       ],
		    radio: true,
		    sortname: 'group_name',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
	fieldList2 = $("#fillterGridCon2").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	fieldList2();
	$('#selectBtn').on('click', function() {
		$("#filtercolum").text(fid);
    	$("#filtercolum").val(fid);		
    	fdPopClose();
	});
		
	$('#cancleBtn').on('click', function() {
		fdPopClose();
	});
});
</script>

<div class="pop_inner_wrap">
	<div id="fillterGridCon2" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="selectBtn">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancleBtn">         
        <spring:message code="M00284"/>
    </button> 
</div>
