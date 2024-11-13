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
<script>

    var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';
    var htmlStore; //html 형식 저장소
    var conid = '<%= cleanXss(request.getParameter("id")) == null || "null".equals(cleanXss(request.getParameter("id"))) ? "" : cleanXss(request.getParameter("id")) %>';

    var chnlCode = 'EMAIL';

    var rteeObj;
    var chtmlContentsArea, ctitle, fileName; // 미리 보기 전달을 위한 변수
    var FileData;
    var arrUploadFileList = [];
    var FiletypeString = [];       //파일 타입 검사
    var sizeStore = [];
    var typeCodeId;
    var filePath = null;
    var personalPropertyGrid;
    var parId;
    var exeContype = null;
    var saveCheck = false;  //실제 파일을 지우기 위한 체크
    var filecheck = false;  //실제 파일을 올렸는지의 체크 여부
    var previewChk = false;
    var typeCheck = true;   //파일 타입 검사
    var detail = false;     //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
    var focusCHeck;
    var mmsFormNewPop;
    var oldFileDelCheck = false;
    var contsimagetype = "USERCONTS_EMAIL";
    var notiContentsName = null;
    var notiTitle = null;
    var notiHtml = null;
    var typeCode = '<%= cleanXss(request.getParameter("type")) %>';
    var personalType = [];
    var surveyString = '';

    var empType;
    var empId;

    function contentEmailPopupInit() {
        if (rteeObj)
            rteeObj.destroy();

        initEmailFormNew();
    }

    //현재 채널 타입 세팅
    function getChnltype() {
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_TYPE_CD'
            , enableNA: true
        }, function (result) {
            var size = result.rows.length;
            for (var i = 0; i < size; i++) {

                //신규 페이지 일 시
                if (chnlCode != "null") {
                    if (result.rows[i].codeName == chnlCode) {
                        typeCodeId = result.rows[i].codeId;
                        exeContype = result.rows[i].codeName;
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                } else {
                    //상세 페이지 일 시
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

    function rteInit() {
        $("#htmlContentsArea").ejRTE({
            width: "100%",
            minWidth: "10px",
            showFooter: true,
            showHtmlSource: true,
            maxLength: 90000000,
            tools: {
                formatStyle: ["format"],
                font: ["fontSize", "fontColor", "backgroundColor"],
                style: ["bold", "italic", "underline"],
                indenting: [],
                images: [],
                tables: [],
                doAction: [],
                links: [],
                media: [],
                view: ["fullScreen"]
            },
            select: function () {
                focusCHeck = 'htmlContentsArea_Iframe'
            }
        });

        rteeObj = $("#htmlContentsArea").data("ejRTE");
    }

    function initEmailFormNew() {

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

        rteInit();

        getChnltype();

        htmlStore = "";
        $.ifvmLnbSetting('contentListNew');

        $("#fileRemoveBtn").hide();

        //rich text editor 설정
        //setRichTextEditor();


        //이메일 유형 조회
        getContsEmailTypeCode();

        //채널 유형 조회
        getCamChnlTypeCode();

        //상세여부 확인 및 데이터 조회
        idCheck();

        emialvalidation = $("#selectForm").ifvValidation();
    }

    //이메일 유형 조회
    function getContsEmailTypeCode() {
        //콘텐츠 이메일 유형 값 코드
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'CONTS_EMAIL_TYPE_CD'
            , enableNA: true
        }, function (result) {
            var temp = $("#emailTypetemp").tmpl(result.rows);
            $("#emailType").empty().append(temp);
        });
    }

    //채널 유형 조회
    function getCamChnlTypeCode() {
        // Test 발송을 위한 mms/sms/push 구분
        $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
            groupCode: 'MKT_CAM_CHNL_TYPE_CD',
            enableNA: true
        }, function (result) {
            var size = result.rows.length;
            for (var i = 0; i < size; i++) {

                // 신규 페이지 일 시
                if (chnlCode != "null") {
                    if (result.rows[i].markName == chnlCode) {
                        typeCodeId = result.rows[i].codeId;
                        exeContype = result.rows[i].codeId;
                        chnlCode = result.rows[i].codeName;
                    }
                } else {
                    // 상세 페이지 일 시
                    if (exeContype != null) {
                        if (exeContype == result.rows[i].codeId) {
                            chnlCode = result.rows[i].codeName;
                        }
                    }
                }
            }
        });
    }

    //트리거 세팅
    function searchFile() {
        $("#fileAdd").trigger("click");
    }

    //파일 클릭 후 파일  이름을 넣어주기
    function changeFile() {

        var value = $("#fileAdd").val();
        var array = value.split("\\");
        var name = array[array.length - 1];

        $("#fileValue").val(name);
        $("#fileNameText").text(name);
        $("#fileNameText").show();
    }

    //상세페이지 체크
    function idCheck() {

        if (conid != "") {
            $.ifvSyncPostJSON('<ifvm:action name="getEmailDtlList"/>', {
                id: conid
            }, function (result) {
                $("#contentsName").val(result.contentsName);
                notiContentsName = result.contentsName;
                $("#title").val(result.title);
                notiTitle = result.title;
                $("#emailType").val(result.emailType);
                exeContype = result.contentsType;
                $("#textByteSize").val(result.textByteSize);

                $('#surveyNm').val(result.surveyNm);
                $('#ridSurvey').val(result.ridSurv);

                $("#txtMsgObject").val(result.txtMsgObject);


                htmlStore = result.html;
                notiHtml = result.html;

                $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", result.contsTypeCd, null, true);
                if (result.fileName != null) {
                    detailFIleSetting(result.fileName)
                    filePath = result.filePath;
                    saveCheck = true;
                    $("#fileRemoveBtn").show();
                    $("#emailFileUpload").show();
                } else {
                    $("#fileNameText").text("");
                    $("#fileNameText").hide();
                    $("#fileRemoveBtn").hide();
                    $("#fileAddBtn").show();
                }
            });
            detail = true;
            $('#contsTypeCd').attr('disabled', true);
        } else {
            $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", typeCode, null, true);
            $('#contsTypeCd').attr('disabled', true);
            $('#txtMsgObjectDiv').hide();
            if(empType != 'H'){
                $('#surveyDiv').hide();
            }
            //메세지 유형 설정
            setTxtMsg();
        }

        //html load시 콘텐츠 내용이 초기화 되어 timeout으로 재설정
        setTimeout(function () {
            if ($("#htmlContentsArea").length)
                rteeObj.setHtml(htmlStore);
        }, 600);

        //개인화 속성 값 조회
        setPersonalProperty($('#contsTypeCd').val());
    }

    function detailFIleSetting(fileName) {
        $("#fileNameText").show();
        $("#fileNameText").text(fileName);
        $("#fileAddBtn").hide();
    }

    //저장 버튼클릭 시 동작
    function actionContent() {
        var resultFlag = false;
        var mktOfrTypeSaveValue = null;

        emialvalidation = $("#selectForm").ifvValidation();
        isValid = emialvalidation.confirm();

        if (isValid) {
            if ($('#ridSurvey').val() != null && $('#ridSurvey').val() != '') {
                mktOfrTypeSaveValue = 'S';
                surveyRid = $('#ridSurvey').val();
            } else {
                mktOfrTypeSaveValue = null;
                ofrRid = null;
                surveyRid = null;
            }
            //상세 페이지일 시 수정 작업 동작
            if (typeof closeContentsDesignPop == 'function') {
                if(conid != null && conid != ''){
                    if(loadContentCheck) {
                        detail = false;
                    } else {
                        detail = true;
                    }
                } else {
                    detail = false;
                }
            }
            if (detail) {
                //이메일 콘텐츠 수정
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                    contentsName: $("#contentsName").val()
                    , title: $("#title").val()
                    , emailType: $("#emailType").val()
                    , html: $("#htmlContentsArea_Iframe").contents().children().children().next().html()
                    , textByteSize: $("#textByteSize").val()
                    , imgSize: $("#imgSize").val()
                    , imgCnt: $("#imgCnt").val()
                    , id: conid
                    , ridSurv: $('#ridSurvey').val()
                    , contsTypeCd: $("#contsTypeCd").val()
                    , txtMsgObject: $("#txtMsgObject option:selected").val()
                    , comOfrType: mktOfrTypeSaveValue
                    , contents : rteeObj.getText()
                }, function (result) {
                    if (previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }
                    idCheck();

                    resultFlag = true;
                });
            }
            //상세 페이지가 아닐 시 insert 동작
            else {
                var camFlag = 0;
                //캠페인 워크플로우인지 확인한다.
                if (openType != "") {
                    camFlag = '1';
                }

                $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
                    contentsName: $("#contentsName").val()
                    , contentsType: chnlCode
                    , title: $("#title").val()
                    , emailType: $("#emailType").val()
                    , html: $("#htmlContentsArea_Iframe").contents().children().children().next().html()
                    , textByteSize: $("#textByteSize").val()
                    , imgSize: $("#imgSize").val()
                    , imgCnt: $("#imgCnt").val()
                    , contents: $("#htmlContentsArea_Iframe").contents().find("#conTable").find("tr:eq(2)").text()
                    , camFlag: camFlag
                    , ridSurv: $('#ridSurvey').val()
                    , contsTypeCd: $("#contsTypeCd").val()
                    , txtMsgObject: $("#txtMsgObject").val()
                    , comOfrType: mktOfrTypeSaveValue
                    , contents : rteeObj.getText()
                }, function (result) {
                    if (previewChk == false) {
                        alert('<spring:message code="M00430"/>');
                    }
                    conid = result.message;
                    detail = true;

                    idCheck();
                    resultFlag = true;
                });
                if (openType == "") {
                    qtjs.href('/marketing/content/emailFormNew' + '?id=' + conid);
                }
            }
        }
        previewChk = false;

        return resultFlag;
    }

    function editorInit() {
        $('.e-rte-footer-right .clearFormat').remove();
        $('.e-rte-footer-right .clearAll').remove();
        $('.e-rte-footer-right .e-rte-resize').remove();
        $('.e-rte-footer-right .e-rte-wordcount').remove();
    }

    //개인화 속성 값 조회
    function setPersonalProperty(changeType) {
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
        $("#persnal option[value='쿠폰난수번호']").attr('disabled', 'disabled').hide();
    }

    //파일첨부 추가하기
    function fileAdd(_this) {
        if (_this.value) {
            fileCHeck()
        }
    }

    //파일첨부 삭제
    function fileRemove() {
        $("#fileNameText").text("");
        $("#fileNameText").hide();
        $("#fileAddBtn").show();
        $("#fileRemoveBtn").hide();

        filePath = "";
        filename = "";

        oldFileDelCheck = true;
        filecheck = false;
        saveCheck = false;
    }

    /* 팝업 닫기 */
    function mmsFormNewPopClose() {
        mmsFormNewPopDialog._destroy();
    }

    //테스트 발송
    function sendTestPop() {
        if ($("#contsTypeCd").val() == "mkt") {
            $("#mmsFormNewPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="MKTEmailPreviewPop"/>',
                contentType: "ajax",
                title: '<spring:message code="M00419"/>',
                width: 1022,
                close: 'mmsFormNewPopClose'
            });
            mmsFormNewPop = $("#mmsFormNewPopDialog").data("ifvsfPopup");
        } else {
            if (conid != "") {

                if (notiContentsName == $("#contentsName").val()
                    && notiTitle == $("#title").val()
                    && notiHtml == $("#htmlContentsArea_Iframe").contents().children().children().next().html()) {
                    $("#mmsFormNewPopDialog").ifvsfPopup({
                        enableModal: true,
                        enableResize: false,
                        contentUrl: '<ifvm:url name="notiEmailPreviewPop"/>',
                        contentType: "ajax",
                        title: '<spring:message code="M00419"/>',
                        width: 1030,
                        close: 'mmsFormNewPopClose'
                    });
                    mmsFormNewPop = $("#mmsFormNewPopDialog").data("ifvsfPopup");
                } else {
                    alert('<spring:message code="M00448"/>')
                }
            } else {
                alert('<spring:message code="M00448"/>')
            }
        }
    }

    //파일을 실제 서버에 업로드
    function fileServerUpload() {
        //기존 파일 삭제
        if (oldFileDelCheck) {
            $.ifvSyncPostJSON('<ifvm:action name="removeContentFile"/>', {
                id: conid
            }, function (result) {
            });

            //초기화
            oldFileDelCheck = false;
        }

        if (filecheck) {
            var uploadObject = new Object;
            uploadObject.size = FileData[0].size;
            uploadObject.accountId = conid;
            uploadObject.filePath = FileData[0].url;
            uploadObject.fileName = FileData[0].name;
            uploadObject.realfileName = FileData[0].oriFileName;

            uploadObject.fileType = $('#fileType').val();
            uploadObject.description = $('#description').val();

            uploadObject.extension = FileData[0].name.split('.')[1];

            $.ifvSyncPostJSON('<ifvm:action name="addfile"/>',
                uploadObject,
                function (result) {
                    $('#closeBtn').trigger('click');
                    $('#description').val('');
                    $('#fileValue').val('');
                    saveCheck = true;
                });
        }
    }

    //현재 세팅되어 있는 파일 형식 가져오기.
    function getFileUpType() {
        $.ifvSyncPostJSON('<ifvm:action name="getFileUpType"/>', {
            id: conid
        }, function (result) {
            var size = result.length;
            for (var i = 0; i < size; i++) {
                FiletypeString[i] = result[i].name;
                sizeStore.push(result[i])
            }
        });
    }

    function fileCHeck() {
        getFileUpType();
        var size = FiletypeString.length;
        var typeCheck;
        var count = 0;
        var fileType;

        for (var i = 0; i < size; i++) {
            var SubSize = $("#fileAdd")[0].files[0].name.split('.');

            if ($("#fileAdd")[0].files[0].name.split('.')[SubSize.length - 1] == FiletypeString[i].toLowerCase()) {
                fileType = FiletypeString[i].toLowerCase()
                count++;
            }
        }

        if (count > 0) {
            typeCheck = true;
        } else {
            typeCheck = false;
        }

        var size = sizeStore.length
        var sizeCheck = true;
        //채널에 설정된 각 이미지 버전에 맞는 용량 비교.
        for (var i = 0; i < size; i++) {
            if (fileType == (sizeStore[i].name).toLowerCase()) {
                if ($("#fileAdd")[0].files[0].size > (sizeStore[i].maxVol * 1024)) {
                    sizeCheck = false;
                }
            }
        }

        if (typeCheck) {
            if (sizeCheck) {
                var formData = new FormData();
                formData.append("file", $("#fileAdd")[0].files[0]);
                $.ajax({
                    url: '<ifvm:action name="tempUpload"/>',
                    data: formData, processData: false, contentType: false, type: 'POST',
                    success: function (data) {

                        changeFile();
                        data[0].oriFileName = $("#fileNameText").text();
                        FileData = data;
                        filePath = FileData[0].url;

                        $("#fileAdd").removeAttr("value");
                    }
                });
                filecheck = true;
                $("#fileAddBtn").hide();
                $("#fileRemoveBtn").show();
                $("#fileNameText").show();
            } else {
                alert('<spring:message code="M00384"/>');
            }
        } else {
            alert('<spring:message code="M00458"/>');
            fileRemove();
            filecheck = false;
            $("#fileAdd").removeAttr("value");
        }

        if ($("#fileAdd")[0].files[0].name.split('.')[0].length > 50) {
            fileRemove();
            filecheck = false;
            $("#fileAdd").removeAttr("value");
            alert('<spring:message code="M00457"/>')
        }
    }

    //현재 커서 위치에 개인화 속성 값 추가하기
    function insertAtCursor(area, text) {
        var smsTextArea = document.getElementById(area);
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


    //editor 한글로 변경
    ej.RTE.Locale["ko"] = {
        dialogInsert: '<spring:message code="M00736"/>',
        dialogCancel: '<spring:message code="M00737"/>',
        linkOpenInNewWindow: '<spring:message code="M00738"/>'
    }

    //파일 다운로드
    function emailFormFileDownload() {
        var fileName = $("#fileNameText").text();
        var params = {fileName: fileName, filePath: filePath};
        $.fn.ifvmFileDownload(params);
    }

    //rich text editor 설정
    function setRichTextEditor() {

    }

    //이미지 팝업 열기
    function openImagePopup() {
        var pushType = $("#contsPushType").val();

        //팝업창에서 이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
        $("#mmsFormNewPopDialog").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            //contentUrl: '<ifvm:url name="MKTAddImagePop"/>',
            contentUrl: '<ifvm:url name="MKTAddImagePopS3"/>?type=email',
            contentType: "ajax",
            title: '<spring:message code="M00797"/>',
            width: 870,
            close: 'mmsFormNewPopClose'
        });
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
            if (addTitle == false && $("#title").val().startsWith(searchString)) {
                addTitle = true;
                $("#title").val($("#title").val().replace(searchString, selectMsg));
            }
        }
        if (addTitle == false) $("#title").val(selectMsg + $("#title").val());

    }

    function copyToClipboard() {
        var t = document.createElement("textarea");
        document.body.appendChild(t);
        t.value = $('#copyTextArea').val();
        t.select();
        document.execCommand('copy');
        document.body.removeChild(t);
        alert('클립보드에 복사 되었습니다.');
    }

    function contentAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            empType = result.rows[0].empType;
        });
    }


    $(document).ready(function () {

        $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);
        $('#contsTypeCd').hide();

        //권한 불러오가
        contentAuth();

        //초기 설정
        initEmailFormNew();
        getPersonalType();

        $("#btnList").click(function () {
            qtjs.href('<ifvm:url name="contentListNew"/>');
        });

        $("#fileNameText").change(function () {
            searchFile();
        });

        $("#hideFile").change(function () {
            fileCHeck();
        });

        //파일 첨부 추가
        $("#fileAdd").on("change", function () {
            fileAdd(this);
        });

        //파일 첨부 삭제
        $("#fileRemoveBtn").on("click", function () {
            fileRemove();
        });

        $("#htmlContentsArea_fullScreen").on("click", function () {
            $("#htmlContentsArea_wrapper").css("top", "0");
        });

        // 개인화 버튼 숨김
        $('#uploadPersnalTypeBtn').hide();

        // 이미지 팝업 호출 이벤트
        $('#mmsImage').on('click', function () {
            //이미지 팝업 열기
            openImagePopup();
        });

        //쿠폰리스트
        // $('#btnOfrListPop').on('click', function(){
        // 	ofrListPop();
        // });

        $("#contsTypeCd").change(function () {
            setPersonalProperty($('#contsTypeCd').val());
        });

        //테스트 발송
        $('#sendTestBtn').on('click', function () {
            previewChk = true;

            //URL 포함인지 확인
            if (checkURLYn() == false) {
                alert(surveyString)
                return;
            }

            // 저장
            var resultFlag = actionContent();

            if (resultFlag == false) return;

            if (conid != '') {
                ctitle = title.value;
                chtmlContentsArea = htmlContentsArea.value;
                fileName = fileNameText.text;
                sendTestPop();
            } else {
                alert('<spring:message code="M00448"/>')
            }
        });

        $("#saveBtn").on('click', function () {


            //URL 포함인지 확인
            if (checkURLYn() == false) {
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

        $("#title").on('click', function () {
            focusCHeck = "title";
        });

        //개인화 속성 클릭시
        $("#persnal").on('change', function () {
            if (checkPersonalType() === false) {
                alert('개인화 속성은 5가지를 넘길 수 없습니다.')
                $("#persnal option:eq(0)").attr("selected", "selected");
                return;
            }
            if ($.fn.ifvmIsEmpty(focusCHeck)) {
                insertAtCursor("title", "{{" + $("#persnal option:selected").text() + "}}");
            } else if (focusCHeck == 'htmlContentsArea_Iframe') {
                var rteObj = $("#htmlContentsArea").data("ejRTE");
                rteObj.executeCommand("inserthtml", "{{" + $("#persnal option:selected").text() + "}}");
            } else {
                insertAtCursor("title", "{{" + $("#persnal option:selected").text() + "}}");
            }
            $("#persnal option:eq(0)").attr('selected', 'selected');
        });

        $('#MKTLimitListButton').on('click', function () {
            $("#mmsFormNewPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="MKTLimitListPop"/>',
                contentType: "ajax",
                title: '<spring:message code="M00512"/>',
                width: 1150,
                close: 'mmsFormNewPopClose'
            });
            mmsFormNewPop = $("#mmsFormNewPopDialog").data("ifvsfPopup");
        });

        $('#contentNewBtn').on('click', function () {
            //팝업창에서 이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
            $("#mmsFormNewPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="MKTAddImagePop"/>?type=email',
                contentType: "ajax",
                title: '<spring:message code="M00797"/>',
                width: 870,
                close: 'mmsFormNewPopClose'
            });
            mmsFormNewPop = $("#mmsFormNewPopDialog").data("ifvsfPopup");
        });

        //파일명 클릭시
        $('#fileNameText').on('click', function () {
            emailFormFileDownload();
        });

        //파일 추가 클릭시
        $('#fileAddBtn').on('click', function () {
            searchFile();
        });

        $("#txtMsgObject").change(function () {
            setTxtMsg(); //메세지 유형 설정
        });

        focusCHeck = 'title';

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
        var checkText = $("#htmlContentsArea").val()
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
        var chkText = $("#htmlContentsArea").val() + $("#title").val();

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

</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>


</script>

<script id="emailTypetemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>


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

<style type="text/css">
    #hideFile {
        display: none;
    }

    .hideFile {
        display: none;
    }

    #contentsDesignCon {
        height: 510px;
    }
