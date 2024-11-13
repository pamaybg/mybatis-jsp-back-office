<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="gameRulePopValid">
    <div class="form-horizontal underline top_well">
        <div id="gameRuleDetail"></div>
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="btnGameRuleSave" objCode="gameRulePoptBtnSave_OBJ">
        <spring:message code="C00164" />
    </button>
    <button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="gameRulePoptBtnCancel_OBJ">
        <spring:message code="M00441" />
    </button>
</div>

<div id="offerPopupContainer" class="popup_container"></div>

<script type="text/javascript">

    var GameRulePop = function () {
        var _rid = 	ifvGlobal["gameRuleRid"];
        var _ridGame = ifvGlobal["gameRid"];
        var _formId = "gameRulePopValid";

        var isRoulette = ifvGlobal.gameType === "R";
        var isSlot = ifvGlobal.gameType === "C";
        var isDice = ifvGlobal.gameType === "D";

        var _rouletteForm = `
            <div class="row">
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineNm" label="L02882" labelClass="3" conClass="9"/>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="number" id="pieSizeRate" label="L02883" labelClass="3" conClass="2"/>
                    <div style="float: left">%</div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                     <ifvm:inputNew type="text" id="missionChar" label="L02884" labelClass="3" conClass="9"/>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineOfrNm" label="L02885" labelClass="3" conClass="8" disabled="true"/>
                    <span class="input-group-addon" style="padding: 6px;" id="btnLineOfrPop"> <a><i class="fa fa-search"></i></a></span>
                    <ifvm:inputNew type="hidden" id="ridLineOfr"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                     <ifvm:inputNew type="number" id="lineOfrQty" label="L02886" labelClass="3" conClass="2"/>
                     <div style="float: left">개</div>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="number" id="lineOfrAvailDay" label="L02887" labelClass="3" conClass="9"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                     <ifvm:inputNew type="number" id="lineWinRate" label="L02888" labelClass="3" conClass="2"/>
                     <div style="float: left">%</div>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="checkBox" id="budgtCloseYn" label="L02889" labelClass="3" conClass="9"/>
                </div>
            </div>
        `;

        var _slotForm = `
            <div class="row">
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineImgUrl" label="L02890" labelClass="3" conClass="9"/>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="checkBox" id="lineOfrYn" label="L02891" labelClass="3" conClass="9"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <ifvm:inputNew type="checkBox" id="firstSlotYn" label="L02892" labelClass="3" conClass="9"/>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="checkBox" id="specialYn" label="L02893" labelClass="3" conClass="9"/>
                </div>
            </div>
        `;

        var _diceForm = `
            <div class="row">
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineNm" label="L02882" labelClass="3" conClass="9"/>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineOfrNm" label="L02885" labelClass="3" conClass="8" disabled="true"/>
                    <span class="input-group-addon" style="padding: 6px;" id="btnLineOfrPop"> <a><i class="fa fa-search"></i></a></span>
                    <ifvm:inputNew type="hidden" id="ridLineOfr"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                     <ifvm:inputNew type="number" id="lineOfrQty" label="L02886" labelClass="3" conClass="2"/>
                     <div style="float: left">개</div>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="number" id="lineOfrAvailDay" label="L02887" labelClass="3" conClass="9"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                     <ifvm:inputNew type="number" id="lineWinRate" label="L02888" labelClass="3" conClass="2"/>
                     <div style="float: left">%</div>
                </div>
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="lineImgUrl" label="L02890" labelClass="3" conClass="9"/>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <ifvm:inputNew type="number" id="diceSumQty" label="L02894" labelClass="3" conClass="9"/>
                </div>
            </div>
        `;

        // 유효성 검사 초기화
        this.validation = $("#" + _formId ).ifvValidation(),
        this.setRid = function (rid) {
            ifvGlobal["gameRuleRid"] = rid;
            _rid = rid;
        },
        this.getRid = function () {
            return _rid;
        },
        this.getRidGame = function () {
            return _ridGame;
        },
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = null,
        this.setFields = function (fields) {
            this.fields = $.ifvGetFields(_formId);
        },
        /* Form 데이터 로드 */
        this.formDataLoad = function () {

            var _callback = function (result) {
                $.ifvLoadFormData(result, this.fields);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getGameRuleDetail"/>', {
                rid: this.getRid(),
                ridGame: this.getRidGame()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnGameRuleSave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                $.fn.ifvmPopupClose();
            }.bind(this));

            /* 오퍼 조회 팝업 */
            $('#btnLineOfrPop').on('click', function () {
                var targetFields = { name: "lineOfrNm", rid: "ridLineOfr" };
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopupContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');
            });

        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = this.isNew ? '<ifvm:action name="addGameRule"/>' : '<ifvm:action name="editGameRule"/>';

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {

                var vObj = $.ifvGetFieldData(this.fields);

                vObj["ridGame"] = this.getRidGame();

                if (!this.isNew) {
                    vObj['rid'] = this.getRid();
                }

                return vObj;
            }

            /* 제출 후 알럿창 및 화면 이동*/
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
                // 팝업 창 닫고
                $.fn.ifvmPopupClose();
                // 리스트 리로드
                ifvGlobal.gameRuleGrid.setGridAndDataLoad();
            };

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) this.onSubmit();
        },
        this.setGameSubFormByType = function() {
            var gameType = ifvGlobal.gameType;
            var subDetailForm = $("#gameRuleDetail");
            if (gameType === 'C') subDetailForm.append(_slotForm);
            else if (gameType === 'R') subDetailForm.append(_rouletteForm);
            else subDetailForm.append(_diceForm);
        },
        this.init = function () {
            this.setGameSubFormByType();
            this.setButtons();
            this.setFields();
            if (!this.isNew) {
                this.formDataLoad();
            }
        }
    }

    $(document).ready(function () {
        var gameRulePop = new GameRulePop();
        gameRulePop.init();
    });
</script>