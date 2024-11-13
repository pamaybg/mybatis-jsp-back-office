<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<style>
.well .hidden_row {display: none;}
</style>
<script>


var action;
var validation;

function init(){
	$.ifvmLnbSetting("ownerGroupList");
    validation = $("#selectForm").ifvValidation();
    

	
	
   	var date = new Date();
   	var month ='00',  dateD = '00';
   	var dateMonth = String(date.getMonth()+1);	
   	var monthlength = month.length-dateMonth.length;   
   	var dateDate = String(date.getDate());
   	var datelength = dateD.length-dateDate.length;
       	
	$('#createdDate').val(date.getFullYear()+'-'+month.substring(0,monthlength)+dateMonth+'-'+dateD.substring(0,datelength)+dateDate);
	
   	   	
};

//권한유형조회
/* function groupTypeSelect(select){

	 $.ifvSyncPostJSON('<ifvm:action name="getAuthGroupType"/>',
			 {},	 
			 function(result){
			      	 //
			    	 $(result.rows).each(function(index, item){	 
			    		 //console.log(item);
			    		 $(select).append($('<option/>').text(item.markName)
			    				  .val(item.commId));	 
			    	 });   
	});
}
 */


//시스템명 조회
function systemSelect(select){

	 $.ifvSyncPostJSON('<ifvm:action name="getSystem"/>',
	 {id:'SYS_SELECT'}, 
	 function(result){
	      	 //
	    	 $(result.rows).each(function(index, item){	 
	    		 //console.log(item);
	    		 
	    		 $(select).append($('<option/>').text(item.and_app_name)
	    				  .val(item.id));	 	
	    	 });	 
	    	 
		     var chkSession = $.ifvmGetUserInfo().appServiceId;
		    	 
			 if(chkSession!='null' || chkSession!=null ) 
		     	select.val(chkSession);
	    	 
	 });
}

function checkforDetail(flag){	
	//console.log(flag);
	
	//업데이트
	if(flag!='null'){
     	 var myParam = '<%=cleanXss(request.getParameter("id"))%>';
     	 $('#groupType').attr("disabled",true);
     	 $('#subTitle').text( '<spring:message code="M00259"/>');
     	
    	 $.ifvSyncPostJSON('<ifvm:action name="getAuthGroupDetail"/>',
    			 {id:myParam},
  	 			 function(result){
    				 	
    			      	//console.log($(result.rows)[0]);
    			      	var detailObject = $(result.rows)[0];
    			      	//$('#groupType option:selected').attr(detailObject.authGroupType);
    			      	$('#authId').val(detailObject.authId);				//권한그룹 auth_num
    			      	$('#authName').val(detailObject.authGroupName);		//권한 그룹명
    			      	$('#dataAuthType').val(detailObject.dataAuthType);	//data권한 유형명
    			        $('#groupType').val(detailObject.authGroupType);	//권한그룹유형명
    				   	$('#createdBy').val(detailObject.createBy);			//작성자
    				   	$('#baseDept').val(detailObject.baseDeptName).text(detailObject.baseDept);	//기준부서명, id
    			      	var crDate = detailObject.createdDate; 
       			        $('#createdDate').val(crDate.substring(0,10));		//작성일자  
    			      	if(parseInt(detailObject.flag)==1){
    			      	$('#flagCheck1').trigger('click');
    			      	
    			      	}
    			 });
    	 

    	 
    	 
    	action = 'updateAuthGroup';
    	  
	}else{
		$('#flagCheck1').trigger('click');

		//신규 등록할때 로그인한 계정으로 등록자 설정
	   	$('#createdBy').val($.ifvmGetUserInfo().empName);
		action = 'addAuthGroup';
	}
}



