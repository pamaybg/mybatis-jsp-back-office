<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap" id="changePhoneWrap">

	<!-- <iframe src="http://10.245.124.162:8082/APP_Mobile/View/Call/App_Mobile_Call_MemInfo_MP.aspx" frameborder="0" width="600" height="300" marginwidth="0" marginheight="0" scrolling="yes"> -->

</div>
<%-- <div class="pop_btn_area">
    <ifvm:inputNew type="button" text="L00817" btnFunc="" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="gMbrDetail.changePhoneNum.close" className="btn_lightGray2"/>
</div> --%>
<script>
var action = '<ifvm:action name="getCommCodeList"/>';
var data = {
		groupCode : 'SYM_URL',
		codeName : 'E1CellPhoneModifyPopup'
}
$.ifvSyncPostJSON(action, data , function(result) {

	if (result.success) {

		
		var url = result.rows[0].attrib01;
		/* var aIframe = document.createElement("iframe");

		aIframe.setAttribute("scrolling","no");

		aIframe.style.width = "420px";
		aIframe.style.height = "320px";
		aIframe.src = url+"?seq="+gMbrDetail.data.mbrNo;

		$("#changePhoneWrap").append(aIframe); */
		var popUrl = url+"?seq="+gMbrDetail.data.mbrNo;

		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)

		window.open(popUrl,"",popOption);

	}
}, function(result){
	alert(result.message);
})


</script>