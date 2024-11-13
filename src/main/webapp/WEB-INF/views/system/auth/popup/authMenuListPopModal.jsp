<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var gridVal;
var menuListPopModal = null;
var progCheck = 0;

function menuListPopModal_init(){
	var jqGridOption = {
		onSelectCell : function (data) {
		},
		serializeGridData : function(data){
			data.appServiceType = ifvmUserInfo.appServiceId;
			data.menuId = $('#systemId').attr('treeid');
			data.accountId = ifvmUserInfo.accountId;
			data.progTypeCheck = progTypeCheck;
		},
		loadComplete : function(obj){			 
		},
        url : '<ifvm:action name="getAuthMenuListPop"/>',
        colNames:[
					'<spring:message code="M00763" />',
					'<spring:message code="I02045" />',
					'<spring:message code="I02046" />',
					'<spring:message code="M01901" />',
					'<spring:message code="M00185" />',
					'<spring:message code="M01900" />'
                   ],
        colModel:[
			        { name:'progNum', index: 'p.pgm_no', resizable : false},
			        { name:'progName', index: 'p.pgm_nm', resizable : false},
			        { name:'progType', index:'cc.mark_name', resizable : false },
			        { name:'progTypeCheck', hidden : true, searchable : false},
			        { name:'createDate', index:'p.create_date', resizable : false },
			        { name:'progId', index:'p.id', searchable : false}
        ],
        multiselect: true,
        sortname: 'p.create_date',
        sortorder: "desc",
        caption: '<spring:message code="I02035"/>',
        tempId: 'ifvGridOriginTemplete'
    }; 
	menuListPopModal = $("#menuListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};




  $('#addMenuListBtn').click(function(){
	
    var arrayData = new Array;
    var arrayItem;
    progCheck = 0;
    
   
    /*입력된 적용유형 */
    $(menuListPopModal.getCheckedGridData()).each(function(index, item){
    	arrayItem = new Object;
    	arrayItem.menuId =  $('#systemId').attr('treeid');
    	arrayItem.progId = item.progId;
    	arrayItem.progNum = item.progNum;
    	arrayItem.appServiceType= ifvmUserInfo.appServiceId;
    	arrayItem.accountId = ifvmUserInfo.accountId;
    	if(item.progTypeCheck == 1){
    		progCheck += 1;
    	}
    	arrayData.push(arrayItem);
    	
    	
    });    

    if(arrayData.length==0){
        alert('<spring:message code="I02051"/>');	
    }else{
    	if(progCheck > 1){
    		alert('<spring:message code="I02104"/>');
    	}
    	else if(confirm('<spring:message code="I02052"/>')){			
			 $.ifvSyncPostJSON('<ifvm:action name="addAuthMenuListProg"/>',
		 		{array : arrayData}, 
					 function(result){
		 				
		 					programListInit(currMenuId);
		 					appClose();
		             });
		 } 	
    } 
    
});
  
function appClose() {
	javascript:$.modalClose();
}


$(document).ready(function(){
	menuListPopModal_init();
	
	
});

</script>

<style>
	#menuLsitBtn{
		margin:auto;
	}

</style>



<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" >
			<button type="button" class="close" onclick="javascript:$.modalClose();">&times;</button>
   			<h4 class="modal-title"><spring:message code="I02035" /></h4>
		</div> 
		<div class="modal-body" >
			<!-- <div class="row" id="wid-id-2" data-widget-editbutton="false"> -->
			<%-- <header class="temp_title">
				<spring:message code="I02035"/>
				<div class="btn_right2">
					<button class="btn btn-sm btn_blue" onClick="javascript:$.modalClose();" data-dismiss="modal" aria-hidden="true"><spring:message code="I00404"/></button>
				</div>
			</header> --%>
			<!-- </div> -->
<!-- 			<div class="well" style="margin:0; padding:0;">
			<div class="row qt_border">
				</div>
			</div> -->
			<div class="row">
				<div id="menuListGridCon" class="con_size"></div>
			</div>
		</div>
			<center>
				<div class="qt_border" id="menuLsitBtn">
					<button class="btn btn-sm btn_gray" id="addMenuListBtn" >
						<i class="glyphicon glyphicon-check"></i>             
						<spring:message code="I02030" />
					</button>
					<button class="btn btn-sm btn_gray" id="cancelMenuListBtn" onClick="javascript:$.modalClose();">         
				        <spring:message code="I02053"/>
				    </button>
				</div>  
		    </center>
	</div>
</div>