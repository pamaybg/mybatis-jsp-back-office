<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
    <div class="col-xs-12" id="survItemAttrHead">
    </div>
</div>
<div class="form-horizontal top_well underline" id="areaSurveyItemAttrDetail">
    <div class="row qt_border">
        <ifvm:inputNew type="number" id="itemNo" names="itemNo" dto="itemNo"  label="설문 문항" labelClass="2" conClass="4" required="true" disabled="true" />
        <ifvm:inputNew type="search" id="itemTitle" names="itemTitle" dto="itemTitle"  btnFunc="pageObjectSurveyItemAttrDetailPop.searchItems" conClass="5" disabled="true" />
        <ifvm:inputNew type="hidden" id="surveyItemRid" names="surveyItemRid" dto="surveyItemRid"  conClass="1" required="true" disabled="true" />
    </div>
    <div class="row qt_border">
        <ifvm:inputNew type="number" id="itemAttrNo" names="itemAttrNo" dto="itemAttrNo" required="true" label="S00088" labelClass="2" conClass="9"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="text" id="itemAttrValue" names="itemAttrValue" dto="itemAttrValue" required="true" label="S00089" labelClass="2" conClass="9"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="number" id="targetSectionNo" names="targetSectionNo" dto="targetSectionNo" label="이동 페이지 번호" labelClass="2" conClass="9"/>
    </div>

    <div class="row qt_border">
        <ifvm:inputNew type="search" id="textItemNm" dto="textItemNm" btnFunc="pageObjectSurveyItemAttrDetailPop.searchTextItem" label="기타 문항" labelClass="2" conClass="7"/>
        <ifvm:inputNew type="hidden" id="ridTextItem" dto="ridTextItem" conClass="1"/>
        <div class="col-xs-1">
            <button class="btn btn-sm btn_lightGray2" id="removeTextItem" objCode="removeSurveyTextItem_OBJ" onclick=pageObjectSurveyItemAttrDetailPop.initSurveyItemControlled();>
                <spring:message code="L00031"/>
            </button>
        </div>
        <div id="helpItemAttr">
            <a><i class="helpBtn" style="vertical-align: middle; padding-left: 50px;">
                <div class="helptxt" style="display: none;">
                    ※ 기타 선택 시 이동할 문항을 선택 합니다.
                </div>
            </i></a>
        </div>
    </div>
    <%--<div class="row qt_border">
        <div class="col-xs-2"></div>
        <p style="color: red;">※ 기타 선택 시 이동할 문항을 선택 합니다.</p>
    </div>--%>

    <%-- <div class="row qt_border">
        <ifvm:inputNew type="checkBox" id="giveOfferFlag" names="giveOfferFlag" dto="giveOfferFlag" label="오퍼 제공 체크 항목" labelClass="2" conClass="9" values="Y"/>
    </div> --%>
</div>
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
<div class="pop_btn_area">
    <ifvm:inputNew type="button" id="btnAddSurveyItemAttrDetail" btnFunc="pageObjectSurveyItemAttrDetailPop.saveSurveyItemAttrDetail" text="저장" objCode="btnAddSurveyItemAttrDetail_OBJ"/>
    <ifvm:inputNew type="button" id="btnCloseSurveyItemAttrDetail" btnFunc="popupSurveyItemAttrDetail.close" text="닫기" objCode="btnCloseSurveyItemAttrDetail_OBJ"/>
</div>
<div id="popupContainer" class="popup_container"/>

