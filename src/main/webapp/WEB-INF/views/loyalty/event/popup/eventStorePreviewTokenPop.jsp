<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

// 이벤트 미리보기 토큰 조회
function getEventPreviewToken(){
	var validation = $("#eventPreviewTokenPopFormArea").ifvValidation();
	
	if (validation.confirm()) {
		var data = $("#eventPreviewTokenPopFormArea").getSubmitData();
		
		$.ifvSyncPostJSON('<ifvm:action name="getEventStorePreviewToken"/>', data
		, function(result) {
			var url = result.url + "?key=" + result.token;
			
			$("#url").val(url);	
		});
	};
}

// url 열기
function eventPreviewOpen() {
    var url = $("#url").val();
    
    if (url != "") {
    	var newWindow = window.open("about:blank");
    	newWindow.location.href = url;
    } else {
    	alert("토큰을 생성 하세요.");
    }
}


$(document).ready(function(){

});
</script>

<div id='eventPreviewTokenPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
			<ifvm:inputNew type="text" id="foUserId" dto="foUserId" label="사용자 ID" labelClass="2" conClass="7" required="true" nuc="true"/>
	    </div>
	    <div class="row">
	    	<div class="col-xs-12 control_content" style="padding-left:30px; color:red;">
		    	<li >gloShop 이벤트 미리보기를 위한 glolive 로그인 이메일을 입력하여 주세요.</li>
		    	<li >미리보기 URL을 열기전에 glolive 로그인을 먼저 해주세요.</li>
		    	<li >토큰 생성 후 유효시간은 30분입니다.</li>
		    	<li >gloShop 미리보기 화면에서 벗어나고 싶다면 다른 메뉴 화면으로 이동하시면 미리보기가 해제됩니다.</li>
	    	</div>
	    </div>
		<div class="row">
			<ifvm:inputNew type="text" id="url" label="미리보기 URL" labelClass="2" disabled="true" conClass="7" nuc="true"/>
			<ifvm:inputNew type="button" btnType="" className="btn_gray btn_lightGray2" text="열기" nuc="true" btnFunc="eventPreviewOpen"/>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="cancel" text="닫기" nuc="true" btnFunc="eventPreviewTokenPopClose"/>
    <ifvm:inputNew type="button" btnType="save" text="토큰 생성" nuc="true" btnFunc="getEventPreviewToken"/>
</div>