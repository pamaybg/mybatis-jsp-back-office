<%@ page trimDirectiveWhitespaces="true" %>
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
<script type="text/javascript">

var prodSpecFrom = {
	init : function(){
		var prodSpecRid = '<%= cleanXss(request.getParameter("prodSpecRid")) %>';
		
		//스펙 유형 - 공통코드를 사용하고 있지않다(존재하지 않음)
		$.fn.ifvmSetSelectOptionCommCode( "specType", "LOY_PROD_SPEC", null, null, true );
		
		//생성 팝업 
		if(prodSpecRid == 'null'){
			$("#ridProd").val(rid);
		} else {
			$("#prodSpecDtl").dataSetting(prodSpecData);
		}
	}
}


$(document).ready(function(){
	prodSpecFrom.init();
	//선택
	$("#saveProdSpecBtn").on("click", function(){
		
		var validation = $("#prodSpecDtl").ifvValidation();
		if( validation.confirm() == false ) return;		// 유효성 검사
		var obj = $('#prodSpecDtl').getSubmitData();	// 입력된 값을 obj에 저장
		$.ifvSyncPostJSON('<ifvm:action name="saveProdSpec"/>', obj
		, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				alert('<spring:message code="O00069" />'); // 저장되었습니다.
				prodSpecInit();
				popupContainer._destroy();
			}
		}, function(result) {
			alert(result.message);
		});
		
	});
	
	//취소
	$("#cancelProdSpecBtn").on("click", function(){
		popupContainer._destroy();
	});
	
});
</script>

<div id="ifParmList">
    <div class="pop_inner_wrap" id="prodSpecDtl" >
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q00004" /></span> <!-- 기본 정보 -->
			</div>
		</div>       
        <div class="row">
        	<ifvm:inputNew type="hidden" id="prodSpecRid" dto="prodSpecRid" />
        	<ifvm:inputNew type="hidden" id="ridProd" dto="ridProd" />
        	<ifvm:inputNew type="select" id="specType" names="specType" dto="specType" label="E00091" labelClass="3" conClass="6" required="true" /> <!-- 유형 -->
        </div>
        <div class="row">
        	<ifvm:inputNew type="text" id="specTypeVal" dto="specTypeVal" label="E00092" labelClass="3" conClass="6" required="true" /> <!-- 순서 -->
        </div>
    </div>
    <br>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="saveProdSpecBtn" objCode="prodSpecPopSaveProdSpecBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="cancelProdSpecBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>