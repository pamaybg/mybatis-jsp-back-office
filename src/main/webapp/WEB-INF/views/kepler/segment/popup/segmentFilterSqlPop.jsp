<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function segmentFilterSqlPopInit() {
    var filterSql = diagram._selectedObject.data.filterSqlCount;
    if ($.fn.ifvmIsNotEmpty(filterSql)) {
        $("#filterSql").html(filterSql);
    }
}

$(document).ready(function(){
    segmentFilterSqlPopInit();
    //닫기 클릭시
    $('#segmentFilterSqlPopCloseBtn').on('click', function(){
        filterSqlPopupClose();
    });
}); 
</script>

<div id="segmentFilterSqlPop_wrap" class="popup_container">
    <div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border">
            <div class="col-xs-12 control_content prev_textarea_wrap" id="filterSql">
            </div>
        </div>
	</div>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_lightGray2" id="segmentFilterSqlPopCloseBtn" objCode="segmentFilterSqlPopCloseBtn_OBJ">
    		<spring:message code="M01322"/>
    	</button>
    </div> 
</div>
