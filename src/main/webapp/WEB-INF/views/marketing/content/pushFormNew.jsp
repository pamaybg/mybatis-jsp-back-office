<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>

<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<style type="text/css">
.contentsArea2 { height: 245px; }
.guide_area .control_content input[type="text"] { width: 495px }
.push_phone_area { margin-bottom: 5px; }
.user_param_row { margin-left: 20px; padding: 10px 0; }
.user_param_row select { width: 25%; }
.user_param_row input { width: 70%; }
.descript {
    margin-left: 135px;
    width: 50%;
    overflow:hidden;
    margin-left : 17.5%;
}
.row {
    margin-top: 20px;
    margin-bottom: 20px;
}
</style>

<script>

var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';
var imgId;
var preViewPop;
var conid    = '<%= cleanXss(request.getParameter("id")) == null || "null".equals(cleanXss(request.getParameter("id"))) ? "" : cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';
var contsimagetype = "USERCONTS_PUSH";
var typeCode = '<%= cleanXss(request.getParameter("type")) %>';

var push = {
		precontentsTitle	:	""  ,
		precontentsSubTitle	:	""  ,
		precontents			:	""  ,
		typeCodeId			: 	""  ,
		limitByte			:	""  ,
		totallength			:	""  ,
		pushTypeCode		:	""  ,
		imgSrc				:	""  ,
		photoUrl			:	""  ,
		preAppType			:	""  ,	// App 유형
		preLinkUrl			:	""  ,	// 링크 URL
		exeContype			: null  ,	//실행 채널 정보
		LimitCHk			: true  ,
		mergeCheck			: true  ,	//이미지, 바코드에 변경이 일어날시 false를 시켜 머지 이미지를 생성한다.
		previewChk			: false ,
		detail				: false ,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
		rteeObj				: null	,
		focusCHeck			: null  ,
		imgPreviewPath		:   ""  ,
}

var personalType = [];
var empId;
var empType;
var phoneNo;

$(function() {
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
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
            id : conid
        }, function(result) {

            $("#contentsName").val(result.contentsName);                // 콘텐츠 명
            push.exeContype = result.contentsType;                      // 실행채널유형
            chnlCode = result.contentsType;                             // 실행채널유형
            $("#brazeCamApiKey").val(result.brazeCamApiKey);                // 캠페인 키
            $("#contentsFlag").val(result.contentsFlag);                //
            $("#contentsTitle").val(result.title);                      // 콘텐츠제목
            $("#textByteSize").val(result.textByteSize);                // 콘텐츠 용량
            $("#contsPushType").val(result.contsPushTypeCode);          // PUSH유형
            $("#txtMsgObject").val(result.txtMsgObject);                // 메세지 유형
            $("#contsPushSubTypeVal").val(result.contsPushSubTypeVal);  // 링크URL
            $("#contsPushAppType").val(result.contsPushAppTypeCode);    // APP 유형
            $("#contentsSubTitle").val(result.contsSubTitle);           // 콘텐츠 서브 제목
            $("#chnlGuide").val(result.chnlGuide);						// 채널 가이드
            $("#ofrNm").val(result.ofrNm);                                //오퍼명
            $("#ridOfr").val(result.ridOfr);
            imgId = result.imgId;                                       // 이미지 ID
            $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", result.contsTypeCd, null, true);

            mktOfrType	= result.comOfrType;
            ofrNm 		= result.ofrNm;
            ridOfr 		= result.ridOfr;
            surveyNm    = result.surveyNm;
            ridSurvey   = result.ridSurv;

            var path;

            if (result.imagepath != null && result.imagename != null) {
                /* var path = '<ifvm:url name="imageView"/>' + result.imagepath; */
                /* 2018.11.08 hy.jun AWS S3 반영 */
                path = '<%= BeansUtil.getApplicationProperty("icignal.context.imageServerUrl")%>' + result.imagepath+"/" + result.imagename;
                push.imgPreviewPath = path;
                $('#mmsImage').attr('src',path);
                $('.image_close').show();
                $("#imgCnt").val(1);
            } else {
            	push.imgPreviewPath = "";
            }
            
            push.photoUrl = path;

            if (result.imagepath != null && result.imagepath != null) {
                push.mergeCheck = false
            }
            
            $("#textByteSize").val(result.textByteSize);
            $("#imgSize").val(result.imgSize);
            $("#imgCnt").val(result.imgCnt);

            //push 유형 설정
            changeContsPushType();

            // 콘텐츠내용
            $("#contents").val(result.contents);

            //push유형이 HTML 일 경우만 html로 contents 구성
            if (result.contsPushTypeCode == "HTML" && result.html != "") {
                setTimeout(function() {
                    push.rteeObj.setHtml(result.html);
                    setContentsHTML();
                }, 600);
            }

            //사용자 정의 데이터 설정
            setUserParameter(result.contsPushParam);

        });
        push.detail = true;
        $('#contsTypeCd').attr('disabled', true);
        $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", mktOfrType, null, true);
        var mktOfrTypeVal = $("#mktOfrType").val();
        if(mktOfrTypeVal != null && mktOfrTypeVal != '') {
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
    }
    else {
        $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", typeCode, null, true);
        $('#contsTypeCd').attr('disabled', true);
        //메세지 유형 설정
        setTxtMsg();
    }
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

