<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area">
        <div class="col-xs-2">
            <span>설문 요약</span>
        </div>

        <div class="col-sm-10 searchbtn_r">
            <%--<ifv:inputNew type="button" nuc="true" text="요약 엑셀 다운로드" btnFunc="pageObjectSurveyResultDetail.downloadSurveyResultSummary" objCode="downloadSurveyResultSummary_OBJ"/>--%>
            <ifv:inputNew type="button" nuc="true" text="결과 다운로드"
                          btnFunc="pageObjectSurveyResultDetail.survDetailGridExcelDown"
                          objCode="downloadSurveyResultSummary_OBJ"/>
            <ifv:inputNew type="button" nuc="true" text="상세 결과 다운로드" btnFunc="pageObjectSurveyResultDetail.downloadSurveyResultDetail" objCode="downloadSurveyResultDetail_OBJ"/>
        </div>
    </div>

    <div>
        <div class="form-horizontal underline top_well">
            <div class="row qt_border" id="surveyResultRow"></div>
        </div>
    </div>

    <div class="page_btn_area">
        <div class="col-xs-2">
            <span>항목별 요약</span>
        </div>

        <label class="col-xs-10 control-label">
            <span class="asterisk">* 텍스트 유형에 대한 응답 내용은 상세 엑셀 다운로드 후 확인해주세요.</span>
        </label>
    </div>

    <div id="gridSurveyResultList" class="white_bg grid_bd0"></div>


    <%-- <div class="page_btn_area">
    <div class="col-xs-2">
    <span>상세 결과</span>
    </div>
    </div>
    <div id="gridSurveyDtlResultList" class="white_bg grid_bd0"></div>
    </div> --%>

    <script type="text/javascript">

        var pageObjectSurveyResultDetail = {
            gridSurveyResultList: null,
            gridSurveyDtlResultList: null,
            init: function () {
                this.getSurveyResultSummary();
                this.createGridList();
                //this.createDtlGridList();
            },
            getSurveyResultSummary: function () {
                $.ifvPostJSON('${pageContext.request.contextPath}/loyalty/survey/getSurveyResultSummary.do', {
                    rid: pageObjectSurveyDetail.ridSurvey
                }, function (response) {
                    var totalCount = response.totalCount;
                    var enterCount = response.enterCount;
                    var enterRate = (response.enterRate * 100).toFixed(2);

                    var text = '총 대상자 : {0} 명 / 참여자 : {1} 명 / 참여율 : {2} %';
                    $('#surveyResultRow').text(
                        text.cFormat([totalCount, enterCount, enterRate])
                    );
                });
            },
            createGridList: function () {
                var gridOptions = {
                    serializeGridData: function (data) {
                        data.rid = pageObjectSurveyDetail.ridSurvey;
                        return data;
                    },
                    allowResizing : false,
                    dataUrl: '<ifv:action name="getSurveyResultList"/>',
                    columns: [{
                        field: 'sectionNo',
                        headerText: '페이지 번호',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '9%'
                    }, {
                        field: 'itemNo',
                        headerText: '문항 번호',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '9%'
                    }, {
                        field: 'itemTitle',
                        headerText: '문항 내용',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '41%'
                    }, {
                        field: 'fieldTypeCodeName',
                        headerText: '유형',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '11%'
                    }, {
                        field: 'answerValue',
                        headerText: '응답 내용',
                        headerTextAlign: 'center',
                        textAlign: 'left',
                        customAttributes: {sortable: false},
                        width: '20%'
                    }, {
                        field: 'answerCount',
                        headerText: '응답자 수',
                        headerTextAlign: 'center',
                        textAlign: 'right',
                        format: '{0:n0}',
                        customAttributes: {sortable: false},
                        width: '9%'
                    }, {
                        field: 'fieldTypeCode', headerText: 'fieldTypeCodeName', visible: false
                    }],
                    requestGridData: {
                        sidx: 'sectionNo, itemNo, itemAttrNo',
                        sord: '',
                        rows: 1000
                    },
                    rowNum: 1000,
                    tempId: 'ifvGridSimplePageTemplete'
                }

                this.gridSurveyResultList = $('#gridSurveyResultList').ifvsfGrid({
                    ejGridOption: gridOptions
                });
            },
            createDtlGridList: function () {
                var gridOptions = {
                    serializeGridData: function (data) {
                        data.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                        return data;
                    },
                    dataUrl: '<ifv:action name="selectSurveyResultDtlList"/>',
                    columns: [{
                        field: 'pageNo',
                        headerText: '페이지',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '9%'
                    }, {
                        field: 'itemNo',
                        headerText: '문항',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '9%'
                    }, {
                        field: 'itemTitle',
                        headerText: '문항 내용',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '31%'
                    }, {
                        field: 'custNo',
                        headerText: '회원번호',
                        headerTextAlign: 'center',
                        textAlign: 'center',
                        customAttributes: {sortable: false},
                        width: '10%'
                    },/*{
                        field: 'custNm', headerText: '회원명', headerTextAlign: 'center', textAlign: 'center', customAttributes: {sortable: false}, width : '7%'
                    },*/ {
                        field: 'answerValue',
                        headerText: '응답 내용',
                        headerTextAlign: 'center',
                        textAlign: 'left',
                        customAttributes: {sortable: false},
                        width: '16%'
                    }],
                    requestGridData: {
                        sidx: 'pageNo',
                    },
                    rowList: [10, 25, 50, 100],
                    tempId: 'ifvGridSimplePageTemplete'
                }
                this.gridSurveyDtlResultList = $('#gridSurveyDtlResultList').ifvsfGrid({
                    ejGridOption: gridOptions
                });
            },
            downloadSurveyResultSummary: function () {
                $.ifvProgressControl(true);

                var requestData = this.gridSurveyResultList.opt.postData;
                requestData.rid = pageObjectSurveyDetail.ridSurvey;
                QTExcelDownload('${pageContext.request.contextPath}/loyalty/survey/downloadSurveyResultSummary.do', requestData);
            },
            downloadSurveyResultDetail: function () {
                $.ifvProgressControl(true);

                var requestData = this.gridSurveyResultList.opt.postData;
                requestData.rid = pageObjectSurveyDetail.ridSurvey;
                /*QTExcelDownload('${pageContext.request.contextPath}/loyalty/survey/downloadSurveyResultDetail.do', requestData);*/
                $.ifvDBExcelDn('${pageContext.request.contextPath}/loyalty/survey/downloadSurveyResultDetail.do', "downloadSurveyResultDetail_OBJ", {ridSurvey: ridSurvey});
            },
            survDetailGridExcelDown: function () {
                $.ifvExcelDn('/loyalty/survey/survDetailGridExcelDown.do', 'gridSurveyResultList');
            }
        };

        $(document).ready(function () {
            pageObjectSurveyResultDetail.init();
        });

    </script>