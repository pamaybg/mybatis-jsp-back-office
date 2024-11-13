<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>
<script id="popProg" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
		{title}
		<div class="filter_area">
		<div class="left" id='searchBoxProg'>
		    {searchBox}
        </div>
		<div class="right">
			{rowsBox}
		</div>
	</div>
	<div class="grid_con">
		{grid}
	</div>
	<div class="page">
		{page}
		<div class="total_area">{total}</div>   
	</div>
</script>

<script>
var programListPopGrid;
function programListPop() {
	var jqGridOption = {
		onSelectCell : function (data) {
			
		},
		serializeGridData : function(data){
		  data.accountId = $('#systemName').val();
		  data.authGroupId = $('#authGroupName').attr('ownerGroupId');
		},
		loadComplete : function(obj){
		   
		},
        url : '<ifvm:action name="getOwnerProgListPop"/>',
        colNames:[ 
                   '<spring:message code="M00179"/>',
                   '<spring:message code="M00176"/>',
                   '<spring:message code="M00180"/>',
                   'progId'
                   ],
        colModel:[
            { name:'progNum', index:'aa.progNum', resizable : false, searchable : true },
            { name:'progName', index:'aa.progName', resizable : false, searchable : true },
            { name:'progType', index:'aa.progType', resizable : false, align:'center', formatter : typeFormat, searchable : false},
  			{ name:'progId', width:55, hidden : true, searchable : false}

        ],
        sortname: 'aa.progNum',
        sortorder: "desc",
        multiselect: true,
        tempId : 'popProg'
    }; 
	programListPopGrid = $("#programListPop").ifvGrid({ jqGridOption : jqGridOption });
};


$('#addOwnerProgListBtn').click(function(){
    var arrayData = new Array;
    var arrayItem;
    
    $(programListPopGrid.getCheckedGridData()).each(function(index, item){
    	arrayItem = new Object;
    	arrayItem.authGroupId = $('#authGroupName').attr('ownergroupid');
    	arrayItem.progId = item.progId;
    	arrayItem.appServiceType= $('#systemName').val();
    	arrayData.push(arrayItem);
    });    
    if(arrayData.length==0){
        alert('<spring:message code="M00206"/>');	
    }else{
	if(confirm('<spring:message code="M00207"/>')){			
		 $.ifvSyncPostJSON('<ifvm:action name="addOwnerProgList"/>',
	 		{array : arrayData}, 
				 function(result){
	 			       $('#progClosingBtn').trigger('click');
				       programListInit();				       
	             });
	 } 	
    }
});
</script>


<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" style="height:30px">
	   		<button id ='progClosingBtn' type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
   			<h4 class="modal-title" id="myModalLabel"></h4>
  		</div>
   		<div class="modal-body">
   			<header class="temp_title pop_tit">
				<spring:message code="M00186"/>
				<div class="btn_right2">
					<button id="addOwnerProgListBtn" class="btn btn-sm btn_gray">
					<spring:message code="M00211"/>
					</button> 
				</div>
			</header>
			<div id="programListPop" class="con_size"></div>
   		</div>
 	</div>
</div>