//사용자 정의 데이터 설정
function setUserParameter(param) {
    var obj = $.parseJSON(param);
    var idx = 0;
    $.each(obj, function(k, v) {
        //사용자 정의 데이터 설정
        var paramObj = $("#userParameterArea .user_param_row")[idx];
        $(paramObj).find('#paramId').val(k);
        $(paramObj).find('#paramVal').val(v);
        
        var optObj = $(paramObj).find('#paramId option');
        
    	$.each(optObj, function(index, obj) {
			var url = $(obj).attr('attrib01');
			
			if (v.indexOf(url) >= 0) {
				$(obj).attr('selected', 'selected');
			}
        });
        
        idx++;
    });
}

//사용자 정의 데이터 추출
function getUserParameter() {
    var map = {}

    $.each($("#userParameterArea .user_param_row"), function(index, obj) {
        var paramId = $(obj).find('#paramId').val();
        var paramVal = $(obj).find('#paramVal').val();

        if (paramId != "" && paramVal != "") {
            map[paramId] = paramVal;
        }
    });

    return JSON.stringify(map);
}

//저장 버튼클릭 시 동작
function actionContent() {
    var resultFlag = false;

    pushValidation = $(".content_textImage_con").ifvValidation();
    isValid = pushValidation.confirm() && checkUrl($('#contsPushSubTypeVal'));

    var ofrRid;
    var surveyRid;
    var mktOfrTypeVal = $("#mktOfrType").val();
    var mktOfrTypeSaveValue = null;

    //쿠폰 COM_OFR_TYPE
    if (mktOfrTypeVal == 'C') {
        if($('#ridOfr').val() != null && $('#ridOfr').val() != ''){
            mktOfrTypeSaveValue = 'C';
            ofrRid = $('#ridOfr').val();
        } else {
            mktOfrTypeSaveValue = null;
            ofrRid = null;
            surveyRid = null;
        }
        //포인트
    } else if (mktOfrTypeVal == 'P') {
        if($('#ridPoint').val() != null && $('#ridPoint').val() != ''){
            mktOfrTypeSaveValue = 'P';
            ofrRid = $('#ridPoint').val();
        } else {
            mktOfrTypeSaveValue = null;
            ofrRid = null;
            surveyRid = null;
        }
        //설문
    } else if (mktOfrTypeVal == 'S') {
        if($('#ridSurvey').val() != null && $('#ridSurvey').val() != ''){
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
        checkByte('input');
        if (push.LimitCHk) {
            if (Number(push.totallength) < Number(push.limitByte)) {
                push.LimitCHk = true;
            }
        }
        if (push.LimitCHk == false) {
            alert("<spring:message code='M01833'/>");
        }

        if ($("#mmsImage").attr('src').substring(1).length >0) {
            var idx = $("#mmsImage").attr('src').indexOf("=");
            push.imgSrc = $("#mmsImage").attr('src').substring(idx+1);
        } else {
            push.imgSrc = '';
        }

        if ($("#imgCnt").val() != 1) {
            imgId = null;
        }
        if (push.LimitCHk) {
            if (isValid) {
                //상세 페이지일 시 수정 작업 동작
                var pHtml = "";
                var pContents = $("#contents").val();

                //push유형이 HTML 일 경우만 html로 contents 구성
                if ($("#contsPushType").val() == "HTML" && push.rteeObj != null) {
                    pHtml = push.rteeObj.getDocument().documentElement.outerHTML;
                    pContents = "";
                }

                if (typeof closeContentsDesignPop == 'function') {
                    if(conid != null && conid != ''){
                        if(loadContentCheck) {
                            push.detail = false;
                        } else {
                            push.detail = true;
                        }
                    } else {
                        push.detail = false;
                    }
                }

                if (push.detail) {
                    //콘텐츠 수정
                    $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                          contentsName     : $("#contentsName").val()
                        , brazeCamApiKey   : $("#brazeCamApiKey").val()
                        , contentsType     : chnlCode
                        , contentsFlag     : $("#contentsFlag").val()
                        , title            : $("#contentsTitle").val()
                        , contents         : pContents
                        , html             : pHtml
                        , textByteSize     : $("#textByteSize").val()
                        , txtMsgObject     : $("#txtMsgObject").val()
                        , contsPushParam   : getUserParameter()
                        , contsPushTypeCode    : $("#contsPushType").val()
                        , contsPushSubTypeVal  : $("#contsPushSubTypeVal").val()
                        , contsPushAppTypeCode : $("#contsPushAppType").val()
                        , contsSubTitle    : $("#contentsSubTitle").val()
                        , id               : conid
                        , imgSize          : $("#imgSize").val()
                        , imgCnt           : $("#imgCnt").val()
                        , filePath         : push.imgSrc
                        , imgId            : imgId
                        , chnlId           : push.exeContype
                        , merCheck         : push.mergeCheck
                        , ridOfr		   : ofrRid
                        , contsTypeCd : $("#contsTypeCd").val()
                        , comOfrType : mktOfrTypeSaveValue
                        , ridSurv : surveyRid

                    }, function(result) {
                        if (push.previewChk == false) {
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
                          contentsName     : $("#contentsName").val()
                        , brazeCamApiKey   : $("#brazeCamApiKey").val()
                        , contentsChannel  : $("#contentsChanne").val()
                        , contentsType     : chnlCode
                        , contentsFlag     : $("#contentsFlag").val()
                        , title            : $("#contentsTitle").val()
                        , contents         : pContents
                        , html             : pHtml
                        , textByteSize     : $("#textByteSize").val()
                        , contsPushTypeCode: $("#contsPushType").val()
                        , txtMsgObject     : $("#txtMsgObject").val()
                        , contsPushSubTypeVal : $("#contsPushSubTypeVal").val()
                        , contsPushAppTypeCode: $("#contsPushAppType").val()
                        , contsSubTitle    : $("#contentsSubTitle").val()
                        , contsPushParam   : getUserParameter()
                        , camFlag          : camFlag
                        , imgSize          : $("#imgSize").val()
                        , imgCnt           : $("#imgCnt").val()
                        , filePath         : push.imgSrc
                        , imgId            : imgId
                        , chnlId           : push.exeContype
                        , merCheck         : push.mergeCheck
                        , ridOfr		   : ofrRid
                        , contsTypeCd : $("#contsTypeCd").val()
                        , comOfrType : mktOfrTypeSaveValue
                        , ridSurv : surveyRid
                    }, function(result) {
                        if (push.previewChk == false) {
                            alert('<spring:message code="M00430"/>');
                        }
                        conid = result.message;
                        push.detail = true;

                        idCheck();

                        resultFlag = true;
                    });

                    if (openType == "") {
                        qtjs.href('/marketing/content/pushFormNew'+'?id='+conid);
                    }

                }
                push.previewChk = false;
            }
        }

        push.previewChk = false;
    }
    return resultFlag;
}

