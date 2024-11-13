<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var uploadErrorList;

// 업로드 오류내역 조회
function uploadErrorList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.id = excelResultId;
			},
		    url:'<ifvm:action name="getUploadErrorList"/>',
		    colNames:[
		              '<spring:message code="M00519"/>',
		              '<spring:message code="M01766"/>',
		              ],
		    colModel:[{name:'tblNm', index:'tbl_nm', width: 180},
		              {name:'errorDesc', index:'error_desc', resizable : false}, 
				      ],  
			sortname: 'seq_index',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
	uploadErrorList = $("#uploadErrorList").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function() {
	uploadErrorList();

	$("#btnColcan").on('click', function(){
		upErrorPopClose();
	});
});
</script>

<div id='dbInformPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="uploadErrorList" class="white_bg grid_bd0"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnColcan">         
		<spring:message code="M00105" />
    </button> 
</div>
