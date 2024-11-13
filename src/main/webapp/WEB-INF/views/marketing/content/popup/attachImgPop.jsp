<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function contentPopupCon_init(params) {
	$("#imgsrc").attr("src",params.imgPath);
}

// $(document).ready(function(){
// 	$("#imgsrc").attr("src",imagePath);
// });
</script>

<div class="pop_inner_wrap">
	<div class="img_detail_pop_wrap">
		<img id="imgsrc" alt=""/>
	</div>
</div>
