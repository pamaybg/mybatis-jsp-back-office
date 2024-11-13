<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/marketing/facebook/facebookPosting.js'></script>

<jsp:include page="/WEB-INF/views/loyalty/campaign/include/campaignListScriptNew.jsp"/>
<script type="text/javascript">

$(document).ready(function() {
    $.ifvmLnbSetting('loyCampaignList');
    initCampaign('LOY');
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
	프로모션 조회 및 등록 &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00739" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn">
            	<i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="campaignListSearchInitBtn">
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
            <button class="btn btn-sm" id="campaignNewBtn"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id='campaignRemoveBtn'><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='campaignStopBtn'><%-- 중지 --%>
                <spring:message code="M02154" />
            </button>
            <%-- <button class="btn btn-sm" id='campaignCompletedBtn'>실행
                <spring:message code="M00751" />
            </button> --%>
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