<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>



<script>

var authList = null;

var storeId = null;

/* function authList_init(){
	if(ifvmAccountInfo.accountName != null){
		$('#orgName').val( ifvmAccountInfo.accountName);
	}
	else{
		if(ifvmUserInfo.orgName != null ) $('#orgName').val( ifvmUserInfo.orgName);
	}
	if(ifvmStoreInfo.storeName != null ) $('#accountName').val( ifvmStoreInfo.storeName );
} */

function authListSetting(){
	
	var jqGridOption = {
		ondblClickRow : function (data) {
			authDetail( authList.getRowData()[data-1].id );
		},
		serializeGridData : function( data ){
			/* data.storeId = ifvmStoreInfo.storeId; */
			return data;
		},
        url : '<ifvm:action name="getAuthList"/>',
        colNames:[ '<spring:message code="I02059" />',
                   '<spring:message code="I02060" />',
                   '<spring:message code="I00075" />',
                   '<spring:message code="I02055" />',
                   '<spring:message code="I02056" />',
                   'id'
        ],
        colModel:[
            { name:'authNo', index:'h.aut_num', resizable : false },
            { name:'authName', index:'h.aut_nm', resizable : false },
            { name:'authDesc', index:'h.aut_desc', resizable : false },
            { name:'authCreater', index:'e.name', resizable : false },
            { name:'authCreateDate', index:'h.create_date', formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}, resizable : false },
            { name:'id', index:'h.id', hidden : true },
            ],
        sortname: 'h.create_date',
        sortorder: 'desc',
        multiselect: true,
        /* rowList: $.ifvmGetSelectBoxNum() */
    };
	authList = $("#authListGrid").ifvGrid({ jqGridOption : jqGridOption });
	
	
};

function authDetail(authId){
	qtjs.href('<ifvm:url name="authDetail"/>' + '?authId=' + authId);
};


function authNew(){
	qtjs.href('<ifvm:url name="authDetail"/>');
};

function deleteAuth() {

		var checkedList = authList.getCheckedList();
		var authIdList = [];
		for( var i = 0; i < checkedList.length; i++ ){
			authIdList.push( checkedList[i].id );	
		}
		
		if(authIdList.length > 0){
			
			if( confirm('<spring:message code="I01500"/>') == true ){
			
				$.ifvSyncPostJSON('<ifvm:action name="deleteAuthList"/>',{
					authIds : authIdList,
				},
				function(result) {
					/* authList.requestData( { storeId : ifvmStoreInfo.storeId } ); */
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
	authList.requestData( { storeId : storeId } );
	
};

function showAccPop(){
	$("#accountNameModal").ifvmLoad('<ifvm:url name="accountNameModal"/>');
}

function showPop(){
	$("#storeNameModal").ifvmLoad('<ifvm:url name="storeNameModal"/>');
}
	
$(document).ready(function() {
	
	/* $.ifvmLnbSetting('authList'); */
	/* authList_init(); */
	authListSetting();
	
	/* pageSetUp(); */
	/* $("#accountNameModal").ifvmLoad('<ifvm:url name="accountNameModal"/>');
	$("#storeNameModal").ifvmLoad('<ifvm:url name="storeNameModal"/>'); */
	
	/* $.ifvmAdminCheck(true,true,true); */
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="I02026"/>
		&gt; <spring:message code="I02061"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-sm-7">
		<span><spring:message code="I02062"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" className="authCretBtn" btnFunc="authNew()" text="I00887" btnType="plus"/>
		<ifvm:inputNew type="button" className="authDelBtn" btnFunc="deleteAuth()" text="I00888" btnType="minus"/>
	</div>
</div>
<div id="authListGrid"></div>

<div id="accountNameModal"></div>
<div id="storeNameModal"></div>