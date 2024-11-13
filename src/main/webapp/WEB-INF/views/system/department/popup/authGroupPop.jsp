<%@page trimDirectiveWhitespaces="true" %>
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
<script>

var authGroupGrid;
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var empId = '<%= cleanXss(request.getParameter("employeeId")) %>';


//조직정보 리스트
function authGroupGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.rid = rid;
			return data;
		},
	    url: '<ifvm:action name="getAuthGroupListByRidUser"/>',
	    colNames:[
                  '<spring:message code="M01243"/>',
                  '<spring:message code="M01875"/>',
                  '<spring:message code="M00329"/>',
                  'id'
                ],
       colModel:[
			{ name:'authGroupName', 		index:'ag.aut_group_nm', 			searchable : true,		resizable : false },
			{ name:'authGroupDesc', 		index:'ag.aut_group_desc', 			searchable : true, 		resizable : false },
			{ name:'modifyDate', 			index:'ag.modify_date', 			searchable : true, 		resizable : false },
			{ name:'id', 					index:'ag.id', 						hidden : true },
       ],
       sortname: 'ag.modify_date',
       sortorder: "desc",
       radio: true,
       tempId: 'ifvGridOriginTemplete'
	};
	authGroupGrid = $("#authGroupGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	authGroupGrid();

	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	if(authGroupGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		var dataArr = authGroupGrid.getCheckedGridData();

    		$.ifvPostJSON( '<ifvm:action name="insertAuthGroupAndEmpId"/>',
        			{
    					empId : empId
    					, ridUser : rid
    					, autGroupId : dataArr[0].id
        			},
        		);
    		authGroupPopupClose();
    		authGroupList(temp.rid, temp2.id);
    	}

    });

  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	authGroupPopupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="authGroupGrid" class=""></div>
	</div>

	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn" objCode="dptEmpNewAuthGroupPopSelect_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="dptEmpNewAuthGroupPopCancel_OBJ">
	    <spring:message code="L00124"/>
	    </button>
	</div>
</div>
