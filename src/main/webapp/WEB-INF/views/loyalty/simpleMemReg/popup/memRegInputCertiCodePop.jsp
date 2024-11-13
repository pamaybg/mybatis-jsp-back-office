<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="inputCertiCodeWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="certiNo"   dto="certiNo"	required="true"
					label="L01856" labelClass="3" conClass="6" /><!-- 인증번호-->
				<ifvm:inputNew type="button" text="L01864" btnFunc="rereqCertiCode" /> <!-- 재전송-->

			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" text="L00817" btnFunc="certiCodeConfirm" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="inputCertiCode.close" className="btn_lightGray2"/>
</div>

<script>

function certiCodeConfirm(){
	//회원가입후 
 	var vali = $("#inputCertiCodeWrap").ifvValidation();
	if(vali.confirm()){
		var action = '<ifvm:action name="memRegCheckCertiCode"/>';
		var reqData = inputCertiCode.reqData;
		reqData.certiNo = $("#inputCertiCodeWrap #certiNo").val();
		reqData.smsendSeq = "01";
		reqData.cardNo=cardNum;
		console.log(reqData);
		$.ifvSyncPostJSON(action, reqData , function(result) {

			if (result.success) {
				qtjs.href('<ifvm:url name="mbrDetail"/>'+'?rid='+result.pMbrRid);
			}
		}, function(result){
			alert(result.message);
		})
	} 
}

function rereqCertiCode(){
		var action = '<ifvm:action name="rereqCertiCode"/>';
		var reqData = inputCertiCode.oReqData;
		reqData.mobileCertiSeq = inputCertiCode.reqData.mobileCertiSeq;
		reqData.tranSerialNum = inputCertiCode.reqData.tranSerialNum;
		reqData.serviceNo = inputCertiCode.reqData.serviceNo;
		reqData.certiSeq = inputCertiCode.reqData.certiSeq;
		console.log(reqData);
		$.ifvSyncPostJSON(action, reqData , function(result) {

			if (result.success) {
				
				qtjs.href('<ifvm:url name="mbrDetail"/>'+'?rid='+result.pMbrRid);
			}
		}, function(result){
			alert(result.message);
		})
}




</script>