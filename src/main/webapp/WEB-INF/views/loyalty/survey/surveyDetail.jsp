<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="S00076"/> &gt; <spring:message code="O00015"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L02320"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="btnPreviewSurvey" objCode="surveyDetailSave_OBJ" onclick="pageObjectSurveyDetail.showSurveyPreview();">
                미리보기
            </button>

            <button class="btn btn-sm" id="btnSaveSurvey" objCode="surveyDetailSave_OBJ" onclick="pageObjectSurveyDetail.saveSurveyDetail();">
                <spring:message code="I00745"/>
            </button>

            <button class="btn btn-sm" id="btnMoveSurveyList" objCode="surveyDetailSave_OBJ" onclick="pageObjectSurveyDetail.moveSurveyList();">
                <spring:message code="L00824"/>
            </button>

            <button class="btn btn-sm" id="btnCopySurvey" objCode="surveyDetailSave_OBJ" onclick="pageObjectSurveyDetail.copySurveyDetail();">
                설문 복사
            </button>
        </div>
    </div>

    <div class="form-horizontal underline top_well" id="areaSurveyDetail">
        <div class="row qt_border">
            <ifvm:inputNew type="text" required="true" id="surveyName" dto="surveyName" label="S00074" labelClass="1" conClass="4"/>
            <ifvm:inputNew type="text" id="surveyNo" dto="surveyNo" label="설문번호" labelClass="2" conClass="4" disabled="true"/>
        </div>

        <div class="row qt_border">
            <ifvm:inputNew type="dateTerm" required="true" startDto="validStartDate"
                           endDto="validEndDate" startId="validStartDate" endId="validEndDate" nuc="true" conClass="4" label="설문기간" labelClass="1"/>
            <ifvm:inputNew type="text" id="createBy" dto="createBy" label="작성자" labelClass="2" conClass="4" disabled="true"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="select" required="true" id="statusCode" names="statusCode" dto="statusCode" label="D10228" labelClass="1" conClass="4"/>
            <ifvm:inputNew type="text" id="createDate" dto="createDate" label="작성일" labelClass="2" conClass="4" disabled="true"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="select" required="true" id="usrTypeCd" names="usrTypeCd" dto="usrTypeCd" label="설문구분" labelClass="1" conClass="4" />
        </div>

        <div class="row qt_border">
            <ifvm:inputNew type="textarea" id="startMessage" dto="startMessage" labelClass="1" conClass="4" rows="5" nuc="true" label="시작 안내 메시지" maxLength="200"/>
            <ifvm:inputNew type="textarea" id="endMessage" dto="endMessage" labelClass="2" conClass="4" rows="5" nuc="true" label="종료 안내 메시지" maxLength="200"/>
        </div>
        <div class="row qt_border">
            <%--<ifvm:input type="upload" btnType="upload" id="startImg" text="시작이미지" btnFunc="fnUpload"/> accept="image/*" onchange="loadFile(this)"--%>
            <div class="col-xs-6">
                <label class="col-xs-2 control-label">
                    <spring:message code="시작이미지"/></label>
<%--                <div class="col-xs-8 control_content">--%>
<%--                    <ifvm:input type="text" id="startImgFilePath"/>--%>
<%--                </div>--%>
<%--                <button class="ifv_search_box_search_btn" id="btnBrowse1" >--%>
<%--                    <spring:message code="M00203"/>--%>
<%--                </button>--%>
<%--                <ifvm:input type="file" id="startImg" />--%>
                <div class="col-xs-8 control_content">
                <ifvm:inputNew type="imgUpload" varName="startImgUpload" maxCnt="1"
                               tempUpload="${pageContext.request.contextPath}/common/fileupload/tempUpload.do"
                               tempUploadIE="${pageContext.request.contextPath}/common/fileupload/tempUploadIE.do"
                               category="" imgWidth="96" imgHeight="96"
                               imgDeleteBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png"/>
                              <!--imgRotationBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png" -->
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-xs-2 control-label">
                    <spring:message code="종료이미지"/></label>
