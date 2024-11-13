<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
    var targetImportMain;

    targetImportMain = function () {
        this.saveBtnHide = false;

        var flag;
        try {
            flag = workflowFlag
        } catch (exception) {
            flag = false
        }

        if (flag) {
            this.saveBtnHide = true;
        }
    }
    //목록 팝업 열기
    targetImportMain.prototype.targetImportListPopupOpen = function () {
        $("#importListPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="importListPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M01494"/>',
            width: 800,
            close: 'targetImportMain.importListPopupClose'
        });
    }

    /**
     * 타겟Import 목록 팝업 닫기
     */
    targetImportMain.prototype.importListPopupClose = function () {
        importListPopup._destroy();
    }

    //선택시
    targetImportMain.prototype.importListSelect = function () {
        var _this = this;

        _this.importListPopupClose();

        if ($.fn.ifvmIsNotEmpty(importListPopGrid.getCheckedList())) {
            var targetGroupId = importListPopGrid.getCheckedList()[0].targetGroupId;   //타겟그룹 아이디

            // 상세화면 Load
            _this.targetImportDetailLoad(targetGroupId);
        }
    }

    /**
     * Import 상세 화면 Load
     */
    targetImportMain.prototype.targetImportDetailLoad = function (targetGroupId) {

        //main화면 숨김 & content 화면 보이기
        $("#uploadMainArea").hide();
        $("#uploadBodyArea").show();

        /*     //타겟그룹 상세화면 Load
            var url  = '
        <ifvm:url name="importTargetingDetailLoad"/>';
    var paramArry = new Array();
    if ($.fn.ifvmIsNotEmpty(targetImportId)) {
     	paramArry.push('targetingId=' + targetImportId);
    }
    if ($.fn.ifvmIsNotEmpty(callType)) {
        paramArry.push('type=COPY');
    }
    if ($.fn.ifvmIsNotEmpty(camId)) {
        paramArry.push('campaignId=' + camId);
    }
    url += "?" + paramArry.join("&");

    $.fn.ifvmLoadUiSetting("uploadBodyArea", url); */

        // 상세화면 Load
        // $.fn.ifvmLoadUiSetting("uploadBodyArea", '<ifvm:url name="importTargetingDetailLoad"/>' + '?targetGroupId=' + targetGroupId);
        $.fn.ifvmLoadUiSetting("uploadBodyArea", '<ifvm:url name="targetImportDetailLoad"/>?targetGroupId=' + targetGroupId);
        //저장 버튼 추가
        var tmpl = $("#targetImportMainSaveBtnTemp").tmpl();
        $("#targetGroupImportDetailBtn_area").append(tmpl);

        //버튼 회색으로
        $("#uploadBodyArea .btn").addClass("btn_gray");

        $("#saveTargetGroupImportBtn").hide();

        $("#targetImportMainSaveBtn").on("click", function () {
            targetImport.segId = tgtId;
            targetImport.camId = camId;
            targetImportMain.campaignTargetImportSave();
        });
        $('#targetGroupListBtn').off();
        $('#targetGroupListBtn').on("click", function () {
            targetImportMain.targetImportLoad();
        });

        if (this.saveBtnHide) {
            $("#targetImportMainSaveBtn").hide();
        }
    }

    /**
     * 타겟 Import 저장
     */
    targetImportMain.prototype.campaignTargetImportSave = function () {
        saveCampaignTarget();
    }

    /**
     * 타겟 Import 메인화면 로드
     */
    targetImportMain.prototype.targetImportLoad = function () {
        $("#uploadBodyArea").hide();
        $("#uploadBodyArea").html("");

        $("#uploadMainArea").show();
    }

    /**
     * 매장일 때 심플타겟팅 생성 숨기기
     */
    function newFileUpload() {
        $("#newFileUpload").hide();
        $("#newFileUpload").html("");
    }

    $(document).ready(function () {
        if (empType == "S") {
            newFileUpload();
        }
        targetImportMain = new targetImportMain();

        //Import 불러오기 팝업 오픈 버튼
        $("#importListOpenBtn").on("click", function () {
            targetImportMain.targetImportListPopupOpen();
        });

        //Import 버튼
        $("#importNewPageOpenBtn").on("click", function () {
            targetImportMain.targetImportDetailLoad('');
        });

    });

</script>

<script id="targetImportMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="targetImportMainSaveBtn">
	<i class="glyphicon glyphicon-check"></i>
	<spring:message code="M00280"/>
</button>

</script>

<div id="uploadMainArea">
    <div class="page_btn_area">
        <div class="col-xs-12">
            <span><spring:message code="S00009"/></span>
        </div>
    </div>
    <div class="user_main_area">
        <div class="main_area main1">
            <p class="user_txt user_tit"><spring:message code="M02444"/></p>
            <p class="user_txt user_desc"><spring:message code="M02446"/></p>
            <button class="user_btn_list" id="importListOpenBtn" objCode="importListOpenBtn_OBJ">
                <spring:message code="M02448"/>
            </button>
        </div>
        <div class="main_area main2" id="newFileUpload">
            <p class="user_txt user_tit"><spring:message code="M02445"/></p>
            <p class="user_txt user_desc"><spring:message code="M02447"/></p>
            <button class="user_btn_list" id="importNewPageOpenBtn" objCode="importNewPageOpenBtn_OBJ">
                <spring:message code="M02436"/>
            </button>
        </div>
    </div>
</div>

<div id="uploadBodyArea"></div>
<div id="importListPopup" class="popup_container"></div>
