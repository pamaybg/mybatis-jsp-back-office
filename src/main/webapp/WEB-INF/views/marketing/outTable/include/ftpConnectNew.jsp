<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var ftpConnectList;
var ftpConnectId = null;

//Target Level List
function ftpConnectListInit(){
	var ejGridOption = {
		/* recordDoubleClick : function(args){
				ftpConnectId = args.data.id;
				targetLevelPopInit("<spring:message code='M00167'/>");
			}, */
 	        onSelectRow : function (data) {
 	        	ftpConnectId = args.data.id;
 			},
// 			serializeGridData : function( data ){
				
// 			},		
// 			loadComplete : function(obj){
// 			},
		dataUrl: '<ifvm:action name="getFtpConnect"/>',
		columns  :[
	    	{
      		  field : 'ftp_prps_cd_nm', headerText : '<spring:message code="M01374"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'FTP_PRPS_CD_NM' , searchable: true} //
      	  },{
    		  field : 'ftp_prot_cd_nm', headerText : '<spring:message code="M01375"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'FTP_PROT_CD_NM' , searchable: true} //
    	  },{
    		  field : 'con_ip', headerText : '<spring:message code="M01376"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'CON_IP' } //
    	  },{
    		  field : 'con_port', headerText : '<spring:message code="M01377"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'CON_PORT' } //
    	  },{
    		  field : 'con_id', headerText : '<spring:message code="M01378"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'CON_ID' } //
    	  },{
    		  field : 'con_foldr_path', headerText : '<spring:message code="M01379"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'CON_FOLDR_PATH', searchable: true } //
    	  },{
    		  field : 'ftp_desc', headerText : '<spring:message code="M01380"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'FTP_DESC' } //
    	  },{
    		  field : 'id', headerText : 'ID', visible : false ,
    		  customAttributes : {
    			  searchable : false,
    			  index : 'id' } //
    	  },
      ],  
      requestGridData : {
    	  nd   : new Date().getTime(),
    	  rows : 10,
    	  sidx : 'FTP_DESC',
    	  sord : 'desc',
    	  _search : false
      },
      
      rowList : [10,25,50,100],
      radio: true,
	  tempId : 'ifvGridOriginTemplete'
	};
	ftpConnectList = $("#ftpConnectList").ifvsfGrid({ ejGridOption : ejGridOption });
}
 
function targetLevelPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ftpConnectPop"/>',
        contentType: "ajax",
        title: title,
        width: 650,
        close : 'adminTargetingPopClose',
    });
} 


$(document).ready(function(){
	ftpConnectListInit();
	
	$('#addFtpConnectList').on('click', function() {
		ftpConnectId = "";
		targetLevelPopInit("<spring:message code='M00167'/>");
	});
	
	$('#removeFtpConnectList').on('click', function() {
		var rowData = ftpConnectList.opt.gridControl.getSelectedRecords()[0];
		
		if( rowData != null ){
			if(confirm('<spring:message code="M00208"/>')){
				//이벤트 조회
				$.ifvSyncPostJSON('<ifvm:action name="removeFtpConnect"/>', {
					id : rowData.id
				}, function(result) {
					alert('<spring:message code="M00590"/>');
					$.fn.ifvmSubmitSearchCondition("ftpConnectList", ftpConnectListInit);
				});
			}
		} else {
			alert('<spring:message code="C00113"/>');
		}
	});
	
	$("#modifyFtpConnectList").on('click', function(){
    	
    	var data = ftpConnectList.opt.gridControl.getSelectedRecords()[0];
    	
    	if(typeof(data) == 'undefined'){
    		alert('<spring:message code="M00004" />');
    	}
    	else{
    		ftpConnectId = ftpConnectList.opt.gridControl.getSelectedRecords()[0].id;
			targetLevelPopInit("<spring:message code='M00167'/>");
    	}
    	
    });
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01373"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addFtpConnectList" objCode="ftpConnectNewAdd_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		
		<button class="btn btn-sm" id="modifyFtpConnectList" objCode="ftpConnectNewModify_OBJ">         
			<spring:message code="M00259"/>
		</button> 
		
		<button class="btn btn-sm" id="removeFtpConnectList" objCode="ftpConnectNewDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="ftpConnectList" class="grid_bd0"></div>

