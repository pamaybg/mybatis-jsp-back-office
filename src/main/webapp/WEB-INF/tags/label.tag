<%@ tag body-content="empty" pageEncoding="UTF-8"  description="유효성 검사 Input 태그"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="targetId" required="true" type="java.lang.String" %>
<c:set var="targetIdValue" value="${targetId}"/>

<div class="error_box">
	<label class="error" id="${targetId}Error" for="${targetId}" generated="true" style="display:none;font-size:11px; color:#e7130b;"></label>
	<label class="ok_txt" id="${targetId}Success" for="${targetId}" generated="true" style="display:none;"></label>
</div>
