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

var limitStore;	//용량 제한
var conid = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';
var kkn = {
	presmsArea            : ""    ,
	presmsTextArea        : ""    ,
	limitLength           : ""    ,
	totallength           : ""    ,
	kakaoNoticeValidation : ""    ,
	kakaoNoticeValid      : ""    ,
	kakaoNoticeFormNewPop : ""    ,
	kakaoTmp              : ""    ,
	detail                :	false ,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
	previewChk            :	false ,
	limitCHk              :	true  	
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

    // 개인화 속성 로드
    $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>', {
    }, function(result) {
        var size = result.length;
        arrStore = {};
        arrStore.markName = '<spring:message code="M00436"/>';
        for (var i = size; i >= 0; i--) {
            if (i != 0) {
                temp = result[i - 1];
                result[i] = temp;
            }
            else {
                result[0] = {};
                result[0] = arrStore;
            }
        }
        //개인화 추가
        for (var i = 1; i <= 5; i++) {
            result.push({markName : '개인화' + i});
        }
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal").append(temp);
    });

    // 템플릿 유형
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'KAKAO_TEMP_TYPE_CD',
        enableNA : true
    }, function(result) {
        var size = result.rows.length;
        arrStore = {};
        arrStore.markName = '<spring:message code="M00436"/>';
        kakaoTmp = result.rows;

        for (var i = size; i >= 0; i--) {
            if (i != 0) {
                temp = result.rows[i - 1];
                result.rows[i] = temp;
            }
            else {
                result.rows[0] = {};
                result.rows[0] = arrStore;
            }
        }
        var temp = $("#templateCodeTemp").tmpl(result.rows);
        $("#templateType").append(temp);
    });

    // 버튼명 공통 코드.
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'KAKAO_BTN_TYPE_CD',
        enableNA : false
    }, function(result) {
        var size = result.rows.length;
        arrStore = {};
        arrStore.markName = '';
        for (var i = size; i >= 0; i--) {
            if (i != 0) {
                temp = result.rows[i - 1];
                result.rows[i] = temp;
            }
            else {
                result.rows[0] = {};
                result.rows[0] = arrStore;
            }
        }
        var temp = $("#optionTemp").tmpl(result.rows);
        $("#btnName").append(temp);
        
        //버튼 모바일 URL 기본값
        var temp2 = $("#optionTemp2").tmpl(result.rows);
        $("#btnNameUrlMobile").append(temp2);
        
        //버튼 PC URL 기본값
        var temp3 = $("#optionTemp3").tmpl(result.rows);
        $("#btnNameUrlPc").append(temp3);
    });
}

/**
 * 상세 페이지인지 체크
 * @returns
 */
function idCheck() {
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
                $("#smsArea").val(result.title);
                $("#smsTextArea").val(result.contents);
                $("#textByteSize").val(result.textByteSize);
                $("#templateCode").val(result.attrib01);
                $('#btnName').val(result.attrib02);
                $('#btnNameUrlMobile').val(result.attrib03);
                $('#btnNameUrlPc').val(result.attrib04);
                $("#chnlGuide").val(result.chnlGuide);
                $('input[type=radio][name=custMessageType][value='+result.attrib05+']').attr('checked', true);
                $("#templateType option[data-attrib01='" + result.attrib01 + "']").prop('selected', true);
            }
        });
        detail = true;
    }
}

/**
 * 개인화속성 값으로 길이 구하기
 */
