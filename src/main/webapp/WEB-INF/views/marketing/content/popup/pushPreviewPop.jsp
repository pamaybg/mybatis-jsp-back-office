<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var PhoneArray = [];
var functionCheck = 0;
var Info;
var contentVal;
var titleVal;
var warningVal;
var phoneChk = true;

function phoneNumChk(text) {
	var phone1;
	var phone2;
	var phone3;
	
	 if (text.length == 11) {
		phone1 = text.substring(0,3);
		phone2 = text.substring(3,7);
		phone3 = text.substring(7,11);
	 }
	 else {
		phone1 = text.substring(0,3);
		phone2 = text.substring(3,6);
		phone3 = text.substring(6,11);
	 }
		
	 var rgEx = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;  
	 var strValue = phone1 + "-" + phone2 + "-" + phone3;
	 
	 var chkFlg = rgEx.test(strValue);
	 
	 if (chkFlg == false) {
	  	alert(text + '<spring:message code="M00456"/>');
	 	return false; 
	 }
	 else{
		return true;
	 }
}


function createPhoneArray() {
    PhoneArray = [];
    phoneChk = true;
    functionCheck = 0;
    for (var i = 1; i < 6; i++) {
	        if ($("#phone" + i).val().length > 0) {
	            var temp = {}
	            temp.phone = $("#phone" + i).val();
				if($("#memberName" + i).val().length > 0) {
					temp.memName = $("#memberName" + i).val();
				} else {
					temp.memName = null;
				}
	            if (phoneChk) {
	                phoneChk = $("#phone" + i).val();
	            }
	            PhoneArray.push(temp)
	            functionCheck++;
	        }
    }
}

//push 미리보기 설정
function initPushPreviewPop() {
	$("#preContentsTitle").html(push.precontentsTitle);
	$("#preContents").html(push.precontents);
	// 이미지가 있다면 
	//if ($('#sortable').children('div:eq(0)').hasClass('imageBox')  && /* (push.photoUrl != null || push.photoUrl != "") */) {
	if (push.imgPreviewPath != "") {
	    $('#preImage').addClass('prev_photo_wrap');
	    $('#preImage').html("<img src='" + $('#mmsImage').attr('src') + "'/>");
	}
	else {
        $('#preImage').removeClass('prev_photo_wrap');
        $('#preImage').html("");
	}
}

function sendPushTest() {
	
	//발송 번호 목록
	createPhoneArray();
	if(functionCheck > 0) {
		if(phoneChk){
				$.ifvSyncPostJSON('<ifvm:action name="sendChannelTest"/>', {
					  title              : push.precontentsTitle
					, contents           : push.precontents
					, id                 : conid
					, contentsType       : chnlCode
					, phoneArr           : PhoneArray
					, denial             : warningVal
					, typeCode           : push.typeCodeId
					, senderInfo	     : Info
					, contsPushTypeCode  : push.pushTypeCode
					, contsPushSubTypeVal: push.preLinkUrl
	                , filePath           : push.photoUrl
	                , imgCnt             : $("#imgCnt").val()
	                , contsPushParam     : getUserParameter()
					, brazeCamApiKey 	 : $("#brazeCamApiKey").val()
				}, function(result) {
					var Text;
					if (result.message.indexOf('Fail') == -1) {
						Text = result.message;
					}
					else Text = result.message + '\n<spring:message code="M00455"/>';
					alert(Text);
				},function(result){
					if (result.errorType == 800100) {
						alert('<spring:message code="M00455"/>');
					} else if (result.errorType = 4444){
						alert('Braze Push 캠페인이 선택되지 않았습니다.');
					}
				});
		}
	} else {
		alert('<spring:message code="M00447"/>');
	}
}


$(document).ready(function() {
    
    initPushPreviewPop();
    
    $("#sendChannelTest").on('click', function(){
        sendPushTest();
    });
    
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

<script id="fiPrevTemp" type="text/x-jquery-tmpl">
	<pre class="prev_textarea_wrap same_textarea">${'${'}textAreaValue}</pre>
	<pre class="prev_warning_wrap">${'${'}warningValue}</pre>
</script>

<div class="content_pop_wrap">
	<div id="mmsPreviewWrap" class="form-horizontal content_textImage_con" style="padding-top: 20px">
        <div class="phoneImage">
    		<div class="sms_kinds"><spring:message code="M00393"/> / <span>PUSH</span></div>
    		<div class="phoneWrap">
    			<div class="preContentsTitleArea" id="preContentsTitle"></div>
                <div id="preImage"></div>
    			<div class="preContentsArea" id="preContents"></div>
    		</div>
    	</div>
	</div>
    
	<div class="send_sms_wrap" style="padding: 20px">
		<div>
			<header class="temp_title">
				<p><spring:message code="M00424"/></p>
			</header>
			<ul class="description_guide">
				<li class="number_guide">1. <spring:message code="M00731"/></li>
				<li class="number_guide">2. <spring:message code="M00732"/></li>
				<li><spring:message code="M00733"/></li>
				<li class="last"><spring:message code="M00734"/></li>
			</ul>
		</div>
		<div>
			<header class="temp_title">
				<p><spring:message code="M03081"/></p>
			</header>
			<div class="form-horizontal row">
				<div class="col-xs-7">
					<ifvm:input type="email" id="phone1" placeholder="M03083" className="form-control input_email" valiItem="number" />
				</div>
				<div class="col-xs-1"></div>
				<div class="col-xs-5">
					<ifvm:inputNew type="text" placeholder="M03033" id="memberName1" className="form-control input_email" required="true" />
				</div>
			</div>
			<div class="form-horizontal row">
				<div class="col-xs-7">
					<ifvm:input type="email" id="phone2" placeholder="M03083" className="form-control input_email" valiItem="number" />
				</div>
				<div class="col-xs-1"></div>
				<div class="col-xs-5">
					<ifvm:inputNew type="text" placeholder="M03033" id="memberName2" className="form-control input_email" required="true" />
				</div>
			</div>
			<div class="form-horizontal row">
				<div class="col-xs-7">
					<ifvm:input type="email" id="phone3" placeholder="M03083" className="form-control input_email" valiItem="number" />
				</div>
				<div class="col-xs-1"></div>
				<div class="col-xs-5">
					<ifvm:inputNew type="text" placeholder="M03033" id="memberName3" className="form-control input_email" required="true" />
				</div>
			</div>
			<div class="form-horizontal row">
				<div class="col-xs-7">
					<ifvm:input type="email" id="phone4" placeholder="M03083" className="form-control input_email" valiItem="number" />
				</div>
				<div class="col-xs-1"></div>
				<div class="col-xs-5">
					<ifvm:inputNew type="text" placeholder="M03033" id="memberName4" className="form-control input_email" required="true" />
				</div>
			</div>
			<div class="form-horizontal row">
				<div class="col-xs-7">
					<ifvm:input type="email" id="phone5" placeholder="M03083" className="form-control input_email" valiItem="number" />
				</div>
				<div class="col-xs-1"></div>
				<div class="col-xs-5">
					<ifvm:inputNew type="text" placeholder="M03033" id="memberName5" className="form-control input_email" required="true" />
				</div>
			</div>
			<div class="text-center send_preview_btn_area" style="padding-bottom:10px;">
				<button class="btn btn-sm btn_gray" id="sendChannelTest" objCode="pushPreviewSendChannelTest_OBJ">
					<spring:message code="M00391"/>
				</button>
			</div>
				
		</div>
	</div>
</div>