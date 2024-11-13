<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var GameList = function () {
	    // 게임 RID
	    var _rid = null;
	    this.setRid = function (rid) {
	    	ifvGlobal["gameRid"] = rid;
	        _rid = rid;
	    }, this.getRid = function () {
	        return _rid;
	    },
        this.gameGridOptions = null,
        /* 게임 목록 */
        this.setGridAndDataLoad = function () {

            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
                if (_data.statCd === 'W') $('#btnRemove').prop('disabled', false);
                else $('#btnRemove').prop('disabled', true);
            };
            var _recordDoubleClick = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
                this.goToDetail();
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData,
                rowSelected: _rowSelected.bind(this),
                recordDoubleClick: _recordDoubleClick.bind(this),
                dataUrl: '<ifvm:action name="getGameList"/>',
                columns: [
                    {
                        field: 'gameNo',
                        headerText: '<spring:message code="L02796"/>',
                        width: '60px',
                        textAlign: 'center',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'gameNm',
                        headerText: '<spring:message code="L02795"/>',
                        width: '150px',
                        textAlign: 'left',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'statCdNm',
                        headerText: '<spring:message code="C00125"/>',
                        width: '100px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'statCd'
                        }
                    }, {
                        field: 'gameTypeCdNm',
                        headerText: '<spring:message code="L00155"/>',
                        width: '100px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'gameTypeCd'
                        }
                    }, {
                       field: 'joinTypeCdNm',
                       headerText: '<spring:message code="L02862"/>',
                       width: '100px',
                       textAlign: 'center',
                       customAttributes: {
                           index: 'joinTypeCd'
                       }
                    }, {
                        field: 'gameStartDate',
                        headerText: '<spring:message code="L00272"/>',
                        width: '80px',
                        textAlign: 'center'
                    }, {
                        field: 'gameEndDate',
                        headerText: '<spring:message code="L00273"/>',
                        width: '80px',
                        textAlign: 'center'
                    }, {
                        field: 'createBy',
                        headerText: '<spring:message code="O00080"/>',
                        width: '100px',
                        textAlign: 'center'
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00116"/>',
                        width: '80px',
                        textAlign: 'center'
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false
                    }],
                requestGridData: {
                    sidx: 'createDate'
                },
                radio: true
            };

            this.gameGridOptions = $("#gameGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            // 조회
            $('#searchCondBtn').on('click', function () {
                var _gameGridOptions = this.gameGridOptions;
                $.fn.ifvmSubmitSearchCondition("gameSearchList", function () {
                    _gameGridOptions.searchGrid({ item: requestitem });
                });
            }.bind(this));

            // 초기화
            $("#searchCondInitBtn").on('click', function () {
                $.fn.ifvmSetCommonCondList("gameSearchList", "LOY_GAME_LIST", "gameList");
            }.bind(this));

            // 신규 클릭시
            $('#btnAdd').on('click', function () {
                qtjs.href('<ifvm:url name="gameDetail"/>');
            });

            // 삭제
            $('#btnRemove').on('click', function () {
                this.removeAction();
            }.bind(this));

            // 중지
            $('#btnStop').on('click', function () {
                this.stopAction();
            }.bind(this));

            // 다운로드
            $('#btnDownload').on('click', function () {
                $.ifvExcelDn('<ifvm:action name="exportExcelGameList"/>','gameGrid');
            }.bind(this));

        },
        /* 게임 상세 이동 */
        this.goToDetail = function () {
            var _rid = this.getRid();
            qtjs.href('<ifvm:url name="gameDetail"/>' + "?rid=" + _rid);
        },
        /* 공통 조회 조건 목록 설정 */
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("gameSearchList", "LOY_GAME_LIST", "gameList");
        },
        /* 삭제 액션 */
        this.removeAction = function () {
            var _success = function () {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.setGridAndDataLoad();
                $('#btnRemove').prop('disabled', true);
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            var _rid = this.getRid();

            if ($.fn.ifvmIsNotEmpty(_rid)) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeGame"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        /* 중지 액션 */
        this.stopAction = function () {
            var _success = function () {
                $.ifvProgressControl(false);
                alert('<spring:message code="L02853"/>');
                this.setGridAndDataLoad();

            };

            var _fail = function (result) {
                alert(result.message);
                $.ifvProgressControl(false);
            };

            var _rid = this.getRid();

            if ($.fn.ifvmIsNotEmpty(_rid)) {
                if (confirm('<spring:message code="L02854"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="stopGame"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        /* 페이지 초기화 */
        this.init = function () {
            // 공통 조회 조건 목록 설정
            this.initSearchCondition();
            // 그리드 설정 및 데이터 로드
            this.setGridAndDataLoad();
            // 버튼 설정
            this.setButtons();
        }
	};

	$(document).ready(function () {
		var gameGrid = new GameList();
		gameGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="L02863" />
		&gt; <spring:message code="L00030" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="gameListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="L00030" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="gameListsearchCondInitBtn_OBJ">
				<spring:message code="L00031" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="gameSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="L00033" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" objCode="gameListAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" disabled="true" objCode="gameListRemove_OBJ"/>
            <ifvm:inputNew type="button" text="L02840" id="btnStop" objCode="gameListStop_OBJ"/>
            <ifvm:inputNew type="button" text="L02536" id="btnDownload" objCode="gameListDown_OBJ"/>
		</div>
	</div>
	<div id="gameGrid" class="white_bg grid_bd0"></div>
</div>