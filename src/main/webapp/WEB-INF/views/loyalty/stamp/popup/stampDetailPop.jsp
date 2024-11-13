<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
.vertical-center {
	min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
	display: flex;
	align-items: center;
}
</style>

<article class="popup_wrap">
	<div class="content">
		<div class="form-horizontal underline top_well" id="uploadMemValdation">

			<div class="form_row">
			<div class="row  qt_border">
			   <ifvm:inputNew type="text" id="stampTotal" maxLength="50"  dto="stampTotal"   label="L00579" labelClass="2" conClass="2"  disabled="true"/> 
  			   <ifvm:inputNew type="text" id="popUsedStamp" maxLength="50"  dto="popUsedStamp"   label="L00580" labelClass="2" conClass="2"  disabled="true" /> 
  			   <ifvm:inputNew type="text" id="popAvlStamp" maxLength="50"  dto="popAvlStamp"   label="L00581" labelClass="2" conClass="2"  disabled="true"/> 
				</div>
			</div>
		</div>
	</div>
</article>

<div class="pop_btn_area">

	 <button class="btn btn-sm" id="closeStampDtlPop"><spring:message code="M00441"/></button>

</div>


<script>
$(function(){
	 $.ifvSyncPostJSON('<ifvm:action name="getStampDetailPop"/>', {
		  rid: testViewList_rid
		 }, function(result) {
		  if($.fn.ifvmIsNotEmpty(result)) {
			  $("#stampTotal").val(result.rows[0].stampTotal);
			  $("#popUsedStamp").val(result.rows[0].dtlUseStamp);
			  $("#popAvlStamp").val(result.rows[0].dtlAvlStamp);
		  }
		   
		    });
	
	$("#closeStampDtlPop").click(function(){
		stampDetailPop.close();		
	})
});


</script>