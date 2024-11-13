<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
    var campaignResultDetailGrid;			//조회결과 그리드 (캠페인 목록)
    var campaignPromExecGrid;		//프로모션 그리드
    var channelUnsentPop;
    var itemId;
    var chnlId;
    var dataType;

    var obj = null;
    var id = null;
    var chId = null;

    /**
     * 화면 초기화
     */
    function initCampaignExecInfo(iId, cId, type) {
        itemId = iId;
        chnlId = cId;
        dataType = type;
        // if(dataType == 'PUSH'){
        // 	$('#campaignresultReasonBtn').hide()
        //푸쉬 캠페인 정보
        // pushCampaignResult();
        // } else {
        // 	$('#campaignresultReasonBtn').show()
        //캠페인 정보
        campaignResult();
        // }
    }

    /**
     * 푸쉬 캠페인 목록
     */
    function pushCampaignResult() {

        var ejGridOption = {
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                data.itemId = itemId;
                data.chnlId = chnlId;
                data.dataType = dataType;

                return data;
            },
            dataUrl: '<ifvm:action name="getPushCampaignDetailForExecResultOfList"/>',
            columns: [
                {
                    field: 'memId', headerText: '<spring:message code="V00004"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T1.MEM_ID'
                    }/*회원번호*/
                }, {
                    field: 'deviceUuId', headerText: '<spring:message code="V00298"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T3.DEVICE_UUID'
                    }/*Device UUID*/
                }
                , {
                    field: 'deviceAgreYn', headerText: '기기 동의 여부', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T3.DEVICE_AGRE_YN'
                    }/*Device Agree Yn */
                }
                , {
                    field: 'batSendStatus', headerText: '<spring:message code="M02993"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'batSendStatus'
                    }/*채널 전송 여부*/
                }, {
                    field: 'sendSucesYn', headerText: '<spring:message code="M02994"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'sendSucesYn'
                    }/*전송 성공 여부*/
                }, {
                    field: 'sendFailYn', headerText: '<spring:message code="M02995"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'sendFailYn'
                    }/*전송 실패 여부 */
                }, {
                    field: 'readSucesYn', headerText: '<spring:message code="M02996"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'readSucesYn'
                    }/*읽음(오픈) 여부 */
                }, {
                    field: 'revSucesYn', headerText: '<spring:message code="M02997"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'revSucesYn'
                    }/*수신 여부 */
                }, {
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        index: 'T1.ID'
                    }/*아이디*/
                },
            ],
            requestGridData: {
                nd: new Date().getTime(),
                sidx: 'T1.MEM_ID',
                sord: 'desc',
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridSimplePageTemplete'
        };

        campaignResultDetailGrid = $("#campaignResultDetailGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    /**
     * 캠페인 목록
     */
    function campaignResult() {

        var ejGridOption = {
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                data.itemId = itemId;
                data.chnlId = chnlId;
                data.dataType = dataType;

                return data;
            },
            dataUrl: '<ifvm:action name="getCampaignDetailForExecResultOfList"/>',
            columns: [
                {
                    field: 'memId', headerText: '사용자 ID', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T1.MEM_ID'
                    }/*유저 ID*/
                },
                {
                    field: 'mbrNo', headerText: '<spring:message code="V00004"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'lm.MBR_NO'
                    }/*회원번호*/
                }, {
                    field: 'ctrlGroupYn', headerText: '<spring:message code="M00746"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T1.CTRL_GROUP_YN'
                    }/*대상자 */
                }, {
                    field: 'batSendStatus', headerText: '<spring:message code="M03068"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'batSendStatus'
                    }/*발송 성공/실패*/
                }, {
                    field: 'failCode', headerText: '<spring:message code="M03069"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'failCode'
                    }/*실패/제외 코드*/
                }, {
                    field: 'failReason', headerText: '<spring:message code="M03070"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'failReason'
                    }/*실패/제외 사유 */
                }, {
                    field: 'readSucesYn', headerText: '<spring:message code="L02184"/>', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'readSucesYn'
                    }/*오픈여부 */
                },/*{
	      		  field : 'revSucesYn', headerText : '<spring:message code="M02997"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'revSucesYn' }/!*수신 여부 *!/
	      	  },*/{
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        index: 'T1.ID'
                    }/*아이디*/
                }, {
                    field: 'memId', headerText: 'memId', visible: false,
                    customAttributes: {
                        index: 'T1.MEM_ID'
                    }/*컬럼 아이디*/
                }, {
                    field: 'usrId', headerText: 'usrId', visible: false,
                    customAttributes: {
                        index: 'lc.USR_ID'
                    }/*회원 아이디*/
                }
            ],
            requestGridData: {
                nd: new Date().getTime(),
                sidx: 'T1.MEM_ID',
                sord: 'desc',
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridSimplePageTemplete'
        };

        campaignResultDetailGrid = $("#campaignResultDetailGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    //공통 조회 조건 목록 설정
    function campaignSearchInitBtn(gridId) {
        $.fn.ifvmSetCommonCondList("SearchList", "STNCAM005", gridId);
    }

    // 공통 조회 호출
    function campaignSearchBtn() {
        $.fn.ifvmSubmitSearchCondition("SearchList", function () {
            campaignResultDetailGrid.searchGrid({
                item: requestitem
            });
        });
    }

    function campaignExeclDownBtn() {
        if (dataType == 'PUSH') {
            $.ifvExcelDn('<ifvm:action name="getPushCampaignDetailForExecResultOfListDown"/>', 'campaignResultDetailGrid');

        } else {
            $.ifvExcelDn('<ifvm:action name="getCampaignDetailForExecResultOfListDown"/>', 'campaignResultDetailGrid');
        }
    }

    function campaignresultReasonBtn() {

        if (campaignResultDetailGrid.opt.gridControl.getSelectedRecords().length > 0) {
            obj = campaignResultDetailGrid.opt.gridControl.getSelectedRecords()[0].batSendStatus;
            id = campaignResultDetailGrid.opt.gridControl.getSelectedRecords()[0].id;
            chId = chnlId;
            if (obj == 'N') {
                $("#campaignresultReasonPopup").ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="execStatusErrorHistoryPop"/>',
                    contentType: "ajax",
                    title: '<spring:message code="M01357"/>',
                    width: 940,
                    close: 'campaignresultReasonPopupClose'
                });
            } else {
                alert('<spring:message code="M02998" />');
            }
        } else {
            alert('<spring:message code="M00004" />');
        }
    }

    function campaignresultReasonPopupClose() {
        campaignresultReasonPopup._destroy();
    }

    $(document).ready(function () {

        campaignSearchInitBtn();
        //조회
        $('#campaignSearchBtn').on('click', function () {
            campaignSearchBtn();
        });
        //초기화
        $('#campaignSearchInitBtn').on('click', function () {
            campaignSearchInitBtn('campaignResultDetailGrid');
        });
        //엑셀 다운로드
        $('#campaignExeclDownBtn').on('click', function () {
            campaignExeclDownBtn();
        });
        //미전송 사유
        $('#campaignresultReasonBtn').on('click', function () {
            campaignresultReasonBtn();
        });
        //닫기
        $('#channelUnsentPopCloseBtn').on('click', function () {
            channelUnsentPopClose();
        });
    });
</script>
<div class="page-title" style="padding-left: 20px;">
    <h1>
        <spring:message code="L01838"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-20 searchbtn_r" style="padding-top: 6px;">
            <button class="btn btn-sm" id="campaignSearchBtn" objCode="campaignExecListSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135"/>
            </button>
            <button class="btn btn-sm" id="campaignSearchInitBtn" objCode="campaignExecListSearchInitBtn_OBJ">
                <spring:message code="M00278"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="SearchList">
    </div>
</div>

<!-- 캠페인 목록 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span id="unSentPopName"><spring:message code="M01217"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignExeclDownBtn" objCode="campaignExeclDownBtn_OBJ">
                <spring:message code="M01218"/>
            </button>
            <%--        <button class="btn btn-sm" id="campaignresultReasonBtn" objCode="campaignresultReasonBtn_OBJ">
                        <spring:message code="M01357" />
                    </button>--%>
        </div>
    </div>
    <div id="campaignResultDetailGrid" class="white_bg grid_bd0"></div>
</div>
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_lightGray2" id="channelUnsentPopCloseBtn" objCode="channelUnsentPopCloseBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
<div id="campaignresultReasonPopup" class="popup_container"></div>
