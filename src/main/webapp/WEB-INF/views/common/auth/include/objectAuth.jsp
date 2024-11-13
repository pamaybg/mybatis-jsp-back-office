<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var pgmId = null;

function objectAuthPop(){
	$.ifvLoadPop({url : '<ifvm:url name="objectAuthPopup"/>', params : {authId:authId, pgmId:pgmId}, close : function(){}});
}

function objectGridList(authId, pgmId){
	
	$("#objListArea").show();
	var jqGridOption = {
			serializeGridData : function( data ){
				data.authId = authId;
				data.pgmId = pgmId;
				return data;
			},
			onSelectRow : function(data) {
				
				
			},
			loadComplete : function(data){
			},
			url : '<ifvm:action name="getAuthObjectList"/>',
	        colNames:[ '<spring:message code="I02101" />',
	                   '<spring:message code="I02099" />',
	                   '<spring:message code="I02100" />',
	                   '<spring:message code="I02102" />',
	                   '<spring:message code="I02055" />',
	                   '<spring:message code="I02056" />',
	                   'id'
	                   
	        ],
	        colModel:[
	            { name:'objNm', index:'uo.ui_obj_nm', resizable : false },
	            { name:'viewType', index:'cc.mark_name', resizable : false },
	            { name:'objType', index:'cc2.mark_name', resizable : false },
	            { name:'objDesc', index:'uo.ui_obj_desc', resizable : false },
	            { name:'createBy', index:'e.name', resizable : false },
	            { name:'createDate', index:'aor.create_date', resizable : false },
	            { name:'id', index:'aor.id', resizable : false, searchable : false, hidden : true }
	        ],
	        sortname: 'aor.create_date',
	        sortorder: "desc",
	        radio : true,
	        rowList: $.ifvmGetSelectBoxNum(),
	    };
		objectListCon = $("#objectAddListCon").ifvGrid({ jqGridOption : jqGridOption });
	
}

function deleteObjectAuth(){
	
	var checkedList = objectListCon.getCheckedList();
	var delIdList = [];
	
	if(checkedList.length == 0){
		alert('<spring:message code="I02051"/>');
	}
	else{
		for( var i = 0; i < checkedList.length; i++ ){
			delIdList.push( checkedList[i].id );	
		}
		if( confirm('<spring:message code="I01500"/>') == true ){

			$.ifvSyncPostJSON('<ifvm:action name="deleteAuthObjRel"/>',{
				objRelIdList : delIdList,
			},
			function(result) {
				objectListCon.requestData( { authId : authId, pgmId : pgmId } );
				alert('<spring:message code="I00726"/>');
			});
		}
	} 
	
}

function programListInit(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			data.authId = authId;
			return data;
		},
		onSelectRow : function(data) {
			
			pgmId = data.id;
			objectGridList(authId, data.id);
		},
		loadComplete : function(data){
		},
		url : '<ifvm:action name="getProgList"/>',
        colNames:[ '<spring:message code="I02044" />',
                   '<spring:message code="I02045" />',
                   '<spring:message code="I02046" />',
                   '<spring:message code="I02047" />',
                   '<spring:message code="I02055" />',
                   '<spring:message code="I02056" />',
                   'id'
                   
        ],
        colModel:[
            { name:'progId', index:'p.pgm_no', resizable : false },
            { name:'progName', index:'p.pgm_nm', resizable : false },
            { name:'progType', index:'cc.mark_name', resizable : false },
            { name:'progPath', index:'p.pgm_path', resizable : false },
            { name:'prog_crea', index:'e.name', resizable : false },
            { name:'createDate', index:'p.create_date', resizable : false },
            { name:'id', index:'p.id', resizable : false, searchable : false, hidden : true }
        ],
        sortname: 'p.create_date',
        sortorder: "desc",
        radio : true,
        rowList: $.ifvmGetSelectBoxNum(),
    };
	groupListCon = $("#programAddListCon").ifvGrid({ jqGridOption : jqGridOption });
};

$(document).ready(function() {
	
	$("#objListArea").hide();
	
	programListInit();
	
	$("#objectNewAuthBtn").click(function(){
		objectAuthPop();
	});
	
	$("#objectDelAuthBtn").click(function(){
		deleteObjectAuth();
	});
	
	
	
});


</script>
 
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="I02098" /></span>
	</div>
</div>


<div id="programAddListCon"></div>

<div class="page_btn_area" id="objListArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="I02087" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
		<%-- <ifvm:inputNew type="button" className="dataSaveBtn" id="dataNewAuthBtn" btnFunc="dataAuthPop()" text="I00887" btnType="plus"/>
		<ifvm:inputNew type="button" className="dataDelBtn" id="dataDelAuthBtn" btnFunc="deleteAuth()" text="I00888" btnType="minus"/> --%>
		<ifvm:inputNew type="button" className="dataSaveBtn" id="objectNewAuthBtn"  text="I00887" btnType="plus"/>
		<ifvm:inputNew type="button" className="dataDelBtn" id="objectDelAuthBtn"  text="I00888" btnType="minus"/>
	</div> 
	
</div>
<div id="objectAddListCon"></div>
<!-- <div id="objectAddListModal"></div> -->
