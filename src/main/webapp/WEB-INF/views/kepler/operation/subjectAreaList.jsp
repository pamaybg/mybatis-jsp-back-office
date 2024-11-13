<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>
<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<script>
var subjectAreaRegistList = null;
var serviceDbList = null;

//dbInform
var subjectAreaURL = '<ifvm:url name="subjectAreaRegistNew"/>';		//주제영역 관리

//runChannel
var permissionURL = '<ifvm:url name="subjectAreaMaping"/>';		//서브젝트 에어리어
var runChannelURL = '<ifvm:url name="subjectAreaService"/>';		//필드 

function divideScreen() {
	$('#adminCon').split({orientation:'vertical', limit:120, position:'18%'});
	$('#vsplitter').attr(" z-index : 999")	
	$('#basicAccordion2').on('resize', function() {
		if(subjectAreaRegistList != null)
			subjectAreaRegistList.setWidth();
		
		if(serviceDbList != null)
			serviceDbList.setWidth();
	});
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
	    	$('#subjectArea').trigger('click');
	    else
	    	$('#serviceDbSubject').trigger('click');
	}
}

function appendPage(type) {
	var url = '';
	
	switch( type ){
		case 'subjectArea' :
			url = this.subjectAreaURL;
			break;
		case 'permission' :
			url = this.permissionURL;
			break;
		case 'runChannel' :
			url = this.runChannelURL;
			break;
		default :
	break;
	};
	
	subjectAreaRegistList = null;
	serviceDbList = null;
	
	var fileName = url.split('/').pop();
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		if(type == 'serviceDb' ||type == 'runChannel') $("#serviceDb").append( script );  
		else if(type == 'subjectDb' ||type == 'permission' ) $("#subjectDb").append( script );
		else  $("#subjectAreaContent").append( script );
		
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
}

function openSubejctArea() {
	$('#serviceDbSubject').trigger('click');
}

function adminTargetingPopClose() {
	adminTargetingPop._destroy();
}

$(document).ready(function() {
	$("#adminCon").height(900);
	
 	divideScreen();
	//accordionSetting();

	/* $('.acc_row').on('click', function() {
		$("#subjectAreaContent").empty();
		$("#serviceDb").empty();
		$("#subjectDb").empty();
		
		$("#subjectAreaContent").html('');
		$("#serviceDb").html('');
		$("#subjectDb").html('');
		
		$('.acc_row').removeClass('active');
		$(this).addClass('active');
		
		var thisId = $(this).attr('id');
		$('.subject_area_content').hide();
		if(thisId == 'subjectArea') {
			$('#subjectAreaContent').show();
			appendPage('subjectArea');
		} else if(thisId == 'permission') {
			$('#subjectAreaContent2').show();
			appendPage('runChannel');
			appendPage('permission'); 
		}
	}); */
	var sourceTreeData=null;
    sourceTreeData = [
                      {id: "subjectArea", text: '<spring:message code="M01595"/>', parentId: ""}
    				 ,{id: "permission", text: '<spring:message code="M01580"/>', parentId: ""}
    ];
	
	$("#nodeTreeView").ifvsfTree({
		  expanded: true
		, fields: { id: "id"
	    		, text: "text"
	    		, parentId: "parentId"
	    		, dataSource: sourceTreeData
	    }
		, nodeClick: function( args ) {
			var target = $( args.currentElement );
			var targetId = target.closest( "li[id]" ).attr( "id" );

			if( $.fn.ifvmIsNotEmpty( targetId ) ) {
	           	
	    		$("#subjectAreaContent").empty();
	    		$("#serviceDb").empty();
	    		$("#subjectDb").empty();
	    		
	    		$("#subjectAreaContent").html('');
	    		$("#serviceDb").html('');
	    		$("#subjectDb").html('');
	    		
	    		$('.subject_area_content').hide();
	    		if(targetId == "subjectArea") {
	    			$('#subjectAreaContent').show();
	    			appendPage('subjectArea');
	    		} else {
	    			$('#subjectAreaContent2').show();
	    			appendPage('runChannel');
	    			appendPage('permission'); 
	    		}
			}
		}
		,template : "#baseTreeTemplate1"
	});
	
	$('#subjectArea').trigger('click');
});

</script>

<div id="formArea">
	<div class="page-title">
		<h1>
			<spring:message code="M01155" /> &gt; <spring:message code="M00273" />
		</h1>
	</div>
	<div id="adminCon">
<%--  		<div id="basicAccordion">
 			<h3>
 				<a href="#"><spring:message code="M01594"/></a> 
			</h3>
			<div>
				<div class="acc_row row_depth1" id="subjectArea"><span><spring:message code="M01595"/></span></div>
				<div class="acc_row row_depth1" id="permission"><span><spring:message code="M01580"/></span></div>
				<div class="row gridrow"></div>
			</div>
		</div> --%>
		<div class="analysis_tree">
			<div id="nodeMenu" class="h100">
				<h3 class="acdn_title"><spring:message code="M01594"/></h3>
				<div id="nodeTreeView" class="left_tree_view"></div>
			</div>
		</div>
		<div id="basicAccordion2">
			<div id="subjectAreaContent" class="subject_area_content"></div>	 
			<div id="subjectAreaContent2" class="h100 subject_area_content">
				<div class="col-xs-6 h100">
					<div  id="serviceDb" class="br h100 white_bg"></div>
				</div>
				<div class="col-xs-6 pl10 h100">
					<div id="subjectDb" class="bl h100 white_bg"></div>		
				</div>
			</div> 
		</div>
	</div>
</div>

<div id="adminTargetingPop" class="popup_container"></div>
