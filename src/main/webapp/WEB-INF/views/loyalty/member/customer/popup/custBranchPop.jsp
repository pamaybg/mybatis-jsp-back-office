<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="custBranchPopValid">
	<div class="form-horizontal underline top_well">
		<div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="brNo" label="L02844" labelClass="3" conClass="9" required="true"/>
            </div>
			<div class="col-xs-6">
                <ifvm:inputNew type="text" id="brNm" label="L02845" labelClass="3" conClass="9" required="true"/>
			</div>
		</div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="charger" label="L00618" labelClass="3" conClass="9" required="true"/>
            </div>
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="telNo" label="L02848" labelClass="3" conClass="9" required="true"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="chnlNm" label="L02849" labelClass="3" conClass="8" disabled="true" required="true"/>
                <span class="input-group-addon" style="padding: 6px;" id="btnChnlPop"> <a><i class="fa fa-search"></i></a></span>
                <ifvm:inputNew type="hidden" id="ridChnl"/>
            </div>
        </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnCustBranchSave" objCode="custBranchPoptBtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="custBranchPoptBtnCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<div id="channelPopupContainer" class="popup_container"></div>

<script type="text/javascript">

	var CustBranchPop = function () {
	    var _rid = 	ifvGlobal["custBranchRid"];
	    var _ridMbrC = $.ifvGetParams().rid;
		var _formId = "custBranchPopValid";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId ).ifvValidation(),
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
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = $.ifvGetFields(_formId),
        /* Form 데이터 로드 */
        this.formDataLoad = function () {

            var _callback = function (result) {
				$.ifvLoadFormData(result, this.fields, null, _formId);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getCustBranchDetail"/>', {
                rid: this.getRid(),
                ridMbrC: this.getRidMbrC()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnCustBranchSave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                $.fn.ifvmPopupClose();
            }.bind(this));

            /* 채널 조회 팝업 */
            $('#btnChnlPop').on('click', function () {
                $.fn.ifvmPopupOpen('channelPopupContainer', null,
                    '<ifvm:url name="chnlPop"/>',
                    '<spring:message code="L00648"/>', 860);
            });
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = this.isNew ? '<ifvm:action name="addCustBranch"/>' : '<ifvm:action name="editCustBranch"/>';

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
                ifvGlobal.custBranchGrid.setGridAndDataLoad();
            };

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) this.onSubmit();
        },
        this.init = function () {
            this.setButtons();
            if (!this.isNew) {
                this.formDataLoad();
            }
        }
	}

	$(document).ready(function () {
		var custBranchPop = new CustBranchPop();

		custBranchPop.init();
	});
</script>