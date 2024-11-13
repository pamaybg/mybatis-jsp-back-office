<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/marketing/common/common/common.jsp"/>
<%@ page import="com.icignal.common.util.BeansUtil" %>

<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>

<style>
    .descript {
        width: 50%;
        font-size: 13px;
        box-sizing: border-box;
        margin: 10px;
        margin-left: 17.5%;
        padding: 10px;
        overflow: hidden;

    }

    .row {
        margin-top: 20px;
        margin-bottom: 20px;
    }
</style>

<script>

    var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';
    var imgId;
    var conid = '<%= cleanXss(request.getParameter("id")) == null || "null".equals(cleanXss(request.getParameter("id"))) ? "" : cleanXss(request.getParameter("id")) %>';
    var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';
    var typeCode = '<%= cleanXss(request.getParameter("type")) %>';

    var barcodeId;
    var contsimagetype = "USERCONTS_MMS";
    var mms = {
        presmsArea: "",
        presmsTextArea: "",
        chnl: "",	//테스트 발송 시 mms,sms 등의 채널 구분을 위한 변수.
        typeCodeId: "",
        barSrc: "",
        imgSrc: "",
        photoUrl: "",
        barNumber: "",	//바코드 넘버
        barstart: "",	//유효기간 시작 일자
        barend: "",	//유효기간 종료 일자
        BarcodefileType: "",
        limitByte: "",
        totallength: "",
        mmsFormNewPop: "",
        exeContype: null,
        LimitStore: null,	//용량 제한
        LimitCHK: true,
        previewChk: false,
        mergeCheck: true,	//이미지, 바코드에 변경이 일어날시 false를 시켜 머지 이미지를 생성한다.
        offerClick: false,	//쿠폰번호를 클릭했는지 체크
        detail: false,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
        focusCHeck: null
    }

    var personalType = [];
    var surveyString = '';
    var empId;
    var empType;
    var phoneNo = '';

    $(function () {
        $("#sortable").sortable();
    });

    //상세 페이지인지 체크
    function idCheck() {
        $('#ofrNmDiv').show();
        $('#ranDomOfrNmDiv').hide();
        $('#ofrPointDiv').hide();
        $('#surveyDiv').hide();

        if (conid != "") {
            //상세 페이지일 경우 세팅
            $.ifvSyncPostJSON('<ifvm:action name="getMmsDtlList"/>', {
                id: conid
            }, function (result) {
                barcodeId = result.barId;
                imgId = result.imgId;
                merId = result.merId;
                $("#contentsName").val(result.contentsName);
                mms.exeContype = result.contentsType
                $("#contentsFlag").val(result.contentsFlag);
                $("#smsArea").val(result.title);
                $("#mmsTextArea").val(result.contents);
                $("#html").val(result.html);
                $("#txtMsgObject").val(result.txtMsgObject);
                $("#chnlGuide").val(result.chnlGuide);
                $("#toCallbackNo").val(result.toCallbackNo)
                /*$("#gaTagVal").val(result.gaTagVal)*/
                $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", result.contsTypeCd, null, true);

                mktOfrType = result.comOfrType;
                ofrNm = result.ofrNm;
                ridOfr = result.ridOfr;
                surveyNm = result.surveyNm;
                ridSurvey = result.ridSurv;
                if (result.imagepath != null && result.imagename != null) {
                    var path = '<%= BeansUtil.getApplicationProperty("icignal.context.imageServerUrl")%>' + result.imagepath + "/" + result.imagename;
                    $('#mmsImage').attr('src', path);
                    $('.image_close').show();
                    $("#imgCnt").val(1);
                }
                if (result.barpath != null) {
                    var textStore = [];
                    textStore = result.barpath.split('.')
                    if (textStore[0] != '' && textStore[0] != null) {
                        $('#barcodimg').attr('src', '/' + textStore[0] + "." + textStore[1].toLowerCase());
                    }
                    $("#imgBarCnt").val(1);
                }
                if (result.merpath != null) {
                    mms.photoUrl = result.merpath;
                }
                if (result.imagepath != null && result.imaganame != null) {
                    mms.mergeCheck = false;
                }

                $("#textByteSize").val(result.textByteSize);
                $("#imgSize").val(result.imgSize);
                $("#imgCnt").val(result.imgCnt);
                $("#smsWarningArea").val(result.bottom);
                $("#ofrNm").val(result.ofrNm);
                $("#ridOfr").val(result.ridOfr);
            });
            mms.detail = true;
            $('#contsTypeCd').attr('disabled', true);
            if (typeof closeContentsDesignPop == 'function') {
                if(empType == 'H'){
                    $('#toCallbackNo').val('18990232');
                } else {
                    $('#toCallbackNo').val(phoneNo);
                }
            }
            $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", mktOfrType, null, true);
            var mktOfrTypeVal = $("#mktOfrType").val();
            if (mktOfrTypeVal != null && mktOfrTypeVal != '') {
                //쿠폰 COM_OFR_TYPE
                if (mktOfrTypeVal == 'C') {
                    $('#ofrNmDiv').show();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').hide();
                    $('#ofrNm').val(ofrNm);
                    $('#ridOfr').val(ridOfr);
                    //포인트
                } else if (mktOfrTypeVal == 'P') {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').show();
                    $('#surveyDiv').hide();
                    $('#ofrPoint').val(ofrNm);
                    $('#ridPoint').val(ridOfr);
                    //설문
                } else if (mktOfrTypeVal == 'S') {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').show();
                    $('#surveyNm').val(surveyNm);
                    $('#ridSurvey').val(ridSurvey);
                    //예외
                } else {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').hide();
                }
            }
        } else {
            $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", typeCode, null, true);
            $('#contsTypeCd').attr('disabled', true);
            if(empType == 'H'){
                $('#toCallbackNo').val('18990232');
            } else if(empType == 'S'){
                $('#toCallbackNo').val(phoneNo);
            }

            $('#smsWarningArea').val('무료수신거부 0808730002');

            //메세지 유형 설정
            setTxtMsg();
        }
        $('#toCallbackNo').attr('disabled', true);
        $('#txtMsgObjectDiv').hide();
        if(empType != 'H'){
            $('#ofrArea').hide();
            $('#ofrNmDiv').hide();
            $('#ofrPointDiv').hide();
            $('#surveyDiv').hide();
            $('#desArea').hide();
        }
        //개인화 로드
        personalChangeFun($('#contsTypeCd').val());
    }

    function createBarcode() {
        if ($("#imgBarCnt").val() != 0) {

            //쿠폰을 생성했는지 체크하여 이미지 생성
            if (mms.offerClick) {
                mms.mergeCheck = false;
                var fid;
                $.ifvSyncPostJSON('<ifvm:action name="getBarcode"/>', {
                    idfyNO: mms.barNumber,
                    applyStrDate: mms.barstart,
                    applyEndDate: mms.barend,
                    chnlId: mms.exeContype,
                    fileType: mms.BarcodefileType
                }, function (result) {
                    var path = result.barpath;
                    barcodeId = result.barId;
                    $("#barcodimg").attr('src', path)
                    mms.barSrc = path;
                });
                mms.offerClick == false;
            }
        }
    }

    function actionInit() {
        //채널에서 세팅된 이미지 타입 구해오기
        /*
         $.ifvSyncPostJSON('

        <ifvm:action name="getNewImgUpType"/>', {
	}, function(result) {	
		var text = [];
		var size = result.length;
		var type;
		text = $("#mmsImage").attr('src').split('.');
		
		//이미지 옵션이 생성되어 있지 않을 때 에러
		if(size == 0){
    		alert('

        <spring:message code="M00434"/>');
    		return;
		}
		for(var i=0;i<size;i++){
				type = result[i].name;
			if(result[i].name == text[text.length-1].toUpperCase()){
				mms.BarcodefileType = result[i].name;
					
				//이미지 옵션의 높이, 넓이가 설정되어 있지 않을 떄
				if(result[i].height.length == 0 || result[i].height.length == 0){
					alert('

        <spring:message code="M00435"/>');
					return;
				}
			}	
		}
		//이미지에 맞는 확장자가 세팅되어 있지 않을 시 현재 설정된 확장자로 전달.
		if(mms.BarcodefileType.length <= 0){
			BarcodefileType = type;
		}
		mms.BarcodefileType = mms.BarcodefileType.toLowerCase();
	}); */
    }


    //저장 버튼클릭 시 동작
    function actionContent() {
        var resultFlag = false;

        mmsvalidation = $("#contentForm").ifvValidation();
        mmsValid = mmsvalidation.confirm();

        var ofrRid;
        var surveyRid;
        var mktOfrTypeVal = $("#mktOfrType").val();
        var mktOfrTypeSaveValue = null;

        //쿠폰 COM_OFR_TYPE
        if (mktOfrTypeVal == 'C') {
            if ($('#ridOfr').val() != null && $('#ridOfr').val() != '') {
                mktOfrTypeSaveValue = 'C';
                ofrRid = $('#ridOfr').val();
            } else {
                mktOfrTypeSaveValue = null;
                ofrRid = null;
                surveyRid = null;
            }
            //포인트
        } else if (mktOfrTypeVal == 'P') {
            if ($('#ridPoint').val() != null && $('#ridPoint').val() != '') {
                mktOfrTypeSaveValue = 'P';
                ofrRid = $('#ridPoint').val();
            } else {
                mktOfrTypeSaveValue = null;
                ofrRid = null;
                surveyRid = null;
            }
            //설문
        } else if (mktOfrTypeVal == 'S') {
            if ($('#ridSurvey').val() != null && $('#ridSurvey').val() != '') {
                mktOfrTypeSaveValue = 'S';
                surveyRid = $('#ridSurvey').val();
            } else {
                mktOfrTypeSaveValue = null;
                ofrRid = null;
                surveyRid = null;
            }
            //예외
        } else {
            mktOfrTypeSaveValue = null;
            ofrRid = null;
            surveyRid = null;
        }

        if (mmsValid) {
            checkByte('input');

            if (mms.LimitCHk) {
                if (Number(mms.totallength) < Number(mms.limitByte)) {
                    mms.LimitCHk = true;
                }
            } else if (mms.LimitCHk == false) {
                alert(mms.limitByte + "<spring:message code='M00431'/>");
                return;
            }

            if ($("#mmsImage").attr('src').substring(1).length > 0) {
                var idx = $("#mmsImage").attr('src').indexOf("=");
                mms.imgSrc = $("#mmsImage").attr('src').substring(idx + 1);
            } else {
                mms.imgSrc = '';
            }

            if ($("#imgCnt").val() != 1) {
                imgId = null;
            }

            if ($("#imgBarCnt").val() == 1) {
                if ($("#barcodimg").attr('src').substring(1).length > 0) mms.barSrc = $("#barcodimg").attr('src').substring(1);
                else mms.barSrc = '';
            }

            actionInit();
            createBarcode();

            if (typeof closeContentsDesignPop == 'function') {
                if(conid != null && conid != ''){
                    if(loadContentCheck) {
                        mms.detail = false;
                    } else {
                        mms.detail = true;
                    }
                } else {
                    mms.detail = false;
                }
            }
            //상세 페이지일 시 수정 작업 동작
            if (mms.detail) {
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                    contentsName: $("#contentsName").val()
                    , contentsFlag: $("#contentsFlag").val()
                    , title: $("#smsArea").val()
                    , txtMsgObject: $("#txtMsgObject option:selected").val()
                    , contents: $("#mmsTextArea").val()
                    , html: $("#html").val()
                    , textByteSize: $("#textByteSize").val()
                    , imgSize: $("#imgSize").val()
                    , imgCnt: $("#imgCnt").val()
                    , imgBarCnt: $("#imgBarCnt").val()
                    , filePath: mms.imgSrc
                    , barPath: mms.barSrc
                    , imgId: imgId
                    , barId: barcodeId
                    , id: conid
                    , chnlId: mms.exeContype
                    , merCheck: mms.mergeCheck
                    , bottom: $("#smsWarningArea").val()
                    , contsTypeCd: $("#contsTypeCd").val()
                    , ridOfr: ofrRid
                    , toCallbackNo: $("#toCallbackNo").val().replace(/-/g, '')
                    , comOfrType: mktOfrTypeSaveValue
                    , ridSurv: surveyRid
                    /*, gaTagVal: $('#gaTagVal').val()*/
                }, function (result) {
                    if (mms.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }

                    idCheck();

                    if (typeof strType != "undefined") {
                        try {
                            quickSaveMessage(conid);
                        } catch (e) {
                        }
                    }
                    resultFlag = true;
                });
            } else {
                var camFlag = 0;
                //캠페인 워크플로우인지 확인한다.
                if (openType != "") {
                    camFlag = '1';
                }
                //상세 페이지가 아닐 시 insert 동작
                $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
                    contentsName: $("#contentsName").val()
                    , contentsChannel: $("#contentsChanne").val()
                    , contentsType: chnlCode
                    , contentsFlag: $("#contentsFlag").val()
                    , title: $("#smsArea").val()
                    , txtMsgObject: $("#txtMsgObject").val()
                    , contents: $("#mmsTextArea").val()
                    , html: $("#html").val()
                    , textByteSize: $("#textByteSize").val()
                    , imgSize: $("#imgSize").val()
                    , imgCnt: $("#imgCnt").val()
                    , imgBarCnt: $("#imgBarCnt").val()
                    , filePath: mms.imgSrc
                    , barPath: mms.barSrc
                    , imgId: imgId
                    , barId: barcodeId
                    , camFlag: camFlag
                    , merCheck: mms.mergeCheck
                    , chnlId: mms.exeContype
                    , bottom: $("#smsWarningArea").val()
                    , contsTypeCd: $("#contsTypeCd").val()
                    , ridOfr: ofrRid
                    , toCallbackNo: $("#toCallbackNo").val().replace(/-/g, '')
                    , comOfrType: mktOfrTypeSaveValue
                    , ridSurv: surveyRid
                    /*, gaTagVal: $('#gaTagVal').val()*/
                }, function (result) {
                    if (mms.previewChk == false) {
                        alert('<spring:message code="M00430"/>');
                    }
                    conid = result.message;
                    mms.detail = true;

                    idCheck();

                    resultFlag = true;
                });

                if (openType == "") {
                    qtjs.href('/marketing/content/mmsFormNew' + '?id=' + conid);
                }
            }
            mms.previewChk = false;
        }
        return resultFlag;
    }

    //총 용량 체크 (컨텐츠 내용을 체크하여 총용량을 계산한다.)
    function totalBytecheck(message) {
        var totalByte = 0;
        var message_unclude_persnal = message;

        // 개인화 속성 길이 고려할 것.
        if (message != null && message.length > 0) {
            var persnalRegex = /\\$\\$[ㄱ-힣a-zA-Z\\(\\)]*\\$\\$/g;
            var arry;
            while ((arry = persnalRegex.exec(message)) != null) {
                var size = Number(getPersnalSize(arry[0]));
                if (size > 0) {
                    message_unclude_persnal = message_unclude_persnal.replace(arry[0], '');
                    totalByte += size;
                }
            }
        }

        for (var i = 0; i < message_unclude_persnal.length; i++) {
            var currentByte = message_unclude_persnal.charCodeAt(i);
            if (currentByte > 128) totalByte += 2;
            else totalByte++;
        }
        return totalByte;
    }

    /**
     * 개인화속성 값으로 길이 구하기
     */
    function getPersnalSize(_str) {
        var txt = _str.replace('{{', '').replace('}}', '');
        var valMaxSize = 0;
        if ($.fn.ifvmIsNotEmpty(txt)) {
            valMaxSize = $('#persnal option[value="' + txt + '"]').data('valMaxSize');
        }
        return valMaxSize;
    }

    function cutMessage(message, remainByte) {

        var totalByte = 0;
        var k = 0;
        for (var i = 0; i < message.length; i++) {
            var currentByte = message.charCodeAt(i);

            if (currentByte > 128) totalByte += 2;
            else totalByte++;

            if (totalByte > remainByte) break;
            k++;
        }
        return k;
    }

    //컨텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
    function checkByte(inputType) {
        var inputMessage = $("#smsArea").val();
        var textareaMessage = $("#mmsTextArea").val();
        var warningMessage = $("#smsWarningArea").val();

        var inputByte = Number(totalBytecheck(inputMessage));
        var textareaByte = Number(totalBytecheck(textareaMessage));
        var warningByte = Number(totalBytecheck(warningMessage));
        var totalByte = inputByte + textareaByte + warningByte;
        mms.totallength = totalByte;
        mms.limitByte = mms.LimitStore;

        $("#textByteSize").val(totalByte);

        if (totalByte > mms.limitByte) {
            mms.LimitCHk = false;
            alert(mms.LimitStore + ' Byte 이상 입력 하실 수 없습니다.')
            //제한 용량을 벗어났음을 알리는 경고 창.                  
            $("#textByteSize").val(mms.LimitStore);
            if (inputType == "input") {
                var remainByte = mms.limitByte - textareaByte - warningByte;
                var k = cutMessage(inputMessage, remainByte);
                $('#smsArea').val(inputMessage.substring(0, k));
            } else if (inputType == "textarea") {
                var remainByte = mms.limitByte - inputByte - warningByte;
                var k = cutMessage(textareaMessage, remainByte);
                $('#mmsTextArea').val(textareaMessage.substring(0, k));
            } else if (inputType == "warning") {
                var remainByte = mms.limitByte - inputByte - textareaByte;
                var k = cutMessage(warningMessage, remainByte);
                $('#smsWarningArea').val(warningMessage.substring(0, k));
            }
        } else {
            mms.LimitCHk = true;
        }
    }

    //현재 커서 위치에 개인화 속성 값 추가하기
    function insertAtCursor(area, text) {
        var smsTextArea = document.getElementById(area.id);
        var scrollPos = smsTextArea.scrollTop;
        var strPos = 0;
        var br = ((smsTextArea.selectionStart || smsTextArea.selectionStart == '0') ?
            "ff" : (document.selection ? "ie" : false));

        if (br == "ie") {
            smsTextArea.focus();
            var range = document.selection.createRange();
            range.moveStart('character', -smsTextArea.value.length);
            strPos = range.text.length;
        } else if (br == "ff") strPos = smsTextArea.selectionStart;

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
        } else if (br == "ff") {
            smsTextArea.selectionStart = strPos;
            smsTextArea.selectionEnd = strPos;
            smsTextArea.focus();
        }
        smsTextArea.scrollTop = scrollPos;
    }

    //현재 채널 타입 세팅(미리보기 발송 시 현재 채널에 대한 타입을 전달하기 위한 세팅)
    function getChcnltype() {
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_TYPE_CD'
            , enableNA: true
        }, function (result) {
            var size = result.rows.length;
            for (var i = 0; i < size; i++) {
                //신규 페이지 일시
                if (chnlCode != "null") {
                    //작성 가이드 셋팅
                    /*$.ifvSyncPostJSON('

                    <ifvm:action name="getChnlGuide"/>', {
						chnltype : chnlCode
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
				    	$("#chnlGuide").val(result.chnlGuide);   
					}
				});*/

                    if (result.rows[i].codeName == chnlCode) {
                        mms.typeCodeId = result.rows[i].codeId;
                        mms.exeContype = result.rows[i].codeName;
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
                //상세 페이지 일시
                else {
                    if (mms.exeContype != null) {
                        if (mms.exeContype == result.rows[i].codeName) {
                            chnlCode = result.rows[i].codeName;
                            $('#chnlTitleArea').text(result.rows[i].markName);
                        }
                    }
                }
            }
            $('.sms_kinds').text('<spring:message code="M00393"/> / ' + chnlCode);
        });
    }

    //초기 로딩 시 글자 수 체크
    function initByteCheck() {
        checkByte();
        checkByte('textarea');
        checkByte('warning');
    }

    function personalChangeFun(changeType) {
        if (changeType == "mkt") {
            //캠페인 개인화 속성 로드
            $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>', {
                contentTypeCodeValue: "PERSONALIZATION"
            }, function (result) {
                var size = result.length;
                arrStore = {};
                arrStore.markName = '<spring:message code="M00436"/>';
                for (var i = size; i >= 0; i--) {
                    if (i != 0) {
                        temp = result[i - 1];
                        result[i] = temp;
                    } else {
                        result[0] = {};
                        result[0] = arrStore;
                    }
                }
                var temp = $("#persnaltemp").tmpl(result);
                $("#persnal").empty().append(temp);
            });
        } else {
            //그외 개인화 속성 로드
            $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>', {
                contentTypeCodeValue: "LOYPERSONALIZATION"
            }, function (result) {
                var size = result.length;
                arrStore = {};
                arrStore.markName = '<spring:message code="M00436"/>';
                for (var i = size; i >= 0; i--) {
                    if (i != 0) {
                        temp = result[i - 1];
                        result[i] = temp;
                    } else {
                        result[0] = {};
                        result[0] = arrStore;
                    }
                }
                var temp = $("#persnaltemp").tmpl(result);
                $("#persnal").empty().append(temp);
            });
        }

        var mktOfrTypeVal = $("#mktOfrType").val();
        //쿠폰 COM_OFR_TYPE
        if (mktOfrTypeVal == 'C') {
            $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
            //포인트
        } else if (mktOfrTypeVal == 'P') {
            $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
            //설문
        } else if (mktOfrTypeVal == 'S') {
            $("#persnal option[value='설문URL']").removeAttr('disabled').show();
            //예외
        } else {
            $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
        }
    }

    //초기 세팅
    function initComm() {
        //Text message 유형 공통 코드.
// 	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
// 		groupCode : 'TEXT_SENDER_INFO'
// 		, enableNA : true
// 	},function(result) {
// 		var size = result.rows.length;

// 		for(var i =0;i<size;i++){
// 			if(result.rows[i].attrib01 != null){
// 				$("#smsWarningArea").val(result.rows[i].attrib01);
// 			}
// 		}
// 	});

        //Text message 유형 공통 코드.
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'TXT_MSG_OBJECT_CD'
            , enableNA: true
        }, function (result) {
            var size = result.rows.length;
            var arry = new Array();
            for (var i = size; i > 0; i--) {
                if (i != 0) {
                    temp = result.rows[i - 1];
                    arry[i - 1] = temp;
                }
            }
            var temp = $("#MsgTypeTemp").tmpl(result.rows);
            $("#txtMsgObject").append(temp);
        });

        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CONT_SUB_TYPE_CD'
            , enableNA: true
        }, function (result) {
            var size = result.rows.length;
            var array = [];

            arrStore = {};
            arrStore.markName = "<spring:message code='M00436'/>";
            arrStore.attrib01 = "1";
            for (var i = size; i >= 0; i--) {
                if (i != 0) {
                    temp = result.rows[i - 1];
                    result.rows[i] = temp;
                } else {
                    result.rows[0] = {};
                    result.rows[0] = arrStore;
                }
            }

            for (var i = 0; i < size; i++) {
                if (result.rows[i].attrib01) {
                    array.push(result.rows[i]);
                }
            }
            var temp = $("#MsgTypeTemp").tmpl(array);
        });

        $("#imgCnt").hide();
        $("#imgBarCnt").hide();
        getLimit();
        initByteCheck();
        getChcnltype();
    }

    //최대 용량 정보 가져오기
    function getLimit() {
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_LIMITE'
            , enableNA: true
        }, function (result) {
            var text = "L" + chnlCode;
            var size = result.rows.length;

            //각 LMS,SMS 등에 맞는 용량 가져오기.
            for (var i = 0; i < size; i++) {
                if (result.rows[i].codeName == text) {
                    mms.LimitStore = result.rows[i].attrib01;
                }
            }
        });

    }

    //이미지, 파일 제한 그리드
    function setImageFileLimitGrid() {
        var chnltypeId;
        $.ifvSyncPostJSON('<ifvm:action name="getChnlId"/>', {
            chnltype: chnlCode
        }, function (result) {
            chnltypeId = result.chnlId;
        });

        var jqGridOption = {
            onSelectCell: function (data) {
                selectChilRow = data.id;
            },
            url: '<ifvm:action name="getImgOption"/>',
            serializeGridData: function (data) {
                data.mktChlId = chnltypeId;
            },
            colNames: [
                '<spring:message code="M00491"/>',
                '<spring:message code="M00492"/>',
                '<spring:message code="M00493"/>',
                '<spring:message code="M00494"/>',
                'id'
            ],
            colModel: [
                {name: 'upldEtsionCd', index: 'c1.mark_name', resizable: false},
                {name: 'maxVol', index: 'mcc.max_vol', resizable: false, formatter: $.fn.comma, align: "right"},
                {name: 'imgResolW', index: 'mcc.img_resol_w', resizable: false, align: "right"},
                {name: 'imgResolH', index: 'mcc.img_resol_h', resizable: false, align: "right"},
                {name: 'id', index: 'id', resizable: false, hidden: true, searchable: false}
            ],
            autowidth: true,
            sortname: 'seq',
            sortorder: "asc",
            tempId: 'LimitPopTemplete',
            search: false,
            emptyRows: true
        };
        imageFileLimitGrid = $("#imageFileLimitGrid").ifvGrid({jqGridOption: jqGridOption});
    }

    //바코드 추가 전 초기 이미지 세팅 영어,한글 버전에 따라 이미지가 달라진다.
    function barcodeImageSetting() {
        if (window.lang == "ko") {
            $("#barcodimg").attr('src', '<ifvm:image name="barcode_def"/>');
        } else {
            $("#barcodimg").attr('src', '<ifvm:image name="barcode_def_en"/>');
        }
    }

    //초기 실행할 펑션들.
    function initRunFunction() {
        barcodeImageSetting();
        initComm();
        idCheck();
        getChcnltype();
        getLimit();
        checkByte();


        mms.photoUrl = null;

        setTimeout(function () {
            setImageFileLimitGrid();
        }, 50);
    }

    /**
     * 메세지 유형 설정
     */
    function setTxtMsg() {
        var selectMsg = $("#txtMsgObject option:selected").text();
        var size = $("#txtMsgObject option").size();
        var addTitle = false;
        var addContent = false;

        //제목&내용에 해당 문자열이 있는지 검사
        for (var i = 0; i < size; i++) {
            var searchString = $("#txtMsgObject option").eq(i).text();
            if (addTitle == false && $("#smsArea").val().startsWith(searchString)) {
                addTitle = true;
                $("#smsArea").val($("#smsArea").val().replace(searchString, selectMsg));
            }

            if (addContent == false && $("#mmsTextArea").val().startsWith(searchString)) {
                addContent = true;
                $("#mmsTextArea").val($("#mmsTextArea").val().replace(searchString, selectMsg));
            }
        }
        if (addTitle == false) $("#smsArea").val(selectMsg + $("#smsArea").val());
        /* if (addContent == false) $("#mmsTextArea").val(selectMsg + $("#mmsTextArea").val()); */

        checkByte('input');
        checkByte('textarea');
    }

    //쿠폰 리스트 팝업
    function ofrListPop() {
        var openflag = true;

        // 오퍼 관련 - 캠페인 워크플로우 일 경우만 (캠페인 내 채널중 오퍼 다중 등록 방지)
        if (openType == "WF" && typeof campaign != "undefined") {
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {campaignId: campaign.id, contentsId: conid},
                function (result) {
                    if (result > 0) {
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferPopCount"/>', {campaignId: campaign.id, chnnelTypeCode: chnlCode,contentsId: conid},
                            function (result) {
                                if (result > 0) {
                                    openflag = false;
                                }
                            });
                    }
                }
            );
        }

        if (openflag) {
            $("#ofrListPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="ofrListPop"/>',
                contentType: "ajax",
                title: '오퍼(쿠폰)',
                width: 1000,
                close: 'ofrListPopClose'
            });
        } else {
            alert("캠페인 채널 중 이미 다른 오퍼가 등록되어 있습니다.")
        }
    }

    function ofrListPopClose() {
        ofrListPopDialog._destroy();
    }

    //포인트 리스트 팝업
    function ofrPointListPop() {
        var openflag = true;

        // 오퍼 관련 - 캠페인 워크플로우 일 경우만 (캠페인 내 채널중 오퍼 다중 등록 방지)
        if (openType == "WF" && typeof campaign != "undefined") {
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {campaignId: campaign.id, contentsId: conid},
                function (result) {
                    if (result > 0) {
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferCount"/>', {campaignId: campaign.id, chnnelTypeCode: chnlCode,contentsId: conid},
                            function (result) {
                                if (result > 0) {
                                    openflag = false;
                                }
                            });
                    }
                }
            );
        }

        if (openflag) {
            $("#ofrPointListPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="pointOfrListPop"/>',
                contentType: "ajax",
                title: '포인트',
                width: 650,
                close: 'ofrPointListPopClose'
            });
        } else {
            alert("캠페인 채널 중 이미 다른 오퍼가 등록되어 있습니다.")
        }
    }

    function ofrPointListPopClose() {
        ofrPointListPopDialog._destroy();
    }

    //설문 리스트 팝업
    function surveyListPop() {
        var openflag = true;

        // 오퍼 관련 - 캠페인 워크플로우 일 경우만 (캠페인 내 채널중 오퍼 다중 등록 방지)
        if (openType == "WF" && typeof campaign != "undefined") {
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {campaignId: campaign.id, contentsId: conid},
                function (result) {
                    if (result > 0) {
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferCount"/>', {campaignId: campaign.id, chnnelTypeCode: chnlCode,contentsId: conid},
                            function (result) {
                                if (result > 0) {
                                    openflag = false;
                                }
                            });
                    }
                }
            );
        }

        if (openflag) {
            $("#surveyListPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="surveyListPop"/>',
                contentType: "ajax",
                title: '설문',
                width: '1000px',
                close: 'surveyListPopClose'
            });
        } else {
            alert("캠페인 채널 중 이미 다른 오퍼가 등록되어 있습니다.")
        }
    }

    function surveyListPopClose() {
        surveyListPopDialog._destroy();
    }

    //이미지 팝업 열기
    function openImagePopup() {

        //팝업창에서 이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
        $("#mmsFormNewPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            //contentUrl: '<ifvm:url name="MKTAddImagePop"/>',
            contentUrl: '<ifvm:url name="MKTAddImagePopS3"/>?type=mms',
            contentType: "ajax",
            title: '<spring:message code="M00797"/>',
            width: 870,
            close: 'mmsFormNewPopClose'
        });
    }

    /* 팝업 닫기 */
    function mmsFormNewPopClose() {
        mmsFormNewPop._destroy();
    }

    function getPersonalType() {
        $.ifvSyncPostJSON('<ifvm:action name="getPersonalType"/>', {}, function (result) {
            for (i = 0; i < result.length; i++) {
                personalType.push(result[i].markName);
            }
        });
    }



    $(document).ready(function () {

        $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);

        $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", null, null, true);
        $('#contsTypeArea').hide();

        //권한 불러오기
        contentAuth();

        //레프트 메뉴 세팅
        $.ifvmLnbSetting('contentListNew');

        //화면 로딩 후 초기 실행될 펑션
        initRunFunction();

        //개인화 속성 목록
        getPersonalType();

        //$('#toCallbackNo').val('0316463563');
        $("#mmsTextArea").bind('keyup', function () {
            checkByte('textarea');
        });
        $("#smsArea").bind('keyup', function () {
            checkByte('input');
        });

        // 개인화 버튼 숨김
        $('#uploadPersnalTypeBtn').hide();

        $("#txtMsgObject").change(function () {
            //메세지 유형 설정
            setTxtMsg();
        });

        $("#persnal").on('change', function () {

            if (checkPersonalType() === false) {
                alert('개인화 속성은 5가지를 넘길 수 없습니다.')
                $("#persnal option:eq(0)").attr("selected", "selected");
                return;
            }

            var text = "{{" + $("#persnal option:selected").text() + "}}";
            if (mms.focusCHeck == smsArea) insertAtCursor(smsArea, text);
            else insertAtCursor(mmsTextArea, text);
            $("#persnal option:eq(0)").attr("selected", "selected");
            checkByte();
        });

        $("#mmsTextArea").on('blur', function () {
            mms.focusCHeck = mmsTextArea;
        });

        $("#smsWarningArea").bind('keyup', function () {
            checkByte('warning');
        });

        $("#contsTypeCd").change(function () {
            personalChangeFun($('#contsTypeCd').val());
        });

        $("#saveBtn").on('click', function () {

            //URL 포함인지 확인
            if ($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
                alert(surveyString)
                return;
            }

            // 저장
            var result = actionContent();
            if (result == true) {
                // 컨텐츠 팝업 종료
                if (typeof closeContentsDesignPop == 'function') {
                    closeContentsDesignPop();
                }
            }
        });

        $("#btnList").click(function () {
            qtjs.href('<ifvm:url name="contentListNew"/>');
        });

        $("#image_remove").on('click', function () {
            //이미지 초기화
            $('#mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
            imgId = '';
            $("#imgCnt").val(0);
            $(this).hide();
        });

        $('#remove_barcord').on('click', function () {

            barcodeImageSetting();
            $("#imgBarCnt").val(0);
            $(this).hide();
        });

        $('#mmsImage').on('click', function () {
            openImagePopup();
        });

        //바코드 클릭시
        $('.barcode_wrap').on('click', function () {

            mms.barNumber = number;
            mms.barstart = start;
            mms.barend = end;

            if (window.lang == "ko") {
                $("#barcodimg").attr('src', '/resources/images/marketing/content/barcode_sample2.gif');
            } else {
                $("#barcodimg").attr('src', '/resources/images/marketing/content/barcode_sample2_en.gif');
            }

            $('#remove_barcord').show();
        });

        //테스트 발송
        $('#mmsTestSendBtn').on('click', function () {

            mms.previewChk = true;
            mms.presmsArea = $('#smsArea').val();
            mms.presmsTextArea = $('#mmsTextArea').val();
            actionInit();

            //URL 포함인지 확인
            if ($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
                alert(surveyString)
                return;
            }

            var resultFlag = actionContent();
            checkByte('input');

            if (mms.LimitCHk) {
                if (Number(mms.totallength) < Number(mms.limitByte)) mms.LimitCHk = true;
            }
            if (mms.LimitCHk == false) return;
            if (resultFlag == false) return;

            if (conid != '') {
                idCheck();
                $("#mmsFormNewPop").ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="MKTMmsPreviewPop"/>',
                    contentType: "ajax",
                    title: '<spring:message code="M00419"/>',
                    width: 800,
                    close: 'mmsFormNewPopClose'
                });
                mms.mmsFormNewPop = $("#mmsFormNewPop").data('ifvsfPopup');
            } else alert('<spring:message code="M00448"/>');
        });

        $('#btnOfrListPop').on('click', function () {
            ofrListPop();
        });

        $("#mktOfrType").change(function () {
            var mktOfrTypeVal = $("#mktOfrType").val();
            if (mktOfrTypeVal != null && mktOfrTypeVal != '') {
                //쿠폰 COM_OFR_TYPE
                if (mktOfrTypeVal == 'C') {
                    $('#ofrNmDiv').show();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').hide();
                    $('#ranDomOfrNm').val(null);
                    $('#ranDomRidOfr').val(null);
                    $('#ofrPoint').val(null);
                    $('#ridPoint').val(null);
                    $('#surveyNm').val(null);
                    $('#ridSurvey').val(null);
                    $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
                    //포인트
                } else if (mktOfrTypeVal == 'P') {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').show();
                    $('#surveyDiv').hide();
                    $('#ofrNm').val(null);
                    $('#ridOfr').val(null);
                    $('#ranDomOfrNm').val(null);
                    $('#ranDomRidOfr').val(null);
                    $('#surveyNm').val(null);
                    $('#ridSurvey').val(null);
                    $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
                    //설문
                } else if (mktOfrTypeVal == 'S') {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').show();
                    $('#ofrNm').val(null);
                    $('#ridOfr').val(null);
                    $('#ranDomOfrNm').val(null);
                    $('#ranDomRidOfr').val(null);
                    $('#ofrPoint').val(null);
                    $('#ridPoint').val(null);
                    $("#persnal option[value='설문URL']").removeAttr('disabled').show();
                    //예외
                } else {
                    $('#ofrNmDiv').hide();
                    $('#ranDomOfrNmDiv').hide();
                    $('#ofrPointDiv').hide();
                    $('#surveyDiv').hide();
                    $('#ofrNm').val(null);
                    $('#ridOfr').val(null);
                    $('#ranDomOfrNm').val(null);
                    $('#ranDomRidOfr').val(null);
                    $('#ofrPoint').val(null);
                    $('#ridPoint').val(null);
                    $('#surveyNm').val(null);
                    $('#ridSurvey').val(null);
                    $("#persnal option[value='설문URL']").attr('disabled', 'disabled').hide();
                }
            }
        });

        //유효성 검사
        mmsvalidation = $("#contentForm").ifvValidation();

        //popup 높이 맞추기
        initPopupHeight();
    });

    //popup 높이 맞추기
    function initPopupHeight() {
        try {
            if (cDialog) {
                setTimeout(function () {
                    new ifvm.PopupHeight({
                        popupDivId: 'dialog',
                        contentsId: 'dialogPopupWrap'
                    });
                    cDialog.refresh();
                }, 500);
            }
        } catch (e) {
        }
    }

    //설문 url 체크
    function checkURLYn() {
        var checkText = $("#mmsTextArea").val()
        var checkValue = $("#surveyNm").val()
        cText = '{{설문URL}}'

        if (checkText.search(cText) != -1 && checkValue == '') {
            surveyString = '설문 값을 입력해주세요.'
            return false;
        } else if($.fn.ifvmIsNotEmpty(checkValue) && checkText.search(cText) == -1){
            surveyString = '설문 URL을 입력해주세요.'
            return false;
        }
    }

    function checkPersonalType() {
        var chkFlag = 1;
        var chkText = $("#mmsTextArea").val() + $("#smsArea").val() + $("#smsWarningArea").val();

        for (i = 0; i < personalType.length; i++) {
            if (chkText.indexOf(personalType[i]) != -1) {
                if (chkText.indexOf($('#persnal').val()) == -1) {
                    chkFlag++;
                }
            }
        }

        if (chkFlag > 5) {
            return false;
        }
    }

    function contentAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            authType = result.rows[0].authType;
            brandCd = result.rows[0].brandCd;
            empType = result.rows[0].empType;
        });

        $.ifvSyncPostJSON('<ifvm:action name="selectPhoneNo"/>', {
            empId: empId
        }, function (result) {
            phoneNo = result.phoneNo;
        });
    }
