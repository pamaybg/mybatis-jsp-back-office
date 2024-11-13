<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    #kakaoFormArea .w100 {
        width: 100%
    }

    .e-grid .e-gridheader .e-icon {
        display: none
    }

    .descript {
        width: 50%;
        margin-left: 13.5%;
        overflow: hidden;
    }
</style>
<script>

    var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';

    var conid = '<%= cleanXss(request.getParameter("id")) %>';
    conid = conid === 'null' ? null : conid;

    var gridDataSeq = null;
    var countCheck = 1;
    var focusCHeck;

    var contentsNameData = null;
    var titleNameData = null;
    var mmsTextAreaOriData = null;
    var mmsTextAreaRepData = null;
    var senderKeyData = null;

    var btnListData = null;
    var toCallbackNo = null;

    var typeCode = '<%= cleanXss(request.getParameter("type")) %>';
    var personalType;
    var surveyString = '';

    var empId;
    var empType;
    var phoneNo;


    function kakaoInit() {
        $('#ofrNmDiv').show();
        $('#ranDomOfrNmDiv').hide();
        $('#ofrPointDiv').hide();
        $('#surveyDiv').hide();

        if (conid != null) {
            var mktOfrType = '';
            var ofrNm = '';
            var ridOfr = '';
            var surveyNm = '';
            var ridSurvey = '';

            $.ifvSyncPostJSON('<ifvm:action name="getDescContsKakao"/>', {
                    id: conid
                },
                function (result) {
                    $('#contentsName').val(result.contentsName)        //컨텐츠명
                    $('#titleName').val(result.title)                                    //제목
                    $('#mmsTextAreaOri').val(result.contents)                //전송 메세지
                    $('#mmsTextAreaRep').val(result.attrib01)                //대체 메세지
                    $('#senderKey').val(result.attrib05)                         //발신 프로필 키(코드값)
                    $('#toCallbackNo').val(result.toCallbackNo)                        //수신자 번호

                    $.fn.ifvmSetSelectOptionCommCode("transTypeCd", "TRAN_REPLACE_TYPE", result.attrib04, null, true);  //전환 전송 타입
                    $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", result.contsTypeCd, null, true);
                    contentsNameData = result.contentsName;
                    titleNameData = result.title;
                    mmsTextAreaOriData = result.contents;
                    mmsTextAreaRepData = result.attrib01;
                    senderKeyData = result.attrib05;

                    mktOfrType = result.comOfrType;
                    ofrNm = result.ofrNm;
                    ridOfr = result.ridOfr;
                    surveyNm = result.surveyNm;
                    ridSurvey = result.ridSurv;
                    toCallbackNo = result.toCallbackNo;


                });

            $.ifvSyncPostJSON('<ifvm:action name="getGridContsKakao"/>', {
                    id: conid
                },
                function (result) {
                    btnListData = result.rows;
                    delete btnListData.counts;
                });
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

        }
        $('#toCallbackNo').attr('disabled', true);

        if(empType != 'H'){
            $('#ofrArea').hide();
            $('#ofrSubArea').hide();
            $('#desArea').hide();
        }

        //개인화 속성 값 조회
        setPersonalProperty($('#contsTypeCd').val());
    }

    function kakaoBtnGridList() {

        var ejGridOption = {
            serializeGridData: function (data) {
                data.id = conid;
                return data;
            },
//      recordDoubleClick : function(args) {
//          var data = args.data;
//          rid = data.rid;
//      },
            loadComplete: function (obj) {
                gridDataSeq = kakaoBtnGrid.opt.gridControl.model.dataSource;
                for (i = 1; i <= gridDataSeq.length; i++) {
                    countCheck++;
                }
            },
//         rowSelected: function (args) {
//             console.log(args);
//         },
            editSettings: {
                allowEditing: false
                , allowAdding: true
                , allowDeleting: true
            }
            , sortSettings: {
                sortedColumns: [
                    {field: "seq", direction: "ascending"}
                    , {field: "type"}
                    , {field: "btnName"}
                    , {field: "pcUrl"}
                    , {field: "mobileUrl"}

                ]
            } //ascending descending
            , allowPaging: true
            , allowSorting: false
            , allowMultiSorting: false
            , loadonce: true
            , allowSelection: true
            , dataSource: []
            , dataUrl: '<ifvm:action name="getGridContsKakao"/>'
            , columns: [
                {
                    field: 'seq', headerText: '순서', headerTextAlign: 'center', textAlign: 'center', width: 40
                }
                , {
                    field: 'type', headerText: '구분', headerTextAlign: 'center', textAlign: 'center', width: 60
                }
                , {
                    field: 'btnName', headerText: '버튼명', headerTextAlign: 'center', textAlign: 'center', width: 150
                }
                , {
                    field: 'pcUrl', headerText: 'PC URL', headerTextAlign: 'center', textAlign: 'center', width: 200
                }
                , {
                    field: 'mobileUrl',
                    headerText: 'MOBILE URL',
                    headerTextAlign: 'center',
                    textAlign: 'center',
                    width: 200
                }
            ],
            requestGridData: {
                sidx: '1',
                sord: 'asc'
            },
            radio: false,
            emptyRows: true,
            isHorizontalScroll: true,
            tempId: 'ifvGridSimplePageTemplete'
        };
        kakaoBtnGrid = $("#kakaoBtnGrid").ifvsfGrid({
            ejGridOption: ejGridOption
        });
    }

    function saveFun(saveType) {
        if (selectForm.confirm() && phoneForm.confirm()) {
            var buttonDataList = kakaoBtnGrid.opt.gridControl.model.dataSource;
            var ValueContents = $('#mmsTextAreaOri').val()
            ValueContents = ValueContents.replace(/\r/g, "");
            var ValueAttrib01 = $('#mmsTextAreaRep').val()
            ValueAttrib01 = ValueAttrib01.replace(/\r/g, "");

            var ofrRid;
            var surveyRid;
            var mktOfrTypeVal = $("#mktOfrType").val();
            var mktOfrTypeSaveValue = null;

            //URL 포함인지 확인
            if ($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
                alert(surveyString)
                return;
            }

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

            if (typeof closeContentsDesignPop == 'function') {
                if(conid != null && conid != ''){
                    if(loadContentCheck) {
                        conid = null;
                    }
                } else {
                    conid = null;
                }
            }

            //insert
            if (conid == null) {
                $.ifvSyncPostJSON('<ifvm:action name="saveContsKakao"/>', {
                    contentsName: $('#contentsName').val()        //컨텐츠명
                    , title: $('#titleName').val()                //제목
                    , contents: ValueContents                       //전송 메세지
                    , attrib01: ValueAttrib01                         //대체 메세지
                    , contsTypeCd: $('#contsTypeCd').val()           //컨텐츠 타입
                    , attrib04: $('#transTypeCd').val()            //전환 전송 타입
                    , attrib05: $('#senderKey').val()               //발신 프로필 키
                    , kakaoConts: buttonDataList                      //버튼 데이터
                    , ridOfr: ofrRid
                    , comOfrType: mktOfrTypeSaveValue
                    , ridSurv: surveyRid
                    , kakaoTypeCd: 'KAKAOFR'
                    , toCallbackNo: $('#toCallbackNo').val().replace(/-/g, '')
                }, function (result) {
                    conid = result.message;
                    if (saveType != 'TEST') {
                        alert("<spring:message code='M00295'/>");
                    }
                });
                if (typeof closeContentsDesignPop == 'function') {
                    if (saveType != 'TEST') {
                        closeContentsDesignPop();
                    }
                } else {
                    qtjs.href('/marketing/content/frdKakaoFormNew' + '?id=' + conid);
                }
                // 	update
            } else {
                $.ifvSyncPostJSON('<ifvm:action name="changeSaveContsKakao"/>', {
                    id: conid       //아이디
                    , contentsName: $('#contentsName').val()        //컨텐츠명
                    , title: $('#titleName').val()                //제목
                    , contents: ValueContents                       //전송 메세지
                    , attrib01: ValueAttrib01                         //대체 메세지
                    , contsTypeCd: $('#contsTypeCd').val()           //컨텐츠 타입
                    , attrib04: $('#transTypeCd').val()            //전환 전송 타입
                    , attrib05: $('#senderKey').val()               //발신 프로필 키
                    , kakaoConts: buttonDataList                      //버튼 데이터
                    , ridOfr: ofrRid
                    , comOfrType: mktOfrTypeSaveValue
                    , ridSurv: surveyRid
                    , kakaoTypeCd: 'KAKAOFR'
                    , toCallbackNo: $('#toCallbackNo').val().replace(/-/g, '')
                }, function (result) {
                    conid = result.message;
                    if (saveType != 'TEST') {
                        alert("<spring:message code='M00295'/>");
                    }
                });

                if (typeof closeContentsDesignPop == 'function') {
                    if (saveType != 'TEST') {
                        closeContentsDesignPop();
                    }
                }
            }
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

    function testBtnPopup() {

        saveFun('TEST')
        if (conid != null) {
            $("#testbtnPop").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="frdKakaoFormNewTestBtnPop"/>',
                contentType: "ajax",
                title: '테스트 발송',
                width: 1024,
                close: 'testBtnClosePop'
            });

        } else {
            alert('<spring:message code="M00448"/>')
        }

    }

    function testBtnClosePop() {
        testbtnPop._destroy();
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
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferPopCount"/>', {campaignId: campaign.id, chnnelTypeCode: 'KAKAOFR',contentsId: conid},
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
                width: 900,
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
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferCount"/>', {campaignId: campaign.id, chnnelTypeCode: 'KAKAOFR',contentsId: conid},
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
                width: 900,
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
                        $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferCount"/>', {campaignId: campaign.id, chnnelTypeCode: 'KAKAOFR',contentsId: conid},
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

    function contentKaKaoPopupInit() {

        initKaKaoFormNew();
    }

    function initKaKaoFormNew() {

        if (typeof closeContentsDesignPop == 'function') {
            $("#btnList").hide()
        }

        kakaoInit();
        kakaoBtnGridList();
        setPersonalProperty($('#contsTypeCd').val());

    }

    function checkFileType(id) {
        var realFileType = $("#" + id)[0].files[0].name.split('.')[1].toLowerCase()
        var fType = ['jpg', 'jfif', 'jpeg', 'gif', 'png'];
        if (fType.includes(realFileType)) {
            return true;
        } else {
            alert("<spring:message code='M00703'/>")
            $("#" + id).removeAttr("value");
            return false;
        }
    }

    function getKakaoImgFile() {
        var _callback = function (result) {
        }

        var _error = function (result) {
            if (result.messages) alert(result.messages)
            else alert('업로드 실패')
        }

        $.ifvProgressControl(true);
        var formData = new FormData();
        formData.append("file", $("#kakaoImg")[0].files[0]);

        // $.fn.ifvmFileUpload("kakaoImg");

        $.ifvProgressControl(false);
    }

    function getPersonalType() {
        $.ifvSyncPostJSON('<ifvm:action name="getPersonalType"/>', {}, function (result) {
            for (i = 0; i < result.length; i++) {
                personalType.push(result[i].markName);
            }
        });
    }

    function contentAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            empType = result.rows[0].empType;
        });

        $.ifvSyncPostJSON('<ifvm:action name="selectPhoneNo"/>', {
            empId: empId
        }, function (result) {
            phoneNo = result.phoneNo;
        });
    }

    $(document).ready(function () {

        $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("btnType", "BTN_TYPE_CD", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("numberType", "KAKAO_NUMBER_TYPE", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("transTypeCd", "TRAN_REPLACE_TYPE", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", null, null, true);
        $.fn.ifvmSetSelectOptionCommCode("senderKey", "BRAND_CD", null, null, true);
        $('#contsTypeCd').hide();

        //권한 불러오기
        contentAuth();

        initKaKaoFormNew();

        //개인화 속성 목록
        getPersonalType();

        // $('#contsTypeCd option:first').remove();
        $("#persnal option:eq(0)").attr('selected', 'selected');

        $("#titleName").on('click', function () {
            focusCHeck = "titleName";
        });
        $("#mmsTextAreaOri").on('click', function () {
            focusCHeck = "mmsTextAreaOri";
        });
        $("#mmsTextAreaRep").on('click', function () {
            focusCHeck = "mmsTextAreaRep";
        });

        $("#testBtn").on('click', function () {
            testBtnPopup();
        });

        $("#btnList").click(function () {
            qtjs.href('<ifvm:url name="contentListNew"/>');
        });


        //개인화 속성 클릭시
        $("#persnal").on('change', function () {
            if (checkPersonalType() === false) {
                alert('개인화 속성은 5가지를 넘길 수 없습니다.')
                $("#persnal option:eq(0)").attr("selected", "selected");
                return;
            }
            if ($.fn.ifvmIsEmpty(focusCHeck)) {
//            insertAtCursor("titleName",$("#persnal option:selected").text());
            } else {
                if (focusCHeck == "titleName") {
                    insertAtCursor("titleName", "{{" + $("#persnal option:selected").text() + "}}");
                } else if (focusCHeck == "mmsTextAreaOri") {
                    insertAtCursor("mmsTextAreaOri", "{{" + $("#persnal option:selected").text() + "}}");
                } else if (focusCHeck == "mmsTextAreaRep") {
                    insertAtCursor("mmsTextAreaRep", "{{" + $("#persnal option:selected").text() + "}}");
                }
            }
            $("#persnal option:eq(0)").attr('selected', 'selected');
        });

        $("#contsTypeCd").change(function () {
            setPersonalProperty($('#contsTypeCd').val());
        });

        $('#saveBtn').on('click', function () {
            saveFun();
        });

        //  kakaoBtnGrid.opt.gridControl.model.dataSource[0]
        // 참고 : contentSearchResult.opt.gridControl.addRecord([{'contentsChannel':'asdf','contentsName':'asd'}])
        $('#btnAdd').on('click', function () {
            if (countCheck <= 5) {
                if ($('#btnType').val() != '' && $('#btnName').val() != '' && $('#mobileUrl').val() != '') {
                    kakaoBtnGrid.opt.gridControl.addRecord({
                        'seq': countCheck.toString(),
                        'type': $('#btnType').val(),
                        'btnName': $('#btnName').val(),
                        'pcUrl': $('#pcUrl').val(),
                        'mobileUrl': $('#mobileUrl').val(),
                        'counts': null,
                        'createBy': null,
                        'modifyBy': null,
                        'pageNum': 0,
                        'ridContsMst': null,
                        'totalCount': 1,
                        'totalPage': 0
                    })
                    kakaoBtnGrid.opt.gridControl.refreshContent()
                    countCheck++;
                    $('#btnName').val('');
                    $('#pcUrl').val('');
                    $('#mobileUrl').val('');
                } else {
                    alert("<spring:message code='M03023'/>");
                }
            } else {
                alert("<spring:message code='I02132'/>");
            }
        });
        $('#btnDel').on('click', function () {
            if (gridDataSeq.length != 0) {
                if (confirm('<spring:message code="버튼 속성을 삭제 하시겠습니까?"/>')) {
                    for (var i = 1; i < countCheck; i++) {
                        kakaoBtnGrid.opt.gridControl.deleteRecord("seq", {"seq": kakaoBtnGrid.opt.gridControl.model.dataSource[0].seq})
                    }
                    kakaoBtnGrid.opt.gridControl.refreshContent()
                    countCheck = 1;
                    $('#btnName').val('');
                    $('#pcUrl').val('');
                    $('#mobileUrl').val('');
                }
            } else {
                alert("<spring:message code='C00183'/>");
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

        selectForm = $("#selectForm").ifvValidation();
        phoneForm = $("#phoneForm").ifvValidation();

        $('#kakaoImg').hide();

        $("#kakaoImageBtn").on('click', function () {
            $("#kakaoImg").trigger("click");
        });

        $("#kakaoImg").change(function () {
            if (checkFileType("kakaoImg")) {
                if ($("#kakoImgFilePath").val() != null && $("#kakoImgFilePath").val() != '') {
                    //이미지 업로드
                    getKakaoImgFile()
                    $("#kakoImgFilePath").val($("#kakaoImg").val())
                }
            }
        }.bind(this));

        // 개인화 버튼 숨김
        $('#uploadPersnalTypeBtn').hide();

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
                }, 1300);
            }
        } catch (e) {
        }
    }

    //설문 url 체크
    function checkURLYn() {
        var checkText = $("#mmsTextAreaOri").val()
        var checkTextRep = $("#mmsTextAreaRep").val()
        var checkValue = $("#surveyNm").val()
        cText = '{{설문URL}}'

        if ((checkTextRep.search(cText) != -1 || checkText.search(cText) != -1) && checkValue == '') {
            surveyString = '설문 값을 입력해주세요.'
            return false;
        } else if($.fn.ifvmIsNotEmpty(checkValue) && (checkText.search(cText) == -1 || checkTextRep.search(cText) == -1)){
            surveyString = '설문 URL을 입력해주세요.'
            return false;
        }
    }

    function getPersonalType() {
        $.ifvSyncPostJSON('<ifvm:action name="getPersonalType"/>', {}, function (result) {
            for (i = 0; i < result.length; i++) {
                personalType.push(result.markName);
            }
        });
    }

    function checkPersonalType() {
        var chkFlag = 1;
        var chkFlagRep = 1;

        var chkText = $("#mmsTextAreaOri").val()
        var chkTextRep = $("#mmsTextAreaRep").val();

        for (i = 0; i < personalType.length; i++) {
            if (chkText.indexOf(personalType[i]) != -1) {
                if (chkText.indexOf($('#persnal').val()) == -1){
                    chkFlag++;
                }
            }

            if (chkTextRep.indexOf(personalType[i]) != -1) {
                if (chkText.indexOf($('#persnal').val()) == -1){
                    chkFlagRep++;
                }
            }
        }

        if (chkFlag > 5 || chkFlagRep > 5) {
            return false;
        }
    }

</script>
<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>





</script>
<style type="text/css">
    /*#hideFile{display:none;}*/
    /*.hideFile{display:none;}*/
    /*#contentsDesignCon{height:510px;}*/
</style>
<div class="page-title">
    <h1>
        <spring:message code="M00374"/>
        &gt; <spring:message code="M00274"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span id="chnlTitleArea"></span> <span><spring:message
                code="M02494"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

            <%-- 저장 --%>
            <button class="btn btn-sm" id='saveBtn' objCode="smsFormNewSaveBtn_OBJ">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
            <button class="btn btn-sm" id='testBtn' objCode="smsFormNewTestSendBtn_OBJ">
                <spring:message code="M00391"/>
            </button>
            <button class="btn btn-sm btn_gray" id="btnList" objCode="smsFormNewList_OBJ">
                <spring:message code="C00166"/>
            </button>

        </div>
    </div>
</div>

<div id="kakaoFormArea">
    <ifvm:input type="hidden" id="imgCnt"/>
    <ifvm:input type="hidden" id="imgBarCnt"/>
    <br>
    <div class="well form-horizontal content_textImage_con" id="phoneForm">
        <div class="phoneImage">
            <div class="sms_kinds">
                <spring:message code="M02403"/>
            </div>
            <div class="phoneWrap">
                <%--                 <ifvm:input type="text" id="smsArea" placeholder="M00394" maxLength="50" /> --%>
                <div id="sortable">
                    <spring:message code="I02123"/>
                    <div class="textareaBox">
                        <ifvm:input type="textarea" className="sms_phone_area" placeholder="I02125" id="mmsTextAreaOri"
                                    dto="mmsTextAreaOri" required="true"/>
                    </div>
                    <spring:message code="I02124"/>
                    <div class="textareaBox">
                        <ifvm:input type="textarea" className="sms_phone_area" placeholder="I02126" id="mmsTextAreaRep"
                                    dto="mmsTextAreaRep"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-8 control_content">
            <div class="input_area" id="selectForm">
                <div class="row">
                    <div class="col-xs-6">
                        <!-- 제목 -->
                        <label class="col-xs-3 control-label"><span class="asterisk">*</span>
                            <spring:message code="M02509"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" required="true" id="titleName" dto="titleName" maxLength="30"/>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <%-- 컨텐츠명 --%>
                        <label class="col-xs-3 control-label"><span class="asterisk">*</span>
                            <spring:message code="M00376"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" required="true" id="contentsName" dto="contentsName"
                                        maxLength="30"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-6">
                            <%-- SENDER KEY --%>
                            <label class="col-xs-3 control-label"><span class="asterisk">*</span>
                                <spring:message code="I02127"/></label>
                            <div class="col-xs-9 control_content">
                                <ifvm:input type="select" required="true" id="senderKey" dto="senderKey"
                                            names="senderKey"/>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <%--              <label class="col-xs-3 control-label">--%>
                            <%--                <spring:message code="이미지"/></label>--%>
                            <%--              <div class="col-xs-6 control_content">--%>
                            <%--                <ifvm:input type="text" id="kakoImgFilePath"/>--%>
                            <%--              </div>--%>
                            <%--              <button class="ifv_search_box_search_btn" id="kakaoImageBtn" >--%>
                            <%--                <spring:message code="M00203"/>--%>
                            <%--              </button>--%>
                            <%--              <ifvm:input type="file" id="kakaoImg" />--%>
                            <ifvm:inputNew type="text" required="true" id="toCallbackNo" dto="toCallbackNo"
                                           label="송신자 번호" labelClass="3" conClass="9"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <ifvm:inputNew type="select" id="persnal" names="persnal" dto="persnal" label="개인화 속성"
                                           labelClass="3" conClass="9"/>

                        </div>
                        <div class="col-xs-6">
                            <ifvm:inputNew type="select" id="transTypeCd" names="transTypeCd" dto="transTypeCd"
                                           label="전환 전송 타입" labelClass="3" conClass="9"/>

                            <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd"/>
                        </div>
                    </div>
                    <div class="row" id="ofrArea">
                        <div class="col-xs-6">
                            <%-- 오퍼유형 --%>
                            <ifvm:inputNew type="select" id="mktOfrType" names="mktOfrType" dto="mktOfrType"
                                           label="M03049" labelClass="3" conClass="9"/>
                        </div>
                    </div>
                    <div class="row" id="ofrSubArea">
                        <div class="col-xs-6">
                            <%--오퍼(쿠폰) --%>
                            <div class="row" id="ofrNmDiv">
                                <ifvm:inputNew type="search" clearArgs="'ofrNm,ridOfr'" id="ofrNm" hidId="ridOfr"
                                               hidDto="ridOfr" btnFunc="ofrListPop" dto="ofrNm" names="ofrNm"
                                               label="쿠폰" labelClass="3" conClass="9"/>
                            </div>
                            <%--포인트 --%>
                            <div class="row" id="ofrPointDiv">
                                <ifvm:inputNew type="search" clearArgs="'ofrPoint,ridPoint'" id="ofrPoint"
                                               hidId="ridPoint" hidDto="ridPoint" btnFunc="ofrPointListPop"
                                               dto="ofrPoint"
                                               names="ofrPoint" label="포인트" labelClass="3" conClass="9"/>
                            </div>
                            <%--설문 --%>
                            <div class="row" id="surveyDiv">
                                <ifvm:inputNew type="search" clearArgs="'surveyNm,ridSurvey'" id="surveyNm"
                                               hidId="ridSurvey" hidDto="ridSurvey" btnFunc="surveyListPop"
                                               dto="surveyNm"
                                               names="surveyNm" label="설문" labelClass="3" conClass="9"/>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row qt_border" id="desArea">
					<textarea class='descript' maxlength="50" rows="3" readonly=true>
1. 송신자 번호 : 18990232
2. 무료수신거부 : 0808730002
3. 문의 : 0805655600
					</textarea>
                    </div>
                    <div class="row qt_border">
                        <label class="col-xs-6 control-label" style="color: red; text-align: right"><spring:message code="※개인화 속성은 5가지를 초과할 수 없습니다."/></label>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="description_title">
                                <label class="col-xs-3">
                                    <spring:message code="M02405"/>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <%-- 유형 --%>
                            <ifvm:inputNew type="select" id="btnType" names="btnType" dto="btnType" label="유형"
                                           labelClass="4" conClass="8"/>
                        </div>
                        <div class="col-xs-9">
                            <%-- 버튼명 --%>
                            <label class="col-xs-1 control-label"><spring:message code="M02406"/></label>
                            <div class="col-xs-7 control_content">
                                <ifvm:input type="text" id="btnName"/>
                            </div>
                            <!--  버튼 추가 -->
                            <ifvm:inputNew type="button" btnType="check" text="I02131" id="btnAdd"
                                           objCode="kakaoNotiBtnAdd_OBJ"/>
                            <!--  버튼 삭제 -->
                            <ifvm:inputNew type="button" btnType="minus" text="I02133" id="btnDel"
                                           objCode="kakaoNotiBtnDel_OBJ"/>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <%-- PC_URL --%>
                        <label class="col-xs-3 control-label"><spring:message code="I02129"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" id="pcUrl"/>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <%-- MOBILE_URL --%>
                        <label class="col-xs-3 control-label"><spring:message code="I02130"/></label>
                        <div class="col-xs-9 control_content">
                            <ifvm:input type="text" id="mobileUrl"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="kakaoBtnGrid" class="grid_bd"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>

<div id="testbtnPop" class="popup_container"></div>
<div id="ofrListPopDialog" class="popup_container"></div>
<div id="ofrPointListPopDialog" class="popup_container"></div>
<div id="surveyListPopDialog" class="popup_container"></div>