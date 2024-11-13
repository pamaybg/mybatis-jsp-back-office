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
var apId = '<%= cleanXss(request.getParameter("id")) %>'; 
var empRefListPopGrid; 
var reqarvrId;
var reqOrgId;

function setRefGridData(){	
	var valText = '<spring:message code="M00972"/>'; 
	var dataStore = new Object();
	var lengthSize = dataRefArray.length+1;
	referrersListGrid.removeAll();

	dataStore.seq = "10" + lengthSize
	dataStore.apprvName = rename;
	dataStore.apprvDept = reaccNM;
	dataStore.id = count; 
	dataStore.reqarvrId = reqarvrId;
	dataStore.reqOrgId = reqOrgId;
	dataRefArray.push(dataStore);
	count++;
	setReRefGrid();

	getTotal();
}


function empRefListPopGrid(){
	
	
	
	 var jqGridOption = {
			loadComplete : function(obj){
				//popup 높이 맞추기
				 new ifvm.PopupHeight({
					 popupDivId : 'FormNewPop',
					 contentsId : 'FormNewPop'
				}); 
			},
			onSelectRow : function (data) {
				reqarvrId = data.id;
				reqOrgId = data.acId;
				rename = data.empNm;
				reaccNM = data.accNm;
			},
			serializeGridData : function( data ){
				data.id = apId;
				data.empId = refempIdList;
				return data;
			},
			url:'<ifvm:action name="getApproverList"/>',
		    colNames:['<spring:message code="M00983"/>',
		              '<spring:message code="M00984"/>', 
		              '<spring:message code="M00985"/>', 
		              '<spring:message code="M00986"/>', 
		              'acId',
		              'id'
		              ],
		    colModel:[
		        {name:'empNm',    index:'em.name',    resizable : false},   
		        {name:'email',    index:'em.email',   resizable : false},
		        {name:'accNm',    index:'di1.div_nm', resizable : false},
		        {name:'paraccNM', index:'di2.div_nm', resizable : false},
		        {name:'acId',     index:'di1.rid',    resizable : false,  hidden : true,  searchable : false},
		        {name:'id',       index:'em.id',      resizable : false,  hidden : true,  searchable : false}	
		    ],    
		    radio :true,
		    sortname: 'em.id',
			sortorder: "desc",
			caption: '<spring:message code="M00981"/>',
			tempId : 'ifvGridOriginTemplete'
		};
	empRefListPopGrid = $("#empRefListPopGrid").ifvGrid({ jqGridOption : jqGridOption }); 
		
	//해당 그리드에 필터가 검색 박스가 나오지 않아서 위의 새로운 그리드 생성	
	 /* var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			 new ifvm.PopupHeight({
				popupDivId : 'empRefPopupCon',
				contentsId : 'empRefPopupCon'
			}); 
		},
		onSelectRow : function (data) {
			reqarvrId = data.id;
			reqOrgId = data.acId;
			rename = data.empNm
			reaccNM = data.accNm	
		},
		serializeGridData : function( data ){
			data.id = apId;
			data.empId = refempIdList;
			return data;
		},
	    url:'<ifvm:action name="getApproverList"/>',
	    colNames:['<spring:message code="M00983"/>',
	              '<spring:message code="M00984"/>', 
	              '<spring:message code="M00985"/>', 
	              '<spring:message code="M00986"/>', 
	              'acId',
	              'id'
	              ],
	    colModel:[
	        {name:'empNm',index:'em.name', resizable : false},   
	        {name:'email',index:'em.email', resizable : false},
	        {name:'accNm',index:'ac1.name', resizable : false},
	        {name:'paraccNM',index:'ac2.name', resizable : false},
	        {name:'acId', index:'ac1.id', resizable : false,  hidden : true,  searchable : false},
	        {name:'id', index:'em.id', resizable : false,  hidden : true,  searchable : false}	
	    ],    
	    radio :true,
	    sortname: '',
		sortorder: "desc",
		caption: '<spring:message code="M00982"/>',
		tempRefId : 'ifvGridOriginTempReflete'
	};
	empRefListPopGrid = $("#empRefListPopGrid").ifvGrid({ jqGridOption : jqGridOption });  */
}

$(document).ready(function(){
	empRefListPopGrid();
	
	//저장 클릭시
    $('#empRefListPopSaveBtn').on('click', function(){
    	addChk = true;
    	if(empRefListPopGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>'); 
    	}else {
    		var size = dataRefArray.length;
    		
    		if(size < 5){
	    		var dataArr = empRefListPopGrid.getCheckedGridData();
			  	setRefGridData();
    		}
    		else{
    			alert('<spring:message code="M00993"/>');  
    		}
    		FormNewPopClose();	
    	}
    });
	
  	//취소 클릭시
    $('#empRefListPopCancelBtn').on('click', function(){
    	FormNewPopClose();
    });
});
</script>

<div id="empRefPopupCon">
	<div class="pop_inner_wrap">
		<div id="empRefListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="empRefListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="empRefListPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>