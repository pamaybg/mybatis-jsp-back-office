<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var PgmList = function () {
	    // 프로그램 RID
	    var _rid = null;
	    this.setRid = function (rid) {
	    	ifvGlobal["pgmRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
	        return _rid;
	    },
        this.pgmGridOptions = null,
        /* 프로그램 목록 */
        this.setGridAndDataLoad = function () {

            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
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
                dataUrl: '<ifvm:action name="getPgmList"/>',
                columns: [ // '대표여부', '프로그램 번호', '프로그램명', '주관사', '상태', '생성일','최종수정일','수정자' , 'rid'
                    {
                        field: 'repYn',
                        headerText: '<spring:message code="L02714"/>',
                        textAlign : 'center',
                        width: '70px',
                    }, {
                        field: 'pgmNo',
                        headerText: '<spring:message code="L00087"/>',
                        width: '80px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'pgmNm',
                        headerText: '<spring:message code="L00088"/>',
                        width: '200px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'chnlNm',
                        headerText: '<spring:message code="L00089"/>',
                        width: '200px',
                    }, {
                        field: 'pgmTypeNm',
                        headerText: '<spring:message code="M00559"/>',
                        width: '70px',
                        textAlign : 'center',
                        customAttributes: {
                            index: 'pgmType'
                        }
                    }, {
                        field: 'pgmStatNm',
                        headerText: '<spring:message code="L00090"/>',
                        width: '50px',
                        textAlign : 'center',
                        customAttributes: {
                            index: 'pgmStat'
                        }
                    }, {
                        field: 'createDate',
                        textAlign : 'center',
                        headerText: '<spring:message code="L00092"/>',
                        width: '80px',
                    }, {
                        field: 'modifyBy',
                        textAlign : 'center',
                        headerText: '<spring:message code="L00095"/>',
                        width: '100px',
                    }, {
                        field: 'modifyDate',
                        textAlign : 'center',
                        headerText: '<spring:message code="L02703"/>',
                        width: '80px',
                    }, {
						field: 'createDate',
						textAlign : 'center',
						headerText: '<spring:message code="L01125"/>',
						width: '80px',
					}, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                    }],
                requestGridData: {
                    sidx: 'pgmStat ASC, repYn DESC, pgmNo ASC, pgmType ',
                },
                radio: true
            };

            this.pgmGridOptions = $("#pgmList").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            // 조회
            $('#searchCondBtn').on('click', function () {
                var _pgmGridOptions = this.pgmGridOptions;
                $.fn.ifvmSubmitSearchCondition("pgmSearchList", function () {
                    _pgmGridOptions.searchGrid({ item: requestitem });
                });

            }.bind(this));

            // 초기화
            $("#searchCondInitBtn").on('click', function () {
                $.fn.ifvmSetCommonCondList("pgmSearchList", "PLOY_001", "pgmList");
            }.bind(this));

            // 신규 클릭시
            $('#btnAdd').on('click', function () {
                qtjs.href('<ifvm:url name="pgmDetail"/>');
            });

            // 삭제
            $('#btnRemove').on('click', function () {
                this.removeAction();
            }.bind(this));

        },
        /* 프로그램 상세 이동 */
        this.goToDetail = function () {
            qtjs.href('<ifvm:url name="pgmDetail"/>' + "?rid=" + this.getRid());
        },
        /* 공통 조회 조건 목록 설정 */
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("pgmSearchList", "PLOY_001", "pgmList");
        },
        /* 삭제 액션 */
        this.removeAction = function () {
			if($.fn.ifvmIsEmpty(this.pgmGridOptions.opt.gridControl.getSelectedRecords())){
				//this.pgmGridOptions.opt.gridControl.getSelectedRecords().length > 0
				alert('목록을 선택하세요.')
				return ;
			}else{
				var _success = function () {
					$.ifvProgressControl(false);
					setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
					this.setGridAndDataLoad();
				};

				var _fail = function (result) {
					$.ifvProgressControl(false);
					setTimeout(`alert(result.message)`, 0);
				};

				var _rid = this.getRid();

				if ($.fn.ifvmIsNotEmpty(_rid)) {
					if (confirm('<spring:message code="L00086"/>')) {
						$.ifvProgressControl(true);
						$.ifvPostJSON('<ifvm:action name="removePgm"/>', { rid: _rid }, _success.bind(this), _fail);
					}
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
		var pgmGrid = new PgmList();
		pgmGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="L00119" />
		&gt; <spring:message code="L00081" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="pgmListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="L00081" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="pgmListsearchCondInitBtn_OBJ">
				<spring:message code="L00082" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="pgmSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" objCode="pgmListNewBtnAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" objCode="pgmListNewBtnRemove_OBJ"/>
		</div>
	</div>
	<div id="pgmList" class="white_bg grid_bd0"></div>
</div>