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
#webFormNewDiv .content_textImage_con .imageBox { width: 124px; height: 124px; }
#webFormNewDiv .content_textImage_con .image_img { width: 114px; height: 114px; }
</style>

<script>

var openType = '<%= cleanXss(request.getParameter("openType")) == null ? "" : cleanXss(request.getParameter("openType")) %>';

var imgId ,subImgId;
var conid    = '<%= cleanXss(request.getParameter("id")) %>';
var chnlCode = '<%= cleanXss(request.getParameter("chnl")) %>';
var webImgPop;
var web = {
		photoUrl	  : "" ,
		subphotoUrl	  : "" ,
		subImgYN	  : "" ,
		webValidation : "" ,
		exeContype	: null ,
		previewChk	: false,
		isValid		: false,
		detail		: false		//수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지		
}
 
/* 이미지 팝업 닫기 */
function mmsFormNewPopClose() {
    webImgPop._destroy();
}

function idCheck() {
    //상세 페이지일 경우 세팅
    if (conid != "null") {
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
           id : conid
        }, function(result) {
            
            $("#contentsName").val(result.contentsName);
            $("#title").val(result.title);
            $("#subTitle").val(result.subTitle);
            $("#description").val(result.description);
            $("#pstngTypeCd").val(result.pstngTypeCd);
            $("#contsAttenMtr").val(result.contsAttenMtr);
            $("#inqrNo").val(result.inqrNo);
            $("#attrib03").val(result.attrib03);
            $("#chnlGuide").val(result.chnlGuide);
           	web.exeContype = result.contentsType;                           // 실행채널유형
            chnlCode = result.contentsType;                             // 실행채널유형
            
            if (result.attrib04 == '1') { $("#attrib04").prop('checked', true); }
            if (result.attrib05 == '1') { $("#attrib05").prop('checked', true); }
            if (result.attrib06 == '1') { $("#attrib06").prop('checked', true); }
            if (result.attrib07 == '1') { $("#attrib07").prop('checked', true); }
            $("#attrib08").val(result.attrib08);
            $("#attrib09").val(result.attrib09);

            if ($.fn.ifvmIsNotEmpty(result.dpStartDt)) {
                $("#dpStartDt").val(result.dpStartDt.split(' ', 1));
            }
            if ($.fn.ifvmIsNotEmpty(result.dpEndDt)) {
                $("#dpEndDt").val(result.dpEndDt.split(' ', 1));
            }
            if ($.fn.ifvmIsNotEmpty(result.newDpCloDt)) {
                $('#newDpCloDate').val(result.newDpCloDt.split(' ')[0]);
                $('#newDpCloTime').val(result.newDpCloDt.split(' ')[1]);
            }
            $("#apctPosblNum").val(result.apctPosblNum);
            $("#contsSeq").val(result.contsSeq);
            $("#contsLoadSeq").val(result.contsLoadSeq);
            $("#hpage").val(result.hpage);
            $("#evNo").val(result.evNo);

            $("#activeImg #imgId").val(result.imgId);
            $("#subImage #imgId").val(result.subImgId);
            
            //활성이미지
            if (result.imagepath != null) {
                var path = '<ifvm:url name="imageView"/>' + result.imagepath;
                $('#activeImg #mmsImage').attr('src',path);
                $('#activeImg .image_close').show();
                $("#activeImg #imgCnt").val(1);
            }
            if (result.merpath != null) {
                web.photoUrl = '/' + result.merpath;
            }
            
            //비활성이미지
            if (result.subImagepath != null) {
                var path = '<ifvm:url name="imageView"/>' + result.subImagepath;
                $('#subImage #mmsImage').attr('src',path);
                $('#subImage .image_close').show();
                $("#subImage #imgCnt").val(1);
            }
            if (result.subMerpath != null) {
                web.subPhotoUrl = '/' + result.subMerpath;
            }
            
        });
        web.detail = true;
    }
}

/**
 * 저장 버튼클릭 시 동작
 */
