<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="stampBingoBenfPopValid">
	<div class="form-horizontal underline top_well">
		<div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="select" id="bnfTypeCd" names="bnfTypeCd" label="L02203" labelClass="3" conClass="8" required="true"/>
            </div>
			<div class="col-xs-6">
                <ifvm:inputNew type="text" id="title" label="L01431" labelClass="3" conClass="8" required="true"/>
			</div>
		</div>
        <div class="row">
            <div class="col-xs-6">
                <ifvm:inputNew type="text" id="ofrNm" label="L02818" labelClass="3" conClass="8" disabled="true"/>
                <span class="input-group-addon" style="padding: 6px;" id="btnOfrPop"> <a><i class="fa fa-search"></i></a></span>
                <ifvm:inputNew type="hidden" id="ridOfr"/>
            </div>
        </div>
        <div class="row">
           <div class="col-xs-6">
                <ifvm:inputNew type="number" id="ofrCnt" label="L02819" labelClass="3" conClass="9" />
           </div>
           <div class="col-xs-6">
                <ifvm:inputNew type="number" id="validStDd" label="L02820" labelClass="3" conClass="9"/>
           </div>
        </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnStampBingoBenfSave" objCode="stampBingoBenfPoptBtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="stampBingoBenfPoptBtnCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<div id="offerPopupContainer" class="popup_container"></div>

<script type="text/javascript">

	var StampBingoBenfPop = function () {
	    var _rid = 	ifvGlobal["stampBingoBenfRid"];
	    var _ridStbg = ifvGlobal["stampBingoRid"];
		var _formId = "stampBingoBenfPopValid";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId ).ifvValidation(),
        this.setRid = function (rid) {
	    	ifvGlobal["stampBingoBenfRid"] = rid;
            _rid = rid;
        },
        this.getRid = function () {
            return _rid;
        },
        this.getRidStbg = function () {
            return _ridStbg;
        },
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = $.ifvGetFields(_formId),
	    this.optionFields = [
	        { fieldName: "bnfTypeCd", commCode: "LOY_BINGO_BNFT_TYPE"}
	    ],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {

            var _callback = function (result) {
				$.ifvLoadFormData(result, this.fields, this.optionFields);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getStampBingoBenfDetail"/>', {
                rid: this.getRid(),
                ridStbg: this.getRidStbg()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnStampBingoBenfSave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                $.fn.ifvmPopupClose();
            }.bind(this));

            /* 오퍼 조회 팝업 */
            $('#btnOfrPop').on('click', function () {
                var targetFields = { name : "ofrNm", rid : "ridOfr" };
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopupContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');
            });
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = this.isNew ? '<ifvm:action name="addStampBingoBenf"/>' : '<ifvm:action name="editStampBingoBenf"/>';

			/* submit을 위한 Form 데이터 파라미터 세팅 */
			var _setSubmitParams = function () {

				var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

                vObj["ridStbg"] = this.getRidStbg();

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
                ifvGlobal.stampBingoBenfGrid.setGridAndDataLoad();
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
            } else {
                $.ifvSetSelectOptions(this.optionFields);
            }
        }
	}

	$(document).ready(function () {
		var stampBingoBenfPop = new StampBingoBenfPop();

		stampBingoBenfPop.init();
	});
</script>