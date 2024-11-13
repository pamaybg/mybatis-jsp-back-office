<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<style>
#kakaoFormArea .w100 {
	width: 100%
}
</style>
<script>

var openType = $.ifvGetParamValue("openType"); // 오픈유형

var imgId;
var limitStore;
var limitImgStore;
var conid = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>' ;
var kko = {
	kakaoFormNewPop		  :	""	,
	limitLength			  :	""	,
	totallength			  :	""	,
	typeCodeId			  :	""  ,
	limitStore_includeImg :	""  ,	//용량 제한 (이미지를 포함하고 있을때)
	chnl                  :	""  ,	//테스트 발송 시 mms,sms 등의 채널 구분을 위한 변수.
	barSrc                :	""  ,
	imgSrc                :	""  ,
	barcodeId             :	""  ,
	exeContype            :	""  ,
	kakaoValidation       :	""  ,
	kakaoValid            :	""  ,
	mergeCheck            :	true  ,	//이미지, 바코드에 변경이 일어날시 false를 시켜 머지 이미지를 생성한다.
	detail                :	false ,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
	focusCHeck            :	null  ,
	previewChk            :	false ,
	limitCHk              :	true  
}

/**
 * 초기 실행할 펑션들.
 * 
 * @returns
 */
function initRunFunction() { 
    barcodeImageSetting(); // 바코드 추가 전 초기 이미지 세팅
    initComm(); // 공통코드 설정
    idCheck(); // 상세 정보 조회
    getChcnltype(); // 현재 채널 타입 조회
    getLimit();     // 입력 제한 조회
    initLengthCheck(); // byte 수 체크   
    photoUrl = null;
    setTimeout(function() {
        setImageFileLimitGrid();
    }, 50);
}

/**
 * 팝업 닫기
 * @returns
 */
function mmsFormNewPopClose() {
   kakaoFormNewPop._destroy();
}




/**
 * 상세 페이지인지 체크
 * 
 * @returns
 */
function idCheck() {
	var merId;
    if (conid != "null") {    
        // 상세 페이지일 경우 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getMmsDtlList"/>', {
            id : conid
        }, function(result) {
            kko.barcodeId = result.barId;
            imgId = result.imgId;
            merId = result.merId;
            $("#contentsName").val(result.contentsName);
            kko.exeContype = result.contentsType;
            $("#smsArea").val(result.title);
            $("#mmsTextArea").val(result.contents);
            $("#txtMsgObject").val(result.txtMsgObject);
            $('#btnName').val(result.attrib01);
            $('#btnNameUrl').val(result.attrib02);
            $('#imgLinkUrl').val(result.imgLinkUrl);
            $("#chnlGuide").val(result.chnlGuide);
            
            if (result.imagepath != null) {
                var path = '<ifvm:url name="imageView"/>' + result.imagepath;
                $('#mmsImage').attr('src', path);
                $('.image_close').show();
                $("#imgCnt").val(1);
            }
            if (result.barpath != null) {
                var textStore = [];
                textStore = result.barpath.split('.');
                $('#barcodimg').attr('src', '/' + textStore[0] + "." + textStore[1].toLowerCase());
                $("#imgBarCnt").val(1);
            }
            if (result.merpath != null) {
                photoUrl = '/' + result.merpath;
            }
            if (result.imagepath != null && result.imagepath != null) {
                kko.mergeCheck = false
            }
            $("#textByteSize").val(result.textByteSize);
            $("#imgSize").val(result.imgSize);
            $("#imgCnt").val(result.imgCnt);
        });
        kko.detail = true;
    }
    else {
        //메세지 유형 설정
        setTxtMsg();
    }
}

/**
 * 초기 로딩 시 글자 수 체크
 */
function initLengthCheck() {
    checkLength('textarea');
}


function getFileSize(){
	   $.ifvSyncPostJSON('<ifvm:action name="getImgSize"/>', {
           id : imgId
       }, function(result) {
    	   limitImgStore = result.imgSize;
       });
           
}
/**
 * 콘텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
 */
