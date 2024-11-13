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
<div class="page-title">
	<h1>
		<spring:message code="고객" />
		&gt; <spring:message code="Cafe24 회원" />
		&gt; <spring:message code="캠페인 이력" />
	</h1>
</div>
<div class = well>
	<div class="page_btn_area" id="headForm">
		<div class="col-xs-2">
			<span><spring:message code="회원 상세"/></span>
		</div>
		<div class="col-xs-10 searchbtn_r">
			<ifvm:inputNew type="button" id = "btnListCafe24" btnFunc="btnListCafe24" text="목록" />
		</div>
	</div>
	<div class="row">
		<div class="half_wrap top_well">
			
			<div class="row">
				<ifvm:inputNew type="text" id="name" dto="name" label="이름" title="이름" labelClass="1" conClass="2" disabled="true" />
				<ifvm:inputNew type="text" id="userId" dto="userId" label="사용자ID" title="사용자ID" labelClass="1" conClass="2" disabled="true" />
				<ifvm:inputNew type="text" id="cellPh" dto="cellPh" label="휴대전화번호" title="휴대전화번호" labelClass="1" conClass="2" disabled="true" />
				<ifvm:inputNew type="text" id="email" dto="email" label="EMAIL" title="이메일" labelClass="1" conClass="2" disabled="true" />
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="mall" dto="mall" label="가입몰" title="가입몰" labelClass="1" conClass="2" disabled="true" />
				<ifvm:inputNew type="text" id="regDate" dto="regDate" label="가입일자" title="가입일자" labelClass="1" conClass="2" disabled="true" />
				<ifvm:inputNew type="singleCheckbox" id="smsYn" dto="smsYn" label="SMS수신" title="SMS수신" labelClass="1" conClass="1" disabled="true" />
				<ifvm:inputNew type="singleCheckbox" id="emailYn" dto="emailYn" label="EMAIL수신" title="EMAIL수신" labelClass="1" conClass="1" disabled="true" />
			</div>
		</div>
	</div>
</div>
<div id="cafe24MbrDetailTabArea"></div>

<script type = "text/javascript">
var rid = '<%= cleanXss(request.getParameter("rid")) %>';

function setMbrInfo(){
	$.ifvSyncPostJSON('<ifvm:action name="getCafe24MemDetail"/>', {
		rid : rid
	},
	function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					$("#name").val(result.name);
					$("#cellPh").val(result.cellPh);
					$("#email").val(result.email);
					$("#regDate").val(result.regDate);
					$("#mall").val(result.mallNm);
					$("#userId").val(result.userId);
					
					
					result.smsYn == "Y" ? $("#smsYn").prop('checked',true) :$("#smsYn").prop('checked',false);
					result.emailYn == "Y" ? $("#emailYn").prop('checked',true) :$("#emailYn").prop('checked',false);
				}
			});
}


var cafe24MbrDetailTabArea = $('#cafe24MbrDetailTabArea').DrawTab({
	item : [
		{	label : '<spring:message code="L00420"/>', href : '<ifvm:url name="cafe24CamHist"/>'}
	]
}); 

$(document).ready(function() {
	setMbrInfo();
	
   $("#btnListCafe24").click(function () {
	    qtjs.href('<ifvm:url name="cafe24MemList"/>');
   });
   
});


</script>