function getPersnalSize(_str) {
    var txt = _str.replace('$$', '').replace('$$', '');
    var valMaxSize = 0;
    if ($.fn.ifvmIsNotEmpty(txt)) {
        valMaxSize = $('#persnal option[value="' + txt + '"]').data('valMaxSize');
    }
    return valMaxSize;
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
						if ($.fn.ifvmIsNotEmpty(result)) {
					    	$("#chnlGuide").val(result.chnlGuide);
						}   
					});		
                if (result.rows[i].markName == chnlCode) {
                    typeCodeId = result.rows[i].codeId;
                    exeContype = result.rows[i].codeName;
                    chnlCode = result.rows[i].codeName;
                }
            }
            // 상세 페이지 일 시
            else {
                if (exeContype != null) {
                    if (exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
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
}

/**
 * 콘텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
 */
function checkLength(inputType) {
    var inputMessage = $("#smsArea").val();
    var textareaMessage = $("#smsTextArea").val();

    var inputLength = Number(totalLengthcheck(inputMessage));
    var textareaLength = Number(totalLengthcheck(textareaMessage));
    var totalLength = inputLength + textareaLength;
    totallength = totalLength;
    limitLength = limitStore;

    $(".description_guide li").eq(0).text('<spring:message code="M02404"/>' + ' <spring:message code="M00452"/> ' + limitStore + ' <spring:message code="M02409"/>');

    $("#textByteSize").val(totalLength);

    // 길이 초과인 경우
    if (totalLength > limitLength) {
        limitCHk = false;
        alert(limitLength + "<spring:message code='M02416'/>");
        $("#textByteSize").val(limitLength);
        if (inputType == "input") {
            var remainLength = limitLength - textareaLength;
            var k = cutMessage(inputMessage, remainLength);
            $('#smsArea').val(inputMessage.substring(0, k));
        }
        else if (inputType == "textarea") {
            var remainLength = limitLength - inputLength;
            var k = cutMessage(textareaMessage, remainLength);
            $('#smsTextArea').val(textareaMessage.substring(0, k));
        }
        // parameter가 없는경우 본문을 자른다.
        else {
            var remainLength = limitLength - inputLength;
            var k = cutMessage(textareaMessage, remainLength);
            $('#smsTextArea').val(textareaMessage.substring(0, k));
        }
    }
    else {
        limitCHk = true;
    }
}

/**
 * 총 길이 체크 (콘텐츠 내용을 체크하여 총용량을 계산한다.)
 *
 * @param message
 * @returns
 */
function totalLengthcheck(message) {
    var totalLength = 0;
    var message_unclude_persnal = message;

    // 개인화 속성 길이 고려할 것.
    if (message != null && message.length > 0) {
        var persnalRegex = /\\$\\$[ㄱ-힣a-zA-Z\\(\\)]*\\$\\$/g;
        var arry;
        while ((arry = persnalRegex.exec(message)) != null) {
            var size = Number(getPersnalSize(arry[0]));
            if (size > 0) {
                message_unclude_persnal = message_unclude_persnal.replace(arry[0], '');
                totalLength += size;
            }
        }
    }

    for (var i = 0; i < message_unclude_persnal.length; i++) {
        totalLength++;
    }
    return totalLength;
}

function cutMessage(message, remainLength) {
    var totalLength = 0;
    var k = 0;
    for (var i = 0; i < message.length; i++) {
        totalLength++;
        if (totalLength >= remainLength) {
            break;
        }
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
                limitStore = result.rows[i].attrib01;
            }
        }
    });
}

/**
 * Mobile 버튼 링크 URL 포맷 체크 (필수)
 */
function checkUrlMobile(urlObj) {
    if ($.fn.ifvmIsNotEmpty(urlObj.val())) {
	    if (urlObj.val().startsWith('http://') || urlObj.val().startsWith('https://')) return true;
	    else {
	        validFailMessage(urlObj, '<spring:message code="C00029"/>');
	        return false;
	    }
    }
    else {
		return true;
    }
}

/**
 * PC 버튼 링크 URL 포맷 체크 (필수 아님)
 */
function checkUrlPc(urlObj) {
    if ($.fn.ifvmIsNotEmpty(urlObj.val())) {
	    if (urlObj.val().startsWith('http://') || urlObj.val().startsWith('https://')) return true;
	    else {
	        validFailMessage(urlObj, '<spring:message code="C00029"/>');
	        return false;
	    }
    }
    else {
    	return true;
    }
}

/**
 * 저장 버튼클릭 시 동작
 */
