<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<script>
$.ifvmLnbSetting('targeting');
//Target Level
var targetLevelURL = '<ifvm:url name="targetLevel"/>';		//타겟 레벨
var targetTableURL = '<ifvm:url name="targetTable"/>';		//타겟 테이블
var levelJoinURL = '<ifvm:url name="levelJoin"/>';		    //타겟 레벨 테이블

var targetColumnURL = '<ifvm:url name="targetColumn"/>';		//타겟 칼럼
//Subject Area
var subjectAreaURL = '<ifvm:url name="subjectArea"/>';		//서브젝트 에어리어
var subjectFieldURL = '<ifvm:url name="subjectField"/>';		//필드
var joinDefinitionURL = '<ifvm:url name="joinDefinition"/>';		//Join 정의
var joinDetailURL = '<ifvm:url name="joinDetail"/>';		//Join 상세

function divideScreen() {
	$('#adminCon').split({orientation:'vertical', limit:100, position:'15%'});
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
		case 'levelJoin' :
			url = this.levelJoinURL;
			break;
		case 'targetTable' :
			url = this.targetTableURL;
			break;
		case 'targetColumn' :
			url = this.targetColumnURL;
			break;

		case 'subjectArea' :
			url = this.subjectAreaURL;
			break;
		case 'subjectField' :
			url = this.subjectFieldURL;
			break;
		case 'joinDefinition' :
			url = this.joinDefinitionURL;
			break;
		case 'joinDetail' :
			url = this.joinDetailURL;
			break;
			
		default :
			
			break;
	};
	
	var _this = this;
	var fileName = url.split('/').pop();
	
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		$("#targetLevelContent").append( script );
		
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
		$("#targetLevelContent").html('');
		
		$('.acc_row').removeClass('active');
		$(this).addClass('active');
		
		var thisId = $(this).attr('id');
		if(thisId == 'targetLevel') {
			appendPage('targetLevel');
			appendPage('levelJoin');	
		} else if(thisId == 'targetTable') {
			columPage = 'false';
			appendPage('targetLevel');
			appendPage('targetTable');
		} else if(thisId == 'targetColumn') {
			columPage = 'true';
			appendPage('targetTable');
			appendPage('targetColumn');
		} else if(thisId == 'subjectArea') {
			appendPage('subjectArea');
		} else if(thisId == 'subjectField') {
			appendPage('subjectArea');
			appendPage('subjectField');
		} else if(thisId == 'joinDefinition') {
			appendPage('subjectArea');
			appendPage('joinDefinition');
		} else if(thisId == 'joinDetail') {
			appendPage('joinDefinition');
			appendPage('joinDetail');
		}
	});

	$('#targetLevel').trigger('click');
});

</script>

<div id="formArea">
	<div class="page-title">
		<h1>
			<spring:message code="M01102"/>
			<span> &gt; <spring:message code="M01103"/></span>
		</h1>
	</div>
	<div id="adminCon">
 		<div id="basicAccordion">
			<h3>
				<a href="#"><spring:message code="M01104"/></a>
			</h3>
			<div>
				<div class="acc_row row_depth1" id="targetLevel"><span><spring:message code="M01105"/></span></div>
				<div class="acc_row row_depth2" id="targetTable">&bull; <span><spring:message code="M01106"/></span></div>
				<div class="acc_row row_depth3" id="targetColumn">- <span><spring:message code="M01107"/></span></div>
			</div>
			<h3>
				<a href="#"><spring:message code="M01108"/></a>
			</h3>
			<div>
				<div class="acc_row row_depth1" id="subjectArea"><span><spring:message code="M01108"/></span></div>			
				<div class="acc_row row_depth2" id="subjectField">&bull; <span><spring:message code="M01109"/></span></div>
				<div class="acc_row row_depth2" id="joinDefinition">&bull; <span><spring:message code="M01110"/></span></div>
				<div class="acc_row row_depth3" id="joinDetail">- <span><spring:message code="M01111"/></span></div>
			</div>				
		</div>
		<div id="targetLevelContent"></div>	 
	</div>
</div>

<div id="adminTargetingPop" class="popup_container"></div>
