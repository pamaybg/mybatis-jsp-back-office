<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
<script>
    var subFlag = 0;
    /* effStartDayCnt = null;
    effStartDate = null;
    effStartDayCnt = null; */
    /* 채널 조회 팝업  */
    function btnChnlPop() {
        $.fn.ifvmPopupOpen('popupContainer', null,
            '<ifvm:url name="chnlPop"/>',
            '<spring:message code="L00126"/>', 860, true, true);
    }

    /* 오퍼 그룹 조회 팝업 */
    function btnOfrgrpPop() {
        /* $.fn.ifvmPopupOpen('popupContainer', null,
                '

        <ifvm:url name="ofrgrpPop"/>',
                '

        <spring:message code="O00005"/>', 860, true, true); */
    }

    var OfferDetail = function (rid) {
        // 프로그램 RID
        var _rid = rid;
        var _formId = 'offerDetail';

        this.setRid = function (rid) {
            ifvGlobal["offerRid"] = rid;
            _rid = rid;
        },
            this.getRid = function () {
                return _rid;
            },
            // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
            this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
            // 유효성 검사 초기화
            this.validation = $("#" + _formId).ifvValidation(),
            this.fields = $.ifvGetFields(_formId),
            this.priceFields = ["feeAmt", "ofrCostAmt", "feeShareBaseAmt", "ofrValAmt"],
            this.optionFields = [
                {fieldName: "statCd", commCode: "LOY_OFR_STAT_TYPE"},
                {fieldName: "ofrCtg", commCode: "LOY_OFR_MST_TYPE"},
                {fieldName: "ofrSubType", commCode: "X_DK_OFR_SUB_TYPE"},
                {fieldName: "ofrType", commCode: "COM_OFR_TYPE"},
                {fieldName: "ofrValType", commCode: "LOY_OFR_VAL_TYPE", isFirstLowBlank: true},
                {fieldName: "settleType", commCode: "LOY_OFR_SETTLE_TYPE"},
                {fieldName: "expirType", commCode: "LOY_OFR_EXPIR_TYPE", isFirstLowBlank: true},
                {fieldName: "maxLimitTypeCd", commCode: "LOY_OFR_MAX_LIMT_TYPE_CD", isFirstLowBlank: true},
                {fieldName: "refCd", commCode: "LOY_OFR_REF_TYPE_CD", isFirstLowBlank: true},
                {fieldName: "effDateType", commCode: "PACT_EFF_DATE_TYPE", isFirstLowBlank: true},
                {fieldName: "useExpirType", commCode: "LOY_CPN_EXPIR_TYPE"},
            ],
            /* Form 데이터 로드 */
            this.formDataLoad = function () {
                var _callback = function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        // 필드의 데이터 로드
                        $.ifvLoadFormData(result, this.fields, this.optionFields);
                        $("#ofrSubType option[value='P']").remove();
                        //$("#ofrType option[value='PP']").remove();
                        this.priceFields.forEach(function (vf) {
                            var vfVal = $('#' + vf).val();
                            $('#' + vf).val($.fn.ifvmNumberWithCommas(vfVal));
                            $('#' + vf).css("text-align", "right");

                            if (result.useFixStartDate != null) {
                                $("#useFixStartDate").val(result.useFixStartDate.substring(0, 10));
                            }

                            if (result.useFixEndDate != null) {
                                $("#useFixEndDate").val(result.useFixEndDate.substring(0, 10));
                            }

                            /*$("#useMaxDcAmt").val($.ifvNumberFormat(result.useMaxDcAmt));
                            $("#useMinPurAmt").val($.ifvNumberFormat(result.useMinPurAmt));*/
                            $("#ofrValAmt").val($.ifvNumberFormat(result.ofrValAmt));

                            chkofrSubType();

                            if ($("#useExpirType").val() == "FIX") {
                                /* 고정기간일 경우 고정유효기간 활성화  */
                                $("#useFixStartDate").attr("disabled", false);
                                $("#useFixEndDate").attr("disabled", false);
                                $("#useExpirDayCnt").attr("disabled", true);
                                $("#useExpirDayCnt").val("");
                                $("#useExpirDayCnt").attr("required", false);

                            } else if ($("#useExpirType").val() == "NA") {
                                /*기간 제한 없을 경우 오른쪽 텍스트 */
                                $("#useExpirDayCnt").attr("disabled", true);
                                $("#useExpirDayCnt").val("");
                                $("#useExpirDayCnt").removeAttr("required", false);
                                $("#useFixStartDate").attr("disabled", true);
                                $("#useFixEndDate").attr("disabled", true);
                                $("#useFixStartDate").val("");
                                $("#useFixEndDate").val("");
                            } else {
                                $("#useFixStartDate").attr("disabled", true);
                                $("#useFixEndDate").attr("disabled", true);
                                $("#useFixStartDate").val("");
                                $("#useFixEndDate").val("");
                                $("#useExpirDayCnt").attr("required", true);
                                $("#useExpirDayCnt").attr("disabled", false);

                            }
                        });

                    }
                }

                $.ifvSyncPostJSON('<ifvm:action name="getOfferDetail"/>', {rid: this.getRid()}, _callback.bind(this));
                //$.ifvSyncPostJSON('<ifvm:action name="getCouponDetail"/>', { ridOfr:this.getRid()}, _callback.bind(this));


                ofrValTypeChange();
                cpnYnChange();
                ofrSubTypeChange();
                expirMmChange();
                if ($("#effDateType").val() == 'D') {
                    $("#effStartDayCnt").attr("disabled", true);
                    $("#effStartDate").attr("disabled", true);
                    $("#effStartDate").val('');
                    $("#effStartDayCnt").val('');
                } else if ($("#effDateType").val() == 'A') {
                    $("#effStartDayCnt").attr("disabled", false);
                    $("#effStartDate").attr("disabled", true);
                    $("#effStartDate").val('');
                    /* $('#effStartDayCnt').attr("type", "number"); */
                } else if ($("#effDateType").val() == 'P') {
                    $("#effStartDayCnt").attr("disabled", true);
                    $("#effStartDayCnt").val('');
                    $("#effStartDate").attr("disabled", false);
                    var effStartDate = $("#effStartDate");
                    effStartDate.ifvDateChecker({});
                    /* $('#effStartDayCnt').attr("type", "text");
                    var effStartDayCnt = $("#effStartDayCnt");
                    effStartDayCnt.ifvDateChecker({

                    });*/

                }
            },
            this.setCalendar = function () {
                var issStartDate = $("#issStartDate");
                var issEndDate = $("#issEndDate");
                var issStartTime = $("#issStartTime");
                var issEndTime = $("#issEndTime");

                var useFixStartDate = $("#useFixStartDate");
                var useFixEndDate = $("#useFixEndDate");

                var startDate = $('#validStartDate');
                var endDate = $('#validEndDate');

                var validStartDate = $("#validStartDate");
                var validEndDate = $("#validEndDate");


                issStartTime.timepicker({
                    defaultTime: '00:00',
                    timeFormat: 'H:i',
                    showMeridian: false
                });

                issEndTime.timepicker({
                    defaultTime: '00:00',
                    timeFormat: 'H:i',
                    showMeridian: false
                });

                if (this.isNew == true) {
                    issStartDate.val($("#validStartDate").val());
                    issEndDate.val($("#validEndDate").val());

                    //오늘날짜
                    startDate.val($.ifvGetTodayDate());
                    //오늘부터 한달 뒤
                    endDate.val($.ifvGetNewDate('m', +99).newDateS);
                }
                issStartDate.ifvDateChecker({
                    maxDate: issEndDate
                });
                issEndDate.ifvDateChecker({
                    minDate: issStartDate
                });

                useFixStartDate.ifvDateChecker({
                    maxDate: useFixEndDate
                });
                useFixEndDate.ifvDateChecker({
                    minDate: useFixStartDate
                });

                //validEndDate.val('2090-12-31');
                validStartDate.ifvDateChecker({
                    maxDate: validEndDate
                });
                validEndDate.ifvDateChecker({
                    minDate: validStartDate
                });

                startDate.ifvDateChecker({
                    maxDate: endDate
                });
                endDate.ifvDateChecker({
                    minDate: startDate
                });
            }, this.setChange = function () {
            $('#useExpirDayCnt').change(function () {
                if ($("#useExpirType").val() == 'DAY') {
                    if ($("#useExpirDayCnt").val() == '0') {
                        $("#info2").text("(발급일로부터 당일까지)");
                    } else $("#info2").text("(발급일로부터 " + $("#useExpirDayCnt").val() + "일 후 까지)");
                } else if ($("#useExpirType").val() == 'MONTH') {
                    if ($("#useExpirDayCnt").val() == '0') {
                        $("#info2").text("(발급일로부터 당일까지)");
                    } else $("#info2").text("(발급일로부터 " + $("#useExpirDayCnt").val() + "개월 후 까지)");
                } else if ($("#useExpirType").val() == 'YEAR') {
                    if ($("#useExpirDayCnt").val() == '0') {
                        $("#info2").text("(발급일로부터 당일까지)");
                    } else $("#info2").text("(발급일로부터 " + $("#useExpirDayCnt").val() + "년 후 까지)");
                } else if ($("#useExpirType").val() == 'EOM') {
                    if ($("#useExpirDayCnt").val() == '0') {
                        $("#info2").text("(발급일로부터 당월 말일까지)");
                    } else $("#info2").text("(발급일로부터 " + $("#useExpirDayCnt").val() + "개월 후 말일 까지)");
                } else if ($("#useExpirType").val() == 'EOY') {
                    if ($("#useExpirDayCnt").val() == '0') {
                        $("#info2").text("(발급일로부터 금년 12월31일까지)");
                    } else $("#info2").text("(발급일로부터 " + $("#useExpirDayCnt").val() + "년 후 12월31일까지)");
                } else if ($("#useExpirType").val() == 'NA') {
                    $("#info2").text('');
                } else if ($("#useExpirType").val() == 'FIX') {
                    $("#info2").text('');
                }


            });

            $("#useExpirType").change(function () {
                $("#info2").text('');
                $("#useExpirDayCnt").val('');

            });

            $('#issType').change(function () {
                issTypeChange();
            });
        },

            /* 버튼 세팅 */
            this.setButtons = function () {
                $("#btnSave").click(function () {
                    if($("#ofrType").val() == "P" && ($("#ofrValAmt").val() == 0 || $("#ofrValAmt").val() == null)){
                        alert("가치 값을 입력해주세요.")
                        return false;
                    }
                    this.saveAction();
                }.bind(this));

                $("#btnList").click(function () {
                    qtjs.href('<ifvm:url name="campaignCpnList"/>');
                });

            },
            /* 메뉴 세팅 */
            this.setMenu = function () {
                $.ifvmLnbSetting('campaignCpnList');
            },
            /* Form 데이터 제출 */
            this.onSubmit = function () {
                var resultRid = null;
                var _submitUrl = this.isNew ? '<ifvm:action name="addOffer"/>' : '<ifvm:action name="editOffer"/>';

                /* submit을 위한 Form 데이터 파라미터 세팅 */
                var _setSubmitParams = function () {
                    var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
                    $("#ofrSubType option[value='P']").remove();

                    vObj['useMaxDcAmt'] = $("#useMaxDcAmt").val().replace(/,/g, '');
                    vObj['useMinPurAmt'] = $("#useMinPurAmt").val().replace(/,/g, '');

                    //$("#ofrType option[value='PP']").remove();
                    if (!this.isNew) {
                        vObj['rid'] = this.getRid();
                        resultRid = this.getRid();
                    }
                    /*                    this.priceFields.forEach(function(vf) {
                                            vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
                                        });*/

                    return vObj;
                }

                /* 제출 후 알럿창 */
                var _afterSubmit = function (result) {
                    resultRid = result.message;
                    alert('<spring:message code="L00127"/>');
                    if (this.isNew) {
                        qtjs.href('<ifvm:url name="offerCampaignDetail"/>' + '?rid=' + resultRid);
                    }
                };
                $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));

            },
            this.getOfrCpnCnt = function () {
                $.ifvSyncPostJSON('<ifvm:action name="getOfrCpnCnt"/>', {rid: $.ifvGetParams().rid}, function (result) {
                    $("#cpnCnt").val(result);
                }.bind(this));
            },
            /* 저장 버튼클릭 시 확인 */
            this.saveAction = function () {
                if ($("#statCd").val() == 'A' && $("#cpnYn").is(":checked")) {
                    this.getOfrCpnCnt();
                    if ($("#cpnCnt").val() == '0') {
                        alert("활성된 쿠폰오퍼는 쿠폰정책 저장이 필요합니다.");
                        return;
                    }
                }


                if ($("#cpnYn").is(":checked")) {
                    if ($("#ofrType").val() == 'DD' || $("#ofrType").val() == 'D5' || $("#ofrType").val() == 'D6') {
                        if ($("#ofrValType").val() == '' || $("#ofrValAmt").val() == '') {
                            alert("쿠폰형(금액할인,무료배송)의 가치 수량 항목은 필수입니다.");
                            return;
                        }
                    }
                }

                if ($("#cpnYn").is(":checked")) {
                } else {
                    $("#ofrValAmt").attr("required", false);
                }

                if (this.validation.confirm()) this.onSubmit();
            },
            this.setCommaKeyup = function () {
                this.priceFields.forEach(function (vf) {
                    $('#' + vf).keyup(function () {
                        var vfVal = $('#' + vf).val();
                        $('#' + vf).val($.fn.ifvmNumberWithCommas(vfVal));
                        $('#' + vf).css("text-align", "right");
                    });
                })
            }, this.setEvent = function () {

            $("#issMaxCnt, #useExpirDayCnt, #usableMaxCnt").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ""));
            });

            $("#useMaxDcAmt, #useMinPurAmt").keyup(function () {
                $(this).val($.fn.ifvmNumberWithCommas(this.value));
            });

            $("#useExpirType").change(function () {
                var expireType = $(this).val();

                if (expireType == "FIX") {
                    /* 고정기간일 경우 고정유효기간 활성화  */
                    $("#useFixStartDate").attr("disabled", false);
                    $("#useFixEndDate").attr("disabled", false);
                    $("#useExpirDayCnt").attr("disabled", true);
                    $("#useExpirDayCnt").val("");
                    $("#useExpirDayCnt").attr("required", false);
                } else if (expireType == "NA") {
                    /* 유효기간 구분 값이 기한 제한 없음일 경우 고정유효 기간 disabled */
                    $("#useExpirDayCnt").attr("disabled", true);
                    $("#useExpirDayCnt").val("");
                    $("#useExpirDayCnt").removeAttr("required", false);
                    $("#useFixStartDate").attr("disabled", true);
                    $("#useFixEndDate").attr("disabled", true);
                    $("#useFixStartDate").val("");
                    $("#useFixEndDate").val("");
                } else {
                    $("#useFixStartDate").attr("disabled", true);
                    $("#useFixEndDate").attr("disabled", true);
                    $("#useFixStartDate").val("");
                    $("#useFixEndDate").val("");
                    $("#useExpirDayCnt").attr("disabled", false);
                    $("#useExpirDayCnt").attr("required", true);
                }
            });


        },
            /* 페이지 초기화 */
            this.init = function () {
                if (!this.isNew) {
                    this.formDataLoad();
                } else {
                    $.ifvSetSelectOptions(this.optionFields);

                    //$("#ofrSubType option[value='P']").remove();
                    //$("#ofrSubType").val('D');
                    //$("#ofrSubType").trigger("change");
                    $("#statCd").attr('disabled', true);
                    $("#cpnYn").attr('checked', true);
                    $("#ofrCtg").val('C');
                    //select box 기본 설정
                    $("#ofrType").val("P").prop("selected", true);
                    $("#ofrSubType option:eq(0)").prop("selected", true);
                    $("#ofrValType").val("F").prop("selected", true);
                }

                this.setCommaKeyup();
                this.setCalendar();
                this.setEvent();
                this.setMenu();
                this.setButtons();
                this.setChange();
            }
    }

    function ofrValTypeChange() {
        if ($("#ofrValType").val() == 'R') {
            $("#info").text("%");
            $("#ofrValAmt").attr("disabled", false);
        } else if ($("#ofrValType").val() == 'F') {
            $("#info").text("원");
            $("#ofrValAmt").attr("disabled", false);
        } else if ($("#ofrValType").val() == 'A') {
            $("#info").text("");
            $("#ofrValAmt").val("");
            $("#ofrValAmt").attr("disabled", true);
        } else if ($("#ofrValType").val() == 'B') {
            $("#info").text("원");
            $("#ofrValAmt").attr("disabled", false);
        }
    }

    function effStartDateChange() {
        if ($("#effDateType").val() == 'D') {
            $("#effStartDayCnt").attr("disabled", true);
            $("#effStartDate").attr("disabled", true);
            $("#effStartDate").val('');
            $("#effStartDayCnt").val('');
        } else if ($("#effDateType").val() == 'A') {
            $("#effStartDayCnt").attr("disabled", false);
            $("#effStartDate").attr("disabled", true);
            $("#effStartDate").val('');
            /* $('#effStartDayCnt').attr("type", "number"); */
        } else if ($("#effDateType").val() == 'P') {
            $("#effStartDayCnt").attr("disabled", true);
            $("#effStartDayCnt").val('');
            $("#effStartDate").attr("disabled", false);
            var effStartDate = $("#effStartDate");
            effStartDate.ifvDateChecker({});

        }
    }

    function cpnYnChange() {
        if ($("#cpnYn").prop("checked") == true) {
            $("#expirType").val('');
            $("#expirType").attr("disabled", true);
            $("#expirMM").val('');
            $("#expirMM").attr("disabled", true);
            $("#effDateType").val('');
            $("#effDateType").attr("disabled", true);
        } else {
            $("#expirType").attr("disabled", false);
            $("#expirMM").attr("disabled", false);
            $("#effDateType").attr("disabled", false);
        }
    }

    function ofrSubTypeChange() {
        if ($("#ofrSubType").val() == 'P') {
            $("#ofrValType").val("");
            $("#ofrValAmt").val("");
            $("#ofrValType").attr("disabled", true);
            $("#ofrValAmt").attr("disabled", true);
            $("#cpnYn").attr("disabled", true);
        } else {
            $("#ofrValType").attr("disabled", false);
            $("#ofrValAmt").attr("disabled", false);
            $("#cpnYn").attr("disabled", false);
        }
    }

    function setChannelCalendar() {
        var effStartDate = $("#effStartDate");

        effStartDate.ifvDateChecker({});
    }


    function checkOnlyOne(element) { // vocYn/empYn 체크박스 중 하나만 선택 처리 함수
        var checkedId = element.target.id;

        if ((checkedId == 'empYn') && ($("#empYn").is(":checked"))) {
            if ($("#vocYn").is(":checked")) {
                $('#vocYn').attr('checked', false);
            }
        } else if ((checkedId == 'vocYn') && ($("#vocYn").is(":checked"))) {
            if ($("#empYn").is(":checked")) {
                $('#empYn').attr('checked', false);
            }
        }
    }

    function ofrStatSaveValid() {
        if ($("#statCd").val() != 'W') {
            //오퍼 마스터
            $("#btnSave").attr('disabled', true);

            //쿠폰 정책
            $("#couponbtnSave").attr('disabled', true);
            $("#initCoupon").attr('disabled', true);

            //사용 가능 채널
            $("#btnAddOfferJoinChnl").attr('disabled', true);
            $("#btnRemoveOfferJoinChnl").attr('disabled', true);
            $("#btnRemoveOfferJoinAllChnl").attr('disabled', true);
            $("#btnUpload").attr('disabled', true);

            //사용 가능 상품
            $("#btnAddOfferJoinProd").attr('disabled', true);
            $("#btnRemoveOfferJoinProd").attr('disabled', true);
            $("#btnRemoveOfferJoinAllProd").attr('disabled', true);
            $("#btnUpload").attr('disabled', true);

            //사용 불가능 상품
            $("#btnAddOfferJoinProd").attr('disabled', true);
            $("#btnRemoveOfferJoinProd").attr('disabled', true);
            $("#btnRemoveOfferJoinAllProd").attr('disabled', true);
            $("#btnUpload").attr('disabled', true);

            //프로그램
            $("#btnAddOfferJoinPgm").attr('disabled', true);
            $("#btnRemoveOfferJoinPgm").attr('disabled', true);

        }
    }

    function expirMmChange() {
        if ($("#expirType").val() == 'DAY') {
            if ($("#expirMM").val() == '0') {
                $("#info3").text("(유효시작일로부터 당일까지)");
            } else $("#info3").text("(유효시작일로부터 " + $("#expirMM").val() + "일 후 까지)");
        } else if ($("#expirType").val() == 'MONTH') {
            if ($("#expirMM").val() == '0') {
                $("#info3").text("(유효시작일로부터 당일까지)");
            } else $("#info3").text("(유효시작일로부터 " + $("#expirMM").val() + "개월 후 까지)");
        } else if ($("#expirType").val() == 'YEAR') {
            if ($("#expirMM").val() == '0') {
                $("#info3").text("(유효시작일로부터 당일까지)");
            } else $("#info3").text("(유효시작일로부터 " + $("#expirMM").val() + "년 후 까지)");
        } else if ($("#expirType").val() == 'EOM') {
            if ($("#expirMM").val() == '0') {
                $("#info3").text("(유효시작일로부터 당월 말일까지)");
            } else $("#info3").text("(유효시작일로부터 " + $("#expirMM").val() + "개월 후 말일 까지)");
        } else if ($("#expirType").val() == 'EOY') {
            if ($("#expirMM").val() == '0') {
                $("#info3").text("(유효시작일로부터 금년 12월31일까지)");
            } else $("#info3").text("(유효시작일로부터 " + $("#expirMM").val() + "년 후 12월31일까지)");
        } else if ($("#expirType").val() == 'NA') {
            $("#info3").text('');
        } else if ($("#expirType").val() == 'FIX') {
            $("#info3").text('');
        }


    }

    function expirTypeChange() {
        $("#info3").text('');
        $("#expirMM").val('');
    }

    function chkofrSubType(){
        $("#useMinPurAmt").attr("disabled", true);
        $("#useMaxDcAmt").attr("disabled", true);
        $("#useExpirType").attr("disabled", true);

        if($("#ofrType").val() == "C"){
            $("#ofrValType").attr("disabled", true);
            $("#ofrValAmt").attr("disabled", true);
            $("#useExpirDayCnt").attr("disabled", true);
            $("#payDescript").attr("disabled", true);
            $("#cpndescText").attr("disabled", true);
            $("#ofrSubType").empty();
            $("#ofrSubType").attr("disabled", true);
            $("#ofrSubType").attr("required", false);
            $("#useExpirDayCnt").attr("required", false);
            $("#useExpirDayCnt").val("");
            $("#cpndescText").attr("required", false);
            $("#cpndescText").val("");
            $("#ofrValAmt").attr("required", false);
            if(subFlag != 0){
                $("#ofrValAmt").val("0");
            }
            /*$("#ofrSubType option").hide();

            $("#ofrSubType option:eq(0)").prop("selected", true);*/
        } else{
            $("#ofrValType").attr("disabled", false);
            $("#ofrValAmt").attr("disabled", false);
            $("#useExpirDayCnt").attr("disabled", false);
            $("#payDescript").attr("disabled", false);
            $("#ofrValType").val("F").prop("selected", true);
            $("#ofrValType").attr("disabled", true);
            $("#ofrSubType").attr("disabled", false);
            $("#ofrSubType").attr("required", true);
            $("#useExpirDayCnt").attr("required", true);
            $("#cpndescText").attr("disabled", false);
            $("#cpndescText").attr("required", true);
            $("#ofrValAmt").attr("required", true);
            if(subFlag != 0){
                $.fn.ifvmSetSelectOptionCommCode("ofrSubType", "X_DK_OFR_SUB_TYPE", null, null, true);
            }
        }
    }


    $(document).ready(function () {
        setChannelCalendar();
        $("#hqSettleRate").val("100");
        $("#useFixEndDate").attr("disabled", true);

        var urlParams = $.ifvGetParams();
        var _rid = urlParams.rid;
        ifvGlobal["offerRid"] = _rid;

        var offerGrid = new OfferDetail(_rid);
        ifvGlobal["offerGrid"] = offerGrid;

        offerGrid.init();

        $("#ofrValType option[value='B']").remove();
        $("#useExpirType option[value='NA']").remove();
        // $("#ofrType option[value='C']").remove();
        $("#ofrType option[value='S']").remove();
        $("#useExpirType option[value='MONTH']").remove();
        $("#useExpirType option[value='YEAR']").remove();
        $("#useExpirType option[value='EOM']").remove();
        $("#useExpirType option[value='EOY']").remove();
        $("#useExpirType option[value='FIX']").remove();

        chkofrSubType();

        subFlag = 1;

        //본사 100% -> 본사부담율 100% 처리
        $("#settleType").change(function () {
            if ($("#settleType").val() == 'A') {
                $("#hqSettleRate").val(100);
            } else {
                $("#hqSettleRate").val(0);
            }
        });

        $('#ofrType').change(function () {
            chkofrSubType();
        });

        $('#ofrSubType').change(function () {
            //ofrSubTypeChange();
            /*if ($("#ofrSubType").val() == 'D' || $("#ofrSubType").val() == 'G') {
                $("#cpnYn").attr("checked", true);
            } else {
                $("#cpnYn").attr("checked", false);
            }*/
        });

        $('#ofrValType').change(function () {
            ofrValTypeChange();

        });

        $('#effDateType').change(function () {
            effStartDateChange();

        });
        $('#cpnYn').change(function () {
            cpnYnChange();

        });

        // Voc지급/임직원지급 checkBox 클릭 시 : 택1
        $('.vocAndEmpChk').change(function (args) { // change로 할지 click 으로 할지 이따 판단
            checkOnlyOne(args);
        });

        ofrStatSaveValid();

        $("#expirMM").change(function () {

            expirMmChange();
        });

        $("#expirType").change(function () {

            expirTypeChange();
        });

        $("#useExpirType").change(function () {
            $("#useExpirDayCnt").val('');

        });

        $('.helpBtn').hover(function () {
            // Hover over code
            var text = $(this).children(".helptxt").html();
            $(this).data('tipText', text).removeAttr('title');
            $('<p class="tooltip"></p>')
                .html(text)
                .appendTo('body')
                .fadeIn('slow');
        }, function () {
            // Hover out code
            $('.tooltip').remove();
        }).mousemove(function (e) {
            var mousex = e.pageX + 20; //Get X coordinates
            var mousey = e.pageY + 10; //Get Y coordinates
            $('.tooltip')
                .css({top: mousey, left: mousex})
        });

    });
