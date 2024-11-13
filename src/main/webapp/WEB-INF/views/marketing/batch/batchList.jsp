<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/x-jsrender" id="runStatFormatter">
	{{if status == "Y"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if status == "N"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>

<script type="text/x-jsrender" id="execStatFormatter">
	{{if resultCd == "R"}}
		<span style="color:#FFA500;">●</span>
	{{/if}}
	{{if resultCd == "S"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if resultCd == "F"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}

	{{if batchStatus == "S"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if batchStatus == "F"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}

	{{if batchStatusDtl == "S"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if batchStatusDtl == "F"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>

<script type="text/javascript">
	var batchObject = function () {
	    var _data = null;
	    var _rid = null;
	    var _batchExeLogHadId = null;
	    
	    this.setRid = function (rid) {
	        _rid = rid;
	    }, this.getRid = function () {
	        return _rid;
	    },
	    this.setData = function (data) {
	        _data = data;
	    }, 
	    this.getData = function () {
	        return _data;
	    },
	    this.setBatchExeLogHadId = function(id) {
	    	_batchExeLogHadId = id;
	    },
	    this.getBatchExeLogHadId = function() {
	    	return _batchExeLogHadId;
	    },
        this.batchGrid = null,
        this.batchLogHadGrid = null,
        this.batchLogDtlGrid = null,
        /* 배치 목록 */
        this.setGridBatchDataLoad = function () {
            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.setData(data);
                
                this.setGridBatchLogHadDataLoad();
                
                this.setBatchExeLogHadId("X");
                this.setGridBatchLogDtlDataLoad();
            };
            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.setData(data);
                
                this.openPopup(data);
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData,
                rowSelected: _rowSelected.bind(this),
                //recordDoubleClick: _recordDoubleClick.bind(this),
                dataUrl: '/marketing/batch/getMktBatchJobList.do',
                columns: [
                    {
                        field: 'jobNm', headerText: 'Job', width: '100px', textAlign: 'left',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'jobDesc', headerText: 'Job명', width: '100px', textAlign: 'left',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'useYn', headerText: '사용여부', width: '100px', textAlign: 'center',
                    }, {
                        field: 'execCycle', headerText: 'Cron', width: '100px', textAlign: 'center',
                    }, {
                       field: 'status', headerText: '상태', width: '100px', textAlign: 'center', template : "#runStatFormatter"
						,customAttributes: {
							index : 'useYn'
						}
                    }, {
                        field: 'lastExecStartDt', headerText: '마지막 시작일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'lastExecEndDt', headerText: '마지막 종료일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'resultCd', headerText: '마지막 실행결과', width: '100px', textAlign: 'center', template : "#execStatFormatter"
                    }, {
                        field: 'rid', headerText: 'rid', visible: false
                    }],
                requestGridData: {
                    sidx: 'create_date'
                },
                radio: true
            };

            this.batchGrid = $("#batchGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 배치 로그 헤더 목록 */
        this.setGridBatchLogHadDataLoad = function () {
            var _serializeGridData = function (data) {
            	var batchData = this.getData();
            	data.jobNm = batchData.jobNm;
            	
                return data;
            };
            var _rowSelected = function (args) {
                var data = args.data;
                this.setBatchExeLogHadId(data.batchExeLogHadId); 
                
                this.setGridBatchLogDtlDataLoad();
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                rowSelected: _rowSelected.bind(this),
                //recordDoubleClick: _recordDoubleClick.bind(this),
                dataUrl: '/marketing/batch/getMktBatchLogHadList.do',
                columns: [
                    {
                        field: 'batchWrkjobNm', headerText: '배치구분명', width: '100px', textAlign: 'left',
                        customAttributes: {
                            searchable: true, index : 'c1.MARK_NAME'
                        }
                    }, {
                        field: 'batchNm', headerText: '배치명', width: '100px', textAlign: 'left',
                        customAttributes: {
                            searchable: true, index : 'c2.MARK_NAME'
                        }
                    }, {
                       field: 'startDt', headerText: '실행 시작일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'endDt', headerText: '실행 종료일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'batchStatus', headerText: '실행 결과', width: '100px', textAlign: 'center', template : "#execStatFormatter"
                    }, {
                        field: 'batchExeLogHadId', headerText: 'batchExeLogHadId', visible: false
                    }],
                requestGridData: {
                    sidx: 't1.create_date'
                },
                radio: true
            };

            this.batchLogHadGrid = $("#batchLogHadGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },        
        /* 배치 로그 상세 목록 */
        this.setGridBatchLogDtlDataLoad = function () {
            var _serializeGridData = function (data) {
            	data.batchExeLogHadId = this.getBatchExeLogHadId();
            	
                return data;
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData.bind(this),
                dataUrl: '/marketing/batch/getMktBatchLogDtlList.do',
                columns: [
                    {
                        field: 'batchModuleNm', headerText: '배치 모듈명', width: '100px', textAlign: 'left',
                        customAttributes: {
                            searchable: true, index : 'c3.MARK_NAME'
                        }
                    }, {
                       field: 'startDt', headerText: '실행 시작일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'endDt', headerText: '실행 종료일시', width: '100px', textAlign: 'center'
                    }, {
                        field: 'batchStatusDtl', headerText: '실행 결과', width: '100px', textAlign: 'center', template : "#execStatFormatter"
                    }, {
                        field: 'errCd', headerText: '오류 코드', width: '100px', textAlign: 'center'
                    }, {
                        field: 'errSbst', headerText: '오류 내용', width: '200px', textAlign: 'center',
						customAttributes: {index : 'errCd'
						}
                    }],
                requestGridData: {
                    sidx: 't1.create_date'
                },
                radio: true
            };

            this.batchLogDtlGrid = $("#batchLogDtlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },   
        /* 버튼 세팅 */
        this.setButtons = function () {
            // 조회
            $('#searchCondBtn').on('click', function () {
            	this.searchAction();
            }.bind(this));

            // 초기화
            $("#searchCondInitBtn").on('click', function () {
                $.fn.ifvmSetCommonCondList("batchSearchList", "MKT_BATCH_LIST", "gameList");
            }.bind(this));

            // 신규 클릭시
            $('#btnAdd').on('click', function () {
            	this.openPopup();
            }.bind(this));
            
            // 수정 클릭시
            $('#btnEdit').on('click', function () {
            	if ($.fn.ifvmIsNotEmpty(this.getData())) {
            		this.openPopup(this.getData());
            	} else {
            		alert('<spring:message code="M00285"/>');
            	}
            }.bind(this));

            // 삭제
            $('#btnRemove').on('click', function () {
                this.removeAction();
            }.bind(this));
            
            // 수동실행
            $('#btnRun').on('click', function () {
                this.runAction();
            }.bind(this));
            
            // 실행
            $('#btnStart').on('click', function () {
                this.startAction();
            }.bind(this));

            // 중지
            $('#btnStop').on('click', function () {
                this.stopAction();
            }.bind(this));

        },
        this.openPopup = function (data) {
        	$("#batchPopup").ifvsfPopup({
        		enableModal : true,
                enableResize: false,
                contentUrl: '/marketing/batch/popup/batchPop',
                contentType: "ajax",
                title: 'Job 등록/수정',
                width: 400,
                open : function() {
                	batchPopObj.init(data);
                },
                close : function() {
                	$.fn.ifvmPopupClose();
                }
            });
        },
        /* 공통 조회 조건 목록 설정 */
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("batchSearchList", "MKT_BATCH_LIST", "batchGrid");
        },
        this.searchAction = function() {
            var _batchGrid = this.batchGrid;
            $.fn.ifvmSubmitSearchCondition("batchSearchList", function () {
            	_batchGrid.searchGrid({ item: requestitem });
            });
        },
        /* 삭제 액션 */
        this.removeAction = function () {
        	var _this = this;
        	var data = this.getData();
        	
        	if ($.fn.ifvmIsNotEmpty(data)) {
				if(confirm('<spring:message code="I01500"/>')) {

					$.ifvPostJSON('/marketing/batch/removeMktBatchJob.do', data,
							function (result) {
								alert("삭제 하였습니다.");
								_this.searchAction();
								$.ifvProgressControl(false);
							},
							function (result) {
								alert(result.message);

								$.ifvProgressControl(false);
							});
				}
        	} else {
        		alert('<spring:message code="M00285"/>');
        	}
        },
        /* 중지 액션 */
        this.stopAction = function () {
			var _this = this;
            var data = this.getData();

            if ($.fn.ifvmIsNotEmpty(data)) {
                if (confirm('중지 할까요?')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('/marketing/batch/stopMktBatchJob.do', data, 
                    function(result) {
                    	alert("중지 하였습니다.");
                    	
                    	_this.searchAction();
                    	$.ifvProgressControl(false);
                    },
                    function(result) {
                    	alert(result.message);
                    	
                    	$.ifvProgressControl(false);
                    });
                }
        	} else {
        		alert('<spring:message code="M00285"/>');
        	}
        },
        /* 실행 액션 */
        this.runAction = function () {
        	var _this = this;
            var data = this.getData();

            if ($.fn.ifvmIsNotEmpty(data)) {
                if (confirm('수동 실행 할까요?')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('/marketing/batch/runMktBatchJob.do', data,
                    function(result) {
                    	alert("실행 하였습니다.");
                    	
                    	_this.searchAction();
                    	$.ifvProgressControl(false);
                    },
                    function(result) {
                    	alert(result.message);
                    	
                    	$.ifvProgressControl(false);
                    });
                }
        	} else {
        		alert('<spring:message code="M00285"/>');
        	}
        },
        /* 실행 액션 */
        this.startAction = function () {
        	var _this = this;
            var data = this.getData();

            if ($.fn.ifvmIsNotEmpty(data)) {
                if (confirm('실행 할까요?')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('/marketing/batch/startMktBatchJob.do', data,
                    function(result) {
                    	alert("실행 하였습니다.");
                    	
                    	_this.searchAction();
                    	$.ifvProgressControl(false);
                    },
                    function(result) {
                    	alert(result.message);
                    	
                    	$.ifvProgressControl(false);
                    });
                }
        	} else {
        		alert('<spring:message code="M00285"/>');
        	}
        }
        
        /* 페이지 초기화 */
        this.init = function () {
            // 공통 조회 조건 목록 설정
            this.initSearchCondition();
            // 그리드 설정 및 데이터 로드
            this.setGridBatchDataLoad();
            // 버튼 설정
            this.setButtons();
        }
	};

	var batchObj;
	$(document).ready(function () {
		batchObj = new batchObject();
		batchObj.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="마케팅 배치 관리" /> &gt; <spring:message code="조회" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="batchListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="L00030" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="batchListsearchCondInitBtn_OBJ">
				<spring:message code="L00031" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="batchSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="L00033" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" objCode="btnAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="plus" text="M00283" id="btnEdit" objCode="btnAdd_OBJ"/>
<%--			<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" objCode="btnRemove_OBJ"/>--%>
			<ifvm:inputNew type="button" text="수동실행" nuc="true" id="btnRun" objCode="btnRun_OBJ"/>
			<ifvm:inputNew type="button" text="M00603" id="btnStart" objCode="btnStart_OBJ"/>
            <ifvm:inputNew type="button" text="M02154" id="btnStop" objCode="btnStop_OBJ"/>
		</div>
	</div>
	<div id="batchGrid" class="white_bg grid_bd0"></div>
	
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span>배치 로그 헤더 목록</span>
		</div>
	</div>
	<div id="batchLogHadGrid" class="white_bg grid_bd0"></div>
	
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span>배치 로그 상세 목록</span>
		</div>
	</div>
	<div id="batchLogDtlGrid" class="white_bg grid_bd0"></div>
	
	<div id="batchPopup"></div>
</div>