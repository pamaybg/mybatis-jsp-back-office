<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="ynTemplate">
	{{if
promYn == 1 }}
		Y
	{{else}}
		N
	{{/
if}}



</script>

<script>

    var strType = '';

    var campaignListGrid = null;
    var cDialog;
    var selectChk = false;

    var campaign = {
        id: "",
        selRow: ""
    };

    //노드 체크 변수
    var fbChk = false;
    var instaChk = false;
    var offerChk = false;
    var targetChk = false;
    var scheduleChk = false;
    var delChk = false;
    //페이스북 포스팅을 위한 appId
    var appId = "";

    //권한
    var empId = '';
    var empType = '';
    var authType = '';
    var divRid = '';
    var brandCd = '';
    var workFlowChecklist = new Array();

    //캠페인 목록
    function getCampaignList() {

        var ejGridOption = {
            rowSelected: function (args) {
                selectChk = true;
                if (args.data.campaignTypeCode == 'QUICK') {
                    //진행현황 비활성
                    $(".campaign_order").html("");
                    //실행버튼 비활성
                    $("#campaignRunBtn").hide();
                } else if (args.data.type == 'STN') {
                    //진행현황 비활성
                    $(".campaign_order").html("");
                } else {
                    //실행버튼 활성
                    $("#campaignRunBtn").show();

                    //버튼 활성 설정
                    setBtnActive(args.data.campaignStatusCode);
                    setApprBtnActive(args.data.campaignApprovalStatusCode);

                    //진행현황 활성
                    getCampaignStatusList(args.data.id);
                }
                getAppIdAndInitSDK(args.data.id);
            },
            recordDoubleClick: function (args) {
                var data = args.data;
                if (data.campaignTypeCode == 'QUICK') {
                    $(".campaign_order").empty();
                    qtjs.href('<ifvm:url name="quickCampaign"/>' + '?id=' + data.id);
                } else if (data.type == 'STN') {
                    $(".campaign_order").empty();
                    qtjs.href('<ifvm:url name="stnCampaignDetail"/>' + '?id=' + data.id);
                } else {
                    goCampaignWorkflow(data.id);
                }

            },
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                if ($.fn.ifvmIsNotEmpty(strType)) {
                    data.type = strType;
                }
                return data;
            },
            dataUrl: '<ifvm:action name="getCampaignList"/>',
            columns: [
                {
                    //field : 'dispNo', headerText : '<spring:message code="L00417"/>', headerTextAlign : 'center', width : '90px' , textAlign : ej.TextAlign.Center ,
                    field: 'dispNo', headerText: '번호', headerTextAlign: 'center', width: '90px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c.DISP_NO', searchable: true
                    }/*캠폐인번호 */
                }, {
                    field: 'campaignTypeCodeName', headerText: '<spring:message code="M00598"/>', headerTextAlign: 'center', width: '90px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c8.MARK_NAME'
                    }/*유형 */
                }, {
                    field: 'campaignName', headerText: '<spring:message code="M00592"/>', headerTextAlign: 'center', width: '220px',
                    //field : 'campaignName', headerText : 'Rule', headerTextAlign : 'center', width : '220px' ,
                    customAttributes: {
                        index: 'c.CAM_NM', searchable: true
                    }/*캠폐인명 */
                }, {
                    field: 'concatChnlType', headerText: '<spring:message code="M00402"/>', headerTextAlign: 'center', width: '100px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                         searchable: false, sortable: false
                    }/*발송채널 */
                }, {
                    field: 'recentSendDt', headerText: '<spring:message code="M03095"/>', headerTextAlign: 'center', width: '100px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        searchable: false, sortable: false
                    }/*최근 발송일시 */
                }
                <%--{--%>
                <%--    field: 'campaignStartDate', headerText: '<spring:message code="M00593"/>', headerTextAlign: 'center', width: '80px', textAlign: ej.TextAlign.Center,--%>
                <%--    customAttributes: {--%>
                <%--        index: 'c.CAM_START_DD', searchable: true--%>
                <%--    }/*시작일 */--%>
                <%--}, {--%>
                <%--    field: 'campaignEndDate', headerText: '<spring:message code="M00594"/>', headerTextAlign: 'center', width: '80px', textAlign: ej.TextAlign.Center,--%>
                <%--    customAttributes: {--%>
                <%--        index: 'c.CAM_END_DD'--%>
                <%--    }/* 종료일*/--%>
                <%--}--%>
                , {
                    field: 'campaignStatusCodeName', headerText: '<spring:message code="M00595"/>', headerTextAlign: 'center', width: '60px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c2.MARK_NAME', searchable: true
                    }/*상태*/
                }, {
                    field: 'campaignApprovalStatusCodeName', headerText: '<spring:message code="M03042"/>', headerTextAlign: 'center', width: '60px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c9.MARK_NAME'
                    }/*결재상태*/
                }
                , {
                    field: 'offerCheckTypeName', headerText: '오퍼상태', headerTextAlign: 'center', width: '80px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c14.MARK_NAME'
                    }/*쿠폰&포인트 발급여부*/
                }
                , {
                    field: 'planOrgCodeName', headerText: '<spring:message code="M00558"/>', headerTextAlign: 'center', width: '80px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'd1.div_nm', searchable: true
                    }/*소속*/
                },
