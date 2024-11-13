<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span>혜택</span>
    </div>

    <div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="btnAddSurveyOffer" text="M00163" btnFunc="pageObjectSurveyOfferDetail.addSurveyOfferDetail" objCode="surveyOfferListAdd_OBJ"/>
        <ifvm:inputNew type="button" id="btnModifySurveyOffer" text="C00177" btnFunc="pageObjectSurveyOfferDetail.modifySurveyOfferDetail" objCode="surveyOfferListEdit_OBJ"/>
        <ifvm:inputNew type="button" id="btnRemoveSurveyOffer" text="M00165" btnFunc="pageObjectSurveyOfferDetail.removeSurveyOfferDetail" objCode="surveyOfferListDel_OBJ"/>
    </div>
</div>

<div id="surveyOfferGrid"></div>
<%--<div id="popupSurveyOfferDetailupContainer" class="popup_container"></div>--%>

<script type="text/javascript">

    var pageObjectSurveyOfferDetail = {
        surveyOfferGrid: null,
        init: function () {
            this.createSurveyOfferGrid();
        },
        createSurveyOfferGrid: function () {
            var ejGridOption = {
                serializeGridData: function (data) {
                    data.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                    return data;
                },
                dataUrl: '<ifvm:action name="getSurveyOfferList"/>',
                columns: [
                    {
                        field: 'ridSurveyOffer', headerText: 'ridSurveyOffer', visible: false
                    }, {
                        field: 'ridOffer', headerText: 'ridOffer', visible: false
                    }, {
                        field: 'offerTitle', headerText: '혜택명', textAlign: 'center', customAttributes: {searchable: true}
                    }, {
                        field: 'offerName', headerText: '오퍼명', textAlign: 'center', customAttributes: {searchable: true}
                    }, {
                        field: 'offerCount', headerText: '오퍼수량', textAlign: 'center', customAttributes: {index: ''}
                    }, {
                        field: 'offerValidStartDate', headerText: '유효시작일(D+)', textAlign: 'center', customAttributes: {index: ''}
                    }, {
                        field: 'createBy', headerText: '등록자', textAlign: 'center', customAttributes: {searchable: true}, format: '{0:n0}'
                    }, {
                        field: 'createDate', headerText: '등록일자', textAlign: 'center', customAttributes: {index: ''}
                    }
                ],
                requestGridData: {
                    sidx: 'createDate',
                    sord: 'desc',
                },
                rowList: [10, 25, 50, 100],
                radio: true
            };

            this.surveyOfferGrid = $("#surveyOfferGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        addSurveyOfferDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 오퍼를 추가할 수 없습니다.');
                return;
            }

            this.showSurveyOfferDetailPopup();
        },
        modifySurveyOfferDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 오퍼를 수정할 수 없습니다.');
                return;
            }

            var selectRecords = this.surveyOfferGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectRecords.length === 0) {
                alert('<spring:message code="M02219"/>');
                return;
            }

            this.showSurveyOfferDetailPopup(selectRecords[0].ridSurveyOffer);
        },
        removeSurveyOfferDetail: function () {
            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 오퍼를 삭제할 수 없습니다.');
                return;
            }

            var selectedRecords = this.surveyOfferGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectedRecords.length === 0) {
                alert('<spring:message code="C00113"/>');
                return;
            }

            if (confirm('<spring:message code="I01500"/>')) {
                var ridSurveyOffer = selectedRecords[0].ridSurveyOffer;

                $.ifvSyncPostJSON('<ifvm:action name="removeSurveyOfferDetail"/>', {
                    ridSurveyOffer: ridSurveyOffer,
                    ridSurvey: pageObjectSurveyDetail.ridSurvey
                }, function () {
                    alert('<spring:message code="M00590"/>');

                    pageObjectSurveyOfferDetail.searchSurveySectionList();
                });
            }
        },
        showSurveyOfferDetailPopup: function (ridSurveyOffer) {
            var targetUrl = '<ifvm:url name="popupSurveyOfferDetail"/>';

            if (ridSurveyOffer) {
                targetUrl += '?rid=' + ridSurveyOffer;
            }

            $('[id*="popupSurveyOfferDetail"], [name*="popupSurveyOfferDetail"]').remove();

            $('<div id="popupSurveyOfferDetail" class="popup_container"></div>')
                .appendTo('body')
                .ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: targetUrl,
                    contentType: 'ajax',
                    title: '혜택 상세 정보',
                    width: 600,
                    open: function () {
                        new ifvm.PopupCenter({
                            popupDivId: 'popupSurveyOfferDetail'
                        });
                    }
                });
        },
        searchSurveySectionList: function () {
            this.surveyOfferGrid.searchGrid({
                ridSurvey: pageObjectSurveyDetail.ridSurvey
            });
        }
    };

    $(document).ready(function () {
        pageObjectSurveyOfferDetail.init();
    });
</script>