function checkLength(inputType) {
    var inputMessage = $("#smsArea").val();
    var textareaMessage = $("#mmsTextArea").val();

    var inputLength = Number(totalLengthcheck(inputMessage));
    var textareaLength = Number(totalLengthcheck(textareaMessage));
    var totalLength = inputLength + textareaLength;
    kko.totallength = totalLength;
    kko.limitLength = limitStore;
    

    $("#textByteSize").val(totalLength);
    // 길이 초과인 경우 
    if (totalLength > kko.limitLength) {
        kko.limitCHk = false;
        alert(kko.limitLength + "<spring:message code='M02416'/>");
        $("#textByteSize").val(kko.limitLength);
        if (inputType == "input") {
            var remainLength = kko.limitLength - textareaLength;
            var k = cutMessage(inputMessage, remainLength);
            $('#smsArea').val(inputMessage.substring(0, k));
        }
        else if (inputType == "textarea") {
            var remainLength = kko.limitLength - inputLength;
            var k = cutMessage(textareaMessage, remainLength);
            $('#mmsTextArea').val(textareaMessage.substring(0, k));
        }
        // parameter가 없는경우 본문을 자른다. 
        else {
            var remainLength = kko.limitLength - inputLength;
            var k = cutMessage(textareaMessage, remainLength);
            $('#mmsTextArea').val(textareaMessage.substring(0, k));
        }
    }
    else {
        kko.limitCHk = true;
    }
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
            	// 작성 가이드 셋팅
	            $.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
	            	chnltype : chnlCode
	            }, function(result) {
	    			if ($.fn.ifvmIsNotEmpty(result)) {
	    		    	$("#chnlGuide").val(result.chnlGuide);
	    			}
	            });    	
                if (result.rows[i].codeName == chnlCode) {
                    console.log()
                    kko.typeCodeId = result.rows[i].codeId;
                    kko.exeContype = result.rows[i].codeName;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            // 상세 페이지 일 시
            else {
                if (kko.exeContype != null) {
                    if (kko.exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
            }
        }
    });
}


/**
 * 이미지, 파일 제한 그리드
 * 
 * @returns
 */
function setImageFileLimitGrid() {
    var chnltypeId;
	
    $.ifvSyncPostJSON('<ifvm:action name="getChnlId"/>', {
        chnltype : chnlCode
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            chnltypeId = result.chnlId;
        }
    });

    var jqGridOption = {
        onSelectCell : function(data) {
            selectChilRow = data.id;
        },
        url : '<ifvm:action name="getImgOption"/>',
        serializeGridData : function(data) {
            data.mktChlId = chnltypeId
        },
        colNames:[
                  '<spring:message code="M00491"/>', 
                  '<spring:message code="M00492"/>', 
                  '<spring:message code="M00493"/>', 
                  '<spring:message code="M00494"/>',
                  'id'
        ],
        colModel:[
            {name:'upldEtsionCd', index:'c1.mark_name',     resizable : false,  align:"left" }, 
            {name:'maxVol',       index:'mcc.max_vol',      resizable : false,  align:"right", formatter: $.fn.comma},
            {name:'imgResolW',    index:'mcc.img_resol_w',  resizable : false,  align:"right"}, 
            {name:'imgResolH',    index:'mcc.img_resol_h',  resizable : false,  align:"right"},
            {name:'id',           index:'id',               hidden : true,  searchable : false}
        ],
        autowidth : true,
        sortname : 'seq',
        sortorder : "asc",
        tempId : 'LimitPopTemplete',
        emptyRows : true
    };
    imageFileLimitGrid = $("#imageFileLimitGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
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
    	var currentByte = message_unclude_persnal.charCodeAt(i);
        totalLength++;
    }
    return totalLength;
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
 * 바코드 추가 전 초기 이미지 세팅 
 * (영어,한글 버전에 따라 이미지가 달라진다.)
 * @returns
 */
function barcodeImageSetting() {
    if (window.lang == "ko") {
        $("#barcodimg").attr('src', '<ifvm:image name="barcode_def"/>');
    }
    else {
        $("#barcodimg").attr('src', '<ifvm:image name="barcode_def_en"/>');
    }
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
        var temp = $("#persnaltemp").tmpl(result);
        $("#persnal").append(temp);
    });

    // Text message 유형 공통 코드.
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'TXT_MSG_OBJECT_CD',
        enableNA : true
    }, function(result) {
		var size = result.rows.length;
		var arry = new Array();
		for (var i = size; i > 0; i--) {
			if (i != 0) {
				temp = result.rows[i - 1];
				arry[i-1] = temp;
			}
		}
		var temp = $("#optionTemp").tmpl(result.rows);
		$("#txtMsgObject").append(temp);        
    });
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
                kko.limitStore_includeImg = result.rows[i].attrib02;    // 이미지를 포함하고 있을때 문자제한
            }
        }
    });
}

/**
 * 저장 버튼클릭 시 동작
 *
 * @returns
 */
