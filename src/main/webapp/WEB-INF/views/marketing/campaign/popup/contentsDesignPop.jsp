<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loadContentsPopup;
var campaignContents = {};

var loadContentCheck = false;

//contentsDesignPopInit
function contentsDesignPopInit() {
    cDialog.model.title = '<spring:message code="M02495"/>';
    $("#dialog_title").append('<spring:message code="M02495"/>');
    //cDialog.model.width = "1030";
    cDialog.model.close = "closeContentsDesignPop";
    
    // 실행일시 등록여부
    // 멀티스테이지 일 경우와 상위 노드가 일정이 아닐 경우만
    var parNode = getSourceNodeData(diagram._selectedObject.nodeName);
    if (getCampaignTypeCode() == "MULTISTAGE" && parNode.nodeType != "SCHEDULE") {
    	$("#chnlExeDtArea").show();
    	contentsDesignPopCalendarSet();
    } else {
    	$("#chnlExeDtArea").hide();
    }
}

/**
 * 달력
 */
function contentsDesignPopCalendarSet() {
    var exeDdDate = $('#chnlExeDtArea #exeDt');
    exeDdDate.val($.ifvGetTodayDate());
    exeDdDate.ifvDateChecker({});

    $('#chnlExeDtArea #exeTm').timepicker({
        showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1,
    });
}

//contentsDesignPopInitData
function contentsDesignPopInitData() {
    campaignContents = {};

    /* var data = diagram._selectedObject.data.campaignContents;
    if ($.fn.ifvmIsNotEmpty(data)) {
        campaignContents = data;
    } else {
        diagram._selectedObject.data.campaignContents = {};
    } */

    //캠페인 기본정보와 연결이 되어있는지 확인
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    if (isNotEmpty(campaignInfo)) {
        
        //캠페인 ID
        campaign.id = campaignInfo[0].addInfo.actualTaskId;

        //컨텐츠 폼 불러오기
        loadContentsDesign();
    }
    else {
        alert('<spring:message code="C00148"/>');

        //close popup
        closeContentsDesignPop();

        return false;
    }
}

//컨텐츠 목록 조회 클릭 시 수행
function changeContents(data) {
    var url = data.path;
    var contentType = data.contentsTypeCode;
    var i = url.split("/");
    var fileName = i[i.length-1];
    fileName = fileName.split('.')[0];
    url = '/marketing/content/load/' + fileName + "?id=" + data.id + '&type=' + data.contentsTypeCode + '&openType=WF';

    var openflag = true;

    // 오퍼 관련 - 캠페인 워크플로우 일 경우만 (캠페인 내 채널중 오퍼 다중 등록 방지)
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignOfferCount"/>', {campaignId: campaign.id, contentsId: data.id},
    function (result) {
        if (result > 0) {
             $.ifvSyncPostJSON('<ifvm:action name="getCampaignLoadOfferCount"/>', {campaignId: campaign.id, chnnelTypeCode: contentType, contentsId: data.id},
             function (result) {
                 if (result > 0) {
                     openflag = false;
                 }
             });
        }
    });

    if (openflag) {
        var obj = $.ifvCachedHtml(url);
        $('#contentsDesignCon').html(obj.responseText);
        contentsLoadUiSetting();

        //컨텐츠 신규로 등록
        detail = false;

        loadPopupClose();
    } else {
        alert("캠페인 채널 중 이미 다른 오퍼가 등록되어 있습니다.")
    }
}

//dialog close
function closeContentsDesignPop(args) {
    cDialog._destroy();
}

//load시 필요없는 항목 제거
function contentsLoadUiSetting(){
    $('#contentsDesignCon .page-title').remove();
    $("#saveBtn").hide();
    $("#btnList").hide();
    $('#contentsDesignCon .page_btn_area:first').css({'border-top':'0'});
    $('#contentsDesignCon .well').css({'margin-bottom':'0','border-bottom':'0'});
}

