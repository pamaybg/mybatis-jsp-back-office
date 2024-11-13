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

var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';

var htmlStore; //html 형식 저장소
var conid = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = 'TM';

var rteeObj;
var ctmContentsArea, ctitle, fileName; // 미리 보기 전달을 위한 변수
var typeCodeId;
var personalPropertyGrid;
var parId;
var exeContype;
var detail = false;     //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지

function initTmFormNew() {
    
    htmlStore="";
    $.ifvmLnbSetting('contentListNew');

    //채널 유형 조회
    getCamChnlTypeCode();

    //상세여부 확인 및 데이터 조회
    idCheck();

    tmValidation = $("#selectForm").ifvValidation();
}

//채널 유형 조회
function getCamChnlTypeCode() {
    // Test 발송을 위한 mms/sms/push 구분
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_TYPE_CD',
        enableNA : true
    }, function(result) {
        var size = result.rows.length;
        for (var i = 0; i < size; i++) {

            // 신규 페이지 일 시
            if (chnlCode != "null") {
                if (result.rows[i].codeName == chnlCode) {
                    typeCodeId = result.rows[i].codeId;
                    exeContype = result.rows[i].codeId;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            else {
                // 상세 페이지 일 시
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

//상세페이지 체크
function idCheck() {
    if (conid != "null") {
        //상세 페이지일 경우 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
            id : conid
        }, function(result) {
            $("#contentsName").val(result.contentsName);
            htmlStore = result.html;
        });
        detail = true;
    }

    //html load시 콘텐츠 내용이 초기화 되어 timeout으로 재설정
    setTimeout(function() {
        setRichTextEditor();
    }, 600);
}

//저장 버튼클릭 시 동작
function actionContent() {
    var resultFlag = false;
    
    tmValidation = $("#selectForm").ifvValidation();
    isValid = tmValidation.confirm();
    
    if (isValid) {
        //상세 페이지일 시 수정 작업 동작
        if((typeof(camId) != "undefined" && (camId == null || camId == 'null'))){
            alert('<spring:message code="M00710"/>');
        }
        else if((typeof(quickFlag) != "undefined"
                && quickFlag != null
                && $("#benefitSelect option:selected").attr('value') == 'direct'
                && $("#benefitDirectInput").val().length == 0)) {
            alert('<spring:message code="M00711"/>');
        }
        else {
            //상세 페이지일 시 수정 작업 동작
            if(detail) {
                //이메일 콘텐츠 수정
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                      contentsName     : $("#contentsName").val()
                    , contentsType     : chnlCode
                    , html             : $("#tmContentsArea_Iframe").contents().children().children().next().html()
                    , id               : conid
                }, function(result) {
                    alert('<spring:message code="M00429"/>');
                    if(typeof(camId) != "undefined" && typeof(quickFlag) != "undefined" && quickFlag != null){
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
                    idCheck();
                    resultFlag = true;
                });
            }
            //상세 페이지가 아닐 시 insert 동작
            else {
                var camFlag = 0;
                var campaignWorkflowFlag = $("#campaignWorkflowFlag").val();
                //퀵캠페인 또는 캠페인 워크플로우인지 확인한다.
                if((typeof(quickFlag) != "undefined" && quickFlag != null) || $.fn.ifvmIsNotEmpty(campaignWorkflowFlag)){
                    camFlag = '1';
                }
    
                $.ifvSyncPostJSON('<ifvm:action name="setContent"/>', {
                      contentsName     : $("#contentsName").val()
                    , contentsType     : chnlCode
                    , html             : $("#tmContentsArea_Iframe").contents().children().children().next().html()
                    , camFlag          : camFlag
                }, function(result) {
                    alert('<spring:message code="M00429"/>');
                    conid = result.message;
                    detail = true;
    
                    if (typeof(camId) != "undefined" && quickFlag != null) {
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
    
                    if (typeof(directFlag) != "undefined" && directFlag != null) {
                        directSaveMessage(conid);
                    }
                    idCheck();
                    resultFlag = true;
                });
            }
        }
        if (typeof(directFlag) != "undefined" && directFlag != null) {
            directSaveMessage(conid);
        }
    }
    
    return resultFlag;
}

function editorInit() {
    $('.e-rte-footer-right .clearFormat').remove();
    $('.e-rte-footer-right .clearAll').remove();
    $('.e-rte-footer-right .e-rte-resize').remove();
    $('.e-rte-footer-right .e-rte-wordcount').remove();
}

//editor 한글로 변경
ej.RTE.Locale["ko"] = {
    dialogInsert : '<spring:message code="M00736"/>',
    dialogCancel : '<spring:message code="M00737"/>',
    linkOpenInNewWindow : '<spring:message code="M00738"/>'
}

//rich text editor 설정
function setRichTextEditor() {
    $("#tmContentsArea").ejRTE({
         width:"100%",
         minWidth:"10px",
         showFooter: true,
         showHtmlSource:true,
         tools: {
             formatStyle: ["format"],
             font: ["fontSize", "fontColor", "backgroundColor"],
             style : ["bold", "italic", "underline"],
             indenting: [],
             images: [],
             tables : [],
             doAction : [],
             links : [],
             media : [],
             view : ["fullScreen"]
        }
    });

    rteeObj = $("#tmContentsArea").data("ejRTE");
    rteeObj.setHtml(htmlStore);
}

$(document).ready(function() {
    
    //초기 설정
    initTmFormNew();

    $("#tmContentsArea_fullScreen").on("click", function(){
        $("#tmContentsArea_wrapper").css("top", "0");
    });

    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();

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
</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
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
#hideFile{display:none;}
.hideFile{display:none;}
#contentsDesignCon{height:510px;}
</style>

<div class="page-title">
    <h1>
        <spring:message code="M00372"/> &gt;  <spring:message code="M00274"/>
    </h1>
</div>

<div id="selectForm">
    <div>
        <div class="page_btn_area">
            <div class="col-xs-8">
				<span id="chnlTitleArea"></span> <span><spring:message code="M02494"/></span>
            </div>
            <div class="col-xs-4 searchbtn_r">
            
                <%-- 저장 --%>
                <button class="btn btn-sm" id='saveBtn'>
                    <i class="glyphicon glyphicon-check"></i>
                    <spring:message code="M00280"/>
                </button>
            </div>
        </div>
        <div class="well form-horizontal well_sum">
            <div class="row">
            
                <%-- 컨텐츠명 --%>
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>
                <div class="col-xs-6 control_content">
                    <ifvm:input type="text" required="true" id="contentsName" maxLength="30"/>
                </div>
            </div>
        </div>
        <div class="well form-horizontal">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row qt_border">
                        <!-- editor -->
                        <textarea id="tmContentsArea"></textarea>
                        <!-- editor end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
