<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="S00079"/></span>
    </div>

    <div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="btnAddSurveySection" text="M00163" btnFunc="pageObjectSurveySectionDetail.addSurveySectionDetail" objCode="surveyItemListAdd_OBJ"/>
        <%--<ifvm:inputNew type="button" id="btnModifySurveySection" text="C00177" btnFunc="pageObjectSurveySectionDetail.modifySurveySectionDetail" objCode="surveyItemListAdd_OBJ"/>--%>
        <ifvm:inputNew type="button" id="btnRemoveSurveySection" text="M00165" btnFunc="pageObjectSurveySectionDetail.removeSurveySectionDetail" objCode="surveyItemListDel_OBJ"/>
    </div>
</div>

<div id="surveySectionGrid"></div>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="S00086"/></span>
    </div>

    <div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="btnAddSurveyItem" text="M00163" btnFunc="pageObjectSurveySectionDetail.addSurveyItemDetail" objCode="surveyItemListAdd_OBJ"/>
        <%--<ifvm:inputNew type="button" id="btnModifySurveyItem" text="C00177" btnFunc="pageObjectSurveySectionDetail.modifySurveyItemDetail" objCode="surveyItemListAdd_OBJ"/>--%>
        <ifvm:inputNew type="button" id="btnRemoveSurveyItem" text="M00165" btnFunc="pageObjectSurveySectionDetail.removeSurveyItemDetail" objCode="surveyItemListDel_OBJ"/>
    </div>
</div>

<div id="surveyItemGrid"></div>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="S00087"/></span>
    </div>

    <div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="btnAddSurveyItemAttr" text="M00163" btnFunc="pageObjectSurveySectionDetail.addSurveyItemAttrDetail" objCode="surveyItemListAttrAdd_OBJ"/>
       <%-- <ifvm:inputNew type="button" id="btnModifySurveyItemAttr" text="C00177" btnFunc="pageObjectSurveySectionDetail.modifySurveyItemAttrDetail" objCode="surveyItemListAttrAdd_OBJ"/>--%>
        <ifvm:inputNew type="button" id="btnRemoveSurveyItemAttr" text="M00165" btnFunc="pageObjectSurveySectionDetail.removeSurveyItemAttrDetail" objCode="surveyItemListAttrDel_OBJ"/>
    </div>
</div>

<div id="surveyItemAttrGrid"></div>

