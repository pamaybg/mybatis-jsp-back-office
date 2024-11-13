<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/marketing/facebook/facebookPosting.js'></script>

<jsp:include page="/WEB-INF/views/marketing/campaign/include/campaignApprList.jsp"/>
<script type="text/javascript">

    $(document).ready(function() {
        initCampaign("MKT");
    });

</script>

<div class="page-title">
    <h1>
        <spring:message code="매장 캠페인 승인/결재"/>
        &gt; <spring:message code="조회"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignSubmitListSearchBtn" objCode="campaignSubmitListSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="campaignSubmitListSearchInitBtn" objCode="campaignSubmitListSearchInitBtn_OBJ">
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
            <button class="btn btn-sm" id='campaignSubmitBtn' objCode="campaignSubmitBtn_OBJ"><%-- 승인 --%>
                <spring:message code="M00748" />
            </button>
            <button class="btn btn-sm" id='campaignRejectBtn' objCode="campaignRejectBtn_OBJ"><%-- 반려 --%>
                <spring:message code="L01445" />
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
<div id="approvalPopup" class="popup_container"></div>
