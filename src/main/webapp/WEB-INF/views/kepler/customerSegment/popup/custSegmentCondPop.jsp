<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//세그먼트 새로고침
function setSegmentCond() {

    $.ifvProgressControl(true);
    
    $.ifvPostJSON('<ifvm:action name="setSegmentCond"/>', {
    	tgtGroupId: tgtGroupId
    }
    , function(result) {
	  
       $("#dpCond").val(result.dpCond);
        $.ifvProgressControl(false);
    }
 	, function(result) {
 	    $.ifvProgressControl(false);

    });
}

$(document).ready(function() {
	setSegmentCond(); 
	
    $("#btnCancel").click(function () {
		$.fn.ifvmPopupClose();
    }.bind(this));

});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="segmentNewPop" >
	
     
        <div class="row qt_border">
            <div class="col-xs-12 control_content">
                <ifvm:input type="text" required="true" maxLength="9" id="dpCond"  disabled="true"/>
            </div>
        </div>
        
        </div>
         <div class="pop_btn_area">
  		<button class="btn btn-sm btn_gray" id="btnCancel">     
    		<spring:message code="M01322"/>
    	</button>
    </div> 
     </div>