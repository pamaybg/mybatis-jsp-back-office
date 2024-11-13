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
					label="L01856" labelClass="3" conClass="5" /><!-- 인증번호-->
				<ifvm:inputNew type="button" text="L01864" btnFunc="rereqCertiCode" className="left" /> <!-- 재전송-->
				<div id="time" class="control_content col-xs-1" style="line-height: 19.5px;"></div>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="confirmBtn" text="L00817" btnFunc="certiCodeConfirm" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="inputCertiCode.close" className="btn_lightGray2"/>
</div>

<script>
function certiCodeConfirm(){
	var vali = $("#inputCertiCodeWrap").ifvValidation();
	if(vali.confirm()){
		var action ;

		var reqData = inputCertiCode.reqData;
		reqData.certiNo = $("#inputCertiCodeWrap #certiNo").val();
		reqData.smsendSeq = "01";


		/* 간편회원가입 카드등로 위해 cardNo추가 */
		/* 180126 -jkkim*/
		if(cardNo !="null"){
			reqData.cardNo = cardNo;
		}

		switch(certiCase){
			case "001" :
				action = '<ifvm:action name="checkCertiCode"/>';
				break;
			case "002" :
				tgtObj = {
						oldName : $("#mbrRenameReqDetailForm #oldName").val()
						, ridMbr : $("#ridMbr").val()
						, newName : $("#mbrRenameReqDetailForm #newName").val()
						, rid : $("#rid").val()
						, mbrNo : $("#mbrRenameReqDetailForm #mbrNo").val()
					}

				/* reqData.oldName = $("#mbrRenameReqDetailForm #oldName").val();
				reqData.ridMbr = $("#ridMbr").val();
				reqData.newName = $("#mbrRenameReqDetailForm #newName").val();
				reqData.rid = $("#rid").val();
				reqData.mbrNo = $("#mbrRenameReqDetailForm #mbrNo").val() */

				//reqData = Object.assign(reqData,tgtObj);
				reqData = $.extend(reqData,tgtObj);

				action = '<ifvm:action name="checkCertiCode4Rename"/>';
				break;
			case "003" :
				action = '<ifvm:action name="checkCertiCode"/>';
				break;
			default:
				break;
		}

		console.log(reqData);
		$.ifvSyncPostJSON(action, reqData , function(result) {

			if (result.success) {
				switch(certiCase){
					case "001" :
						url = '<ifvm:url name="mbrDetail"/>'+'?rid='+result.pMbrRid;
						break;
					case "002" :
						alert('<spring:message code="L01824"/>');
						url = '<ifvm:url name="mbrRenameReqList"/>';
						break;
					case "003" :
						url = '<ifvm:url name="mbrDetail"/>'+'?rid='+result.pMbrRid;
						break;
					default:
						break;
				}
				qtjs.href(url);
			}
		}, function(result){
			alert(result.message);
			/* switch(certiCase){
				case "001" :
					inputCertiCode.close();
					certiOwn.close();

					break;
				case "002" :
					certiOwn.close();
					break;
				default:
					break;
			} */
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
				alert('<spring:message code="L01863"/>');
				inputCertiCode.oReqData = reqData;
				inputCertiCode.reqData = convertFirstLetter(result.rtnVal);
				inputCertiCode.pop();
				//REQ_M021
				clearInterval(interId);
				time = 180;
				interId = setInterval(decrementTime(),1000);
				$("#confirmBtn").prop('disabled',false);
			}
		}, function(result){
			alert(result.message);
		})
}

$(document).ready(function() {
	$("#time").html(toHourMinSec(time))
})



</script>