<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>

var openType = $.ifvGetParamValue("openType"); // 오픈유형

var totallength	 //용량 제한
var conid	= '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';

var rcp = {
		limitLength         :	""	,
		totallength         :	""	,
		limitStore          :	""	,
		receiptValidation	:	""	,
		receiptValid        :	""	,
		focusCHeck          :	null	,
		detail              :	false	,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
		previewChk          :	false	,
		limitCHk            :	true
}

/**
 * 초기 실행할 펑션들.
 * 
 * @returns
 */
function initRunFunction() {
    
    // 공통코드 설정
    initComm();
    
    // 상세 정보 조회
    idCheck();

    // 현재 채널 타입 조회
    getChcnltype();
    
    // 입력 제한 조회
    getLimit();
    
    // byte 수 체크   
    initLengthCheck();
}

/**
 * 초기 세팅
 */
function initComm() {
    
}

/**
 * 상세 페이지인지 체크
 * @returns
 */
function idCheck() {

    $("input[name=autoCutYN][value=N]").prop('checked', true);
    $("input[name=barcodeYN][value=N]").prop('checked', true);
    $("input[name=qrcodeYN][value=N]").prop('checked', true);
    
    // 상세 페이지일 경우 세팅
    if (conid != "null") {
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
            id : conid
        }, function(result) {
            
            if ($.fn.ifvmIsNotEmpty(result)) {
                $("#contentsName").val(result.contentsName);
                exeContype = result.contentsType;
                chnlCode = result.contentsType;
                $("#contentsFlag").val(result.contentsFlag);
                $("#smsTextArea").val(result.contents);
                $("#textByteSize").val(result.textByteSize);
                $("#chnlGuide").val(result.chnlGuide);
                
                if (result.attrib01 == 'Y') {
                    $("input[name=autoCutYN][value=Y]").prop('checked', true);
                }
                else {
                    $("input[name=autoCutYN][value=N]").prop('checked', true);
                }
                if (result.attrib02 == 'Y') {
                    $("input[name=barcodeYN][value=Y]").prop('checked', true);
                }
                else {
                    $("input[name=barcodeYN][value=N]").prop('checked', true);
                }
                if (result.attrib03 == 'Y') {
                    $("input[name=qrcodeYN][value=Y]").prop('checked', true);
                }
                else {
                    $("input[name=qrcodeYN][value=N]").prop('checked', true);
                }
                $("#qrcodeUrl").val(result.attrib04);
                $("#barcodeNo").val(result.attrib05);
            }
        });
        rcp.detail = true;
    }
    
    changeQrcodeYN();
    changeBarcodeYN();
}

/**
 * 현재 채널 타입 세팅(미리보기 발송 시 현재 채널에 대한 타입을 전달하기 위한 세팅)
 * 
 * @returns
 */
function getChcnltype() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_TYPE_CD',
        enableNA : true
    }, function(result) {
        var size = result.rows.length;
        for (var i = 0; i < size; i++) {
            // 신규 페이지 일 시
            if (chnlCode != "null") {
            	//작성 가이드 셋팅
				$.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
						chnltype : chnlCode
				}, function(result) {
				    $("#chnlGuide").val(result.chnlGuide);   
				});		
                if (result.rows[i].codeName == chnlCode) {
                    typeCodeId = result.rows[i].codeId;
                    exeContype = result.rows[i].codeName;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            // 상세 페이지 일 시
            else {
                if (exeContype != null) {
                    if (exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
            }
        }
    });
}

/**
 * 초기 로딩 시 글자 수 체크
 */
function initLengthCheck() {
    checkLength();
    checkLength('textarea');
    checkLength('url');
}

/**
 * 콘텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
 */
function checkLength(inputType) {
    var textareaMessage = $("#smsTextArea").val();
    var qrcodeUrlMessage = $("#qrcodeUrl").val();
    
    var textareaLength = Number(totalLengthcheck(textareaMessage));
    if (textareaLength > 0) {
        textareaLength += 4;
    }
    
    var codeLength = 0;
    var qrcodeUrlLength = Number(totalLengthcheck(qrcodeUrlMessage));
    if ($("input[name=autoCutYN]:checked").val() == 'Y') {
        codeLength += 4;
    }
    if ($("input[name=barcodeYN]:checked").val() == 'Y') {
        codeLength += 16;
    }
    if ($("input[name=qrcodeYN]:checked").val() == 'Y') {
        codeLength += 4;
        codeLength += qrcodeUrlLength;
    }
    
    var totalLength = textareaLength + codeLength;
    
    totallength = totalLength;
    rcp.limitLength = rcp.limitStore;
    
    
    $("#textByteSize").val(totalLength);

    // 길이 초과인 경우 
    if (totalLength > rcp.limitLength) {
        rcp.limitCHk = false;
        alert(rcp.limitLength + "<spring:message code='M00431'/>");
    }
    else {
        rcp.limitCHk = true;
    }
}

