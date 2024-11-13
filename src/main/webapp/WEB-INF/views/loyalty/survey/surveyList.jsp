<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="S00076"/> &gt; <spring:message code="D10049"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>

        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="btnSearchSurvey" onclick="pageObjectSurveyList.searchSurveyList();" objCode="surveyListSearch_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>

            <%-- <button class="btn btn-sm" id="btnClearSurveySearchCondition" onclick="pageObjectSurveyList.setupSearchCondition();" objCode="surveyListSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button> --%>
        </div>
    </div>

    <div class="well form-horizontal well_bt5" id="areaSurveySearchCondition"></div>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>

        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="btnAddSurvey" objCode="surveyListAdd_OBJ" onclick="pageObjectSurveyList.moveSurveyDetail();">
                <spring:message code="L01169"/>
            </button>

            <button class="btn btn-sm" id="btnRemoveSurveyDetail" objCode="surveyListRemove_OBJ" onclick="pageObjectSurveyList.removeSurveyDetail();">
                <spring:message code="L00080"/>
            </button>
        </div>
    </div>

    <div id="surveyGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
    var pageObjectSurveyList = {
        surveyGrid: null,
        init: function () {
            this.createSurveyGrid();

            this.setupSearchCondition();
        },
        setupSearchCondition: function () {
            $.fn.ifvmSetCommonCondList("areaSurveySearchCondition", "LOY_SURVEY_LIST", this.surveyGrid.attr('id'));
        },
        createSurveyGrid: function () {
            var ejGridOption = {
                serializeGridData: function (data) {
                    if ($.fn.ifvmIsNotEmpty(requestitem)) {
                        data.item = requestitem;
                    }
                    return data;
                },
                rowSelected: function (args) {
                    if(args.data.createById == $.ifvmGetUserInfo().empId && args.data.statusCode === 'W'){
                        $("#btnRemoveSurveyDetail").attr("disabled",false);
                    } else{
                        $("#btnRemoveSurveyDetail").attr("disabled",true);
                    }
                },
                recordDoubleClick: function (args) {
                    pageObjectSurveyList.moveSurveyDetail(args.data.ridSurvey);
                },
                dataUrl: '<ifvm:action name="getSurveyList"/>',
                columns: [
                    {
                        field: 'surveyNo', headerText: '설문번호', textAlign: 'center', customAttributes: {index : 'LSM.SURV_NO', searchable: true}, width: '10%'
                    }, {
                        field: 'surveyName', headerText: '<spring:message code="S00074"/>', textAlign: 'left', customAttributes: {index : 'LSM.SURV_NM', searchable: true}
                    }, {
                        field: 'validStartDate', headerText: '<spring:message code="L00153"/>', textAlign: 'center', width: '6%'
                    }, {
                        field: 'validEndDate', headerText: '<spring:message code="L00154"/>', textAlign: 'center', width: '6%'
                    },{
                        field: 'statusCodeName', headerText: '<spring:message code="C00125"/>', textAlign: 'center', customAttributes: {index: 'LSM.STAT_CD'}, width: '8%'
                    }, {
                        field: 'targetCount', headerText: '<spring:message code="M00860"/>', textAlign: 'center', format: '{0:n0}', width: '9%'
                    }, {
                        field: 'surveyCount', headerText: '<spring:message code="S00083"/>', textAlign: 'center', format: '{0:n0}', width: '9%'
                    }, {
                        field: 'createBy', headerText: '<spring:message code="L00224"/>', textAlign: 'center', width: '10%'
                    }, {
                        field: 'createDate', headerText: '<spring:message code="L01125"/>', textAlign: 'center', width: '12%'
                    }, {
                        field: 'ridSurvey', headerText: 'ridSurvey', visible: false
                    }, {
                        field: 'createById', headerText: 'createById', visible: false
                    },{
                        field: 'statusCode', headerText: 'statusCode', visible: false
                    }
                ],
                requestGridData: {
                    sidx: 'statusCode desc, createDate',
                    sord: 'desc',
                },
                gridDataInit: true,
                radio: true,
            };

            this.surveyGrid = $('#surveyGrid').ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        moveSurveyDetail: function (ridSurvey) {
            var targetUri = '<ifvm:url name="surveyDetail"/>';

            if (ridSurvey) {
                targetUri += '?rid=' + ridSurvey;
            }

            qtjs.href(targetUri);
        },
        searchSurveyList: function () {
            $.fn.ifvmSubmitSearchCondition('areaSurveySearchCondition', function () {
                pageObjectSurveyList.surveyGrid.searchGrid({
                    item: requestitem
                });
            });
        },
        removeSurveyDetail: function () {
            var selectedRecords = pageObjectSurveyList.surveyGrid.opt.gridControl.getSelectedRecords() || [];

            if (selectedRecords.length === 0) {
                alert('<spring:message code="C00113"/>');
                return;
            }

            if (confirm('<spring:message code="I01500"/>')) {
                var ridSurvey = selectedRecords[0].ridSurvey;

                $.ifvSyncPostJSON('<ifvm:action name="removeSurveyDetail"/>', {
                    ridSurvey: ridSurvey
                }, function () {
                    alert('<spring:message code="I00726"/>');

                    pageObjectSurveyList.searchSurveyList();
                });
            }
        }
    };

    $(document).ready(function () {
        pageObjectSurveyList.init();
    });
</script>