/* 팝업 닫기 */
function preViewPopClose() {
    preViewPopDialog._destroy();
}

/* 팝업 닫기 */
function mmsFormNewPopClose() {
    mmsFormNewPop._destroy();
}

//총 용량 체크 (콘텐츠 내용을 체크하여 총용량을 계산한다.)
function totalBytecheck(message) {
    var totalByte = 0;

    for (var i =0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);
        if (currentByte > 128) totalByte += 2;
        else totalByte++;
    }
    return totalByte;
}

//최대 용량 넘어갈 시 메세지 자르기
function cutMessage(message, remainByte) {

    var totalByte = 0;
    var k = 0;
    for (var i =0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);

        if (currentByte > 128) totalByte += 2;
        else totalByte++;

        if (totalByte >= remainByte)
        break;
        k++;
    }
    return k;
}

//콘텐츠 내용의 용량을 체크하여 입력문자 text byte를 화면에 뿌려준다.
function checkByte(inputType) {
    var inputMessage = $("#contentsTitle").val();
    var textareaMessage = $("#contents").val();
    var subTitleMessage = $("#contentsSubTitle").val();
    var linkUrlMessage = $("#contsPushSubTypeVal").val();

    var inputByte = Number(totalBytecheck(inputMessage));
    var textareaByte = Number(totalBytecheck(textareaMessage));
    var subTitleByte = Number(totalBytecheck(subTitleMessage));
    var linkUrlByte = Number(totalBytecheck(linkUrlMessage));
    var totalByte = inputByte + textareaByte + subTitleByte + linkUrlByte;
    var titleByte = inputByte + subTitleByte;
    push.totallength = titleByte;
    push.limitByte = 80;

    $("#textByteSize").val(totalByte);

    if (titleByte > push.limitByte) {
        var confirmChk = true; //컨펌 창의 값이 true인지 false인지 체크

        push.LimitCHk = false;

        if (confirmChk) {
            //제한 용량을 벗어났음을 알리는 경고 창.
            alert("<spring:message code='M01833'/>");

            if (inputType == "input") {
                var remainByte = push.limitByte - textareaByte - subTitleByte - linkUrlByte;
                var k = cutMessage(inputMessage, remainByte);
                $('#contentsTitle').val(inputMessage.substring(0,k));
            }
            else if (inputType == "inputSub") {
                var remainByte = push.limitByte - inputByte - textareaByte - linkUrlByte;
                var k = cutMessage(subTitleMessage, remainByte);
                $('#contentsSubTitle').val(subTitleMessage.substring(0,k));
            }
        }
    }
    else {
        push.LimitCHk = true;
    }
}

//현재 커서 위치에 개인화 속성 값 추가하기
function insertAtCursor(area,text) {
    var contents = document.getElementById(area.id);
    var scrollPos = contents.scrollTop;
    var strPos = 0;
    var br = ((contents.selectionStart || contents.selectionStart == '0') ? "ff" : (document.selection ? "ie" : false ) );

    if (br == "ie") {
        contents.focus();
        var range = document.selection.createRange();
        range.moveStart ('character', -contents.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") {
        strPos = contents.selectionStart;
    }

    var front = (contents.value).substring(0,strPos);
    var back = (contents.value).substring(strPos,contents.value.length);
    contents.value=front+text+back;
    strPos = strPos + text.length;

    if (br == "ie") {
        contents.focus();
        var range = document.selection.createRange( );
        range.moveStart ('character', -contents.value.length);
        range.moveStart ('character', strPos);
        range.moveEnd ('character', 0);
        range.select();
    }
    else if (br == "ff") {
        contents.selectionStart = strPos;
        contents.selectionEnd = strPos;
        contents.focus();
    }

    contents.scrollTop = scrollPos;
}

//개인화 속성 버튼 누를 시 Text 값이 들어가는  action
function persnalTypeClick(id) {
    var perText = "{{" + $("#" + id +" td:eq('0')").text() + "}}";
    insertAtCursor(contents,perText)
    checkByte('textarea');
}

function getChnltype() {
    //Test 발송을 위한 mms/sms/push 구분
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
          groupCode : 'MKT_CAM_CHNL_TYPE_CD'
        , enableNA : true
    }, function(result) {

        var size = result.rows.length;
        for (var i = 0 ; i < size ; i++) {
            //신규 페이지 일 시
            if (chnlCode != "null") {
                if (result.rows[i].codeName == chnlCode) {
                    push.typeCodeId = result.rows[i].codeId;
                    chnlCode = result.rows[i].codeName;
                    push.exeContype = result.rows[i].codeName;
                }
            }
            else {
                //상세 페이지 일 시
                if (push.exeContype != null) {
                    if (push.exeContype == result.rows[i].codeName)
                          chnlCode = result.rows[i].codeName;
                }
            }
        }
    });
}

