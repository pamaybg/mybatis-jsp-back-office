<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal">
	<div class="row">
		<ifvm:inputNew className="dfdfdf" type="monthTerm" startDto="termStartMonth" endDto="termEndMonth" startId="termStartMonth" endId="termEndMonth" required="true"
 label="aaaasdfd" labelClass="2" conClass="9" desc="asdfasdf" nuc="true"/>
	</div>
</div>
<script>
function setMonthCalendar() {
	var termStartMonth = $('#termStartMonth');
	var termEndMonth = $('#termEndMonth');
	
	termStartMonth.ifvMonthChecker({
		maxMonth: termEndMonth 
	});
	
	termEndMonth.ifvMonthChecker({
		minMonth: termStartMonth
	});

	//이번달
	termStartMonth.val($.ifvGetNewDate('m', 0).monthType);
	//이번달부터 한달 뒤
	termEndMonth.val($.ifvGetNewDate('m', +1).monthType);
/* 	$('.dfdfdf').ifvMonthChecker({
		dateFormat : "yymm"
	}); */
}

	$(document).ready(function() {
		setMonthCalendar();
	});
</script>