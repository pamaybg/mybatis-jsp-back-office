<%@ page trimDirectiveWhitespaces="true" %>
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
var phoneChk = true;

function initKakaoNoticePreviewPop() {
    $("#preContentsTitle").text(kkn.presmsArea);
    $("#preContents").text(kkn.presmsTextArea);
}

function createPhoneArray() {
    PhoneArray = [];
    phoneChk = true;
    functionCheck = 0;

    for (var i = 1; i < 6; i++) {
        if ($("#phone" + i).val().length > 0) {
            var temp = {}
            temp.phone = $("#phone" + i).val();

            if (phoneChk) {
                phoneChk = phoneNumChk($("#phone" + i).val());
            }
            PhoneArray.push(temp)
            functionCheck++;
        }
    }
}
function sendPushTest() {
    
    // 발송 번호 목록
    createPhoneArray();

    if (functionCheck > 0) {
        if (phoneChk) {
            $.ifvSyncPostJSON('<ifvm:action name="sendChannelTest"/>', {
                  title            : precontentsTitle
                , contents         : precontents
                , id               : conid
                , contentsType     : chnlCode
                , phoneArr         : PhoneArray
                , typeCode         : typeCodeId
                , senderInfo       : Info
            }, function(result) {
                var Text;

                if (result.message.indexOf('Fail') == -1) {
                    Text = result.message;
                }
                else
                    Text = result.message + '\n<spring:message code="M00455"/>';

                alert(Text);
            }, function(result) {
                if (result.errorType == 800100) {
                    alert('<spring:message code="M00455"/>');
                }
            });
        }
    }
    else {
        alert('<spring:message code="M00447"/>');
    }
}


$(document).ready(function() {
    
    initKakaoNoticePreviewPop();
    
    $("#sendChannelTest").on('click', function(){
        sendPushTest();
    });
    
});

</script>

<script id="fiPrevTemp" type="text/x-jquery-tmpl">
    <pre class="prev_textarea_wrap">${'${'}textAreaValue}</pre>
</script>

<div class="content_pop_wrap" style="padding: 12px;">
    <div id="mmsPreviewWrap" class="form-horizontal content_textImage_con">
        <div class="phoneImage">
            <div class="sms_kinds"><spring:message code="M02404"/></div>
            <div class="phoneWrap">
                <div class="preContentsTitleArea" id="preContentsTitle"></div>
                <div id="preImage"></div>
                <div class="preContentsArea" id="preContents"></div>
            </div>
        </div>
    </div>
    <div class="send_sms_wrap">
        <div>
            <header class="temp_title">
                <p><spring:message code="M00424"/></p>
            </header>
            <ul class="description_guide">
                <li class="number_guide">1. <spring:message code="M00731"/></li>
                <li class="number_guide">2. <spring:message code="M00732"/></li>
                <li class="last"><spring:message code="M00734"/></li>
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
                <button class="btn btn-sm btn_gray" id="sendChannelTest">         
                    <spring:message code="M00391"/>
                </button>
            </div>
        </div>
    </div>
</div>