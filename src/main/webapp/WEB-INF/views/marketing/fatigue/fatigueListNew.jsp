<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>


    var fatigueSearchResult;
    var parId = null;
    var requestitem = [];

    //조회결과 그리드
    function fatigueSearchResultList() {

        var ejGridOption = {
            rowSelected: function (args) {
                setBtnActive(args.data.fatiState);
            },
            serializeGridData: function (data) {
                if (requestitem != null && requestitem.length > 0) {
                    data.item = requestitem;
                }
                return data;
            },
            recordDoubleClick: function (args) {
                var data = args.data
                //location.href = '<ifvm:url name="fatigueDetail"/>?id='+fatigueSearchResult.getRowData()[data-1].id;
                qtjs.href('<ifvm:url name="fatigueDetail"/>?id=' + data.id);
            },
            loadComplete: function (obj) {

            },
            dataUrl: '<ifvm:action name="getFatigueList"/>',
            columns: [
                {
                    field: 'fatiTitle', headerText: '<spring:message code="M03050"/>', headerTextAlign: 'center', width: '250px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(mfm.FATI_TITLE)', searchable: true
                    }/* */
                }, {
                    field: 'markName', headerText: '<spring:message code="M03051"/>', headerTextAlign: 'center', width: '100px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(c1.MARK_NAME)', searchable: true
                    }/* */
                }, {
                    field: 'fatiRestrictionDay', headerText: '<spring:message code="M03085"/>', headerTextAlign: 'center', width: '120px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(mfm.FATI_RESTRICTION_DAY)'
                    }/* */
                }, {
                    field: 'fatiMaxRestrictionDayCnt', headerText: '<spring:message code="M03053"/>', headerTextAlign: 'center', width: '130px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(mfm.FATI_MAX_RESTRICTION_DAY_CNT)', searchable: true
                    }/* */
                }, {
                    field: 'chnlList', headerText: '채널', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '180px',
                    customAttributes: {
                        index: 'max(mfci.CHNL_TYPE_CD)', searchable: true
                    }
                }, /*{
                    field: 'modifyBy', headerText: '<spring:message code="M03058"/>', headerTextAlign: 'center', width: '110px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(mfm.MODIFY_BY)'
                    }/!* *!/
                }, {
                    field: 'createDate', headerText: '<spring:message code="M00222"/>', headerTextAlign: 'center', width: '110px', textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'max(mfm.create_date)'
                    }/!* *!/
                }, */{
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'mfm.id'
                    }/* */
                },
                {
                    field: 'fatiState', headerText: 'fati_state', visible: false,
                    customAttributes: {
                        searchable: false,
                        index: 'mfm.FATI_STATE'
                    }/* */
                },
            ],
            requestGridData: {
                nd: new Date().getTime(),
                rows: 10,
                sidx: 'max(mfci.CHNL_TYPE_CD) DESC,max(mfm.create_date)',
                sord: 'desc',
                _search: false
            },
            tempId: 'ifvGridNotSearchTemplete',
            rowList: [10, 25, 50, 100],
            radio: true
        };
        fatigueSearchResult = $("#fatigueSearchResult").ifvsfGrid({ejGridOption: ejGridOption});
    }


    //공통 조회 조건 목록 설정
    function searchCondInit(gridid) {
        $.fn.ifvmSetCommonCondList("commSearchList", "MNGFTG001",gridid);
    }

    //공통 조회 호출
    function fatigueSerach() {
        $.fn.ifvmSubmitSearchCondition("commSearchList", fatigueSearchResultList);
    }

    //버튼 활성 설정
    function setBtnActive(state) {

        //적용중
        if (state == "A") {
            $("#fatigueUnApplyBtn").removeAttr('disabled');
            $("#fatigueApplyBtn").attr('disabled', true);
        }

        //비적용중
        else if (state == "S") {
            $("#fatigueApplyBtn").removeAttr('disabled');
            $("#fatigueUnApplyBtn").attr('disabled', true);
        }
        //그외
        else {
        }
    }

    $(document).ready(function () {
        //공통 조회 조건 목록 설정
        searchCondInit();

        $.ifvmLnbSetting('fatigueListNew');
        var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
        fatigueSearchResultList();

        //조회
        $("#authGroupSearchBtn").on('click', function () {
            //조회 호출
            fatigueSerach();
        });

        //초기화
        $('#authGroupinitBtn').on('click', function () {
            searchCondInit('fatigueSearchResult')

        });
//	searchCondInit()


        //조건 조회 분류 선태겡 따른 조건절 변경
        $(".searchTextVal").change(function () {
            fatigueChangeSelect($(this).parent().parent().children().children("#searchCon"));
        });

        //필수항목 플러스 버튼
        $('.itemPlusBtn').live('click', function () {
            if ($('.fatigueSearchCondition').length < 5) {
                for (var i = 0; i < $('.fatigueSearchCondition').length; i++) {
                    var showId = $('.fatigueSearchCondition')[i].id;
                    var defCon = $("#" + showId).attr('defcon');

                    if (defCon != 1) {
                        $("#" + showId).show();
                        $("#" + showId).attr('defcon', 1);
                        break;
                    }
                }

                flexMinusBtn();
            }
        });

        //필수항목 마이너스 버튼
        $('.itemMinusBtn').live('click', function () {

            if ($(this).parent().parent().attr('seq') != 0) {

                $(this).parent().parent().hide();

                $(this).parent().parent().attr('defcon', 0);
            }
        });

        //필수항목 type별 컨트롤 제어
        $(".searchCondition").live('change', function () {
            fatigueChangeSelect(this);
        });

        //신규
        $('#fatigueNewBtn').on('click', function () {
            //location.href = '<ifvm:url name="fatigueDetail"/>';
            qtjs.href('<ifvm:url name="fatigueDetail"/>');
        });
        //삭제
        $('#fatigueDelBtn').on('click', function () {
            if ($(fatigueSearchResult.opt.gridControl.getSelectedRecords()).length == 0) {
                alert('<spring:message code="M01051"/>');
            } else {
                if (confirm('<spring:message code="M01053"/>')) {

                    var sendId = null;
                    //console.log(programGrid.getCheckedGridData());
                    $(fatigueSearchResult.opt.gridControl.getSelectedRecords()).each(function (index, item) {
                        sendId = item.id;
                    });
                    $.ifvSyncPostJSON('<ifvm:action name="deleteFatigue"/>', {
                            id: sendId
                        },
                        function (result) {
                            alert('<spring:message code="M01049"/>');

                            fatigueSearchResultList();

                        });
                }
            }
        });

        //적용
        $('#fatigueApplyBtn').on('click', function () {
            var dataList = fatigueSearchResult.opt.gridControl.getSelectedRecords();
            var data;
            var fatiState;
            if (dataList.length != 0) {
                data = dataList[0];
                fatiState = data.fatiState;
            }
            if ($(fatigueSearchResult.opt.gridControl.getSelectedRecords()).length == 0) {
                alert('<spring:message code="M01051"/>');
            } else {
                // 피로도 미적용 여부 확인
                if (fatiState == "S") {
                    if (confirm('<spring:message code="M03063"/>')) {

                        var sendId = null;
                        //console.log(programGrid.getCheckedGridData());
                        $(fatigueSearchResult.opt.gridControl.getSelectedRecords()).each(function (index, item) {
                            sendId = item.id;
                        });
                        $.ifvSyncPostJSON('<ifvm:action name="applyFatigue"/>', {
                                id: sendId
                            },
                            function (result) {
                                alert('<spring:message code="M03065"/>');
                                fatigueSearchResultList();
                            }, function (result) {
                                alert("<spring:message code='I00742' />");
                            });
                    }
                }
            }
        });

        //미적용
        $('#fatigueUnApplyBtn').on('click', function () {
            var dataList = fatigueSearchResult.opt.gridControl.getSelectedRecords();
            var data;
            var fatiState;
            if (dataList.length != 0) {
                data = dataList[0];
                fatiState = data.fatiState;
            }

            if ($(fatigueSearchResult.opt.gridControl.getSelectedRecords()).length == 0) {
                alert('<spring:message code="M01051"/>');
            } else {
                // 피로도 적용 여부 확인
                if (fatiState == "A") {
                    if (confirm('<spring:message code="M03064"/>')) {

                        var sendId = null;
                        //console.log(programGrid.getCheckedGridData());
                        $(fatigueSearchResult.opt.gridControl.getSelectedRecords()).each(function (index, item) {
                            sendId = item.id;
                        });
                        $.ifvSyncPostJSON('<ifvm:action name="unApplyFatigue"/>', {
                                id: sendId
                            },
                            function (result) {
                                alert('<spring:message code="M03066"/>');
                                fatigueSearchResultList();
                            }, function (result) {
                                alert("<spring:message code='I00742' />");
                            });
                    }
                }
            }
        });
    });