function actionContent() {
    var resultFlag = false;

    kakaoNoticeValid = $("#kakaoNoticeFormArea").ifvValidation();
    kakaoNoticeValid = kakaoNoticeValidation.confirm();
    
    // 버튼명이 존재한다면 모바일 url도 입력해야 함.
    if ($.fn.ifvmIsNotEmpty($('#btnName').val())) {
    	if($.fn.ifvmIsEmpty($('#btnNameUrlMobile').val())) {
    		$.ifvCallValidationBox($("#btnNameUrlMobile"), '<spring:message code="M02711"/>');
        	kakaoNoticeValid = false;
    	} else {
    		kakaoNoticeValid = checkUrlMobile($('#btnNameUrlMobile')) && checkUrlPc($('#btnNameUrlPc'))
    	}
    }
    
    if (kakaoNoticeValid == true) {
        checkLength('input');

        if (limitCHk == true) {
            if (Number(totallength) < Number(limitLength)) {
                limitCHk = true
            }
        }
        if (limitCHk == true) {
            if (kakaoNoticeValid == true) {


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
                    if (detail == true) {
                        // 콘텐츠 수정
                        $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                            id                  : conid,
                            contentsName        : $("#contentsName").val(),
                            contentsType        : chnlCode,
                            contentsFlag        : $("#contentsFlag").val(),
                            title               : $("#smsArea").val(),
                            attrib01            : $("#templateCode").val(),
                            attrib02            : $("#btnName").val(),
                            attrib03            : $("#btnNameUrlMobile").val(),
                            attrib04            : $("#btnNameUrlPc").val(),
                            attrib05            : $("input[type=radio][name=custMessageType]:checked").val(),
                            contents            : $("#smsTextArea").val(),
                            textByteSize        : $("#textByteSize").val(),
                            camFlag             : camFlag,
                        }, function(result) {
                            if (previewChk == false) {
                                alert('<spring:message code="M00429"/>');
                            }

                            idCheck();
                            if (typeof (camId) != "undefined" && quickFlag != null) {
                                quickSaveMessage(conid);
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
                            title               : $("#smsArea").val(),
                            attrib01            : $("#templateCode").val(),
                            attrib02            : $("#btnName").val(),
                            attrib03            : $("#btnNameUrlMobile").val(),
                            attrib04            : $("#btnNameUrlPc").val(),
                            attrib05            : $("input[type=radio][name=custMessageType]:checked").val(),
                            contents            : $("#smsTextArea").val(),
                            textByteSize        : $("#textByteSize").val(),
                            camFlag             : camFlag,
                        }, function(result) {
                            if (previewChk == false) {
                                alert('<spring:message code="M00430"/>');
                            }
                            conid = result.message;
                            kkn.detail = true;
                            if (typeof (camId) != "undefined" && quickFlag != null) {
                                quickSaveMessage(conid);
                            }

                            if (typeof (directFlag) != "undefined" && directFlag != null) {
                                directSaveMessage(conid);
                            }

                            resultFlag = true;
                        });
                    }
                }
            }
        }
        else {
            alert(limitLength + "<spring:message code='M00431'/>");
        }
        previewChk = false;
    }
    return resultFlag;
}

/**
 * 프리뷰 팝업 종료
 */
function mmsFormNewPopClose() {
    kakaoNoticeFormNewPop._destroy();
}

/**
 * 현재 커서 위치에 개인화 속성 값 추가하기
 */
function insertAtCursor(area, text) {
    var smsTextArea = document.getElementById(area.id);
    var scrollPos = smsTextArea.scrollTop;
    var strPos = 0;
    var br = ((smsTextArea.selectionStart || smsTextArea.selectionStart == '0') ? "ff" : (document.selection ? "ie" : false));
    if (br == "ie") {
        smsTextArea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -smsTextArea.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") {
        strPos = smsTextArea.selectionStart;
    }

    var front = (smsTextArea.value).substring(0, strPos);
    var back = (smsTextArea.value).substring(strPos, smsTextArea.value.length);
    smsTextArea.value = front + text + back;
    strPos = strPos + text.length;
    if (br == "ie") {
        smsTextArea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -smsTextArea.value.length);
        range.moveStart('character', strPos);
        range.moveEnd('character', 0);
        range.select();
    }
    else if (br == "ff") {
        smsTextArea.selectionStart = strPos;
        smsTextArea.selectionEnd = strPos;
        smsTextArea.focus();
    }
    smsTextArea.scrollTop = scrollPos;
}

$(document).ready(function() {

    initRunFunction();

    // 포커스 위치 저장
    $("#smsTextArea").on('blur', function() {
        focusCHeck = smsTextArea;
    });
    $("#smsArea").on('blur', function() {
        focusCHeck = smsArea;
    });

    // 입력문자 byte 수 체크
    $("#smsTextArea").bind('keyup', function() {
        checkLength('textarea');
    });
    $("#smsArea").bind('keyup', function() {
        checkLength();
    });

    // 저장 버튼
    $("#saveBtn").on('click', function() {

        // 저장
        var resultFlag = actionContent();

        // 컨텐츠 팝업 종료
        if (resultFlag == true) {
            closeContentsDesignPop();
        }
    });

    // 개인화 속성
    $("#persnal").on('change', function() {
        var text = "$$" + $("#persnal option:selected").text() + "$$";
        if (focusCHeck == smsTextArea) {
            insertAtCursor(smsTextArea, text);
        }
        else {
            insertAtCursor(smsArea, text);
        }
        $("#persnal option:eq(0)").attr("selected","selected")
        checkLength();
    });

    // 메세지 템플릿
    $('#templateType').on('change', function() {
        $('#smsArea').val('');
        $('#smsTextArea').val('');

        if ($.fn.ifvmIsNotEmpty($('#templateType').val())) {
            if ($.fn.ifvmIsNotEmpty(kakaoTmp)) {
                kakaoTmp.forEach(function(data) {
                    if (data.codeName == $('#templateType').val()) {
                        $('#templateCode').val(data.attrib01);
                        $('#smsArea').val(data.attrib03);
                        $('#smsTextArea').val(data.attrib02);
                    }
                });
            }
        }

        // 입력 문자수 계산
        initLengthCheck();
    });

    //테스트 발송
    $('#kakaoNoticePreviewBtn').on('click', function() {

        previewChk = true;
        presmsArea = $('#smsArea').val();
        presmsTextArea = $('#smsTextArea').val();

        // 저장
        var resultFlag = actionContent();

        // byte 체크
        checkLength('input');

        if (limitCHk == true) {
            if (Number(totallength) < Number(limitLength)) {
                limitCHk = true;
            }
        }

        if (kkn.limitCHk == false) {
            return;
        }
        if (conid != 'null') {
            
            // 상세정보 
            idCheck();

            $("#kakaoNoticeFormNewPop").ifvsfPopup({
                enableModal : true,
                enableResize : false,
                contentUrl : '<ifvm:url name="MKTKakaoNoticePreviewPop"/>',
                contentType : "ajax",
                title : '<spring:message code="M00419"/>',
                width : 630,
                close : 'mmsFormNewPopClose'
            });
        }
        else alert('<spring:message code="M00448"/>');
    });

    // 개인화 버튼 숨김
    $('#persnalArea').hide();
    $('#uploadPersnalTypeBtn').hide();

    // 유효성검사
    kakaoNoticeValidation = $("#kakaoNoticeFormArea").ifvValidation();

});

