<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var gridVal;
var storeAddListModal = null;
var storeSelectedList = new Array;
var storeList = new Array;
var storeData = new Object;
var gridRecord = 0;
var check = true;
var totalPage = 0;
var selectList = new Array;
var page;

function objectTypeCommonCode(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'UI_VIEW_CD'
	},function(result){
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#objectTypeWrap").append(temp);
	});
};


function storeAddListModalModalInit(){
	var jqGridOption = {
		onSelectRow : function(data) {
			
			$("#menuLsitBtn").show();
			/* for(var i=0; i<gridRecord; i++){
				if(storeSelectedList[i] != null && storeSelectedList[i] != "null"){
					if(storeSelectedList[i].id != data.id){
						check = true
					}
					else{
						//storeSelectedList.remove(storeSelectedList.indexOf(storeSelectedList[i]))
						storeSelectedList.remove(i)
						check = false
						break;
					}
				}
			}
			if(check){
				storeData = data;
				storeData.page = data.page;
				storeSelectedList.push(storeData);
				
			} */
		},
		/* onSelectAll : function(data) {
			
			
			if(storeAddListModal.getCheckedGridData().length > 0){
				
				if(storeSelectedList.length > 0){
					for(i=0; i<storeAddListModal.getCheckedGridData().length; i++){
						for(j=0; j<storeSelectedList.length; j++){
							
							if(storeAddListModal.getCheckedGridData()[i].id != storeSelectedList[j].id){
								check = true;
							}
							else{
								if(storeSelectedList[j].page == page){
									
									check = false;
									break;
								}
								else{
									check=true;
									break;
								}
							}
						}
						
						if(check){
							if($.inArray(storeList[i], storeSelectedList) < 0){
								storeList[i].page = page;
								storeSelectedList.push(storeList[i]);
							}
						}
						else{
							if($.inArray(storeList[i], storeSelectedList) > 0){
								storeSelectedList.remove(storeSelectedList.indexOf(storeList[i]))
							}
						} 
					}
				}
				else
				{
					for(i=0; i<storeList.length; i++){
						storeList[i].page = page;
						storeSelectedList.push(storeList[i])
					}
				}
			}
			else{
				
				if(storeSelectedList.length > 0){
					for(var j=0; j<storeSelectedList.length; j++){
						
						for(var i=0; i<storeList.length; i++){
						
							if(storeSelectedList[j].id == storeList[i].id)
								storeSelectedList.remove(j);
						
						}
					}
				}
			}
		}, */
		loadComplete : function(data){
			
			/* storeList = data.rows;
			gridRecord = data.records;
			totalPage = (data.records / data.rows.length);
			
			for(var i=0; i<gridRecord; i++){
				if(storeSelectedList[i] != null && storeSelectedList[i] != "null"){
					//if(empSelectedList[i].page == data.page){
						for(var j=0; j<storeList.length; j++){
							if(storeSelectedList[i].id == storeList[j].id){
								selectList.push(j+1);
							}
						}
					//}
				}
			}
			storeAddListModal.setCheckRow(selectList);
			selectList = []; */
			
		},
		serializeGridData : function(data){
			data.accountId = ifvmUserInfo.accountId;
			data.authId = authId;
			data.pgmId = pgmId;
		},
 
		
		url : '<ifvm:action name="getAuthObjectListPop"/>',
        colNames:[ '<spring:message code="I02101" />',
                   /* '<spring:message code="I02099" />', */
                   '<spring:message code="I02100" />',
                   '<spring:message code="I02102" />',
                   /* '<spring:message code="I02055" />',
                   '<spring:message code="I02056" />', */
                   'id'
                   
        ],
        colModel:[
            { name:'objNm', index:'uo.ui_obj_nm', resizable : false },
            /* { name:'viewType', index:'cc.mark_name', resizable : false }, */
            { name:'objType', index:'cc2.mark_name', resizable : false },
            { name:'objDesc', index:'uo.ui_obj_desc', resizable : false },
            /* { name:'createBy', index:'e.name', resizable : false },
            { name:'createDate', index:'aor.create_date', resizable : false }, */
            { name:'id', index:'aor.id', resizable : false, searchable : false, hidden : true }
        ],
        sortname: 'uo.create_date',
        sortorder: "desc",
        radio: true,
        rowList: $.ifvmGetSelectBoxNum(),
        caption: '<spring:message code="I02087"/>' 
    }; 		
	storeAddListModal = $("#objectListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};


$('#addMenuListBtn').click(function(){
	
	var saveObj = new Object;
	saveObj.objId = storeAddListModal.getCheckedGridData()[0].id;
	saveObj.authId = authId;
	saveObj.pgmId = pgmId;
	saveObj.viewType = $("#objectTypeWrap").val();
	
	

	if(authId != null && authId != ''){
		
		
		if(confirm('<spring:message code="I02052"/>')){			
			 $.ifvSyncPostJSON('<ifvm:action name="setAuthObjRel"/>',saveObj,
			 function(result){
 				
				objectGridList(authId, pgmId);
 				appClose();
             });
		 }
		else{
			return false;
		}
		
	}
	else{
		alert('<spring:message code="I02103"/>');		
	}
    
    
});

 
  
function appClose() {
	javascript:$.modalClose();
}


$(document).ready(function(){
	
	
	$("#menuLsitBtn").hide();
	objectTypeCommonCode();
	storeAddListModalModalInit();
	
	 /* $('#addMenuListBtn').click(function(){
		  
		  
			var saveObj = new Object;
			
			saveObj.objId = storeAddListModal.getCheckedGridData()[0].id;
			saveObj.authId = authId;
			saveObj.pgmId = pgmId;
			saveObj.viewType = $("#objectTypeWrap").val();

			if(authId != null && authId != ''){
				
				
				if(confirm('<spring:message code="I02052"/>')){			
					 $.ifvSyncPostJSON('<ifvm:action name="setAuthObjRel"/>',saveObj, 
						 function(result){
						 	objectGridList(authId, pgmId);
			 				
		             });
				 }
				
			}
			else{
				alert('<spring:message code="I02103"/>');		
			}
		    
		    
		}); */
	 
	 
});

</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" >
			<button type="button" class="close" onclick="javascript:$.modalClose();">&times;</button>
   			<h4 class="modal-title"><spring:message code="I02087" /></h4>
		</div> 
		<div class="modal-body" >
			<div class="row">
				<div id="objectListGridCon" class="con_size"></div>
			</div>
		</div>
			<center>
				<div id="menuLsitBtn" class="row qt_border">
				
					<div class="form-horizontal">
						<ifvm:inputNew type="select" id="objectTypeWrap" required="true" label="I02099" labelClass="4" conClass="3"/>
						
						<div class="control_content col-xs-2">
							<button class="btn btn-sm btn_gray" id="addMenuListBtn" >
							<i class="glyphicon glyphicon-check"></i>             
							<spring:message code="I02030" />
						</button>
						</div>
					</div>
					
					
				
					<%-- <ifvm:inputNew type="select" id="objectTypeWrap" required="true" label="I02099" labelClass="3" conClass="3"/>
					<button class="btn btn-sm btn_gray" id="addMenuListBtn" >
						<i class="glyphicon glyphicon-check"></i>             
						<spring:message code="I02030" />
					</button> --%>
				</div>
		    </center>
	</div>
</div>