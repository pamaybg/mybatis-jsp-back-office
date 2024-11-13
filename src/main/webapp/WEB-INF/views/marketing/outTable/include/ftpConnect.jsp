<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var ftpConnectList;
var ftpConnectId = "";

//Target Level List
function ftpConnectListInit(){
	var jqGridOption = {
			ondblClickRow : function(data){
				ftpConnectId = ftpConnectList.getCheckedGridData()[0].id;
				targetLevelPopInit("<spring:message code='M00167'/>");
			},
	        onSelectRow : function (data) {
			},
			serializeGridData : function( data ){
				
			},		
			loadComplete : function(obj){
			},
		url: '<ifvm:action name="getFtpConnect"/>',
	    colNames:[
	              "<spring:message code='M01374'/>"
	              , "<spring:message code='M01375'/>"
	              , "<spring:message code='M01376'/>"
	              , "<spring:message code='M01377'/>"
	              , "<spring:message code='M01378'/>"
	              , "<spring:message code='M01379'/>"
	              , "<spring:message code='M01380'/>"
	              , "ID"
	              ],
	    colModel:[
					{name:'ftp_prps_cd_nm', index:'FTP_PRPS_CD_NM', resizable : false}
	              , {name:'ftp_prot_cd_nm', index:'FTP_PROT_CD_NM', resizable : false}
	              , {name:'con_ip', index:'CON_IP', resizable : false}	              
	              , {name:'con_port', index:'CON_PORT', resizable : false}
	              , {name:'con_id', index:'CON_ID', resizable : false}
	              , {name:'con_foldr_path', index:'CON_FOLDR_PATH', resizable : false}
	              , {name:'ftp_desc', index:'FTP_DESC', resizable : false}	              
	              , {name:'id', index:'id', resizable : false,  hidden : true,  searchable : false}
			      ],  
		radio:true,
	    sortname: 'FTP_DESC',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	ftpConnectList = $("#ftpConnectList").ifvGrid({ jqGridOption : jqGridOption });
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
		var rowData = ftpConnectList.getCheckedGridData()[0];
		
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
	
	$("#commonDtlBtn4").on('click', function(){
    	
    	var data = ftpConnectList.getCheckedList()[0];
    	
    	if(typeof(data) == 'undefined'){
    		alert('<spring:message code="M00004" />');
    	}
    	else{
    		ftpConnectId = ftpConnectList.getCheckedGridData()[0].id;
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
		<button class="btn btn-sm" id="addFtpConnectList">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		
		<button class="btn btn-sm" id="commonDtlBtn4">         
			<spring:message code="M00259"/>
		</button> 
		
		<button class="btn btn-sm" id="removeFtpConnectList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="ftpConnectList" class="grid_bd0"></div>

