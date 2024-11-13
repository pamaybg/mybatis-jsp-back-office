<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var phoneChk = true;

function phoneNumChk(text){
	var phone1,phone2,phone3;
	
	 if(text.length == 11){
		phone1 = text.substring(0,3);
		phone2 = text.substring(3,7);
		phone3 = text.substring(7,11);
	 }else{
		phone1 = text.substring(0,3);
		phone2 = text.substring(3,6);
		phone3 = text.substring(6,11);
		 
	 }
		
	 var rgEx = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;  
	 var strValue = phone1 + "-" + phone2 + "-" + phone3;
	 
	 var chkFlg = rgEx.test(strValue);   
	 
	 if(!chkFlg){
	  	alert(text + '<spring:message code="M00456"/>');
	 	return false; 
	 }
	 else{
		return true;
	 }
}


$(document).ready(function(){
	var barcodeUrl;
	var textAreaValue;
	var warningValue;
	var html;
	var PhoneArray = [];
	var chnlId;
	var functionCheck = 0;
	var Info;
	$("#smsMms").text(chnlCode);
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'TEXT_SENDER_INFO'
		, enableNA : true
	},function(result) {
		var size = result.rows.length;
		
		for(var i=0;i<size;i++){
			if(result.rows[i].codeName == "SEND_TEL"){
				Info = result.rows[i].markName
			}
		}
	});
	function createPhoneArray(){
		PhoneArray = [];
		phoneChk = true;
		functionCheck = 0;
		
		for(var i=1;i<6;i++){
			if($("#phone" +i).val().length > 0)
			{ 
				var temp = {} 
				temp.phone = $("#phone" +i).val();
				if(phoneChk) phoneChk = phoneNumChk($("#phone" +i).val());
				
				PhoneArray.push(temp)
				functionCheck++;
			}
		}
	}
	
	$("#sendChannelTest").on('click', function(){
		createPhoneArray();
		if(functionCheck > 0){
			if(phoneChk){
				//조회 호출
				$.ifvSyncPostJSON('<ifvm:action name="sendChannelTest"/>', { ///marketing/content/sendChannelTest.do
					  title            : $("#smsArea").val()
					, contents         : $(".prev_textarea_wrap").text() //$("#previewContent").html()
					, id               : conid
					, contentsType     : chnlCode
					, imgCnt           : $("#imgCnt").val()
					, phoneArr         : PhoneArray
					, denial           : $("#smsWarningArea").val()
					, chnlId           : mms.chnl
					, filePath         : mms.imgSrc
					, typeCode         : mms.typeCodeId
					, toCallbackNo	   : $("#toCallbackNo").val()
				}, function(result) {
					var Text;
					if (result.message.indexOf('Fail') == -1) {
						Text = result.message;
					}
					else Text = result.message + '\n<spring:message code="M00455"/>';
					alert(Text);
				});
			}
		}
		else alert('<spring:message code="M00447"/>');
	});

	if($('#smsArea').val() == '')
		$('#smsArea_c').text($('#smsArea').attr('placeholder'));
	else
		$('#smsArea_c').text($('#smsArea').val());

	textAreaValue = $('#mmsTextArea').val();
	warningValue = $('#smsWarningArea').val();
	var htmlValue = {barcodeUrl: barcodeUrl, photoUrl : mms.imgSrc, textAreaValue: textAreaValue, warningValue: warningValue};

	if($('#sortable').children('div:eq(0)').hasClass('imageBox'))
		html = $("#fiPrevTemp").tmpl(htmlValue);
	else
		html = $("#ftPrevTemp").tmpl(htmlValue);

	$('#previewContent').append(html);

});
</script>

<style>
.same_textarea {
    white-space: pre-wrap;
    overflow: auto;
    word-break: normal;
    margin: 0;
    padding: 2px 8px;
    font-size: 11px;
}
</style>

<script id="ftPrevTemp" type="text/x-jquery-tmpl">
	<pre class="prev_textarea_wrap same_textarea">${'${'}textAreaValue}</pre>
	{{if photoUrl != ''}}
	<div class="prev_photo_wrap">
		<img src="${'${'}photoUrl}"/>
	</div>
	{{/if}}
	<pre class="prev_warning_wrap">${'${'}warningValue}</pre>
	
</script>

<script id="fiPrevTemp" type="text/x-jquery-tmpl">
	{{if photoUrl != ''}}
	<div class="prev_photo_wrap">
		<img src="${'${'}photoUrl}"/>
	</div>
	{{/if}}

	<pre class="prev_textarea_wrap same_textarea">${'${'}textAreaValue}</pre>
	<pre class="prev_warning_wrap">${'${'}warningValue}</pre>
	
</script>

<div class="content_pop_wrap">
	<div id="mmsPreviewWrap" class="form-horizontal content_textImage_con" style="padding-top: 20px; padding-bottom: 30px">
			<div class="phoneImage fix_phone">
				<div class="sms_kinds"><spring:message code="M00393"/> / <span class="sms_mms">MMS</span></div><!-- 단문SMS/ 장문SMS /이미지MMS /PUSH -->
				<div class="phoneWrap" id="previewContent">
					<div id="smsArea_c">
						
					</div>
				</div>
			</div>
	</div>
	<div class="send_sms_wrap" style="padding: 20px">
		<div>
			<header class="temp_title">
				<p><spring:message code="M00424"/></p>
			</header>
			<ul class="description_guide">
				※ 필수 입력사항
				<li> 송신자 번호 : 각 매장별 번호로 발송</li>
				<li> 문구 앞단 (광고) 표기 및 첫줄내 브랜드명 기재</li>
				<li>  : 비즈니스 문자 발송 주체를 고객이 인지할 수 있어야함</li>
				<li> 수신자 거부 번호 '무료거부0808730002‘</li>
				<li>※ MMS 이미지 가이드 : 사이즈 640*480px, jpg</li>
				<li>※ 별도 텍스트 기재가 없는 화보컷 위주 사용을 권장</li>
				<li>텍스트 기재가 필요할 경우 핵심 문구 1~2줄내로 간결하게 작성</li>
			</ul>
		</div>
		<div>
			<header class="temp_title">
				<p><spring:message code="M00391"/></p>
			</header>
			<ifvm:input type="email" id="phone1" placeholder="M00730" className="form-control input_email" valiItem="number" />	
			<ifvm:input type="email" id="phone2" placeholder="M00730" className="form-control input_email" valiItem="number" />	
			<ifvm:input type="email" id="phone3" placeholder="M00730" className="form-control input_email" valiItem="number" />	
			<ifvm:input type="email" id="phone4" placeholder="M00730" className="form-control input_email" valiItem="number" />	
			<ifvm:input type="email" id="phone5" placeholder="M00730" className="form-control input_email" valiItem="number" />	
			<div class="text-center send_preview_btn_area">
				<button class="btn btn-sm btn_gray" id="sendChannelTest" objCode="mmsPreviewTest_OBJ">         
					<spring:message code="M00391"/>
				</button>
			</div>
		</div>
	</div>
</div>