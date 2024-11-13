<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02720" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddMgtPlcy" objCode="btnAddMgtPlcy_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveMgtPlcy" objCode="btnRemoveMgtPlcy_OBJ"/>
	</div>
</div>
<div id="mgtPlcyGrid"></div>

<script type="text/javascript">
	var PgmMgtPlcyList = function () {
	    var _rid = null;
	    var _pgmRid = ifvGlobal["pgmRid"];
	    this.setRid = function (rid) {
	    	ifvGlobal["mgtPlcyRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.setGridAndDataLoad = function () {
            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.openPopup();
            };
            var _serializeGridData = function (data) {
                data.pgmRid = this.getPgmRid();
                return data;
            };
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
            };

            var ejGridOption = {
                recordDoubleClick: _recordDoubleClick.bind(this),
                serializeGridData: _serializeGridData.bind(this),
                rowSelected: _rowSelected.bind(this),
                dataUrl: '<ifvm:action name="getPgmMgtPlcyList"/>',
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'mgtCateNm',
                    headerText: '<spring:message code="LO2683"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'mgtCate'
                    }
                }, {
                    field: 'mgtCateSubNm',
                    headerText: '<spring:message code="L00155"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'mgtCateSub'
                    }
                },
                {
                    field: 'mgtRangeNm',
                    headerText: '<spring:message code="L02726"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'mgtRange'
                    }
                }, {
                    field: 'mgtCondNm',
                    headerText: '<spring:message code="L02727"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'mgtCond'
                    }
                }, {
                    field: 'val',
                    headerText: '<spring:message code="L02462"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'mgtDateNm',
                    headerText: '<spring:message code="L02728"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'mgtDate'
                    }
                }, {
                    field: 'comments',
                    headerText: '<spring:message code="L00340"/>',
                    width: '250px',
                    customAttributes: {
                        sortable: false
                    }
                }, {
                    field: 'useYn',
                    headerText: '<spring:message code="사용여부"/>',
                    textAlign : 'center',
                    customAttributes: {
                        index: 'useYnCd'
                    }
                }, {
                    field: 'modifyBy',
                    headerText: '<spring:message code="L01042"/>',
                    textAlign : 'center',
                }, {
                    field: 'modifyDate',
                    headerText: '<spring:message code="L02703"/>',
                    textAlign : 'center',
                }],
                requestGridData: {
                    sidx: 'modifyDate'
                },
                radio: true,
            };

            $("#mgtPlcyGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="pgmMgtPlcyDetailPop"/>',
                '<spring:message code="L02776"/>', 860);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddMgtPlcy").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

            $("#btnRemoveMgtPlcy").click(function () {
                this.removeAction();
            }.bind(this));
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

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removePgmMgtPlcy"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};
	
	$(document).ready(function () {
		var pgmMgtPlcyGrid = new PgmMgtPlcyList();
		ifvGlobal['pgmMgtPlcyGrid'] = pgmMgtPlcyGrid;
		pgmMgtPlcyGrid.init();
	});
</script>