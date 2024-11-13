<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/marketing/plan/include/planListPopScript.jsp"/>

<script>
/*
 * 마케팅 플랜 디테일 팝업 화면 
 * 
 * @date 2020. 06. 11.
 * @author LEE GYEONG YOUNG
 * 
 */
//시작 함수 호출
$(document).ready(function() {
	InitPlan("MKT");
});

</script>
<!-- 마케팅 플랜 화면과 동일 -->
<div>
	<div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
          <button class="btn btn-sm" id='planListSearchBtn'>
              <spring:message code="M00273"/>
          </button>
          <button class="btn btn-sm" id='planListSearchInitBtn'>
              <spring:message code="M00311"/>
          </button>
        </div>
     </div>   
     <div class="well form-horizontal well_bt5" id="planSearchList"></div>
</div>

<div>
     <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
     </div>
     <div id="planListGrid" class="white_bg grid_bd0"></div> 
</div>
<!-- End -->
<div id="contsListPopWrap">
    <div class="pop_btn_area">
    	<!-- 선택 -->
        <button class="btn btn-sm btn_gray" id="selectBtn">
            <spring:message code="M00282"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>

<style>
.well{padding-bottom:5px;}
</style>

<div class="well">
    <ol class="plan_order">
    </ol>
</div>