<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var phoneChk = true;

var barcodeUrl;
var textAreaValue;
var html;
var PhoneArray = [];
var chnlId;
var functionCheck = 0;
var Info;

function phoneNumChk(text) {
    var phone1, phone2, phone3;

    if (text.length == 11) {
        phone1 = text.substring(0, 3);
        phone2 = text.substring(3, 7);
        phone3 = text.substring(7, 11);
    }
    else {
        phone1 = text.substring(0, 3);
        phone2 = text.substring(3, 6);
        phone3 = text.substring(6, 11);
    }

    var rgEx = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;
    var strValue = phone1 + "-" + phone2 + "-" + phone3;

    var chkFlg = rgEx.test(strValue);
    if (!chkFlg) {
        alert(text + '<spring:message code="M00456"/>');
        return false;
    }
    else {
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
            if (phoneChk)
                phoneChk = phoneNumChk($("#phone" + i).val());

            PhoneArray.push(temp)
            functionCheck++;
        }
    }
}

$(document).ready(function() {
    
    $("#smsMms").text(chnlCode);
    
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'TEXT_SENDER_INFO',
        enableNA : true
    }, function(result) {
        var size = result.rows.length;

        for (var i = 0; i < size; i++) {
            if (result.rows[i].codeName == "SEND_TEL") {
                Info = result.rows[i].markName
            }
        }
    });

    $("#sendChannelTest").on('click', function() {
        createPhoneArray();
        if (functionCheck > 0) {
            if (phoneChk) {
                
                $.ifvSyncPostJSON('<ifvm:action name="sendChannelTest"/>', {
                    title        : $("#smsArea").val(),
                    contents     : $(".prev_textarea_wrap").text(),
                    id           : conid,
                    contentsType : chnlCode,
                    imgCnt       : $("#imgCnt").val(),
                    phoneArr     : PhoneArray,
                    chnlId       : kko.chnl,
                    filePath     : photoUrl,
                    typeCode     : typeCodeId,
                    senderInfo   : Info,
                }, function(result) {
                    var Text;
                    if (result.message.indexOf('Fail') == -1) {
                        Text = result.message;
                    }
                    else
                        Text = result.message + '\n<spring:message code="M00455"/>';
                    alert(Text);
                });
            }
        }
        else
            alert('<spring:message code="M00447"/>');
    });

    if ($('#smsArea').val() == '') {
        $('#smsArea_c').text($('#smsArea').attr('placeholder'));
    }
    else {
        $('#smsArea_c').text($('#smsArea').val());
    }

    textAreaValue = $('#mmsTextArea').val();
    var htmlValue = {
        barcodeUrl    : barcodeUrl,
        photoUrl      : photoUrl,
        textAreaValue : textAreaValue,
    };
    
    console.log(htmlValue);

    if ($('#sortable').children('div:eq(0)').hasClass('imageBox'))
        html = $("#fiPrevTemp").tmpl(htmlValue);
    else
        html = $("#ftPrevTemp").tmpl(htmlValue);

    $('#previewContent').append(html);

});

</script>

<script id="ftPrevTemp" type="text/x-jquery-tmpl">
    <pre class="prev_textarea_wrap">${'${'}textAreaValue}</pre>
    {{if photoUrl != '' && photoUrl != null}}
    <div class="prev_photo_wrap">
        <img src="${'${'}photoUrl}"/>
    </div>
    {{/if}}
    
</script>

<script id="fiPrevTemp" type="text/x-jquery-tmpl">
    {{if photoUrl != '' && photoUrl != null}}
    <div class="prev_photo_wrap">
        <img src="${'${'}photoUrl}"/>
    </div>
    {{/if}}

    <pre class="prev_textarea_wrap">${'${'}textAreaValue}</pre>
    
</script>

<style>

#kakaoPreviewWrap {
    display: inline;
}

</style>

<div class="content_pop_wrap">
    <div id="kakaoPreviewWrap" class="form-horizontal content_textImage_con">
        <div class="phoneImage fix_phone">
            <div class="sms_kinds"><spring:message code="M02403"/></div>
            <div class="phoneWrap" id="previewContent">
                <div id="smsArea_c">
                    
                </div>
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