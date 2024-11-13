<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.ui-jqgrid tr.ui-row-ltr td input{
 margin-left : -4px;
}

.btn_wrap {diplay : block; float:right;}

#hideFile{display:none;}
</style>

<script>

var jqTable; 			//화면권한그룹 목록
var dataAuthGridList;	//데이터권한그룹 목록

function init(){
	//검색어
	$('#authGroupSearchBtn').click(function(){
		jqGridTable();
		dataAuthGrid();
	});
	
	//신규
	$('#addAuthGroupBtn').click(function(){
		qtjs.href('${pageContext.request.contextPath}/marketing/manage/ownerGroupDetail';  );
		
	});
	//신규
	$('#addDataAuthGroupBtn').click(function(){
		qtjs.href('${pageContext.request.contextPath}/marketing/manage/ownerGroupDetail';  );
		
	});
		
	$("#authGroupSearch").keyup(function(event){
	    if(event.keyCode == 13){
			jqGridTable();					
	    }
	});
	//삭제
	$('#delAuthGroupBtn').click(function(){
		//console.log(jqTable.getCheckedGridData());
		 if($(jqTable.getCheckedGridData()).length==0){
			   alert('<spring:message code="M00206"/>');
		   }else{
			   if(confirm('<spring:message code="M00208"/>')){
					var sendDataArray = new Array;
					var sendData = null;
			        $(jqTable.getCheckedGridData()).each(function(index, item){
			    	    sendData = new Object;
			        	sendData.systemId = $('#systemName').val();
			        	sendData.id =  item.id; 
			        	sendDataArray.push(sendData);
			        });		 
					 
				 	 $.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/delAuthGroup.do',
				 			 {
				 		     //systemId : $('#systemName').val(),
				 		     array : sendDataArray}, 
							 function(result){
							       jqGridTable();	
				             });
				}
		   }
	});
	//삭제
	$('#delDataAuthGroupBtn').click(function(){
		//console.log(jqTable.getCheckedGridData());
		 if($(dataAuthGridList.getCheckedGridData()).length==0){
			   alert('<spring:message code="M00206"/>');
		   }else{
			   if(confirm('<spring:message code="M00208"/>')){
					var sendDataArray = new Array;
					var sendData = null;
			        $(dataAuthGridList.getCheckedGridData()).each(function(index, item){
			    	    sendData = new Object;
			        	sendData.systemId = $('#systemName').val();
			        	sendData.id =  item.id; 
			        	sendDataArray.push(sendData);
			        });		 
					 
				 	 $.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/delAuthGroup.do',
				 			 {
				 		     //systemId : $('#systemName').val(),
				 		     array : sendDataArray}, 
							 function(result){
				 		    	 dataAuthGrid();	
				             });
				}
		   }
	});	
	
}


/* function groupTypeSelect(select){
	 $.ifvSyncPostJSON('<ifvm:action name="getAuthGroupType"/>',
			 {},	 
			 function(result){
					 $('#groupType').append($('<option/>').text('<spring:message code="M00172"/>').val(""));
			      	 //
			    	 $(result.rows).each(function(index, item){	 
			    		 //console.log(item);
			    		 $(select).append($('<option/>').text(item.markName)
			    				  .val(item.commId));
			    	 });
			    	
            
	});
}
 */

function systemSelect(select){	
	 //groupTypeSelect($('#groupType'));
	 $.ifvSyncPostJSON('<ifvm:action name="getSystem"/>',
	 {id:'SYS_SELECT'}, 
	 function(result){

	      	 //
	    	 $(result.rows).each(function(index, item){	 
	    		 //console.log(item);
	    		 
	    		 select.append($('<option/>').text(item.and_app_name)
	    				  .val(item.id));	 
	    	 });
	    	 
	    	var chkSession = $.ifvmGetUserInfo().appServiceId;
	    	 
	    	if(chkSession!='null' || chkSession!=null ) 
                   select.val(chkSession);
	    		 
	 });
	 

}