</style>

<div class="page-title">
    <h1>
        <spring:message code="M00372"/> &gt; <spring:message code="M00274"/>
    </h1>
</div>

<div id="selectForm">
    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span id="chnlTitleArea"></span> <span><spring:message code="M02494"/></span>
            </div>
            <div class="col-xs-5 searchbtn_r">

                <%-- 저장 --%>
                <button class="btn btn-sm" id='saveBtn' objCode="emailFormSave_OBJ">
                    <i class="glyphicon glyphicon-check"></i>
                    <spring:message code="M00280"/>
                </button>

                <!-- 이미지추가 -->
                <button class="btn btn-sm btn_gray" id="mmsImage" objCode="emailFormAddImage_OBJ">
                    <spring:message code="M00807"/>
                </button>


                <%-- 제한내용 --%>
                <%--                 <button class="btn btn-sm btn_gray" id="MKTLimitListButton">
                                    <spring:message code="M00512"/>
                                </button> --%>

                <%-- 이미지 조회 및 추가 --%>
                <%--
                <button class="btn btn-sm btn_gray" id="contentNewBtn">
                    <spring:message code="M00390"/>
                </button>
                 --%>

                <%-- 테스트 발송 --%>
                <button class="btn btn-sm btn_gray" id="sendTestBtn" objCode="emailFormTest_OBJ">
                    <spring:message code="M00391"/>
                </button>

                <!-- 푸터 복사 -->
                <%--				<button class="btn btn-sm btn_gray" id="copybtn" onclick="copyToClipboard();" title="수신거부 HTML 복사" objCode="emailFormCopy_OBJ">--%>
                <%--                  수신거부 HTML 복사--%>
                <%--                </button>--%>

                <button class="btn btn-sm btn_gray" id="btnList" objCode="emailFormList_OBJ">
                    <spring:message code="C00166"/>
                </button>
            </div>
        </div>
        <div class="well form-horizontal well_sum">
            <div class="row">
                <div class="col-xs-6">

                    <%-- 컨텐츠명 --%>
                    <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
                    <div class="col-xs-8 control_content">
                        <ifvm:input type="text" required="true" id="contentsName" maxLength="30"/>
                    </div>
                </div>
                <%-- 개인화 속성 --%>
                <div class="col-xs-6">
                    <label class="col-xs-2 control-label"><spring:message code="M00398"/></label>
                    <div class="col-xs-8 control_content">
                        <ifvm:input type="select" id="persnal"/>
                    </div>
                    <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd"/>
                </div>
                <%-- 컨텐츠 이메일 유형 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M01383"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="emailType"/>
                </div> --%>
            </div>
            <div class="col-xs-6">
                <%-- 제목 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message
                        code="M00377"/></label>
                <div class="col-xs-8 control_content">
                    <ifvm:input type="text" required="true" id="title" maxLength="50"/>
                </div>
            </div>
            <div class="col-xs-6">
                <%--설문 --%>
                <div class="row qt_border" id="surveyDiv">
                    <ifvm:inputNew type="search" clearArgs="'surveyNm,ridSurvey'" id="surveyNm" hidId="ridSurvey"
                                   hidDto="ridSurvey" btnFunc="surveyListPop" dto="surveyNm" names="surveyNm" label="설문"
                                   labelClass="2" conClass="8"/>
                </div>
            </div>
            <div class="row" id="txtMsgObjectDiv">
                <div class="col-xs-6">
                    <%-- 메세지유형 --%>
                    <label class="col-xs-2 control-label"><spring:message code="M00388"/></label>
                    <div class="col-xs-8 control_content">
                        <ifvm:input type="select" id="txtMsgObject"/>
                    </div>
                </div>
                <div class="col-xs-1">
                    <%--							<label class="col-xs-12 control-label"><spring:message code="M03029"/></label>--%>
                </div>
                <div class="col-xs-4">

                    <%--						    <textarea class = 'descript' id ='howTocopyTextArea' maxlength="5000" rows="3" readonly = true>--%>
                    <%--※이메일수신거부 링크 만드는 방법--%>
                    <%--수신거부 HTML 복사 버튼을 클릭하여 아래 HTML 에디터의 'View Html'을 클릭하고 붙여넣기 한 후 Update 버튼을 클릭합니다.--%>
                    <%--</textarea>--%>
                    <%--<textarea class = 'descript' id ='copyTextArea' maxlength="5000" rows="5" readonly = true style="display: none;">--%>
                    <%--<tr>--%>
                    <%--    <td width="20" bgcolor="#f7f7f7"></td>--%>
                    <%--    <td>--%>
                    <%--        <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#f7f7f7" style="padding-top: 40px; padding-bottom: 40px;">--%>
                    <%--            <tr>--%>
                    <%--                <td width="20"></td>--%>
                    <%--                <td style="color: #888888; font-size: 12px; line-height: 1.6; word-break: keep-all;">--%>
                    <%--                    - 본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 시행규칙에 의거 {{이메일수신동의일자}} 기준으로 회원님의 이메일 수신동의여부를 확인한 결과 수신동의를 하셨기에 발송되는 메일입니다.<br />--%>
                    <%--                    - 이메일 수신을 더 이상 원하지 않으실 경우, <a href="https://lnlapp.locknlockmall.com/email/spam?emailEnc={{암호화이메일}}&mbrNo={{회원번호}}" style="color: #888888;">이메일 수신거부</a>를 클릭하여 수신여부를 변경해 주시기 바랍니다. 개인정보변경 시 시스템 적용까지 2~3일의 시간이 소요될 수 있으니 양해 부탁드립니다.<br />--%>
                    <%--                    - If you don’t want to receive this e-mail anymore, <a href="https://lnlapp.locknlockmall.com/email/spam?emailEnc={{암호화이메일}}&mbrNo={{회원번호}}" style="color: #888888;">Click here.</a><br />--%>
                    <%--                    - 비회원 또는 이메일 수신거부 회원이심에도 불구하고 메일을 받으신다면, 고객센터 080-329-3000으로 연락하여 주시기 바랍니다.<br />--%>
                    <%--                    - 본 메일 내 상품의 가격 및 정보는 발송일 기준이므로 고객님의 이메일 오픈 시점에 따라 변경될 수 있습니다.<br />--%>
                    <%--                    - 본 메일은 발신전용 메일로 회신이 불가하며, 문의사항이 있으실 경우 <a href="https://lnlapp.locknlockmall.com/service/cs" target="_blank" style="color: #888888;">고객센터</a>로 문의하여 주시기 바랍니다.<br />--%>
                    <%--                </td>--%>
                    <%--                <td width="20"></td>--%>
                    <%--            </tr>--%>
                    <%--        </table>--%>
                    <%--    </td>--%>
                    <%--    <td width="20" bgcolor="#f7f7f7"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--    <td width="20" bgcolor="#222222"></td>--%>
                    <%--    <td>--%>
                    <%--        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#222222" style="height: 217px; padding-top: 20px;">--%>
                    <%--            <tr>--%>
                    <%--                <td width="20"></td>--%>
                    <%--                <td style="font-size: 12px; line-height: 1.6; color: #dddddd; word-break: keep-all;">--%>
                    <%--                    (주)락앤락 &nbsp;|&nbsp;  06655 서울특별시 서초구 서초대로38길 12, 10층 (서초동, 마제스타시티타워2)  &nbsp;|&nbsp;  대표 : 김성훈<br />--%>
                    <%--                    사업자 등록번호 : 214-85-34765   &nbsp;|&nbsp;  통신판매업 신고번호 : 제 2012-서울서초-1008호   &nbsp;|&nbsp;  TEL: 080-329-3000   <br />--%>
                    <%--                    FAX: 0505-500-9595  &nbsp;|&nbsp;  개인정보관리자 : 주미영  &nbsp;|&nbsp;  E-mail: <a href="mailto:webmaster@locknlock.com" style="text-decoration: none; color: #dddddd;">webmaster@locknlock.com</a>  &nbsp;|&nbsp;  <a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=2148534765" onclick="window.open(this.href,'_blank', 'width=800 height=600'); return false;" style="color: #dddddd; text-decoration: underline;">사업자 등록정보</a><br />--%>
                    <%--                    락앤락몰 상품이미지를 포함한 모든 컨텐츠는 저작권법 제 98조에 의거하여 보호를 받고 있습니다.<br />--%>
                    <%--                    &copy;Copyright (주)락앤락 All Right Reserved<br />--%>
                    <%--                </td>--%>
                    <%--                <td width="20"></td>--%>
                    <%--            </tr>--%>
                    <%--            <tr>--%>
                    <%--                <td width="20"></td>--%>
                    <%--                <td>--%>
                    <%--                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-bottom: 20px;">--%>
                    <%--                        <tr>--%>
                    <%--                            <td align="center">--%>
                    <%--                                <a href="https://lnlapp.locknlockmall.com/mypage/myqna_catalog" style="text-decoration: none;">--%>
                    <%--                                    <div style="width: 100%; height: auto; padding: 12px 4px 12px 4px; border: 1px solid #ffffff; background-color: #222222; font-size: 14px; color: #ffffff; word-break: keep-all;">고객센터 문의 전 확인하기</div>--%>
                    <%--                                </a>--%>
                    <%--                            </td>--%>
                    <%--                            <td style="padding-left: 19px;">--%>
                    <%--                                <span style="color: #ffffff;"></span>--%>
                    <%--                                <a href="https://lnlapp.locknlockmall.com/service/cs" target="_blank" style="text-decoration: none; color: #ffffff; font-weight: 700; font-size: 20px; word-break: keep-all;"><span>고객센터 </span><span style="white-space: nowrap;">080-329-3000</span></a><br />--%>
                    <%--                                <span style="color: #dddddd; font-size: 12px; word-break: keep-all;">상담시간  &nbsp;|&nbsp; 평일 09 : 00 ~ 18 : 00  점심시간 12 : 00 ~ 13 : 00  </span>--%>
                    <%--                            </td>--%>
                    <%--                        </tr>--%>
                    <%--                    </table>--%>
                    <%--                </td>--%>
                    <%--                <td width="20"></td>--%>
                    <%--            </tr>--%>
                    <%--        </table>--%>
                    <%--    </td>--%>
                    <%--    <td width="20" bgcolor="#222222"></td>--%>
                    <%--</tr>--%>
                    <%--</textarea>--%>


                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="row qt_border">
                    <%-- 개인화 속성 --%>
                    <%-- <label class="col-xs-2 control-label"><spring:message code="M00398"/></label>
                    <div class="col-xs-4 control_content">
                        <ifvm:input type="select" id="persnal"/>
                    </div> --%>
                </div>
                <div class="row qt_border">
                    <!-- editor -->
                    <textarea id="htmlContentsArea"></textarea>
                    <!-- editor end -->
                </div>
                <div class="file_box row" style="display: none;">
                    <span class="file_tit"><spring:message code="M00420"/></span>
                    <ifvm:input type="file" id="hideFile"/> <!-- 파일 경로  -->
                    <p class="file_link"><span class="file_btn" id="fileNameText"></span></p>
                    <%-- <ifvm:input type="file" id="hideFile" /> <!-- 파일 경로  --> --%>
                    <div class="file_btn" id="fileAddBtn">
                        <img alt="" src="<ifvm:image name='btn_plus'/>">
                        <spring:message code="M00421"/>
                    </div>
                    <div class="hideFile">
                        <ifvm:input type="file" id="fileAdd"/>
                    </div>
                    <div class="file_btn delete" id="fileRemoveBtn">
                        <img alt="" src="<ifvm:image name='btn_delete'/>">
                        <spring:message code="M00275"/>
                    </div>
                </div>
            </div>
            <!--
            <div class="grid_fix_width">
                <div id="personalPropertyGrid"></div>
            </div>
             -->
        </div>
    </div>
</div>

<div id="mmsFormNewPopDialog" class="popup_container"></div>
<div id="surveyListPopDialog" class="popup_container"></div>