<script type="text/javascript">
    var pageObjectSurveyItemAttrDetailPop = {
        ridSurveyItem: null,
        ridSurveyItemAttr: null,
        textItemYn: false,
        init: function () {
            var ridSurveyItemAttr = '<%=request.getParameter("rid") %>';
            this.ridSurveyItemAttr = (ridSurveyItemAttr !== 'undefined' && ridSurveyItemAttr !== 'null') ? ridSurveyItemAttr : null;

            if($.fn.ifvmIsEmpty(ridSurveyItem)){
                itemNo = "";
                itemTitle = "";
                ridSurveyItem = "";
            }
            this.setTitleTemp();
            $("#itemNo").val(itemNo);
            $("#itemTitle").val(itemTitle);
            $("#surveyItemRid").val(ridSurveyItem);

            this.setupSurveyItemAttrDetail();

        },
        setTitleTemp: function(){
            $("#survItemAttrHead span").remove()
            var temp = '<span>'+'[문항 번호 '+itemNo+'] '+ itemTitle+'</span>'
            $("#survItemAttrHead").append(temp);
        },
        setupRidSurveyItem: function (ridSurveyItem) {
            this.ridSurveyItem = ridSurveyItem;
        },
        setupSurveyItemAttrDetail: function () {
            if (this.ridSurveyItemAttr) {
                $.ifvSyncPostJSON('<ifvm:action name="getSurveyItemAttrDetail"/>', {
                    ridSurveyItemAttr: this.ridSurveyItemAttr
                }, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        $('#areaSurveyItemAttrDetail').dataSetting(result);

                        if (result.readonlyFlag === 'Y') {
                            $('#itemAttrNo').attr('disabled', true);
                            $('#itemAttrValue').attr('disabled', true);
                        }
                        if($.fn.ifvmIsNotEmpty(result.ridTextItem)) pageObjectSurveyItemAttrDetailPop.textItemYn = true;
                    }
                });
            }
        },
        saveSurveyItemAttrDetail: function () {
            var areaSurveyItemAttrDetail = $("#areaSurveyItemAttrDetail");
            var validation = areaSurveyItemAttrDetail.ifvValidation();

            if (validation.confirm()) {
                var targetUrl = this.ridSurveyItemAttr ? '<ifvm:action name="modifySurveyItemAttrDetail"/>' : '<ifvm:action name="addSurveyItemAttrDetail"/>';

                var reqData = areaSurveyItemAttrDetail.getSubmitData();
                //reqData.giveOfferFlag = $('[name="giveOfferFlag"]').is(':checked') ? 'Y' : 'N';
                reqData.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                reqData.ridSurveyItem = $("#surveyItemRid").val();
                reqData.ridSurveyItemAttr = this.ridSurveyItemAttr;

                $.ifvSyncPostJSON(targetUrl, reqData, function (result) {
                    if ($.fn.ifvmIsNotEmpty(result)) {
                        alert('<spring:message code="L00076"/>');
                        pageObjectSurveySectionDetail.searchSurveyItemAttrList();
                        popupSurveyItemAttrDetail.close();
                    }
                }, function (response) {
                    alert(response.message);
                });
            }
        },
        searchTextItem: function(){
            //var searchCond = this.ridSurveyItemAttr;
            $.fn.ifvmSearchHelpOpen(null, null, 'popupContainer', '<ifvm:url name="searchTextItemPop"/>', '기타 문항 조회');
        },
        initSurveyItemControlled: function(){
            if(this.textItemYn){
                $.ifvSyncPostJSON('<ifvm:action name="initSurveyItemControlled"/>', {
                    ridSurveyItemAttr: this.ridSurveyItemAttr
                }, function(result) {
                    alert('기타 문항을 초기화했습니다.');
                    pageObjectSurveyItemAttrDetailPop.textItemYn = false;
                    $('#textItemNm').val('');
                });
            }
            else{
                alert('기타 문항을 저장해주세요.');
            }
        },
        searchItems: function(){
            //var targetFields = { ridSurvey: "ridSurvey"};
            //var searchCond = null;
            $.fn.ifvmSearchHelpOpen(null, null, 'popupContainer', '<ifvm:url name="surveyItemListPop"/>', '설문 문항 정보 조회', 1040);
        }
    };

    $(document).ready(function () {
        pageObjectSurveyItemAttrDetailPop.init();

        $('#helpItemAttr .helpBtn').setupHelpMessage();
    });
</script>