function actionContent() {
    var resultFlag = false;
    
    web.isValid = web.webValidation.confirm() && chkCalendarValidation();
    if (web.isValid == true) {

        if ($("#activeImg #mmsImage").attr('src').substring(1).length > 0) {
            var idx = $("#activeImg #mmsImage").attr('src').indexOf("=");
            imgSrc = $("#activeImg #mmsImage").attr('src').substring(idx+1);
        }
        else {
            imgSrc = '';
        }
        if ($("#activeImg #imgCnt").val() != 1) {
            imgId = null;
        }

        //비활성이미지
        if ($("#subImage #mmsImage").attr('src').substring(1).length > 0) {
            var idx = $("#subImage #mmsImage").attr('src').indexOf("=");
            subImgSrc = $("#subImage #mmsImage").attr('src').substring(idx+1);
        }
        else {
            subImgSrc = '';
        }
        if ($("#subImage #imgCnt").val() != 1) {
            subImgId = null;
        }
        
        //상세 페이지일 시 수정 작업 동작
        if ((typeof(camId) != "undefined" && (camId == null || camId == 'null'))) {
            alert('<spring:message code="M00710"/>');
        }
        else if ((typeof(quickFlag) != "undefined" && quickFlag != null 
                && $("#benefitSelect option:selected").attr('value') == 'direct' 
                && $("#benefitDirectInput").val().length == 0)) {
            alert('<spring:message code="M00711"/>');
        } 
        else {
            
            if (web.detail == true) {
                //오퍼 수정
                $.ifvSyncPostJSON('<ifvm:action name="editResponseContent"/>', {
                      id            : conid
                    , contentsType  : chnlCode
                    , contentsName  : $("#contentsName").val()
                    , title         : $("#title").val()
                    , subTitle      : $("#subTitle").val()
                    , description   : $("#description").val()
                    , pstngTypeCd   : $("#pstngTypeCd").val()
                    , contsAttenMtr : $("#contsAttenMtr").val()
                    , inqrNo        : $("#inqrNo").val()
                    , attrib03      : $("#attrib03").val()
                    , attrib04      : $("#attrib04").is(':checked') == true ? '1' : '0'
                    , attrib05      : $("#attrib05").is(':checked') == true ? '1' : '0'
                    , attrib06      : $("#attrib06").is(':checked') == true ? '1' : '0'
                    , attrib07      : $("#attrib07").is(':checked') == true ? '1' : '0'
                    , attrib08		: $("#attrib08").val()
                    , attrib09		: $("#attrib09").val()
                    , dpStartDt     : $("#dpStartDt").val()
                    , dpEndDt       : $("#dpEndDt").val()
                    , newDpCloDt    : $.fn.ifvmIsEmpty($('#newDpCloDate').val()) ? '' : $('#newDpCloDate').val() + ' ' + $('#newDpCloTime').val()
                    , apctPosblNum  : $("#apctPosblNum").val()
                    , contsSeq      : $("#contsSeq").val()
                    , contsLoadSeq  : $("#contsLoadSeq").val()
                    , hpage         : $("#hpage").val()
                    , evNo          : $("#evNo").val()

                    , imgSize       : $("#activeImg #imgSize").val()
                    , imgCnt        : $("#activeImg #imgCnt").val()
                    , imgId         : $('#activeImg #imgId').val()
                    
                    , subImgSize    : $("#subImage #imgSize").val()
                    , subImgId      : $('#subImage #imgId').val()
                }, function(result) {
                    if (web.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }
                    
                    idCheck();
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
                      contentsType  : chnlCode
                    , camFlag       : camFlag
                    , contentsName  : $("#contentsName").val()
                    , title         : $("#title").val()
                    , subTitle      : $("#subTitle").val()
                    , description   : $("#description").val()
                    , pstngTypeCd   : $("#pstngTypeCd").val()
                    , contsAttenMtr : $("#contsAttenMtr").val()
                    , inqrNo        : $("#inqrNo").val()
                    , attrib03      : $("#attrib03").val()
                    , attrib04      : $("#attrib04").is(':checked') == true ? '1' : '0'
                    , attrib05      : $("#attrib05").is(':checked') == true ? '1' : '0'
                    , attrib06      : $("#attrib06").is(':checked') == true ? '1' : '0'
                    , attrib07      : $("#attrib07").is(':checked') == true ? '1' : '0'
                    , attrib08		: $("#attrib08").val()
                    , attrib09		: $("#attrib09").val()
                    , dpStartDt     : $("#dpStartDt").val()
                    , dpEndDt       : $("#dpEndDt").val()
                    , newDpCloDt    : $.fn.ifvmIsEmpty($('#newDpCloDate').val()) ? '' : $('#newDpCloDate').val() + ' ' + $('#newDpCloTime').val()
                    , apctPosblNum  : $("#apctPosblNum").val()
                    , contsSeq      : $("#contsSeq").val()
                    , contsLoadSeq  : $("#contsLoadSeq").val()
                    , hpage         : $("#hpage").val()
                    , evNo          : $("#evNo").val()

                    , imgSize       : $("#activeImg #imgSize").val()
                    , imgCnt        : $("#activeImg #imgCnt").val()
                    , imgId         : $('#activeImg #imgId').val()
                    
                    , subImgSize    : $("#subImage #imgSize").val()
                    , subImgId      : $('#subImage #imgId').val()
                }, function(result) {
                    if (web.previewChk == false) {
                        alert('<spring:message code="M00429"/>');
                    }
                    
                    conid = result.message;
                    web.detail = true;
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
    
    getChnlTypeCode();
    
    // 게시유형
    $.fn.ifvmSetSelectOptionCommCode("pstngTypeCd", "COUPON_TYPE", null, null, true);
    
    // 제휴사
    $.fn.ifvmSetSelectOptionCommCode("attrib08", "CPRT_TYPE_CD", null, null, false);

    // 작성가이드 
    var limitStore;
    
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
        groupCode : 'MKT_CAM_CHNL_LIMITE'
        , enableNA : true
    }, function(result) {
        var text = "L" + chnlCode;
        var size = result.rows.length
        
        //각 LMS,SMS 등에 맞는 용량 가져오기.
        for (var i = 0 ; i < size ; i++) {
            if (result.rows[i].codeName == text) {
                limitStore = result.rows[i].attrib01;
            }
        }
    });
    
    if (limitStore != null) {
        $(".description_guide").children().text(chnlCode + ' <spring:message code="M00452"/> '+  limitStore + "Byte" +' <spring:message code="M00453"/>')
    }
    else {
        $(".description_guide").children().text('');
    }
    
    // validation 
    web.webValidation = $('#webFormNewDiv').ifvValidation();
}

/**
 * 달력 초기 설정
 * 
 * @returns
 */
function setWebFormCalendar() {

    //기간 
    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
    
    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});
    
    //New표시 마감일시
    $("#newDpCloDate").ifvDateChecker({});
    $('#newDpCloTime').timepicker({
        showMeridian: false,
        showSeconds: true,
    });
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
    
    startDate.removeClass('ifv_vali_wrong');
    
    if ( $.fn.ifvmIsNotEmpty(startDate.val()) && $.fn.ifvmIsNotEmpty(endDate.val()) ) {
        if (startDate.val() > endDate.val()) {
            validFailMessage(startDate, '<spring:message code="C00043"/>');
            rtnFlag = false;
        }
    }
    return rtnFlag;
}

/**
 * 이미지 정보 셋팅 
 */
function setMultiImageInfo() {

    // 비활성 이미지
    if (web.subImgYN == 'Y') {
        $('#subImage #imgId').val(imgData.imgId);
        $("#subImage #mmsImage").attr('src', imgData.imgFullPath);
        $('#subImage .image_close').show();
    }
    // 활성이미지
    else {
        $('#activeImg #imgId').val(imgData.imgId);
        $("#activeImg #mmsImage").attr('src', imgData.imgFullPath);
        $('#activeImg .image_close').show();
    }
}

//채널 유형 조회
function getChnlTypeCode() {
    // Test 발송을 위한 mms/sms/push 구분
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
                    web.exeContype = result.rows[i].codeId;
                    chnlCode = result.rows[i].codeName;
                    $('#chnlTitleArea').text(result.rows[i].markName);
                }
            }
            else {
                // 상세 페이지 일 시
                if (web.exeContype != null) {
                    if (web.exeContype == result.rows[i].codeName) {
                        chnlCode = result.rows[i].codeName;
                        $('#chnlTitleArea').text(result.rows[i].markName);
                    }
                }
            }
        }
    });
}
$(document).ready(function() {
    
    // 화면 초기 설정
    initSetting();
    
    // 달력 초기 설정
    setWebFormCalendar();
    
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
    
    // 개인화 버튼 숨김
    $('#uploadPersnalTypeBtn').hide();

    //활성이미지 초기화
    $("#activeImg #image_remove").on('click', function(){
        $('#activeImg #mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
        imgId = '';
        $("#activeImg #imgCnt").val(0);
        $("#activeImg #imgId").val('');
        $(this).hide();
    });
    //비활성이미지 초기화
    $("#subImage #image_remove").on('click', function(){
        $('#subImage #mmsImage').attr('src', '<ifvm:image name="photo_def"/>');
        imgId = '';
        $("#subImage #imgCnt").val(0);
        $('#subImage #imgId').val('');
        $(this).hide();
    });

    //팝업창에서 활성이미지 선택, 업로드 완료 후 적용시 $('.image_close').show();
    $('#activeImg #mmsImage').on('click', function() {
        $("#webImgPop").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="MKTAddImagePop"/>',
            contentType: "ajax",
            title: '<spring:message code="M00797"/>',
            width: 870,
            close : 'mmsFormNewPopClose',
            open: function (args) {
                multiImagePage = true;
                web.subImgYN = 'N';
            }
        });
    });
    //비활성이미지 선택
    $('#subImage #mmsImage').on('click', function() {
        $("#webImgPop").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="MKTAddImagePop"/>',
            contentType: "ajax",
            title: '<spring:message code="M00797"/>',
            width: 870,
            close : 'mmsFormNewPopClose', 
            open: function (args) {
                multiImagePage = true;
                web.subImgYN = 'Y';
            }
        });
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

<script id="LimitPopTemplete" type="text/ifvGrid-tmpl">
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
            <button class="btn btn-sm" id='saveBtn'>
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00280"/>
            </button>
        </div>
    </div>
</div>

<div class="half_wrap top_well" id="webFormNewDiv">
    <div class="half_content half_left">
        <div class="form-horizontal underline top_well">
            <div class="row qt_border">     
                <%-- 컨텐츠명 --%>
                <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00376"/></label>    
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="text" required="true" id="contentsName" names="contentsName" maxLength="50"/>
                </div>
            </div>
            <div class="row qt_border">           
                <%-- 제목 --%>
                <label class="col-xs-3 control-label"><spring:message code="M00377"/></label>    
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="title" names="title" maxLength="100" rows="2"/>
                </div>
            </div>
            <div class="row qt_border">       
                <%-- 목록 슬로건 --%>
                <label class="col-xs-3 control-label"><spring:message code="M02720"/></label>
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="attrib03" names="attrib03" maxLength="150" rows="3"/>
                </div>
            </div>
            <div class="row qt_border">
        
                <%-- 상세 슬로건 --%>
                <label class="col-xs-3 control-label"><spring:message code="M02721"/></label>
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="attrib09" names="attrib09" maxLength="100" rows="3"/>
                </div>
            </div>
            <div class="row qt_border">
            
                <%-- 상세설명 --%>
                <label class="col-xs-3 control-label"><spring:message code="M02345"/></label>    
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="description" names="description" maxLength="2000" rows="5"/>
                </div>
            </div>
            <div class="row qt_border">
            
                <%-- 주의사항 --%>
                <label class="col-xs-3 control-label"><spring:message code="M02348"/></label>    
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="contsAttenMtr" names="contsAttenMtr" maxLength="1000" rows="3"/>
                </div>
            </div>
            <div class="row qt_border">
            
                <%-- 이용 문의 --%>
                <label class="col-xs-3 control-label"><spring:message code="M02351"/></label>    
                <div class="col-xs-8 control_content">
                    <ifvm:inputNew type="textarea" id="inqrNo" names="inqrNo" maxLength="1000" rows="3"/>
                </div>
            </div>
	        <div class="row qt_border">
	   
	            <%-- 홈페이지 --%>
	            <label class="col-xs-3 control-label"><spring:message code="M01800"/></label>
	            <div class="col-xs-8 control_content">
	                <ifvm:inputNew type="text" id="hpage" names="hpage" maxLength="100"/>
	            </div>
	        </div>
	        <div class="row qt_border">
	        
	       		<%-- 채널 가이드 --%>
            	<label class="col-xs-3 control-label"><spring:message code="M00400"/></label>
            	<div class="col-xs-8 control_content">
            		<ifvm:inputNew type="textarea" id="chnlGuide" names="chnlGuide" rows="5" readonly="true"/>
        		</div>
        	</div>
        </div>
    </div>
    
    <div class="half_content half_right">
        
        <%-- 이미지 --%>
        <div class="row qt_border content_textImage_con">
        
            <%-- 활성 이미지 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02501"/></label>
            <div class="col-xs-4 control_content" id="activeImg">
                <div class="imageBox">
                    <div class="image_img">
                        <div class="image_close remove_image" id="image_remove">
                            <img src="<ifvm:image name='photo_close'/>"/>
                        </div>
                        <img src="<ifvm:image name='photo_def'/>" id="mmsImage"/>
                    </div>
                    <ifvm:inputNew type="hidden" id="imgCnt" />
                    <ifvm:inputNew type="hidden" id="imgSize" />
                    <ifvm:inputNew type="hidden" id="imgId" />
                </div>
            </div>
            
            <%-- 비활성 이미지 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02502"/></label>
            <div class="col-xs-4 control_content" id="subImage">
                <div class="imageBox">
                    <div class="image_img">
                        <div class="image_close remove_image" id="image_remove">
                            <img src="<ifvm:image name='photo_close'/>"/>
                        </div>
                        <img src="<ifvm:image name='photo_def'/>" id="mmsImage"/>
                    </div>
                    <ifvm:inputNew type="hidden" id="imgCnt" />
                    <ifvm:inputNew type="hidden" id="imgSize" />
                    <ifvm:inputNew type="hidden" id="imgId" />
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 게시유형 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02359"/></label>
            <div class="col-xs-4">
                <ifvm:inputNew type="select" id="pstngTypeCd" names="pstngTypeCd"/>
            </div>
            
            <%-- 제휴사 --%>
            <label class="col-xs-2 control-label"><spring:message code="L00919"/></label>
            <div class="col-xs-4 end_date">
                <ifvm:inputNew type="select" id="attrib08" names="attrib08"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 기간 --%>
            <label class="col-xs-2 control-label"><spring:message code="M00607"/></label>
            <div class="col-xs-4 start_date">
                <ifvm:inputNew type="date" id="dpStartDt" names="dpStartDt"/>
            </div>
            <label class="col-xs-2 control-label" style="text-align: center; padding-left: 0px; padding-right: 0px; "> ~ </label>
            <div class="col-xs-4 end_date">
                <ifvm:inputNew type="date" id="dpEndDt" names="dpEndDt"/>
            </div>
        </div>
        <div class="row qt_border">
    
            <%-- New 표시 마감일시 newDpCloDt --%>
            <label class="col-xs-2 control-label"><spring:message code="M02346"/></label>
            <div class="col-xs-4 control_content" style="padding:0px">
                <ifvm:inputNew type="date" id="newDpCloDate"/>
            </div>
            <div class="col-xs-3 control_content" style="padding:0px">
                <ifvm:inputNew type="time" id="newDpCloTime" />
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 순서 --%>
            <label class="col-xs-2 control-label"><spring:message code="M01972"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="contsSeq" names="contsSeq"/>
            </div>
            
            <%-- 부하순서 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02349"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="contsLoadSeq" names="contsLoadSeq"/>
            </div>
        </div>
        <div class="row qt_border">
    
            <%-- 응모 가능 수 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02347"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="number" className="text-right" id="apctPosblNum" names="apctPosblNum"/>
            </div>
    
            <%-- 이벤트 번호 --%>
            <label class="col-xs-2 control-label"><spring:message code="L01048"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="evNo" names="evNo"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- Only You Y/N --%>
            <label class="col-xs-2 control-label"><spring:message code="M02353"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="checkbox" id="attrib04"/>
            </div>
            
            <%-- Hot 기능 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02354"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="checkbox" id="attrib05"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- Highlight In Pad --%>
            <label class="col-xs-2 control-label"><spring:message code="M02355"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="checkbox" id="attrib06"/>
            </div>
            
            <%-- 프로모션 Y/N --%>
            <label class="col-xs-2 control-label"><spring:message code="M02356"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="checkbox" id="attrib07"/>
            </div>
        </div>

        <div class="row qt_border"><div class="col-xs-12">&nbsp;</div></div>

    </div>
</div>

<div id="webImgPop"></div>