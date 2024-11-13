<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var popSelectlId;

function deleteAuth(){
	
	var checkedList = groupListCon.getCheckedList();
	var delIdList = [];
	
	if(checkedList.length == 0){
		alert('<spring:message code="I02051"/>');
	}
	else{
		for( var i = 0; i < checkedList.length; i++ ){
			delIdList.push( checkedList[i].id );	
		}
		if( confirm('<spring:message code="I01500"/>') == true ){

			$.ifvSyncPostJSON('<ifvm:action name="deleteDivisionList"/>',{
				delIdList : delIdList,
			},
			function(result) {
				groupListCon.requestData( { authId : authId } );
				alert('<spring:message code="I00726"/>');
			});
		}
	}
	
}

function popupClose(){
	$('#divisionModal').ejDialog('destroy');
}

function divisionAddListInit(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			data.authId = authId;
			return data;
		},
		loadComplete : function(data){
		},
        url : '<ifvm:action name="getAuthGroupDivisionList"/>',
        colNames:[ '<spring:message code="M00555"/>',
                   '<spring:message code="L00478"/>',
                   '<spring:message code="I02055"/>',
                   '<spring:message code="I02056"/>',
                   'id'
                  ],
        colModel:[
            { name:'accName', index:'acc.name'},
            { name:'accType', index:'cc.mark_name', resizable : false },
            { name:'accCreater', index:'e.name' },
            { name:'accCreateDate', index:'adr.create_date', formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}, resizable : false },
            { name:'id', index:'adr.id', hidden : true, resizable : false }
        ],
        sortname: 'adr.create_date',
        sortorder: "desc",
        multiselect: true
    };
	groupListCon = $("#divisionAddListCon").ifvGrid({ jqGridOption : jqGridOption });
};

$(document).ready(function() {
	divisionAddListInit();
	
	$("#dataNewAuthBtn").click(function(){
		$.fn.ifvmPopupOpen('divisionModal', '', '<ifvm:url name="dataAuthPopup"/>', '',860);	
	});
	
	$("#dataDelAuthBtn").click(function(){
		deleteAuth();
	});
	
	
	
});


</script>
 
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="I02097" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" className="dataSaveBtn" id="dataNewAuthBtn"  text="I00887" btnType="plus"/>
		<ifvm:inputNew type="button" className="dataDelBtn" id="dataDelAuthBtn"  text="I00888" btnType="minus"/>
	</div> 
	
</div>


<div id="divisionAddListCon"></div>
<div id="divisionModal" class="popup_container"></div>
