<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="pop_inner_wrap" id="cerOwnPopWrap">
	<div id="tabArea">
		<!-- 탭 컨텐츠 -->
		 <div>
		    <div id="tabContent" class="white_bg grid_bd0"></div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" text="L00817" btnFunc="certiOwnPopConfirm" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="certiOwnPopClose" className="btn_lightGray2"/>
</div>
<script>

var cardNum= '<%= cleanXss(request.getParameter("cardNum")) %>' ;

var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
	item: [
		{label: '<spring:message code="L00813"/>', href: '<ifvm:url name="memRegCertiByPhone"/>'}, //휴대폰 인증
		{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="memRegCertiByMypin"/>'} //마이핀인증
	]
});
</script>