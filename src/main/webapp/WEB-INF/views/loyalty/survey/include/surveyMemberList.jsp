<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span>대상 및 참여자</span>
    </div>
    <div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="btnUnmasking" text="마스킹해제" objCode="surveyMbrListMask_OBJ" btnFunc="pageObjectSurveyMemberDetail.clearSurveyMemberMaskingDetail"/>
    </div>
</div>

<div id="surveyMemberGrid"></div>

<script type="text/javascript">

    var pageObjectSurveyMemberDetail = {
        surveyMemberGrid: null,
        init: function () {
            this.createSurveyMemberGrid();
        },
        createSurveyMemberGrid: function () {
            var ejGridOption = {
                serializeGridData: function (data) {
                    data.ridSurvey = pageObjectSurveyDetail.ridSurvey;
                    return data;
                },
                allowResizing : false,
                dataUrl: '<ifvm:action name="getSurveyMemberList"/>',
                columns: [
                    {
                        field: 'ridSurveyMember', headerText: 'ridSurveyMember', visible: false
                    }, {
                        field: 'ridMember', headerText: 'ridMember', visible: false
                    }, {
                        field: 'memberNo', headerText: '회원번호', textAlign: 'center', customAttributes: {searchable: true, index: 'Z.MBR_NO'}
                    }, {
                        field: 'customerName', headerText: '회원명', textAlign: 'center',
                    }, {
                        field: 'mobilePhoneNumber', headerText: '전화번호', textAlign: 'center',
                    }, {
                        field: 'selectedDate', headerText: '대상 선정 일시', textAlign: 'center'
                    }, {
                        field: 'joinedFlag', headerText: '참여 여부', textAlign: 'center', customAttributes: {searchable: true, index: 'Z.JOIN_YN'}
                    }, {
                        field: 'joinedDate', headerText: '참여 일시', textAlign: 'center'
                    }
                ],
                requestGridData: {
                    sidx: 'selectedDate',
                    sord: 'asc',
                },
                rowList: [10, 25, 50, 100],
                radio: true
            };

            this.surveyMemberGrid = $("#surveyMemberGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        clearSurveyMemberMaskingDetail: function () {
            var selectedRecords = this.surveyMemberGrid.opt.gridControl.getSelectedRecords() || [];
            if (selectedRecords.length === 0) {
                alert('<spring:message code="M02219"/>');

                return;
            }

            if (selectedRecords.length > 1) {
                alert("마스킹해제는 1개씩만 가능합니다.");

                return;
            }

            $.ifvSyncPostJSON('<ifvm:action name="clearSurveyMemberMaskingDetail"/>', {
                ridMember: selectedRecords[0].ridSurveyMember
            }, function (result) {
                var gridControl = pageObjectSurveyMemberDetail.surveyMemberGrid.opt.gridControl;
                var selectedIndex = gridControl.getIndexByRow(gridControl.getSelectedRows());

                gridControl.setCellText(selectedIndex, gridControl.getColumnIndexByField('customerName'), result.unmaskingCustomerName);
                gridControl.setCellText(selectedIndex, gridControl.getColumnIndexByField('mobilePhoneNumber'), result.unmaskingMobilePhoneNumber);
            });
        }
    };

    $(document).ready(function () {
        pageObjectSurveyMemberDetail.init();
    });
</script>