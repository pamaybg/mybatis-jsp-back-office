<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>
<style type="text/css">
    .ifv_grid_templete .e-grid .e-headercell .sort_type.asc:after {
        content: '';
        height: '';
        width: '';
        background: '';
        display: none;
    }

    .ifv_grid_templete .e-grid .e-headercell .sort_type.desc:after {
        content: '';
        height: '';
        width: '';
        background: '';
        display: none;
    }
</style>

<!-- 회원ID 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrIdTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:
mbrId}}</span>


</script>


<script type="text/javascript">
    var targetGroupTargetListGrid;
    var targetGroup = {
        targetGroupId: "",
        targetGroupType: "SEG",
        data: {}
    }
    var targetColumnLen = 0;

    function initTargetGroupDetail() {
        var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';
        targetGroup.targetGroupId = $.fn.ifvmIsEmpty(targetGroupId) || targetGroupId == "null" ? '' : targetGroupId;

        //타겟그룹 상세 조회
        getTargetGroup();
    }

    //타겟그룹 상세 조회
    function getTargetGroup() {
        var targetGroupId = targetGroup.targetGroupId;

        $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="getTargetGroup"/>', {
                targetGroupId: targetGroupId
            },
            function (result) {
                //타겟그룹 설정
                setTargetGroup(result);
                targetGroup.data = result;

                getTargetGroupTargetList(false);
            },
            function (result) {
                $.errorChecker(result);
                $.ifvProgressControl(false);
            });
    }

    //1000단위 정규식
    function numberWithCommas(x) {
        if ($.fn.ifvmIsNotEmpty(x)) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        } else return 0;
    }

    //타겟그룹 설정
    function setTargetGroup(data) {
        $("#targetGroupName").val(data.targetGroupName);
        $("#targetGroupDesc").val(data.targetGroupDesc);
        $("#filterText").val(data.dpCond);

        //대상수 조회 오류 발생시 메시지
        if (data.targetCount == "MSG_T0001") {
            $.ifvErrorPop('<spring:message code="M01694"/>');
        } else {
            $("#targetCount").val(numberWithCommas(data.targetCount));
        }
        /*
        var comprGroupDtl = data.comprGroupDtl;
        var comprGroupTypeCode = data.comprGroupTypeCode;
        if (comprGroupTypeCode == "R") {
            comprGroupDtl += " %";
        } else if (comprGroupTypeCode == "C") {
            comprGroupDtl += '

        <spring:message code="M01196"/>';
    } else {
        comprGroupDtl = "";
    }
    $("#comprGroupDtl").val(comprGroupDtl);
     */
    }

    //타겟그룹 대상자 목록
    function getTargetGroupTargetList(getSelectFlag) {
        var targetGroupId = targetGroup.targetGroupId;
        var targetGroupColList = [];

        //타겟그룹 대상자 컬럼 목록 조회
        $.ifvSyncPostJSON('<ifvm:action name="getTargetGroupColumnList"/>', {
                targetGroupId: targetGroupId
            },
            function (result) {
                if (result.length > 0) {
                    targetGroupColList = result;
                }

                $.ifvProgressControl(false);

                if (targetGroupColList.length < 1 && $.fn.ifvmIsNotEmpty(targetGroup.targetGroupId)) {
                    //타겟그룹 대상자 그리드 설정
                    targetGroupColumnSetPopupOpen();
                } else {
                    setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag);
                }
            });
    }

    //타겟그룹 대상자 그리드 설정
    function setTargetGroupTargetListGrid(targetGroupColList, getSelectFlag) {

        var targetGroupId = targetGroup.targetGroupId;
        var columns = [];

        //타겟그룹 대상자 그리드 모델 설정
        $.each(targetGroupColList, function (index, col) {

            if (col.displayName == "사용자ID") {
                var model = {
                    field: col.columnName,
                    headerText: col.displayName,
                    headerTextAlign: 'center',
                    textAlign: 'center',
                    width: '80px',
                    template: "<span style=\"color : blue;cursor:pointer; text-decoration: underline; \">{{:" + col.columnName + "}}</span>",
                    customAttributes: {index: col.columnName}
                };
            } else {
                var model = {
                    field: col.columnName,
                    headerText: col.displayName,
                    headerTextAlign: 'center',
                    textAlign: 'center',
                    width: '80px',
                    customAttributes: {index: col.columnName}
                };
            }

            columns.push(model);
        });

        var ejGridOption = {
            serializeGridData: function (data) {
                data.targetGroupId = targetGroupId;

                return data;
            },
            recordClick: function (args) {
                <%--if (args.columnName == '사용자ID') {--%>
                <%--    $.ifvPostJSON('<ifvm:action name="getMbrNoFromCust"/>', {--%>
                <%--        userId: args.data.C0001--%>
                <%--    }, function (result) {--%>
                <%--        MbrDetail(result.ridMbr, result.custTypeCd);--%>
                <%--    });--%>
                <%--}--%>
            },
            recordDoubleClick: function (args) {
                $.ifvPostJSON('<ifvm:action name="getMbrNoFromCust"/>', {
                    userId: args.data.C0001
                }, function (result) {
                    MbrDetail(result.ridMbr, result.custTypeCd);
                });
            },
            columns: columns,
            allowSorting: true,
            requestGridData: {
                nd: new Date().getTime(),
                rows: 10,
                sidx: 1,
                sord: 'desc',
                _search: true
            },
            rowList: [10, 25, 50, 100],
            radio: false,
            isHorizontalScroll: true,
            tempId: 'ifvGridSimplePageTemplete'
        };

        if (getSelectFlag == true) {
            ejGridOption.dataUrl = '<ifvm:action name="getTargetGroupTargetList"/>';
        } else {
            ejGridOption.dataSource = [];
            ejGridOption.datatype = 'clientSide';
        }


        targetGroupTargetListGrid = $("#targetGroupTargetListGrid").ifvsfGrid({ejGridOption: ejGridOption});

        targetColumnLen = targetGroupColList.length;

        //대상수
        $("#targetCount").val();
    }

    //목록 이동
    function targetGroupList() {
        qtjs.href('<ifvm:url name="targetGroupList"/>');
    }

    function goMbrDetail(id) {
        //개인정보 조회 이력남기기
        var url = null;

        $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
        //    qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + id);
        $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>', {
            rid: '',
            mbrNo: id
        }, function (result) {
            if (result.custTypeCd != null) {
                if (result.custTypeCd == 'C') {
                    //개인정보 조회 이력남기기(법인)
                    url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid;
                } else if (result.custTypeCd == 'I' || result.custTypeCd == 'E' || result.custTypeCd == 'D' || result.custTypeCd == 'O' || result.custTypeCd == 'X') {
                    //개인정보 조회 이력남기기(개인/임직원)
                    url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid;
                }
            }
        });
        window.open(url, "_blank");

    }

    //컬럼 설정 팝업 열기
    function targetGroupColumnSetPopupOpen() {
        $("#targetGroupColumnSetPopup").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="targetGroupColumnSetPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M01496" />',
            width: 440,
            close: 'targetGroupColumnSetPopupClose'
        });
    }

    //컬럼 설정 팝업 닫기
    function targetGroupColumnSetPopupClose() {
        targetGroupColumnSetPopup._destroy();
    }

    //고객 상세 이동
    function MbrDetail(rid, custTypeCd) {
        if (custTypeCd != null) {
            if (custTypeCd == 'C') {
                //개인정보 조회 이력남기기(법인)
                qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid);
            } else if (custTypeCd == 'I' || custTypeCd == 'E' || custTypeCd == 'D' || custTypeCd == 'O' || custTypeCd == 'X') {
                //개인정보 조회 이력남기기(개인/임직원)
                qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid);
            }
        }
        $('#dialog_closebutton').trigger('click');
    }

    //엑셀 다운로드
    function excelDownload() {
        $.ifvExcelDn('<ifvm:action name="exportExcelTargetGroupTargetList"/>',
            'targetGroupTargetListGrid', {targetGroupId: targetGroup.targetGroupId});
    }

    //세그먼트 팝업 열기
    function openSegmentViewPopup() {
        var segmentId = targetGroup.data.segmentId;

        if ($.fn.ifvmIsNotEmpty(segmentId)) {
            $("#segmentViewPopup").ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="targetGroupSegmentViewPop"/>?segmentId=' + segmentId,
                contentType: "ajax",
                title: '<spring:message code="M00546" />',
                width: 800,
                close: 'segmentViewPopupClose'
            });
        }
    }

    //세그먼트 팝업 닫기
    function segmentViewPopupClose() {
        segmentViewPopup._destroy();
        $('.tooltip').remove();
    }

    //타겟그룹 상세 조회
    function getTargetGroupCount() {
        var targetGroupId = targetGroup.targetGroupId;

        $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="getTargetGroupCount"/>', {
                targetGroupId: targetGroupId
            },
            function (result) {
                //타겟그룹 설정
                setTargetGroup(result);
                targetGroup.data = result;

                getTargetGroupTargetList(false);
            },
            function (result) {
                $.errorChecker(result);
                $.ifvProgressControl(false);
            });
    }

    $(document).ready(function () {
        $.ifvmLnbSetting('targetGroupListNew');

        initTargetGroupDetail();

        //목록
        $('#targetGroupListBtn').on('click', function () {
            targetGroupList();
        });

        //대상자수 재조회
        $('#targetGroupCountBtn').on('click', function () {
            getTargetGroupCount();
        });

        //타겟팅대상자 목록 조회 버튼
        $('#tgtDtlListBtn').on('click', function () {
            $.ifvProgressControl(true, null, '<spring:message code="C00150" />');
            if ($('#targetCount').val() == '0') {
                alert('<spring:message code="대상자 수를 재조회 해주세요." />')
                $.ifvProgressControl(false);
            } else {
                setTimeout(function () {
                    getTargetGroupTargetList(true);
                }, 100);
            }
        });

        //컬럼 설정
        $('#columnSetBtn').on('click', function () {
            targetGroupColumnSetPopupOpen();
        });

        //엑셀 다운로드
        $('#excelDownloadBtn').on('click', function () {
            excelDownload();
        });

        //세그먼트 팝업
//     $('#segmentViewPopupOpenBtn').on('click', function(){
//         openSegmentViewPopup();
//     });
    });

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01494"/>
        &gt; <spring:message code="M00582"/>
    </h1>
