<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<script>

//QIM Admin Main View
var qimAdmin = '<ifvm:url name="qimAdmin"/>';					//QIM Menu Main

//QIM Admin Sub View
var manageEncDetail = '<ifvm:url name="manageEncDetail"/>';		//암호화 키
var srcTgtList = '<ifvm:url name="srcTgtList"/>';				//소스-타겟 관리
var accessInfoList = '<ifvm:url name="accessInfoList"/>';		//리소스 관리
var interfaceList = '<ifvm:url name="interfaceList"/>';			//인터페이스 관리
/*
var targetLevelURL = '<ifvm:url name="outtargetLevel"/>';		//암호화키
var targetTableURL = '<ifvm:url name="outtargetTable"/>';		//소스-타겟관리
var targetColumnURL = '<ifvm:url name="outtargetColumn"/>';		//리소스 관리
var targetColumnURL = '<ifvm:url name="outtargetColumn"/>';		//인터페이스 관리

//runChannel
var permissionURL = '<ifvm:url name="permission"/>';		//서브젝트 에어리어
var runChannelURL = '<ifvm:url name="runChannel"/>';		//필드

//ftpConnect
var ftpConnectURL = '<ifvm:url name="ftpConnect"/>';		//FTP 연결정보
*/

function divideScreen() {

	$('#adminCon').split({orientation:'vertical', limit:120, position:'15%'});
	$('#vsplitter').attr(" z-index : 999")	
}

function accordionSetting(){

	$("#basicAccordion").ejAccordion({
		activate: "onActivate",
		collapsible: true
		});
}

function onActivate(args) {
	if (!ej.isNullOrUndefined(args.activeIndex)) {
	    if(args.activeIndex == '0')
	    	$('#manageEncDetail').trigger('click');
	    else
	    	$('#subjectArea').trigger('click');
	}
}

function appendPage(type) {

	var url = '';
	
	switch( type ){
	
		case 'manageEncDetail' :
			url = this.manageEncDetail;
			break;
		case 'srcTgtList' :
			url = this.srcTgtList;
			break;
		case 'accessInfoList' :
			url = this.accessInfoList;
			break;
		case 'interfaceList' :
			url = this.interfaceList;
			break;

		default :
			break;
	};
	
	var fileName = url.split('/').pop();

	$.ifvCachedHtml( url ).done( function(script, textStatus){
		if(type == 'manageEncDetail') $("#qimContent").append( script );
		else $("#qimContent").append( script );
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
	
}

function openSubejctArea() {
	$('#subjectArea').trigger('click');
}

function adminTargetingPopClose() {
	$('#adminTargetingPop').ejDialog('destroy');
}

$(document).ready(function() {
	$.ifvmLnbSetting('qimAdmin');
	$("#adminCon").height(900);
	
	divideScreen();
	accordionSetting();
	
	$('.acc_row').on('click', function() {
		$("#qimContent").empty();
/* 		$("#manageEncDetail").empty();
		$("#srcTgtList").empty();
		$("#accessInfoList").empty();
		$("#interfaceList").empty(); */
		
		$("#qimContent").html('');
/* 		$("#manageEncDetail").html('');
		$("#srcTgtList").html('');
		$("#accessInfoList").html('');
		$("#interfaceList").html(''); */
		
		/*
		$("#targetTable").empty();
		$("#targetColumn").empty();
		$("#targetLevelContent").html('');
		$("#targetTable").html('');
		$("#targetColumn").html('');
		*/
		$('.acc_row').removeClass('active');
		$(this).addClass('active');
		
		var thisId = $(this).attr('id');
		if(thisId == 'manageEncDetail') {
			
			
			appendPage('manageEncDetail');
			//appendPage('targetTable');
			//appendPage('targetColumn');
			//appendPage('levelJoin');	
		} else if(thisId == 'srcTgtList') {
			appendPage('srcTgtList');
		} else if(thisId == 'accessInfoList') {
			appendPage('accessInfoList');
			//appendPage('permission'); 
		} else if(thisId == 'interfaceList') {
			appendPage('interfaceList');
		} 

	});

	$('#manageEncDetail').trigger('click');
});

</script>

<div id="formArea">
	<div class="page-title">
		<h1>
			<spring:message code="Q02908"/>
			<span> &gt; <spring:message code="M01103"/></span>
		</h1>
	</div>
	<div id="adminCon">
 		<div id="basicAccordion">
			<h3>
				<a href="#"><spring:message code="Q02909"/></a>
			</h3>
			<div>
				<div class="acc_row row_depth1" id="manageEncDetail"><span><spring:message code="Q02835"/></span></div>
				<div class="acc_row row_depth1" id="srcTgtList"><span><spring:message code="Q02839"/></span></div>
				<div class="acc_row row_depth1" id="accessInfoList"><span><spring:message code="Q02858"/></span></div>
				<div class="acc_row row_depth1" id="interfaceList"><span><spring:message code="Q02849"/></span></div>
				<%--
				<div class="acc_row row_depth1" id="targetLevel"><span><spring:message code="M01291"/></span></div>
				<div class="acc_row row_depth1" id="permission"><span><spring:message code="M01286"/></span></div>
				<div class="acc_row row_depth1" id="ftpConnect"><span><spring:message code="M01373"/></span></div>
				 --%>
   				<%-- 
                <div class="acc_row row_depth2" id="targetTable">&bull; <span><spring:message code="M01106"/></span></div>
   				<div class="acc_row row_depth3" id="targetColumn">- <span><spring:message code="M01107"/></span></div>
   				 --%>
				<div class="row gridrow"></div>
			</div>
		</div>
		<div id="qimContent">
			<!-- <div id="qimSubMenu"></div>-->
			<div id="qimContents">
                <div class="row">
                    <div  id="qimContentsInner"></div>
                </div>
			</div>
		</div>
	</div>
</div>

<div id="adminTargetingPop" class="popup_container"></div>
