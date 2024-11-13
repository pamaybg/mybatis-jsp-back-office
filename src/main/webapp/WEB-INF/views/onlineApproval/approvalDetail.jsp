<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>

<style>
    .ui-jqgrid .ui-jqgrid-bdiv {
        position: relative;
        margin: 0em;
        padding: 0;
        overflow: hidden;
        text-align: left;
    }
    .popup_container .pop_inner_wrap {
        overflow: hidden;
    }
</style>

<script type="text/javascript">
    var approverListGrid;
    var valcheck = true;
    var detail = false;
    var sysdate = new Date();
    var approvalDialog;
    var chid = '<%= cleanXss(request.getParameter("id")) %>';
    var disabledType = '<%= cleanXss(request.getParameter("type")) %>';
    var saveCheck = false;         //실제 파일을 지우기 위한 체크
    var aprvStore = '';
    var createBy;
    var isValid;
    var FileData;
    var approvalHtmlContents;
    var html;
    var saveChk = false;
    var addChk = false; //결제자,참조자 추가 됬는지 체크
    var approvalDetailData = {
        htmlContents: '',
        status: '',
    };
    var dataArray = new Array();
    var aprvStore;
    var count = 0;
    var AprbCheck = false;
    var empIdList = [];
    var refempIdList = [];
    var notClick = true;
    var FormNewPop;
    var empType;        //매장&본사 구분 (H:본사, S:매장)
    var rejectRsn;

    /**
     * 기안자 및 부서 세팅
     * @returns
     */
    function initCreSetting() {

        $("#approvalPopupSangsinCancelBtn").hide();
        //$("#approvalPopupAprvsendBtn").hide();

        $("#createDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

        // 승인업무 유형
        $.fn.ifvmSetSelectOptionCommCode("elecAprvTypeCd", "APRV_TYPE_CD", null, null, true);

        // 승인상태
        $.fn.ifvmSetSelectOptionCommCode("elecAprvStatusCd", "EL_APPROVAL_STATUS_CD", null, null, true);

        getgridDataReload();
    }

    /**
     * 상세정보 호출
     */
    function idCheck() {
        if (chid != "null") {

            //정보 세팅
            $.ifvSyncPostJSON('<ifvm:action name="getDetailAprv"/>', {
                id: chid
            }, function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {

                    result = result.rows[0];
                    saveChk = true;

                    //$("#approvalPopupAprvsendBtn").hide();
                    $("#approvalPopupSangsinCancelBtn").hide();
                    $("#approvalPopupSaveBtn").hide();
                    $("#aprvAdd").hide();
                    $("#setAprv").hide();
                    $("#aprvDel").hide();

                    $('#btnsend').hide();
                    $('#btnSave').hide();
                    $('#cancle').hide();

                    $("#camNm").val(result.camNm);
                    $("#camCode").val(result.dispNo);
                    $("#camId").text(result.camId);
                    $("#camContent").val(result.camDesc);

                    $("#elecAprvTypeCd").val(result.elecAprvTypeCd);
                    $("#elecAprvRqtrId").val(result.elecAprvRqtrId);
                    $("#elecAprvRqtrNm").val(result.elecAprvRqtrNm);
                    $("#elecAprvRqtrOrgId").val(result.elecAprvRqtrOrgId);
                    $("#elecAprvRqtrOrgNm").val(result.elecAprvRqtrOrgNm);
                    $("#createDate").val(result.createDd);
                    $("#elecAprvLastApvDd").val(result.lastApvDd);
                    $("#elecAprvStatusCd").val(result.elecAprvStatusCd);
                    $("#elecAprvSbst").val(result.contetnt);

                    html = result.contetnt;
                    notClick = true;

                    //작성 중
                    if (result.elecAprvStatusCd == "001") {
                        $("#approvalPopupSaveBtn").show();
                        //$("#approvalPopupAprvsendBtn").hide();
                        $("#approvalPopupSangsinCancelBtn").hide();
                        $("#aprvAdd").show();
                        $("#setAprv").show();
                        $("#aprvDel").show();
                        $('#btnsend').show();   //결제상신
                        $('#cancle').show();    //작성취소
                        $('#btnSave').show();   //저장
                        $("#elecAprvSbst").attr("disabled", false);
                    }
                    // 결재 진행중
                    else if (result.elecAprvStatusCd == "010") {
                        $("#approvalPopupAprvsendBtn").hide();
                        $("#elecAprvSbst").attr("disabled", true);
                        notClick = false;
                        aprvStore = "013";
                    }
                    // 작성 취소
                    else if (result.elecAprvStatusCd == "002") {
                        $("#approvalPopupSaveBtn").show();
                        $("#approvalPopupAprvsendBtn").hide();
                        $("#aprvAdd").show();
                        $("#setAprv").show();
                        $("#aprvDel").show();
                        $('#btnSave').show();   //저장
                        $('#btnsend').show();   //결제상신
                    }
                    // 결재 반려
                    else if (result.elecAprvStatusCd == "020") {
                        notClick = false;
                        $("#approvalPopupSaveBtn").hide();
                        $("#approvalPopupAprvsendBtn").hide();
                        $("#aprvAdd").hide();
                        $("#setAprv").hide();
                        $("#aprvDel").hide();

                        $('#btnsend').show();   //결제상신
                        $('#cancle').show();    //작성취소
                        $('#btnSave').show();   //저장
                        $("#elecAprvSbst").attr("disabled", true);
                    }
                    // 승인 완료
                    else if (result.elecAprvStatusCd == "090") {
                        $("#approvalPopupAprvsendBtn").hide();
                        $("#aprvAdd").attr('disabled', 'true');
                        $("#setAprv").attr('disabled', 'true');
                        $("#aprvDel").attr('disabled', 'true');
                        $("#elecAprvSbst").attr('disabled', 'true');
                        $("#elecAprvSbst").attr("disabled", true);

                        notClick = false;
                    } else {
                    }

                    approvalDetailData.status = result.elecAprvStatusCd;
                    approvalDetailData.htmlContents = result.contetnt;

                    //수정 권한 트루
                    detail = true;
                }
            });

            if (disabledType == "ref" || disabledType == "aprv") {

            }
        } else {
            AprbCheck = true;
            $("#approvalPopupSaveBtn").show();
            //$("#approvalPopupAprvsendBtn").hide();
            $("#approvalPopupSangsinCancelBtn").show();
            $("#aprvAdd").show();
            $("#setAprv").show();
            $("#aprvDel").show();
            $('#btnsend').show();   //결제상신
            $('#cancle').show();    //작성취소
            $('#btnSave').show();   //저장
        }

        if (detail == false) {
            var empId = $.ifvmGetUserInfo().empId;
            var empName = $.ifvmGetUserInfo().empName;
            var orgId = $.ifvmGetUserInfo().orgId;
            var orgName = $.ifvmGetUserInfo().orgName;

            //승인요청자 기본 설정
            $("#elecAprvRqtrId").val(empId);
            $("#elecAprvRqtrNm").val(empName);
            $("#elecAprvRqtrOrgId").val(orgId);
            $("#elecAprvRqtrOrgNm").val(orgName);
        }
    }

    //저장 버튼클릭 시 동작
    function actionApproval() {
        isValid = validation.confirm();
        if (isValid) {

            // 상세 페이지일 시 수정 작업 동작
            if (detail) {

                //수정
                $.ifvSyncPostJSON('<ifvm:action name="editElapproval"/>', {
                    camId: campaignApprovalData.campaignInfo.id
                    , id: chid
                    , elecAprvTitle: campaignApprovalData.campaignInfo.campaignName
                    , elecAprvStatusCd: $("#elecAprvStatusCd").val()
                    , elecAprvTypeCd: '01' //$("#elecAprvTypeCd").val()
                    , elecAprvRqtrId: $("#elecAprvRqtrId").val()
                    , elecAprvRqtrOrgId: $("#elecAprvRqtrOrgId").val()
                    , elecAprvStatusCd: $("#elecAprvStatusCd").val()
                    , elecAprvSbst: $("#elecAprvSbst").val()
                }, function (result) {
                    alert('<spring:message code="M00991"/>');
                    //approvalPopClose();
                    //qtjs.href('<ifvm:url name="campaignList"/>');
                });
            }
            // 상세 페이지가 아닐 시 insert 동작
            else {
                //language code
                $.ifvSyncPostJSON('<ifvm:action name="setApproval"/>', {
                    camId: campaignApprovalData.campaignInfo.id
                    , elecAprvTitle: campaignApprovalData.campaignInfo.campaignName
                    , elecAprvStatusCd: '001'
                    , elecAprvTypeCd: '01' // $("#elecAprvTypeCd").val()
                    , elecAprvRqtrId: $("#elecAprvRqtrId").val()
                    , elecAprvRqtrOrgId: $("#elecAprvRqtrOrgId").val()
                    , elecAprvStatusCd: $("#elecAprvStatusCd").val()
                    , elecAprvSbst: $("#elecAprvSbst").val()
                }, function (result) {
                    chid = result.message;
                    alert('<spring:message code="M00990"/>');
                    if (addChk) {
                        updateSaveAprv();
                    }
                    //approvalPopClose();
                    //qtjs.href('<ifvm:url name="campaignList"/>');
                });
            }
        }
        idCheck();
    }


    function deleteAprvList(fromTbl, toTbl) {

        var active = 0;
        var checkedList = approverListGrid.getCheckedGridData();
        var listFlowIdList = [];
        var count = checkedList.length;

        if (checkedList.length != 0) {
            for (var i = 0; i < checkedList.length; i++) {
                listFlowIdList.push(checkedList[i].id);
            }

            var size = dataArray.length - 1;
            var dataStore = new Object();
            for (var i = 0; i <= size; i++) {
                dataStore[size - i] = dataArray.pop();
            }

            for (var i = 0; i <= size - count + 1; i++) {
                if (dataStore[i].id != listFlowIdList) {
                    dataArray.push(dataStore[i]);
                }
            }

            $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>', {
                listChannelFlowId: listFlowIdList
            }, function (result) {
                alert('<spring:message code="M00622"/>');
                approverListGrid.delCheckedRow();
            });
            reDefined();
        } else {
            alert('<spring:message code="M00285"/>');
        }
    }

    function getIddeleteAprvList() {
        var listFlowIdList = [];
        var checkedList = approverListGrid.getRowData();
        $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>', {
            id: chid
        }, function (result) {

        });
    }

    //페이지를 벗어날 시 Grid Data 자동 삭제
    function delPageOutAprv() {
        var listFlowIdList = [];
        var gridSize = approverListGrid.getRowData().length;
        if (gridSize != 0) {
            for (var i = 0; i < gridSize; i++) {
                listFlowIdList.push(approverListGrid.getRowData()[i].id);
            }
            $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>', {
                listChannelFlowId: listFlowIdList
            }, function (result) {
            });
        }
    }

    //페이지를 벗어날 시 Grid Data 자동 삭제
    function updateSaveAprv() {
        var listFlowIdList = [];
        var gridSize = approverListGrid.getRowData().length;
        if (gridSize != 0) {
            for (var i = 0; i < gridSize; i++) {
                listFlowIdList.push(approverListGrid.getRowData()[i].id);
            }

            $.ifvSyncPostJSON('<ifvm:action name="editItem"/>', {
                elecId: chid
                , listChannelFlowId: listFlowIdList
            }, function (result) {
            });
        }
    }

    //승인 완료 후 Disabled 처리
    function allDisabled() {
        $("#elecAprvStatusCd").attr('disabled', 'true');
        $("#elecAprvSbst").attr('disabled', 'true');
        $("#camContent").attr('disabled', 'true');
        $("#aprvAdd").attr('disabled', 'true');
        $("#setAprv").attr('disabled', 'true');
        $("#aprvDel").attr('disabled', 'true');
        $("#aprvRefAdd").attr('disabled', 'true');
        $("#aprvRefDel").attr('disabled', 'true');
        $("#fileAdd").attr('disabled', 'true');
        $("#fileRemoveBtn").attr('disabled', 'true');
    }

    // 승인 완료 후 Disabled 처리
    function allDisabledFalse() {
        $("#elecAprvStatusCd").attr('disabled', 'false');
        $("#elecAprvSbst").attr('disabled', 'false');
        $("#camContent").attr('disabled', 'false');
        $("#aprvAdd").attr('disabled', 'false');
        $("#setAprv").attr('disabled', 'false');
        $("#aprvDel").attr('disabled', 'false');
        $("#aprvRefAdd").attr('disabled', 'false');
        $("#aprvRefDel").attr('disabled', 'false');
        $("#fileAdd").attr('disabled', 'false');
        $("#fileRemoveBtn").attr('disabled', 'false');
    }

    //결제 승인자
    function initApproverListGrid() {

        var jqGridOption = {
            ondblClickRow : function () {
                rejectRsn = approverListGrid.getSelectedRowData().rejectRsn;
                if($.fn.ifvmIsNotEmpty(rejectRsn)) {
                    goRejectDesc()
                }
            },
            data: dataArray,
            datatype: 'clientSide',
            colNames: [
                '<spring:message code="M00953"/>',
                '<spring:message code="M00954"/>',
                '<spring:message code="M00955"/>',
                '<spring:message code="M00956"/>',
                '<spring:message code="M00957"/>',
                '<spring:message code="M03086"/>',
                '결재일자',
                'apprvCode',
                'id',
            ],
            colModel: [
                {name: 'seq', index: 'meai.ELEC_APRV_SEQ', resizable: false, width: '25px', align: 'center'},
                {name: 'apprvType', index: 'c1.MARK_NAME', resizable: false, align: 'center',width:'75px'},
                {name: 'apprvName', index: 'c3.NAME', resizable: false,width:'80px'},
                {name: 'apprvDept', index: 'c5.name', resizable: false,width:'80px'},
                {name: 'elApproveStatus', index: 'c2.MARK_NAME', resizable: false,align: 'center',width:'80px'},
                {name: 'rejectRsn', index: 'ceai.REJECT_RSN', resizable: false,width:'200px'},
                {name: 'apvDd', index: 'meai.apv_dd', resizable: false,width:'100px'},
                {name: 'apprvCode', index: 'meai.APVR_TYPE_CD', resizable: false, hidden: true},
                {name: 'id', index: 'meai.ID', resizable: false, hidden: true, key: true},
            ],
            rowList: [100000],
            radio: true,
            tempId: 'approvalPopTemplete',
        };
        approverListGrid = $("#approverListGrid").ifvGrid({jqGridOption: jqGridOption});
        // ui-jqgrid
        // $("#approverListGrid").removeClass("ui-jqgrid-bdiv")
        // $(this).addClass("ui-jqgrid-bdiv");
    }

    function getTotal() {
        $("#approverListGrid").find(".total_area").children().text('<spring:message code="M00172"/>' + ": " + dataArray.length + '<spring:message code="M00964"/>');
    }

    /**
     * 팝업 닫기
     */
    function FormNewPopClose() {
        FormNewPopDialog._destroy();
    }

    /**
     * 데이터를 배열에 담기(DB내의 Data를 배열에 담는 초기 세팅)
     */
    function getgridDataReload() {

        var size = dataArray.length;
        for (var i = 0; i < size; i++) {
            dataArray.pop();
        }
        // 그리드 Data Setting
        if (chid != "null") {

            $.ifvSyncPostJSON('<ifvm:action name="getAprvList"/>', {
                id: chid
            }, function (result) {
                var size = result.length;

                for (var i = 0; i < size; i++) {
                    AprbCheck = true;
                    var dataStore = new Object();
                    dataStore.seq = result[i].seq;
                    dataStore.apprvType = result[i].apprvType;
                    dataStore.apprvName = result[i].apprvName;
                    dataStore.apprvCode = result[i].apprvCode;
                    dataStore.apprvDept = result[i].apprvDept;
                    dataStore.elApproveStatus = result[i].elApproveStatus;
                    dataStore.apvDd = result[i].apvDd;
                    dataStore.id = result[i].id;
                    dataStore.reqarvrId = result[i].apvrId;
                    dataStore.reqOrgId = result[i].acId;
                    dataStore.rejectRsn = result[i].rejectRsn;
                    dataArray.push(dataStore);
                }
            });
        }
    }

    //그리드 데이타 세팅 후 추가(행 추가)
    function setReGrid() {
        var size = dataArray.length;

        for (var i = 0; i < size; i++) {
            var dataStore = new Object();

            dataStore.seq = dataArray[i].seq
            dataStore.apprvType = dataArray[i].apprvType
            dataStore.apprvName = dataArray[i].apprvName
            dataStore.apprvCode = dataArray[i].apprvCode
            dataStore.apprvDept = dataArray[i].apprvDept
            dataStore.elApproveStatus = dataArray[i].elApproveStatus
            dataStore.apvDd = dataArray[i].apvDd
            dataStore.id = dataArray[i].id
            dataStore.rejectRsn = dataArray[i].rejectRsn
            approverListGrid.addLocalTr(dataStore);
        }

    }

    function reDefined() {

        approverListGrid.removeAll();
        var size = dataArray.length;
        for (var i = 0; i < size; i++) {
            dataArray[i].apprvType = '<spring:message code="M00949"/>';
            if (i == (size - 1)) dataArray[size - 1].apprvType = '<spring:message code="M00972"/>';
            dataArray[i].seq = i + 1;

            approverListGrid.addLocalTr(dataArray[i]);
        }
    }

    //결재 라인 자동 추가
    function getAprvLine() {
        approverListGrid.removeAll();
        dataArray = [];
        $.ifvSyncPostJSON('<ifvm:action name="getStoreManagerInfo"/>', {
            id: this.empId
        }, function (result) {
            var valText = '<spring:message code="M00949"/>';
            var dataStore2 = new Object();
            var size = result.rows.length;

            for (i = 0; i < size; i++) {
                dataStore2 = {};
                dataStore2.reqarvrId = result.rows[i].id;
                dataStore2.seq = i + 1;
                dataStore2.apprvName = result.rows[i].empNm;
                //dataStore2.email = result.rows[i].email;
                dataStore2.apprvDept = result.rows[i].accNm;
                dataStore2.reqOrgId = result.rows[i].acId;
                //dataStore2.paraccNm = result.rows[i].paraccNm;
                dataStore2.apprvType = valText;
                dataStore2.elApproveStatus = '';
                dataStore2.apvDd = '';
                dataStore2.id = count;

                if (i == size - 1) {
                    dataStore2.apprvType = '<spring:message code="M00972"/>';
                }

                count++;
                dataArray.push(dataStore2);
            }
            setReGrid();
            getTotal();
        });
    }

    //결제자 추가
    function setRow() {
        var size = dataArray.length;
        var ApprCheck = 'F';
        //결재승인자 여부 확인
        for (var i = 0; i < size; i++) {
            var dataStore = new Object();
            $.ifvSyncPostJSON('<ifvm:action name="setItemApproval"/>', {
                aprvId: chid
                , arvrId: dataArray[i].reqarvrId
                , orgId: dataArray[i].reqOrgId
                , apvrType: '9'
                , aprbStatus: aprvStore
            }, function (result) {
            }, function (result) {
                if (result.errorType == 700100) {
                    alert('<spring:message code="M00993"/>'); //최대 사용자를 초과하였습니다.
                }
            });
        }

        //필수결재자 추가
        $.ifvSyncPostJSON('<ifvm:action name="setRequiredItemApproval"/>', {
            aprvId: chid
        }, function (result) {
        }, function (result) {
            if (result.errorType == 1) {
                alert('<spring:message code="M00995"/>'); //결재자를 추가해주세요.

                //상태 값 코드
                $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
                    elecAprvStatusCd: '002'
                    , id: chid
                }, function (result) {
                });

                idCheck();
            }
        });
    }

    window.onbeforeunload = function () {
        if (saveChk == false) {
            if (addChk) delPageOutAprv();
        }
    }

    //현재 추가된 목록 가져오기.
    function getempIdList() {
        var size = dataArray.length;
        empIdList = [];
        refempIdList = [];
        for (var i = 0; i < size; i++) {
            empIdList.push(dataArray[i].reqarvrId);
        }
    }

    /**
     * 승인요청자 선택시
     */
    function selectApprovalEmp() {

        var len = approvalEmpGrid.getCheckedGridData().length;
        if (len > 0) {
            var data = approvalEmpGrid.getCheckedGridData()[0];
            $('#elecAprvRqtrNm').val(data.empNm);
            $('#elecAprvRqtrId').val(data.id);
            $('#elecAprvRqtrOrgNm').val(data.accNm);
            $('#elecAprvRqtrOrgId').val(data.acId);

            FormNewPopClose();

            //popup 높이 맞추기
            initPopupHeight();
        } else {
            alert('<spring:message code="L00066"/>');
        }
    }

    //popup 높이 맞추기
    function initPopupHeight() {
        setTimeout(function () {
            try {
                new ifvm.PopupHeight({
                    popupDivId: 'dialog',
                    contentsId: 'dialogPopupWrap'
                });
                cDialog.refresh();
            } catch (e) {
            }
        }, 500);
    }

    function saveApproval() {
        setTimeout(function () {
            $('#btnsend').hide();
            var actionNm;
            if (dataArray.length > 0) {
                if (strType == "MKT") {
                    actionNm = '<ifvm:action name="campaignStatusCheckMkt"/>'
                } else {
                    actionNm = '<ifvm:action name="campaignStatusCheck"/>'
                }

                // 캠페인 상태 체크
                $.ifvSyncPostJSON(actionNm, {
                        camId: campaignApprovalData.campaignInfo.id,
                        useApproval: true,
                        type: strType
                    }, function (result) {

                        if (result.message == '1') {
                            //오퍼유형이 [모바일 쿠폰]인 경우에는 전송 채널 중에 MMS만 연결이 가능합니다. [기획완료 및 실행]를 진행 할 수 없습니다.
                            alert("<spring:message code='M01386' />");
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
                            //해당 캠페인은 채널을 등록해야 실행 할 수 있습니다.
                            alert("<spring:message code='M03003' />");
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
                        } else {

                            //결제라인 추가
                            saveChk = true;
                            var approverList = new Array();
                            dataArray.forEach(function (data) {
                                approverList.push({
                                    id: data.reqarvrId,
                                    seq: data.seq,
                                });
                            });

                            //결제 상신
                            $.ifvSyncPostJSON('<ifvm:action name="campaignRequestApproval"/>', {
                                recordRid: campaignApprovalData.campaignInfo.id,
                                aprvTitle: campaignApprovalData.campaignInfo.campaignName,
                                aprvType: $('#elecAprvTypeCd').val(),
                                reqRid: $('#elecAprvRqtrId').val(),
                                approverList: approverList,
                                rid: chid,
                                dataVal: '01',
                                apvrId: dataArray[0].reqarvrId,
                                elecAprvTitle: campaignApprovalData.campaignInfo.campaignName,
                                elecAprvEmpNo: campaignApprovalData.campaignInfo.campaignPlannerEmpNo,
                                elecAprvEmpName: campaignApprovalData.campaignInfo.campaignPlannerName
                            }, function (result) {
                            });

                            //화면 전체 reload
                            loadApproval();

                            //상세화면 조회
//                     idCheck();

                            if (AprbCheck == true) {
//                         getIddeleteAprvList();
                            }
//                     approverListGrid.removeAll();
//                     setRow();
//                     getgridDataReload();
//                     initApproverListGrid();

                        }
                    }
                    , function (result) {
                        if (result.message == '97') {
                            alert('<spring:message code="M02768" />');
                        }
                    });
            } else {
                alert('<spring:message code="M00995"/>');
            }
            $.ifvProgressControl(false);
            approvalPopClose();
        }, 500);
    }

    function empTypeChk(){
        if(empType != 'H'){
            $('#setAprv').hide();
            $('#aprvAdd').hide();
            $('#aprvDel').hide();
        }
    }

    //반려사유 상세 팝업
    function goRejectDesc(){
        $("#RejectDescPop").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="approvalRejectDescPop"/>',
            contentType: "ajax",
            title: '<spring:message code="반려사유 상세"/>',
            width: 340,
            close: 'rejectDescPopClose',
            /*open : function(){
                new ifvm.PopupCenter({
                    rejectRsn : rejectRsn
                });
            }*/
        });
    }

    function rejectDescPopClose(){
        RejectDescPop._destroy();
    }

    $(document).ready(function () {

        $.ifvmLnbSetting('approvalList');

        pageSetUp();

        //초기 Data 세팅
        initCreSetting();

        // 상세 조회
        // idCheck();
        setTimeout(function () {
            idCheck();
        }, 0);

        $("#aprvDel").on("click", function () {
            deleteAprvList();
            getTotal();
        });

        //결재 상신
        $("#btnsend").on("click", function () {
            $.ifvProgressControl(true);
            setTimeout(function () {
                saveApproval();
            }, 500);
        });

        //작성 취소
        $("#cancle").on("click", function () {

            //결제 승인자 초기화
            $.ifvSyncPostJSON('<ifvm:action name="removeItem"/>', {
                id: chid
            }, function (result) {
            });

            //상태 값 코드
            $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
                elecAprvStatusCd: '002'
                , id: chid
            }, function (result) {
            });

            dataArray = [];
            $('#elecAprvSbst').val('');

            //$("#btnSave").click();
            initApproverListGrid();

            idCheck();
        });

        //저장
        $("#btnSave").on("click", function () {
            if (disabledType == "ref"
                || disabledType == "aprv") {
            } else {
                //생성 및 수정
                actionApproval();

                $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
                    elecAprvStatusCd: '001'
                    , id: chid
                }, function (result) {
                    idCheck();
                });
            }
            //현재 설정되어 있는 Grid Data delete 후 새로 등록.
            if (AprbCheck) {
                getIddeleteAprvList();
            }
            setRow();
            getgridDataReload();
            initApproverListGrid();
        });

        // if ($(".popup_container #approvelDetailWrap").length > 0) {
        //     //팝업일 때
        //     //그리드 사이즈
        //     //$(".pop_grid").addClass("pop1024_grid");
        //     initApproverListGrid();
        // }
        // else {
        initApproverListGrid();
        // }

        $("#btnCampop").on("click", function () {
            if (notClick) {
                $("#FormNewPopDialog").ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="camListPop"/>',
                    contentType: "ajax",
                    title: '<spring:message code="M00967"/>',
                    width: 600,
                    close: 'FormNewPopClose',
                    open: function () {
                        new ifvm.PopupCenter({
                            popupDivId: 'FormNewPopDialog'
                        });
                    }
                });
            }

            FormNewPop = $("#FormNewPopDialog").data("ejDialog");
        });

        $("#aprvAdd").on("click", function () {
            $("#FormNewPopDialog").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="empListPop"/>?id=' + chid,
                contentType: "ajax",
                title: '<spring:message code="M00981"/>',
                width: 650,
                close: 'FormNewPopClose',
                open: function () {
                    new ifvm.PopupCenter({
                        popupDivId: 'FormNewPopDialog'
                    });
                }
            });