</script>

<style>

#kakaoNoticeFormArea .w100 {
    width: 100%
}

</style>

<script id="templateCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" data-attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>

<script id="optionTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="optionTemp2" type="text/x-jquery-tmpl">
<option value="${'${'}attrib01}">${'${'}attrib01}</option>
</script>

<script id="optionTemp3" type="text/x-jquery-tmpl">
<option value="${'${'}attrib02}">${'${'}attrib02}</option>
</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M00374"/> &gt;  <spring:message code="M00274"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M02494"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id='saveBtn'>
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
            <button class="btn btn-sm" id="kakaoNoticePreviewBtn">
                <spring:message code="M00392"/>
            </button>
        </div>
    </div>
</div>

<div id="kakaoNoticeFormArea">
    <div class="well form-horizontal content_textImage_con">
        <div class="phoneImage">
            <div class="sms_kinds"><spring:message code="M02404"/></div>
            <div class="phoneWrap">
                <ifvm:input type="text" id="smsArea" placeholder="M00394"  maxLength="50" readonly="readonly" />
                <ifvm:input type="textarea" id="smsTextArea" className="sms_phone_area" readonly="readonly" />
                <label class="phone_text"><spring:message code="M00397"/></label>
                <ifvm:input type="text" id="textByteSize" className="inputText" disabled="true" />
                <span class="phone_text"><spring:message code="M02415"/></span>
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
                	<ifvm:input type="hidden" id="templateCode" />

                    <%-- 템플릿 유형 --%>
                    <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M02841"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="select" required="true" id="templateType"/>
                    </div>
                </div>
                <div class="row" id="persnalArea" >

                    <%-- 개인화 속성 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M00398"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="select" id="persnal" />
                    </div>
                </div>
                
                <div class="row">
	                <%-- 버튼명 --%>
	                <label class="col-xs-1 control-label"><spring:message code="M02406"/></label>
	                <div class="col-xs-2 control_content">
	                    <ifvm:input type="select" className="w100" id="btnName"/>
	                </div>
	            </div>
				
				<div class="row">
	                <%-- 모바일 URL --%>
	                <label class="col-xs-1 control-label">Mobile URL</label>
	                <div class="col-xs-6 control_content">
	                    <ifvm:input type="select" className="w100" id="btnNameUrlMobile" maxLength="100" />
	                </div>
	            </div>
	            
	            <div class="row">
	                <%-- PC URL --%>
	                <label class="col-xs-1 control-label">PC URL</label>
	                <div class="col-xs-6 control_content">
	                    <ifvm:input type="select" className="w100" id="btnNameUrlPc" maxLength="100" />
	                </div>
	            </div>
	            
	            <%-- 부달 처리 --%>
	            <div class="row">
	            	<ifvm:inputNew type="radio" id="custMessageType" names="custMessageType" text="M02884|M02885|M02886" values="X|S|L" label="M02887" labelClass="1" conClass="10" checkIndex="1" />
	            </div>
                
            </div>
            <%-- 작성 가이드 --%>
<%-- 			<div>
				<label class="description_title"><spring:message code="M00400"/></label>
				<div class="chnl_guide">
					<ifvm:input type="textarea" id="chnlGuide" readonly="readonly"/>
				</div>
			</div> --%>
        </div>
    </div>
</div>

<div id="FormNewPop" class="popup_container"></div>
<div id="kakaoNoticeFormNewPop" class="popup_container"></div>