//현재 채널 타입 세팅(미리보기 발송 시 현재 채널에 대한 타입을 전달하기 위한 세팅)
function getChcnltype() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_TYPE_CD'
        , enableNA : true
    }, function(result) {
        var size = result.rows.length;
        for (var i=0;i<size;i++) {

            //신규 페이지 일 시
            if (chnlCode != "null") {
            	//작성 가이드 셋팅
					$.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
						chnltype : chnlCode
					}, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
					    	$("#chnlGuide").val(result.chnlGuide);
						}
					});		
                if (result.rows[i].codeName == chnlCode) {
                    push.typeCodeId = result.rows[i].codeId;
                    push.exeContype = result.rows[i].codeName;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            else {
                //상세 페이지 일 시
                if (push.exeContype != null) {
                    if (push.exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
            }
        }
    });
}

//초기 로딩 시 글자 수 체크
function initByteCheck() {
    checkByte();
    checkByte('inputSub');
    checkByte('inputLink');
    checkByte('textarea');
}


function personalChangeFun(changeType){
    if(changeType == "mkt"){
        //개인화 속성 로드
        $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>', {
            contentTypeCodeValue : "PERSONALIZATION"
        }, function(result) {
            var size = result.length;
            arrStore = {};
            arrStore.markName = '<spring:message code="M00436"/>';
            for (var i=size;i>=0;i--) {
                if (i != 0) {
                    temp = result[i-1];
                    result[i] = temp;
                }
                else {
                    result[0] = {};
                    result[0] = arrStore;
                }
            }
            var temp = $("#persnalTemp").tmpl(result);
            $("#persnal").empty().append(temp);
        });
    } else {
        //그외 개인화 속성 로드
        $.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>', {
            contentTypeCodeValue : "LOYPERSONALIZATION"
        }, function(result) {
            var size = result.length;
            arrStore = {};
            arrStore.markName = '<spring:message code="M00436"/>';
            for (var i=size;i>=0;i--) {
                if (i != 0) {
                    temp = result[i-1];
                    result[i] = temp;
                }
                else {
                    result[0] = {};
                    result[0] = arrStore;
                }
            }
            var temp = $("#persnalTemp").tmpl(result);
            $("#persnal").empty().append(temp);
        });
    }

    var mktOfrTypeVal = $("#mktOfrType").val();
    //쿠폰 COM_OFR_TYPE
    if (mktOfrTypeVal == 'C') {
        $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
        //포인트
    } else if (mktOfrTypeVal == 'P') {
        $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
        //설문
    } else if (mktOfrTypeVal == 'S') {
        $("#persnal option[value='설문URL']").removeAttr('disabled').show();
        //예외
    } else {
        $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
    }
}

//초기 설정
function initSetting() {

    //입력문자 사이즈 숨김
    $("#textByteSizeArea").hide();

    // PUSH 유형 공통코드
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'CONTS_PUSH_TYPE_CD'
        , enableNA : true
    }, function(result) {
        var size = result.rows.length;

        var temp = $("#pushTypeTemp").tmpl(result.rows);
        $("#contsPushType").append(temp);
    });
    
	$("#contsPushType option[value='Direct_URL']").remove();
	$("#contsPushType option[value='HTML']").remove();

    // 메세지 유형 공통코드
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'TXT_MSG_OBJECT_CD'
        , enableNA : true
    }, function(result) {
		var size = result.rows.length;
		var arry = new Array();
		for (var i = size; i > 0; i--) {
			if (i != 0) {
				temp = result.rows[i - 1];
				arry[i-1] = temp;
			}
		}
		var temp = $("#MsgTypeTemp").tmpl(result.rows);
		$("#txtMsgObject").append(temp);
    });



    //사용자 정의 데이터 유형
    // PUSH 유형 공통코드
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'PUSH_PARAM_TYPE'
        , enableNA : true
    }, function(result) {
        var size = result.rows.length;
        arrStore = {};
        arrStore.markName = '<spring:message code="M00436"/>';
        for (var i=size;i>=0;i--) {
            if (i != 0) {
                temp = result.rows[i-1];
                result.rows[i] = temp;
            }
            else {
                result.rows[0] = {};
                result.rows[0] = arrStore;
            }
        }

        $.each($("#userParameterArea .user_param_row"), function(index, obj) {
            var temp = $("#pushTypeTemp").tmpl(result.rows);
            $(obj.children.paramId).append(temp);
        });
    });
    
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'DAISO_APP_DISP_CODE'
        , enableNA : true
    }, function(result) {
    	
    	$.each(result.rows, function(index, obj) {
    		obj.codeName = "SHOW_DETAILS";
    	});
    	
    	$.each($("#userParameterArea .user_param_row"), function(index, obj) {
            var temp = $("#pushTypeTemp").tmpl(result.rows);
            $(obj.children.paramId).append(temp);
            
            $(obj.children.paramId).change(function() {
            	var url = $(obj).find('#paramId option:selected').attr('attrib01');
            	$(obj).find('#paramVal').val(url);
            });
        });
    });

    $("#imgCnt").hide();
    initByteCheck();
    getChcnltype();
    pushValidation = $(".content_textImage_con").ifvValidation();
}