function actionContent() {
    var resultFlag = false;

    // 버튼명이 존재한다면 url도 입력해야 함. 
    if ($.fn.ifvmIsNotEmpty($('#btnName').val())) {
        $('#btnNameUrl').attr('required', "true");
    }
    else $('#btnNameUrl').removeAttr('required');
    
    kko.kakaoValidation = $("#kakaoFormArea").ifvValidation();
    kko.kakaoValid = kko.kakaoValidation.confirm() && checkUrl($('#btnNameUrl'));
    
    if (kko.kakaoValid == true) {
        
        checkLength();

        if (kko.limitCHk == true) {
            if (Number(kko.totallength) < Number(kko.limitLength)) {
                kko.limitCHk = true
            }
        }
        if (kko.limitCHk == false) {
            return;
        }

        if ($("#mmsImage").attr('src').substring(1).length > 0) {
            var idx = $("#mmsImage").attr('src').indexOf("=");
            kko.imgSrc = $("#mmsImage").attr('src').substring(idx + 1);
        }
        else {
            kko.imgSrc = '';
        }

        if ($("#imgCnt").val() != 1) {
            imgId = null;
        }

        if ($("#imgBarCnt").val() == 1) {
            if ($("#barcodimg").attr('src').substring(1).length > 0) {
                kko.barSrc = $("#barcodimg").attr('src').substring(1);
            }
            else {
                kko.barSrc = '';
            }
        }

        // 상세 페이지일 시 수정 작업 동작
        if ((typeof (camId) != "undefined" && (camId == null || camId == 'null'))) {
            alert('<spring:message code="M00710"/>');
        }
        else if ((typeof (quickFlag) != "undefined" 
                    && quickFlag != null 
                    && $("#benefitSelect option:selected").attr('value') == 'direct'
                    && $("#benefitDirectInput").val().length == 0)) {
            alert('<spring:message code="M00711"/>');
        }
        else {
            
            // 채널에 셋팅된 이미지 타입 조회
            actionInit();
            
            // 바코드 생성
            createBarcode();
            
            // 상세 페이지일 시 수정 작업 동작
            if (kko.detail) {
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                      contentsName     : $("#contentsName").val()
                    , contentsFlag     : $("#contentsFlag").val()
                    , title            : $("#smsArea").val()
                    , txtMsgObject     : $("#txtMsgObject").val()
                    , contents         : $("#mmsTextArea").val()
                    , html             : $("#html").val()
                    , textByteSize     : $("#textByteSize").val()
                    , imgSize          : $("#imgSize").val()
                    , imgCnt           : $("#imgCnt").val()
                    , imgBarCnt        : $("#imgBarCnt").val()
                    , imgLinkUrl       : $("#imgLinkUrl").val()
                    , filePath         : kko.imgSrc
                    , barPath          : kko.barSrc
                    , imgId            : imgId
                    , barId            : kko.barcodeId
                    , id               : conid
                    , chnlId           : kko.exeContype
                    , merCheck         : kko.mergeCheck
                    , attrib01         : $("#btnName").val()
                    , attrib02         : $("#btnNameUrl").val()
                }, function(result) {
                    if (kko.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }

                    idCheck();
                    
                    if (typeof (camId) != "undefined"
                        && typeof (quickFlag) != "undefined" 
                        && quickFlag != null) {
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
                    resultFlag = true;
                });
            }
            else {
                var camFlag = 0;
                var campaignWorkflowFlag = $("#campaignWorkflowFlag").val();
                // 퀵캠페인 또는 캠페인 워크플로우인지 확인한다.
                if ((typeof (quickFlag) != "undefined" && quickFlag != null) 
                        || $.fn.ifvmIsNotEmpty(campaignWorkflowFlag)) {
                    camFlag = '1';
                }
                //상세 페이지가 아닐 시 insert 동작
                $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
                      contentsName     : $("#contentsName").val()
                    , contentsChannel  : $("#contentsChanne").val()
                    , contentsType     : chnlCode
                    , contentsFlag     : $("#contentsFlag").val()
                    , title            : $("#smsArea").val()
                    , txtMsgObject     : $("#txtMsgObject").val()
                    , contents         : $("#mmsTextArea").val()
                    , html             : $("#html").val()
                    , textByteSize     : $("#textByteSize").val()
                    , imgSize          : $("#imgSize").val()
                    , imgCnt           : $("#imgCnt").val()
                    , imgBarCnt        : $("#imgBarCnt").val()
                    , imgLinkUrl       : $("#imgLinkUrl").val()
                    , filePath         : kko.imgSrc
                    , barPath          : kko.barSrc
                    , imgId            : imgId
                    , barId            : kko.barcodeId
                    , camFlag          : camFlag
                    , merCheck         : kko.mergeCheck
                    , chnlId           : kko.exeContype
                    , attrib01         : $("#btnName").val()
                    , attrib02         : $("#btnNameUrl").val()
                }, function(result) {
                    if (kko.previewChk == false) {
                        alert('<spring:message code="M00430"/>');
                    }
                    conid = result.message;
                    kko.detail = true;

                    idCheck();
                    if (typeof (camId) != "undefined" && quickFlag != null) {
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
                    resultFlag = true;
                });
            }
            kko.previewChk = false;
        }
    }
    return resultFlag;
}

