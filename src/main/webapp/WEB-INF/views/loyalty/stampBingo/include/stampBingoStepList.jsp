<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02811" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddStampBingoStep" objCode="stampBingoStepListAdd_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveStampBingoStep" objCode="stampBingoStepListRemove_OBJ"/>
		<ifvm:inputNew type="button" text="L02861" id="btnPreview" objCode="stampBingoStepListPreview_OBJ"/>
	</div>
</div>
<div id="stampBingoStepGrid"></div>

<script type="text/javascript">
	var StampBingoStepList = function () {
	    var _rid = null;
	    var _ridStbg = ifvGlobal["stampBingoRid"];
	    this.dataUrl = '<ifvm:action name="getStampBingoStepList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["stampBingoStepRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidStbg = function () {
            return _ridStbg;
        },
        this.setGridAndDataLoad = function (url) {
            var _recordDoubleClick = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                $.fn.ifvmPopupOpen('popupContainer', this.getRid(), '<ifvm:url name="stampBingoStepDetailPop"/>', '<spring:message code="L02825"/>', 860);
            };
            var _serializeGridData = function (data) {
                data.ridStbg = this.getRidStbg();
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
                    field: 'rowNo',
                    width: '50px',
                    headerText: '<spring:message code="L02821"/>',
                    textAlign : 'center'
                }, {
                    field: 'colNo',
                    width: '50px',
                    headerText: '<spring:message code="L02822"/>',
                    textAlign : 'center'
                }, {
                    field: 'title',
                    headerText: '<spring:message code="L01431"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'titleDesc',
                    headerText: '<spring:message code="L02823"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="L02813"/>',
                    textAlign : 'left'
                }, {
                    field: 'ofrCnt',
                    headerText: '<spring:message code="L02824"/>',
                    textAlign : 'center'
                }, {
                    field: 'createBy',
                    headerText: '<spring:message code="L01078"/>',
                    textAlign : 'center'
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
            $("#stampBingoStepGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddStampBingoStep").click(function () {
                this.setRid(null);
                $.fn.ifvmPopupOpen('popupContainer', this.getRid(), '<ifvm:url name="stampBingoStepDetailPop"/>', '<spring:message code="L02825"/>', 860);
            }.bind(this));

            $("#btnRemoveStampBingoStep").click(function () {
                this.removeAction();
            }.bind(this));

            // btnPreview
            $("#btnPreview").click(function () {
                $.fn.ifvmPopupOpen('popupContainer', this.getRid(), '<ifvm:url name="stampBingoStepPreviewPop"/>', '<spring:message code="L02861"/>', 640);
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
                    $.ifvPostJSON('<ifvm:action name="removeStampBingoStep"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		stampBingoStepGrid = new StampBingoStepList();
		ifvGlobal['stampBingoStepGrid'] = stampBingoStepGrid;
		stampBingoStepGrid.init();
	});
</script>