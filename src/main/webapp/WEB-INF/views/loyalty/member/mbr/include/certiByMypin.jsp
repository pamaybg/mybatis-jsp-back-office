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
				<ifvm:inputNew type="text" id="mypinNumMas"   dto="mypinNumMas"    required="true" maxLength="13"
					label="L00816" labelClass="4" conClass="7" /><!-- 마이핀번호 -->

				<ifvm:inputNew type="hidden" id="mypinNum"   dto="mypinNum" maxLength="13"
					label="L00816" labelClass="4" conClass="7" /><!-- 마이핀번호 -->
			</div>
		</div>
	</div>
</div>

<script>
//본인인증 케이스
//001 가입인증
//002 개명인증
//003 간편회원가입
//004 소프트폰 마이핀
	var mypinVali = $("#certiMypinWrap").ifvValidation();
	function certiOwnPopConfirm(){
		if(mypinVali.confirm() == true){
			/* var dataObj = $("#certiMypinWrap").getSubmitData();
			console.log(dataObj); */
			/* if(!pinNumVali(dataObj.mypinNumMas)){
				alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
				return;
			} */
			//alert("[마아핀 인증 ] \n 성명 :"+dataObj.name+"\n 마이핀 번호 : "+dataObj.mypinNum+"\n 입력하신 정보가 맞습니까?");

			var reqData = $("#certiMypinWrap").getSubmitData();

			reqData = {
				mypinNum : ""
				, name : $("#certiMypinWrap #name").val()
			}
			var action = '<ifvm:action name="checkMypinNum"/>';

			switch(certiCase){
				case "001" :

					action = '<ifvm:action name="checkMypinNum"/>';
					reqData = {
							mypinNum : $("#certiMypinWrap #mypinNumMas").val().replaceAll('-','')
							, name : $("#certiMypinWrap #name").val()
						}
					if(!pinNumVali(reqData.mypinNum)){
						alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
						return;
					}
					break;
				case "002" :
					reqData = {
						mypinNum : $("#certiMypinWrap #mypinNumMas").val().replaceAll('-','')
						, name : $("#certiMypinWrap #name").val()
					}
					tgtObj = {
						oldName : $("#mbrRenameReqDetailForm #oldName").val()
						, ridMbr : $("#ridMbr").val()
						, newName : $("#mbrRenameReqDetailForm #newName").val()
						, rid : $("#rid").val()
						, mbrNo : $("#mbrRenameReqDetailForm #mbrNo").val()
					}
					reqData = $.extend(reqData,tgtObj);
					action = '<ifvm:action name="checkMypinNum4Rename"/>';
					if(!pinNumVali(reqData.mypinNum)){
						alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
						return;
					}
					break;
				case "003" :
					reqData = {
						mypinNum : $("#certiMypinWrap #mypinNum").val().replaceAll('-','')
						, name : $("#certiMypinWrap #name").val()
					}

					action = '<ifvm:action name="checkMypinNum"/>';

					if(!pinNumVali(reqData.mypinNum)){
						alert('<spring:message code="L01839"/>');//잘못된 핀번호 입니다.
						return;
					}
					break;

				case "004" :
					reqData = {
						mypinNum : $("#certiMypinWrap #mypinNum").val().replaceAll('-','')
						, name : $("#certiMypinWrap #name").val()
					}

					action = '<ifvm:action name="checkMypinNum"/>';
					break;
				default:
					break;
			}
			/* 간편회원가입 카드등로 위해 cardNo추가 */
			/* 180126 -jkkim*/
			if(cardNo !="null"){
				reqData.cardNo = cardNo;
			}
			$.ifvSyncPostJSON(action, reqData , function(result) {

				if (result.success) {
					switch(certiCase){
						case "001" :
							url = '<ifvm:url name="mbrDetailNew"/>'+'?rid='+result.pMbrRid;
							qtjs.href(url);
							break;
						case "002" :
							alert('<spring:message code="L01824"/>');
							url = '<ifvm:url name="mbrRenameReqList"/>';
							qtjs.href(url);
							break;
						case "003" :
							url = '<ifvm:url name="mbrDetailNew"/>'+'?rid='+result.pMbrRid;
							qtjs.href(url);
							break;
						case "004" :
							$("#mainIframe").attr("src",'<ifvm:url name="mbrDetailNew"/>'+'?rid='+result.pMbrRid);
							certiOwnPopClose();
							break;
						default:
							break;
					}

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

switch(certiCase){
	case "001" :
		break;
	case "002" :
		$("#certiMypinWrap #name").val($("#mbrRenameReqDetailForm #newName").val()).prop('disabled',true);
		break;
	case "003" :
		$("#certiMypinWrap #name").val($("#simpleMemRegDtlForm #userName").val());
		$("#certiMypinWrap #mypinNum").prop('disabled',true).val($("#simpleMemRegDtlForm #userMypinDescrypt").val());
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
				{
			type : 'lmsr',
			field : 'mypinNull',
			rid : $.ifvGetParam('rid')
		},
        function(result) {
			if(result.message){
				var patten = /.{10}$/;
				$("#certiMypinWrap #mypinNum").val(result.message);
				$("#certiMypinWrap #mypinNumMas").prop('disabled',true).val(result.message.replace(patten,"**********"));
			}});

		break;
	case "004" :
		var patten = /.{10}$/;
		$("#certiMypinWrap #mypinNum").val(mypin);
		$("#certiMypinWrap #mypinNumMas").prop('disabled',true).val(mypin.replace(patten,"**********"));
		break;
	default:
		break;
}



</script>