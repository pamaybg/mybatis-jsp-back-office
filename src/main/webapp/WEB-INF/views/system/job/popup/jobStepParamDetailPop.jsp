<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<style>
    .helpBtn {
        background-image: url("/resources/images/icons/btn_help.png");
        background-repeat: no-repeat;
        background-position: center center;
        padding-left: 30px;
        vertical-align: middle;
        width: 17px;
        height: 17px;
        line-height: 17px;
    }
</style>

<div>
    <div class="form-horizontal" id="jobStepParamForm">
        <div class="pop_inner_wrap">
            <div class="temp_title_bb">
                기본 정보
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="itemType" dto="itemType" required="true" label="유형" nuc="true" labelClass="3" conClass="9"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="paramDesc" dto="paramDesc" required="true" label="설명" nuc="true" labelClass="3" conClass="9"/>
            </div>
        </div>

        <div class="half_wrap top_well">
            <div class="half_content half_left">
                <div class="pop_inner_wrap">
                    <div class="temp_title_bb">
                        매퍼설정
                        <a><i class="helpBtn" style="vertical-align: middle;">
                            <div class="helptxt" style="display:none;">
                                * 유형이 Tasklet 일 경우, 아래와 같이 입력해주세요.
                                <br/> 매퍼 ID : [Schema] / [Schema].[Package]
                                <br/> 매퍼 파라미터 : [Procedure][,[Parameter1],[Parameter2],[Parameter3]]
                            </div>
                        </i></a>
                    </div>
                </div>
                <div class="row">
                    <ifvm:inputNew type="text" id="maprId" dto="maprId" label="매퍼 ID" nuc="true" labelClass="3" conClass="9"/>
                </div>
                <div class="row">
                    <ifvm:inputNew type="text" id="maprParam" dto="maprParam" label="매퍼 파라미터" nuc="true" labelClass="3" conClass="9"/>
                </div>
            </div>

            <div class="half_content half_right">
                <div class="pop_inner_wrap">
                    <div class="temp_title_bb">
                        명령어 설정
                        <a><i class="helpBtn" style="vertical-align: middle;">
                            <div class="helptxt" style="display:none;">
                                명령어 파라미터 구분자는 æ (아스키230번) 입니다.
                            </div>
                        </i></a>
                    </div>
                </div>
                <div class="row">
                    <ifvm:inputNew type="text" id="execCmnd" dto="execCmnd" label="명령어" nuc="true" labelClass="3" conClass="9"/>
                </div>
                <div class="row">
                    <ifvm:inputNew type="select" id="cmndParamType" dto="cmndParamType" label="파라미터 유형" nuc="true" labelClass="3" conClass="9"/>
                </div>
                <div class="row">
                    <ifvm:inputNew type="text" id="cmndParam" dto="cmndParam" label="파라미터" nuc="true" labelClass="3" conClass="9" desc="구분자 : æ (아스키230번) "/>
                </div>
                <div class="row">
                    <ifvm:inputNew type="text" id="workingDir" dto="workingDir" label="실행경로" nuc="true" labelClass="3" conClass="9"/>
                </div>
            </div>
        </div>
    </div>

    <div class="page_btn_area">
        <div class="col-xs-7">
            <span>실행인수 정보</span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="newBtn" btnFunc="paramPopup" objCode="paramPopup_OBJ"/>
            <ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editBtn" btnFunc="modifyParamPopup" objCode="modifyParamPopup_OBJ"/>
            <ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeBtn" btnFunc="paramRemove" objCode="paramRemove_OBJ"/>
        </div>
    </div>
    <div id="infoExecuteParamGrid" class="white_bg"></div>
</div>
<br/>

<div class="pop_btn_area">
    <ifvm:inputNew
            type="button"
            btnType="save"
            text="저장"
            nuc="true"
            btnFunc="saveJobStepParam" objCode="saveBatchParameterDetailPopSave_OBJ"/>
    <ifvm:inputNew
            type="button"
            btnType="cancel"
            text="취소"
            nuc="true"
            btnFunc="jobStepParamPop.close()" objCode="batchParameterDetailPopClose_OBJ"/>
</div>

<div id="executeParamInfoPopUp" class="popup_container content_container"></div>

