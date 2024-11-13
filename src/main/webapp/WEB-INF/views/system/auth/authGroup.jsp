<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>



<script>

var GroupList = null;

var storeId = null;


function authGroupListSetting(){
	
	var jqGridOption = {
		ondblClickRow : function (data) {
			authGroupDetail( GroupList.getRowData()[data-1].id );
		},
		serializeGridData : function( data ){
			/* data.storeId = ifvmStoreInfo.storeId; */
			return data;
		},
		loadComplete : function(data){
			
		},
        url : '<ifvm:action name="getAuthGroupList"/>',
        colNames:[ '<spring:message code="I02071" />',
                   '<spring:message code="I00075" />',
                   '<spring:message code="I02072" />',
                   '<spring:message code="I02055" />',
                   '<spring:message code="I02056" />',
                   'id'
        ],
        colModel:[
            { name:'groupName', index:'ag.aut_group_nm', resizable : false },
            { name:'groupDesc', index:'ag.aut_group_desc', resizable : false },
            { name:'groupStatus', index:'cc.mark_name', resizable : false },
            { name:'group_Creater', index:'e.name', resizable : false },
            { name:'group_Create_Date', index:'ag.create_date', resizable : false , formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} },
            { name:'id', index:'ag.id', hidden:true }
            ],
        sortname: 'ag.create_date',
        sortorder: "desc",
        multiselect: true,
        rowList: $.ifvmGetSelectBoxNum()
    };
	GroupList = $("#GroupListGrid").ifvGrid({ jqGridOption : jqGridOption });
	
	
};

function authGroupDetail(groupId){
	qtjs.href('<ifvm:url name="authGroupDetail"/>' + '?groupId=' + groupId);
};


function authNew(){
	qtjs.href('<ifvm:url name="authGroupDetail"/>');
};

function deleteAuth() {

		var checkedList = GroupList.getCheckedList();
		var groupIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			groupIdList.push( checkedList[i].id );	
		}
		
		if(groupIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
				
				$.ifvSyncPostJSON('<ifvm:action name="deleteAuthGroupList"/>',{
					groupId : groupIdList,
				},
				function(result) {
					/* GroupList.requestData( { storeId : ifvmStoreInfo.storeId } ); */
					alert('<spring:message code="I00726"/>');
				});
			}
			
		}else{
			alert('<spring:message code="I00728"/>');
		}
	
};

function storeNameModalSelected(obj){
	
	$('#accountName').val(obj.storeName);
	storeId = obj.storeId;
	GroupList.requestData( { storeId : storeId } );
	
};


	
$(document).ready(function() {
	
	$.ifvmLnbSetting('authGroup');
	$.ifvmAdminCheck();
	
	pageSetUp();
	
	authGroupListSetting();
	
	$.ifvmAdminCheck(true,true,true);
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02026"/>
		&gt; <spring:message code="I02084"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02084"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" className="authCretBtn" btnFunc="authNew()" text="I00887" btnType="plus"/>
		<ifvm:inputNew type="button" className="authDelBtn" btnFunc="deleteAuth()" text="I00888" btnType="minus"/>
	</div>
</div>
<div id="GroupListGrid"></div>

