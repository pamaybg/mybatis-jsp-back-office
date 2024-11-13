<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="dataSetItemForm">
<br>
	<div class="row qt_border">
			<ifvm:inputNew type="text" id="fieldNm" names="fieldNm" label="필드명" labelClass="3" conClass="5" required="true"/>	
	</div>
	

	<div class="row qt_border">
			<ifvm:inputNew type="text" id="fieldDesc" names="fieldDesc" label="필드설명" labelClass="3" conClass="5" required="true"/>	
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="saveDataSetItem">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L02251"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="dataSetItemClose">
		<spring:message code="L01781"/>
	</button>
</div>

<script>
function tierBnftInit(){
	if(typeof dataSetItemRid === 'undefined' || dataSetItemRid == null){
		dataSetItem_isNew = true;
	}
	else {
		dataSetItem_isNew = false;
		getDataSetItem();
	}
}

function getTierBnft() {
	$.ifvSyncPostJSON('<ifvm:action name="getDataSetItemDetail"/>',{
		rid  : dataSetItemRid
	},function(result) {
		$("#dataSetItemForm").dataSetting(result);
	});
}

function saveDataSetItem() {
	var validation = $("#dataSetItemForm").ifvValidation();
	
	//유효성 체크
	if(validation.confirm()){
		var url = dataSet_isNew? '<ifvm:action name="saveDataSetItem"/>' : '<ifvm:action name="modifyDataSetItem"/>';
		var varData = null;
		varData = $("#dataSetItemForm").getSubmitData();
		varData.rid = dataSetItemRid;

		$.ifvSyncPostJSON(url, varData
		, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				alert("<spring:message code="C00094" />");
			}
		}, function(result) {
			alert("<spring:message code="M02248" />");
		});
		addDataSetItemClose();
		dataSetItemGrid._doAjax();
		dataSetItem_isNew = false;
	 }
}

$(document).ready(function() {
	dataSetItemInit();	
	
	//닫기
	$("#dataSetItemClose").on("click",function(){
		addDataSetItemClose();
	});
	
	$("#saveDataSetItem").click(function(){
		saveDataSetItem();
	});
	

});

</script>

