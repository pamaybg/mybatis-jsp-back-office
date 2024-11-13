<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="mbrPntArclYnDiv">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="beforePntAcrlYn"   dto="beforePntAcrlYn" 
					label="변경 전" labelClass="2" conClass="4"  disabled="true"/>
				<ifvm:inputNew type="text" id="afterPntAcrlYn"   dto="afterPntAcrlYn" 
					label="변경 후" labelClass="2" conClass="4" disabled="true"/>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="chngeResn"   dto="chngeResn"    required="true"
					label="사유" labelClass="2" conClass="10" maxLength="20"  /><!-- 사유-->
				
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="save" text="L00817" btnFunc="saveFn" className="btn btn-sm btn_gray" objCode="save_OBJ"/>
    <ifvm:inputNew type="button" id="close" text="L00073" btnFunc="closeFn" className="btn btn-sm btn_gray" objCode="close_OBJ"/>
</div>

<script type="text/javascript">
var afterPntAcrlYnVal =null;
var beforePntAcrlYnVal =null;
$(document).ready(function() {
	
	$("#beforePntAcrlYn").val(pntAcrlYn);
	
	if(pntAcrlYn=="가능"){
		$("#afterPntAcrlYn").val("불가능");	
		beforePntAcrlYnVal ="Y";
		afterPntAcrlYnVal ="N";
		
	}else if(pntAcrlYn=="불가능"){
		$("#afterPntAcrlYn").val("가능");		
		afterPntAcrlYnVal ="Y";
		beforePntAcrlYnVal ="N";


	}
});	

function saveFn(){
	baseValidation = $("#mbrPntArclYnDiv").ifvValidation();
	if (baseValidation.confirm()) {
 		if(confirm('<spring:message code="변경하시겠습니까?"/>')){ 
		$.ifvSyncPostJSON('<ifvm:action name="updatePntYn"/>',{
			beforePntAcrlYnVal : beforePntAcrlYnVal,
			afterPntAcrlYnVal : afterPntAcrlYnVal,
			rid 					: mbr_rid,
			pntResn 			: $("#chngeResn").val()
	},
	function(result) {
		
		if(result.message=="Y"){
			$("#chngAcrlYn")[0].innerHTML="적립 가능";
			pntAcrlYn="가능";
		}else if(result.message=="N"){
			$("#chngAcrlYn")[0].innerHTML="적립 불가";
			pntAcrlYn="불가능";
		}
		
		chngAcrlYnFnClose();
		alert("변경되었습니다.");
	
	
	});
	 }
	}
}
function closeFn(){
	chngAcrlYnFnClose();
}
</script>