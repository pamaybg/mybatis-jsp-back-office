<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline" id="certiMypinWrap">
	<div class="top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00814"/></span><!-- 마이핀인증 -->
			</div>
		</div>
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="text" id="name"   dto="name"    required="true"
					label="L00815" labelClass="4" conClass="7" /><!-- 성명-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="mypinNum"   dto="mypinNum"    required="true" maxLength="13"
					label="L00816" labelClass="4" conClass="7" /><!-- 마이핀번호 -->
			</div>
		</div>
	</div>
</div>

<script>
	var mypinVali = $("#certiMypinWrap").ifvValidation();
	function certiOwnPopConfirm(){
		if(mypinVali.confirm() == true){
			var dataObj = $("#certiMypinWrap").getSubmitData();
			console.log(dataObj);
			if(!pinNumVali(dataObj.mypinNum)){
				alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
				return;
			}
			//alert("[마아핀 인증 ] \n 성명 :"+dataObj.name+"\n 마이핀 번호 : "+dataObj.mypinNum+"\n 입력하신 정보가 맞습니까?");

			var data = $("#certiMypinWrap").getSubmitData();
			data = {
				mypinNum : $("#certiMypinWrap #mypinNum").val().replaceAll('-','')
				, name : $("#certiMypinWrap #name").val()
			}
			var action = '<ifvm:action name="memRegcheckMypinNum"/>';
			data.cardNo=cardNum;
			$.ifvSyncPostJSON(action, data , function(result) {

				if (result.success) {
					qtjs.href('<ifvm:url name="mbrDetail"/>'+'?rid='+result.pMbrRid);
				}
			}, function(result){
				alert(result.message);
			})
		}
	}

	function pinNumVali(_pinNum){
		var regNum = /^[0-9]*$/;
		if(regNum.test(_pinNum) && _pinNum.length==13) return true;
		else return false;
	}


</script>