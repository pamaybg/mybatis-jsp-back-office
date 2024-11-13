<%@page trimDirectiveWhitespaces="true" %>
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
<script>




    $(document).ready(function() {
        $('#description').val(rejectRsn)

        setTimeout(function () {
            idCheck()
        }, 100)
    });
</script>



<div id="capacityWrap">
    <div class="pop_inner_wrap form-horizontal">
        <div class="row">
            <label class="col-xs-3 control-label"><spring:message code="M00979"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="textarea" maxLength="1000" className="text_description text_description_150" id="description" disabled="true"/>
            </div>
        </div>
    </div>
    <div class="pop_btn_area">
    </div>
</div>