// 	      	  {
// 	      		  field : 'campaignApprovalStatusCodeName', headerText : '<spring:message code="M00974"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c9.MARK_NAME' }/*승인진행상태 */
// 	      	  },
// 	      	  {
// 	      		  field : 'camScopeTypeNm', headerText : '<spring:message code="M02304"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c10.MARK_NAME' }/*캠페인 범위 */
// 	      	  },
                {
                    field: 'campaignPlannerName', headerText: '<spring:message code="M03096"/>', headerTextAlign: 'center', width: '100px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'mo.NAME', searchable: true
                    }/*요청자 */
                },
// 	      	  {
// 	      		  field : 'planOrgCodeName', headerText : '<spring:message code="M00597"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'd1.div_nm' }/*부서 */
// 	      	  },
//	      	  {
//	      		  field : 'offerName', headerText : '<spring:message code="M01870"/>', headerTextAlign : 'center',width : '150px' ,
//	      		  customAttributes : {
//	      			  index : 'o.OFFER_NM' }/*오퍼 */
//	      	  },
// 	      	  {
// 	      		  field : 'description', headerText : '<spring:message code="M00600"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c.CAM_DESC' }/*비고 */
// 	      	  },
                {
                    field: 'campaignTypeCode', headerText: 'typeCode', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'c8.CODE_NAME'
                    }
                }
                , {
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'c.id'
                    }
                }, {
                    field: 'type', headerText: 'type', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'c.type'
                    }
                }, {
                    field: 'campaignApprovalStatusCode', headerText: 'campaignApprovalStatusCode', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'c9.CODE_NAME'
                    }
                }
            ],
            requestGridData: {
                empId: empId,
                authType: authType,
                brandCd: brandCd,
                nd: new Date().getTime(),
                rows: 10,
                sidx: 'c.create_date',
                sord: 'desc',
                _search: false
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridOriginTemplete'
        };
        campaignListGrid = $("#campaignListGrid").ifvsfGrid({ejGridOption: ejGridOption});

        if (campaign.selRow != "") {
            $("#gridIdcampaignListGrid").setSelection(campaign.selRow, true);
            campaign.selRow = "";
        }
    }

    function approvalRequestFun() {
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        if (dataList.length != 0) {
            if (workFlowChecklist.indexOf('INFO') == -1) {
                alert("기본 정보를 등록해주세요.");
                return;
            }
            if (workFlowChecklist.indexOf('TARGET') == -1) {
                alert("타겟팅을 등록해주세요.");
                return;
            }
            if (workFlowChecklist.indexOf('SCHEDULE') == -1) {
                alert("일정을 등록해주세요.");
                return;
            }

            if (workFlowChecklist.length < 4) {
                if (workFlowChecklist.indexOf('CHNL') == -1) {
                    alert("발송채널을 등록해주세요.");
                    return;
                } else {
                    alert("결재할 수 없는 캠페인 입니다. 관리자에게 문의해주세요.");
                    return;
                }
            }

            $("#approvalPop").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="approvalPopCam"/>',
                contentType: "ajax",
                title: "승인",
                width: 1024,
                close: 'approvalPopClose'
            });

        } else {
            alert("<spring:message code='M01018' />");
        }
    }

    function approvalPopClose() {
        approvalPop._destroy();
        getCampaignList();

    }

    //버튼 활성 설정
    function setBtnActive(type) {
        //작업중
        if (type == "W") {
            $("#campaignCompletedBtn").removeAttr('disabled');
            $("#campaignRemoveBtn").removeAttr('disabled');
            $("#campaignStopBtn").attr('disabled', true);
            $("#approvalRequestBtn").removeAttr('disabled');
            $("#cpnPointBtn").attr('disabled', true);
            $("#campaignCompletedBtn").attr('disabled', true);
        }

        //활성
        else if (type == "A") {
            $("#campaignCompletedBtn").attr('disabled', true);
            $("#campaignRemoveBtn").attr('disabled', true);
            $("#campaignStopBtn").removeAttr('disabled');
            //$("#approvalRequestBtn").attr('disabled', true);
            $("#campaignCompletedBtn").attr('disabled', true);
            $("#cpnPointBtn").attr('disabled', true);
        }
        //그외
        else {
            $("#campaignCompletedBtn").attr('disabled', true);
            $("#campaignRemoveBtn").attr('disabled', true);
            $("#campaignStopBtn").attr('disabled', true);
            //$("#approvalRequestBtn").attr('disabled', true);
            $("#campaignCompletedBtn").attr('disabled', true);
            $("#cpnPointBtn").attr('disabled', true);
        }
    }

    //버튼 승인 활성 설정
    function setApprBtnActive(type) {
        var campaignStatusCode = campaignListGrid.opt.gridControl.getSelectedRecords()[0].campaignStatusCode;

        if(type != null && campaignStatusCode == 'W'){
            $("#campaignRemoveBtn").attr('disabled', true);
        }

        if (type == "090") { //승인 완료
            if (campaignStatusCode == 'W') {
                $("#cpnPointBtn").removeAttr('disabled');
                $("#campaignCompletedBtn").removeAttr('disabled');
            }
        }
    }

    //캠페인 진행현황 목록
    function getCampaignStatusList(id) {
        workFlowChecklist = new Array();
        $.ifvPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
            campaignId: id
        }, function (result) {
            // 캠페인 진행상태 표시
            $.each(result, function (index, data) {
                if ($.fn.ifvmIsNotEmpty(data.enterTime)) {
                    data.dataInTypeClass = "btn_complete";
                    if (data.taskTypeCode == 'SMS'
                        || data.taskTypeCode == 'LMS'
                        || data.taskTypeCode == 'MMS'
                        || data.taskTypeCode == 'PUSH'
                        || data.taskTypeCode == 'EMAIL'
                        || data.taskTypeCode == 'KAKAOFR'
                        || data.taskTypeCode == 'KAKAONOTI'
                    ) {
                        if (workFlowChecklist.indexOf('CHNL') == -1) {
                            workFlowChecklist.push('CHNL');
                        }
                    } else {
                        workFlowChecklist.push(data.taskTypeCode);
                    }
                } else {
                    data.dataInTypeClass = "btn_incomplete";
                }
                if ($.fn.ifvmIsNotEmpty(data.enterTime)) {
                    data.enterTime = $.fn.ifvmGetCalculateTime(data.enterTime);
                }
            });
            var temp = '';

            // 초기화
            $(".campaign_order").empty();
            // start temp
            temp = $("#campaignStatusStartTemp").tmpl();
            $(".campaign_order").append(temp);
            // status temp
            var temp = $("#campaignStatusTemp").tmpl(result);
            $(".campaign_order").append(temp);
            // end temp
            temp = $("#campaignStatusEndTemp").tmpl();
            $(".campaign_order").append(temp);

        });
    }

    //캠페인 워크플로우 화면 이동
    function goCampaignWorkflow(id) {
        var url = '<ifvm:url name="campaignWorkFlow"/>?type=' + strType;
        if (id != null) {
            url = url + '&id=' + id;
        }
        qtjs.href(url);
    };

    // 캠페인 취소(중단)
    function setCampaignCancel() {
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        if (dataList.length != 0) {
            if (confirm('<spring:message code="M00752" />')) {
                var data = dataList[0];
                var id = data.id;
                $.ifvSyncPostJSON('<ifvm:action name="setCampaignCancel"/>', {
                    id: id
                }, function (result) {
                    alert('<spring:message code="M00152" />');
                    getCampaignList();
                    $(".campaign_order").empty();
                });
            }
        } else {
            alert("<spring:message code='M01018' />");
        }
    }

    //캠페인 중지
    function setCampaignStop() {
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        if (dataList.length != 0) {
            var data = dataList[0];
            var id = data.id;
            var camStatusCd = data.campaignStatusCode;

            // 페이스북 및 인스타그램 채널 노드 확인 및 포스팅 삭제 확인
            fbChk = false;
            instaChk = false;
            delChk = false;

            // 페이스북 노드 체크
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
                campaignId: id
            }, function (result) {
                for (var x = 0; x < result.length; x++) {
                    if (result[x].nodeTypeCode == "FACEBOOK") {
                        fbChk = true;
                    } else if (result[x].nodeTypeCode == "INSTAGRAM") {
                        instaChk = true;
                    }
                }
            });

            // 캠페인 활성여부 확인
            if (fbChk == false && instaChk == false && camStatusCd == "A") {
                if (confirm('<spring:message code="M02155" />')) {
                    $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', {
                        id: id
                    }, function (result) {
                        alert('<spring:message code="M00152" />');
                        getCampaignList();
                        $(".campaign_order").empty();
                    }, function (result) {
                        alert("<spring:message code='I00742' />");
                    });
                }
            } else if (fbChk == true && camStatusCd == "A") {
                if (confirm('<spring:message code="M02191"/>')) {
                    // 페이스북 포스팅 삭제
                    FBDeleting(id);
                }
            } else if (instaChk == true && camStatusCd == "A") {
                if (confirm('<spring:message code="M02232"/>')) {
                    $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', {
                        id: id
                    }, function (result) {
                        alert('<spring:message code="M00152" />');
                        getCampaignList();
                        $(".campaign_order").empty();
                    }, function (result) {
                        alert("<spring:message code='I00742' />");
                    });
                }
            } else {
                alert("<spring:message code='M02156' />");
            }
        } else {
            alert("<spring:message code='M01018' />");
        }

        $.ifvProgressControl(false);
    }

    //페이스북 노드 체크, 있을 시 : 포스팅 -> 캠페인 활성화 / 없을 시 : 캠페인 활성화
    function nodeCheck() {
        $.ifvProgressControl(true);
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        var camChk = true;
        fbChk = false;
        instaChk = false;
        // 정보 노드가 존재하는가?
        var infoChk = false;

        if (dataList.length != 0) {
            var data = dataList[0];
            var id = data.id;
            var camStatusCd = data.campaignStatusCode;

            // 페이스북/인스타그램 채널이 포함된 캠페인 기획완료 시, 노드 체크
            $.ifvSyncPostJSON('<ifvm:action name="getCampaignWorkflowStatusList"/>', {
                campaignId: id
            }, function (result) {
                for (var x = 0; x < result.length; x++) {
                    if (result[x].nodeTypeCode == "INFO") {
                        infoChk = true;
                    } else if (result[x].nodeTypeCode == "FACEBOOK") {
                        fbChk = true;
                    } else if (result[x].nodeTypeCode == "OFFER") {
                        offerChk = true;
                    } else if (result[x].nodeTypeCode == "TARGET") {
                        targetChk = true;
                    } else if (result[x].nodeTypeCode == "SCHEDULE") {
                        scheduleChk = true;
                    } else if (result[x].nodeTypeCode == "INSTAGRAM") {
                        instaChk = true;
                    }
                }
            });

            if (infoChk == false) {
                camStatusCd = "N/A";
            } else if (fbChk == true && offerChk == true) {
                camStatusCd = "N/A";
            } else if (fbChk == true && targetChk == true) {
                camStatusCd = "N/A";
            } else if (fbChk == true && scheduleChk == true) {
                camStatusCd = "N/A";
            }

            if (infoChk == false && data.type != "STN") { // 캠페인 노드 정보가 존재하지 않음. = 잘못 저장된 캠페인
                //캠페인 정보가 존재하지 않습니다
                alert("<spring:message code='M02242'/>");
                $.ifvProgressControl(false);
            }
            // 페이스북 포스팅
            else if (fbChk == true && camStatusCd == "W") {
                FBPosting(camStatusCd, id);
            }
            // 활성화
            else if ((fbChk == false && instaChk == false && camStatusCd == "W") || data.type == "STN") {
                setCampaignCompleted(offerChk);
            }
            // 인스타그램 포스팅
            else if (instaChk = true && camStatusCd == "W") {
                instagramPosting(camStatusCd, id);
            } else if (fbChk == true && offerChk == true) {
                alert("<spring:message code='M02186'/>");
                $.ifvProgressControl(false);
            } else if (fbChk == true && targetChk == true) {
                alert("<spring:message code='M02187'/>");
                $.ifvProgressControl(false);
            } else if (fbChk == true && scheduleChk == true) {
                alert("<spring:message code='M02188'/>");
                $.ifvProgressControl(false);
            } else {
                //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
                alert('<spring:message code="M02157"/>');
                $.ifvProgressControl(false);
            }
        } else {
            //항목을 선택해주세요.
            alert("<spring:message code='M00499' />");
            $.ifvProgressControl(false);
        }
    }

    function getAppIdAndInitSDK(id) {
        appId = "";

        $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
            camid: id
        }, function (getResult) {

            var len = getResult == null ? 0 : getResult.length;
            for (var z = 0; z < len; z++) {
                var result = getResult[z];
                if (result.chnlTypeCd == 'FACEBOOK') {

                    conid = result.conid;
                    $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                        id: conid
                    }, function (result2) {
                        if (result2 != null) {
                            $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                                fbId: result2.snsInfo
                            }, function (result3) {
                                if (result3 != null) {
                                    appId = result3.appId;
                                    initSDK(appId);
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    function offerCheckFun() {
        var camid = campaignListGrid.opt.gridControl.getSelectedRecords()[0].id;
        var camTypeData = campaignListGrid.opt.gridControl.getSelectedRecords()[0].campaignTypeCode;
        var offerSendCheckStatus = campaignListGrid.opt.gridControl.getSelectedRecords()[0].offerCheckTypeCd;

        var offerIdData = campaignListGrid.opt.gridControl.getSelectedRecords()[0].offerId;
        var offerTypeData = campaignListGrid.opt.gridControl.getSelectedRecords()[0].offerTypeCodeName;

        var rtnCheck = false;
        var rtnMessage = "";

        if(offerSendCheckStatus != "ALL" && offerSendCheckStatus != "SPART") {
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
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        var camChk = true;

        if (dataList.length != 0) {
            var data = dataList[0];
            var id = data.id;
            var camStatusCd = data.campaignStatusCode;

            // 캠페인 작성중 여부 확인
            if (camStatusCd == "W") {
                if (confirm('<spring:message code="M00753" />')) {

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
                                        alert("캠페인 예약시간이 현재시간 이전입니다.\n캠페인 예약시간 변경 후, 다시 실행해 주세요.");
                                        $.ifvProgressControl(false);
                                    } else if (result.message == '20') {
                                        //템플릿 복사시 타겟팅 활성 문제(데상트는 매장의 경우에 쿼리 재생성이 필요함)
                                        alert("캠페인 상세정보의 타겟팅 노드에서 대상자 저장 후\n 일정을 확인해 주세요.");
                                        $.ifvProgressControl(false);
                                    } else {
                                        //저장되었습니다.
                                        alert("캠페인이 정상적으로 활성화 되었습니다.\n일정에 맞춰 캠페인이 실행 될 예정입니다.");
                                        $(".campaign_order").empty();
                                        $.ifvProgressControl(false);
                                    }
                                }
                                , function (result) {
                                    if (result.message == '97') {
                                        alert('<spring:message code="M02768" />');
                                        $.ifvProgressControl(false);
                                    }
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
                            $.ifvProgressControl(false);
                            getCampaignList();
                        }
                    } else {
                        $.ifvProgressControl(false);
                    }
                } else {
                    $.ifvProgressControl(false);
                }
            }
        } else {
            $.ifvProgressControl(false);
            alert('<spring:message code="O00066" />');
        }
        getCampaignList();
    }

    //결재요청(조건만 있음 / 수정필요)
    function setCampaignApprRequest(_offerChk) {
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        var camChk = true;

        if (dataList.length != 0) {
            var data = dataList[0];
            var id = data.id;
            var camStatusCd = data.campaignStatusCode;

            // 캠페인 작성중 여부 확인
            if (camStatusCd == "W") {
                if (confirm('<spring:message code="결재요청 하시겠습니까?" />')) {

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
                                } else {
                                    //저장되었습니다.
                                    alert('<spring:message code="M00152" />');
                                    /*getCampaignList();
                                    $(".campaign_order").empty();
                                    $.ifvProgressControl(false);*/
                                }
                            }
                            , function (result) {
                                if (result.message == '97') {
                                    alert('<spring:message code="결재요청에 실패했습니다." />');
                                    $.ifvProgressControl(false);
                                }
                            });
                    } else {
                        $.ifvProgressControl(false);
                    }
                } else {
                    $.ifvProgressControl(false);
                }
            }
        }
    }

    //페이스북 포스팅 삭제
    function FBDeleting(id) {
        var acesToken = "";
        var postId = "";

        /*
         * $.ifvSyncPostJSON('


        <ifvm:action name="getFacebookDefaultInfo"/>', { camid : id }, function(result){
     * acesToken = result.acesToken; postId = result.postId;
     * //해당 포스팅을 삭제 처리 FB.api("/"+postId,"DELETE", { "access_token" : acesToken },function(response){ if(response && !response.error){
     * alert('


        <spring:message code="M02189"/>'); delChk == true; if(confirm('


        <spring:message code="M02155"/>')){
     * $.ifvSyncPostJSON('


        <ifvm:action name="setCampaignStop"/>', { id: id }, function(result) { alert('


        <spring:message code="M00152"/>'); getCampaignList(); $(".campaign_order").empty(); }, function(result) { alert( "


        <spring:message code='I00742'/>" ); }); } }else{ alert('


        <spring:message code="M02190"/>'); } $.ifvProgressControl(false); }); });
     */

        // camid로 conid 조회 -> 변수 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
            camid: id
        }, function (getResult) {
            var len = getResult == null ? 0 : getResult.length;
            for (var z = 0; z < len; z++) {
                var result = getResult[z];
                if (result.chnlTypeCd == 'FACEBOOK') {
                    conid = result.conid;
                    $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                        id: conid
                    }, function (result2) {

                        $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                            fbId: result2.snsInfo
                        }, function (result3) {
                            acesToken = result3.acesToken;
                        });
                        postId = result2.postId;

                        // 해당 포스팅을 삭제 처리
                        FB.api("/" + postId, "DELETE", {
                            "access_token": acesToken
                        }, function (response) {
                            if (response && !response.error) {

                                alert('<spring:message code="M02189"/>');
                                delChk == true;
                                if (confirm('<spring:message code="M02155"/>')) {

                                    $.ifvSyncPostJSON('<ifvm:action name="setCampaignStop"/>', {
                                        id: id
                                    }, function (result) {
                                        alert('<spring:message code="M00152"/>');
                                        getCampaignList();
                                        $(".campaign_order").empty();
                                    }, function (result) {
                                        alert("<spring:message code='I00742'/>");
                                    });
                                }

                            } else {
                                alert('<spring:message code="M02190"/>');
                            }
                            $.ifvProgressControl(false);
                        });
                    });
                }
            }
        });
    }

    //기획완료 버튼 클릭 시, 페이스북 포스팅
    function FBPosting(camStatusCd, id) {
        var snsPageId = "";
        var appId = "";
        var appSecurCode = "";
        var acesToken = "";
        var acesExpDt = "";
        var contents = "";
        var openRange = "";
        var reservePost = "";
        var attType = "";
        var fileUrl = "";

        var numOfImages = "";
        var imageInfo = new Array();
        var imageInfoId = new Array();
        var postId = "";
        var conid = "";

        // camid로 conid 조회 -> 변수 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
            camid: id
        }, function (getResult) {

            var len = getResult == null ? 0 : getResult.length;
            for (var z = 0; z < len; z++) {
                var result = getResult[z];
                if (result.chnlTypeCd == 'FACEBOOK') {

                    conid = result.conid;
                    $.ifvSyncPostJSON('<ifvm:action name="getFacebookDtlList"/>', {
                        id: conid
                    }, function (result2) {
                        $.ifvSyncPostJSON('<ifvm:action name="getFacebookPageInfoById"/>', {
                            fbId: result2.snsInfo
                        }, function (result3) {
                            snsPageId = result3.snsPageId;
                            appId = result3.appId;
                            appSecurCode = result3.appSecurCode;
                            acesToken = result3.acesToken;
                            acesExpDt = result3.acesExpDt;
                        });

                        contents = result2.contents;
                        openRange = result2.openRange;
                        reservePost = result2.reservePost;
                        attType = result2.attType;
                        fileUrl = '<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>/' + result2.filePath + result2.fileName;

                        if (result2.imageUrl != '') {
                            numOfImages = result2.images.length;
                            for (var i = 0; i < numOfImages; i++) {
                                imageInfo[i] = result2.images[i].imgOrgUrl;
                            }
                        }
                        facebookPosting(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
                    });
                }
            }
        });
    }

    //바로실행 캠페인 실행
    function setLoadAndGoCampaignExecution() {
        var data = campaignListGrid.opt.gridControl.getSelectedRecords()[0];
        var id = data.id;
        var getCampaignTypeCode = data.campaignTypeCode;

        if (type == "LOADNGO") {
            if (getCampaignTypeCode == "LOADNGO") {
                $.ifvSyncPostJSON('<ifvm:action name="loadAndGoCampaignExecution"/>', {
                    id: id
                }, function (result) {
                    alert('<spring:message code="M00152" />');
                });
            }
        }
    }

    // 팝업 닫기
    function campaignTempPopClose() {
        dialog._destroy();
    }

    // 공통 조회 조건 목록 설정
    function campaignListSearchInit(gridId) {
        $.fn.ifvmSetCommonCondList("campaignSearchList", "MKTMNG001", gridId);
    }

    // 공통 조회 호출
    function campaignListSearch() {
        $.fn.ifvmSubmitSearchCondition("campaignSearchList", function () {
            campaignListGrid.searchGrid({item: requestitem});
        });
    }

    //기획완료 시, 인스타그램 포스팅
    function instagramPosting(camStatusCd, id) {
        var snsPageId = "";
        var appId = "";
        var appSecurCode = "";
        var contents = "";
        var attType = "";
        var fileUrl = "";
        var numOfImages = "";
        var imageInfo = new Array();
        var postId = "";
        var conid = "";
        var imgFileName = new Array();
        var videoFileName = "";

        // camid로 conid 조회 -> 변수 세팅
        $.ifvSyncPostJSON('<ifvm:action name="getConidByCamid"/>', {
            camid: id
        }, function (getResult) {

            var len = getResult == null ? 0 : getResult.length;
            for (var z = 0; z < len; z++) {
                var result = getResult[z];
                if (result.chnlTypeCd == 'INSTAGRAM') {

                    conid = result.conid;
                    $.ifvSyncPostJSON('<ifvm:action name="getInstagramDtlList"/>', {
                        id: conid
                    }, function (result2) {
                        $.ifvSyncPostJSON('<ifvm:action name="getInstagramInfoById"/>', {
                            id: result2.snsInfo
                        }, function (result3) {
                            snsPageId = result3.snsPageId;
                            appId = result3.appId;
                            appSecurCode = result3.appSecurCode;
                        });

                        contents = result2.contents;
                        attType = result2.attType;
                        fileUrl = '<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>/' + result2.filePath + result2.fileName;
                        videoFileName = result2.fileName;

                        if (result2.imageUrl != '') {
                            numOfImages = result2.images.length;
                            for (var i = 0; i < numOfImages; i++) {
                                imageInfo[i] = result2.images[i].imgOrgUrl;
                                imgFileName[i] = result2.images[i].imgFileName;
                            }
                        }

                        // 인스타그램 포스팅
                        if (attType == "IMAGE") {
                            $.ifvSyncPostJSON('<ifvm:action name="uploadImageToInsta"/>', {
                                username: appId,
                                password: appSecurCode,
                                imageInfo: imageInfo,
                                file: imgFileName,
                                contents: contents
                            }, function (result4) {

                                if (result4.message == "0") {
                                    alert('<spring:message code="M02223"/>');
                                    $.ifvProgressControl(false);
                                } else if (result4.message == "1") {
                                    alert('<spring:message code="M02224"/>');
                                    $.ifvProgressControl(false);
                                } else if (result4.message == "2") {
                                    alert('<spring:message code="M02225"/>');
                                    $.ifvProgressControl(false);
                                } else {
                                    alert('<spring:message code="M02226"/>');

                                    // 포스팅 이후, uploadId(result.message)를 데이터베이스에 저장
                                    $.ifvSyncPostJSON('<ifvm:action name="setPostId"/>', {
                                        id: conid,
                                        postId: result4.message
                                    }, function (result5) {
                                    });

                                    // 기획완료
                                    setCampaignCompleted();
                                }
                            });
                        } else if (attType == "VIDEO") {
                            $.ifvSyncPostJSON('<ifvm:action name="uploadVideoToInsta"/>', {
                                username: appId,
                                password: appSecurCode,
                                fileUrl: fileUrl,
                                file: videoFileName,
                                contents: contents
                            }, function (result4) {

                                if (result4.message == "0") {
                                    alert('<spring:message code="M02223"/>');
                                    $.ifvProgressControl(false);
                                } else if (result4.message == "1") {
                                    alert('<spring:message code="M02224"/>');
                                    $.ifvProgressControl(false);
                                } else if (result4.message == "2") {
                                    alert('<spring:message code="M02225"/>');
                                    $.ifvProgressControl(false);
                                } else {
                                    alert('<spring:message code="M02226"/>');
                                    // 기획완료
                                    setCampaignCompleted();
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    function gridDataSetFlag() {
        var cellValue
        if (cellValue == '1') return 'Y';
        else return 'N';
    }

    /**
     * 캠페인 삭제
     *
     * @date 2017. 11. 29.
     * @author jh.kim
     */
    function setCampaignRemove() {
        var dataList = campaignListGrid.opt.gridControl.getSelectedRecords();
        if (dataList.length != 0) {

            var data = dataList[0];
            var id = data.id;
            var campaignStatusCode = data.campaignStatusCode;
            var campaignApprovalStatusCode = data.campaignApprovalStatusCode;

            if (campaignStatusCode == 'W') {

                //캠페인 삭제 하시겠습니까?
                if (confirm('<spring:message code="M02305" />')) {
                    $.ifvSyncPostJSON('<ifvm:action name="removeCampaign"/>', {
                        id: id,
                        campaignStatusCode: campaignStatusCode,
                        campaignApprovalStatusCode: data.campaignApprovalStatusCode
                    }, function (result) {
                        if ($.fn.ifvmIsNotEmpty(result)) {
                            if (result.success == true) {
                                //삭제되었습니다.
                                alert('<spring:message code="L00034" />');
                                getCampaignList();
                            } else {
                                //해당 캠페인은 삭제 가능한 상태가 아닙니다
                                alert('<spring:message code="M02306" />');
                            }
                            $(".campaign_order").empty();
                        }
                    });
                }
            } else {
                //해당 캠페인은 삭제 가능한 상태가 아닙니다
                alert('<spring:message code="M02306" />');
            }
        } else {
            //목록을 선택해주세요.
            alert("<spring:message code='M01018' />");
        }
    }

    function campaignAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            authType = result.rows[0].authType;
            brandCd = result.rows[0].brandCd;
            empType = result.rows[0].empType;
        });
    }

    function cpnPointFun() {
        var offerCheck = offerCheckFun();
        var camId = campaignListGrid.opt.gridControl.getSelectedRecords()[0].id;

        //발급 완료 여부
        if (offerCheck[0]) {
            //완료 체크
            if (offerCheck[1] == 'S') {
                alert('이미 발급이 완료 되었습니다.');
            } else if (offerCheck[1] == 'N') {
                alert('쿠폰/포인트 오퍼가 등록되지 않았습니다.');
            } else if (offerCheck[1] == 'R') {
                alert('정기캠페인의 경우 쿠폰/포인트 오퍼를 선 발급 할 수 없습니다.');
            } else {
                alert('예상치 못한 에러가 발생하였습니다. 관리자에게 문의해주세요.');
            }
        } else {
            if (offerCheck[1] == '0') {
                alert('쿠폰/포인트 발급이 진행 중 입니다.\n잠시 후 다시 시도해주세요.');
            } else if (offerCheck[1] == '1') {
                //발급 진행
                $.ifvSyncPostJSON('<ifvm:action name="camOfferRequest"/>', {
                    id: camId
                }, function (result) {
                    alert('쿠폰/포인트 발급을 요청하였습니다.')
                }, function (result) {
                    alert('쿠폰/포인트 발급 요청이 실패하였습니다. 관리자에게 문의해주세요.')
                });

            } else if (offerCheck[1] == '99') {
                alert('쿠폰/포인트가 정상적으로 발급되지 않았습니다.\n 관리자에게 문의해주세요.');
            } else {
                alert('예상치 못한 에러가 발생하였습니다. 관리자에게 문의해주세요.')
            }
        }
        getCampaignList();
    }

    function initCampaign(getType) {
        campaignAuth();

        strType = getType;

        getCampaignList();

        // 공통 조회 조건 목록 설정
        campaignListSearchInit();

        // 조회
        $('#campaignListSearchBtn').on('click', function () {
            campaignListSearch();
        });

        // 초기화
        $("#campaignListSearchInitBtn").on('click', function () {
            campaignListSearchInit('campaignListGrid');
        });

        // 신규 클릭시
        $('#campaignNewBtn').on('click', function () {
            $("#dialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="campaignTempPop"/>',
                contentType: "ajax",
                /* title : '<spring:message code="M00754" />', */
                title: '템플릿',
                width: 825,
                close: 'campaignTempPopClose',
                open: function () {
                    new ifvm.PopupCenter({
                        popupDivId: 'dialog'
                    });
                }
            });
        });

        // 작성취소
        $('#campaignCancelBtn').on('click', function () {
            setCampaignCancel();
        });

        $('#campaignRemoveBtn').on('click', function () {
            setCampaignRemove();
        });

        // 중지
        $('#campaignStopBtn').on('click', function () {
            $.ifvProgressControl(true);

            setTimeout(function () {
                setCampaignStop();
            }, 1000);
        });

        // 기획완료
        $('#campaignCompletedBtn').on('click', function () {
            $.ifvProgressControl(true);

            setTimeout(function () {
                //nodeCheck();
                setCampaignCompleted("");
            }, 1000);
        });

        // 바로실행캠페인 실행
        $('#campaignRunBtn').on('click', function () {
            setLoadAndGoCampaignExecution();
        });

        $('#approvalRequestBtn').on('click', function () {
            approvalRequestFun();
        });

        $('#cpnPointBtn').on('click', function () {
            var list = campaignListGrid.opt.gridControl.getSelectedRecords();
            if (list.length != 0) {
                $.ifvProgressControl(true);
                setTimeout(function () {
                    //결재 승인 여부 확인
                    if (list[0].campaignApprovalStatusCode == '090') {
                        if (confirm('쿠폰/포인트 발급을 진행하시겠습니까?')) {
                            cpnPointFun();
                        }
                    } else {
                        alert('캠페인 승인이 완료되지 않았습니다. 쿠폰/포인트 발급을 진행 할 수 없습니다.');
                        getCampaignList();
                    }
                    $.ifvProgressControl(false);
                }, 1000);
            } else {
                alert('목록을 선택해주세요.');
            }
        });
    }

</script>