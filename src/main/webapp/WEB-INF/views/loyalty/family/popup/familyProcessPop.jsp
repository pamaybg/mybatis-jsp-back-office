<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline" id="canlDetailForm">
<br>
	<div class="row ">
		<ifvm:inputNew type="select" id="statCd" names="statCd" label="M00147" labelClass="2" conClass="8" disabled="true" required="true"/>
	</div>
	<div class="row ">
		<ifvm:inputNew type="textarea" id="canlRsnDesc" names="canlRsnDesc" label="M00324" labelClass="2" conClass="8" rows="3" required="true" maxLength="200"/>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveProcess" objCode="familyProcessSave_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancelPrcsBtn" objCode="familyProcessCancel_OBJ">
		<spring:message code="M01856" />
	</button>
</div>

<script type="text/javascript">
var validation;

function saveCanlProcs(){
	validation = $("#canlDetailForm").ifvValidation();
	var c_rid =[];
	
	if(validation.confirm()){
		var checkedList = familyList.opt.gridControl.getSelectedRecords();
		if (checkedList.length == 0) {
			alert('<spring:message code="I02051"/>');
		}else{
			for(var i = 0; i < checkedList.length; i++){
				c_rid.push(checkedList[i].rid);
			}
		}
		if (c_rid.length>0) {
		    $.ifvSyncPostJSON('<ifvm:action name="saveCanlProcess"/>', {
		    	ridList : c_rid,
		    	statCd : $("#statCd").val(),
		    	canlRsnDesc : $("#canlRsnDesc").val()
		    }, function(result) {
		    	alert('<spring:message code="처리되었습니다."/>');
		    	familyPrcsPopupContainer._destroy();
		    	familyList._doAjax();
		    });
		}
	}
}

$(document).ready(function(){

	$.fn.ifvmSetSelectOptionCommCode("statCd", "LOY_FAML_STAT_CD", 03, null, true);
	
	$("#saveProcess").click(function(){
		saveCanlProcs();
	});
	
	$("#cancelPrcsBtn").click(function(){
		familyPrcsPopupContainer._destroy();
	});
	
});
</script>