//컨텐츠 채널/유형에 따른 폼 불러오기
function loadContentsDesign(){
    var chnnelType = diagram._selectedObject.nodeType;

    var contentsId = null;
    //call 캠페인 컨텐츠 채널 관계
    var id = diagram._selectedObject.actualTaskId;
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignContentsChnnelRel"/>', {
        id: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            campaignContents = result;
            contentsId = result.contentsId;
            
            // 실행일시 설정
            if (getCampaignTypeCode() == "MULTISTAGE") {
            	if ($.fn.ifvmIsNotEmpty(result.exeDt)) {
            		var exeDt = result.exeDt.substring(0, 4) + "-" + result.exeDt.substring(4, 6) + "-" + result.exeDt.substring(6, 8);
            		$("#exeDt").val(exeDt);
            	}
            	
            	if ($.fn.ifvmIsNotEmpty(result.exeTm)) {
            		var exeTm = result.exeTm.substring(0, 2) + ":" + result.exeTm.substring(2, 4);
            		$("#exeTm").val(exeTm);
            	}
            }
        }
    });
    
    //노드 유형별 contents 폼 호출
    var url = "";
    $.ifvSyncPostJSON('<ifvm:action name="getChannelByCodeName"/>',{
        type : chnnelType
    }, function(result) {
            
        //채널이 있는지 검색
        if ($.fn.ifvmIsNotEmpty(result)) {
            //채널 폼 url
            url = result.path;
            if ($.fn.ifvmIsNotEmpty(url)) {
                var i = url.split("/");
                var fileName = i[i.length-1];
                fileName = fileName.split('.')[0];
                url = '${pageContext.request.contextPath}/marketing/content/load/' + fileName + '?chnl=' + chnnelType +'&id='+contentsId +'&openType=WF' ;
            }
        }
    });

    //채널 유형
    $("#chnlType").val(chnnelType);
    //폼 호출
    if (url != "") {
        var obj = $.ifvCachedHtml(url);
        $('#contentsDesignCon').html(obj.responseText);
        contentsLoadUiSetting();
    }
    else {
         alert('<spring:message code="M00504"/>');

         //close popup
         cDialog.destroy();
    }
}

//컨텐츠 저장
function contentsDesignSave(type) {
    //버튼 비활성화
    //$('#contentsDesignSaveBtn').attr('disabled', true);
    //form 저장 버튼 클릭
    var exeDt = $("#exeDt").val().replaceAll("-", "");
    var exeTm = null;
    
	if ($("#exeTm").val() != "") {
		exeTm = $("#exeTm").val().replaceAll(":", "") + "00";
	}

    
    $("#saveBtn").trigger("click");
    //저장 후 컨텐츠 아이디 확인
    var contentsId = conid;
    if ($.fn.ifvmIsNotEmpty(contentsId) && contentsId != "null") {
        campaignContents.id = diagram._selectedObject.actualTaskId;
        campaignContents.contentsId = contentsId;
        campaignContents.campaignId = campaign.id;
        if(diagram._selectedObject.nodeType == 'SMS'){
            campaignContents.chnnelTypeCode =chnlCode
        } else {
            campaignContents.chnnelTypeCode = diagram._selectedObject.nodeType;
        }
        campaignContents.dataStatus = getTaskStatusCode(campaignContents);
        if(diagram._selectedObject.nodeType == 'SMS'){
            diagram._selectedObject.taskType = chnlCode
        } else {
            diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
        }
        diagram._selectedObject.data.campaignContents = campaignContents;
        diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignContents);
        
        campaignContents.exeDt = exeDt;
    	
    	if (exeTm != null) {
    		campaignContents.exeTm = exeTm;
    	}

        //call 캠페인 컨텐츠 채널 관계 저장
        $.ifvSyncPostJSON('<ifvm:action name="saveCampaignContentsChnnelRel"/>',
            campaignContents,
        function(result) {
            //set actual task ID
            diagram._selectedObject.actualTaskId = result.message;

            //set campaign ID
            diagram._selectedObject.campaignId = campaign.id;

            //set old campaign ID
            diagram._selectedObject.oldCampaignId = campaign.id;

            //set alertFlag(현재 팝업에서 저장 alert창이 발생하여 중복 발생하지 않기 위해..)
            workflow.alertFlag = false;
            //save workflow
            saveWorkflow();
        });
    }

    //버튼 활성화
    //$('#contentsDesignSaveBtn').attr('disabled', false);
    checkClickBtn = 0;
}

//컨텐츠 불러오기
function loadContentsBtn() {
    $("#loadContentsPopupDialog").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="MKTContentsListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M00371"/>',
        width: 1000,
        close : 'loadPopupClose',
        open : function(){
			new ifvm.PopupCenter({
				popupDivId : 'dialog'
			});
//             //set dialog popup height
//             new ifvm.PopupHeight({
//                 popupDivId : 'loadContentsPopupDialog',
//                 contentsId : 'contentsListArea'
//             });

//             new ifvm.PopupCenter({
//                 popupDivId : 'loadContentsPopupDialog'
//             });

//             //set dialog popup height
//             new ifvm.PopupHeight({
//                 popupDivId : 'dialog',
//                 contentsId : 'dialogPopupWrap'
//             });

//             //set dialog popup center
//             new ifvm.PopupCenter({
//                 popupDivId : 'dialog'
//             });
        }
    });

    loadContentsPopup = $("#loadContentsPopupDialog").data("ejDialog");
}

