<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02843" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddCustBranch" />
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveCustBranch" />
	</div>
</div>
<div id="custBranchGrid"></div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
	var CustBranchList = function () {
	    var _rid = null;
	    var _ridMbrC = $.ifvGetParams().rid;
	    this.dataUrl = '<ifvm:action name="getCustBranchList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["custBranchRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidMbrC = function () {
            return _ridMbrC;
        },
        this.setGridAndDataLoad = function (url) {
            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.openPopup();
            };
            var _serializeGridData = function (data) {
                data.ridMbrC = this.getRidMbrC();
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
                dataUrl: url || this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'brNo',
                    headerText: '<spring:message code="L02844"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'brNm',
                    headerText: '<spring:message code="L02845"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'chnlNo',
                    headerText: '<spring:message code="L02846"/>',
                    textAlign : 'center',

                }, {
                    field: 'chnlNm',
                    headerText: '<spring:message code="L02847"/>',
                    textAlign : 'left',
                }, {
                    field: 'charger',
                    headerText: '<spring:message code="L00618"/>',
                    textAlign : 'left',
                }, {
                   field: 'telNo',
                   headerText: '<spring:message code="L02848"/>',
                   textAlign : 'left',
               }, {
                    field: 'createDate',
                    headerText: '<spring:message code="L01125"/>',
                    textAlign : 'center'
                }],
                requestGridData: {
                    sidx: 'createDate'
                },
                radio: true,
            };
            $("#custBranchGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="custBranchPop"/>',
                '<spring:message code="L02843"/>', 860);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddCustBranch").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

            $("#btnRemoveCustBranch").click(function () {
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
                    $.ifvPostJSON('<ifvm:action name="removeCustBranch"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		custBranchGrid = new CustBranchList();
		ifvGlobal['custBranchGrid'] = custBranchGrid;
		custBranchGrid.init();
	});
</script>