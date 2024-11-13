<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var menuListPopGrid;

/* 조건 목록 */
function menuListPop() {
	var jqGridOption = {
	
		onSelectCell : function (data) {
			
		},
		serializeGridData : function(data){
			  data.accountId = $('#systemId').val();
			  data.menuId = $('#systemId').attr('treeid');
		},
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'menuListPopModal',
				contentsId : 'menuListPopCon'
			});
			new ifvm.PopupCenter({
				popupDivId : 'menuListPopModal'
			});
		},
        url : '<ifvm:action name="getMenuListPop"/>',
        colNames:[ 
                  '<spring:message code="M00187"/>',
                   '<spring:message code="M00179"/>',
                   '<spring:message code="M00176"/>',
                   '<spring:message code="M00180"/>',
                   'progId',
                   ],
        colModel:[
      	        {name:'applyType',index:'aa.applyType', resizable : false},
    	        {name:'progNum',index:'aa.progNum', resizable : false},	        
    	        {name:'progName',index:'aa.progName', resizable : false},
    	        {name:'progType',index:'aa.progType', resizable : false},
    	        {name:'progId', width:55, hidden : true, searchable : false}	        
   	        ],
   	    radio : true,
        sortname: 'create_date',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete',
        caption: '<spring:message code="M00177"/>'       
        
    }; 
	menuListPopGrid = $("#menuListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$('#addMenuListBtn').click(function(){
	   
    var arrayData = new Array;
    var arrayItem;
    
 /*    
 	var sendManager = false;
    var sendManagerCnt = 0;
    var sendAdmin = false;
    var sendAdminCnt = 0;
    var sendCommon = false;
 */
    var sendMKT = false; 
    var sendMKTCnt = 0;
   
    /*입력된 적용유형 */
    $(menuListPopGrid.getCheckedGridData()).each(function(index, item){
    	arrayItem = new Object;
    	arrayItem.menuId =  $('#systemId').attr('treeid');
    	arrayItem.progId = item.progId;
    	arrayItem.appServiceType= $('#systemId').val();
    	arrayData.push(arrayItem);
    	
    	/* if(item.applyType=='공통'){
    		sendCommon = true;
    	}   
    	
    	if(item.applyType=='MANAGER'){
    		sendManager = true;
    		sendManagerCnt+=1;
    	}     
    	
    	if(item.applyType=='ADMIN'){
    		sendAdmin = true;
    		sendAdminCnt+=1;
    	}      */
    	
    	if(item.applyType=='MARKETING'){
    		sendMKT = true;
    		sendMKTCnt+=1;
    	}
    	
    });    
    
/*     var receivedManager = false;
    var receivedAdmin = false;
    var commonType = false;  */
    var receivedMKT = false;
    /*추가시킬 적용 유형 */
    $(programListGrid.getRowData()).each(function(index, item){
    	//console.log(item.applyType);
    	
    	if(item.applyType=='MARKETING'){
    		receivedMKT = true;
    	}
    });
       
    
    var avoidDuplicates = false;    

    if(sendMKT && receivedMKT){
    	avoidDuplicates = true;
    }else if(sendMKTCnt >1){
    	avoidDuplicates = true;
    }
    
    //console.log(commonType);
       

    if(avoidDuplicates){
        alert('<spring:message code="M00271"/>');	
    }else if(arrayData.length==0){
        alert('<spring:message code="M00206"/>');	
    }else{
	if(confirm('<spring:message code="M00207"/>')){			
		 $.ifvSyncPostJSON('<ifvm:action name="addMenuListProg"/>',
	 		{array : arrayData}, 
				 function(result){
				        programListInit();	
				        menuPopupClose();
	             });
	 } 	
    } 
    
});

$(document).ready(function(){
	menuListPop();
/*  	$('menuSelectBtn').on('click', function() {
		//메뉴선택시 처리부분 로직 및 체크없을 경우 validation 필요
		   

	menuPopupClose();
	}); */
	
	$("#cancelMenuListBtn").on("click", function(){
		menuPopupClose();
	});
});
</script>
<div  id="menuListPopCon">
	<div class="pop_inner_wrap">	
		<div id="menuListPopGrid" class="con_size bp0"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addMenuListBtn">
			<i class="glyphicon glyphicon-check"></i>             
			<spring:message code="M00282" />
		</button>
		<button class="btn btn-sm btn_lightGray2" id="cancelMenuListBtn">         
	        <spring:message code="M00284"/>
	    </button>  
	</div>
</div>