/* 팝업 닫기 */
function loadPopupClose() {
	loadContentsPopupDialog._destroy();

    //set dialog popup height
    new ifvm.PopupHeight({
        popupDivId : 'dialog',
        contentsId : 'dialogPopupWrap'
    });

    //set dialog popup center
    new ifvm.PopupCenter({
        popupDivId : 'dialog'
    });
}

var uploadPersnalTypePopup;

/**
 * 개인화 업로드 팝업
 */
function uploadPersnalTypePopOpen() {
    var _chnnelType = diagram._selectedObject.nodeType;
    var _id = diagram._selectedObject.actualTaskId;
    
    if ( $.fn.ifvmIsNotEmpty(_id) == true ) {
        uploadPersnalTypePopup = $("#uploadPersnalTypePopup").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="persnalTypePop"/>',
            contentType: "ajax",
            title: '<spring:message code="M00371"/>',
            width: 400,
            open: function() {
                persanlPop_getInitData(_chnnelType, _id);
            },
            close : 'uploadPersnalTypePopClose'
        });
    }
    else {
        alert('<spring:message code="M02363"/>');
    }
}

/**
 * 개인화 업로드 팝업 종료
 */
function uploadPersnalTypePopClose() {
    uploadPersnalTypePopup.ejDialog('destroy');
}

$(function () {
    contentsDesignPopInit();
    contentsDesignPopInitData();

    //컨텐츠 불러오기 시 실행
    $('#loadContentsBtn').on('click', function(){
        loadContentsBtn();
    });

    //신규 작성 클릭시
//     $('#contentsDesignNewBtn').on('click', function(){
//         loadContentsDesign();
//     });
    
    //개인화 업로드
    $('#uploadPersnalTypeBtn').on('click', function(){
        uploadPersnalTypePopOpen();
    });

    //저장 클릭시(컨텐츠 폼은 저장 후 팝업을 닫지 않는다.)
    $('#contentsDesignSaveBtn').on('click', function(){
        if(checkClickBtnFunc()){
            contentsDesignSave();
        }
    });

    //Draft 클릭시(컨텐츠 폼은 저장 후 팝업을 닫지 않는다.)
    $('#contentsDesignDraftBtn').on('click', function(){
        contentsDesignSave();
    });

    //취소 클릭시
    $('#contentsDesignCancelBtn').on('click', function(){
        closeContentsDesignPop();
    });

});
</script>

<div id="dialogPopupWrap">
    <input type="hidden" id=chnlType value="">
    <input type="hidden" id="contentsType" value="">
    <input type="hidden" id="campaignWorkflowFlag" value="true">

    <div class="pop_inner_wrap form-horizontal">
		<div class="page_btn_area" >
            <label class="col-xs-2 control-label" style="text-align: left;">
                <spring:message code="M00821"/></label>
            <div class="col-xs-2">
                <button class="btn_Load" id="loadContentsBtn">
                    <img src="<ifvm:image name='ico_search'/>" alt="" />
                    <spring:message code="M00613"/>
                </button>
                <%-- 개인화 업로드 버튼 contentsDesignNewBtn --%>
                <button class="btn_Load" id="uploadPersnalTypeBtn">
                    <spring:message code="M02343"/>
                </button>
            </div>
            <div id="chnlExeDtArea" style="display:none;">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>실행일시</label>
			<div class="col-xs-2">
				<ifvm:input type="date" required="true" id="exeDt" />
			</div>
			<div class="col-xs-2 control_content" style="padding:0px">
				<ifvm:inputNew type="time" required="true" id="exeTm" />
			</div>
			</div>
			
			<div id="chnlExeDtArea" style="display:none;">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>실행일시</label>
			<div class="col-xs-2">
				<ifvm:input type="date" required="true" id="exeDt" />
			</div>
			<div class="col-xs-2 control_content" style="padding:0px">
				<ifvm:inputNew type="time" required="true" id="exeTm" />
			</div>
			</div>
			
			<div id="chnlExeDtArea" style="display:none;">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>실행일시</label>
			<div class="col-xs-2">
				<ifvm:input type="date" required="true" id="exeDt" />
			</div>
			<div class="col-xs-2 control_content" style="padding:0px">
				<ifvm:inputNew type="time" required="true" id="exeTm" />
			</div>
			</div>
		</div>
    </div>
    <div class="row " id="contentsDesignCon">
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="contentsDesignSaveBtn" objCode="contentsDesignSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- <button class="btn btn-sm btn_gray" id="contentsDesignDraftBtn">
            <spring:message code="M00775"/>
        </button> --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="contentsDesignCancelBtn" objCode="contentsDesignCancelBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="loadContentsPopupDialog" class="popup_container"></div>
<div id="uploadPersnalTypePopup" class="popup_container"></div>