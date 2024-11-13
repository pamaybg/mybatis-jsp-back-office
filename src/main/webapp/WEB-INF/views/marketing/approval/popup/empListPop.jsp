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
var empListPopGrid; 
var reqarvrId;
var reqOrgId;

//변수 초기화
function emptyfunction(){
	reqarvrId = null;
	reqOrgId = null;
	
}

//popup 높이 맞추기
function initPopupHeight() {
  setTimeout(function() {
      try {
          new ifvm.PopupHeight({
              popupDivId : 'FormNewPop',
              contentsId : 'empPopupCon'
          });
          cDialog.refresh();
      }
      catch(e) {
      }
  }, 500);
}

function initEmpListPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
// 			new ifvm.PopupHeight({
// 				popupDivId : 'FormNewPop',
// 				contentsId : 'FormNewPop'
// 			});
			initPopupHeight();
		},
		onSelectRow : function (data) {
			emptyfunction();
			reqarvrId = data.id;
			reqOrgId = data.acId;
			rename = data.empNm;
			reaccNM = data.accNm;	
		},
		serializeGridData : function( data ){
			data.id = apId;
			data.empId = empIdList;
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
	empListPopGrid = $("#empListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function setGridData(text){	
	var valText = '<spring:message code="M00972"/>'; 
	var dataStore = new Object();
	approverListGrid.removeAll();
	
	if(text != "new"){
		var dataStore2 = new Object();
		var size = dataArray.length-1;
		dataStore2.apprvType = '<spring:message code="M00949"/>';
		dataStore2.seq = dataArray[size].seq;
		dataStore2.apprvName = dataArray[size].apprvName;
		dataStore2.apprvDept = dataArray[size].apprvDept;
		dataStore2.elApproveStatus = dataArray[size].elApproveStatus;
		dataStore2.apvDd = dataArray[size].apvDd;
		dataStore2.id = dataArray[size].id; 
		dataStore2.reqarvrId = dataArray[size].reqarvrId;
		dataStore2.reqOrgId = dataArray[size].reqOrgId;
		dataArray.pop();
		dataArray.push(dataStore2);
	}
	dataStore.apprvType = valText;
	dataStore.seq = dataArray.length+1;
	dataStore.apprvName = rename;
	dataStore.apprvDept = reaccNM;
	dataStore.elApproveStatus = '';
	dataStore.apvDd = '';
	dataStore.id = count; 
	dataStore.reqarvrId = reqarvrId;
	dataStore.reqOrgId = reqOrgId;
	dataArray.push(dataStore);
	count++;
	setReGrid();
	
	getTotal();
}

$(document).ready(function(){
	getempIdList();
	initEmpListPopGrid();
	
	//저장 클릭시
    $('#empListPopSaveBtn').on('click', function(){
    	addChk = true;
    	if(empListPopGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var size = dataArray.length;
    		if (size < 5) {
	    		var dataArr = empListPopGrid.getCheckedGridData();
	    		
				var text;
			  	if (dataArray.length > 0) {
			  		text = "not new"
			  		setGridData(text)
			  	} else {
			  		text = "new"
			  		setGridData(text)
			  	}

		        //popup 높이 맞추기
		        initPopupHeight();
    		}
    		else {
    			alert('<spring:message code="M00993"/>');
    		}
    		FormNewPopClose();
        }
    });
	
  	//취소 클릭시
    $('#empListPopCancelBtn').on('click', function() {
    	FormNewPopClose();
    });
});
</script>

<div id="empPopupCon">
	<div class="pop_inner_wrap">
		<div id="empListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="empListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="empListPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>