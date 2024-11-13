<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline" id="areaSurveySectionDetail">
    <div class="row qt_border">
        <ifvm:inputNew type="number" id="sectionNo" names="sectionNo" dto="sectionNo" required="true" label="페이지 번호" labelClass="2" conClass="4"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="textarea" id="sectionContents" names="sectionContents" dto="sectionContents" label="페이지 설명" labelClass="2" conClass="9" rows="3"/>
    </div>

    <div class="row qt_border">
        <label class="control-label col-xs-2"></label>

        <ifvm:inputNew type="checkbox" id="lastFlag" names="lastFlag" dto="lastFlag" values="Y" text="마지막 페이지 여부" labelClass="2" conClass="4"/>
    </div>
</div>

<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="btnAddSurveySectionDetail" btnFunc="pageObjectSurveySectionDetailPop.saveSurveySectionDetail" text="저장" objCode="btnAddSurveySectionDetail_OBJ"/>
    <ifvm:inputNew type="button" id="btnCloseSurveySectionDetailPop" btnFunc="popupSurveySectionDetail.close" text="닫기" objCode="btnCloseSurveySectionDetailPop_OBJ"/>
</div>

<script type="text/javascript">
    var pageObjectSurveySectionDetailPop = {
        ridSurveySection: null,
        ridImage: null,
        imageSurveySection: null,
        init: function () {
            var ridSurveySection = '<%=request.getParameter("rid") %>';
            this.ridSurveySection = (ridSurveySection !== 'undefined' && ridSurveySection !== 'null') ? ridSurveySection : null;

            //$.fn.ifvmSetSelectOptionCommCode("fieldTypeCode", "LOY_SURV_FIELD_CD", null, null, true);

            this.setupSurveySectionDetail();
        },
        setupSurveySectionDetail: function () {
            if (this.ridSurveySection != null) {
                $.ifvSyncPostJSON('<ifvm:action name="getSurveySectionDetail"/>', {
                    ridSurveySection: this.ridSurveySection
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        $('#areaSurveySectionDetail').dataSetting(result);
                    }
                });
            }
        },
        saveSurveySectionDetail: function () {
            var areaSurveySectionDetail = $("#areaSurveySectionDetail");
            var validation = areaSurveySectionDetail.ifvValidation();

            if (validation.confirm()) {
                var targetUrl = this.ridSurveySection ? '<ifvm:action name="modifySurveySectionDetail"/>' : '<ifvm:action name="addSurveySectionDetail"/>';

                var reqData = areaSurveySectionDetail.getSubmitData();
                reqData.lastFlag = $('[name="lastFlag"]').is(':checked') ? 'Y' : 'N';
                reqData.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                reqData.ridSurveySection = this.ridSurveySection;

                $.ifvSyncPostJSON(targetUrl, reqData, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert('<spring:message code="L00076"/>');

                        pageObjectSurveySectionDetail.searchSurveySectionList();
                        //pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.selectRows($("#sectionNo").val()-1);
                        var index = 0;
                        pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                            if(result.message == vf.ridSurveySection ){
                                pageObjectSurveySectionDetail.surveySectionGrid.opt.gridControl.selectRows(index);
                            }
                            index = index+1;
                        });

                        popupSurveySectionDetail.close();
                    }
                }, function (response) {
                    alert(response.message);
                });
            }
        }
    };

    $(document).ready(function () {
        pageObjectSurveySectionDetailPop.init();
    });
</script>