</script>

<div class="page-title">
    <h1>
        <spring:message code="O00014"/>
        &gt; <spring:message code="상세"/>
        <lable style="color:#191970"><%--&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; ※ 쿠폰형 오퍼 신규 생성 및 변경(쿠폰정책포함) 후 자사몰관리화면의 통합쿠폰동기화 버튼을 클릭하세요.</lable>--%>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7"> <!-- 기본정보 및 유형 -->
            <span><spring:message code="O00041"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="offerCamDetailSave_OBJ"/>
            <button class="btn btn-sm" id="btnList" objCode="offerCamDetailList_OBJ">
                <spring:message code="M00002"/>
            </button>
        </div>
    </div>
    <div id="offerDetail">
        <div class="form-horizontal underline top_well">
            <div class="col-xs-12">
                <!-- 오퍼 명 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="ofrNm" label="O00007" labelClass="2" conClass="8" required="true"/>
                    <ifvm:inputNew type="hidden" label="분류/번호" labelClass="2" names="ofrCtg" id="ofrCtg" conClass="4"
                                   disabled="true"/>
                </div>
                <!-- 오퍼 번호 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="ofrNo" conClass="8" disabled="true" label="오퍼번호" labelClass="2"/>
                </div>
            </div>
            <div class="row ">
                <!-- 오퍼적용가능기간 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="dateTerm" startDto="validStartDate" endDto="validEndDate"
                                   startId="validStartDate" endId="validEndDate" required="true" label="O00017"
                                   labelClass="2" conClass="8"/>
                </div>
                <!-- 작성자 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="createBy" label="L02561" labelClass="2" conClass="8"
                                   disabled="true"/>
                </div>
            </div>
            <div class="row ">
                <%--                <div class="col-xs-6">
                                    <!-- 대유형 -->
                                    <ifvm:inputNew type="select" id="ofrSubType" names="ofrSubType" label="O00019" labelClass="2" conClass="8" required="true"/>
                                </div>--%>
                <div class="col-xs-6">
                    <!-- 대유형 -->
                    <ifvm:inputNew type="select" id="ofrType" names="ofrType" label="O00019" labelClass="2"
                                   conClass="8" required="true"/>
                </div>

                <!-- 작성일 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="createDate" label="M03078" labelClass="2" conClass="8"
                                   disabled="true"/>
                </div>


            </div>
            <div class="row ">
                <div class="col-xs-6">
                    <!-- 소유형 -->
                    <ifvm:inputNew type="select" id="ofrSubType" names="ofrSubType" label="O00020" labelClass="2" conClass="8"
                                   required="true"/>
                </div>
                <!-- 상태 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="statCd" names="statCd" label="O00018" labelClass="2" conClass="8"
                                   required="true"/>
                </div>
            </div>
            <!-- 설명 -->
            <div class="rows">
                <%-- <div class="col-xs-2">
            <div style="float: left;padding-top: 5px;padding-left: 73px;padding-right: 6px; font-size: 13px;"><spring:message code="O00016" /></div>
                        <label class="col-xs-1 control-label"><spring:message code="O00016"/></label>
                </div> --%>
                <div class="col-xs-12">
                    <ifvm:inputNew type="textarea" id="descText" conClass="10" label="O00016" labelClass="1" rows="4"
                                   maxLength="2000"/>
                </div>
            </div>
        </div>

        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code="O00158"/></span>
            </div>

        </div>

        <div class="half_wrap top_well">
            <!-- 가치 -->
            <div class="page_btn_area">
                <div class="col-xs-6">
                    <span> <spring:message code="지급 조건"/></span>
                </div>
            </div>
            <div class="form-horizontal top_well underline">

                <div class="row">
                    <!-- 유효기간 구분 -->
                    <div class="col-xs-6">
                        <ifvm:inputNew type="select" id="useExpirType" names="useExpirType" label="O00133"
                                       labelClass="3" conClass="3" required="true"/>
                        <ifvm:inputNew type="text" id="useExpirDayCnt" names="useExpirDayCnt"  conClass="3" maxLength="10" required="true"/><!-- (일) -->
                    </div>
                    <div class="col-xs-6">
                        <!-- 가치 -->
                        <ifvm:inputNew type="select" id="ofrValType" names="ofrValType" label="가치" labelClass="2"
                                       conClass="3" required="true"/>
                        <ifvm:inputNew type="text" id="ofrValAmt" conClass="3"/>
                        <lebel id="info"></lebel>
                    </div>
                </div>


                <div class="row">
                    <%--<div class="col-xs-6 control_content" id="fixDatefield">
                        &lt;%&ndash;                        <ifvm:inputNew type="date" id="useFixStartDate" label="유효기간"  labelClass="3" conClass="3" />&ndash;%&gt;
                        &lt;%&ndash;                        <div style="float: left">~</div>&ndash;%&gt;
                        <ifvm:inputNew type="date" id="useFixEndDate" label="유효기간" labelClass="3" conClass="3"/>
                    </div>--%>
                        <div class="col-xs-6" >
                            <ifvm:inputNew type="textarea" id="cpndescText" label="지급사유" labelClass="3" conClass="6" rows="3" maxLength="2000" required="true"/>
                        </div>
                    <div class="col-xs-6">
                        <ifvm:inputNew type="text" id="useMinPurAmt" names="useMinPurAmt" values="0"
                                       label="O00137" labelClass="2" conClass="3" maxLength="14"
                                       className="text-right"/>
                    </div>
                        <div class="col-xs-6">
                            <ifvm:inputNew type="text" id="useMaxDcAmt" names="useMaxDcAmt" values="0" label="O00138"
                                           labelClass="2" conClass="3" maxLength="14" className="text-right"/>
                        </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 팝업 -->
    <div id="popupContainer" class="popup_container"></div>

