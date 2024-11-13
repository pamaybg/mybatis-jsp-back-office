<%@ page import="com.icignal.common.util.BeansUtil" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline" id="areaSurveyPreviewDetail">
</div>

<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="btnCloseSurveyPreview" btnFunc="popupSurveyPreview.close" text="닫기" objCode="btnCloseSurveyPreview_OBJ"/>
</div>

<script type="text/javascript">
    var pageObjectSurveyPreviewPop = {
        ridSurvey: null,
        surveyView: null,
        init: function () {
            var ridSurvey = '<%=request.getParameter("rid") %>';
            this.ridSurvey = (ridSurvey !== 'undefined' && ridSurvey !== 'null') ? ridSurvey : null;

            this.setupSurveyPreview();
        },
        setupSurveyPreview: function () {
            var data = {
                ridSurv: this.ridSurvey,
                previewFlag: 'Y',
                mbrNo: ''
            };
            var query = Object.entries(data)
                .map(function (d) {
                return (d[0] + '=' + d[1]);
            }).join('&');

            var mobileBaseUri = '<%= BeansUtil.getApplicationProperty("common.base-uri")%>';
            var surveyUri = '<%= BeansUtil.getApplicationProperty("common.survey-uri")%>';
            var src = [(mobileBaseUri + surveyUri), query].join('?');
            var _frame = $('<iframe src="' + src + '" style="height: 700px;">')
            $('#areaSurveyPreviewDetail').append(_frame);
        }
    };

    $(document).ready(function () {
        pageObjectSurveyPreviewPop.init();
    });
</script>