</div>

<div id="targetGroupDetail_area">
    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code="M00556"/></span>
            </div>
            <div class="col-xs-5 searchbtn_r" id="targetGroupDetailBtn_area">
                <button class="btn btn-sm" id="targetGroupCountBtn" objCode="targetGroupCountBtn_OBJ">
                    대상자 수 재조회
                </button>
                <!--             <button class="btn btn-sm" id="segmentViewPopupOpenBtn"> -->
                <%--                 <i class="fa fa-search"></i><spring:message code="M00546" /> --%>
                <!--             </button> -->
                <button class="btn btn-sm" id="targetGroupListBtn" objCode="targetGroupListBtn_OBJ">
                    <spring:message code="M00002"/>
                </button>
            </div>
        </div>
        <div>
            <div class="well form-horizontal underline">
                <div class="row qt_border">
                    <label class="col-xs-1 control-label"><spring:message code="M01490"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="text" required="true" disabled="true" id="targetGroupName"/>
                    </div>
                </div>
                <div class="row qt_border">
                    <label class="col-xs-1 control-label"><spring:message code="M00324"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="text" required="true" disabled="true" id="targetGroupDesc"/>
                    </div>
                </div>
                <div class="row qt_border">
                    <%-- 대상수 --%>
                    <label class="col-xs-1 control-label"><spring:message code="M01495"/></label>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="text" required="true" disabled="true" id="targetCount"/>
                    </div>
                </div>
                <div class="row qt_border">
                    <%--<label class="col-xs-1 control-label"><spring:message code="M01232"/></label>--%>
                    <div class="col-xs-10 control_content">
                        <ifvm:input type="hidden" required="true" disabled="true" id="filterText"/>
                    </div>
                </div>

                <%-- 비교군 --%>
                <%--
             <div class="row qt_border">
                 <label class="col-xs-2 control-label"><spring:message code="M00846"/></label>
                 <div class="col-xs-9 control_content">
                     <ifvm:input type="text" required="true" disabled="true" id="comprGroupDtl" />
                 </div>
             </div>
              --%>
            </div>
        </div>
    </div>
    <div>
        <div class="page_btn_area">
            <div class="col-xs-5">
                <span><spring:message code="M01217"/></span>
            </div>
            <div class="col-xs-7 searchbtn_r">

                <%-- 조회 --%>
                <button class="btn btn-sm" id="tgtDtlListBtn" objCode="tgtDtlListBtn_OBJ">
                    <spring:message code="L00030"/>
                </button>

                <%-- 컬럼 설정 --%>
                <button class="btn btn-sm" id="columnSetBtn" objCode="columnSetBtn_OBJ">
                    <spring:message code="M01496"/>
                </button>

                <%-- 엑셀 다운로드 --%>
                <button class="btn btn-sm" id="excelDownloadBtn" objCode="excelDownloadBtn_OBJ">
                    <spring:message code="M01218"/>
                </button>
            </div>
        </div>
        <div id="targetGroupTargetListGrid" class="white_bg grid_bd0"></div>
    </div>
</div>
<div id="targetGroupColumnSetPopup"></div>
<div id="segmentViewPopup"></div>
