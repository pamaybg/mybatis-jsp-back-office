<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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
<div>
	<img width="100%" id="imgView" src="" controls="controls"/>
</div>

<script>

$(document).ready(function(){
	var ipath = '<%= cleanXss(request.getParameter("path")) %>';
	$("#imgView").attr('src',ipath);
});
</script>