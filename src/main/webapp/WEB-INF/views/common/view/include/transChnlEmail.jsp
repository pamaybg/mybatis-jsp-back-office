<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>

</style>
<div class="form-horizontal underline" id="transChnlEmailWrap">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="email"   dto="email"  valiItem="email"	required="true"	disabled="true"
					label="L01484" labelClass="2" conClass="3" /><!-- 이메일 -->
		<ifvm:inputNew type="select" id="msgType"   dto="msgType"	required="true"
					label="L01804" labelClass="3" conClass="3" /><!-- 메세지 유형-->
	</div>
	
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="title"   dto="title"
					label="L01431" labelClass="2" conClass="9" /><!-- 제목 -->
	</div>
	<div class="row qt_border">
	    <!-- editor -->
	    <textarea id="htmlContentsArea"></textarea>
	    <!-- editor end -->
	</div>
</div>

<script>
gTransChnl_email = {
		init : function(){
			$.ifvGetCommCodeList('select', 'transChnlEmailWrap #msgType', '<ifvm:action name="getCommCodeList2"/>', 'EMAIL_MSG_TYPE', 'loy', false, false, true);

			$("#htmlContentsArea").ejRTE({
			    width:"100%",
			    minWidth:"10px",
			    showFooter: true,
			    showHtmlSource:true,
			    tools: {
			        formatStyle: ["format"],
			        font: ["fontSize", "fontColor", "backgroundColor"],
			        style : ["bold", "italic", "underline"],
			        indenting: [],
			        images: [],
			        tables : [],
			        doAction : [],
			        links : [],
			        media : [],
			        view : ["fullScreen"]
			   }
			});

			rteeObj  = $("#htmlContentsArea").data("ejRTE");



			if(typeof(gTransChnl) != 'undefined'){
				$("#transChnlEmailWrap #email").val(gTransChnl.mbrInfo.emailAddr);
			}


		}
}


gTransChnl_email.init();
</script>