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
<style>
#appNoticeFormNewDiv .half_left { width: 70%; margin-top: 10px; } 
#appNoticeFormNewDiv .half_right { width: 25%; margin-top: 10px; } 
</style>

<script>
var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';
var conid   = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode= '<%= cleanXss(request.getParameter("chnl")) %>';
var app = {
	appNoticeValidation :	""		,
	typeCodeId          :	""		,
	exeContype          :	""		,
	detail              :	false	,	//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
	previewChk          :	false	,
	isValid             :	false	,
	focusCHeck          :	null
}

//초기 실행할 펑션들.
function initRunFunction(){
	idCheck();
	getChcnltype();	
}

function idCheck() {
    
    //상세 페이지일 경우 세팅
    if (conid != "null") {
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
               id : conid
        }, function(result) {
            $("#contentsName").val(result.contentsName);
            $("#title").val(result.title);
            $("#contents").val(result.contents);
            $("#hpage").val(result.hpage);
            $("[name=backgroundColor][value=" + result.attrib01 + "]").attr('checked', 'checked');
            $("#chnlGuide").val(result.chnlGuide);
        });
        app.detail = true;
    }
}

/**
 * 저장 버튼클릭 시 동작
 */
function actionContent() {
    var resultFlag = false;
    
    app.isValid = app.appNoticeValidation.confirm();
    if (app.isValid == true) {

        //상세 페이지일 시 수정 작업 동작
        if ((typeof(camId) != "undefined" && (camId == null || camId == 'null'))) {
            alert('<spring:message code="M00710"/>');
        }
        else if((typeof(quickFlag) != "undefined" && quickFlag != null 
                && $("#benefitSelect option:selected").attr('value') == 'direct' 
                && $("#benefitDirectInput").val().length == 0)){
            alert('<spring:message code="M00711"/>');
        } 
        else {
            
            if (app.detail == true) {
                //오퍼 수정
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                      contentsName     : $("#contentsName").val()
                    , contents         : $("#contents").val()
                    , contentsType     : chnlCode
                    , id               : conid
                    , attrib01         : $('[name=backgroundColor]:checked').val()
                    , hpage            : $("#hpage").val()
                    , title            : $("#title").val()
                }, function(result) {
                    if (app.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }  
                    if (typeof(camId) != "undefined" && quickFlag != null) {
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
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
                    , contents         : $("#contents").val()
                    , contentsType     : chnlCode
                    , camFlag          : camFlag
                    , attrib01         : $('[name=backgroundColor]:checked').val()
                    , hpage            : $("#hpage").val()
                    , title            : $("#title").val()
                }, function(result) {
                    if (app.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }
                    
                    conid = result.message;
                    app.detail = true;
                    if (typeof(camId) != "undefined" && quickFlag != null) {
                        try { quickSaveMessage(conid); } catch (e) { }
                    }
                    
                    if (typeof(directFlag) != "undefined" && directFlag != null) {
                        directSaveMessage(conid);
                    }
                    resultFlag = true;
                });
            }
        }
    }
    return resultFlag;
}

/**
 * 화면 기본 셋팅
 */
function initSetting() {

    var limitStore;
    
    //가이드 작성 
    if (limitStore != null) {
        $(".description_guide").children().text(chnlCode + ' <spring:message code="M00452"/> '+  limitStore + "Byte" +' <spring:message code="M00453"/>')
    }
    else {
        $(".description_guide").children().text('');
    }
    
    //배경색 
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'APP_NOTICE_BKCOLOR_TYPE_CD',
        enableNA : false
    }, function(result) {
		var temp = $("#backgroundColortemp").tmpl(result.rows);
		$("#backgroundColortempArea").append(temp);
	});
    
	//개인화 속성 로드
	$.ifvSyncPostJSON('<ifvm:action name="getConPersonalList"/>',{
	},function(result) {
		var size = result.length;
		arrStore = {};
		arrStore.markName = '<spring:message code="M00436"/>';
		for (var i = size ; i >= 0 ; i--) {
			if (i != 0) {
				temp = result[i-1];
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
    
    app.appNoticeValidation = $("#appNoticeFormNewDiv").ifvValidation();
}

//현재 채널 타입 세팅
function getChcnltype() {
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
        groupCode : 'MKT_CAM_CHNL_TYPE_CD'
        , enableNA : true
    }, function(result) {
        var size = result.rows.length;
        for (var i = 0 ; i < size ; i++) {
            //신규 페이지 일 시
            if (chnlCode != "null") {
            	//작성 가이드 셋팅
				$.ifvSyncPostJSON('<ifvm:action name="getChnlGuide"/>', {
						chnltype : chnlCode
				}, function(result) {
				    $("#chnlGuide").val(result.chnlGuide);   
				});		
                if (result.rows[i].codeName == chnlCode) {
                    app.typeCodeId = result.rows[i].codeId;
                    app.exeContype = result.rows[i].codeName;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            else {
                //상세 페이지 일 시
                if (app.exeContype != null) {
                    if (app.exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
            }
        }
    });
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

$(document).ready(function() {
    
    getChcnltype();
    initSetting();
    
    // 상세 데이터 출력
    idCheck();
    
    // 저장 버튼 클릭
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

    $("#title").on('blur', function() {
        app.focusCHeck = title;
    });
    $("#contents").on('blur', function() {
        app.focusCHeck = contents;
    });
    
    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();
	$("#persnal").on('change', function() {
		if($("#persnal option:selected").text() != '<spring:message code="M00436"/>'){
			var text = "$$" + $("#persnal option:selected").text() + "$$";
			if (app.focusCHeck == title) {
				insertAtCursor(document.getElementById("title"), text);
			}
			else {
				insertAtCursor(document.getElementById("contents"), text);
			}
		}
		$("#persnal option:eq(0)").attr("selected", "selected");
	});
});

</script>

<script id="persnaltemp" type="text/x-jquery-tmpl">
<option data-val-max-size="${'${'}valMaxSize}" value="${'${'}markName}">${'${'}markName}</option>
</script>

<script id="backgroundColortemp" type="text/x-jquery-tmpl">
<label class="radio-inline">
    <ifvm:input type="radio" required="true" names="backgroundColor" values="${'${'}codeName}"/>${'${'}markName}
</label>
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

<div class="half_wrap top_well" id="appNoticeFormNewDiv">
   	<div class="half_content half_left">
        <div class="row qt_border">
        
            <%-- 컨텐츠명 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>    
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" required="true" id="contentsName" names="contentsName"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 제목 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00377"/></label>    
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" required="true" id="title" names="title"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 공지내용 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02358"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="textarea" required="true" id="contents" names="contents" rows="3"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 링크URL --%>
            <label class="col-xs-2 control-label"><spring:message code="M01836"/></label>    
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" id="hpage" names="hpage"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 배경색 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02719"/></label>
            <div class="col-xs-10 control_content" id="backgroundColortempArea"></div>
        </div>
   	</div>
   	<div class="half_content half_right">
		<div class="row">

            <%-- 개인화속성 --%>
			<label class="col-xs-4 control-label"><spring:message code="M00398"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="select" id="persnal"/>
			</div>
		</div>
   	</div>
    
   	<%-- 작성가이드 --%>
    <div class="guide_area" style="width: 70%">
        <div class="col-xs-12 control_content">
            <div class="description_title">
                <spring:message code="M00400"/>
            </div>
            <ifvm:input type="textarea" id="chnlGuide" readonly="readonly" rows="5"/>
        </div>
    </div>
</div>
