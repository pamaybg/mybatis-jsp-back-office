<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="custBnftPopValid">
	<div class="form-horizontal underline top_well">
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="ofrNm" label="M00314" labelClass="3" conClass="8" disabled="true" required="true"/>
                <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop"> <a><i class="fa fa-search"></i></a></span>
                <ifvm:inputNew type="hidden" id="ridOfr"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="date" id="startDate" label="O00017" labelClass="3" conClass="4" required="true"/>
                <div style="float: left">~</div>
                <ifvm:inputNew type="date" id="endDate" conClass="4" required="true"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="number" id="qty" label="L02824" labelClass="3" conClass="9" required="true"/>
            </div>
        </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnCustBnftSave" objCode="custBnftPoptBtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="custBnftPoptBtnCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<div id="offerPopupContainer" class="popup_container"></div>

<script type="text/javascript">

	var CustBnftPop = function () {
	    var _rid = 	ifvGlobal["custBnftRid"];
	    var _ridMbrC = $.ifvGetParams().rid;
		var _formId = "custBnftPopValid";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId ).ifvValidation(),
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
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = $.ifvGetFields(_formId),
        /* Form 데이터 로드 */
        this.formDataLoad = function () {

            var _callback = function (result) {
				$.ifvLoadFormData(result, this.fields, null, _formId);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getCustBnftDetail"/>', {
                rid: this.getRid(),
                ridMbrC: this.getRidMbrC()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnCustBnftSave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                $.fn.ifvmPopupClose();
            }.bind(this));

            /* 오퍼 조회 팝업 */
            $('#btnOfrPop').on('click', function () {
                var targetFields = { name : "ofrNm", rid : "ridOfr"};
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');
            });
        },
        /* 캘린더 세팅 */
        this.setCalendar = function() {
            var startDate = $("#startDate");
            var endDate = $("#endDate");

            startDate.ifvDateChecker({
                maxDate : startDate
            });
            endDate.ifvDateChecker({
                minDate : endDate
            });
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = this.isNew ? '<ifvm:action name="addCustBnft"/>' : '<ifvm:action name="editCustBnft"/>';

			/* submit을 위한 Form 데이터 파라미터 세팅 */
			var _setSubmitParams = function () {

				var vObj = $.ifvGetFieldData(this.fields, null, _formId);

                vObj["ridMbrC"] = this.getRidMbrC();

				if (!this.isNew) {
					vObj['rid'] = this.getRid();
				}

				return vObj;
			}

            /* 제출 후 알럿창 및 화면 이동*/
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
                // 팝업 창 닫고
                $.fn.ifvmPopupClose();
                // 리스트 리로드
                ifvGlobal.custBnftGrid.setGridAndDataLoad();
            };

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) this.onSubmit();
        },
        this.init = function () {
            this.setButtons();
            this.setCalendar();
            if (!this.isNew) {
                this.formDataLoad();
            }
        }
	}

	$(document).ready(function () {
		var custBnftPop = new CustBnftPop();
		custBnftPop.init();
	});
</script>