$(document).ready(function(){
	//권한그룹유형 
    $.fn.ifvmSetSelectOptionCommCode("groupType", "AUTH_GROUP_TYPE");
	//data권한유형
    $.fn.ifvmSetSelectOptionCommCode("dataAuthType", "AUTH_DATA_GROUP_TYPE");
    $('#groupType').children("[value='']").remove();	//첫번째 빈 Option 삭제

    $('#dataAuthType').children("[value='']").text('<spring:message code="M01253"/>');
        
	init();
    
	systemSelect($('#systemName'));
	checkforDetail('<%=request.getAttribute("authGroupDetail")%>');	
	
	
	//권한유형별 사용 안하는 데이터들 설정 못하게 이벤트 설정
	 $("#groupType").on("change", function(){
		 if($('#groupType').val() == 'DATA'){
	     	 $('#dataAuthType').attr("disabled",false);
		 }else{
			 $('#baseDept').val("").text("");
			 $('#dataAuthType').val("");
	 		 $('#dataAuthType').attr("disabled",true);
		 }
	 });
	 
	 //데이터 권한 변경 이벤트
	 $("#dataAuthType").on("change", function(){
		//하위부서로 추가된 기준부서를, 다른 전체 혹은 소속부서로 변경 한다면, 기준부서가 없도록 초기화.
        if($('#dataAuthType').val() != 'UNDERDEPT' && ($('#baseDept').text() != null || $('#baseDept').text() != "")){
        	$('#baseDept').text("").val("");
        }
		
	 });
	//부서 조회 팝업 
	$('#searchDept').on('click', function() {
		if($('#groupType').val() != 'DATA' ){
			alert('<spring:message code="M01251"/>');
		}else if($('#dataAuthType').val() != 'UNDERDEPT' ){
			alert('<spring:message code="M01252"/>');
		}
		else{
			$("#popupContainer").ejDialog({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="deptListPop"/>',
		        contentType: "ajax",
		        title: '<spring:message code="M00566"/>',
		        width: 600,
		        close : 'deptPopupClose'
		    });
		}
	});
	
    //data권한설정이 아닐때 데이터 권한 유형설정을 사용 안함.
    if($('#groupType').val() != 'DATA'){
    	$('#dataAuthType').attr("disabled",true);
    }
    
    //추가 ,수정
    $('#saveBtn').click(function(){		  		  	
		var flagCheckValue = false;
		validation.confirm();
		if($('#flagCheck1').attr('checked'))
			flagCheckValue = true;	

			var alertText = '';
			var data = new Object;
			if(action=='addAuthGroup'){
		        data.authGroupName = $('#authName').val();
		        data.authGroupType = $('#groupType option:selected').attr("value");
		        //data.appServiceType =  $('#systemName').val();
		        data.baseDept =$('#baseDept').text();
		        data.dataAuthType = $('#dataAuthType option:selected').attr("value");
		        data.groupCode = $('#dataAuthType').val();
		        data.flagCheck = flagCheckValue;			
		        alertText = '<spring:message code="M00207"/>';
		        
			}else if(action=='updateAuthGroup'){ 
				

				data.id = '<%=cleanXss(request.getParameter("id"))%>';
				data.authGroupType = $('#groupType option:selected').attr("value");
		        data.authGroupName = $('#authName').val();
		        //data.appServiceType =  $('#systemName').val();
		        data.baseDept =$('#baseDept').text();
		      
		        data.dataAuthType = $('#dataAuthType option:selected').attr("value");
		        //data.groupCode = $('#dataAuthType').val();
		        data.flagCheck = flagCheckValue;						
		        alertText = '<spring:message code="M00209"/>';
			}
			
			alert(alertText);
			//권한그룹명이 입력 안되잇을때
			if($('#authName').val()==''||$('#authName').val()==null){
				alert('<spring:message code="M00215"/>');
			}
		    //하위부서로 저장시에 기준부서가 선택되어야함.
			else if($('#dataAuthType').val() == 'UNDERDEPT' &&($('#baseDept').val() == null || $('#baseDept').val() ==""))
			{
		    	alert('<spring:message code="M01254"/>');
		    //DATA권한인 경우에 data권한 유형이 선택되어야함.
			}else if($('#groupType').val() == 'DATA' &&($('#dataAuthType').val() == null || $('#dataAuthType').val() =="")){
				alert('<spring:message code="M01255"/>');
			}else{
					$.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/'+action+'.do',data, 
							 function(result){
									if(action=='addAuthGroup'){
									    qtjs.href('<ifvm:url name="ownerGroupList"/>';				         );
									}else if(action=='updateAuthGroup'){
										alert('<spring:message code="M01256"/>');
										qtjs.reload();
									}
					});	
			}

	});		
	


	
});
function deptPopupClose() {
	$('#popupContainer').ejDialog('destroy');	
}

</script>

<div class="page-title">
	<h1>
		<spring:message code="M00216"/> &gt; <spring:message code="M00188"/> &gt; <label id="subTitle"><spring:message code="M00217"/></label>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00219"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button class="btn btn-sm" id="saveBtn">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00220"/>
		</button> 
	</div>
</div>


<div class="well underline form-horizontal" id ="selectForm">
	<div class="row  qt_border hidden_row">
		<label class="col-xs-2 control-label"><spring:message code="M00174"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">				
				<ifvm:input type="select" id="systemName" disabled="true"/>				
			</div>
		</div>
	</div>	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00587"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="groupType" names="groupType"/>				
			</div>
		</div>

		<label class="col-xs-2 control-label"><spring:message code="M00181"/></label>
		<div class="col-xs-1 control_content" >
			<div class="input-group">
				   <ifvm:input type="checkboxType" text="M00164" id="flagCheck"/>	
	    	</div>
		</div>
	</div>	
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00192"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id="authId" placeholder="M00588" disabled="true"/>				
			</div>
		</div>
	   <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00190"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id="authName" maxLength='100' required="true"/>				
			</div>
		</div>
	</div>
		<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01244"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="dataAuthType" names="dataAuthType"/>				
			</div>
		</div>
		<div class="col-xs-6"> 
		<label class="col-xs-4 control-label"><spring:message code="M01245"/></label>
				<div class="col-xs-6 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="baseDept"/>
						<span class="input-group-addon" id="searchDept"><i class="fa fa-search"></i></span>
					</div>
				</div>
		</div>

	</div>		
	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="M00221"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id="createdBy" disabled="true"/>				
			</div>
		</div>
	    <label class="col-xs-2 control-label"><spring:message code="M00222"/></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" className="form-control" id="createdDate" disabled="true"/>				
			</div>
		</div>
	</div>	
</div>


<div id="popupContainer" class="popup_container"></div>