</script>

<script id="LimitPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	{title}
	<div class="grid_con">
		{grid}
	</div>
</div>


</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>


</script>

<script id="MsgTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>


</script>

<script id="barTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" attrib01="${'${'}attrib01}">${'${'}markName}</option>


</script>

<script id="contentTextGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}
		<div class="grid_con">
			{grid}
		</div>
	</div>


</script>

<div class="page-title">
    <h1>
        <spring:message code="M00374"/> &gt; <spring:message code="M00274"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span id="chnlTitleArea"></span> <span><spring:message code="M02494"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id='saveBtn' objCode="saveBtn_obj">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
            <button class="btn btn-sm" id="mmsTestSendBtn" objCode="mmsTestSendBtn_OBJ">
                <spring:message code="M00391"/>
            </button>
            <button class="btn btn-sm btn_gray" id="btnList" objCode="btnList_OBJ">
                <spring:message code="C00166"/>
            </button>
        </div>
    </div>
</div>
<div>
    <div id="contentForm" class="well form-horizontal content_textImage_con">
        <br>
        <div class="phoneImage">
            <div class="sms_kinds"><spring:message code="M00393"/> / <span class="sms_mms">MMS</span></div><!-- 단문SMS/ 장문SMS /이미지MMS /PUSH -->
            <div class="phoneWrap">
                <ifvm:input type="text" required="true" id="smsArea" placeholder="M00394" maxLength="50"/>
                <div id="sortable">
                    <div class="imageBox">
                        <div class="image_img">
                            <div class="image_close remove_image" id="image_remove">
                                <img src="<ifvm:image name='photo_close'/>"/>
                            </div>
                            <img src="<ifvm:image name='photo_def'/>" id="mmsImage"/>
                        </div>
                        <div class="image_barcode" style="display: none;">
                            <div class="barcode_wrap">
                                <img src="<ifvm:image name='barcode_def'/>" id="barcodimg"/>
                            </div>
                            <div class="image_close remove_barcord" id="remove_barcord">
                                <img src="<ifvm:image name='photo_close'/>"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="textareaBox">
                    <ifvm:input type="textarea" required="true" className="sms_phone_area" id="mmsTextArea"/>
                </div>
                <div class="warningBox">
                    <ifvm:input type="textarea" className="sms_phone_area" id="smsWarningArea" maxLength="50"/>
                </div>
                <label class="phone_text"><spring:message code="M00397"/></label>
                <ifvm:input type="text" className="inputText" disabled="true" id="textByteSize"/>
                <span class="phone_text"><spring:message code="M00798"/></span>
            </div>
        </div>
        <div class="col-xs-8 control_content">
            <div class="input_area" id="selectForm">
                <br>
                <div class="row">
                    <%-- 컨텐츠명 --%>
                    <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="text" id="contentsName" required="true" maxLength="30"/>
                        <ifvm:input type="text" id="imgCnt"/>
                        <ifvm:input type="text" id="imgBarCnt"/>
                    </div>
                </div>
                <div class="row">
                    <%-- 송신자 번호 --%>
                    <ifvm:inputNew type="text" id="toCallbackNo" label="송신자 번호" labelClass="2" conClass="7" required="true"/>

                </div>