<script>
    //지역변수
    var jobStepFormVali = $("#jobStepParamForm").ifvValidation();

    var isJobStepParam = gJobStepParamRid && !isJobStepParamNew;
    //전역변수

    jobStepParamDetailSelectSet();
    infoExecuteParamGridFn();

    if (isJobStepParam) {
        getJobStepParamDetail();
    }

    $('.helpBtn').setupHelpMessage();

    //Job 저장
    function saveJobStepParam() {
        if (jobStepFormVali.confirm()) {
            var sendData = $("#jobStepParamForm").getSubmitData();
            sendData.ridStep = gStepRid;

            var url = !(isJobStepParam) ? "<ifvm:action name='addJobStepParam'/>" : "<ifvm:action name='editJobStepParam'/>";
            if (isJobStepParam) {
                sendData.rid = gJobStepParamRid;
            }
            var confirmMsg = !(isJobStepParam) ? "저장되었습니다." : "수정되었습니다.";
            $.ifvPostJSON(
                url,
                sendData,
                function () {
                    jobStepParamPop.close();

                    makeJobStepParamGrid();
                    alert(confirmMsg);
                }, null, "#jobPopup", "bigsize_progressRoll include_progress"
            );
        }
    }

    //Job 상세 조회
    function getJobStepParamDetail() {
        var url = "<ifvm:action name='getJobStepParamDtl'/>";
        var sendData = {};
        sendData.rid = gJobStepParamRid;
        $.ifvPostJSON(
            url,
            sendData,
            function (_result) {
                $("#jobStepParamForm").dataSetting(_result, null, false, [])
            }, null, "#jobPopup", "bigsize_progressRoll include_progress"
        );
    }

    function jobStepParamDetailSelectSet() {
        $.ifvGetCommCodeList('select', 'itemType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_ITEM_TYPE', 'loy', false, true, true);
        $.ifvGetCommCodeList('select', 'cmndParamType', '<ifvm:action name="getCommCodeList"/>', 'BATCH_COMMAND_PARAM_TYPE', 'loy', false, true, true);

        if(!isJobStepParam){
            $('#newBtn').prop('disabled',true);
            $('#editBtn').prop('disabled',true);
            $('#removeBtn').prop('disabled',true);
        }
    }

    //실행인수 그리드생성
    function infoExecuteParamGridFn() {
        var ejGridOption = {
            dataUrl: "<ifvm:action name='getInfoExecuteParam'/>",
            serializeGridData: function(data) {
                data.ridStep = gJobStepParamRid;
                return data;
            },
            columns :[
                {
                    field : 'executRid', headerText : '', headerTextAlign : 'center',  visible : false ,
                    customAttributes : {
                        index : 'executRid' } //
                },
                {
                    field : 'argsTypeNm', headerText : '인수 유형', headerTextAlign : 'center', textAlign : 'center',
                    customAttributes : {
                        index : 'jspa.ARGS_TYPE_CD',
                        sortable: false} //
                },
                {
                    field : 'argsSeq', headerText : '인수 순서', headerTextAlign : 'center', textAlign : 'right',
                    customAttributes : {
                        index : 'jspa.ARGS_SEQ',
                        sortable: false} //
                },
                {
                    field : 'argsNm', headerText : '인수 명', headerTextAlign : 'center', textAlign : 'left',
                    customAttributes : {
                        index : 'jspa.ARGS_NM' ,
                        sortable: false} //
                },
                {
                    field : 'argsVal', headerText : '인수 값', headerTextAlign : 'center', textAlign : 'center',
                    customAttributes : {
                        index : 'jspa.ARGS_VAL',
                        sortable: false} //
                },
            ],
            requestGridData : {
                rows : 10,
                sidx : 'jspa.ARGS_SEQ',
                sord : 'desc',
                _search : false
            },
            radio: true,
            rowList : [10,25,50,100],
            tempId: "ifvGridNotSearchTemplete"
        };
        jobStepParamDtlGrid = $("#infoExecuteParamGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    function paramPopup(paramRid){
        //로그 상세 팝업 호출
        $("#executeParamInfoPopUp").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: "<ifvm:url name='executeParamInfoPopUp'/>" + "?rid=" + paramRid,
            contentType: "ajax",
            title: "실행인수 정보",
            width: 700,
            beforeClose: "paramPopupClose"
        });
    }

    // 팝업 닫기
    function paramPopupClose() {
        executeParamInfoPopUp._destroy();
    }

    function paramRemove(){
        if(jobStepParamDtlGrid.opt.gridControl.getSelectedRecords().length === 0) {
            alert('목록을 선택해주세요.');
            return;
        }
        if(!confirm('삭제하시겠습니까?')) return;

        let paramRid = jobStepParamDtlGrid.opt.gridControl.getSelectedRecords()[0].executRid;

        $.ifvPostJSON('<ifvm:action name="deleteParamInfo"/>', {
            rid: paramRid
        }, function () {
            alert('삭제되었습니다.');
            infoExecuteParamGridFn();
        });
    }

    function modifyParamPopup(){
        if(jobStepParamDtlGrid.opt.gridControl.getSelectedRecords().length === 0) {
            alert('목록을 선택해 주세요.');
            return;
        }else{
            let paramRid = jobStepParamDtlGrid.opt.gridControl.getSelectedRecords()[0].executRid;
            paramPopup(paramRid);
        }
    }
</script>