<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="mbrPntRdmYnDiv">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="beforePntRdmYn"   dto="beforePntRdmYn" 
					label="변경 전" labelClass="2" conClass="4"  disabled="true"/>
				<ifvm:inputNew type="text" id="afterPntRdmYn"   dto="afterPntRdmYn" 
					label="변경 후" labelClass="2" conClass="4" disabled="true"/>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="chngeResn"   dto="chngeResn"  required="true"
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
var afterPntRdmYnVal =null;
var beforePntRdmYnVal =null;
$(document).ready(function() {
	
	$("#beforePntRdmYn").val(pntRdmYn);
	
	if(pntRdmYn=="가능"){
		$("#afterPntRdmYn").val("불가능");	
		afterPntRdmYnVal ="N";
		beforePntRdmYnVal ="Y";
	}else if(pntRdmYn=="불가능"){
		$("#afterPntRdmYn").val("가능");		
		afterPntRdmYnVal ="Y";
		beforePntRdmYnVal="N";
	}
});	

function saveFn(){

	baseValidation = $("#mbrPntRdmYnDiv").ifvValidation();
	
	if (baseValidation.confirm()) {
	 	if(confirm('<spring:message code="변경하시겠습니까?"/>')){ 
			$.ifvSyncPostJSON('<ifvm:action name="updateRdmPntYn"/>',{
				beforePntRdmYnVal : beforePntRdmYnVal,
				afterPntRdmYnVal : afterPntRdmYnVal,
				rid 					 : mbr_rid,
				pntResn 			 : $("#chngeResn").val()
			},
			function(result) {
				
				if(result.message=="Y"){
					$("#chngPntRdmYn")[0].innerHTML="사용 가능";
					pntRdmYn = "가능";
				}else if(result.message=="N"){
					$("#chngPntRdmYn")[0].innerHTML="사용 불가";
					pntRdmYn = "불가능";
				}				
				
				chngPntRdmYnFnClose();
				alert("변경되었습니다.");
			
			});
	 	}	
	}
}
function closeFn(){
	chngPntRdmYnFnClose();
}
</script>