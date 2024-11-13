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
var fundOrgPopGrid; 
var offerid = '<%= cleanXss(request.getParameter("id")) %>'; 

function fundOrgPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'offerPopupCon',
				contentsId : 'fundOrgPopCon'
			});
		},
		onSelectRow : function (data) {

		},
		serializeGridData : function( data ){
			data.id = offerid
			return data; 
		},			
	    url:'<ifvm:action name="getOfferOrg"/>',
	    colNames:['<spring:message code="M00309"/>',
	              '<spring:message code="M00317"/>', 
	              '<spring:message code="M00336"/>',
	              'id'
	              ],
	    colModel:[
	        {name:'accName',index:'ac.name', resizable : false},
	        {name:'accStatus',index:'c1.MARK_NAME', resizable : false},
	        {name:'accNumber',index:'ac.account_number', resizable : false},
	        {name:'id', index:'ac.id', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio:true,
	    sortname: 'ac.account_number',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00322"/>'
	};
	fundOrgPopGrid = $("#fundOrgPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	fundOrgPopGrid();
	fundOrgPopGrid.requestData( { id : offerid } );
	//저장 클릭시
    $('#fundOrgPopSaveBtn').on('click', function(){
    	
    	if(fundOrgPopGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = fundOrgPopGrid.getCheckedGridData();
        	$("#offerFownerId").text(dataArr[0].id).val(dataArr[0].accName);
        	formNewPopClose();	
    	}
    });
	
  	//취소 클릭시
    $('#fundOrgPopCancelBtn').on('click', function(){
    	formNewPopClose();
    });
});
</script>

<div id="fundOrgPopCon">
	<div class="pop_inner_wrap">
		<div id="fundOrgPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="fundOrgPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="fundOrgPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>