function createBarcode() {
	var offerClick = false;  //쿠폰번호를 클릭했는지 체크
    if ($("#imgBarCnt").val() != 0) {
        // 쿠폰을 생성했는지 체크하여 이미지 생성
        if (offerClick == true) {
            kko.mergeCheck = false
            var fid;
            $.ifvSyncPostJSON('<ifvm:action name="getBarcode"/>', {
                idfyNO : barNumber,
                applyStrDate : barstart,
                applyEndDate : barend,
                chnlId : kko.exeContype,
                fileType : BarcodefileType
            }, function(result) {
                var path = result.barpath;
                kko.barcodeId = result.barId;
                $("#barcodimg").attr('src', path)
                kko.barSrc = path;
            });
            offerClick == false
        }
    }
}

/**
 * 팝업 닫기
 */
function formNewPopClose() {
    FormNewPop._destroy();
}

/**
 * 채널에서 세팅된 이미지 타입 구해오기
 * 
 * @returns
 */
function actionInit() {
    $.ifvSyncPostJSON('<ifvm:action name="getNewImgUpType"/>', {
    }, function(result) {
        var text = []
        var size = result.length;
        var type;
        text = $("#mmsImage").attr('src').split('.');

        //이미지 옵션이 생성되어 있지 않을 때 에러
        if (size == 0) {
            alert('<spring:message code="M00434"/>');
            return;
        }
        for (var i = 0; i < size; i++) {
            type = result[i].name;
            if (result[i].name == text[text.length - 1].toUpperCase()) {
                BarcodefileType = result[i].name;
                //이미지 옵션의 높이, 넓이가 설정되어 있지 않을 떄
                if (result[i].height.length == 0 || result[i].height.length == 0) {
                    alert('<spring:message code="M00435"/>');
                    return;
                }
            }
        }
        //이미지에 맞는 확장자가 세팅되어 있지 않을 시 현재 설정된 확장자로 전달.
        if (BarcodefileType.length <= 0) {
            BarcodefileType = type;
        }
        BarcodefileType = BarcodefileType.toLowerCase()
    });
}

