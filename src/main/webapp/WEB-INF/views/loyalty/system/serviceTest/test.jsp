<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>

Hi Lee.

<script>

$.ajax({
	url: "https://oneclickapi.neimsdev.eland.co.kr:8443/crmapi/memberInfoApi",
	type: "POST",
	cache: false, 
	dataType: "json",
	contentType : "application/json; charset=utf-8",
	data: $.toJSON({ "List": [{ "PBP_ID": "7014560793" }] }),
	success: function(data) {
		console.log(data);
	},
});

</script>