<%--                <div class="col-xs-8 control_content">--%>
<%--                    <ifvm:input type="text" id="endImgFilePath"/>--%>
<%--                </div>--%>
<%--                <button class="ifv_search_box_search_btn" id="btnBrowse2" >--%>
<%--                    <spring:message code="M00203"/>--%>
<%--                </button>--%>
<%--                <ifvm:input type="file" id="endImg" />--%>
                <div class="col-xs-8 control_content">
                <ifvm:inputNew type="imgUpload" varName="endImgUpload" maxCnt="1"
                               tempUpload="${pageContext.request.contextPath}/common/fileupload/tempUpload.do"
                               tempUploadIE="${pageContext.request.contextPath}/common/fileupload/tempUploadIE.do"
                               category="" imgWidth="96" imgHeight="96"
                               imgDeleteBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png"/>
                               <!--imgRotationBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png" -->
                </div>
            </div>
        </div>

        <div class="row qt_border">
            <ifvm:inputNew type="textarea" id="contents" dto="contents" labelClass="1" conClass="10" rows="5" label="설명" maxLength="200"/>
            <div class="row qt_border">
                <ifvm:inputNew type="text" id="urlWeb" names="urlWeb" dto="urlWeb" label="URL" labelClass="1" conClass="10" maxLength="300" disabled="true"/>
            </div>
        </div>
    </div>
</div>

<div id="areaSurveyDetailTab"></div>

<div id="popupLoyProgramList" class="popup_container"></div>