/**
 * 총 길이 체크 (콘텐츠 내용을 체크하여 총용량을 계산한다.)
 * 
 * @param message
 * @returns
 */
function totalLengthcheck(message) {
    var totalByte = 0;
    for (var i = 0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);
        if (currentByte > 128)
            totalByte += 2;
        // 줄바꿈의 경우 4byte 추가 
        else if (currentByte == 10)
            totalByte += 4;
        else
            totalByte++;
    }
    return totalByte;
}

function cutMessage(message, remainLength) {
    var totalByte = 0;
    var k = 0;
    for (var i = 0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);

        if (currentByte > 128)
            totalByte += 2;
        else
            totalByte++;

        if (totalByte >= remainByte)
            break;
        k++;
    }
    return k;
}

/**
 * 최대 용량 정보 가져오기
 * 
 * @returns
 */
function getLimit() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_LIMITE',
        enableNA : true
    }, function(result) {
        var text = "L" + chnlCode;
        var size = result.rows.length;

        // 각 LMS,SMS 등에 맞는 용량 가져오기.
        for (var i = 0; i < size; i++) {
            if (result.rows[i].codeName == text) {
                rcp.limitStore = result.rows[i].attrib01;
            }
        }
    });
}

/**
 * 저장 버튼클릭 시 동작
 */
function actionContent() {
    var resultFlag = false;

    rcp.receiptValid = rcp.receiptValidation.confirm();

    if (rcp.receiptValid == true) {
        checkLength();
        
        if (rcp.limitCHk == true) {

            // 상세 페이지일 시 수정 작업 동작
            if ((typeof (camId) != "undefined" && (camId == null || camId == 'null'))) {
                alert('<spring:message code="M00710"/>');
            }
            else if ((typeof (quickFlag) != "undefined" && quickFlag != null 
                    && $("#benefitSelect option:selected").attr('value') == 'direct' 
                    && $("#benefitDirectInput").val().length == 0)) {
                alert('<spring:message code="M00711"/>');
            }
            else {
                if (rcp.detail == true) {
                    // 콘텐츠 수정
                    $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                        id                  : conid,
                        contentsName        : $("#contentsName").val(),
                        contentsType        : chnlCode,
                        contentsFlag        : $("#contentsFlag").val(),
                        contents            : $("#smsTextArea").val(),
                        textByteSize        : $("#textByteSize").val(),
                        html                : $("#html").val(),
                        camFlag             : camFlag,
                        attrib01            : $("input[name=autoCutYN]:checked").val(),
                        attrib02            : $("input[name=barcodeYN]:checked").val(),
                        attrib03            : $("input[name=qrcodeYN]:checked").val(),
                        attrib04            : $("#qrcodeUrl").val(),
                        attrib05            : $("#barcodeNo").val(),
                        
                    }, function(result) {
                        if (rcp.previewChk == false) {
                            alert('<spring:message code="M00429"/>');
                        }

                        idCheck();
                        if (typeof (camId) != "undefined" && quickFlag != null) {
                            try { quickSaveMessage(conid); } catch (e) { }
                        }
                        resultFlag = true;
                    });
                }
                // 상세 페이지가 아닐 시 insert 동작
                else {
                    var camFlag = 0;
                    var campaignWorkflowFlag = $("#campaignWorkflowFlag").val();
                    // 퀵캠페인 또는 캠페인 워크플로우인지 확인한다.
                    if ((typeof (quickFlag) != "undefined" && quickFlag != null)
                            || $.fn.ifvmIsNotEmpty(campaignWorkflowFlag)) {
                        camFlag = '1';
                    }

                    $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {

                        contentsName        : $("#contentsName").val(),
                        contentsType        : chnlCode,
                        contentsFlag        : $("#contentsFlag").val(),
                        contents            : $("#smsTextArea").val(),
                        textByteSize        : $("#textByteSize").val(),
                        html                : $("#html").val(),
                        camFlag             : camFlag,
                        attrib01            : $("input[name=autoCutYN]:checked").val(),
                        attrib02            : $("input[name=barcodeYN]:checked").val(),
                        attrib03            : $("input[name=qrcodeYN]:checked").val(),
                        attrib04            : $("#qrcodeUrl").val(),
                        attrib05            : $("#barcodeNo").val(),

                    }, function(result) {
                        if (rcp.previewChk == false) {
                            alert('<spring:message code="M00430"/>');
                        }
                        conid = result.message;
                        rcp.detail = true;
                        if (typeof (camId) != "undefined" && quickFlag != null) {
                            try { quickSaveMessage(conid); } catch (e) { }
                        }

                        if (typeof (directFlag) != "undefined" && directFlag != null) {
                            directSaveMessage(conid);
                        }
                        resultFlag = true;
                    });
                }
                rcp.previewChk = false;
            }
        }
    }
    return resultFlag;
}

