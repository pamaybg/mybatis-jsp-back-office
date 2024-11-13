<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00599" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAddCustBnft" />
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveCustBnft" />
	</div>
</div>
<div id="custBnftGrid"></div>
<div id="custSettleValid">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span>
                <spring:message code="M02827" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnType="check" text="L00125" id="btnAddPntPlcy" />
            <ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemovePntPlcy" />
        </div>
    </div>
    <div class="row">
        <ifvm:inputNew type="select" id="stlCycleCd" names="stlCycleCd" label="L02850" labelClass="2"
            conClass="3" required="true" />
        <ifvm:inputNew type="select" id="shaChnlCd" names="shaChnlCd" label="L02852" labelClass="2"
            conClass="3" required="true" />
    </div>
    <div class="row">
        <ifvm:inputNew type="number" id="chnlShaRate" label="L02851" labelClass="2" conClass="2" required="true" /> %
    </div>
</div>
<div id="popupContainer" class="popup_container"></div>
<script type="text/javascript">
	var CustBnftList = function () {
	    var _rid = null;
	    var _ridMbrC = $.ifvGetParams().rid;
	    this.dataUrl = '<ifvm:action name="getCustBnftList"/>';
	    this.setRid = function (rid) {
		    ifvGlobal["custBnftRid"] = rid;
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
                dataUrl: this.dataUrl,
                columns: [{
                    field: 'rid',
                    visible: false
                }, {
                    field: 'ofrNo',
                    headerText: '<spring:message code="M00313"/>',
                    textAlign : 'center',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'ofrNm',
                    headerText: '<spring:message code="M00314"/>',
                    textAlign : 'left',
                    customAttributes: {
                        searchable: true
                    }
                }, {
                    field: 'startDate',
                    headerText: '<spring:message code="L01096"/>',
                    textAlign : 'center',

                }, {
                    field: 'endDate',
                    headerText: '<spring:message code="L01097"/>',
                    textAlign : 'center',
                }, {
                    field: 'qty',
                    headerText: '<spring:message code="L02824"/>',
                    textAlign : 'right',
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
            $("#custBnftGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="custBnftPop"/>',
                '<spring:message code="M00599"/>', 860);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddCustBnft").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

            $("#btnRemoveCustBnft").click(function () {
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
                    $.ifvPostJSON('<ifvm:action name="removeCustBnft"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};


    var CustSettleDetail = function () {

	    var _rid = null;
	    var _ridMbrC = $.ifvGetParams().rid;
	    var _formId = "custSettleValid";
	    this.setRid = function (rid) {
		    ifvGlobal["custBnftRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getRidMbrC = function () {
            return _ridMbrC;
        },
        this.isNew = false,
        this.validation = $("#" + _formId).ifvValidation(),
        this.fields = $.ifvGetFields(_formId),
        this.optionFields = [
            { fieldName: "stlCycleCd", commCode: "LOY_SETTLE_CYCLE_CD" },
            { fieldName: "shaChnlCd", commCode: "LOY_SETTLE_SHR_CHNL_CD" },
        ],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    // 일단 조회해 본 후 결과가 있다면 rid 세팅
                    this.setRid(result.rid);
                    this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;
                    $.ifvLoadFormData(result, this.fields, this.optionFields);

                } else {
                    this.isNew = true;
                    $.ifvInitFields(this.fields, this.optionFields);
                }
            };
            $.ifvSyncPostJSON('<ifvm:action name="getCustSettleDetail"/>', { ridMbrC: this.getRidMbrC() }, _callback.bind(this));
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddPntPlcy").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnRemovePntPlcy").click(function () {
                this.removeAction();
            }.bind(this));
        },
        /* 삭제 액션 */
        this.removeAction = function () {

            var _success = function (result) {
                $.ifvProgressControl(false);
                alert('<spring:message code="L00085"/>');
                $.ifvInitFields(this.fields, this.optionFields);
            };

            var _fail = function (result) {
                alert(result.message);
                $.ifvProgressControl(false);
            };

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeCustSettle"/>', { rid: this.getRid(), ridMbrC: this.getRidMbrC() }, _success.bind(this), _fail.bind(this));
                }
            }
        }
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {

                var vObj = {};

                // 필드 데이터 가져오기
                var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

                vObj["ridMbrC"] = this.getRidMbrC();

                if (!this.isNew) {
                    vObj['rid'] = this.getRid();
                }
                return vObj;
            }

            /* 제출 후 알럿창 */
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
            }

            var submitUrl = (this.isNew) ? '<ifvm:action name="addCustSettle"/>' : '<ifvm:action name="editCustSettle"/>';
            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit);
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) this.onSubmit();
        },
        this.init = function () {
            this.setButtons();
            this.formDataLoad();
        }
    };


	$(document).ready(function () {
		var custBnftGrid = new CustBnftList();
		ifvGlobal['custBnftGrid'] = custBnftGrid;
		custBnftGrid.init();

       var custSettleDetail = new CustSettleDetail();
       custSettleDetail.init();
	});
</script>