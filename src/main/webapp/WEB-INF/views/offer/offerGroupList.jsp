<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var OfferGroupList = function () {
	    // 프로그램 RID
	    var _rid = null;
	    this.setRid = function (rid) {
	    	ifvGlobal["offerGroupRid"] = rid;
	        _rid = rid;
	    }, this.getRid = function () {
	        return _rid;
	    },
        this.offerGroupGridOptions = null,
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
                dataUrl: '<ifvm:action name="getOfferGroupList"/>',
                columns: [ // '번호', '그룹명', '유형', '총액', '참조오퍼번호', '생성일', '생성자'
                    {
                        field: 'ofrgrpNo',
                        headerText: '<spring:message code="O00060"/>',
                        width: '80px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrgrpNm',
                        headerText: '<spring:message code="O00061"/>',
                        width: '200px',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'ofrgrpTypeNm',
                        headerText: '<spring:message code="O00051"/>',
                        width: '100px',
                        textAlign : 'center',
                        customAttributes: {
                            index: 'ofrgrpType'
                        }
                    }, {
                        field: 'totAmt',
                        headerText: '<spring:message code="O00063"/>',
                        textAlign : 'right',
                        format: "{0:n0}",
                        width: '70px',
                    }, {
                        field: 'createBy',
                        headerText: '<spring:message code="O00012"/>',
                        textAlign : 'center',
                        width: '100px',
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00013"/>',
                        textAlign : 'center',
                        width: '80px',
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                    }],
                requestGridData: {
                    sidx: 'ofrgrpNo',
                },
                radio: true
            };

            this.offerGroupGridOptions = $("#ofrgrpList").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            // 조회
            $('#searchCondBtn').on('click', function () {
                var _offerGroupGridOptions = this.offerGroupGridOptions;
                $.fn.ifvmSubmitSearchCondition("offerGroupSearchList", function () {
                    _offerGroupGridOptions.searchGrid({ item: requestitem });
                });

            }.bind(this));

            // 초기화
            $("#searchCondInitBtn").on('click', function () {
                // 다시 확인
            }.bind(this));

            // 신규 클릭시
            $('#btnAdd').on('click', function () {
                qtjs.href('<ifvm:url name="offerGroupDetail"/>');
            });

            // 삭제
            $('#btnRemove').on('click', function () {
                this.removeAction();
            }.bind(this));

        },
        /* 프로그램 상세 이동 */
        this.goToDetail = function () {
            var _rid = this.getRid();
            qtjs.href('<ifvm:url name="offerGroupDetail"/>' + "?rid=" + _rid);
        },
        /* 공통 조회 조건 목록 설정 */
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("offerGroupSearchList", "OFFER_GROUP_LIST", "offerGroupList");
        },
        /* 삭제 액션 */
        this.removeAction = function () {
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
                    $.ifvPostJSON('<ifvm:action name="removeOfferGroup"/>', { rid: _rid }, _success.bind(this), _fail);
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
		var offerGroupGrid = new OfferGroupList();
		offerGroupGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="O00005" />
		&gt; <spring:message code="O00105" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="offerGroupListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="O00105" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="offerGroupListsearchCondInitBtn_OBJ">
				<spring:message code="O00106" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="offerGroupSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="O00108" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" />
			<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" />
		</div>
	</div>
	<div id="ofrgrpList" class="white_bg grid_bd0"></div>
</div>