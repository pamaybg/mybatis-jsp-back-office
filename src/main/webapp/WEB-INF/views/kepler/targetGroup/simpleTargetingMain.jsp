<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
    simpleTargetingMain = function () {
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

    // 목록 팝업 열기
    simpleTargetingMain.prototype.simpleTargetingListPopupOpen = function () {
        $("#simpleTargetingListPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="simpleTargetingListPopup"/>',
            contentType: "ajax",
            title: '<spring:message code="M01494"/>',
            width: 800,
            close: 'simpleTargetingMain.simpleTargetingListPopupClose'
        });
    }

    //팝업 닫기
    simpleTargetingMain.prototype.simpleTargetingListPopupClose = function () {
        simpleTargetingListPopup._destroy();
    }

    // 선택시
    simpleTargetingMain.prototype.simpleTargetingSelect = function () {
        var _this = this;

        _this.simpleTargetingListPopupClose();

        if ($.fn.ifvmIsNotEmpty(simpleListPopGrid.getCheckedList())) {
            var targetGroupId = simpleListPopGrid.getCheckedList()[0].targetGroupId;   //타겟그룹 아이디

            // 상세화면 Load
            _this.simpleTargetingDetailLoad(targetGroupId);
        }
    }

    // 상세화면 기존 Load
    simpleTargetingMain.prototype.simpleTargetingDetailLoad = function (targetGroupId) {

        //main화면 숨김
        $("#simpleTargetingMain_top").hide();

        //content 화면 보이기
        $("#simpleTargetingMain_con").show();

        // 상세화면 Load
        $.fn.ifvmLoadUiSetting("simpleTargetingMain_con", '<ifvm:url name="simpleTargetingDetailLoad"/>' + '?targetGroupId=' + targetGroupId);

        //저장 버튼 추가
        var tmpl = $("#simpleTargetingMainSaveBtnTemp").tmpl();
        $("#simpleTargetingDetailBtn_area").append(tmpl);

        //버튼 회색으로
        $("#simpleTargetingMain_con .btn").addClass("btn_gray");

        $('#simpleTargetingSave').hide();

        $("#simpleTargetingMainSaveBtn").on("click", function () {
            simpleTargetingMain.campaignTargetGroupSave();
        });
        $('#segmentList').off();
        $('#segmentList').on("click", function () {
            simpleTargetingMain.simpleTargetingMainLoad();
        });

        if (this.saveBtnHide) {
            $("#simpleTargetingMainSaveBtn").hide();
        }
    }

    //조회시 목록화면 Load
    simpleTargetingMain.prototype.simpleTargetingMainLoad = function () {
        //content 화면 숨기기
        $("#simpleTargetingMain_con").hide();
        $("#simpleTargetingMain_con").html("");
        //main화면 보이기
        $("#simpleTargetingMain_top").show();

    }

    //캠페인  저장
    simpleTargetingMain.prototype.campaignTargetGroupSave = function () {
        saveCampaignTarget();
    }

    var simpleTargetingMain;
    $(document).ready(function () {
        simpleTargetingMain = new simpleTargetingMain();

        $("#simpleTargetingListPopupBtn").on("click", function () {
            simpleTargetingMain.simpleTargetingListPopupOpen();
        });

        $("#simpleOpenBtn").on("click", function () {
            simpleTargetingMain.simpleTargetingDetailLoad('');
        });
    });


</script>

<script id="simpleTargetingMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="simpleTargetingMainSaveBtn">    
	<i class="glyphicon glyphicon-check"></i>     
	<spring:message code="M00280"/>
</button>

</script>

<style>
    html, body {
        background: #fff;
    }
</style>

<div id="simpleTargetingMain_wrap">
    <div id="simpleTargetingMain_top">
        <div class="page_btn_area">
            <div class="col-xs-12">
                <span><spring:message code="M02499"/></span>
            </div>
        </div>
        <div class="user_main_area">
            <div class="main_area main1">
                <p class="user_txt user_tit"><spring:message code="M02981"/></p>
                <p class="user_txt user_desc"><spring:message code="M02983"/></p>
                <button class="user_btn_list" id="simpleTargetingListPopupBtn">
                    <spring:message code="M02985"/>
                </button>
            </div>
            <div class="main_area main2" id="newSimpleTarget">
                <p class="user_txt user_tit"><spring:message code="M02982"/></p>
                <p class="user_txt user_desc"><spring:message code="M02984"/></p>
                <button class="user_btn_list" id="simpleOpenBtn">
                    <spring:message code="M02986"/>
                </button>
            </div>
        </div>
    </div>
    <div class="well form-horizontal well_wrap pad0" id="simpleTargetingMain_con">
    </div>
</div>

<div id="simpleTargetingListPopup" class="popup_container"></div>