<%--                <div class="row" id="gaTagArea">
                    &lt;%&ndash; gaTag&ndash;%&gt;
                        <label class="col-xs-2 control-label" id="gaTagId"><spring:message code="GA TAG"/></label>
                        <ifvm:inputNew type="text" id="gaTagVal" conClass="7"/>

                </div>--%>

                <div class="row" id="txtMsgObjectDiv">
                    <%-- 메세지 유형 --%>
                    <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00388"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="select" id="txtMsgObject"/>
                    </div>
                </div>
                <div class="row">
                    <%-- 개인화 속성 --%>
                    <label class="col-xs-2 control-label"><spring:message code="M00398"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="select" id="persnal"/>
                    </div>
                </div>
                				<div class="row" id="contsTypeArea">
                <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd"/>
                				</div>
                <%--				<br>--%>
                <div class="row" id="ofrArea">
                    <%-- 오퍼유형 --%>
                    <ifvm:inputNew type="select" id="mktOfrType" names="mktOfrType" dto="mktOfrType" label="M03049" labelClass="2" conClass="7"/>
                </div>

                <%--오퍼(쿠폰) --%>
                <div class="row qt_border" id="ofrNmDiv">
                    <ifvm:inputNew type="search" clearArgs="'ofrNm,ridOfr'" id="ofrNm" hidId="ridOfr" hidDto="ridOfr" btnFunc="ofrListPop" dto="ofrNm" names="ofrNm" label="쿠폰"
                                   labelClass="2" conClass="7"/>
                </div>
                <%--포인트 --%>
                <div class="row qt_border" id="ofrPointDiv">
                    <ifvm:inputNew type="search" clearArgs="'ofrPoint,ridPoint'" id="ofrPoint" hidId="ridPoint" hidDto="ridPoint" btnFunc="ofrPointListPop" dto="ofrPoint"
                                   names="ofrPoint" label="포인트" labelClass="2" conClass="7"/>
                </div>
                <%--설문 --%>
                <div class="row qt_border" id="surveyDiv">
                    <ifvm:inputNew type="search" clearArgs="'surveyNm,ridSurvey'" id="surveyNm" hidId="ridSurvey" hidDto="ridSurvey" btnFunc="surveyListPop" dto="surveyNm"
                                   names="surveyNm" label="설문" labelClass="2" conClass="7"/>
                </div>
                <div id="desArea">
					<textarea class='descript' maxlength="50" rows="3" readonly=true>
1. 송신자 번호 : 18990232
2. 무료수신거부 : 0808730002
3. 문의 : 0805655600
					</textarea>
                </div>
                    <label class="col-xs-8 control-label" style="color: red; text-align: center">※개인화 속성은 5가지를 초과할 수 없습니다.</label>
                <label class="col-xs-8 control-label" style="color: red; text-align: center">MMS 발송 파일 최대사이즈 : 1,000 KB</label>
            </div>
        </div>

        <%--
        <div>
            <label class="description_title"><spring:message code="M00512"/></label>
            <div class="limit_content">
                <div id="imageFileLimitGrid" class="pop_grid2"></div>
            </div>
        </div>
        --%>
        <%-- 작성 가이드 --%>
        <%-- 			<div>
                        <label class="description_title"><spring:message code="M00400"/></label>
                        <div class="chnl_guide">
                            <ifvm:input type="textarea" id="chnlGuide" readonly="readonly"/>
                        </div>
                    </div> --%>
    </div>
</div>


<div id="mmsFormNewPop" class="popup_container"></div>
<div id="ofrListPopDialog" class="popup_container"></div>
<div id="ofrPointListPopDialog" class="popup_container"></div>
<div id="surveyListPopDialog" class="popup_container"></div>