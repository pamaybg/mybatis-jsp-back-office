<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var GameSubDetail = function () {
	    var _rouletteForm = `
                            <div>
                               <div class="row">
                                   <div class="col-xs-6">
                                       <ifvm:inputNew type="text" id="rlMissionText" label="L02867" labelClass="2" conClass="9" />
                                   </div>
                                   <div class="col-xs-6">
                                       <ifvm:inputNew type="text" id="ofrNm1" label="L02868" labelClass="2" conClass="8" disabled="true"/>
                                       <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop1"> <a><i class="fa fa-search"></i></a></span>
                                       <ifvm:inputNew type="hidden" id="ridOfr1"/>
                                   </div>
                               </div>
                               <div class="row">
                                   <div class="col-xs-6">
                                       <ifvm:inputNew type="number" id="ofr1Qty" label="L02869" labelClass="2" conClass="8"/><div style="float: left">개</div>
                                   </div>
                                   <div class="col-xs-6">
                                       <ifvm:inputNew type="number" id="ofr1AvailDay" label="L02870" labelClass="2" conClass="8"/><div style="float: left">일</div>
                                   </div>
                               </div>
                           </div>
                          `;

        var _slotForm = `
                        <div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="number" id="runItemCnt" label="L02871" labelClass="2" conClass="9" /><div style="float: left">개</div>
                                </div>
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="combiMaxAmt" label="L02872" labelClass="2" conClass="9" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="ofrNm1" label="L02873" labelClass="2" conClass="8" disabled="true"/>
                                    <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop1"> <a><i class="fa fa-search"></i></a></span>
                                    <ifvm:inputNew type="hidden" id="ridOfr1"/>
                                </div>
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="number" id="ofr1Qty" label="L02869" labelClass="2" conClass="8"/><div style="float: left">개</div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="text" id="ofrNm2" label="L02874" labelClass="2" conClass="8" disabled="true"/>
                                    <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop2"> <a><i class="fa fa-search"></i></a></span>
                                    <ifvm:inputNew type="hidden" id="ridOfr2"/>
                                </div>
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="number" id="ofr2Qty" label="L02905" labelClass="2" conClass="8"/><div style="float: left">개</div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <ifvm:inputNew type="number" id="lostRate" label="L02876" labelClass="4" conClass="6" /><div style="float: left">%</div>
                                </div>
                                <div class="col-xs-3">
                                    <ifvm:inputNew type="number" id="winRate1slot" label="L02877" labelClass="4" conClass="6" /><div style="float: left">%</div>
                                </div>
                                <div class="col-xs-3">
                                    <ifvm:inputNew type="number" id="winRateFirst" label="L02878" labelClass="4" conClass="6" /><div style="float: left">%</div>
                                </div>
                                <div class="col-xs-3">
                                    <ifvm:inputNew type="number" id="winRateSpecial" label="L02879" labelClass="4" conClass="6" /><div style="float: left">%</div>
                                </div>
                            </div>
                        </div>
                    `;

        var _diceForm = `
                        <div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <ifvm:inputNew type="number" id="runItemCnt" label="L02875" labelClass="2" conClass="8"/><div style="float: left">개</div>
                                </div>
                            </div>
                        </div>
        `;

	    var _rid = ifvGlobal["gameRid"];
	    var _formId = "gameSubDetail";
	    this.setRid = function (rid) {
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getGameType = function() {
            return ifvGlobal.gameType;
        },
        this.isNew = false,
		this.validation = $("#" + _formId).ifvValidation(),
        this.fields = null,
        this.setFields = function (fields) {
            this.fields = $.ifvGetFields(_formId);
        },
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;
					$.ifvLoadFormData(result, this.fields);
                } else {
                    this.isNew = true;
                    // 필드 데이터 초기화
                    $.ifvInitFields(this.fields);
                }
            };

            $.ifvSyncPostJSON('<ifvm:action name="getGameSubDetail"/>', { rid: this.getRid() }, _callback.bind(this));
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddGameSub").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnRemoveGameSub").click(function () {
                this.removeAction();
            }.bind(this));

            $("#btnOfrPop1").click(function () {
                var targetFields = { name : "ofrNm1", rid : "ridOfr1" };
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="M00794"/>');
            }.bind(this));

            $("#btnOfrPop2").click(function () {
                var targetFields = { name : "ofrNm2", rid : "ridOfr2" };
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="M00794"/>');
            }.bind(this));

        },
        /* 삭제 액션 */
        this.removeAction = function () {
            var _success = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.formDataLoad();
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeGameSub"/>', { rid: this.getRid() }, _success.bind(this), _fail.bind(this));
                    this.isNew = true;
                }
            }
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {
            	var vObj = {};
            	// 필드 데이터 가져오기
				var vObj = $.ifvGetFieldData(this.fields);
                vObj['rid'] = this.getRid();
                return vObj;
            }

            /* 제출 후 알럿창 */
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
                this.formDataLoad();
            }

            var submitUrl = (this.isNew) ? '<ifvm:action name="addGameSub"/>' : '<ifvm:action name="editGameSub"/>';

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {

            if (this.validation.confirm()) this.onSubmit();
        },
        this.setGameSubFormByType = function() {
            var gameType = this.getGameType();
            var subDetailForm = $("#"+ _formId);
            if (gameType === 'C') subDetailForm.append(_slotForm);
            else if (gameType === 'R') subDetailForm.append(_rouletteForm);
            else subDetailForm.append(_diceForm);
        },
        this.init = function () {
            this.setGameSubFormByType();
            this.setButtons();
            this.setFields();
            this.formDataLoad();
        }
	};

	var GameRuleList = function () {
    	    var _rid = null;
    	    var _ridGame = ifvGlobal["gameRid"];

    	    var isRoulette = ifvGlobal.gameType === "R";
    	    var isSlot = ifvGlobal.gameType === "C";
    	    var isDice = ifvGlobal.gameType === "D";

    	    this.dataUrl = '<ifvm:action name="getGameRuleList"/>';
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
            this.setGridAndDataLoad = function (url) {
                var _recordDoubleClick = function (args) {
                    var data = args.data;
                    this.setRid(data.rid);
                    $.fn.ifvmPopupOpen('popupContainer', this.getRid(), '<ifvm:url name="gameRuleDetailPop"/>', '<spring:message code="L02866"/>', 860);
                };
                var _serializeGridData = function (data) {
                    data.ridGame = this.getRidGame();
                    return data;
                };
                var _rowSelected = function (args) {
                    var data = args.data;
                    this.setRid(data.rid);
                };

                var ejGridOption = {
                    recordDoubleClick: _recordDoubleClick.bind(this),
                    serializeGridData: _serializeGridData.bind(this),
                    rowSelected: _rowSelected.bind(this),
                    dataUrl: url || this.dataUrl,
                    columns: [{
                        field: 'lineNm',
                        headerText: '<spring:message code="L02882"/>',
                        textAlign : 'left',
                        visible: isRoulette || isDice,
                        customAttributes: {
                            searchable: isRoulette || isDice
                        }
                    }, {
                        field: 'pieSizeRate',
                        headerText: '<spring:message code="L02883"/>',
                        textAlign : 'right',
                        visible: isRoulette
                    }, {
                        field: 'missionChar',
                        headerText: '<spring:message code="L02884"/>',
                        textAlign : 'center',
                        visible: isRoulette,
                        customAttributes: {
                            searchable: isRoulette
                        }
                    }, {
                        field: 'lineOfrNm',
                        headerText: '<spring:message code="L02885"/>',
                        textAlign : 'left',
                        visible: isRoulette || isDice,
                    }, {
                        field: 'lineOfrQty',
                        headerText: '<spring:message code="L02886"/>',
                        textAlign : 'right',
                        visible: isRoulette || isDice,
                        customAttributes: {
                            searchable: isRoulette || isDice
                        }
                    }, {
                        field: 'lineOfrAvailDay',
                        headerText: '<spring:message code="L02887"/>',
                        textAlign : 'right',
                        visible: isRoulette || isDice,
                        customAttributes: {
                            searchable: isRoulette || isDice
                        }
                    }, {
                        field: 'lineWinRate',
                        headerText: '<spring:message code="L02888"/>',
                        textAlign : 'right',
                        visible: isRoulette || isDice,
                        customAttributes: {
                            searchable: isRoulette || isDice
                        }
                    }, {
                        field: 'budgtCloseYn',
                        headerText: '<spring:message code="L02889"/>',
                        textAlign : 'center',
                        visible: isRoulette,
                        customAttributes: {
                            searchable: isRoulette
                        }
                    }, {
                        field: 'lineImgUrl',
                        headerText: '<spring:message code="L02890"/>',
                        textAlign : 'left',
                        visible: isSlot || isDice,
                        customAttributes: {
                            searchable: isSlot || isDice
                        }
                    }, {
                       field: 'lineOfrYn',
                       headerText: '<spring:message code="L02891"/>',
                       textAlign : 'center',
                       visible: isSlot,
                       customAttributes: {
                           searchable: isSlot
                       }
                    }, {
                        field: 'firstSlotYn',
                        headerText: '<spring:message code="L02892"/>',
                        textAlign : 'center',
                        visible: isSlot,
                        customAttributes: {
                            searchable: isSlot
                        }
                    }, {
                        field: 'specialYn',
                        headerText: '<spring:message code="L02893"/>',
                        textAlign : 'center',
                        visible: isSlot,
                        customAttributes: {
                            searchable: isSlot
                        }
                    }, {
                        field: 'diceSumQty',
                        headerText: '<spring:message code="L02894"/>',
                        textAlign : 'right',
                        visible: isDice,
                        customAttributes: {
                            searchable: isDice
                        }
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="L01996"/>',
                        textAlign : 'center',
                    },{
                       field: 'rid',
                       visible: false
                   }],
                    requestGridData: {
                        sidx: 'createDate'
                    },
                    radio: true,
                };
                $("#gameRuleGrid").ifvsfGrid({
                    ejGridOption: ejGridOption
                });
            },
            /* 버튼 클릭 시 액션 세팅 */
            this.setButtons = function () {
                $("#btnAddGameRule").click(function () {
                    this.setRid(null);
                    $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="gameRuleDetailPop"/>', '<spring:message code="L02866"/>', 860);
                }.bind(this));

                $("#btnRemoveGameRule").click(function () {
                    this.removeAction();
                }.bind(this));
                // btnPreview
                $("#btnPreview").click(function () {
	                    $.fn.ifvmPopupOpen('popupContainer', this.getRid(), '<ifvm:url name="gameSubDetailPreview"/>', '<spring:message code="L02861"/>', 640);
                }.bind(this));
            },
            /* 삭제 액션 */
            this.removeAction = function () {
                var _success = function () {
                    $.ifvProgressControl(false);
                    alert('<spring:message code="L00085"/>');
                    this.setGridAndDataLoad();
                };

                var _fail = function (result) {
                    alert(result.message);
                    $.ifvProgressControl(false);
                };

                var _rid = this.getRid();

                if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                    if (confirm('<spring:message code="L00086"/>')) {
                        $.ifvProgressControl(true);
                        $.ifvPostJSON('<ifvm:action name="removeGameRule"/>', { rid: _rid }, _success.bind(this), _fail);
                    }
                }
            },
            this.init = function () {
                this.setGridAndDataLoad();
                this.setButtons();
            }
    	};

	$(document).ready(function () {
		var gameSubDetail = new GameSubDetail();
		gameSubDetail.init();

        gameRuleGrid = new GameRuleList();
        ifvGlobal['gameRuleGrid'] = gameRuleGrid;
        gameRuleGrid.init();
	});
</script>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span>
            <spring:message code="L02866" /></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="check" text="L00125" id="btnAddGameSub" objCode="gameSubDetailAddGameSub_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveGameSub" objCode="gameSubDetailRemoveGameSub_OBJ"/>
    </div>
</div>
<div id="gameSubDetail"></div>
<br/>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02866" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddGameRule" objCode="gameSubDetailAddGameRule_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveGameRule" objCode="gameSubDetailRemoveGameRule_OBJ"/>
		<ifvm:inputNew type="button" text="L02861" id="btnPreview" objCode="gameSubDetailPreview_OBJ"/>
	</div>
</div>
<div id="gameRuleGrid"></div>