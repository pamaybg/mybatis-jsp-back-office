<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>

<script type="text/javascript">
var dataAuthOwnerListPopGrid;

//추가된 직원을 제외한 전 직원 
function dataOwnerListPop() {
	var jqGridOption = {	
		serializeGridData : function(data){
			data.authGroupId = authGpId;
		},
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'dataOwnerListModal',
				contentsId : 'dataOwnerListPopCon'
			});
			new ifvm.PopupCenter({
				popupDivId : 'dataOwnerListModal'
			});
		},
        url : '<ifvm:action name="getEmpList"/>',
        colNames:[ 
                   '<spring:message code="M01249"/>',
                   '<spring:message code="M01248"/>',
                   '<spring:message code="M01250"/>',
                   'empId'
                   ],
        colModel:[
            { name:'userName', index:'e.name', resizable : false, searchable : true  },
            { name:'userId', index:'e.email', resizable : false, searchable : true  },
            { name:'dept', index:'a.name', resizable : false, searchable : true  },
  			{ name:'empId', width:55, hidden : true, searchable : false }
        ],
        sortname: 'userName',
        sortorder: "desc",
        multiselect: true,
        caption: '<spring:message code="M00196"/>',
        tempId : 'ifvGridOriginTemplete'
    }; 
	dataAuthOwnerListPopGrid = $("#dataOwnerListPop").ifvGrid({ jqGridOption : jqGridOption });
};


//권한 추가
$('#addDataOwnerListBtn').click(function(){
    //console.log(dataAuthOwnerListPopGrid.getCheckedGridData());	
    
    var arrayData = new Array;
    var arrayItem;
    
    $(dataAuthOwnerListPopGrid.getCheckedGridData()).each(function(index, item){
    	arrayItem = new Object;
    	arrayItem.authGroupId = authGpId;
    	arrayItem.memId = item.empId;
    	arrayData.push(arrayItem);
    });    
    
    if(arrayData.length==0){
    	alert('<spring:message code="M00206"/>');
    }else{
    	if(confirm('<spring:message code="M00207"/>')){			
   		 $.ifvSyncPostJSON('<ifvm:action name="addDataAuthOwnerList"/>',
   	 		{array : arrayData}, 
   				 function(result){
   	 			       /* $('#closingBtn').trigger('click'); */
   					   ownerGroupUserInit();
   					   $("#dataOwnerListModal").ejDialog('destroy');
   	             });
   	     }
    }
});    	

$(document).ready(function() {
	dataOwnerListPop();
	
	$("#cancelDataOwnerListBtn").on("click", function(){
		dataOwnerPopupClose();
	});
});

</script>
<div id="dataOwnerListPopCon">
	<div class="pop_inner_wrap">
		<div id="dataOwnerListPop" class="con_size bp0"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addDataOwnerListBtn">     
			<i class="glyphicon glyphicon-check"></i>    
			<spring:message code="M00282" />
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="cancelDataOwnerListBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>