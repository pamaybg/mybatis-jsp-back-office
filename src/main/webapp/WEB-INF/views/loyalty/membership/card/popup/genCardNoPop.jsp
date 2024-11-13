<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function getBin() {
    var binFieldValue = $("#binNoRule").val();
    return binFieldValue;
}

function genBtn(){
	var validation = $("#genCardNoPop").ifvValidation();

	if(validation.confirm()){
		var obj = {
			ridCardKind : ifvGlobal.cardTypeRid
			, title : $("#title").val()
			, cnt : $("#cnt").val()
			, bin : getBin()
		};

		$.ifvPostJSON('<ifvm:action name="genCardNo"/>',obj
		,function(result) {
			alert('<spring:message code="M02966"/>');
			$.ifvProgressControl(false);
			getcardNoPoolListInit();
			cancelBtn();
		}
		,function(result) {
			alert('카드번호 생성에 실패하였습니다.');
			$.ifvProgressControl(false);
		}
		);
	}
} 

function cancelBtn() {
	$.fn.ifvmPopupClose();
}

</script>


<div id='genCardNoPop'>
	<div class="pop_inner_wrap form-horizontal">
        <div class="row">
            <ifvm:inputNew type="text" id="title" label="L01431" labelClass="2" conClass="10" required="true"/>
        </div>
	    <div class="row">
	        <ifvm:inputNew type="number" id="cnt" label="M02965" labelClass="2" conClass="10" required="true"/>
	    </div>
	    
	</div>
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="genBtn" btnFunc="genBtn" text="M01575" objCode="addCardBinBtn_obj"/>
	<ifvm:inputNew type="button" id="cancelBtn" btnFunc="cancelBtn" btnType="cancel" text="M00284" objCode="cancelCardBinBtn_obj"/>  
</div>

<div id="cardBinListPopup" class="popup_container"></div>