function checkUrl(urlObj) {
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
 * 메세지 유형 설정
 */
function setTxtMsg() {
	var selectMsg = $("#txtMsgObject option:selected").text();
	var size = $("#txtMsgObject option").size();
	var addTitle = false;
	//var addContent = false;
	//제목&내용에 해당 문자열이 있는지 검사
	for (var i = 0 ; i < size ; i++) {
		var searchString = $("#txtMsgObject option").eq(i).text();
		if (addTitle == false && $("#smsArea").val().startsWith(searchString)) {
			addTitle = true;
			$("#smsArea").val($("#smsArea").val().replace(searchString, selectMsg));
		}
	//	if (addContent == false && $("#mmsTextArea").val().startsWith(searchString)) {
	//		addContent = true;
	//		$("#mmsTextArea").val($("#mmsTextArea").val().replace(searchString, selectMsg));
	//	}
	}
	if (addTitle == false) $("#smsArea").val(selectMsg + $("#smsArea").val());
	//if (addContent == false) $("#mmsTextArea").val(selectMsg + $("#mmsTextArea").val());
	 checkLength('input');
	checkLength('textarea'); 
}

$(document).ready(function() {
    initRunFunction();
    // 포커스 위치 저장
    $("#mmsTextArea").on('blur', function() {
        kko.focusCHeck = mmsTextArea;
    });
    $("#smsArea").on('blur', function() {
        kko.focusCHeck = smsArea;
    });

    // 입력문자 byte 수 체크 
    $("#mmsTextArea").bind('keyup', function() {
        checkLength('textarea');
    });
    $("#smsArea").bind('keyup', function() {
        checkLength();
    }); 
    
    // 이미지 초기화
    $("#image_remove").on('click', function() {
        $('#mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
        imgId = '';
        $("#imgCnt").val(0);
        $(this).hide();
    });

    // 바코드 초기화
    $('#remove_barcord').on('click', function() {
        barcodeImageSetting();
        $("#imgBarCnt").val(0);
        $(this).hide();
    });
    
    // 팝업창에서 이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
    $('#mmsImage').on('click', function() {
        $("#kakaoFormNewPop").ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : '<ifvm:url name="MKTAddImagePop"/>',
            contentType : "ajax",
            title : '<spring:message code="M00797"/>',
            width : 870,
            close : 'mmsFormNewPopClose'
        });

        kko.kakaoFormNewPop = $("#kakaoFormNewPop").data('ifvsfPopup');
    });

    // 저장 버튼
    $("#saveBtn").on('click', function() {
        if ($("#imgCnt").val() == 1) {
       	 getFileSize();
       	    if ($.fn.ifvmIsNotEmpty(kko.limitStore_includeImg)) {
   		    	 if(limitImgStore>kko.limitStore_includeImg){
   		    		 alert("<spring:message code='C00015'/>")
   		    	 }
   		    	 else{
   			    	//메세지유형 체크
   			    	var validTitle = $("#smsArea").val();
   			    	var checkMsg = $("#txtMsgObject option:selected").text();
   			    	if(validTitle.indexOf(checkMsg) > -1){
   			        	// 저장
   			        	var resultFlag = actionContent();
   			    	 }else{
   			    		alert('<spring:message code="M00433"/>');
   			    	} 
   			        // 컨텐츠 팝업 종료
   			        if (resultFlag == true) {
   			            if( typeof closeContentsDesignPop == 'function' ) {
   			            	closeContentsDesignPop();
   			            }
   			        }
   		        }
       	    }
     	  }
      
    });

    // 개인화 속성
    $("#persnal").on('change', function() {
        var text = "$$" + $("#persnal option:selected").text() + "$$";
        if (kko.focusCHeck == mmsTextArea) {
            insertAtCursor(mmsTextArea, text);
        }
        else {
            insertAtCursor(smsArea, text);
        }
        $("#persnal option:eq(0)").attr("selected","selected")
        checkLength();
    });

    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();
    
    //테스트 발송
    $('#kakaoPreviewBtn').on('click', function() {
        
        kko.previewChk = true;
        presmsArea = $('#smsArea').val();
        presmsTextArea = $('#mmsTextArea').val();
        
        // 채널에 셋팅된 이미지 타입 조회
        actionInit();
        
        // 저장
        var resultFlag = actionContent();
        
        // byte 체크
        checkLength('input');

        if (kko.limitCHk == true) {
            if (Number(kko.totallength) < Number(kko.limitLength)) {
                kko.limitCHk = true;
            }
        }

        if (kko.limitCHk == false) return;
        if (resultFlag == false) return;
        
        if (conid != 'null') {
            
            // 상세정보 
            idCheck();
            
            $("#kakaoFormNewPop").ifvsfPopup({
                enableModal : true,
                enableResize : false,
                contentUrl : '<ifvm:url name="MKTKakaoPreviewPop"/>',
                contentType : "ajax",
                title : '<spring:message code="M00419"/>',
                width : 650,
                close : 'mmsFormNewPopClose'
            });
            kko.kakaoFormNewPop = $("#kakaoFormNewPop").data('ifvsfPopup');
        }
        else
            alert('<spring:message code="M00448"/>');
    });
    
    // 메세지유형
    $("#txtMsgObject").change(function() {
    	//메세지 유형 설정
    	setTxtMsg();
    });

    // 유효성검사
    kko.kakaoValidation = $("#kakaoFormArea").ifvValidation();
    
	//바코드 클릭시
	$('.barcode_wrap').on('click', function() {
		$("#imgBarCnt").val(1);
		
		if(window.lang == "ko") {
			$("#barcodimg").attr('src','/resources/images/marketing/content/barcode_sample2.gif');
		} else {
			$("#barcodimg").attr('src','/resources/images/marketing/content/barcode_sample2_en.gif');
		}
		
		$('#remove_barcord').show();
 	});
});

</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
</script>

<script id="LimitPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
    {title}
    <div class="grid_con">
        {grid}
    </div>
</div>
</script>

