<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<script>

//Target Level
var targetLevelURL = '<ifvm:url name="outtargetLevelNew"/>';		//타겟 레벨
var targetTableURL = '<ifvm:url name="outtargetTableNew"/>';		//타겟 테이블
var targetColumnURL = '<ifvm:url name="outtargetColumnNew"/>';		//타겟 칼럼

//runChannel
var permissionURL = '<ifvm:url name="permissionNew"/>';		//서브젝트 에어리어
var runChannelURL = '<ifvm:url name="runChannelNew"/>';		//필드

//ftpConnect
var ftpConnectURL = '<ifvm:url name="ftpConnectNew"/>';		//FTP 연결정보

var emailHostURL = '<ifvm:url name="emailHostURL"/>';		//FTP 연결정보

//외부 웹사이트 관리
var webServiceURL = '<ifvm:url name="webServiceURL"/>';

function divideScreen() {
	$('#adminCon').split({orientation:'vertical', limit:120, position:'18%'});
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
	    	$('#targetLevel').trigger('click');
	    else
	    	$('#subjectArea').trigger('click');
	}
}

function appendPage(type) {
	
	var url = '';
	
	switch( type ){
	
		case 'targetLevel' :
			url = this.targetLevelURL;
			break;
		case 'targetTable' :
			url = this.targetTableURL;
			break;
		case 'targetColumn' :
			url = this.targetColumnURL;
			break;
		case 'permission' :
			url = this.permissionURL;
			break;
		case 'runChannel' :
			url = this.runChannelURL;
			break;
		case 'ftpConnect' :
			url = this.ftpConnectURL;
			break;
		case 'emailHost' :
			url = this.emailHostURL;
			break;
        case 'webService' :
            url = this.webServiceURL;
            break;
            
		default :
			break;
	};
	
	var fileName = url.split('/').pop();
	
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		
		console.log('type=====' + type);
		
		if(type == 'targetTable' ||type == 'runChannel') $("#targetTable").append( script );  
		else if(type == 'targetColumn' ||type == 'permission' ) $("#targetColumn").append( script );
		else $("#targetLevelContent").append( script );
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
	$("#adminCon").height(900);
	
	divideScreen();
	accordionSetting();
	
	$('.acc_row').on('click', function() {
		$("#targetLevelContent").empty();
		$("#targetTable").empty();
		$("#targetColumn").empty();
		
		$("#targetLevelContent").html('');
		$("#targetTable").html('');
		$("#targetColumn").html('');
		
		$('.acc_row').removeClass('active');
		$(this).addClass('active');
		
		var thisId = $(this).attr('id');
		if(thisId == 'targetLevel') {
			appendPage('targetLevel');
			appendPage('targetTable');
			appendPage('targetColumn');
			//appendPage('levelJoin');	
		} else if(thisId == 'targetTable') {
			appendPage('targetTable');
		} else if(thisId == 'permission') {
			appendPage('runChannel');
			appendPage('permission'); 
		} else if(thisId == 'ftpConnect') {
			appendPage('ftpConnect');
		} else if(thisId == 'emailHost') {
			appendPage('emailHost');
		}  else if(thisId == 'webService') {
            appendPage('webService');
        } 

	});

	$('#targetLevel').trigger('click');
});

</script>

<div id="formArea">
	<div class="page-title">
		<h1>
			<spring:message code="O00202"/> &gt; <spring:message code="L00030"/>
			<%-- <span> &gt; <spring:message code="L00030"/></span> --%>
		</h1>
	</div>
	<div id="adminCon">
 		<div id="basicAccordion">
			<h3>
				<a href="#"><spring:message code="M01290"/></a>
			</h3>
			<div>
				<div class="acc_row row_depth1" id="targetLevel"><span><spring:message code="M01291"/></span></div>
				<div class="acc_row row_depth1" id="permission"><span><spring:message code="M01286"/></span></div>
				<div class="acc_row row_depth1" id="ftpConnect"><span><spring:message code="M01373"/></span></div>
				<div class="acc_row row_depth1" id="emailHost"><span><spring:message code="이메일 발송 호스트 관리"/></span></div>
        	    <div class="acc_row row_depth1" id="webService"><span><spring:message code="M03011"/></span></div>
    				<%-- 
                    <div class="acc_row row_depth2" id="targetTable">&bull; <span><spring:message code="M01106"/></span></div>
    				<div class="acc_row row_depth3" id="targetColumn">- <span><spring:message code="M01107"/></span></div>
    				 --%>
				<div class="row gridrow"></div>
			</div>
		</div>
		<div id="basicAccordion2">
			<div id="targetLevelContent"></div>
			<div id="targetLevelContent2">
                <div class="row">
                    <div  id="targetTable"></div>
                </div>
                <div class="row">
					<div id="targetColumn"></div>		
                </div>
			</div>
		</div>
	</div>
</div>

<div id="adminTargetingPop" class="popup_container"></div>