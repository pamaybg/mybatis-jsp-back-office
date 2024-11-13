<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 메뉴정보 -->
<div class="page-title">
    <h1>
        <spring:message code="실시간 캠페인 실행관리" /> &gt; <spring:message code="조회" />
    </h1>
</div>

<!-- 조회조건 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="searchCondBtn_OBJ">
                조회
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn"objCode="searchCondInitBtn_OBJ">
                초기화
            </button>
        </div>
    </div>

    <div class="well form-horizontal well_bt5" id="commSearchList"></div>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00312"/></span>
        </div>

        <div class="col-xs-5 searchbtn_r"> 
            <button class="btn btn-sm" id="eventNewBtn" objCode="eventNewBtn_OBJ">
                <i class="fa fa-plus"></i>
                <spring:message code="M00274"/>
            </button>

            <button class="btn btn-sm" id="eventDeleteBtn" objCode="eventDeleteBtn_OBJ">
                <i class="fa fa-minus"></i>
                <spring:message code="M00165"/>
            </button>

            <button class="btn btn-sm" id="realCampaignStop" objCode="realCampaignStop_OBJ">
                <i class="fa fa-pause"></i>
                중지
            </button>

            <button class="btn btn-sm" id="realCampaignStart" objCode="realCampaignStart_OBJ">
                <i class="fa fa-play"></i>
                실행
            </button>
        </div>
    </div>

    <div id="eventGridDiv" class="white_bg grid_bd0"></div>
</div>