function checkInput(i) {
    var regExpStr = "[^0-9|^ㄱ-ㅎ|^ㅏ-ㅣ|^가-힣|^a-z|^\\s|^\\r\n|^\\n|^`~!@#$%^&*()-=[\\]\;',./'";
    $("#btnSpcArea button").each(function(i,e) {
        regExpStr += "|^" + $(e).text().trim();
    });
    regExpStr += "]"
    
    var replaceStr = $("#"+i).val().replace(new RegExp(regExpStr,"gi"),"");
    $("#"+i).val(replaceStr);
}

/**
 * QR코드 사용여부 변경
 */
function changeQrcodeYN() {
    var qrcodeYN = $('input[name=qrcodeYN]:checked').val();
    if (qrcodeYN == 'Y') {
        $('#qrcodeUrl').attr('required', true);
        $('#qrcodeUrl').prop('readonly', false);
        $('#qrcodeImgBox').show();
    }
    else {
        $('#qrcodeUrl').removeAttr('required');
        $('#qrcodeUrl').prop('readonly', true);
        $('#qrcodeUrl').val('');
        $('#qrcodeImgBox').hide();
    }
    rcp.receiptValidation = $("#receiptFormArea").ifvValidation();
}

/**
 * 바코드 사용여부 변경
 */
function changeBarcodeYN() {
    var barcodeYN = $('input[name=barcodeYN]:checked').val();
	if (barcodeYN == 'Y') {
        $('#barcodeNo').attr('required', true);
        $('#barcodeNo').prop('readonly', false);
        $('#barcodeImgBox').show();
	}
	else {
        $('#barcodeNo').removeAttr('required');
        $('#barcodeNo').prop('readonly', true);
        $('#barcodeImgBox').hide();
	}
	rcp.receiptValidation = $("#receiptFormArea").ifvValidation();
}

//현재 커서 위치에 특수문자 값 추가하기
function insertAtCursor(area,text) {
    var smsTextArea = document.getElementById(area);
    var scrollPos = smsTextArea.scrollTop;
    var strPos = 0;
    var br = ((smsTextArea.selectionStart || smsTextArea.selectionStart == '0') ?
        "ff" : (document.selection ? "ie" : false ) );
    if (br == "ie") {
        smsTextArea.focus();
        var range = document.selection.createRange();
        range.moveStart ('character', -smsTextArea.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") strPos = smsTextArea.selectionStart;
 
    var front = (smsTextArea.value).substring(0,strPos);
    var back = (smsTextArea.value).substring(strPos,smsTextArea.value.length);
    smsTextArea.value=front+text+back;
    strPos = strPos + text.length;
    if (br == "ie") {
        smsTextArea.focus();
        var range = document.selection.createRange();
        range.moveStart ('character', -smsTextArea.value.length);
        range.moveStart ('character', strPos);
        range.moveEnd ('character', 0);
        range.select();
    }
    else if (br == "ff") {
        smsTextArea.selectionStart = strPos;
        smsTextArea.selectionEnd = strPos;
        smsTextArea.focus();
    }
    smsTextArea.scrollTop = scrollPos;
}

//popup 높이 맞추기
function initPopupHeight() {
    try {
    	if(cDialog) {
            setTimeout(function() {
                new ifvm.PopupHeight({
                    popupDivId : 'dialog',
                    contentsId : 'dialogPopupWrap'
                });
                cDialog.refresh();
            }, 500);    		
    	}
    }
    catch (e) {
    }
}

$(document).ready(function() {
    
    initRunFunction();

    // 포커스 위치 저장
    $("#smsTextArea").on('blur', function() {
        rcp.focusCHeck = smsTextArea;
    });
    $("#qrcodeUrl").on('blur', function() {
        rcp.focusCHeck = qrcodeUrl;
    });

    // 입력문자 byte 수 체크 
    $("#smsTextArea").bind('keyup', function() {
        checkLength('textarea');
        checkInput('smsTextArea');
    });
    
    $("#qrcodeUrl").bind('keyup', function() {
        checkLength('url');
    });

    // 저장 버튼
    $("#saveBtn").on('click', function() {

        // 저장 
        var result = actionContent();
        if (result == true) {
            // 컨텐츠 팝업 종료
                if( typeof closeContentsDesignPop == 'function' ) {
            	closeContentsDesignPop();
            }
        }
    });

    $("input[name=autoCutYN]").on('change', function() {
        checkLength();
    });
    // 바코드 사용여부 변경 
    $("input[name=barcodeYN]").on('change', function() {
        checkLength();
        changeBarcodeYN();
    });
    // QR코드 사용여부 변경
    $("input[name=qrcodeYN]").on('change', function() {
        changeQrcodeYN();
        checkLength();
    });
    
    $("button[name=btnSpcChar]").on('click', function() {
        insertAtCursor(("smsTextArea"), $(this).text().trim());
        $("#smsTextArea").trigger('keyup');
    })
    
    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();
    
    // 유효성검사
    rcp.receiptValidation = $("#receiptFormArea").ifvValidation();

    //popup 높이 맞추기
    initPopupHeight();
});

</script>

<style>

#receiptFormArea .w100 {
    width: 100%
}

#receiptFormArea .phoneImage {
    border-radius: 0px;
    padding: 28px 20px 15px;
}

