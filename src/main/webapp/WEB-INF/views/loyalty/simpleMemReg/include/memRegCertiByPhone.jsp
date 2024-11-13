<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline" id="certiPhoneWrap">
	<div class="top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00813"/></span><!-- 휴대폰인증 -->
			</div>
		</div>
		<div class="form-horizontal top_well">
			<div class="row qt_border" id="terms">
				<ifvm:inputNew type="onlyLabel" label="L01605" labelClass="4" required="true" /><!-- 약관동의 -->
				<ifvm:inputNew type="checkbox" id="agrItem" text="L01139|L01132|L01133|L01135|L01136|L01138" values="whole|personalInfo|inherent|agency|service|protect"
						labelClass="3" conClass="8" checked="false" /><!-- 개인정보 이용동의 -->
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="onlyLabel" label="L01140" labelClass="4" required="true" /><!-- 내/외국인 -->
				<ifvm:inputNew type="radio" id="foreign" text="L01141|L01142" values="1|2" names='foreign'	checkIndex="1"
						labelClass="3" conClass="8" checked="false" /><!-- 내국인  | 외국인-->
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="onlyLabel" label="L01143" labelClass="4"  required="true" /><!-- 성별 -->
				<ifvm:inputNew type="radio" id="gender" text="L01144|L01145" values="m|f" names='gender'	checkIndex="1"
						labelClass="3" conClass="8" checked="false" /><!-- 남  | 여-->
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="name"   dto="name" label="L01146" labelClass="4" conClass="7" required="true" /><!-- 성명 -->
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="date" id="certiBirthDt"   dto="birthDt" label="L01147" labelClass="4" conClass="7" required="true" /><!-- 생년월일 -->
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="text" id="phoneNum"   dto="phoneNum" label="L01148" labelClass="4" conClass="7" required="true" /><!-- 휴대폰번호 -->
			</div>
			<div class="row">
				<ifvm:inputNew type="onlyLabel"  label="L01149" labelClass="4" required="true"/><!-- 이동통신사 -->
				<ifvm:inputNew type="radio" id="agency" text="L01150|L01151|L01152|L01153|L01154|L01155" values="skt|ktf|lgt|skm|ktm|lgm" names='telecomCode'	checkIndex="1"
					labelClass="3" conClass="8" checked="false" /><!-- skt|kt|lgu|skt mvno|kt mvno |lgu mvno-->
			</div>
		</div>
	</div>
</div>
<div id="inputCertiCodePop" class="popup_container"></div><!--충전량 조회  -->
<script>
var certiBirthDt  = $('#certiPhoneWrap #certiBirthDt');
certiBirthDt.val();
certiBirthDt.ifvDateChecker({});
$("#certiPhoneWrap #certiBirthDt").prop('placeholder','<spring:message code="L02008"/>');
$("#certiPhoneWrap #phoneNum").prop('placeholder','<spring:message code="L02015"/>');

//전체 동의
$("#terms input[value='whole']").unbind().bind('change', function(){
	if($(this).prop('checked')){
		$("#terms input").prop('checked',true);
	}else{
		$("#terms input").prop('checked',false);
	}
})

$("#terms input").not('[value="whole"]').unbind().bind('change', function(){
	$("#terms input[value='whole']").prop('checked',false);
})
	function certiOwnPopConfirm(){
		var vali = $("#certiPhoneWrap").ifvValidation();
		if(vali.confirm()){
			//약관동의 필수 체크
			$("#terms input").not("[value='whole'],[value='protect']").filter(function(){
				if(!$(this).prop('checked')){
					$.ifvCallValidationBox($("#terms > div"), '약관동의는 필수 입니다. ')
					return;
				}
			})

			var data = $("#certiPhoneWrap").getSubmitData();
			//임시 data 인증후 data 처리 해야 함
			var reqData = {
				mobile : data.phoneNum.replaceAll('-','')
				, name : data.name
				, birthDay : data.birthDt.replaceAll('-','')
				, telecomCode : $("#certiPhoneWrap input[name='telecomCode']:checked").val().toUpperCase()
				, sex : $("#certiPhoneWrap input[name='gender']:checked").val().toUpperCase()
				, foreignFlg : $("#certiPhoneWrap input[name='foreign']:checked").val().toUpperCase()
			}

			var action = '<ifvm:action name="reqCertiCode"/>';
			$.ifvSyncPostJSON(action, reqData , function(result) {

				if (result.success) {
					alert('<spring:message code="L01863"/>');
					inputCertiCode.oReqData = reqData;
					inputCertiCode.reqData = convertFirstLetter(result.rtnVal);
					inputCertiCode.pop();
				}
			},function(result){
				alert(result.message);
			})
		}
	}

	function convertFirstLetter(obj) {
		var rtnObj = {};
		for(var key in obj){
			var tmpKey = key.charAt(0).toLowerCase() + key.slice(1)
			rtnObj[tmpKey] = obj[key];
		}
		return rtnObj;
	}

	inputCertiCode = {
		id : "inputCertiCodePop",
		oReqData : null,
		reqData :null,
		pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="memRegInputCertiCodePop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L01856"/>', // 인증번호,
	            width : '400px'
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
	}
</script>
