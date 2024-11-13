<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    #smsPhoneArea .textareaBox {
        height: 213px;
    }

    .descript {
        width: 50%;
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
    var conid = '<%= cleanXss(request.getParameter("id")) == null || "null".equals(cleanXss(request.getParameter("id"))) ? "" : cleanXss(request.getParameter("id")) %>';
    var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';
    var typeCode = '<%= cleanXss(request.getParameter("type")) %>';

    var FormNewPop;
    var LimitStore; //용량제한
    var sms = {
        smsPersonalPropertyGrid: "",
        presmsArea: "",
        presmsTextArea: "",
        limitByte: "",
        totallength: "",
        focusCHeck: null,
        detail: false,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
        exeContype: null,	//실행 채널 정보
        LimitCHk: true,
        previewChk: false
    }

    var personalType = [];
    var personalTypeChk = [];
    var surveyString = '';
    var empId;
    var empType;
    var phoneNo = '';

    //상세 페이지인지 체크
    function idCheck() {
        $('#ofrNmDiv').show();
        $('#ranDomOfrNmDiv').hide();
        $('#ofrPointDiv').hide();
        $('#surveyDiv').hide();

        // 상세페이지인 경우  상세정보 셋팅
        if (conid != "") {
            var mktOfrType = '';
            var ofrNm = '';
            var ridOfr = '';
            var surveyNm = '';
            var ridSurvey = '';

            $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
                id: conid
            }, function (result) {
                $("#contentsName").val(result.contentsName);
                sms.exeContype = result.contentsType;
                chnlCode = result.contentsType;
                $("#contentsFlag").val(result.contentsFlag);
                $("#smsArea").val(result.title);
                $("#txtMsgObject").val(result.txtMsgObject);
                $("#promMsgDateType").val(result.promMsgDateType);
                $("#promMsgHourType").val(result.promMsgHourType);
                $("#smsTextArea").val(result.contents);
                $("#textByteSize").val(result.textByteSize);
                $("#smsWarningArea").val(result.bottom);
                $("#chnlGuide").val(result.chnlGuide);
                $("#toCallbackNo").val(result.toCallbackNo);
                /*$("#gaTagVal").val(result.gaTagVal)*/
                $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", result.contsTypeCd, null, true);
                $("#contsChangeCd option[value='"+result.contentsType+"']").attr("selected", true);
                mktOfrType = result.comOfrType;
                ofrNm = result.ofrNm;
                ridOfr = result.ridOfr;
                surveyNm = result.surveyNm;
                ridSurvey = result.ridSurv;
            });
            sms.detail = true;
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
            $('#mktOfrTypeArea').hide();
            $('#ofrNmDiv').hide();
            $('#ofrPointDiv').hide();
            $('#surveyDiv').hide();
            $('#desArea').hide();
        }

        //개인화 로드
        personalChangeFun($('#contsTypeCd').val());
    }

    //저장 버튼클릭 시 동작
    function actionContent() {

        var resultFlag = false;

        smsvalidation = $("#contentForm").ifvValidation();
        isValid = smsvalidation.confirm();

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

        if (isValid) {
            checkByte('input')
            if (sms.LimitCHk) {
                if (Number(sms.totallength) < Number(sms.limitByte)) {
                    sms.LimitCHk = true
                }
            }
            if (sms.LimitCHk && isValid) {

                if (typeof closeContentsDesignPop == 'function') {
                    if(conid != null && conid != ''){
                        if(loadContentCheck) {
                            sms.detail = false;
                        } else {
                            sms.detail = true;
                        }
                    } else {
                        sms.detail = false;
                    }
                }

                //상세 페이지일 시 수정 작업 동작
                if (sms.detail) {
                    //오퍼 수정
                    $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                        contentsName: $("#contentsName").val()
                        , contentsType: chnlCode
                        , contentsFlag: $("#contentsFlag").val()
                        , title: $("#smsArea").val()
                        , txtMsgObject: $("#txtMsgObject option:selected").val()
                        , promMsgDateType: $("#promMsgDateType option:selected").val()
                        , promMsgHourType: $("#promMsgHourType option:selected").val()
                        , contents: $("#smsTextArea").val()
                        , html: $("#html").val()
                        , textByteSize: $("#textByteSize").val()
                        , bottom: $("#smsWarningArea").val()
                        , id: conid
                        , ridOfr: ofrRid
                        , contsTypeCd: $("#contsTypeCd").val()
                        , toCallbackNo: $("#toCallbackNo").val().replace(/-/g, '')
                        , comOfrType: mktOfrTypeSaveValue
                        , ridSurv: surveyRid
                        /*, gaTagVal: $('#gaTagVal').val()*/
                    }, function (result) {
                        if (sms.previewChk == false) {
                            alert('<spring:message code="M00429"/>');
                        }

                        idCheck();

                        resultFlag = true;
                    }, function (result) {
                            alert(result.message);
                        resultFlag = false;
                    });
                }
                //상세 페이지가 아닐 시 insert 동작
                else {
                    var camFlag = 0;
                    // 캠페인 확인.
                    if (openType != "") {
                        camFlag = '1';
                    }

                    $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
                        contentsName: $("#contentsName").val()
                        , contentsChannel: $("#contentsChanne").val()
                        , contentsType: chnlCode
                        , contentsFlag: $("#contentsFlag").val()
                        , title: $("#smsArea").val()
                        , txtMsgObject: $("#txtMsgObject").val()
                        , promMsgDateType: $("#promMsgDateType option:selected").val()
                        , promMsgHourType: $("#promMsgHourType option:selected").val()
                        , contents: $("#smsTextArea").val()
                        , bottom: $("#smsWarningArea").val()
                        , textByteSize: $("#textByteSize").val()
                        , camFlag: camFlag
                        , ridOfr: ofrRid
                        , contsTypeCd: $("#contsTypeCd").val()
                        , toCallbackNo: $("#toCallbackNo").val().replace(/-/g, '')
                        , comOfrType: mktOfrTypeSaveValue
                        , ridSurv: surveyRid
                        /*, gaTagVal: $('#gaTagVal').val()*/
                    }, function (result) {
                        if (sms.previewChk == false) {
                            alert('<spring:message code="M00430"/>');
                        }
                        conid = result.message;
                        sms.detail = true;

                        resultFlag = true;
                    });

                    if (openType == "") {
                        qtjs.href('/marketing/content/smsFormNew' + '?id=' + conid);
                    }
                }
                sms.previewChk = false;
            } else {
                alert(sms.limitByte + "<spring:message code='M00431'/>");
            }
            sms.previewChk = false;
        }
        return resultFlag;
    }

    /* 팝업 닫기 */
    function FormNewPopClose() {
        FormNewPop._destroy();
    }

    //개인화 속성 값 조회
    function smsPersonalPropertyGrid() {
        var jqGridOption = {
            onSelectCell: function (data) {
                Selectedid = data.id
            },
            serializeGridData: function (data) {
                data.groupCode = 'MKT_PERSONAL_TYPE_CD'
                data.enableNA = 'true'
                return data;
            },
            loadComplete: function (obj) {

            },
            url: '<ifvm:action name="getCommCodeList"/>',
            colNames: ['',
                '',
                ''
            ],
            colModel: [
                {name: 'markName', index: 'mark_name', resizable: false},
                {name: 'id', index: 'mc.id', resizable: false, hidden: true, searchable: false},
                {name: '', index: '', resizable: false, formatter: applyBtnFormat, align: 'center'}
            ],
            tempId: 'contentTextGridTemplete',
            caption: '<spring:message code="M00398"/>',
            rowNum: '100'
        };
        sms.smsPersonalPropertyGrid = $("#smsPersonalPropertyGrid").ifvGrid({jqGridOption: jqGridOption});

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

    function applyBtnFormat(cellValue, options, rowdata) {
        return "<button class='grid_apply_btn' id='" + options.rowId + "' onclick='javascript:persnalTypeClick(" + options.rowId + ")'><spring:message code='M00418'/></button>";
    }

    //총 용량 체크 (콘텐츠 내용을 체크하여 총용량을 계산한다.)
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

    //최대 용량 넘어갈 시 메세지 자르기
    function cutMessage(message, remainByte) {

        var totalByte = 0;
        var k = 0;
        for (var i = 0; i < message.length; i++) {
            var currentByte = message.charCodeAt(i);
            if (currentByte > 128) totalByte += 2;
            else totalByte++;

            if (totalByte > remainByte)
                break;

            k++;
        }
        return k;
    }

    //LMS로 바꿀건지 사용자에게 묻는 질문 메세지
    function getConfirm() {
        if (chnlCode == "SMS") {
            if (confirm(LimitStore + ' Byte 이상 입력되었습니다. LMS 채널로 전환하시겠습니까?') == true) {
                $("#contsChangeCd option[value='LMS']").attr("selected", true);

                $(this).parent().click();
                chnlCode = "LMS";
                getLimit();
                getChnltype();

                $('#smsArea').show();

                if ($('#txtMsgObject').val() == '0000') {
                    $('#smsArea').val("(공지)");
                } else {
                    $('#smsArea').val("(광고)");
                }

                var inputMessage = $("#smsArea").val();
                var textareaMessage = $("#smsTextArea").val();
                var warningMessage = $("#smsWarningArea").val();

                var inputByte = Number(totalBytecheck(inputMessage));
                var textareaByte = Number(totalBytecheck(textareaMessage));
                var warningByte = Number(totalBytecheck(warningMessage));
                var totalByte = inputByte + textareaByte + warningByte;
                sms.totallength = totalByte
                sms.limitByte = LimitStore;

                $("#textByteSize").val(totalByte);

                $('#txtMsgObjectDiv').show();

                return false;
            } else {
                chnlCode = "SMS";
                $("#contsChangeCd option[value='SMS']").attr("selected", true);

                return true;
            }
        }

    }

    //LMS로 바꿀건지 사용자에게 묻는 질문 메세지
    function getConfirmLms() {
        if (chnlCode == "SMS") {
            if (confirm('LMS 채널로 전환하시겠습니까?') == true) {
                $(this).parent().click();
                chnlCode = "LMS";
                getLimit();
                getChnltype();

                $('#smsArea').show();

                if ($('#txtMsgObject').val() == '0000') {
                    $('#smsArea').val("(공지)");
                } else {
                    $('#smsArea').val("(광고)");
                }

                var inputMessage = $("#smsArea").val();
                var textareaMessage = $("#smsTextArea").val();
                var warningMessage = $("#smsWarningArea").val();

                var inputByte = Number(totalBytecheck(inputMessage));
                var textareaByte = Number(totalBytecheck(textareaMessage));
                var warningByte = Number(totalBytecheck(warningMessage));
                var totalByte = inputByte + textareaByte + warningByte;
                sms.totallength = totalByte
                sms.limitByte = LimitStore;

                $("#textByteSize").val(totalByte);

                $('#txtMsgObjectDiv').show();

                return false;
            } else {
                $("#contsChangeCd option[value='SMS']").attr("selected", true);
                chnlCode = "SMS";
                return true;
            }
        }

    }

    //SMS로 바꿀건지 사용자에게 묻는 질문 메세지
    function getConfirmSms() {
        if (confirm('SMS 채널로 전환하시겠습니까?') == true) {
            $(this).parent().click();
            chnlCode = "SMS";
            getLimit();
            getChnltype();

            $('#smsArea').val(null);
            $("#smsWarningArea").val(null);
            $('#smsArea').hide();

            $('#txtMsgObjectDiv').hide();
            var inputMessage = $("#smsArea").val();
            var textareaMessage = $("#smsTextArea").val();
            var warningMessage = $("#smsWarningArea").val();

            var inputByte = Number(totalBytecheck(inputMessage));
            var textareaByte = Number(totalBytecheck(textareaMessage));
            var warningByte = Number(totalBytecheck(warningMessage));
            sms.limitByte = LimitStore;

            var remainByte = sms.limitByte - inputByte - warningByte;
            var k = cutMessage(textareaMessage, remainByte);
            $('#smsTextArea').val(textareaMessage.substring(0, k));

           inputMessage = $("#smsArea").val();
           textareaMessage = $("#smsTextArea").val();
           warningMessage = $("#smsWarningArea").val();

           inputByte = Number(totalBytecheck(inputMessage));
           textareaByte = Number(totalBytecheck(textareaMessage));
           warningByte = Number(totalBytecheck(warningMessage));

            var totalByte = inputByte + textareaByte + warningByte;
            sms.totallength = totalByte

            $("#textByteSize").val(totalByte);

            return false;
        } else {
            $("#contsChangeCd option[value='LMS']").attr("selected", true);
            chnlCode = "LMS";
            return true;
        }
    }

    //콘텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
    function checkByte(inputType) {
        var inputMessage = $("#smsArea").val();
        var textareaMessage = $("#smsTextArea").val();
        var warningMessage = $("#smsWarningArea").val();

        var inputByte = Number(totalBytecheck(inputMessage));
        var textareaByte = Number(totalBytecheck(textareaMessage));
        var warningByte = Number(totalBytecheck(warningMessage));
        var totalByte = inputByte + textareaByte + warningByte;
        sms.totallength = totalByte
        sms.limitByte = LimitStore;

        $("#textByteSize").val(totalByte);

        if (totalByte > sms.limitByte) {
            var confirmChk = true; //to컨펌 창의 값이 true인지 false인지 체크

            sms.LimitCHk = false;
            // SMS 일 경우 90byte 초과시 LMS로 바꿀건지 여부 체크
            if (confirmChk == true) {
                getConfirm();
                //제한 용량을 벗어났음을 알리는 경고 창.
                //$("#textByteSize").val(LimitStore);
                if (inputType == "input") {
                    var remainByte = sms.limitByte - textareaByte - warningByte;
                    var k = cutMessage(inputMessage, remainByte);
                    $('#smsArea').val(inputMessage.substring(0, k));
                } else if (inputType == "textarea") {
                    var remainByte = sms.limitByte - inputByte - warningByte;
                    var k = cutMessage(textareaMessage, remainByte);
                    $('#smsTextArea').val(textareaMessage.substring(0, k));
                } else if (inputType == "warning") {
                    var remainByte = sms.limitByte - inputByte - textareaByte;
                    var k = cutMessage(warningMessage, remainByte);
                    $('#smsWarningArea').val(warningMessage.substring(0, k));
                }
            }
        } else {
            sms.LimitCHk = true;
            $(".sms_kinds").find('span').text(chnlCode)
        }
        inputMessage = $("#smsArea").val();
        textareaMessage = $("#smsTextArea").val();
        warningMessage = $("#smsWarningArea").val();

        inputByte = Number(totalBytecheck(inputMessage));
        textareaByte = Number(totalBytecheck(textareaMessage));
        warningByte = Number(totalBytecheck(warningMessage));
        totalByte = inputByte + textareaByte + warningByte;
        sms.totallength = totalByte
        sms.limitByte = LimitStore;
        $("#textByteSize").val(totalByte);
    }

    //현재 커서 위치에 개인화 속성 값 추가하기
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
        } else if (br == "ff") {
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
        } else if (br == "ff") {
            smsTextArea.selectionStart = strPos;
            smsTextArea.selectionEnd = strPos;
            smsTextArea.focus();
        }
        smsTextArea.scrollTop = scrollPos;
    }

    //개인화 속성 버튼 누를 시 Text 값이 들어가는  action
    //여기
    function persnalTypeClick(id) {
        var perText = "{{" + $("#" + id + " td:eq('0')").text() + "}}";

        insertAtCursor(smsTextArea, perText)
        checkByte('textarea');
    }

    function getChnltype() {
        //Test 발송을 위한 mms/sms 구분
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_TYPE_CD'
            , enableNA: true
        }, function (result) {
            var size = result.rows.length;
            for (var i = 0; i < size; i++) {
                //신규 페이지 일 시
                if (chnlCode != "null") {
                    if (result.rows[i].codeName == chnlCode) {
                        var typeCodeId = result.rows[i].codeId;
                        chnlCode = result.rows[i].codeName;
                        sms.exeContype = result.rows[i].codeId;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                        chnlGuide(); // 작성가이드 세팅
                    }
                }
                //상세 페이지 일 시
                else {
                    if (sms.exeContype != null) {
                        if (sms.exeContype == result.rows[i].codeName) {
                            chnlCode = result.rows[i].codeName;
                            $('#chnlTitleArea').text(result.rows[i].markName);
                        }
                    }
                }
            }
            $('.sms_kinds').text('<spring:message code="M00393"/> / ' + chnlCode)
        });
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
    }

    function initSetting() {
        // 무료수신거부 공통 코드.

        $.fn.ifvmSetSelectOptionCommCode("promMsgDateType", "PROM_MSG_DATE_TYPE", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("promMsgHourType", "PROM_MSG_HOUR_TYPE", null, null, true);

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
            groupCode: 'TXT_MSG_OBJECT_CD',
            enableNA: true
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
    }

    function getLimit() {

        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_LIMITE'
            , enableNA: true
        }, function (result) {
            var text = "L" + chnlCode;
            var size = result.rows.length

            //각 LMS,SMS 등에 맞는 용량 가져오기.
            for (var i = 0; i < size; i++) {
                if (result.rows[i].codeName == text) {
                    LimitStore = result.rows[i].attrib01
                }
            }
        });
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

            if (addContent == false && $("#smsTextArea").val().startsWith(searchString)) {
                addContent = true;
                $("#smsTextArea").val($("#smsTextArea").val().replace(searchString, selectMsg));
            }
        }
        if (addTitle == false && chnlCode == 'LMS') $("#smsArea").val(selectMsg + $("#smsArea").val());
        if (addContent == false && chnlCode == 'SMS') $("#smsTextArea").val(selectMsg + $("#smsTextArea").val());

        checkByte('input');
        checkByte('textarea');
    }

    //쿠폰 리스트 팝업
    function ofrListPop() {
        var openflag = true;

        // 오퍼 관련 - 캠페인 워크플로우 일 경우만 (캠페인 내 채널중 오퍼 다중 등록 방지)
        if (openType == "WF" && typeof campaign != "undefined") {
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {
                    campaignId: campaign.id,
                    contentsId: conid
                },
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
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {
                    campaignId: campaign.id,
                    contentsId: conid
                },
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
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {
                    campaignId: campaign.id,
                    contentsId: conid
                },
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

    $(document).ready(function () {
        //$('#toCallbackNo').val('0316463563');

        $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);

        $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", null, null, true);
        $('#contsTypeArea').hide();
//     $("#contsTypeCd option[value='NOTI']").hide();
        $.fn.ifvmSetSelectOptionCommCode("contsChangeCd", "MKT_CAM_CHNL_TYPE_CD", null, null, true);
        $("#contsChangeCd option[value='EMAIL']").remove();
        $("#contsChangeCd option[value='PUSH']").remove();
        $("#contsChangeCd option[value='KAKAONOTI']").remove();
        $("#contsChangeCd option[value='KAKAOFR']").remove();
        $("#contsChangeCd option[value='MMS']").remove();

        $.ifvmLnbSetting('contentListNew');
        contentAuth();
        initSetting();
        idCheck();
        getChnltype();
        getLimit();
        smsPersonalPropertyGrid();
        checkByte('textarea');
        checkByte('warning');
        getPersonalType();


        $("#contsChangeCd").change(function () {
            if($("#contsChangeCd").val() == 'SMS'){
                getConfirmSms();
            } else {
                getConfirmLms();
            }
        });

        $("#contsTypeCd").change(function () {
            personalChangeFun($('#contsTypeCd').val());
        });

        $("#btnList").click(function () {
            qtjs.href('<ifvm:url name="contentListNew"/>');
        });

        $('#btnOfrListPop').on('click', function () {
            ofrListPop();
        });


        $("#txtMsgObject").change(function () {
            setTxtMsg(); //메세지 유형 설정
        });

        $("#persnal").on('change', function () {

            /*personalTypeChk.push($("#persnal option:selected"));*/

            if (checkPersonalType() === false) {
                alert('개인화 속성은 5가지를 넘길 수 없습니다.')
                $("#persnal option:eq(0)").attr("selected", "selected");
                return;
            }

            var persnalCheckedData = $("#persnal option:selected").val();
            if (chnlCode == 'SMS') {
                if (persnalCheckedData == '설문URL') {
                    alert('SMS 컨텐츠에서는 설문URL 필드값을 선택 하실 수 없습니다. ')
                    $("#persnal option:eq(0)").attr("selected", "selected");
                    return;
                }
            }
            if ($("#persnal option:selected").text() != '<spring:message code="M00436"/>') {
                var text = "{{" + $("#persnal option:selected").text() + "}}";
                if (sms.focusCHeck == smsArea) {
                    insertAtCursor(smsArea, text);
                    checkByte('input');
                } else {
                    insertAtCursor(smsTextArea, text);
                    checkByte('textarea');
                }
            }
            $("#persnal option:eq(0)").attr("selected", "selected");
        });

        $("#smsTextArea").on('blur', function () {
            sms.focusCHeck = smsTextArea;
        });
        $("#smsArea").on('blur', function () {
            sms.focusCHeck = smsArea;
        });

        $("#smsTextArea").bind('keyup', function () {
            checkByte('textarea');
        });
        $("#smsArea").bind('keyup', function () {
            checkByte('input');
        });

        $("#smsWarningArea").bind('keyup', function () {
            checkByte('warning');
        });

        $("#saveBtn").on('click', function () {
            //메세지유형 체크
            var validTextArea = $("#smsTextArea").val();
            var validTitleArea = $("#smsArea").val();
            var checkMsg = $("#txtMsgObject option:selected").text();
            var result;
            var checkTitle = $("#smsArea").val();

// 		if(chnlCode == 'SMS' && validTextArea.indexOf(checkMsg) > -1){
            // 저장
// 	        result = actionContent();
// 		}else if(chnlCode == 'LMS' && validTitleArea.indexOf(checkMsg) > -1){
            // 저장
            //result = actionContent();
// 		}else{
// 			alert('<spring:message code="M00433"/>');
// 		}

            //URL 포함인지 확인
            if ($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
                alert(surveyString)
                return;
            }

            if (chnlCode == 'LMS' && (checkTitle == null || checkTitle == '')) {
                alert('LMS 전송 시, 제목은 필수입니다.')
            } else {
                result = actionContent();
            }

            if (result == true) {
                // 컨텐츠 팝업 종료
                if (typeof closeContentsDesignPop == 'function') {
                    closeContentsDesignPop();
                }
            }
        });

        //테스트 발송
        $('#smsTestSendBtn').on('click', function () {
            sms.previewChk = true;

            sms.presmsArea = $('#smsArea').val();
            sms.presmsTextArea = $('#smsTextArea').val();
            presmsWarningArea = $("#smsWarningArea").val();


            //URL 포함인지 확인
            if ($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
                alert(surveyString)
                return;
            }

            var resultFlag = actionContent();
            checkByte('input');
            if (sms.LimitCHk) {
                if (Number(sms.totallength) < Number(sms.limitByte)) {
                    sms.LimitCHk = true
                }
            }
            if (sms.LimitCHk == false) {
                alert(sms.limitByte + "<spring:message code='M00431'/>");
                return;
            }
            if (resultFlag == false) return;

            if (conid != '') {
                $("#FormNewPop").ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="MKTSmsPreviewPop"/>',
                    contentType: "ajax",
                    title: '<spring:message code="M00419"/>',
                    width: 800,
                    close: 'FormNewPopClose'
                });
            } else {
                alert('<spring:message code="M00448"/>');
            }
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

        // 개인화 버튼 숨김
        $('#uploadPersnalTypeBtn').hide();

        smsvalidation = $("#contentForm").ifvValidation();

        if (chnlCode == 'SMS') {
            $("#smsArea").hide();
        }

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

    //LMS 신규 페이지 일시 작성 가이드 셋팅
    function chnlGuide() {
        if (chnlCode == "LMS") {
            $.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
                chnltype: "LMS"
            }, function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    $("#chnlGuide").val(result.chnlGuide);
                }
            });
        } else if (chnlCode == "SMS") {
            $.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
                chnltype: "SMS"
            }, function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    $("#chnlGuide").val(result.chnlGuide);
                }
            });
        }
    }

    //설문 url 체크
    function checkURLYn() {
        var checkText = $("#smsTextArea").val()
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

    function getPersonalType() {
        $.ifvSyncPostJSON('<ifvm:action name="getPersonalType"/>', {}, function (result) {
            for (i = 0; i < result.length; i++) {
                personalType.push(result[i].markName);
            }
        });
    }

    function checkPersonalType() {
        var chkFlag = 1;
        var smsText = $("#smsTextArea").val() + $("#smsArea").val() + $("#smsWarningArea").val();

        for (i = 0; i < personalType.length; i++) {
            if (smsText.indexOf(personalType[i]) != -1) {
                if (smsText.indexOf($('#persnal').val()) == -1){
                    chkFlag++;
                }
            }
        }

        if (chkFlag > 5) {
            return false;
        }
    }
</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>


</script>

<script id="MsgTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>


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
            <button class="btn btn-sm" id='saveBtn' objCode="smsFormNewSaveBtn_OBJ">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
            <button class="btn btn-sm" id="smsTestSendBtn" objCode="smsFormNewTestSendBtn_OBJ">
                <spring:message code="M00391"/>
            </button>
            <button class="btn btn-sm btn_gray" id="btnList" objCode="smsFormNewList_OBJ">
                <spring:message code="C00166"/>
            </button>
        </div>
    </div>
</div>

<div id="contentForm" class="well form-horizontal content_textImage_con">
    <br>
    <div class="phoneImage" id="smsPhoneArea">
        <div class="sms_kinds"><spring:message code="M00393"/> / <span>SMS</span></div>
        <!-- 단문SMS/ 장문SMS /이미지MMS /PUSH -->
        <div class="phoneWrap">
            <ifvm:input type="text" id="smsArea" placeholder="M00394" maxLength="50"/>
            <div class="textareaBox">
                <ifvm:input type="textarea" required="true" className="sms_phone_area" id="smsTextArea"/>
            </div>
            <div class="warningBox">
                <ifvm:input type="textarea" className="sms_phone_area" id="smsWarningArea"/>
            </div>
            <label class="phone_text"><spring:message code="M00397"/></label>
            <ifvm:input type="text" className="inputText" disabled="true" id="textByteSize"/>
            <span class="phone_text"><spring:message code="M00798"/></span>
        </div>
    </div>

    <div class="col-xs-8 control_content">
        <div class="input_area" id="selectForm">
            <div class="row">
                <%-- 제목 --%>
                <ifvm:inputNew type="text" required="true" id="contentsName" label="M00376" labelClass="2"
                               conClass="7"/>
            </div>
            <div class="row">
                <%-- 송신자 번호 --%>
                <ifvm:inputNew type="text" id="toCallbackNo" label="송신자 번호" labelClass="2" conClass="7"
                               required="true"/>
            </div>
<%--            <div class="row" id="gaTagArea" >
                &lt;%&ndash; gaTag&ndash;%&gt;
                 <label class="col-xs-2 control-label" id="gaTagId"><spring:message code="GA TAG"/></label>
                <ifvm:inputNew type="text" id="gaTagVal" conClass="7"/>
            </div>--%>

            <div class="row" id="txtMsgObjectDiv">
                <%-- 메세지유형 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message
                        code="M00388"/></label>
                <div class="col-xs-7 control_content">
                    <ifvm:input type="select" id="txtMsgObject"/>
                </div>

            </div>


            <%-- <div class="row" id="txtMsgObjectDiv">

                메세지유형
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="발송유형"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="select" id="promMsgHourType"/>
                </div>
            </div>

            <div class="row" id="txtMsgObjectDiv">

                메세지유형
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="발송시각"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="select" id="promMsgDateType"/>
                </div>

            </div> --%>
            <div class="row">
                <%-- 개인화속성 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00398"/></label>
                <div class="col-xs-7 control_content">
                    <ifvm:input type="select" id="persnal"/>
                </div>
            </div>

            <div class="row" id="contsTypeArea">
            <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd"/>
            </div>
            <%--            <br>--%>
            <div class="row">
            <ifvm:inputNew type="select" id="contsChangeCd" names="contsChangeCd" dto="contsChangeCd" label="M03094" labelClass="2" conClass="7"/>
            </div>

            <div class="row" id="mktOfrTypeArea">
                <%-- 오퍼유형 --%>
                    <label class="col-xs-2 control-label"><spring:message code="M03049"/></label>
                <ifvm:inputNew type="select" id="mktOfrType" names="mktOfrType" dto="mktOfrType" conClass="7"/>
            </div>

            <%--오퍼(쿠폰) --%>
            <div class="row qt_border" id="ofrNmDiv">
                <ifvm:inputNew type="search" clearArgs="'ofrNm,ridOfr'" id="ofrNm" hidId="ridOfr" hidDto="ridOfr"
                               btnFunc="ofrListPop" dto="ofrNm" names="ofrNm" label="쿠폰"
                               labelClass="2" conClass="7"/>
            </div>
            <%--포인트 --%>
            <div class="row qt_border" id="ofrPointDiv">
                <ifvm:inputNew type="search" clearArgs="'ofrPoint,ridPoint'" id="ofrPoint" hidId="ridPoint"
                               hidDto="ridPoint" btnFunc="ofrPointListPop" dto="ofrPoint" names="ofrPoint"
                               label="포인트" labelClass="2" conClass="7"/>
            </div>
            <%--설문 --%>
            <div class="row qt_border" id="surveyDiv">
                <ifvm:inputNew type="search" clearArgs="'surveyNm,ridSurvey'" id="surveyNm" hidId="ridSurvey"
                               hidDto="ridSurvey" btnFunc="surveyListPop" dto="surveyNm" names="surveyNm"
                               label="설문" labelClass="2" conClass="7"/>
            </div>

            <div id="desArea">
					<textarea class='descript' maxlength="50" rows="3" readonly=true>
1. 송신자 번호 : 18990232
2. 무료수신거부 : 0808730002
3. 문의 : 0805655600
					</textarea>
            </div>
            <label class="col-xs-8" style="color: red; text-align: center">※ 개인화 속성은 5가지를 초과할 수 없습니다.</label>
            <%-- 채널 가이드 --%>
            <%-- 		<div>
                        <label class="description_title"><spring:message code="M00400"/></label>
                        <div class="chnl_guide">
                            <ifvm:input type="textarea" id="chnlGuide" readonly="readonly"/>
                        </div>
                    </div> --%>
        </div>
    </div>

</div>


<div id="FormNewPop" class="popup_container"></div>
<div id="ofrListPopDialog" class="popup_container"></div>
<div id="ofrPointListPopDialog" class="popup_container"></div>
<div id="surveyListPopDialog" class="popup_container"></div>