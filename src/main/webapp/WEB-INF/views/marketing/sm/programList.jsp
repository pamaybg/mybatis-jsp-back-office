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


</style>
<script>
var programGrid;


function jqGridTable() {
	var jqGridOption = {
		ondblClickRow : function (data) {
			qtjs.href('<ifvm:url name="programUpdate"/>?id='+programGrid.getRowData()[data-1].id);
		},
		serializeGridData : function(data){
			data.progName = $('#progName').val();
			data.accountId = $('#systemName').val();
			return data;		
		},
		loadComplete : function(obj){

		},
        url : '<ifvm:action name="getProgramList"/>',
        colNames:[ 
                   '<spring:message code="M00187" />',
                   '<spring:message code="M00179" />',
                   '<spring:message code="M00176" />',
                   '<spring:message code="M00180" />',
                   '<spring:message code="M00181" />',
                   '<spring:message code="M00182" />',
                   '<spring:message code="M00184" />',
                   '<spring:message code="M00185" />',
                   'id'
                   ],
        colModel:[
            { name:'applyType', index:'c1.mark_name', resizable : false,  align:'center', searchable : true},
            { name:'progNum', index:'prog.prog_num', resizable : false,  align:'center', searchable : true},
            { name:'progName', index:'prog.prog_name', resizable : false, searchable : true },
            { name:'type', index:'c2.mark_name', resizable : false, align: 'center', searchable : true,},
            { name:'useFlag', index:'prog.use_flag', resizable : false, width:80, align:"center", formatter: "checkbox", formatoptions: {disabled : true}, searchable : true },
            { name:'progPath', index:'prog.prog_path', resizable : false ,  searchable : true},
            { name:'createBy', index:'e1.name', resizable : false,  searchable : true },
            { name:'createDate', index:'prog.create_date', resizable : true, align: 'center',formatter:dateFormat, searchable : true},
            { name:'id', resizable : false,  hidden : true,  searchable : false }
            ],
        multiselect: true,
        sortname: 'prog.create_date',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    }; 
	programGrid = $("#programListCon").ifvGrid({ jqGridOption : jqGridOption });
};


function dateFormat(data){
	//console.log(typeof data);
	//console.log(data.substring(0,10));
	return data.substring(0,10);
}


function init(){
	
	//Error Check
	$('.searchbox_search_input').on('click', function() {
		$(this).css('background','rgb(255, 94, 94)');
	});
	
	$('#progSearchBtn').on('click', function() {
		jqGridTable();							
	});
	
	$("#progName").keyup(function(event){
	    if(event.keyCode == 13){
			jqGridTable();					
	    }
	});
	
	$('#systemName').on('change', function() {
		programGrid.requestData({ accountId : $('#systemName').val() });						
	});
	
	
	
	$('#addProgram').on('click', function() {
		qtjs.href('<ifvm:url name="programDetail"/>?acid='+$('#systemName').val());
	});
	
	$('#delProgram').on('click', function() {
	   if($(programGrid.getCheckedGridData()).length==0){
		   alert('<spring:message code="M00206"/>');
	   }else{
			if(confirm('<spring:message code="M00208"/>')){
				var sendDataArray = new Array;
				var sendData = null;
				//console.log(programGrid.getCheckedGridData());
		        $(programGrid.getCheckedGridData()).each(function(index, item){
		    	    sendData = new Object;
		        	sendData.progType = item.type;
		        	sendData.id =  item.id; 
		        	sendDataArray.push(sendData);
		        });		 
				 
			 	 $.ifvSyncPostJSON('<ifvm:action name="delProgramList"/>',{
			 		     array : sendDataArray }, 
						 function(result){
			 		    	   alert('<spring:message code="M00590"/>');
			 		    	   jqGridTable();	 
			             });
			}	   
		}
	});
}


function systemSelect(select){
	

	 $.ifvSyncPostJSON('<ifvm:action name="getAccountId"/>',
	 {}, 
	 function(result){
		 	for(var i=0;i<result.length;i++){
		 		select.append($('<option/>').text(result[i].name).val(result[i].id));	 	
		 	}
		 	
	      	 //
	    	 /* $(result.rows).each(function(index, item){	 
	    		 //console.log(item);
	    		 select.append($('<option/>').text(item.and_app_name).val(item.id));

	    		 }); */
       
	    	//var chkSession = $.ifvmGetUserInfo().appServiceId;
	    	/* if(chkSession!='null' || chkSession!=null)
	    	{
                select.val(chkSession);
	    	} */
	    	
	    	/* $(select).change(function(){
	    		jqGridTable();    		
	    	}); */
	    	
	 		jqGridTable();					
	 });
}

$(document).ready(function(){
	init();
	systemSelect($('#systemName'));
});

</script>

<div class="page-title">
	<h1>
		<spring:message code="M00156" /> 
		<span> &gt; <spring:message code="M00157" /></span>
		<span> &gt; <spring:message code="M00162" /></span>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00135" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id='progSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00135" />
		</button> 
	</div>
</div>

<div class="well">
	<div class="form-horizontal">			
		<div class="row">
			<label class="col-sm-2 control-label"><spring:message code="M00174" /></label>
			<div class="col-sm-3 control_content">
				<div class="input-group">
					<%-- <ifvm:input type="select" id='systemName' disabled = "true"/> --%>
					<ifvm:input type="select" id='systemName' />
				</div>
			</div>
			<label class="col-sm-3 control-label"><spring:message code="M00176"/></label>
			<div class="col-sm-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" className="form-control" id='progName'/>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="page_btn_area">
	<div class="col-xs-12">
		<span><spring:message code="M00177" /></span>
		<div class="btn_wrap">
			<button class="btn btn-sm btn_gray" id='addProgram'>         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00217"/>
			</button> 
			<button class="btn btn-sm btn_gray" id='delProgram'>         
				<i class="fa fa-minus"></i>    
				 <spring:message code="M00218"/>
			</button> 	
		</div>
	</div>
</div>
<div id="programListCon" class="grid_bd0"></div>