//입력 길이 제한 조회
function getLimit() {
	var LimitStore = null;
	
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_LIMITE'
        , enableNA : true
    }, function(result) {
        var text = "L" + chnlCode;
        var size = result.rows.length

        //각 LMS,SMS 등에 맞는 용량 가져오기.
        for (var i=0;i<size;i++) {
            if (result.rows[i].codeName == text) {
                LimitStore = result.rows[i].attrib01
            }
        }
    });
}

//미리보기 팝업 열기
function openPreViewPopup() {
    push.previewChk = true;
    push.precontentsTitle = $('#contentsTitle').val();
    push.precontentsSubTitle = $('#contentsSubTitle').val();

    push.precontents = $('#contents').val();
    //push유형이 HTML 일 경우만 html로 contents 구성
    if ($("#contsPushType").val() == "HTML" && push.rteeObj != null) {
        push.precontents = push.rteeObj.getDocument().documentElement.outerHTML;
        push.photoUrl = '';
    }
    push.pushTypeCode = $("#contsPushType").val();
    push.preAppType = $("#contsPushAppType").val();          // App 유형
    push.preLinkUrl = $("#contsPushSubTypeVal").val();       // 링크 URL

    //URL 포함인지 확인
    if($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
        alert('설문 값을 입력해주세요.')
        return;
    }

    var resultFlag = actionContent();
    checkByte('input');

    if (push.LimitCHk) {
        if (Number(push.totallength) < Number(push.limitByte)) {
            push.LimitCHk = true
        }
    }

    if (push.LimitCHk == false) return;
    if (resultFlag == false) return;

    if (conid != '') {
        $("#preViewPopDialog").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="MKTPushPreviewPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M00419"/>',
            width: 800,
            close : 'preViewPopClose'
        });
    }
    else {
        alert('<spring:message code="M00448"/>');
    }
}

//개인화 속성 설정
function setPersnal() {

    if ($("#persnal option:selected").text() != "<spring:message code="M00436"/>") {
        var text = "{{" + $("#persnal option:selected").text() + "}}";
        if (push.focusCHeck == contents) {
            insertAtCursor(contents,text)
            checkByte('textarea');
        }
        else if (push.focusCHeck == contentsTitle) {
            insertAtCursor(contentsTitle,text)
            checkByte('input');
        }
        else if (push.focusCHeck == contentsSubTitle) {
            insertAtCursor(contentsSubTitle,text)
            checkByte('inputSub');
        }
        else if (push.focusCHeck == contsPushSubTypeVal) {
            insertAtCursor(contentsSubTitle,text)
            checkByte('inputSub');
        }
        else if (push.focusCHeck == push.rteeObj) {
           	push.rteeObj = document.execCommand('insertHTML',String(text) );

        }
    }
    $("#persnal option:eq(0)").attr("selected","selected");
}

