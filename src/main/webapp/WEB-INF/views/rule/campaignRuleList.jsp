<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/marketing/facebook/facebookPosting.js'></script>

<jsp:include page="/WEB-INF/views/rule/include/campaignListScriptNew.jsp"/>
<script type="text/javascript">

$(document).ready(function() {
    initCampaign("RUL");
    
	$("#ruleDemoPopBtn").click(function() {
		var url = '/demo/koreanair/winpopup/ruleDemoPop';
		window.open(url, 'ruleDemoPop', 'width=400, height=700, menubar=no, status=no, toolbar=no');
	});
});

</script>

<script id="campaignStatusTemp" type="text/x-jquery-tmpl">
<li class="campaign_circle ${'${'}dataInTypeClass}" >
    <div class="circle_area" taskTypeCode="${'${'}taskTypeCode}">
        <span>${'${'}nodeTypeCodeName}</span>
    </div>
    <p class="campaign_title">${'${'}text}</p>
    <p class="complete_date">${'${'}enterTime}</p>
</li>
</script>

<script id="campaignStatusStartTemp" type="text/x-jquery-templ">
<li class="btn_edge first">
    <i class="start"></i>
    <span><spring:message code="M00742" /></span>
</li>
</script>

<script id="campaignStatusEndTemp" type="text/x-jquery-templ">
<li class="btn_edge">
    <i class="end"></i>
    <span><spring:message code="M00750" /></span>
</li>
</script>

<div class="page-title">
    <h1>
        Rule 관리
        <span>&gt; <spring:message code="M00273" /></span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn" objCode="campaignListSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="campaignListSearchInitBtn" objCode="campaignListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="campaignSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray"  id="ruleDemoPopBtn" objCode="">
				Rule 실행
			</button> 
            <button class="btn btn-sm" id="campaignNewBtn" objCode="campaignNewBtn_OBJ"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <%-- <button class="btn btn-sm" id='campaignCopyBtn'>복사
                <spring:message code="M02307" />
            </button> --%>
            <button class="btn btn-sm" id='campaignRemoveBtn' objCode="campaignRemoveBtn_OBJ"><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='campaignStopBtn' objCode="campaignStopBtn_OBJ"><%-- 중지 --%>
                <spring:message code="M02154" />
            </button>
            <button class="btn btn-sm" id='campaignCompletedBtn' objCode="campaignCompletedBtn_OBJ"><%-- 실행 --%>
                <spring:message code="M00751" />
            </button>
        </div>
    </div>
    <div id="campaignListGrid" class="white_bg grid_bd0"></div>
</div>

<div class="well">
    <ol class="campaign_order">
    </ol>
</div>

<div id="dialog" class="popup_container"></div>
<div id="dialogTempPop"></div>