</script>


<style>
    .well {
        padding-bottom: 5px;
    }
</style>

<div class="page-title">
    <h1>
        <spring:message code="M01030"/> &gt; <spring:message code="M00273"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id='authGroupSearchBtn' objCode="fatigueAuthGroupSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00273"/>
            </button>
            <button class="btn btn-sm" id='authGroupinitBtn' objCode="fatigueAuthGroupinitBtn_OBJ">
                <spring:message code="M01038"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01039"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="fatigueApplyBtn" objCode="fatigueApplyBtn_OBJ">
                <spring:message code="M03067"/>
            </button>
            <button class="btn btn-sm" id="fatigueUnApplyBtn" objCode="fatigueUnApplyBtn_OBJ">
                <spring:message code="M03062"/>
            </button>
            <button class="btn btn-sm" id="fatigueNewBtn" objCode="fatigueNewBtn_OBJ">
                <i class="fa fa-plus"></i>
                <spring:message code="M00274"/>
            </button>
            <button class="btn btn-sm" id="fatigueDelBtn" objCode="fatigueDelBtn_OBJ">
                <i class="fa fa-minus"></i>
                <spring:message code="M00275"/>
            </button>
        </div>
    </div>
    <div id="fatigueSearchResult" class="grid_bd0"></div>
</div>
