<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
    var campaignTempPop = {
        tempid: ''
    };

    //템플릿 노드 리스트
    function campaignTemplateSelect() {

        //초기화
        $("#campaignSelectArea").empty();

        //선택된 유형값
        var camTypeCd = $("#campaignTypeCd option:selected").val();

        //선택된 목적값
        var camPrpsCd = $("#campaignPurposeCd option:selected").val();

        //캠페인 유형선택이 안되있을 경우 조회조건을 null이 아닌 공백으로
        if (!camTypeCd) {
            camTypeCd = "";
        }
        //캠페인 목적 선택이 안되있을 경우 조회조건을 null이 아닌 공백으로
        if (!camPrpsCd) {
            camPrpsCd = "";
        }

        $.ifvSyncPostJSON('<ifvm:action name="getTemp"/>',
            {
                camTypeCd: camTypeCd,
                camPrpsCd: camPrpsCd,
                empId: this.empId,
                authType: this.authType,
                empType: empType,
                brandCd: this.brandCd
            },
            function (result) {
                $(result.rows).each(function (index, item) {
                    var temp = $("#campaignSelectTemplate").tmpl(item);
                    $("#campaignSelectArea").prepend(temp);

                    new ifvm.PopupHeight({
                        popupDivId: 'dialog',
                        contentsId: 'dialogPopupWrap'
                    });
                });
            }
        );

        tempPopupHeight();
    }

    function getCampaignStatusList2(id) {

        //초기화
        $("#campaignTempSelectedFlow").empty();

        //start temp
        var temp = $("#campaignStatusStartTemp2").tmpl();
        $("#campaignTempSelectedFlow").append(temp);

        //status temp
        var firstLoad = true;	//제목,설명, 기본 셋팅은 한번만
        $.ifvSyncPostJSON('<ifvm:action name="getTempNodeList"/>',
            {tempMstId: id},
            function (result) {
                $(result.rows).each(function (index, item) {
                    if (firstLoad == true) {

                        $("#taskTitle").text(item.taskTitle);
                        $("#taskDesc").text(item.taskDesc);
                        $("#camTypeCd").text(item.camTypeCd);
                        firstLoad = false;
                    }

                    temp = $("#campaignStatusTemp2").tmpl(item);
                    $("#campaignTempSelectedFlow").append(temp);
                });
            }
        );

        //end temp
        temp = $("#campaignStatusEndTemp2").tmpl();
        $("#campaignTempSelectedFlow").append(temp);

        tempPopupHeight();
    }

    function tempPopupHeight() {
        new ifvm.PopupHeight({
            popupDivId: 'dialog',
            contentsId: 'campaignTemplatePop'
        });

        new ifvm.PopupCenter({
            popupDivId: 'dialog'
        });
    }

    //신규 캠페인 워크플로우
    function newCampaign() {
        campaignTempPopClose();
        var url = '<ifvm:url name="campaignWorkFlow"/>?type=' + strType;
        qtjs.href(url);

    }

    //템플릿 선택 워크플로우 이동
    function templateSelect() {

        var camId = campaignTempPop.camid;
        var copyCamId = "";
        if ($.fn.ifvmIsEmpty(camId)) {
            alert('템플릿을 선택해 주세요');
        } else {

            $.ifvSyncPostJSON('<ifvm:action name="callProcCamCopy"/>',
                {
                    id: camId,
                    empId: empId,
                    planOrgCode: $.ifvmGetUserInfo().orgId,
                    planOrgCodeName: $.ifvmGetUserInfo().orgName
                },
                function (result) {
                    //
                    copyCamId = result.message;
                }, function (result) {
                    alert(result.message);
                }
            );

            if ($.fn.ifvmIsNotEmpty(copyCamId)) {
                var url = '<ifvm:url name="campaignWorkFlow"/>?id=' + copyCamId + '&type=' + strType;
                qtjs.href(url);
            } else {
                alert("<spring:message code='M02733' />");
            }

            campaignTempPopClose();
        }
    }

    //템플릿 선택
    function selectTemp(args) {
        $(".campaign_temp_box").removeClass("on");
        $("#" + args.id).addClass("on");

        campaignTempPop.tempid = args.getAttribute("workflowid");
        campaignTempPop.camid = args.getAttribute("camid");

        // $("#campaignSelectedTemplate").show();
        getCampaignStatusList2(args.id);
    }

    $(document).ready(function () {

        campaignTemplateSelect();

        //캠페인유형
        $.fn.ifvmSetSelectOptionCommCode("campaignTypeCd", "MKT_CAM_TYPE_CD");
        $('#campaignTypeCd option:eq(0)').text('전체')
        //검색
        $("#searchTemp").on("click", function () {
            $(".campaign_temp_box").removeClass("selected_title_area");

            $(".campaignSelectedTemplatex").removeClass("on");
            $("#campaignSelectedTemplate").hide();
            campaignTemplateSelect();
        });

        //신규작성
        $("#campaignWorkflowNew").on("click", function () {
            newCampaign();
        });

        //선택
        $("#campaignTemplateSelect").on("click", function () {
            templateSelect();
        });

        //취소
        $("#campaignTemplateCancel").on("click", function () {
            campaignTempPopClose();
        });


    });
