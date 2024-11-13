<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//용량 부분 콤마 생성
$.fn.comma = function(cellValue, options, rowdata) {
    var str = "";
    if (typeof (rowdata.maxVol) != "undefined") {
        str = String(rowdata.maxVol);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    else {
        return str;
    }
}

</script>