var jqTable_FirstLoad =false;
function jqGridTable(){
	/* var id2 = $("#groupType option:selected").val(); */
	var jqGridOption = {
			ondblClickRow : function (row) {
				//console.log(data);
				qtjs.href('<ifvm:url name="ownerGroupUpdate"/>?id='+jqTable.getRowData()[row-1].id);
			},
			serializeGridData : function( data ){
				//data.id = $('#systemName').val();
				//data.appServiceType = $('#systemName').val();
				data.authGroupName = $('#authGroupSearch').val();
				data.authGroupType = $('#groupType option:selected').attr('value');
				return data;			
			},			
			loadComplete : function(obj){
				
	/*             if(jqTable_FirstLoad){
	                //console.log($(programGrid.getRowData()).length);
	                if($(jqTable.getRowData()).length==0)
	                	alert('<spring:message code="M00206"/>'); 	
	            }

	            jqTable_FirstLoad = true; */
			},
		    url:'<ifvm:action name="getAuthGroup"/>',
		    colNames:[
		              '<spring:message code="M00587"/>',
 		              '<spring:message code="M00192"/>',
		              '<spring:message code="M00190"/>', 
		              '<spring:message code="M00181"/>', 
		              '<spring:message code="M00221"/>', 
		           	  '<spring:message code="M00222"/>',
		              'id' 
		              ],
		    colModel:[
		        {name:'authGroupType', index:'c1.mark_name' , resizable : false, searchable : true},
 		        {name:'authId', index: 'ag.auth_num', align :'center' ,searchable : true},
		        {name:'authGroupName',index:'ag.auth_group_name' , searchable : true},
		        {name:'flag',index:'ag.flag', align:'center', formatter: 'checkbox', editoptions: { value:"1:0"}, searchable : false},
 		        {name:'createBy',index:'c2.name', searchable : true},     
 		        {name:'createDate',index:'ag.create_date', formatter:dateFormat, align: 'center',searchable : true },    
			    {name:'id', width:55, hidden : true, align: 'center', searchable : false} 

		    ],
		    autowidth:true,
		    sortname: 'c1.mark_name',
		    rowList: $.ifvmGetSelectBoxNum(),
	        multiselect: true,       
			sortorder: "desc",
		    tempId : 'ifvGridOriginTemplete'
		};
	   
	    jqTable = $("#ownerGroupListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/* var id2 = $("#groupType option:selected").val(); */

function dataAuthGrid(){
	
	var jqGridOption = {
			ondblClickRow : function (data) {
				//console.log(data);
				qtjs.href('<ifvm:url name="ownerGroupUpdate"/>?id='+dataAuthGridList.getRowData()[data-1].id);
			},	
			serializeGridData : function( data ){
				data.authGroupName = $('#authGroupSearch').val();
				data.type = $('#groupType option:selected').attr('value'); 
 	
				return data;			
			},			
			loadComplete : function(obj){
				
	/*             if(jqTable_FirstLoad){
	                //console.log($(programGrid.getRowData()).length);
	                if($(jqTable.getRowData()).length==0)
	                	alert('<spring:message code="M00206"/>'); 	
	            }
 *//* 
	            jqTable_FirstLoad = true; */
			},
		    url:'<ifvm:action name="getDataAuthGroup"/>',
		    colNames:[
		              '<spring:message code="M00587"/>' ,
 		              '<spring:message code="M00192"/>',
		              '<spring:message code="M00190"/>',
		              '<spring:message code="M01244"/>', 
		              '<spring:message code="M01245"/>', 
		              '<spring:message code="M01246"/>', 
		              '<spring:message code="M01247"/>', 
		              '<spring:message code="M00221"/>', 
		           	  '<spring:message code="M00222"/>',
		              'id'  
		              ],
		    colModel:[
		        {name:'authGroupTypeName', index:'c3.mark_name' , resizable : false, searchable : true} ,
 		        {name:'authNum', index: 'ag.auth_num', align :'center' ,searchable : true},
		        {name:'authGroupName',index:'ag.auth_group_name' , searchable : true},
		        {name:'dataGroupType',index:'c1.mark_name' ,align :'center' , searchable : true},
		        {name:'baseDept',index:'a1.name' ,align :'center' , searchable : true},
		        {name:'deptLevel',index:'c2.mark_name' ,align :'center' , searchable : true},
		        {name:'flag',index:'ag.flag', align:'center', formatter: 'checkbox', editoptions: { value:"1:0"}, searchable : false},
 		        {name:'createBy',index:'e1.name', searchable : true},     
 		        {name:'createDate',index:'ag.create_date', formatter:dateFormat, align: 'center',searchable : true },    
			    {name:'id', width:55, hidden : true, align: 'center', searchable : false} 
 
	  		],
		    autowidth:true,
		    sortname:  'ag.auth_num',
		    rowList: $.ifvmGetSelectBoxNum(),
	        multiselect: true,       
			sortorder: "desc",
		    tempId : 'ifvGridOriginTemplete'
		};
	   
		dataAuthGridList = $("#dataAuthGrid").ifvGrid({ jqGridOption : jqGridOption });
}
 
function dateFormat(data){
	return data.substring(0,10);
}


$(document).ready(function(){
	
	$("#dataAuthArea").hide(); 
	$.fn.ifvmSetSelectOptionCommCode("groupType", "AUTH_GROUP_TYPE");
    $('#groupType').children("[value='']").remove();	//첫번째 빈 Option 삭제
	
    
    
    systemSelect($('#systemName'));	
    
    jqGridTable();
	dataAuthGrid();
	init();
	
    
  	$('#groupType').change(function(){	   
		var groupCode = $('#groupType').val();
		
		//groupCode가 DATA인 권한그룹유형은 DATA권한목록 
		if( groupCode == 'DATA'){
			$("#screenAuthArea").hide();
			$("#dataAuthArea").show();
			dataAuthGrid();

		}else {
		//화면권한 목록
			$("#dataAuthArea").hide();
			$("#screenAuthArea").show();
			jqGridTable();
		
		}
		
	});  
    
});

</script>


<div class="page-title">
	<h1>
		<spring:message code="M00216"/>
		&gt;  <spring:message code="M00188"/> >&gt; <spring:message code="M00223"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00224"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id='authGroupSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00135" />
		</button> 
	</div>
</div>


<div class="well form-horizontal">
	<div class="row">
		<%-- <label class="col-xs-2 control-label"><spring:message code="M00174"/></label> --%>
		<div class="col-xs-3" style="display:none ">
			<div class="input-group">
			    <ifvm:input type="select" id='systemName'/>				
			</div>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="M00587"/></label>
		<div class="col-xs-3">
			<div class="input-group">
			    <ifvm:input type="select" id='groupType' names='groupType'/>	
			</div>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="M00190"/></label>
		<div class="col-xs-3">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id='authGroupSearch'/>
			</div>
		</div>
	</div>		
</div>

<!-- 화면권한 영역 -->
<div id="screenAuthArea">

	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00189"/></span>
		</div>
		<div class="btn_wrap">
			<button class="btn btn-sm btn_gray" id='addAuthGroupBtn'>         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00163"/>
			</button> 
			<button class="btn btn-sm btn_gray" id='delAuthGroupBtn'>         
				<i class="fa fa-minus"></i>    
				<spring:message code="M00165"/>
			</button> 	
		</div>
	</div>
	<div id="ownerGroupListGrid" class="grid_bd0"></div>
</div>


<!-- data권한 영역 -->

<div id="dataAuthArea">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00189"/></span>
		</div>
		<div class="btn_wrap">
			<button class="btn btn-sm btn_gray" id='addDataAuthGroupBtn'>         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00163"/>
			</button> 
			<button class="btn btn-sm btn_gray" id='delDataAuthGroupBtn'>         
				<i class="fa fa-minus"></i>    
				<spring:message code="M00165"/>
			</button> 	
		</div>
	</div>
	<div id="dataAuthGrid" class="grid_bd0"></div>
</div>
