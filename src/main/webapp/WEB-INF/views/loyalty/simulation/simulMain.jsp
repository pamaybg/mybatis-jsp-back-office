<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
.e-tab .e-active-content {padding: 0;}
</style>

<script>
//탭 관련 URL
var memberUrl 		= '${pageContext.request.contextPath}/loyalty/simulation/include/member';	    //회원
var purRegUrl 		= '${pageContext.request.contextPath}/loyalty/simulation/include/purReg';		//구매등록
var purCnlUrl 		= '${pageContext.request.contextPath}/loyalty/simulation/include/purCnl';		//구매취소
var pointEarnUrl 	= '${pageContext.request.contextPath}/loyalty/simulation/include/pointEarn';	//포인트적립요청
var pointCnlUrl 	= '${pageContext.request.contextPath}/loyalty/simulation/include/pointCnl';		//포인트적립취소


// 탭 페이지
function simulTabInit(){
	// 탭 설정
	$("#simulTab").ifvsfTab({
		 tabId : [ "memberTab"
			      ,"purRegTab"
			      ,"purCnlTab"
			      ,"pointEarnTab"
			      ,"pointCnlTab"
			      ]
		,msgCode : [ '<spring:message code="L00431" />'
					,'<spring:message code="M02100" />'
					,'<spring:message code="M02101" />'
					,'<spring:message code="M02103" />'
					,'<spring:message code="M02104" />'
					]
	});
	
	
	$.ifvCachedHtml( memberUrl ).done( function(script){
		$("#memberTab").html( script ); 
	});
	
}

function getChnlComboList(){
	$.ifvSyncPostJSON('<ifv:action name="getChnlComboList"/>', {}
	, function(result) {
		var temp = $("#selectTmp").tmpl(result.rows);
		$("#chnlCd").append(temp);
	});
}

$(document).ready(function() {
	$("#simulFormArea").ifvValidation();
	
	getChnlComboList();
	
	// 탭페이지 설정
	simulTabInit();
	
	// 회원
	$("a[href='#memberTab']").click(function(){
 		$.ifvCachedHtml( memberUrl ).done( function(script){
			$("#memberTab").empty();
			$("#purRegTab").empty();
			$("#purCnlTab").empty();
			$("#pointEarnTab").empty();
			$("#pointCnlTab").empty();
			$("#memberTab").html( script ); 
		});	 
	});
	// 구매등록
	$("a[href='#purRegTab']").click(function(){
		$.ifvCachedHtml( purRegUrl ).done( function(script){
			$("#memberTab").empty();
			$("#purRegTab").empty();
			$("#purCnlTab").empty();
			$("#pointEarnTab").empty();
			$("#pointCnlTab").empty();
			$("#purRegTab").html( script ); 
		}); 
	});
	// 구매취소
	$("a[href='#purCnlTab']").click(function(){
		$.ifvCachedHtml( purCnlUrl ).done( function(script){
			$("#memberTab").empty();
			$("#purRegTab").empty();
			$("#purCnlTab").empty();
			$("#pointEarnTab").empty();
			$("#pointCnlTab").empty();
			$("#purCnlTab").html( script );  
		});
	});
	// 포인트적립요청
	$("a[href='#pointEarnTab']").click(function(){
		$.ifvCachedHtml( pointEarnUrl ).done( function(script){
			$("#memberTab").empty();
			$("#purRegTab").empty();
			$("#purCnlTab").empty();
			$("#pointEarnTab").empty();
			$("#pointCnlTab").empty();
			$("#pointEarnTab").html( script );  
		});
	});
	// 포인트적립취소
	$("a[href='#pointCnlTab']").click(function(){
		$.ifvCachedHtml( pointCnlUrl ).done( function(script){
			$("#memberTab").empty();
			$("#purRegTab").empty();
			$("#purCnlTab").empty();
			$("#pointEarnTab").empty();
			$("#pointCnlTab").empty();
			$("#pointCnlTab").html( script );  
		});
	});
}); 

</script>

<script id="selectTmp" type="text/x-jquery-tmpl">
<option value="${'${'}chnlNo}">${'${'}chnlNm}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="M02105" />
	</h1>
</div>
<div id='simulFormArea'>
	<div class="well form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M02106" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifv:input id="chnlCd" type="select" />
				</div>
			</div>
		</div>
	</div>
</div>

<div id="simulTab"></div>	
