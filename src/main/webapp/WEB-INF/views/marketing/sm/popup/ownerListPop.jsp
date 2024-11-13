<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script type="text/javascript">
var ownerListPopGrid;

function ownerListPop() {
	var jqGridOption = {
		onSelectCell : function (data) {
			
		},
		serializeGridData : function(data){
		  data.appServiceType = $('#systemId').val();
		  data.authGroupId = $('#authGroupName').attr('ownerGroupId');
		},
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'ownerListModal',
				contentsId : 'ownerListPopCon'
			});
			new ifvm.PopupCenter({
				popupDivId : 'ownerListModal'
			});
		},
        url : '<ifvm:action name="getOwnerListPop"/>',
        colNames:[ 
                   '<spring:message code="M00194"/>',
                   '<spring:message code="M00193"/>',
                   'employId'
                   ],
        colModel:[
            { name:'employName', index:'e.name', resizable : false, searchable : true  },
            { name:'employEmail', index:'e.email', resizable : false, searchable : true  },
  			{ name:'employId', width:55, hidden : true, searchable : false }
        ],
        sortname: 'e.id',
        sortorder: "desc",
        multiselect: true,
        caption: '<spring:message code="M00196"/>',
        tempId : 'ifvGridOriginTemplete'
    }; 
	ownerListPopGrid = $("#ownerListPop").ifvGrid({ jqGridOption : jqGridOption });
};

$('#addOwnerListBtn').click(function(){
    //console.log(ownerListPopGrid.getCheckedGridData());	
    
    var arrayData = new Array;
    var arrayItem;
    
    $(ownerListPopGrid.getCheckedGridData()).each(function(index, item){
    	arrayItem = new Object;
    	arrayItem.authGroupId = $('#authGroupName').attr('ownergroupid');
    	arrayItem.memId = item.employId;
    	arrayItem.appServiceType= $('#systemId').val();
    	arrayData.push(arrayItem);
    });    
    
    if(arrayData.length==0){
    	alert('<spring:message code="M00206"/>');
    }else{
    	if(confirm('<spring:message code="M00207"/>')){			
   		 $.ifvSyncPostJSON('<ifvm:action name="addOwnerList"/>',
   	 		{array : arrayData}, 
   				 function(result){
   	 			       /* $('#closingBtn').trigger('click'); */
   					   ownerListInit();
   					   $("#ownerListModal").ejDialog('destroy');
   	             });
   	     }
    }
});    	

$(document).ready(function() {
	ownerListPop();
	
	$("#cancelOwnerListBtn").on("click", function(){
		ownerPopupClose();
	});
});

</script>
<div id="ownerListPopCon">
	<div class="pop_inner_wrap">
		<div id="ownerListPop" class="con_size bp0"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addOwnerListBtn">     
			<i class="glyphicon glyphicon-check"></i>    
			<spring:message code="M00282" />
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="cancelOwnerListBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>