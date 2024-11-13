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
var certiCase = '<%= cleanXss(request.getParameter("certiCase")) %>';
var cardNo  ='<%= cleanXss(request.getParameter("cardNo")) %>';
var mypin = null;
//본인인증 케이스
//001 가입인증
//002 개명인증
//003 간편회원가입
//004 소프트폰 마이핀
//팝업호출시 실행되는 함수
function certiPopup_init(obj){
	switch(certiCase){
	 	case "001" :
	 		var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
	 			item: [
	 				{label: '<spring:message code="L00813"/>', href: '<ifvm:url name="certiByPhone"/>'}, //휴대폰 인증
	 				{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="certiByMypin"/>'} //마이핀인증
	 			]
	 		});
			break;
		case "002" :
			var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
				item: [
					{label: '<spring:message code="L00813"/>', href: '<ifvm:url name="certiByPhone"/>'}, //휴대폰 인증
					{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="certiByMypin"/>'} //마이핀인증
				]
			});
			break;
		case "003" :
			var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
				item: [
					{label: '<spring:message code="L00813"/>', href: '<ifvm:url name="certiByPhone"/>'}, //휴대폰 인증
					{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="certiByMypin"/>'} //마이핀인증
				]
			});
			break;
		case "004" :
			mypin = obj.spMypinNum;
			var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
				item: [
					{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="certiByMypin"/>'} //마이핀인증
				]
			});

			break;
		default:
			var testTab = $('#cerOwnPopWrap #tabArea').DrawTab({
				item: [
					{label: '<spring:message code="L00813"/>', href: '<ifvm:url name="certiByPhone"/>'}, //휴대폰 인증
					{label: '<spring:message code="L00814"/>', href: '<ifvm:url name="certiByMypin"/>'} //마이핀인증
				]
			});

			break;
	}
}
function certiOwnPopClose(){
	if(typeof(certiOwn) != "undefined"){
		certiOwn.close();
	}else if(typeof(certiOwnForSp) != "undefined"){
		certiOwnForSp.close();
	}

}



</script>