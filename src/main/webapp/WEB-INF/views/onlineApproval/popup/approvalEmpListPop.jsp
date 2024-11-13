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
<script>

var apId = '<%= cleanXss(request.getParameter("id")) %>'; 

var approvalEmpGrid; 
var approvalEmpGridDiv;

function initApprovalEmpGrid() {
    
    var jqGridOption = {
        loadComplete : function(obj) {
            new ifvm.PopupHeight({
                popupDivId : 'FormNewPop',
                contentsId : 'FormNewPop'
            });
        },
        onSelectRow : function(data) {
            reqarvrId = data.id;
            reqOrgId = data.acId;
            rename = data.empNm;
            reaccNM = data.accNm;
        },
        serializeGridData : function(data) {
            data.id = apId;
            data.empId = refempIdList;
            return data;
        },
        url:'<ifvm:action name="getApproverList"/>',
        colNames:[
            '<spring:message code="M00983"/>',
            '<spring:message code="M00984"/>', 
            '<spring:message code="M00985"/>', 
            '<spring:message code="M00986"/>', 
            'acId',
            'id',
            'paraccId'
        ],
        colModel:[
            {name:'empNm',    index:'em.name',  resizable : false},   
            {name:'email',    index:'em.email', resizable : false},
            {name:'accNm',    index:'ac1.name', resizable : false},
            {name:'paraccNM', index:'ac2.name', resizable : false},
            {name:'acId',     index:'ac1.id',   resizable : false,  hidden : true,  searchable : false},
            {name:'id',       index:'em.id',    resizable : false,  hidden : true,  searchable : false},
            {name:'paraccId', index:'ac2.id',   resizable : false,  hidden : true,  searchable : false}  
        ],
        radio : true,
        sortname : 'ac1.account_number',
        sortorder : "desc",
        caption : '<spring:message code="M00981"/>',
        tempId : 'ifvGridOriginTemplete',
        close : 'FormNewPopClose'
    };

	approvalEmpGrid = $("#approvalEmpGridDiv").ifvGrid({ jqGridOption : jqGridOption }); 
}

function FormNewPopClose() {
	empRefPopupCon._destroy();
}

$(document).ready(function() {
    
    initApprovalEmpGrid();
    $('#empRefPopupCon_closebutton').on('click', function(){
    	empRefPopupCon._destroy();
    }); 
	//저장 클릭시
    $('#approvalEmpPopSaveBtn').on('click', function() {
        selectApprovalEmp();
    });
	
  	//취소 클릭시
    $('#approvalEmpPopCancelBtn').on('click', function() {
    	FormNewPopClose();
    });
});
</script>

<div id="empRefPopupCon">
	<div class="pop_inner_wrap">
		<div id="approvalEmpGridDiv" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="approvalEmpPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="approvalEmpPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>