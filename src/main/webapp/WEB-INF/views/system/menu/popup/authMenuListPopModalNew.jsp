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
	var ejGridOption = {
		serializeGridData : function(data){
			data.appServiceType = ifvmUserInfo.appServiceId;
			data.menuId = $('#systemId').attr('treeid');
			data.accountId = ifvmUserInfo.accountId;
			data.progTypeCheck = progTypeCheck;
		},
		dataUrl : '<ifvm:action name="getAuthMenuListPop"/>',
        columns:[
        	{
       		  field : 'progNum', headerText : '<spring:message code="M00763"/>', headerTextAlign : 'center',  customAttributes :{searchable : true,index : 'p.pgm_no'}
       	  },{
     		  field : 'progName', headerText : '<spring:message code="I02045"/>', headerTextAlign : 'center', customAttributes :{index : 'progName'}
     	  },{
     		  field : 'progType', headerText : '<spring:message code="I02046"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
     	  },{
     		  field : 'progTypeCheck', headerText : '<spring:message code="M01901"/>', visible : false , customAttributes :{searchable : true}
     	  },{
     		  field : 'createDate', headerText : '<spring:message code="M00185"/>', headerTextAlign : 'center', 
     	  },{
     		  field : 'progId', headerText : '<spring:message code="M01900"/>', headerTextAlign : 'center', 
     	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'createDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        multiselect: true,
        caption: '<spring:message code="I02035"/>',
        tempId: 'ifvGridOriginTemplete'
    }; 
	menuListPopModal = $("#menuListGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
};

  $('#addMenuListBtn').click(function(){
	
    var arrayData = new Array;
    var arrayItem;
    progCheck = 0;

    /*입력된 적용유형 */
    $(menuListPopModal.opt.gridControl.getSelectedRecords()).each(function(index, item){
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
			<div class="row">
				<div id="menuListGridCon" class="con_size"></div>
			</div>
		</div>
			<center>
				<div class="qt_border" id="menuLsitBtn">
					<button class="btn btn-sm btn_gray" id="addMenuListBtn"  objCode="addMenuListBtn_OBJ">
						<i class="glyphicon glyphicon-check"></i>             
						<spring:message code="I02030" />
					</button>
					<button class="btn btn-sm btn_gray" id="cancelMenuListBtn" onClick="javascript:$.modalClose();" objCode="cancelMenuListBtn_OBJ">         
				        <spring:message code="I02053"/>
				    </button>
				</div>  
		    </center>
	</div>
</div>