//         getempIdList();
//         empListPopGrid.requestData({ empId : empIdList });
        });

        $("#setAprv").on("click", function () {
            getAprvLine();
        });

        //결재 라인 자동 추가
        if ($.fn.ifvmIsEmpty(approverListGrid.getRowData())) {
            getAprvLine();
        }

        validation = $("#approvalBasicInfo").ifvValidation();

    });
</script>

<script id="commStatustemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>


</script>

<script id="approvalPopTemplete" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}
        <div class="grid_con">
            {grid}
        </div>
    </div>


</script>

<div id="approvelDetailWrap" class="col-xs-13">
    <div class="page-title page_hidden">
        <h1>
            <spring:message code="M00937"/>
            <span> &gt; <spring:message code="M00938"/></span>
        </h1>
    </div>
    <div class="page_btn_area page_border">
        <div class="col-xs-7">
            <span><spring:message code="M00939"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="approvalDetailBtnDiv">
            <%-- 결제상신 --%>
            <button id="btnsend" class="btn btn-sm" objCode="btnsend_OBJ">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00987"/>
            </button>
            <button id="cancle" class="btn btn-sm" objCode="cancle_OBJ">
                <spring:message code="M00940"/>
            </button>
            <%-- 저장 --%>
            <button id="btnSave" class="btn btn-sm" objCode="btnSave_OBJ">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00137"/>
            </button>
        </div>
    </div>

    <div class="well mg_bt0 underline form-horizontal" id="approvalBasicInfo">
        <%--<ifvm:input type="hidden" id="camNm"/>--%>
        <div class="row qt_border">

            <%-- 캠페인 코드 --%>
            <label class="col-xs-2 span control-label"><spring:message code="L02428"/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="text" disabled="true" id="camCode"/>
            </div>

                <%-- 캠페인명 --%>
                <label class="col-xs-2 span control-label"><spring:message code="V00257"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="text" disabled="true" id="camNm"/>
                </div>


        <div class="row qt_border">

            <%-- 승인업무유형 --%>
            <label class="col-xs-2 span control-label"><spring:message code="L01434"/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" id="elecAprvTypeCd" names="elecAprvTypeCd" disabled="true"/>
            </div>

            <%-- 승인요청자 부서 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M02398"/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="text" disabled="true" id="elecAprvRqtrOrgNm"/>
                <ifvm:input type="hidden" id="elecAprvRqtrOrgId"/>
            </div>
        </div>
        <div class="row qt_border">

            <%-- 승인요청자 --%>
            <label class="col-xs-2 span control-label"><spring:message code="L01437"/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="text" disabled="true" id="elecAprvRqtrNm" names="elecAprvRqtrNm"/>
                <ifvm:input type="hidden" id="elecAprvRqtrId" names="elecAprvRqtrId"/>
            </div>

                <%-- 승인요청일자 --%>
                <label class="col-xs-2 span control-label"><spring:message code="M02064"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="date" disabled="true" id="createDate"/>
                </div>
        </div>


        </div>

        <div class="row qt_border">
            <%-- 승인상태 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M00946"/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" disabled="true" id="elecAprvStatusCd" names="elecAprvStatusCd"/>
            </div>

                <%-- 결재일자 --%>
                <label class="col-xs-2 span control-label"><spring:message code="L01441" /></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="date" disabled="true" id="elecAprvLastApvDd" names="elecAprvLastApvDd"/>
                </div>
        </div>

        <div class="row">
            <%-- 설명 --%>
            <label class="col-xs-2 span control-label"><spring:message code="M00947"/></label>
            <div class="col-xs-8 control_content">
                <ifvm:input type="textarea" rows="4" id="elecAprvSbst" maxLength="200"/>
            </div>
        </div>

        <div class="temp_title" id="">
            <spring:message code="M00948"/>
            <div class="pop_top_btn mg_top">
                <button class="btn btn-sm btn_gray" id="setAprv" objCode="setAprv_OBJ">
                    <i class="fa fa-plus"></i>
                    <spring:message code="자동등록"/>
                </button>
                <button class="btn btn-sm btn_gray" id="aprvAdd" objCode="aprvAdd_OBJ">
                    <i class="fa fa-plus"></i>
                    <spring:message code="M00951"/>
                </button>
                <button class="btn btn-sm btn_gray" id="aprvDel" objCode="aprvDel_OBJ">
                    <i class="fa fa-minus"></i>
                    <spring:message code="M00952"/>
                </button>
            </div>
        </div>
        <div id="approverListGrid" class="con_size grid_scroll10" style="width:945px;"></div>
    </div>
</div>
<div id="FormNewPopDialog"></div>
<div id="RejectDescPop"></div>