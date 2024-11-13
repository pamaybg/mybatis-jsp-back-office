<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/views/marketing/plan/include/planListScript.jsp"/>
<script type="text/javascript">
/*
 * 마케팅 플랜 리스트 화면 
 * 
 * @date 2020. 06. 11.
 * @author LEE GYEONG YOUNG
 * 
 */
	$(document).ready(function() {
    	InitPlan("MKT");
	});
</script>
<!-- 타이틀 제목 -->
<div class="page-title">
    <h1>
        <spring:message code="M02290"/> &gt;  <spring:message code="M00273"/>
    </h1>
</div>
<div>
	<div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        <!-- 조회버튼 -->
          <button class="btn btn-sm" id='planListSearchBtn'>
              <spring:message code="M00273"/>
          </button>
          <!-- 초기화버튼 -->
          <button class="btn btn-sm" id='planListSearchInitBtn'>
              <spring:message code="M00311"/>
          </button>
        </div>
     </div>
     <!-- 조회 박스 -->   
     <div class="well form-horizontal well_bt5" id="planSearchList""></div>
</div>

<div>
     <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="planNewBtn" objCode="planNewBtn_OBJ"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>

            <button class="btn btn-sm" id='planRemoveBtn' objCode="planRemoveBtn_OBJ"><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id="planExcelExportBtn" objCode="planExcelExportBtn_OBJ">
                <spring:message code="M00838" /><%-- 다운로드 --%>
            </button>
        </div>
     </div>
     <!-- 그리드 -->
     <div id="planListGrid" class="white_bg grid_bd0"></div> 
</div>



<style>
.well{padding-bottom:5px;}
</style>

<div class="well">
    <ol class="plan_order">
    </ol>
</div>

