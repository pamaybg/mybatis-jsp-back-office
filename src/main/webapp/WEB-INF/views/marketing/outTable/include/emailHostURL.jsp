<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var emailHostList;
var emailHostId = null;

//Target Level List
function emailHostListInit(){
	var ejGridOption = {
			rowSelected : function (args) {
 	        	emailHostId = args.data.id;
 			},
		dataUrl: '<ifvm:action name="getEmailHost"/>',
		columns  :[
	    	{
      		  field : 'host', headerText : '<spring:message code="호스트"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'ceh.host' , searchable: true} //
      	  },{
    		  field : 'port', headerText : '<spring:message code="포트"/>',textAlign : 'center' , headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'ceh.port' , searchable: true} //
    	  },{
    		  field : 'email', headerText : '<spring:message code="발신자 이메일"/>',textAlign : 'left' , headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'ceh.email' , searchable: true} //
    	  },{
    		  field : 'id', headerText : 'id', visible : false ,
    		  customAttributes : {
    			  searchable : false,
    			  index : 'ceh.id' } //
    	  },
      ],  
      requestGridData : {
    	  nd   : new Date().getTime(),
    	  rows : 10,
    	  sidx : '1',
    	  sord : 'desc',
    	  _search : false
      },
      
      rowList : [10,25,50,100],
      radio: true,
	  tempId : 'ifvGridOriginTemplete'
	};
	emailHostList = $("#emailHostList").ifvsfGrid({ ejGridOption : ejGridOption });
}
 
function targetLevelPopInit(title){
	$("#emailHostPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="emailHostPop"/>',
        contentType: "ajax",
        title: title,
        width: 650,
        close : 'adminTargetingPopClose',
    });
}

function adminTargetingPopClose() {
	emailHostPop._destroy();
}


$(document).ready(function(){
	emailHostListInit();
	
	$('#addemailHostList').on('click', function() {
		emailHostId = "";
		targetLevelPopInit("<spring:message code='M00167'/>");
	});
	
	$('#removeemailHostList').on('click', function() {
		var rowData = emailHostList.opt.gridControl.getSelectedRecords()[0];
		
		if( rowData != null ){
			if(confirm('<spring:message code="M00208"/>')){
				//이벤트 조회
				$.ifvSyncPostJSON('<ifvm:action name="removeEmailHost"/>', {
					id : rowData.id
				}, function(result) {
					alert('<spring:message code="M00590"/>');
					emailHostList._doAjax();
					//$.fn.ifvmSubmitSearchCondition("emailHostList", emailHostListInit);
				});
			}
		} else {
			alert('<spring:message code="C00113"/>');
		}
	});
	
	$("#modifyemailHostList").on('click', function(){
    	var data = emailHostList.opt.gridControl.getSelectedRecords()[0];
    	
    	if(typeof(data) == 'undefined'){
    		alert('<spring:message code="M00004" />');
    	}
    	else{
    		emailHostId = emailHostList.opt.gridControl.getSelectedRecords()[0].id;
			targetLevelPopInit("<spring:message code='M00167'/>");
    	}
    	
    });
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="이메일 발송 호스트 관리"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addemailHostList" objCode="emailHostNewAdd_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		
		<button class="btn btn-sm" id="modifyemailHostList" objCode="emailHostNewModify_OBJ">         
			<spring:message code="M00259"/>
		</button> 
		
		<button class="btn btn-sm" id="removeemailHostList" objCode="emailHostNewDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="emailHostList" class="grid_bd0"></div>
<div id="emailHostPop" class="popup_container"></div>