<script id="optionTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="page-title">
	<h1>
		<spring:message code="M00374" />
		&gt; <spring:message code="M00274" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span id="chnlTitleArea"></span> <span><spring:message
					code="M02494" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">

			<%-- 저장 --%>
			<button class="btn btn-sm" id='saveBtn'>
				<i class="glyphicon glyphicon-check"></i>
				<spring:message code="M00280" />
			</button>

			<%-- 미리보기 --%>
			<button class="btn btn-sm" id="kakaoPreviewBtn">
				<spring:message code="M00392" />
			</button>
		</div>
	</div>
</div>

<div id="kakaoFormArea">
	<ifvm:input type="hidden" id="imgCnt" />
	<ifvm:input type="hidden" id="imgBarCnt" />

	<div class="well form-horizontal content_textImage_con">
		<div class="phoneImage">
			<div class="sms_kinds">
				<spring:message code="M02403" />
			</div>
			<div class="phoneWrap">
				<ifvm:input type="text" id="smsArea" placeholder="M00394"
					maxLength="50" />
				<div id="sortable">
					<div class="imageBox">
						<div class="image_img">
							<div class="image_close remove_image" id="image_remove">
								<img src="<ifvm:image name='photo_close'/>" />
							</div>
							<img src="<ifvm:image name='photo_def'/>" id="mmsImage" />
						</div>
						<div class="image_barcode" style="display: none;">
							<div class="barcode_wrap">
								<img src="<ifvm:image name='barcode_def'/>" id="barcodimg" />
							</div>
							<div class="image_close remove_barcord" id="remove_barcord">
								<img src="<ifvm:image name='photo_close'/>" />
							</div>
						</div>
					</div>
					<div class="textareaBox">
						<ifvm:input type="textarea" className="sms_phone_area"
							id="mmsTextArea" />
					</div>
				</div>
				<label class="phone_text"><spring:message code="M00397" /></label>
				<ifvm:input type="text" className="inputText" disabled="true"
					id="textByteSize" />
				<span class="phone_text"><spring:message code="M02415" /></span>
			</div>
		</div>
		<div class="guide_area">
			<div class="input_area" id="selectForm">
				<div class="row">

					<%-- 컨텐츠명 --%>
					<label class="col-xs-1 control-label"><span
						class="asterisk">*</span>
					<spring:message code="M00376" /></label>
					<div class="col-xs-10 control_content">
						<ifvm:input type="text" required="true" id="contentsName"
							maxLength="30" />
					</div>
				</div>
				<div class="row">

					<%-- 메세지 유형 --%>
					<label class="col-xs-1 control-label"><span
						class="asterisk">*</span>
					<spring:message code="M00388" /></label>
					<div class="col-xs-10 control_content">
						<ifvm:input type="select" id="txtMsgObject" />
					</div>
				</div>
				<div class="row">

					<%-- 개인화 속성 --%>
					<label class="col-xs-1 control-label"><spring:message
							code="M00398" /></label>
					<div class="col-xs-10 control_content">
						<ifvm:input type="select" id="persnal" />
					</div>
				</div>
				<div class="row">

					<%-- 이미지 링크 URL --%>
					<label class="col-xs-1 control-label"><spring:message
							code="M02430" /></label>
					<div class="col-xs-10 control_content">
						<ifvm:input type="text" id="imgLinkUrl" maxLength="1000" />
					</div>
				</div>
				<div class="description_title">
					<spring:message code="M02405" />
				</div>
				<div class="row">

					<%-- 버튼명 --%>
					<label class="col-xs-1 control-label"><spring:message
							code="M02406" /></label>
					<div class="col-xs-2 control_content">
						<ifvm:input type="text" className="w100" id="btnName" />
					</div>

					<%-- URL --%>
					<label class="col-xs-1 control-label">URL</label>
					<div class="col-xs-6 control_content">
						<ifvm:input type="text" className="w100" id="btnNameUrl"
							maxLength="100" />
					</div>
				</div>
			</div>
			<div>
				<label class="description_title"><spring:message
						code="M00512" /></label>
				<div class="limit_content">
					<div id="imageFileLimitGrid" class="pop_grid2"></div>
				</div>
			</div>
			<%-- 작성 가이드 --%>
<%-- 			<div>
				<label class="description_title"><spring:message
						code="M00400" /></label>
				<div class="chnl_guide">
					<ifvm:input type="textarea" id="chnlGuide" readonly="readonly" />
				</div>
			</div> --%>
		</div>
	</div>
</div>

<div id="kakaoFormNewPop" class="popup_container"></div>