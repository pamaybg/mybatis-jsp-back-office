<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 
<script type="text/javascript">

getpramInfoFrom = {
		init : function(){
			
		}
}


$(document).ready(function(){
	getpramInfoFrom.init();
	
});
</script>

<div id="ifParmList">
    <div class="pop_inner_wrap form-horizontal" id="ifBatchListPop" >
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q00004" /></span> <!-- 기본 정보 -->
			</div>
		</div>       
        <div class="row qt_border">
			<ifvm:inputNew type="text" id="" dto="" label="Q02884" labelClass="2" conClass="4" /> <!-- 배치이름  -->
        	<ifvm:inputNew type="text" id="" dto="" label="Q02885" labelClass="2" conClass="4" /> <!-- 배치유형 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="text" id="" dto="" label="Q02886" labelClass="2" conClass="4" /> <!-- 분할 업데이트 테이블 -->
        	<ifvm:inputNew type="text" id="" dto="" label="Q02878" labelClass="2" conClass="4" /> <!--EIM테이블 -->
        </div>
        <div class="row qt_border">
        	<ifvm:inputNew type="text" id="" dto="" label="Q02887" labelClass="2" conClass="4" /> <!--EIM 시작번호 -->
        	<ifvm:inputNew type="text" id="" dto="" label="Q02889" labelClass="2" conClass="4" /> <!-- EIM 작업 갯수 -->
        </div>
		<div class="row qt_border">
        	<ifvm:inputNew type="text" id="" dto="" label="Q02888" labelClass="2" conClass="4" /> <!--실행순서 -->
        	<ifvm:inputNew type="text" id="" dto="" label="Q02890" labelClass="2" conClass="4" /> <!--Class 경로 -->
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="singleCheckbox" id="useYn" dto="useYn" label="Q02882" labelClass="2" conClass="4" /> <!-- 활성 여부 -->
        </div>
  
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="childOfferAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="childOfferDtlPopCloseBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>