<script type="text/javascript">

    var eventExecutionListPageObject = {
        eventGrid: null,
        execCode: null,
        init: function () {
            $.fn.ifvmSetCommonCondList("commSearchList", "PQIM_003", "eventGridDiv");
        },
        createEventGrid: function () {
            var ejGridOption = {
                serializeGridData: function (data) {
                	if (requestitem != null && requestitem.length > 0) {
                        data.item = requestitem;
                    }
                    return data;
                },
                recordDoubleClick: function (args) {
                    var rid = args.data.rid
                    qtjs.href('<ifvm:url name="rtCampaignExecutionDtl"/>?rid=' + rid);
                },
                dataUrl: '<ifvm:action name="getRealTimeCampaignExecutionList"/>',
                columns: [{
                    field: 'processNm', headerText: '서비스명', headerTextAlign: 'center', customAttributes: {
                        index: 't1.process_nm'
                    }
                }, {
                    field: 'processCd', headerText: '서비스 코드', headerTextAlign: 'center', customAttributes: {
                        index: 't1.process_cd'
                    }
                }, {
                    field: 'triggerType', headerText: '이벤트 유형', headerTextAlign: 'center', textAlign: 'center', customAttributes: {
                        index: 't1.trigger_type'
                    }
                }, {
                    field: 'processStatus', headerText: '처리기 상태', headerTextAlign: 'center', textAlign: 'center', customAttributes: {
                        index: 't1.process_status'
                    }
                }, {
                    field: 'serviceStatusName', headerText: '서비스 상태', headerTextAlign: 'center', textAlign: 'center', customAttributes: {
                        index: 't1.svc_status_cd'
                    }
                }, {
                    field: 'hndlMq', headerText: '핸들MQ', headerTextAlign: 'center', customAttributes: {
                        index: 'c1.hndl_mq'
                    }
                }, {
                    field: 'waitMq', headerText: '대기MQ', headerTextAlign: 'center', customAttributes: {
                        index: 't1.wait_mq'
                    }
                }, {
                    field: 'errMq', headerText: '에러MQ', headerTextAlign: 'center',
                    customAttributes: {
                        index: 't1.err_mq'
                    }
                }, {
                    field: 'svcExeMq', headerText: '실행제어RK', headerTextAlign: 'center',
                    customAttributes: {
                        index: 't1.svc_exe_mq'
                    }
                }, {
                    field: 'cachePort', headerText: '캐시 포트', headerTextAlign: 'center',
                    customAttributes: {
                        index: 't1.cache_port'
                    }
                }, {
                    field: 'startDt', headerText: '시작일시', headerTextAlign: 'center',
                    customAttributes: {
                        index: 't1.svc_start_dt'
                    }
                }, {
                    field: 'stopDt', headerText: '종료일시', headerTextAlign: 'center',
                    customAttributes: {
                        index: 't1.svc_stop_dt'
                    }
                }, {
                    field: 'minWorker', headerText: '최저 Worker', headerTextAlign: 'center', textAlign: 'center',
                    customAttributes: {
                        index: 't1.min_worker'
                    }
                }, {
                    field: 'maxWorker', headerText: '최대 Worker', headerTextAlign: 'center', textAlign: 'center',
                    customAttributes: {
                        index: 't1.max_worker '
                    }
                }, {
                        field: 'rid', visible: false,
                        customAttributes: {
                            index: 't1.max_worker '
                        }
                }],
                requestGridData: {
                    nd: new Date().getTime(),
                    rows: 10,
                    sidx: 't1.rid',
                    sord: 'desc',
                    _search: false
                },
                rowList: [10, 25, 50, 100],
                radio: true
            };

            eventExecutionListPageObject.eventGrid = $("#eventGridDiv").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        setEvent: function () {
            //조회
            $('#searchCondBtn').on('click', function () {
 					$.fn.ifvmSubmitSearchCondition("commSearchList", eventExecutionListPageObject.createEventGrid);
            });

            //초기화
            $("#searchCondInitBtn").on('click', function () {
            	eventExecutionListPageObject.init();
            });

            // Executor 실행
            $("#realCampaignStart").on('click', function () {
                $.ifvProgressControl(true);
                eventExecutionListPageObject.execute('RUN');
            });

            //실시간캠페인 중지
            $("#realCampaignStop").on('click', function () {
                $.ifvProgressControl(true);
                eventExecutionListPageObject.execute('STOP');
            });

            //신규 버튼
            $('#eventNewBtn').on('click', function () {
                qtjs.href('<ifvm:url name="rtCampaignExecutionDtl"/>');
            });

            //삭제 버튼
            $('#eventDeleteBtn').on('click', function () {
                var checkedList = eventExecutionListPageObject.eventGrid.opt.gridControl.getSelectedRecords();
                if (checkedList.length > 0) {
                    if (confirm('<spring:message code="M00127"/>')) {
                        var rid = checkedList[0].rid;

                        $.ifvPostJSON('<ifvm:action name="removeRealTimeCampaign"/>', {
                            rid: rid
                        }, function (result) {
                            if ($.fn.ifvmIsNotEmpty(result) && result.success) {
                                alert('<spring:message code="L00034"/>');
                                eventExecutionListPageObject.searchGridList();
                            }
                        });
                    }
                } else {
                    alert('<spring:message code="I00728"/>');
                }
            });
        },
        searchGridList: function () {
            eventExecutionListPageObject.eventGrid.searchGrid();
        },
        execute: function (type) {
            var checkedList = eventExecutionListPageObject.eventGrid.opt.gridControl.getSelectedRecords();
            if (checkedList.length === 1) {
                var processCode = checkedList[0].processCd;

                $.ifvPostJSON('<ifvm:action name="callApiCampaignExecutor"/>', {
                    execCd: type,
                    processCd: processCode
                }, function (result) {
                    if (result.rsltCd === '0') {
                         if (type === 'RUN') {
                            alert("실행되었습니다.");
                   		 } else if (type === 'STOP') {
                            alert("중지되었습니다.");
                     	}
                    } else {
                        if (result.rsltMsg != null) {
                            alert(result.rsltMsg);
                        } else {
                            alert("잠시 후에 다시 이용해 주세요.");
                        }
                    }
                    $.ifvProgressControl(false);
                    
                }, function (result) {
                    alert("잠시 후에 다시 이용해 주세요.");
                    $.ifvProgressControl(false);
                });
            } else {
                if (type === 'RUN') {
                    alert('실행할 목록을 선택해주세요.');
                } else if (type === 'STOP') {
                    alert("중지할 목록을 선택해주세요.");
                } else {
                    alert('선택된 목록를 확인해주세요.')
                }
                $.ifvProgressControl(false);
            }
        }
    };

    $(document).ready(function () {
        eventExecutionListPageObject.init();
        eventExecutionListPageObject.createEventGrid();
        eventExecutionListPageObject.setEvent();
        
    });
</script>