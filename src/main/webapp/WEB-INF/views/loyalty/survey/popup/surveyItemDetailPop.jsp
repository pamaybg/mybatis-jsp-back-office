<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-12" id="survItemHead">
    </div>
</div>
<div class="form-horizontal top_well underline" id="areaSurveyItemDetail">
    <div class="row qt_border">
        <ifvm:inputNew type="number" id="sectionNo" names="sectionNo" dto="sectionNo"  label="설문 페이지" labelClass="2" conClass="4" required="true" disabled="true" />
        <ifvm:inputNew type="search" id="sectionContents" names="sectionContents" dto="sectionContents"  btnFunc="pageObjectSurveySectionDetailPop.searchSections" conClass="5" disabled="true" />
        <ifvm:inputNew type="hidden" id="surveySectionRid" names="surveySectionRid" dto="surveySectionRid"  conClass="1" required="true" disabled="true" />
    </div>
    <div class="row qt_border">
        <ifvm:inputNew type="number" id="itemNo" names="itemNo" dto="itemNo" required="true" label="S00090" labelClass="2" conClass="4"/>
        <ifvm:inputNew type="checkBox" id="optionalFlag" names="optionalFlag" dto="optionalFlag" label="선택 문항 여부" labelClass="2" conClass="1" values="Y"/>
        <div id="helpItem"style="float: left;">
            <a><i class="helpBtn" style="vertical-align: middle;">
                <div class="helptxt" style="display: none;">
                    ※ 답변 없이 다음으로 이동하거나 기타 TEXT 문항 선택시 선책 문항 여부에 체크를 해야 합니다.
                </div>
                <s></s>
            </i></a>
        </div>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="text" id="itemTitle" names="itemTitle" dto="itemTitle" required="true" label="S00091" labelClass="2" conClass="9" maxLength="200"/>
    </div>
    <div class="row qt_border">
        <%--<ifvm:inputNew type="select" id="fieldTypeCode" names="fieldTypeCode" dto="fieldTypeCode" required="true" label="유형" labelClass="2" conClass="9"/>--%>
        <ifvm:inputNew type="radio" id="fieldTypeCode" text="RADIO|CHECKBOX|TEXT|드롭다운(점수)"  values="RADIO|CHECK_BOX|TEXT|DROP_SCORE" dto="fieldTypeCode" names='fieldTypeCode' checkIndex="1" label="유형" labelClass="2" conClass="9" checked="false" required="true"/>
    </div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span>문항 부가 정보</span>
        </div>
    </div>

    <div class="row qt_border">
        <label class="control-label col-xs-2">이미지</label>
        <div class="col-xs-8 control_content">
            <ifvm:inputNew type="imgUpload" varName="itemImgUpload" maxCnt="1"
                           tempUpload="${pageContext.request.contextPath}/common/fileupload/tempUpload.do"
                           tempUploadIE="${pageContext.request.contextPath}/common/fileupload/tempUploadIE.do"
                           category="" imgWidth="70" imgHeight="70"
                           imgDeleteBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_x.png"/>
            <!--imgRotationBtn="${pageContext.request.contextPath}/resources/images/beacon/store/btn_post_img_rotation.png" -->
        </div>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="text" id="imageContents" names="imageContents" dto="imageContents" label="이미지 설명" labelClass="2" conClass="9"/>
    </div>

    <div id="areaExtendSurveyItem"></div>
</div>

<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="btnSaveSurveyItemDetail" btnFunc="pageObjectSurveySectionDetailPop.saveSurveyItemDetail" text="저장" objCode="btnSaveSurveyItemDetail_OBJ"/>
    <ifvm:inputNew type="button" id="btnCloseSurveyItemDetailPop" btnFunc="popupSurveyItemDetail.close" text="닫기" objCode="btnCloseSurveyItemDetailPop_OBJ"/>
</div>



