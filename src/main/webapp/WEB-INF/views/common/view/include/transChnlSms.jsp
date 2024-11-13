<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#mmsTextArea{
	height : 260px
}
</style>
<div class="form-horizontal underline clearfix" id="transChnlSmsWrap">
	<div class="half_content half_left">
		<div class="phoneImage">
			<div class="sms_kinds"><spring:message code="M00393"/> / <span class="sms_mms">SMS</span></div><!-- 단문SMS/ 장문SMS /이미지MMS /PUSH -->
			<div class="phoneWrap">
				<ifvm:input type="text" id="smsArea" maxLength="50" disabled="true"/>
				<div id="sortable">
					<div class="textareaBox">
						<ifvm:input type="textarea" className="sms_phone_area" id="mmsTextArea"/>
					</div>
				</div>
				<label class="phone_text"><spring:message code="M00397"/></label>
				<ifvm:input type="text" className="inputText" disabled="true" id="blockInfo"/>
				<span id="textByteSize"></span>
				<span class="phone_text"><spring:message code="M00798"/></span>
			</div>
		</div>
	</div>
	<div class="half_content half_right">
		<div class="form-horizontal top_well underline" id="" >
			<div clasa="row col-xs-12">
				<ifvm:inputNew type="text" id="hhpNo"   dto="hhpNo"	required="true" 	maxLength="13"	disabled="true"
						label="L01803" labelClass="4" conClass="6" /><!-- 휴대전화번호 -->
			</div>
			<div clasa="row col-xs-12">
				<ifvm:inputNew type="select" id="msgType"   dto="msgType" required="true"
					label="L01804" labelClass="4" conClass="6" /><!-- 메세지 유형-->
			</div>

		</div>
	</div>
</div>

<script>

function getByte( s, b, i, c){
	for(b=i=0; c=s.charCodeAt(i++); b+=c>>11?2:c>>7?2:1);
	return b;
}

gTransChnl_sms = {
		init : function(){
			/* $("#transChnlSmsWrap #hhpNo").keyup(function(){
				$(this).val(gTransChnl_sms.autoHypenPhone($(this).val()));
				if(typeof(gTransChnl.mbrInfo.custNm) != "undefined"){
					var msg = "";
					msg += "[" + gTransChnl.mbrInfo.custNm + "]"+ $(this).val();
					$("#transChnlSmsWrap #smsArea").val(msg);
				}
			}) */

			$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
	    		groupCode : 'TEXT_SENDER_INFO',
	    		codeName : 'MSG_REJ'
	   		 } , function(result) {

	        	if (result.success) {
	        		var msgRej = result.rows[0].attrib01;
	        		$("#transChnlSmsWrap #blockInfo").val(msgRej);
	        	}
	        }, function(result){
	        	alert(result.message);
	        })


			$("#transChnlSmsWrap #mmsTextArea, #transChnlSmsWrap #smsArea").keyup(function(){
				var calString = $(this).val()+$("#transChnlSmsWrap #blockInfo").val() + $("#transChnlSmsWrap #smsArea").val();
				var currentByte = getByte(calString);
				if(currentByte >= 80){
					$(".sms_mms").text('LMS')
				}else{
					$(".sms_mms").text('SMS')
				}
				$("#textByteSize").text(currentByte);
			})

			$("#transChnlSmsWrap #msgType").change(function(){
				var msgType = $(this).val();
				var content = $("#transChnlSmsWrap #smsArea").val();

				var bMsg = '<spring:message code="L02012"/>';


				switch(msgType){
				//공지 : S001, 광고 : S002
				case 'S001' :
					//$("#transChnlSmsWrap #blockInfo").val('');

					bMsg = '<spring:message code="L02013"/>' + bMsg;
					var _index =content.indexOf(bMsg);
					if( _index == -1){

					}else{
						content = content.replaceAll(bMsg,'');
						$("#transChnlSmsWrap #smsArea").val(content);
					}
					bMsg = '<spring:message code="L02012"/>';
					break;

				case 'S002' :

					//$("#transChnlSmsWrap #blockInfo").val('<spring:message code="L02014"/>');

					var _index =content.indexOf(bMsg);
					if( _index == -1){

					}else{
						content = content.replaceAll('<spring:message code="L02012"/>','');
						$("#transChnlSmsWrap #smsArea").val(content);
					}
					bMsg = '<spring:message code="L02013"/>' + bMsg;
					break;
				}

				var _index =content.indexOf(bMsg);
				if( _index == -1){
					content = bMsg+content;
					$("#transChnlSmsWrap #smsArea").val(content);
				}else{

				}
				$("#transChnlSmsWrap #mmsTextArea").trigger('keyup');

			})

			if(typeof(gTransChnl) != 'undefined'){
				$("#transChnlSmsWrap #hhpNo").val(gTransChnl.mbrInfo.hhpNo).trigger('keyup');


			}
			$.ifvGetCommCodeList('select', 'transChnlSmsWrap #msgType', '<ifvm:action name="getCommCodeList2"/>', 'SMS_MSG_TYPE', 'loy', false, false, true);



		},
		autoHypenPhone : function(str){
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			  if( str.length < 4){
			    return str;
			  }else if(str.length < 7){
			    tmp += str.substr(0, 3);
			    tmp += '-';
			    tmp += str.substr(3);
			    return tmp;
			  }else if(str.length < 11){
				  if(str.substr(0, 2)=="02"){
					  tmp += str.substr(0, 2);
					  tmp += '-';
					  tmp += str.substr(2, 3);
					  tmp += '-';
					  tmp += str.substr(5);
					  return tmp;
				  }else{
					  tmp += str.substr(0, 3);
					  tmp += '-';
					  tmp += str.substr(3, 3);
					  tmp += '-';
					  tmp += str.substr(6);
					  return tmp;
				  }
			  }else{
				  if(str.substr(0, 2)=="02"){
					  tmp += str.substr(0, 2);
					  tmp += '-';
					  tmp += str.substr(2, 4);
					  tmp += '-';
					  tmp += str.substr(6);
					  return tmp;
				  }else{
					  tmp += str.substr(0, 3);
					  tmp += '-';
					  tmp += str.substr(3, 4);
					  tmp += '-';
					  tmp += str.substr(7);
					  return tmp;
				  }
			  }
			  return str;

		}
}
gTransChnl_sms.init();
</script>