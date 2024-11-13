<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">


function calPoint() {
		alert("1111");
	$.ifvSyncPostJSON('<ifvm:action name="calRealPoint"/>', {
		
	}, function(result) {
		
	});
}





$(document).ready(function() {
	calPoint();
    

    
 
});

</script>


산출혜택...