<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$(document).ready(function(){

});

</script>


<script id="gridTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
    </div>
</script>

<div class="page_btn_area">
    <div class="col-xs-7">
        <%-- <span><spring:message code="L01838" /></span> --%>
        <span><spring:message code="M02070" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="memberSearchBtn">
            	<spring:message code="M02071" />
        </button> 
        <button class="btn btn-sm" id="memberSearchInitBtn">
            	<spring:message code="M00278" />
        </button> 
    </div>
</div>
<div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="page_btn_area">
		    <div class="col-xs-5">
		        <%-- <span><spring:message code="L01838" /></span> --%>
		        <span><spring:message code="M02072" /></span>
		    </div>
		    <div class="col-xs-7 searchbtn_r">
		        <button class="btn btn-sm" id="memberSearchBtn">
		        	<spring:message code="M02073" />
		        </button> 
		    </div>
		</div>
		<div class="form-horizontal">
	    	<div class="row qt_border"></div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00232" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" required="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span>구매 금액</label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" required="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><spring:message code="M02074" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M02075" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" required="true"/>
		        </div>
		    </div>
	    </div>
	</div>
	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-5">
			    <span><spring:message code="M02076" /></span>
			    
			</div>
		    <div class="col-xs-7 searchbtn_r">
		     	<button class="btn btn-sm" id="memberSearchBtn">
		        	<spring:message code="M02077" />
		        </button> 
		    </div>
		</div>
	    <div class="form-horizontal">
	    	<div class="row qt_border"></div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00850" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" required="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00343" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00342" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="text" id="bnftCreateBy" required="true" />
		        </div>
		    </div>
	    	<div class="row qt_border">
		        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L00180" /></label>
		        <div class="col-xs-8 control_content">
		            <ifvm:input type="select" id="bnftCreateBy" disabled="true" />
		        </div>
		    </div>
	    </div>
	</div>
</div>