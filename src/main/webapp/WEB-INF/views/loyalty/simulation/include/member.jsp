<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var memUrl 		= '${pageContext.request.contextPath}/loyalty/simulation/include/memList';	    //회원
var pointUrl 	= '${pageContext.request.contextPath}/loyalty/simulation/include/pointList';		//구매등록

var memNm;
var hhpNo;
var cardNo;


/* 팝업 닫기 */
function memPopupClose(){
	memPopupDialog._destroy();
}
/* 팝업 닫기 */
function prodPopupClose(){
	memPopupDialog._destroy();
}
/* 팝업 닫기 */
function memSearchPopupClose(){
	memPopupDialog._destroy();
}


//탭 페이지
function memTabInit(){
	// 탭 설정
	$("#memberTab").ifvsfTab({
		 tabId : [ "memListTab"
			      ,"pointTab"
			      ]
		,msgCode : [ '<spring:message code="M01749"/>'
					,'<spring:message code="M02057" />'
					]
	});
	
	$.ifvCachedHtml( memUrl ).done( function(script){
		$("#memListTab").html( script ); 
	});
	
}

$(document).ready(function(){
	memTabInit();
	
	// 회원
	$("a[href='#memListTab']").click(function(){
 		$.ifvCachedHtml( memUrl ).done( function(script){
			$("#memListTab").empty();
			$("#pointTab").empty();
			$("#memListTab").html( script ); 
		});	 
	});
	// 포인트 이력
	$("a[href='#pointTab']").click(function(){
		$.ifvCachedHtml( pointUrl ).done( function(script){
			$("#memListTab").empty();
			$("#pointTab").empty();
			$("#pointTab").html( script ); 
		}); 
	});
	
	$("#memberSearchBtn").on('click',function(){
		
	});
	
	$("#memberSearchInitBtn").on('click',function(){
		
	});
	
	$("#memberNewBtn").on('click',function(){
		$("#memPopupDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="memPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M02058" />', 
	        width: '800px',
	        close : 'memPopupClose'
	    });
	});
	
	$("#memSearchBtn").on('click',function(){
		$("#memPopupDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="memSearchPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M02059" />', 
	        width: '800px',
	        close : 'memSearchPopupClose'
	    });
	});
	
	$("#prodSearchBtn").on('click',function(){
		$("#memPopupDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="prodPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M02060" />',
	        width: '700px',
	        close : 'prodPopupClose'
	    });
	});
	
});

</script>


<div class="page_btn_area">
    <div class="col-xs-7">
        <%-- <span><spring:message code="L01838" /></span> --%>
        <span><spring:message code="M02059" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="memberNewBtn">
            	<spring:message code="M02061" />
        </button> 
        <button class="btn btn-sm" id="memSearchBtn">
            	<spring:message code="M02059" />
        </button> 
        <button class="btn btn-sm" id="prodSearchBtn">
            	<spring:message code="M00364" />
        </button> 
        <button class="btn btn-sm" id="memberSearchBtn"><i class="fa fa-search"></i>
            <spring:message code="M00135" />
        </button> 
        <button class="btn btn-sm" id="memberSearchInitBtn">
            <spring:message code="M00278" />
        </button> 
    </div>
</div>
<div class="well form-horizontal" >
	<div class="row">
		<label class="col-sm-2 control-label"><spring:message code="M00850" /></label>
		<div class="col-sm-2 control_content">
			<div class="input-group">
			<ifvm:input type="text"  id="memNm" />
			</div>
		</div>
		<label class="col-sm-2 control-label"><spring:message code="L00436" /></label>
		<div class="col-sm-2 control_content">
			<div class="input-group" >
			<ifvm:input type="text"  id="hhpNo" />
			</div>
		</div>
		<label class="col-sm-2 control-label"><spring:message code="M01753" /></label>
		<div class="col-sm-2 control_content">
			<div class="input-group" >
			<ifvm:input type="text"  id="cardNo" />
			</div>
		</div>
	</div>
</div>
<div class="page_btn_area" >
    <div class="col-xs-7">
        <span><spring:message code="M01805" /></span>
    </div>
</div>
<div class="row qt_border"></div>
<div id="memberTab"></div>
<div id="memPopupDialog" class="popup_container"></div><!-- 팝업 -->