<script type="text/javascript">
    var pageObjectSurveySectionDetailPop = {
        ridSurveySection: null,
        ridSurveyItem: null,
        ridImage: null,
        imageSurveyItem: null,
        init: function () {
            var ridSurveyItem = '<%=request.getParameter("rid") %>';
            this.ridSurveyItem = (ridSurveyItem !== 'undefined' && ridSurveyItem !== 'null') ? ridSurveyItem : null;

            if($.fn.ifvmIsEmpty(ridSurveySection)){
                sectionNo = "";
                sectionContents = "";
                ridSurveySection = "";
            }
            this.setTitleTemp();
            $("#sectionNo").val(sectionNo);
            $("#sectionContents").val(sectionContents);
            $("#surveySectionRid").val(ridSurveySection);

            itemImgUploadSetting();
            $.fn.ifvmSetSelectOptionCommCode("fieldTypeCode", "LOY_SURV_FIELD_CD", null, null, true);

            this.setupSurveyItemDetail();


        },
        setTitleTemp: function(){
            $("#survItemHead span").remove()
            var temp = '<span>'+'[페이지 번호 '+sectionNo+'] '+ sectionContents+'</span>'
            $("#survItemHead").append(temp);
            this.setupEventListeners();
        },
        setupRidSurveySection: function (ridSurveySection) {
            this.ridSurveySection = ridSurveySection;
        },
        setupEventListeners: function () {
            $('[name="fieldTypeCode"]').on('change',function () {
                pageObjectSurveySectionDetailPop.setupAreaExtendsSurveyItem(this.value);
            });
            //$('#fieldTypeCode').on('change', function () {
            //    pageObjectSurveySectionDetailPop.setupAreaExtendsSurveyItem(this.value);
            //});
        },
        setupAreaExtendsSurveyItem: function (value) {
            var areaExtendsSurveyItem = $('#areaExtendSurveyItem');
            areaExtendsSurveyItem.empty();

            if (value === 'DROP_NORMAL' || value === 'DROP_SCORE') {
                if (value === 'DROP_SCORE') {
                    areaExtendsSurveyItem.append($('#templateDropdownScore').tmpl());
                }

                areaExtendsSurveyItem.append($('#templateDropdownNormal').tmpl());
            }
        },
        setupSurveyItemDetail: function () {
            if (this.ridSurveyItem) {
                $.ifvSyncPostJSON('<ifvm:action name="getSurveyItemDetail"/>', {
                    ridSurveyItem: this.ridSurveyItem
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        pageObjectSurveySectionDetailPop.setupAreaExtendsSurveyItem(result.fieldTypeCode);

                        $('#areaSurveyItemDetail').dataSetting(result);
                      /*   $('[name="giveOfferFlag"]').prop('checked', 'Y' === result.giveOfferFlag); */
                        $('[name="optionalFlag"]').prop('checked', 'Y' === result.optionalFlag);

                        if (result.ridImage) {
                            itemImgUpload.ridImage = result.ridImage;
                            var imagePath = result.imageFolder;
                            var imageName = result.imageFileName + result.imageFileType;
                            var imageUrl = '<ifvm:url name="imageView"/>' + '?imagePath=' + encodeURI(imagePath) + '&imageName=' + encodeURI(imageName);

                            itemImgUpload.setImgArr([{
                                imgOrgUrl: imageUrl
                            }])

                            pageObjectSurveySectionDetailPop.ridImage = result.ridImage;
                        }
                    }
                });
            }
        },
        saveSurveyItemDetail: function () {
            var areaSurveyItemDetail = $("#areaSurveyItemDetail");
            var validation = areaSurveyItemDetail.ifvValidation();

            if (validation.confirm()) {
                var targetUrl = this.ridSurveyItem ? '<ifvm:action name="modifySurveyItemDetail"/>' : '<ifvm:action name="addSurveyItemDetail"/>';
                var reqData = areaSurveyItemDetail.getSubmitData();
                reqData.naFlag = $('[name="naFlag"]').is(':checked') ? 'Y' : '';
                /* reqData.giveOfferFlag = $('[name="giveOfferFlag"]').is(':checked') ? 'Y' : 'N'; */
                reqData.optionalFlag = $('[name="optionalFlag"]').is(':checked') ? 'Y' : 'N';
                reqData.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                reqData.ridSurveySection = $("#surveySectionRid").val();
                reqData.ridSurveyItem = this.ridSurveyItem;

                reqData.ridImage = itemImgUpload.ridImage;
                reqData.imageData = itemImgUpload.getImageList()[0] ? itemImgUpload.getImageList()[0] : null;
                reqData.imageData ? delete reqData.imageData.category : true;

                $.ifvSyncPostJSON(targetUrl, reqData, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert('<spring:message code="L00076"/>');
                        pageObjectSurveySectionDetail.searchSurveyItemList();
                        var index = 0;
                        pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.model.currentViewData.forEach(function (vf) {
                            if(result.message == vf.ridSurveyItem ){
                                pageObjectSurveySectionDetail.surveyItemGrid.opt.gridControl.selectRows(index);
                            }
                            index = index+1;
                        });
                        popupSurveyItemDetail.close();
                    }
                }, function (response) {
                    alert(response.message);
                });
            }
        },
        searchSections: function(){
            var targetFields = { ridSurvey: "ridSurvey"};
            var searchCond = null;
            $.fn.ifvmSearchHelpOpen(targetFields, searchCond, 'searchSectionPopupContainer', '<ifvm:url name="surveySectionListPop"/>', '설문 페이지 정보 조회', 1040);
        }
    };

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
        pageObjectSurveySectionDetailPop.init();

        $('#helpItem .helpBtn').setupHelpMessage();

        //사용자 지정 function
        itemImgUpload.addFunc = function(data) {
            // 이미지 파일 유효성 검사
            return checkFile(data);
        }
    });
</script>
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
        padding-bottom: 7px;
    }
</style>
<script id="templateDropdownNormal" type="text/x-jquery-tmpl">
<div class="row qt_border">
    <label class="control-label col-xs-2"></label>

    <ifvm:inputNew type="checkbox" id="naFlag" names="naFlag" values="Y" dto="naFlag" labelClass="2" conClass="4" text="해당 없음 항목 추가"/>
</div>
</script>

<script id="templateDropdownScore" type="text/x-jquery-tmpl">
<div class="row qt_border">
    <ifvm:inputNew type="select" id="startNum" names="startNum" dto="startNum" label="최소 점수" labelClass="2" conClass="3" values="0|1" text="0|1"/>
    <ifvm:inputNew type="select" id="endNum" names="endNum" dto="endNum" label="최고 점수" labelClass="3" conClass="3" values="5|7|10" text="5|7|10"/>
</div>
</script>
<div id="searchSectionPopupContainer" class="popup_container"></div>