//이미지, 파일 제한 그리드
function setImageFileLimitGrid() {
    var chnltypeId = "";

    $.ifvSyncPostJSON('<ifvm:action name="getChnlId"/>', {
        chnltype : chnlCode
    }, function(result) {
        if (result != null) {
            chnltypeId = result.chnlId
        }
    });

    var jqGridOption = {
        onSelectCell : function (data) {
            selectChilRow = data.id;
        },
        url:'<ifvm:action name="getImgOption"/>',
        serializeGridData : function( data ) {
            data.mktChlId = chnltypeId
            return data;
        },
        colNames:[
                  '<spring:message code="M00491"/>',
                  '<spring:message code="M00492"/>',
                  '<spring:message code="M00493"/>',
                  '<spring:message code="M00494"/>',
                  'id'
        ],
        colModel:[
            {name:'upldEtsionCd',   index:'c1.mark_name',    resizable : false},
            {name:'maxVol',         index:'mcc.max_vol',     resizable : false, formatter: $.fn.comma, align:"right"},
            {name:'imgResolW',      index:'mcc.img_resol_w', resizable : false, align:"right"},
            {name:'imgResolH',      index:'mcc.img_resol_h', resizable : false, align:"right"},
            {name:'id',             index:'id',              resizable : false, hidden : true,  searchable : false}
        ],
        autowidth: true,
        sortname: 'seq',
        sortorder: "asc",
        tempId : 'LimitPopTemplete',
        emptyRows : true,
    };
    imageFileLimitGrid = $("#imageFileLimitGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//Contents HTML(텍스트 에디터) 설정
function setContentsHTML() {

    //텍스트 에디터 설정
    $("#contents").ejRTE({
         width:"100%",
         height: "100%",
         minWidth:"200px",
         minHeight: "200px",
         showFooter: true,
         showHtmlSource:true,
         toolsList:[],
         select: function(args) {
             push.focusCHeck = push.rteeObj;
         }
    });

    push.rteeObj = $("#contents").data("ejRTE");
}

//Push 유형 변결 설정
function changeContsPushType() {
    var pushType = $("#contsPushType").val();

    //HTML
    if (pushType == "HTML") {
    	
        //내용 초기화
        $("#contents").val("");

        //이미지 영역 숨기기
        $("#sortable").hide();

        //영역 높이
        $(".textareaBox").height("345px");

        //링크 URL 영역 숨기기
        $("#contsPushSubTypeValArea").hide();

        //링크 URL 초기화
        $("#contsPushSubTypeValArea").val("");

        //Contents HTML(텍스트 에디터) 설정
        setContentsHTML();

        //콘텐츠 필수값 설정
        //$("#contents").attr("required", true);
        
    }
    //Direct URL
    else if (pushType == "Direct_URL") {

        //내용 초기화
        $("#contents").val("");

        //이미지 영역 보이기
        $("#sortable").show();

        //내용 영역 비활성
        //$("#contents").attr("disabled", true);

        //콘텐츠 필수값 해제
        //$("#contents").removeAttr("required", true);

        //링크 URL 영역 보이기
        $("#contsPushSubTypeValArea").show();

        //영역 높이
        $(".textareaBox").height("145px");

        if (push.rteeObj != null) {
            //텍스트 에디터 제거
            push.rteeObj.destroy();
        }
        
    }
    else {
        //내용 초기화
        $("#contents").val("");
    	
        //이미지 영역 보이기
        $("#sortable").show();

        //내용 영역 활성
        $("#contents").attr("disabled", false);

        //콘텐츠 필수값 설정
        //$("#contents").attr("required", true);

        //링크 URL 영역 숨기기
        $("#contsPushSubTypeValArea").hide();

        //링크 URL 초기화
        $("#contsPushSubTypeValArea").val("");

        //영역 높이
        $(".textareaBox").height("145px");

        if (push.rteeObj != null) {
            //텍스트 에디터 제거
            push.rteeObj.destroy();
        }
        
    }

    //메세지 유형 설정
    setTxtMsg();

    //validation 설정
    pushValidation = $(".content_textImage_con").ifvValidation();
}

//이미지 삭제
function removeImage() {
    //이미지 초기화
    $('#mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
    imgId = '';
    $("#imgCnt").val(0);
    push.photoUrl = '';
}

//이미지 팝업 열기
function openImagePopup() {
        //팝업창에서 이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
        $("#mmsFormNewPop").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            //contentUrl: '<ifvm:url name="MKTAddImagePop"/>',
            contentUrl: '<ifvm:url name="MKTAddImagePopS3"/>?type=push',
            contentType: "ajax",
            title: '<spring:message code="M00797"/>',
            width: 870,
            close : 'mmsFormNewPopClose'
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

	var contsPushType = $('#contsPushType').val() == '' ? 'Notification' : $('#contsPushType').val() ;
	var contentTxt = (contsPushType == 'HTML') ? push.rteeObj.getHtml() : $("#contents").val();

	for (var i = 0 ; i < size ; i++) {
		var searchString = $("#txtMsgObject option").eq(i).text();
		if (addTitle == false && $("#contentsTitle").val().startsWith(searchString)) {
			addTitle = true;
			$("#contentsTitle").val($("#contentsTitle").val().replace(searchString, selectMsg));
		}
		if (addContent == false && contentTxt.indexOf(searchString) > -1) {
			addContent = true;
		    if (contsPushType == 'HTML')
		        push.rteeObj.setHtml( contentTxt.replace(searchString, selectMsg) );
		    else if (contsPushType == 'Notification')
				$("#contents").val(contentTxt.replace(searchString, selectMsg));
		}
	}
	if (addTitle == false) $("#contentsTitle").val(selectMsg + $("#contentsTitle").val());
/* 	if (addContent == false) {
	    if (contsPushType == 'HTML')
	        push.rteeObj.setHtml( selectMsg + contentTxt );
	    else if (contsPushType == 'Notification')
		    $("#contents").val(selectMsg + contentTxt);
	} */
	checkByte('input');
	checkByte('textarea');

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

//쿠폰 리스트 팝업
function ofrListPop(){
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


function ofrListPopClose(){
    ofrListPopDialog._destroy();
}

//캠페인 키 팝업
function campaignKeyPop(){
    var openflag = true;

    if (openflag) {
        $("#campaignKeyPopDialog").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="campaignKeyPop"/>',
            contentType: "ajax",
            title: '캠페인 키',
            width: 650,
            close: 'campaignKeyPopClose'
        });
    }
}

function campaignKeyPopClose(){
    campaignKeyPopDialog._destroy();
}

//포인트 리스트 팝업
function ofrPointListPop(){
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

function ofrPointListPopClose(){
    ofrPointListPopDialog._destroy();
}

//설문 리스트 팝업
function surveyListPop(){
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

function surveyListPopClose(){
    surveyListPopDialog._destroy();
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


$(document).ready(function() {

    $.fn.ifvmSetSelectOptionCommCode("contsTypeCd", "COM_CONTS_TYPE_CD", null, null, true);

    $.fn.ifvmSetSelectOptionCommCode("mktOfrType", "COM_OFR_TYPE", null, null, true);
    $('#contsTypeArea').hide();
    // $('#ranDomOfrNm').css({'width':"250"});
    // $('#ofrPoint').css({'width':"250"});

    $.ifvmLnbSetting('contentListNew');

    //권한 불러오기
    contentAuth();
    
    //초기설정
    initSetting();

    //상세조회
    idCheck();

    //채널유형조회
    getChnltype();

    //텍스트파일크기조회
    getLimit();

    //개인화 속성 목록
    getPersonalType();

    $('#mktOfrType').find('[value=S]').remove();

    $("#btnList").click(function () {
        qtjs.href('<ifvm:url name="contentListNew"/>');
    });
    

    checkByte('inputSub');
    checkByte('inputLink');
    checkByte('textarea');
    checkByte('warning');

    // 이미지 제한조건 표시 ------ 에듀윌 소스 추가
    setTimeout(function() {
        setImageFileLimitGrid();
    }, 50);

    
    //쿠폰리스트
    $('#btnOfrListPop').on('click', function(){
    	ofrListPop();
    });
	
    
    // 개인속성화 버튼
    $("#persnal").on('change', function() {
        if (checkPersonalType() === false) {
            alert('개인화 속성은 5가지를 넘길 수 없습니다.')
            $("#persnal option:eq(0)").attr("selected", "selected");
            return;
        }
        setPersnal();
    });
    // 콘텐츠 내용 포커스 잃을때 이벤트
    $("#contents").on('blur', function() {
        push.focusCHeck = contents;
    });
    // 콘텐츠 제목 포커스 잃을때 이벤트
    $("#contentsTitle").on('blur', function() {
        push.focusCHeck = contentsTitle;
    });
    // 콘텐츠 제목 포커스 잃을때 이벤트
    $("#contentsSubTitle").on('blur', function() {
        push.focusCHeck = contentsSubTitle;
    });
    // 콘텐츠 제목 포커스 잃을때 이벤트
    $("#contsPushSubTypeVal").on('blur', function() {
        push.focusCHeck = contsPushSubTypeVal;
    });
    // 콘텐츠 내용 키업 이벤트
    $("#contents").bind('keyup', function() {
        checkByte('textarea');
    });
    // 콘텐츠 제목 키업 이벤트
    $("#contentsTitle").bind('keyup', function() {
        checkByte('input');
    });
    // 콘텐츠 서브제목 키업 이벤트
    $("#contentsSubTitle").bind('keyup', function() {
        checkByte('inputSub');
    });
    // 링크 URL 키업 이벤트
    $("#contsPushSubTypeVal").bind('keyup', function() {
        checkByte('inputLink');
    });
    $("#contsTypeCd").change(function () {
        personalChangeFun($('#contsTypeCd').val());
    });
    // 저장 버튼 이벤트
    $("#saveBtn").on('click', function() {
		var validTitleArea = $("#contentsTitle").val();
		var checkMsg = $("#txtMsgObject option:selected").text();

        ///URL 포함인지 확인
        if($("#mktOfrType").val() == 'S' && checkURLYn() == false) {
            alert('설문 값을 입력해주세요.')
            return;
        }

        // 저장
        if(validTitleArea.indexOf(checkMsg) > -1){
        	var result = actionContent();
        }else{
        	alert('<spring:message code="M00433"/>');
        }

        if (result == true) {
            // 컨텐츠 팝업 종료
                if( typeof closeContentsDesignPop == 'function' ) {
            	closeContentsDesignPop();
            }
        }
    });

    //테스트 발송
    $('#pushTestSendBtn').on('click', function() {
        openPreViewPopup();
    });

    // PUSH유형 변경 이벤트
    $("#contsPushType").on('change', function() {
        changeContsPushType();
    });
    // 메세지 유형 변경 이벤트
    $("#txtMsgObject").change(function() {
    	//메세지 유형 설정
    	setTxtMsg();
    });

    // 이미지 삭제 이벤트
    $("#image_remove").on('click', function() {
        //이미지 초기화
        $('#mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
        imgId = '';
        $("#imgCnt").val(0);
        $(this).hide();
    });

    // 이미지 팝업 호출 이벤트
    $('#mmsImage').on('click', function() {
        //이미지 팝업 열기
        	openImagePopup();
    });

    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();

    $("#mktOfrType").change(function () {
        var mktOfrTypeVal = $("#mktOfrType").val();
        if(mktOfrTypeVal != null && mktOfrTypeVal != '') {
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
                $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
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
                $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
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
                $("#persnal option[value='설문URL']").attr('disabled','disabled').hide();
            }
        }
    });
    
    //popup 높이 맞추기
    initPopupHeight();
});

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

//설문 url 체크
function checkURLYn() {
    var checkText = $("#contents").val()
    var checkValue = $("#surveyNm").val()
    cText = '{{설문URL}}'

    if(checkText.search(cText) != -1 && checkValue == '') {
        return false;
    }
}

function checkPersonalType(){
    var chkFlag = 1;
    var chkText = $("#contents").val() + $("#contentsTitle").val();

    for (i = 0; i < personalType.length; i++) {
        if (chkText.indexOf(personalType[i]) != -1) {
            if (chkText.indexOf($('#persnal').val()) == -1){
                chkFlag++;
            }
        }
    }

    if(chkFlag > 5){
        return false;
    }
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

<script id="pushTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>

<script id="persnalTemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
</script>

<script id="MsgTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="appTypeTemp" type="text/x-jquery-tmpl">
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
        <spring:message code="M00374"/> &gt;  <spring:message code="M00274"/>
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
            <button class="btn btn-sm" id="pushTestSendBtn" objCode="smsFormNewTestSendBtn_OBJ">
                <spring:message code="M00391"/>
            </button>
	       <button class="btn btn-sm btn_gray" id = "btnList" objCode="smsFormNewList_OBJ">
              	<spring:message code="C00166"/>
		  </button> 
        </div>
    </div>
</div>

<div>
    <div class="well form-horizontal content_textImage_con">
        <br>
        <div class="phoneImage">
            <div class="sms_kinds"><span>PUSH</span></div>
            <div class="phoneWrap">
                <ifvm:input type="text" className="push_phone_area" id="contentsTitle" required="true" />
                <div style="display:none;">
                    <ifvm:input type="text" className="push_phone_area" id="contentsSubTitle"/>
                </div>
                <div id="sortable">
                    <div class="imageBox">
                        <div class="image_img">
                            <div class="image_close remove_image" id="image_remove">
                                <img src="<ifvm:image name='photo_close'/>"/>
                            </div>
                            <img src="<ifvm:image name='photo_def'/>" id="mmsImage"/>
                        </div>
                    </div>
                </div>
                <div class="textareaBox">
                    <ifvm:input type="textarea" required="true" className="sms_phone_area" id="contents"/>
                </div>
                <div id="textByteSizeArea" style="display:none;">
                    <label class="phone_text"><spring:message code="M00397"/></label>
                    <ifvm:input type="text" className="inputText" disabled="true" id="textByteSize"/>
                    <span class="phone_text"><spring:message code="M00798"/></span>
                </div>
            </div>
        </div>
        <div class="col-xs-8 control_content">
            <div class="input_area" id="selectForm">
                <br>
                <ifvm:input type="hidden" id="contsPushAppType" names="contsPushAppType" values="E1"/>
                <div class="row">

                    <%-- 컨텐츠명 --%>
                    <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="text" required="true" id="contentsName" maxLength="30"/>
                        <ifvm:input type="text" id="imgCnt" />
                    </div>
                </div>
                <%--캠페인 키 --%>
                <div class="row qt_border">
                        <ifvm:inputNew type="search" id="brazeCamApiKey" btnFunc="campaignKeyPop" label="캠페인 키"
                                       dto="brazeCamApiKey" names="brazeCamApiKey" labelClass="2" conClass="7" required="true" />
                </div>
                <div class="row" id="txtMsgObjectDiv">
                    <%-- 메세지유형 --%>
                    <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00388"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="select" id="txtMsgObject" names="txtMsgObject"/>
                    </div>
                </div>
                <div class="row">

                    <%-- push유형 --%>
                    <%--<label class="control-label"><span class="asterisk">*</span><spring:message code="M01834"/></label>
                    <div class="control_content">
                        <ifvm:input type="select" id="contsPushType" names="contsPushType" required="true"/>
                    </div>
                </div>
                <div class="row" id="contsPushSubTypeValArea" style="display:none;">--%>

                    <%-- 링크URL --%>
                    <label class="col-xs-2 control-label"><spring:message code="M01836"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="text" id="contsPushSubTypeVal" names="contsPushSubTypeVal"/>
                    </div>
                </div>
                <div class="row" id="persnalArea">

                    <%-- 개인화 속성 --%>
                    <label class="col-xs-2 control-label"><spring:message code="M00398"/></label>
                    <div class="col-xs-7 control_content">
                        <ifvm:input type="select" id="persnal"/>
                    </div>
                </div>
                <div class="row" id="contsTypeArea">
                        <ifvm:inputNew type="select" id="contsTypeCd" names="contsTypeCd" dto="contsTypeCd" />
                </div>
                			<%--오퍼(쿠폰) --%>
                <div class="row" id="ofrArea">
                    <%-- 오퍼유형 --%>
                    <ifvm:inputNew type="select" id="mktOfrType" names="mktOfrType" dto="mktOfrType"   label="M03049"  labelClass="2" conClass="7"/>
                </div>
                <%--오퍼(쿠폰) --%>
                <div class="row qt_border" id="ofrNmDiv">
                    <ifvm:inputNew type="search" clearArgs="'ofrNm,ridOfr'" id="ofrNm" hidId="ridOfr" hidDto="ridOfr" btnFunc="ofrListPop" dto="ofrNm" names="ofrNm" label="쿠폰" labelClass="2" conClass="7" />
                </div>
                <%--포인트 --%>
                <div class="row qt_border" id="ofrPointDiv">
                    <ifvm:inputNew type="search" clearArgs="'ofrPoint,ridPoint'" id="ofrPoint" hidId="ridPoint" hidDto="ridPoint" btnFunc="ofrPointListPop" dto="ofrPoint" names="ofrPoint" label="포인트" labelClass="2" conClass="7" />
                </div>
                <%--설문 --%>
                <div class="row qt_border" id="surveyDiv">
                    <ifvm:inputNew type="search" clearArgs="'surveyNm,ridSurvey'" id="surveyNm" hidId="ridSurvey" hidDto="ridSurvey" btnFunc="surveyListPop" dto="surveyNm" names="surveyNm" label="설문" labelClass="2" conClass="7" />
                </div>
            </div>

            <%-- 사용자 정의 데이터 --%>
<%--            <div id="userParameterTitle"><spring:message code="M02344"/></div>--%>
<%--            <div class="row qt_border" id="userParameterArea">--%>
<%--                <div class="user_param_row">--%>
<%--                    <ifvm:input type="select" id="paramId" /> : <ifvm:input type="text" id="paramVal"/>--%>
<%--                </div>--%>
<%--            </div>--%>
			<div id="desArea">
					<textarea class = 'descript' maxlength="50" rows="2" readonly = true>
※수신거부:마이페이지>회원정보수정
					</textarea>
			</div>
                <label class="col-xs-8 control-label" style="color: red; text-align: center"><spring:message code="※개인화 속성은 5가지를 초과할 수 없습니다."/></label>
            <label class="col-xs-8 control-label" style="color: red; text-align: center">PUSH 발송 파일 최대사이즈 : 1,000 KB</label>

        <%--<div id="limitImage">
                <label class="description_title"><spring:message code="M00512"/></label>
                <div class="limit_content">
                    <div id="imageFileLimitGrid" class="pop_grid2"></div>
                </div>
            </div>--%>
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

<div id="preViewPopDialog" class="popup_container"></div>
<div id="mmsFormNewPop" class="popup_container"></div>
<div id="ofrListPopDialog" class="popup_container"></div>
<div id="campaignKeyPopDialog" class="popup_container"></div>
<div id="ofrPointListPopDialog" class="popup_container"></div>
<div id="surveyListPopDialog" class="popup_container"></div>