.btn_spc_char {
    width:100%;
    background-color: transparent;
    border: transparent;
    text-align:center;
}
</style>

<script id="optionTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M00374"/> &gt;  <spring:message code="M00274"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
			<span id="chnlTitleArea"></span> <span><spring:message code="M02494"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id='saveBtn'>
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
        </div>
    </div>
</div>

<div id="receiptFormArea">
    <div class="well form-horizontal content_textImage_con">
        <div class="phoneImage" >
            <div class="sms_kinds"><spring:message code="M02411"/></div>
            <div class="receiptWrap">
                <div class="textareaBox">
                    <ifvm:input type="textarea" className="sms_phone_area" id="smsTextArea"/>
                </div>
                <div class="imageBox" id="barcodeImgBox">
                    <div class="image_barcode" >
                        <div class="barcode_wrap">
                            <img src="<ifvm:image name='barcode_sample2'/>" id="barcodimg"/>
                        </div>
                    </div>
                </div>
                <div class="imageBox" id="qrcodeImgBox">
                    <div class="image_qrcode">
                        <div class="qrcode_wrap">
                            <img src="<ifvm:image name='qr_code_e1'/>" id="qrcodimg"/>
                        </div>
                    </div>
                </div>
                <label class="phone_text"><spring:message code="M00397"/></label>
                <ifvm:input type="text" className="inputText" disabled="true" id="textByteSize"/>
                <span class="phone_text"><spring:message code="M00798"/></span>
            </div>
        </div>
        <div class="guide_area">
            <div class="input_area" id="selectForm">
                <div class="row">
                
                    <%-- 컨텐츠명 --%>
                    <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="text" required="true" id="contentsName" maxLength="30"/>
                    </div>
                </div>
                <div class="row">
                
                    <%-- Auto-Cut 사용여부 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M02412"/></label>
                    <div class="col-xs-10 control_content">
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="autoCutYN" values="Y" />
                            <spring:message code="M02418"/>
                        </label>
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="autoCutYN" values="N" />
                            <spring:message code="M02419"/>
                        </label>
                    </div>
                </div>
                <div class="row">
                
                    <%-- 바코드 사용여부 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M02413"/></label>
                    <div class="col-xs-10 control_content">
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="barcodeYN" values="Y" />
                            <spring:message code="M02418"/>
                        </label>
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="barcodeYN" values="N" />
                            <spring:message code="M02419"/>
                        </label>
                    </div>
                </div>
                <div class="row">
                
                    <%-- 바코드 번호 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M02519"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="number" id="barcodeNo" maxLength="12"/>
                    </div>
                </div>
                <div class="row">
                
                    <%-- QR코드 사용여부 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M02414"/></label>
                    <div class="col-xs-10 control_content">
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="qrcodeYN" values="Y" />
                            <spring:message code="M02418"/>
                        </label>
                        <label class="radio-inline">
                            <ifvm:input type="radio" names="qrcodeYN" values="N" />
                            <spring:message code="M02419"/>
                        </label>
                    </div>
                </div>
                <div class="row">
                
                    <%-- QR코드 URL --%>
                    <label class="col-xs-1 control-label"><spring:message code="M02488"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="text" id="qrcodeUrl" />
                    </div>
                </div>
            </div>
            
            <div class="description_title"><spring:message code="S00043"/></div>
            <ul class="description_guide">
                <li><spring:message code="S00044"/></li>
                <div class="row"></div>
                <div id="btnSpcArea" class="row" style="margin-bottom: 0px; border:1px solid #d9d9d9">
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x02605</button>
                    </div>
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x02660</button>
                    </div>
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x0261E</button>
                    </div>
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x0261C</button>
                    </div>
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x025C0</button>
                    </div>
                    <div class="col-xs-1 control_content">
                        <button name="btnSpcChar" class="btn_spc_char"> &#x025B6</button>
                    </div>
                </div>
            </ul>
             <%-- 채널 가이드 --%>
            <div>
				<label class="description_title"><spring:message code="M00400"/></label>
				<div class="chnl_guide">
					<ifvm:input type="textarea" id="chnlGuide" readonly="readonly"/>
				</div>
			</div>
        </div>
    </div>
</div>

<div id="FormNewPop" class="popup_container"></div>