<script type="text/javascript">
    var ridSurvey;

    var pageObjectSurveyDetail = {
        ridSurvey: null,
        statusCode: null,
        usrTypeCd: null,
        areaSurveyDetailTab: null,
        init: function () {
            ridSurvey = '<%=request.getParameter("rid") %>';
            this.ridSurvey = (ridSurvey !== 'undefined' && ridSurvey !== 'null') ? ridSurvey : null;

            this.createSurveyDetailTab();

            this.setupCalendar();

            //인풋태그의 varName + Setting() 함수를 실행하여 이미지 업로더 초기 세팅을 한다.
            startImgUploadSetting();
            endImgUploadSetting();

            $.fn.ifvmSetSelectOptionCommCode("statusCode", "LOY_SURV_STAT_TYPE_CD", null, null, true);
            $.fn.ifvmSetSelectOptionCommCode("usrTypeCd", "SURVEY_USR_TYPE_CD", null, null, false);

            this.setupSurveyDetail();
        },
        createSurveyDetailTab: function () {
            this.areaSurveyDetailTab = $('#areaSurveyDetailTab').DrawTab({
                item: items
                <%--    [--%>
                <%--    {label: '<spring:message code="S00079"/> ', href: '<ifvm:url name="surveySectionList"/>'}, /* 설문항복정보 */--%>
                <%--    {label: '<spring:message code="L02651"/> ', href: '<ifvm:url name="surveyMemberList"/>'}, /* 참여자 */--%>
                <%--    /* {label: '<spring:message code="M00599"/> ', href: '<ifvm:url name="surveyOfferList"/>'}, */ /* 혜택 */--%>
                <%--    {label: '<spring:message code="S00080"/> ', href: '<ifvm:url name="surveyResultList"/>'} /* 설문결과 */--%>
                <%--]--%>
            });
        },
        setupCalendar: function () {
            var validStartDate = $("#validStartDate");
            var validEndDate = $("#validEndDate");

            var defaultStartDate = $.ifvGetTodayDate();
            var defaultEndDate = $.ifvGetNewDate('d', 30).newDateS;

            validStartDate.val(defaultStartDate);
            validEndDate.val(defaultEndDate);

            validStartDate.ifvDateChecker({
                maxDate: validEndDate
            });
            validEndDate.ifvDateChecker({
                minDate: validStartDate
            });
        },
        setupSurveyDetail: function () {
            if ($.fn.ifvmIsNotEmpty(this.ridSurvey)) {
                $.ifvSyncPostJSON('<ifvm:action name="getSurveyDetail"/>', {
                    ridSurvey: this.ridSurvey
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        $("#areaSurveyDetail").dataSetting(result);

                        //날짜 포멧
                        var startDate = $.ifvFormatDate('yyyy-mm-dd', result.validStartDate)
                        $('#validStartDate').val(startDate);
                        var endDate = $.ifvFormatDate('yyyy-mm-dd', result.validEndDate)
                        $('#validEndDate').val(endDate);
                        pageObjectSurveyDetail.ridSurvey = result.ridSurvey;
                        if(result.ridStartImage) {
                            startImgUpload.ridImage = result.ridStartImage;
                            var imagePath = result.startImageFolder;
                            var imageName = result.startImageFileName + result.startImageFileType;
                            var imageUrl = '<ifvm:url name="imageView"/>' + '?imagePath=' + encodeURI(imagePath) + '&imageName=' + encodeURI(imageName);

                            startImgUpload.setImgArr([{
                                imgOrgUrl: imageUrl
                            }])
                        }
                        if(result.ridEndImage){
                            endImgUpload.ridImage = result.ridEndImage;
                            var imagePath = result.endImageFolder;
                            var imageName = result.endImageFileName + result.endImageFileType;
                            var imageUrl = '<ifvm:url name="imageView"/>' + '?imagePath=' + encodeURI(imagePath) + '&imageName=' + encodeURI(imageName);

                            endImgUpload.setImgArr([{
                                imgOrgUrl: imageUrl
                            }])
                        }

                        pageObjectSurveyDetail.statusCode = result.statusCode;
                        pageObjectSurveyDetail.usrTypeCd = result.usrTypeCd;
                    }
                }, function (result) {
                    alert(result.message);
                });
            }
        },
        saveSurveyDetail: function () {
            var areaSurveyDetail = $("#areaSurveyDetail");
            var validation = areaSurveyDetail.ifvValidation();

            if (validation.confirm()) {
                var targetUrl = this.ridSurvey ? '<ifvm:action name="modifySurveyDetail"/>' : '<ifvm:action name="addSurveyDetail"/>';
                var reqData = areaSurveyDetail.getSubmitData();
                reqData.ridSurvey = this.ridSurvey;
                reqData.ridStartImage = startImgUpload.ridImage;
                reqData.ridEndImage = endImgUpload.ridImage;
                reqData.startImageData = startImgUpload.getImageList()[0] ? startImgUpload.getImageList()[0] : null;
                reqData.endImageData = endImgUpload.getImageList()[0] ? endImgUpload.getImageList()[0] : null;
                reqData.startImageData ? delete reqData.startImageData.category : true;
                reqData.endImageData ? delete reqData.endImageData.category : true;

                $.ifvSyncPostJSON(targetUrl, reqData,
                    function (result) {
                        alert('<spring:message code="L00076"/>');
                        pageObjectSurveyDetail.ridSurvey = result.ridSurvey;
                        qtjs.href('<ifvm:url name="surveyDetail"/>?rid='+pageObjectSurveyDetail.ridSurvey)
                    }, function (response) {
                        alert(response.message);
                    });
            }
        },
        moveSurveyList: function () {
            qtjs.href('<ifvm:url name="surveyList"/>');
        },
        showSurveyPreview: function () {
            $('[id*="popupSurveyPreview"], [name*="popupSurveyPreview"]').remove();

            $('<div id="popupSurveyPreview" class="popup_container"></div>')
                .appendTo('body')
                .ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="popupSurveyPreview"/>' + '?rid=' + this.ridSurvey,
                    contentType: 'ajax',
                    title: '미리보기',
                    width: 700,
                    height: 900,
                    open: function () {
                        new ifvm.PopupCenter({
                            popupDivId: 'popupSurveyPreview'
                        });
                    }
                });
        },
        copySurveyDetail: function () {
            if (!this.ridSurvey) {
                alert('저장되지 않은 설문은 복사하실 수 없습니다.');
                return;
            }

            if (confirm('해당 설문을 복사하시겠습니까?')) {
                $.ifvPostJSON('${pageContext.request.contextPath}/loyalty/survey/copySurveyDetail.do', {
                    ridSurvey: this.ridSurvey
                }, function (response) {
                    alert('설문이 복사되었습니다.');

                    var uri = '<ifvm:url name="surveyDetail"/>' + '?rid=' + response.ridSurvey;
                    qtjs.href(uri);
                })
            }
        }
    }

    function checkFile(data) {
        //data 안에는 임시 업로드할 file의 정보가 들어있음
        var fileType = data.files[0].name.split(".")[1].toUpperCase();
        var fileTypeList = ['JPG', 'PNG', 'GIF'];
        var fileSize = data.files[0].size;
        var standardFileSize = 1024 * 1024 * 5;
        if(fileTypeList.includes(fileType) && fileSize <= standardFileSize){
            return true;
        }
        else{
            alert("<spring:message code='M02144'/>")
            return false;
        }
    }




    $(document).ready(function () {
        pageObjectSurveyDetail.init();

        //사용자 지정 function
        startImgUpload.addFunc = function(data) {
            // 이미지 파일 유효성 검사
            return checkFile(data);
        }

        endImgUpload.addFunc = function(data) {
            // 이미지 파일 유효성 검사
            return checkFile(data);
        }
    });
</script>