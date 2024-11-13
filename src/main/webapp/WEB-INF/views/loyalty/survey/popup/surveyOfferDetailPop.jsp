<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline" id="areaSurveyOfferDetail">
    <div class="row qt_border">
        <ifvm:inputNew type="text" id="offerTitle" names="offerTitle" dto="offerTitle" required="true" label="혜택명" labelClass="2" conClass="9" maxLength="20"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="hidden" id="ridOffer" names="ridOffer" dto="ridOffer" conClass="2"/>

        <ifvm:inputNew type="text" id="offerNo" names="offerNo" dto="offerNo" disabled="true" label="오퍼" labelClass="2" conClass="4"/>
        <ifvm:inputNew type="search" id="offerName" names="offerName" dto="offerName" btnFunc="pageObjectSurveyOfferDetailPop.showOfferListPopup" disabled="true" conClass="5"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="number" id="offerCount" names="offerCount" dto="offerCount" label="오퍼수량" labelClass="2" conClass="4"/>
        <ifvm:inputNew type="number" id="offerValidStartDate" names="offerValidStartDate" dto="offerValidStartDate" label="유효시작일(D+)" labelClass="3" conClass="2"/>
    </div>
</div>

<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="btnSaveSurveyOfferDetail" btnFunc="pageObjectSurveyOfferDetailPop.saveSurveyOfferDetail" text="저장" objCode=""/>
    <ifvm:inputNew type="button" id="btnCloseSurveyOfferDetailPop" btnFunc="popupSurveyOfferDetail.close" text="닫기" objCode=""/>
</div>

<script type="text/javascript">

    var pageObjectSurveyOfferDetailPop = {
        ridSurveyOffer: null,
        init: function () {
            var ridSurveyItem = '<%=request.getParameter("rid") %>';
            this.ridSurveyOffer = (ridSurveyItem !== 'undefined' && ridSurveyItem !== 'null') ? ridSurveyItem : null;

            this.setupSurveyOfferDetail();
        },
        setupSurveyOfferDetail: function () {
            if (this.ridSurveyOffer) {
                $.ifvSyncPostJSON('<ifvm:action name="getSurveyOfferDetail"/>', {
                    ridSurveyOffer: this.ridSurveyOffer
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        $('#areaSurveyOfferDetail').dataSetting(result);
                    }
                });
            }
        },
        saveSurveyOfferDetail: function () {
            var areaSurveyOfferDetail = $("#areaSurveyOfferDetail");
            var validation = areaSurveyOfferDetail.ifvValidation();

            if (validation.confirm()) {
                var targetUrl = this.ridSurveyOffer ? '<ifvm:action name="modifySurveyOfferDetail"/>' : '<ifvm:action name="addSurveyOfferDetail"/>';

                var reqData = areaSurveyOfferDetail.getSubmitData();
                reqData.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                reqData.ridSurveyOffer = this.ridSurveyOffer;

                $.ifvSyncPostJSON(targetUrl, reqData, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert('<spring:message code="L00076"/>');

                        pageObjectSurveyOfferDetail.searchSurveySectionList();
                        popupSurveyOfferDetail.close();
                    }
                });
            }
        },
        showOfferListPopup: function () {
            var targetFields = {
                name: "offerName",
                rid: "ridOffer",
                no: "offerNo"
            };

            $('[id*="popupOfferList"], [name*="popupOfferList"]').remove();

            $('<div id="popupOfferList" class="popup_container"></div>')
                .appendTo('body')

            $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupOfferList', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');
        }
    };

    $(document).ready(function () {
        pageObjectSurveyOfferDetailPop.init();
    });

    <%--var survOfferPop;--%>
    <%--var _isNew = true;--%>

    <%--function getsurvOfferPopDetail() {--%>
    <%--    if (survOfferRid == null) _isNew = true;--%>
    <%--    else _isNew = false;--%>
    <%--    if (!_isNew) {--%>
    <%--        $.ifvSyncPostJSON('<ifvm:action name="getSurveyOfferDetail"/>', {rid: survOfferRid},--%>
    <%--            function (result) {--%>
    <%--                $("#title").val(result.title);--%>
    <%--                $("#ofrNo").val(result.ofrNo);--%>
    <%--                $("#ofrNm").val(result.ofrNm);--%>
    <%--                $("#ridOfr").val(result.ridOfr);--%>
    <%--                $("#ofrCnt").val(result.ofrCnt);--%>
    <%--                $("#validStDd").val(result.validStDd);--%>
    <%--            });--%>
    <%--    }--%>
    <%--}--%>

    <%--function saveSurvOffer() {--%>
    <%--    var validation = $("#survOfferDetailForm").ifvValidation();--%>
    <%--    if (validation.confirm()) {--%>
    <%--        if (_isNew) {--%>
    <%--            $.ifvSyncPostJSON('<ifvm:action name="addSurveyOfferDetail"/>', {--%>
    <%--                    ridSurv: survRid,--%>
    <%--                    ridSurvOffer: survOfferRid,--%>
    <%--                    title: $("#title").val(),--%>
    <%--                    ridOfr: $("#ridOfr").val(),--%>
    <%--                    ofrCnt: $("#ofrCnt").val(),--%>
    <%--                    validStDd: $("#validStDd").val()--%>
    <%--                },--%>
    <%--                function (result) {--%>
    <%--                    if (result.message) alert(result.message);--%>
    <%--                    else alert("저장 되었습니다.");--%>
    <%--                    $.fn.ifvmPopupClose();--%>
    <%--                    survOfferList._doAjax();--%>
    <%--                }, function (result) {--%>
    <%--                    alert(result.message);--%>
    <%--                });--%>
    <%--        } else {--%>
    <%--            $.ifvSyncPostJSON('<ifvm:action name="modifySurveyOfferDetail"/>', {--%>
    <%--                    ridSurv: survRid,--%>
    <%--                    ridSurvOffer: survOfferRid,--%>
    <%--                    title: $("#title").val(),--%>
    <%--                    ridOfr: $("#ridOfr").val(),--%>
    <%--                    ofrCnt: $("#ofrCnt").val(),--%>
    <%--                    validStDd: $("#validStDd").val()--%>
    <%--                },--%>
    <%--                function (result) {--%>
    <%--                    if (result.message) alert(result.message);--%>
    <%--                    else alert("저장 되었습니다.");--%>
    <%--                    $.fn.ifvmPopupClose();--%>
    <%--                    survOfferList._doAjax();--%>
    <%--                }, function (result) {--%>
    <%--                    alert(result.message);--%>
    <%--                });--%>
    <%--        }--%>
    <%--    }--%>
    <%--}--%>

    <%--function getOfrList() {--%>
    <%--    var targetFields = {name: "ofrNm", rid: "ridOfr", no: "ofrNo"};--%>
    <%--    $.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopup', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');--%>
    <%--}--%>

    <%--function offerPopupClose() {--%>
    <%--    offerPopup._destroy();--%>
    <%--}--%>

    <%--$(document).ready(function () {--%>

    <%--    getsurvOfferPopDetail();--%>

    <%--    $("#saveSurvMbrBtn").click(function () {--%>
    <%--        if (realStatCd != 'W') {--%>
    <%--            alert('작성중이 아닐때는 혜택을 수정 할 수 없습니다.');--%>
    <%--        } else {--%>
    <%--            saveSurvOffer();--%>
    <%--        }--%>
    <%--    });--%>

    <%--    $("#closeSMbrDetailPop").click(function () {--%>
    <%--        survOfferDetailPopupContainer._destroy();--%>
    <%--    });--%>
    <%--});--%>
</script>