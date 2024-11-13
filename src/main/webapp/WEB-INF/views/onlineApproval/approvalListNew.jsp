<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!-- <style>
#paymentAccordion .border_bottom_zero {border-bottom: 0px}
</style> -->

<script>

    var approvedRequestListGrid2;
    var approvedReference;
    var approvalDialog;
    var rejectId;
    var rowId;
    var itemStatus;
    var searchType = null;
    var doubleSubmitFlag = false;
    var empType;


    function accordionSetting() {
        $("#paymentAccordion").ejAccordion({collapsible: true});
        $("#paymentAccordion").width('inherit');
    }

    function AprvstatusUI(dataid) {
        $("#approvalProgressArea").empty()
        $.ifvSyncPostJSON('<ifvm:action name="getApproverStatus"/>', {
            id: dataid
        }, function (result) {

            var temp = $("#approvalProgressStatus").tmpl(result);
            $("#approvalProgressArea").append(temp);
        });
        $("#approvalProgressWrap").show();

    }


    //등록화면 팝업
    function popupUiSetting() {
        $(".page_hidden").remove();
        $("#approvalPopup .btn").remove();
        $(".page_border").css({"border-top": "0"});
        $("#approvalBasicInfo input").attr("disabled", "disabled");
        $("#approvalBasicInfo select").attr("disabled", "disabled");
        $("#approvalBasicInfo textarea").attr("disabled", "disabled");
        $("#approvalContents").addClass("disabledDiv");
    }

    /* 팝업 닫기 */
    function popupClose() {
        empRefPopupCon._destroy();
    }

    function previewCampaignPopupOpen(strId) {
        $("#empRefPopupCon").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="campaignReportPop"/>?id=' + strId,
            contentType: "ajax",
            title: '<spring:message code="M00392"/>',
            width: '1050px',
            maxHeight: null,
            close: 'popupClose',
        });
    }

    /**
     * 결제라인화면 로드
     */
    function loadPop(strId, campaignId, text) {
        $("#empRefPopupCon").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="approvalLineInfoPop"/>?id=' + strId + "&type=" + text + '&campaignId=' + campaignId,
            contentType: "ajax",
            title: '<spring:message code="M00392"/>',
            width: '1500px',
            height: '700px',
            close: 'popupClose'
        });
    }


    function fnPreview2() {
        var url;

        var checkedList = approvedRequestListGrid2.opt.gridControl.getSelectedRecords();

        if (checkedList.length == 0) {
            alert('<spring:message code="L00066"/>');
        } else if (checkedList.length > 1) {
            alert('<spring:message code="V00204"/>');
        } else if (checkedList.length == 1) {

            switch (checkedList[0].aprvType) {
                case '01' :
                    previewCampaignPopupOpen(checkedList[0].recordRid);
                    break;
                case '02' :
                    url = '<ifvm:url name="previewManualDetailPop"/>' + '?rid=' + checkedList[0].recordRid;
                    fnPreviewPopupOpen(url);
                    break;
                case '03' :
                    url = '<ifvm:url name="previewBatchRgstDetailPop"/>' + '?rid=' + checkedList[0].recordRid;
                    fnPreviewPopupOpen(url);
                    break;
                case '05' :
                    var recordRid = checkedList[0].recordRid.split('/');
                    url = '<ifvm:url name="previewSettleDetailPop"/>' + '?actYearMonth=' + recordRid[0] + '&actnum=' + recordRid[1];
                    fnPreviewPopupOpen(url);
                    break;
                case '06' :
                    url = '<ifvm:url name="previewUnRgstCardDetailPop"/>' + '?rid=' + checkedList[0].recordRid;
                    fnPreviewPopupOpen(url);
                    break;

                case '07' :
                    url = '<ifvm:url name="previewUnRgstCardUploadDetail"/>' + '?rid=' + checkedList[0].recordRid;
                    fnPreviewPopupOpen(url);
                    break;
                default :
                    break;
            }
        }
    }

    function fnPreviewPopupOpen(url) {
        previewPopup = {
            id: "previewPopup"
        };

        previewPopup.popup = function () {
            previewPopup.pop = $('#' + previewPopup.id).ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: url,
                contentType: "ajax",
                title: '<spring:message code="L01442"/>',
                width: '1024px',
                close: previewPopup.close
            });
        };

        previewPopup.beforeClose = function (obj) {
        };

        previewPopup.close = function (obj) {
            previewPopup._destroy();
        };

        previewPopup.popup();
    }

    //승인대기목록
    function approvedRequestList2() {
        var ejGridOption = {
            rowSelected: function (args) {
//             rejectId = args.data.id
            },
            recordDoubleClick: function (row) {
                var selData = row.data;
                loadPop(selData.id, selData.recordRid, 'aprv');
            },
            serializeGridData: function (data) {
                if (requestitem != null && requestitem.length > 0) {
                    data.item = requestitem;
                }
                return data;
            },
            dataUrl: '<ifvm:action name="getMyElapproval2"/>',
            columns: [
                {
                    field: 'elecAprvTypeCd', headerText: '<spring:message code="L01434"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'elecAprvTypeCode'
                    }/* */
                }, {
                    field: 'dispNo', headerText: '<spring:message code="캠페인코드"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'c.DISP_NO', searchable: true
                    }/* */
                }, {
                    field: 'campaignStartDate', headerText: '<spring:message code="캠페인 시작일"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'c.CAM_START_DD', searchable: true
                    }/* */
                },/*{
                    field: 'elecAprvNo', headerText: '<spring:message code="문서번호"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'a.elec_aprv_no', searchable: true
                    }/!* *!/
                }, */{
                    field: 'elecAprvTitle', headerText: '<spring:message code="캠페인명"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'a.elec_aprv_title', searchable: true
                    }/* */
                }, {
                    field: 'elecAprvRqtrId', headerText: '<spring:message code="L01437"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'e.name'
                    }/* */
                }, {
                    field: 'createDate', headerText: '<spring:message code="L01438"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'a.create_date'
                    }/* */
                }, {
                    field: 'elecAprvStatusCd', headerText: '<spring:message code="L01439"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'elecAprvStatusCode'
                    }/* */
                }, {
                    field: 'lastApvrId', headerText: '<spring:message code="L01440"/>', headerTextAlign: 'center',
                    customAttributes: {
                        index: 'g.name'
                    }/* */
                },/*{
	      		  field : 'lastApvDd', headerText : '<spring:message code="L01441"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'f.apv_dd' }/!* *!/
	      	  },*/{
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'a.id'
                    }/* */
                }, {
                    field: 'aprvType', headerText: 'aprvType', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'a.elec_aprv_type_cd'
                    }/* */
                }, {
                    field: 'recordRid', headerText: 'recordRid', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'a.cam_id'
                    }/* */
                }, {
                    field: 'itemId', headerText: 'itemId', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'h.id'
                    }/* */
                }, {
                    field: 'seq', headerText: 'seq', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'h.elec_aprv_seq'
                    }/* */
                }, {
                    field: 'apvrTypeCd', headerText: 'apvrTypeCd', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'h.apvr_type_cd'
                    }/* */
                }
            ],
            requestGridData: {
                nd: new Date().getTime(),
                rows: 10,
                sidx: 'a.modify_date',
                sord: 'desc',
                _search: false
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            multiselect: true,
            tempId: 'ifvGridOriginTemplete',
        };
        approvedRequestListGrid2 = $("#approvedRequestListGrid2").ifvsfGrid({ejGridOption: ejGridOption});
    }


    //팝업 닫기
    function approvalPopupClose() {
        approvalPopup._destroy();
    }

    function Aprvcount() {

        $.ifvSyncPostJSON('<ifvm:action name="getMyAgreeCount"/>', {}, function (result) {
            $("#aprvReq2").text(result.aprvReq);
        });

        /* $.ifvSyncPostJSON('








        <ifvm:action name="getMyAprvCount"/>', {
    }, function(result) {
        $("#aprvReq").text(result.aprvReq)
        $("#aprvLastReq").text(result.lastApvrReq)
    }); */

    }


    function fnReject() {

        var checkedList = approvedRequestListGrid2.opt.gridControl.getSelectedRecords();
        if (checkedList.length === 1) {
            rejectId = checkedList[0].id;
        } else {
            rejectId = null;
        }

        if (rejectId == null) {
            alert('<spring:message code="M00499"/>');
        } else {
            $("#approvalPopup").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="refusalPop"/>?id=' + rejectId,
                contentType: "ajax",
                title: '<spring:message code="M00978"/>',
                width: '340px',
                close: 'approvalPopupClose'
            });
        }
    }


    $(document).ready(function () {
        approvedRequestList2();
        //$.ifvmLnbSetting('approvalListNew');
        //var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');

        //accordionSetting();
        //approvedRequestList();

        //Aprvcount();

        /*  $("#divApproval").on('click', function(){
             approvedRequestList();
         });
         $("#divApproval2").on('click', function(){
             approvedRequestList2();
         }); */

        //필수 영역 공통 호출
        /*
            $("#authGroupSearchBtn").on('click', function(){
                $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedRequestList);
                $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedRequestList2);
                $.fn.ifvmSubmitSearchCondition("channelRequiredList", approvedReferenceList);
            });
            $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);

            $("#authGroupinitBtn").on('click', function(){
                $.fn.ifvmSetCommonCondList("channelRequiredList",LeftMenuId);
            });

            $("#newApproval").on("click", function(){
                qtjs.href('








        <ifvm:url name="approvalDetail"/>');
    });

    $("#companionBtn").on("click", function(){

    }); */

        function deleteList(fromTbl, toTbl) {
            var active = 0;
            var checkedList = contentSearchResult.opt.gridControl.getSelectedRecords();
            var listFlowIdList = [];
            if (checkedList.length != 0) {
                for (var i = 0; i < checkedList.length; i++) {
                    listFlowIdList.push(checkedList[i].id);
                }
                $.ifvSyncPostJSON('<ifvm:action name="removeContent"/>', {
                    lisContentFlowId: listFlowIdList
                }, function (result) {
                    alert('<spring:message code="M00012"/>');
                    contentSearchResult.searchGrid();
                });
            } else {
                alert('<spring:message code="M00285"/>');
            }
        }


    });


    function doubleSubmitCheck() {
        if (doubleSubmitFlag) {
            return doubleSubmitFlag;
        } else {
            doubleSubmitFlag = true;
            return false;
        }
    }


    function offerCheckFun() {
        var camid = approvedRequestListGrid2.opt.gridControl.getSelectedRecords()[0].recordRid;
        var camTypeData = approvedRequestListGrid2.opt.gridControl.getSelectedRecords()[0].campaignTypeCode;
        var offerSendCheckStatus = approvedRequestListGrid2.opt.gridControl.getSelectedRecords()[0].offerCheckTypeCd;

        var rtnCheck = false;
        var rtnMessage = "";

        if (offerSendCheckStatus != "ALL" && offerSendCheckStatus != "SPART") {
            //오퍼 발급 완료 체크
            $.ifvSyncPostJSON('<ifvm:action name="getOfferDataCheck"/>', {
                id: camid
                // , offerId: offerIdData
                // , offerTypeCodeName: offerTypeData
                , campaignTypeCode: camTypeData
            }, function (result) {
                rtnCheck = true;
                rtnMessage = result.message;
            }, function (result) {
                rtnCheck = false;
                rtnMessage = result.message;
            });
        } else {
            rtnCheck = true;
            rtnMessage = 'S';
        }

        return [rtnCheck, rtnMessage];
    }

    //캠페인 완료(활성)
    function setCampaignCompleted(_offerChk) {
        var dataList = approvedRequestListGrid2.opt.gridControl.getSelectedRecords();
        var camChk = true;
        if (dataList.length != 0) {
            var data = dataList[0];
            //CampaignId
            var id = data.recordRid;
            var camStatusCd = data.campaignStatusCode;

            // 캠페인 작성중 여부 확인
            if (camStatusCd == "W") {
                // 외부고객 / PUSH 인경우 기획완료 처리 안됨
                $.ifvSyncPostJSON('<ifvm:action name="getTgtChnlChk"/>', {
                    id: id
                }, function (result) {
                    for (var i = 0; i < result.chnlTypeCdList.length; i++) {
                        if (result.exeChnlTypeCd == "external" && result.chnlTypeCdList[i] == "PUSH") {
                            alert('<spring:message code="M01851" />');
                            camChk = false;
                            break;
                        } else {
                            camChk = true;
                        }
                    }
                });

                if (camChk == true) {

                    var offerCheckFlag = offerCheckFun();
                    if (offerCheckFlag[0]) {
                        // 장용 - 캠페인 상태 체크
                        $.ifvSyncPostJSON('<ifvm:action name="setCampaignComplete"/>', {
                                id: id
                            }, function (result) {

                                if (result.message == '1') {
                                    //오퍼유형이 [모바일 쿠폰]인 경우에는 전송 채널 중에 MMS만 연결이 가능합니다. [기획완료 및 실행]를 진행 할 수 없습니다.
                                    alert("<spring:message code='M01386' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '2' || result.message == '13') {
                                    //캠페인 승인이 완료되지 않았습니다. [기획완료 및 실행]를 진행 할 수 없습니다.
                                    alert("<spring:message code='M01387' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '3') {
                                    //선택한 캠페인에 연결된 노드가 있으나, 등록된 정보가 없어 캠페인 기획완료를 진행 할 수 없습니다. 해당 노드를 삭제하거나, 노드의 정보를 저장 후 진행 바랍니다.
                                    alert("<spring:message code='M01392' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '5') {
                                    //해당 캠페인은 일정을 등록해야 실행 할 수 있습니다.
                                    alert("<spring:message code='M01786' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '4') {
                                    alert("해당 캠페인은 채널을 등록해야 실행 할 수 있습니다.");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '6') {
                                    //해당 캠페인은 일정을 등록할 수 없습니다.
                                    alert("<spring:message code='M02479' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '7') {
                                    //해당 캠페인은 선행 캠페인을 등록해야 실행 할 수 있습니다.
                                    alert("<spring:message code='M02480' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '8' || result.message == '10') {
                                    //해당 캠페인은 오퍼를 등록해야 실행할 수 있습니다.
                                    alert("<spring:message code='M02478' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '9') {
                                    //해당 캠페인은 프로모션 상세 정보를 등록해야 실행할 수 있습니다.
                                    alert("<spring:message code='M02481' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '11') {
                                    //해당 캠페인은 대상자를 등록해야 실행할 수 있습니다.
                                    alert("<spring:message code='M02482' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '12') {
                                    //해당 캠페인은 대상자를 등록할 수 없습니다.
                                    alert("<spring:message code='M02483' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '98') {
                                    //실행권한이 없습니다.
                                    alert("<spring:message code='M02497' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '99') {
                                    //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
                                    alert("<spring:message code='M02157' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '17') {
                                    //캠페인 채널별 일정 체크
                                    alert("<spring:message code='M02912' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '18') {
                                    //오퍼가 포인트쿠폰일때 캠페인기본정보 필수값 체크
                                    alert("<spring:message code='M02913' />");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '19') {
                                    //실행 일정 체크시 실행 불가
                                    alert("결재가 승인 되었지만, 매장 캠페인 예약시간이 현재시간 이전입니다.\n캠페인 예약시간 변경 후, 다시 실행해 주세요.");
                                    $.ifvProgressControl(false);
                                } else if (result.message == '20') {
                                    //템플릿 복사시 타겟팅 활성 문제(데상트는 매장의 경우에 쿼리 재생성이 필요함)
                                    alert("캠페인 상세정보의 타겟팅 노드에서 대상자 저장 후\n 일정을 확인해 주세요.");
                                    $.ifvProgressControl(false);
                                } else {
                                    //저장되었습니다.
                                    alert("최종 결재자 승인으로 인해 매장 캠페인이 정상적으로 활성화 되었습니다.\n일정에 맞춰 캠페인이 실행 될 예정입니다.");
                                    $(".campaign_order").empty();
                                    $.ifvProgressControl(false);
                                }
                            }
                            , function (result) {
                                if (result.message == '97') {
                                    alert('<spring:message code="M02768" />');
                                }
                                $.ifvProgressControl(false);
                            });
                    } else {
                        if (offerCheckFlag[1] == '0') {
                            alert('쿠폰/포인트 발급이 진행 중 입니다.\n잠시 후 다시 시도해주세요.');
                        } else if (offerCheckFlag[1] == '1') {
                            alert('쿠폰/포인트 발급 요청을 진행 하신 후 다시 시도해주세요.');
                        } else if (offerCheckFlag[1] == '99') {
                            alert('쿠폰/포인트가 정상적으로 발급되지 않았습니다.\n 관리자에게 문의해주세요.');
                        } else {
                            alert('예상치 못한 에러가 발생하였습니다. 관리자에게 문의해주세요.')
                        }
                    }
                }
            }
        }
    }


    // 승인
    function fnApprove() {
        var checkedList = approvedRequestListGrid2.opt.gridControl.getSelectedRecords();

        if (checkedList.length != 0) {

            if (confirm('승인하시겠습니까?')) {

                if (doubleSubmitCheck()) return;

                var active = 0;
                var listFlowIdList = [];
                var err = 0;
                var suc = 0;

                $.ifvProgressControl(true);
                $.ifvSyncPostJSON('<ifvm:action name="editReject"/>', {
                    apvDd: '1',
                    id: checkedList[0].id,
                    statusCode: '014',
                    itemId: checkedList[0].itemId,
                    aprvType: checkedList[0].aprvType,
                    elecAprvStatusCd: '090',
                    recordRid: checkedList[0].recordRid,
                    seq: checkedList[0].seq,
                    approvalTypeCd: checkedList[0].apvrTypeCd
                    , apvrId: checkedList[0].itemId
                    , checkseq: checkedList[0].seq
                    , elecAprvId: checkedList[0].id
                    , elecAprvEmpNo: checkedList[0].elecAprvEmpNo
                    , elecAprvTitle: checkedList[0].elecAprvTitle
                }, function (result) {
                    setTimeout(function () {
                        Aprvcount();
                    }, 100);
                    suc = suc + 1;
                }, function (result) {
                    setTimeout(function () {
                        Aprvcount();
                    }, 100);
                });

                var empType = checkedList[0].elecAprvType;
                var camEmpType = checkedList[0].camPlnerType;

                //최종 승인자일 때
                if (checkedList[0].apvrTypeCd == '9') {

                    //결재 완료
                    $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
                        elecAprvStatusCd: '090'
                        , id: checkedList[0].id
                        , aprvType: checkedList[0].aprvType
                        , recordRid: checkedList[0].recordRid
                    }, function (result) {
                        setTimeout(function () {
                            Aprvcount();
                            if (camEmpType != 'H') {
                                setCampaignCompleted("");
                            }
                        }, 100);

                    });
                }

                setTimeout(function () {

                    alert('<spring:message code="L02923"/>');

                    setTimeout(function () {
                        $.ifvProgressControl(false);
                        $.ifvReload();
                    }, 100);

                }, 100);

                doubleSubmitFlag = false;
            }
        } else {
            alert('<spring:message code="M00285"/>');
        }
    }

</script>

<script id="channelListDateTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2 cal_frt start_date">
    <ifvm:input type="date"/>
</div>
<div class="col-xs-1 swung_dash">~</div>
<div class="col-xs-2 cal_scd end_date">
    <ifvm:input type="date"/>
</div>









</script>

<script id="channelListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select"/>
</div>









</script>

<script id="approvalProgressStatus" type="text/x-jquery-templ">
<div class="progress_item">
{{if
statusCode == '021'}}
<div class="progress_item red">
{{/
if}}
{{if
statusCode != '021'}}
<div class="progress_item blue">
{{/
if}}
    <div class="wrap_border">
        <div class="inner_bg">
            <span class="inner_text">${'${'}apprvType}</span>
        </div>
        {{if
apprvCode == '1'}}
            <span class="icon_area write"></span>
        {{/
if}}
        {{if
apprvCode != '1'}}
            <span class="icon_area"></span>
        {{/
if}}
    </div>
    <p class="txt_progress">${'${'}elApproveStatus}</p>
    <p class="txt_name">${'${'}apprvName}</p>
    <p class="txt_date">${'${'}apvDd}</p>
</div>
</div>











</script>

<div class="page-title">
    <h1>
        <spring:message code="승인 대기 목록"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>
<div id="TierLimitForm">
    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code="L01833"/></span>
            </div>
            <div class="col-sm-5 searchbtn_r">
                <%--     <ifvm:inputNew type="button" btnType="select" text="L02449" id="previewBtn2" btnFunc="fnPreview2" objCode="approvalListNewPreview_OBJ"/> --%>
                <ifvm:inputNew type="button" btnType="select" text="L01444" id="approveBtn" btnFunc="fnApprove"
                               objCode="approvalListNewApprov_OBJ"/>
                <ifvm:inputNew type="button" btnType="select" text="L01445" id="rejecthBtn" btnFunc="fnReject"
                               objCode="approvalListNewReject_OBJ"/>
            </div>
        </div>
        <div id="approvedRequestListGrid2" class="white_bg grid_bd0"></div>

        <!-- </div> -->

        <%--  <!-- 내가 승인 요청한 캠페인 -->
         <h3 id="divApproval" >
             <a href="#">
                 <spring:message code="L01834"/>
                 (
                 <spring:message code="M00962"/> : <span id="aprvReq"></span><spring:message code="M00964"/>,
                 <spring:message code="M00963"/> : <span id="aprvLastReq"></span><spring:message code="M00964"/>
                 )
             </a>
         </h3>
         <div  class="well form-horizontal well_sum">
             <div class="campaign_load_contents">
                 <div class="page_btn_area border_bottom_zero">
                     <div class="col-xs-7">
                         <span><spring:message code="L01834"/></span>
                     </div>
                     <div class="col-xs-5 searchbtn_r">
                         <ifvm:inputNew type="button" btnType="select" text="L01443"  id="allSearchBtn"  btnFunc="fnAllSearch" />
                         <ifvm:inputNew type="button" btnType="select" text="L02449"  id="previewBtn" btnFunc="fnPreview" />
                     </div>
                 </div>
                 <div id="approvedRequestListGrid"></div>
             </div>
         </div> --%>
    </div>
</div>

<div id="empRefPopupCon" class="popup_container"></div>
<div id="approvalPopup" class="popup_container"></div>
<div id="previewPopup" class="popup_container"></div>
<div id="testPopup" class="popup_container"></div>