<script type="text/javascript">
    var ridSurveySection;
    var ridSurveyItem;
    var sectionNo;
    var sectionContents;
    var itemNo;
    var itemTitle;

    var pageObjectSurveySectionDetail = {
        surveySectionGrid: null,
        surveyItemGrid: null,
        surveyItemAttrGrid: null,
        init: function () {
            this.createSurveySectionGrid();
            this.createSurveyItemGrid();
            this.createSurveyItemAttrGrid();
        },
        createSurveySectionGrid: function () {
            var ejGridOption = {
                serializeGridData: function (data) {
                    data.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                    return data;
                },
                rowSelected: function (args) {
                    var data = args.data;
                    ridSurveySection = data.ridSurveySection;
                    sectionNo = data.sectionNo;
                    sectionContents = data.sectionContents;
                    pageObjectSurveySectionDetail.searchSurveyItemList(ridSurveySection);
                    pageObjectSurveySectionDetail.searchSurveyItemAttrList(null);
                },
                recordDoubleClick : function (args) {
                    var data = args.data;
                    ridSurveySection = data.ridSurveySection;
                    pageObjectSurveySectionDetail.searchSurveyItemList(ridSurveySection);
                    pageObjectSurveySectionDetail.searchSurveyItemAttrList(null);
                    pageObjectSurveySectionDetail.modifySurveySectionDetail()
                },
                allowResizing : false,
                dataUrl: '<ifvm:action name="getSurveySectionList"/>',
                columns: [
                    {
                        field: 'ridSurveySection', headerText: 'ridSurveySection', visible: false
                    }, {
                        field: 'sectionNo', headerText: '<spring:message code="S00084"/>', textAlign: 'center', customAttributes: { searchable: true }
                    }, {
                        field: 'sectionContents', headerText: '페이지 설명', textAlign: 'left', customAttributes: { searchable: true, style: "text-overflow: ellipsis;white-space: nowrap;overflow: hidden;" }
                    }, {
                        field: 'lastFlag', headerText: '마지막 페이지 여부', textAlign: 'center'
                    }, {
                        field: 'modifyBy', headerText: '<spring:message code="L00044"/>', textAlign: 'center', customAttributes: {index: 'name'}
                    }, {
                        field: 'modifyDate', headerText: '<spring:message code="L02703"/>', textAlign: 'center'
                    }
                ],
                requestGridData: {
                    sidx: 'sectionNo',
                    sord: 'asc'
                },
                rowList: [10, 25, 50, 100],
                radio: true,
                tempId: "ifvGridTemplete"
            };

            this.surveySectionGrid = $("#surveySectionGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        addSurveySectionDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 페이지를 추가할 수 없습니다.');
                return;
            }

            this.showSurveySectionDetailPopup();
        },
        modifySurveySectionDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 문항을 수정할 수 없습니다.');
                return;
            }

            var selectRecords = this.surveySectionGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectRecords.length === 0) {
                alert('<spring:message code="L00066"/>');
                return;
            }

            this.showSurveySectionDetailPopup(selectRecords[0].ridSurveySection);
        },
        removeSurveySectionDetail: function () {
            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 문항을 삭제할 수 없습니다.');
                return;
            }

            var selectedRecords = this.surveySectionGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectedRecords.length === 0) {
                alert('<spring:message code="C00113"/>');
                return;
            }

            if (confirm('<spring:message code="I01500"/>')) {
                var ridSurveySection = selectedRecords[0].ridSurveySection;

                $.ifvSyncPostJSON('<ifvm:action name="removeSurveySectionDetail"/>', {
                    ridSurveySection: ridSurveySection,
                    ridSurvey: pageObjectSurveyDetail.ridSurvey
                }, function () {
                    alert('<spring:message code="M00590"/>');

                    pageObjectSurveySectionDetail.searchSurveySectionList();
                });
            }
        },
        showSurveySectionDetailPopup: function (ridSurveySection) {
            var targetUrl = '<ifvm:url name="popupSurveySectionDetail"/>';

            if (ridSurveySection) {
                targetUrl += '?rid=' + ridSurveySection;
            }

            $('[id*="popupSurveySectionDetail"], [name*="popupSurveySectionDetail"]').remove();

            $('<div id="popupSurveySectionDetail" class="popup_container"></div>')
                .appendTo('body')
                .ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: targetUrl,
                    contentType: 'ajax',
                    title: '설문 페이지 상세 정보',
                    width: 800,
                    open: function () {
                        new ifvm.PopupCenter({
                            popupDivId: 'popupSurveySectionDetail'
                        });
                    }
                });
        },
        searchSurveySectionList: function () {
            this.surveySectionGrid.searchGrid({
                ridSurvey: pageObjectSurveyDetail.ridSurvey
            });
        },
        createSurveyItemGrid: function () {
            var ejGridOption = {
                rowSelected: function (args) {
                    var data = args.data;
                    ridSurveyItem = data.ridSurveyItem;
                    itemNo = data.itemNo;
                    itemTitle = data.itemTitle;

                    pageObjectSurveySectionDetail.searchSurveyItemAttrList(ridSurveyItem);
                },
                recordDoubleClick : function (args) {
                    var data = args.data;
                    ridSurveyItem = data.ridSurveyItem;
                    pageObjectSurveySectionDetail.searchSurveyItemAttrList(ridSurveyItem);
                    pageObjectSurveySectionDetail.modifySurveyItemDetail()
                },
                allowResizing : false,
                dataUrl: '<ifvm:action name="getSurveyItemList"/>',
                columns: [
                    {
                        field: 'ridSurveyItem', headerText: 'ridSurveyItem', visible: false
                    }, {
                        field: 'fieldTypeCode', headerText: 'fieldTypeCode', visible: false
                    }, {
                        field: 'itemNo', headerText: '<spring:message code="S00090"/>', textAlign: 'center', customAttributes: { searchable: true }, width: '12%'
                    }, {
                        field: 'itemTitle', headerText: '<spring:message code="S00091"/>', textAlign: 'left', customAttributes: { searchable: true, style: "text-overflow: ellipsis;white-space: nowrap;overflow: hidden;" }
                    }, {
                        field: 'fieldTypeCodeName', headerText: '<spring:message code="L02702"/>', textAlign: 'center', customAttributes: {index: 'fieldTypeCode'}
                    }, {
                        field: 'optionalFlag', headerText: '선택 문항 여부', textAlign: 'center', customAttributes: {index: 'optionalFlag'}
                    }, {
                        field: 'modifyBy', headerText: '<spring:message code="L00044"/>', textAlign: 'center', customAttributes: {index: 'name'}
                    }, {
                        field: 'modifyDate', headerText: '<spring:message code="L02703"/>', textAlign: 'center'
                    }
                ],
                requestGridData: {
                    sidx: 'itemNo',
                    sord: 'asc',
                },
                rowList: [10, 25, 50, 100],
                gridDataInit: false,
                radio: true,
                tempId: "ifvGridTemplete"
            };

            this.surveyItemGrid = $("#surveyItemGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        addSurveyItemDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 문항을 추가할 수 없습니다.');
                return;
            }

            var surveySectionRecords = this.surveySectionGrid.opt.gridControl.getSelectedRecords() || [];

            // if (surveySectionRecords.length === 0) {
            //     alert('페이지를 먼저 선택해주세요.');
            //     return;
            // }

            var ridSS;
            if($.fn.ifvmIsNotEmpty(surveySectionRecords[0])){
                ridSS =  surveySectionRecords[0].ridSurveySection;
            }


            this.showSurveyItemDetailPopup(ridSS);
        },
        modifySurveyItemDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 문항을 수정할 수 없습니다.');
                return;
            }

            var surveySectionRecords = this.surveySectionGrid.opt.gridControl.getSelectedRecords() || [];
            if (surveySectionRecords.length === 0) {
                alert('페이지를 먼저 선택해주세요.');
                return;
            }

            var selectRecords = this.surveyItemGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectRecords.length === 0) {
                alert('<spring:message code="L00066"/>');
                return;
            }

            this.showSurveyItemDetailPopup(surveySectionRecords[0].ridSurveySection, selectRecords[0].ridSurveyItem);
        },
        removeSurveyItemDetail: function () {
            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 문항을 삭제할 수 없습니다.');
                return;
            }

            var selectedRecords = this.surveyItemGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectedRecords.length === 0) {
                alert('<spring:message code="C00113"/>');
                return;
            }

            if (confirm('<spring:message code="I01500"/>')) {
                var ridSurveyItem = selectedRecords[0].ridSurveyItem;

                $.ifvSyncPostJSON('<ifvm:action name="removeSurveyItemDetail"/>', {
                    ridSurveyItem: ridSurveyItem,
                    ridSurvey: pageObjectSurveyDetail.ridSurvey
                }, function () {
                    alert('<spring:message code="M00590"/>');

                    pageObjectSurveySectionDetail.searchSurveyItemList();
                });
            }
        },
        showSurveyItemDetailPopup: function (ridSurveySection, ridSurveyItem) {
            var targetUrl = '<ifvm:url name="popupSurveyItemDetail"/>';

            if (ridSurveyItem) {
                targetUrl += '?rid=' + ridSurveyItem;
            }

            $('[id*="popupSurveyItemDetail"], [name*="popupSurveyItemDetail"]').remove();

            $('<div id="popupSurveyItemDetail" class="popup_container"></div>')
                .appendTo('body')
                .ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: targetUrl,
                    contentType: 'ajax',
                    title: '<spring:message code="S00081"/>',
                    width: 800,
                    open: function () {
                        pageObjectSurveySectionDetailPop.setupRidSurveySection(ridSurveySection);

                        new ifvm.PopupCenter({
                            popupDivId: 'popupSurveyItemDetail'
                        });
                    }
                });
        },
        searchSurveyItemList: function (ridSurveySection) {
            this.surveyItemGrid.opt.ejGridOption.gridDataInit = true;
            this.surveyItemGrid.searchGrid({
                ridSurveySection: ridSurveySection
            });
        },
        createSurveyItemAttrGrid: function () {
            var ejGridOption = {
                recordDoubleClick : function (args) {
                    var data = args.data;
                    pageObjectSurveySectionDetail.modifySurveyItemAttrDetail();
                },
                allowResizing : false,
                dataUrl: '<ifvm:action name="getSurveyItemAttrList"/>',
                columns: [
                    {
                        field: 'ridSurveyItemAttr', headerText: 'ridSurveyItemAttr', visible: false
                    }, {
                        field: 'itemAttrNo', headerText: '<spring:message code="S00088"/>', textAlign: 'center', customAttributes: { searchable: true }
                    }, {
                        field: 'itemAttrValue', headerText: '<spring:message code="S00089"/>', textAlign: 'center', customAttributes: { searchable: true }
                    }, {
                        field: 'targetSectionNo', headerText: '이동 페이지 번호', textAlign: 'center'
                    }, {
                        field: 'modifyBy', headerText: '<spring:message code="L00044"/>', textAlign: 'center'
                    }, {
                        field: 'modifyDate', headerText: '<spring:message code="L02703"/>', textAlign: 'center'
                    }
                ],
                requestGridData: {
                    sidx: 'itemAttrNo',
                    sord: 'ASC',
                },
                rowList: [10, 25, 50, 100],
                gridDataInit: false,
                radio: true,
                tempId: "ifvGridTemplete"
            };

            this.surveyItemAttrGrid = $("#surveyItemAttrGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        addSurveyItemAttrDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 보기를 추가할 수 없습니다.');
                return;
            }

            var surveyItemRecords = this.surveyItemGrid.opt.gridControl.getSelectedRecords() || [];
            // if (surveyItemRecords.length === 0) {
            //     alert('문항을 먼저 선택해주세요.');
            //     return;
            // }

            var ridSI;
            if($.fn.ifvmIsNotEmpty(surveyItemRecords[0])){
                var surveyItemData = surveyItemRecords[0];
                if (surveyItemData.fieldTypeCode === 'INFO' || surveyItemData.fieldTypeCode === 'TEXT' || surveyItemData.fieldTypeCode === 'DROP_SCORE') {
                    alert('필드타입이 "텍스트", "드롭다운(점수)" 일 경우에는 항목을 추가할 수 없습니다.');
                    return;
                }
                ridSI = surveyItemRecords[0].ridSurveyItem;
            }else{
                ridSurveyItem = null;
            }

            this.showSurveyItemAttrDetailPopup(ridSI);
        },
        modifySurveyItemAttrDetail: function () {
            if (pageObjectSurveyDetail.ridSurvey === null) {
                alert('<spring:message code="D10182"/>');
                return;
            }

            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 보기를 수정할 수 없습니다.');
                return;
            }

            var surveyItemRecords = this.surveyItemGrid.opt.gridControl.getSelectedRecords() || [];
            if (surveyItemRecords.length === 0) {
                alert('문항을 먼저 선택해주세요.');
                return;
            }

            var surveyItemAttrRecords = this.surveyItemAttrGrid.opt.gridControl.getSelectedRecords() || [];
            if (surveyItemAttrRecords.length === 0) {
                alert('<spring:message code="L00066"/>');
                return;
            }

            this.showSurveyItemAttrDetailPopup(surveyItemRecords[0].ridSurveyItem, surveyItemAttrRecords[0].ridSurveyItemAttr);
        },
        removeSurveyItemAttrDetail: function () {
            if ('W' !== pageObjectSurveyDetail.statusCode) {
                alert('작성 중이 아닐 때는 보기를 삭제할 수 없습니다.');
                return;
            }

            var selectedRecords = this.surveyItemAttrGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectedRecords.length === 0) {
                alert('<spring:message code="C00113"/>');
                return;
            }

            if (confirm('<spring:message code="I01500"/>')) {
                var ridSurveyItemAttr = selectedRecords[0].ridSurveyItemAttr;

                $.ifvSyncPostJSON('<ifvm:action name="removeSurveyItemAttrDetail"/>', {
                    ridSurveyItemAttr: ridSurveyItemAttr,
                    ridSurvey: pageObjectSurveyDetail.ridSurvey
                }, function () {
                    alert('<spring:message code="M00590"/>');

                    pageObjectSurveySectionDetail.searchSurveyItemAttrList();
                });
            }
        },
        showSurveyItemAttrDetailPopup: function (ridSurveyItem, ridSurveyItemAttr) {

            var targetUrl = '<ifvm:url name="popupSurveyItemAttrDetail"/>';

            if (ridSurveyItemAttr) {
                targetUrl += '?rid=' + ridSurveyItemAttr;
            }

            $('[id*="popupSurveyItemAttrDetail"], [name*="popupSurveyItemAttrDetail"]').remove();

            $('<div id="popupSurveyItemAttrDetail" class="popup_container"></div>')
                .appendTo('body')
                .ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: targetUrl,
                    contentType: 'ajax',
                    title: '설문 보기 상세 정보',
                    width: 800,
                    open: function () {
                        pageObjectSurveyItemAttrDetailPop.setupRidSurveyItem(ridSurveyItem);
                        new ifvm.PopupCenter({
                            popupDivId: 'popupSurveyItemAttrDetail'
                        });
                    }
                });
        },
        searchSurveyItemAttrList: function (ridSurveyItem) {
            this.surveyItemAttrGrid.opt.ejGridOption.gridDataInit = true;
            this.surveyItemAttrGrid.searchGrid({
                ridSurveyItem: ridSurveyItem
            });
        }
    };

    $(document).ready(function () {
        pageObjectSurveySectionDetail.init();
    });
</script>