</script>

<script id="campaignSelectTemplate" type="text/x-jquery-tmpl">
<div class="campaign_temp_box" id="${'${'}tempMstId}" workflowid="${'${'}workflowId}" camid="${'${'}campaignId}" onclick="selectTemp(this)" ondblClick="templateSelect()">
	<p class="template_title" >${'${'}taskTitle}</p>
	<span class="campaign_type">${'${'}camTypeCdName}</span>
</div>

</script>

<script id="campaignStatusTemp2" type="text/x-jquery-tmpl">
<li class="campaign_circle btn_incomplete" >
    <div class="circle_area" taskTypeCode="${'${'}taskTypeCode}">
        <span>${'${'}nodeTypeCodeName}</span>
    </div>
</li>

</script>

<script id="campaignStatusStartTemp2" type="text/x-jquery-templ">
<li class="btn_edge first">
    <i class="start"></i>
	<span><spring:message code="M00742"/></span>
</li>

</script>

<script id="campaignStatusEndTemp2" type="text/x-jquery-templ">
<li class="btn_edge">
    <i class="end"></i>
	<span><spring:message code="M00750"/></span>
</li>

</script>

<div id="campaignTemplatePop">
    <div class="pop_inner_wrap">
        <div class="group_box_bg row">
            <label class="col-xs-1 control-label"><spring:message code="M00755"/></label>
            <div class="col-xs-3">
                <ifvm:input type="select" id="campaignTypeCd" names="campaignTypeCd"/>
            </div>
            <div class="col-xs-4">
                <button class="inner_btn" id="searchTemp">
                    <spring:message code="M00757"/>
                </button>
            </div>
        </div>
        <div class="campaign_template_select">
            <div class="temp_title">
                <spring:message code="M00759"/>
                <span class="temp_title_detail"><spring:message code="M00760"/></span>
            </div>
            <div class="">
                <div class="group_box_bg temp_select_area" id="campaignSelectArea">

                </div>
                <div class="group_box_line selected_info_area" id="campaignSelectedTemplate">
                    <div class="selected_title_area">
                        <p class="campaign_title ellipsis" id="taskTitle"></p>
                        <p class="campaign_desc ellipsis" id="taskDesc"></p>
                    </div>
                    <span class="campaign_type" id="camTypeCd"></span>
                    <span class="campaign_name"></span>
                    <span class="campaign_time"></span>
                    <div class="campaign_temp_wrap">
                        <ol class="campaign_order sm_camp_order" id="campaignTempSelectedFlow">

                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="campaignTemplateSelect" objCode="campaignTemplateSelect_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M03026"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="campaignWorkflowNew" objCode="campaignWorkflowNew_OBJ">
            <img src="<ifvm:image name='ico_write'/>" alt=""/>
            <spring:message code="M00758"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="campaignTemplateCancel" objCode="campaignTemplateCancel_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>