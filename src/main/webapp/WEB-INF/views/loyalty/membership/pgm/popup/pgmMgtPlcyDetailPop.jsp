<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="pgmMgtPlcyPopValid">
	<div class="form-horizontal underline top_well">
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="mgtCate" names="mgtCate" dto="mgtCate" label="LO2683" labelClass="3" conClass="9" required="true" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="mgtCateSub" names="mgtCateSub" dto="mgtCateSub" label="L00155" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="mgtRange" names="mgtRange" dto="mgtRange" label="L02726" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="mgtCond" names="mgtCond" dto="mgtCond" label="L02727" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="val" label="L02462" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="mgtDate" names="mgtDate" dto="mgtDate" label="L02728" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="textarea" id="comments" dto="comments" rows="3" maxLength="150" label="설명" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="useYn" names="useYn" dto="useYn" label="사용여부" labelClass="3" conClass="9"/>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnMgtPlcySave" objCode="pgmMgtPlcyPoptBtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	
	var PgmMgtPlcyPop = function () {
	    var _rid = 	ifvGlobal["mgtPlcyRid"];
	    var _pgmRid = ifvGlobal["pgmRid"];
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
		var _formId = "pgmMgtPlcyPopValid";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId).ifvValidation(),
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
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = $.ifvGetFields(_formId),
        this.optionFields = [{ fieldName: "mgtCate", commCode: "LOY_MGT_CATE_CD"},
        	{ fieldName: "mgtCateSub", commCode: "LOY_MGT_CATE_SUB_CD", isFirstLowBlank: true, parField : "mgtCate"},
            { fieldName: "mgtRange", commCode: "LOY_MGT_RANGE_CD", isFirstLowBlank: true/* , parField :'mgtCateSub' */ },
            { fieldName: "mgtCond", commCode: "LOY_MGT_COND_CD", isFirstLowBlank: true },
            { fieldName: "useYn", commCode: "REQUIRED_YN", isFirstLowBlank: false },
            { fieldName: "mgtDate", commCode: "LOY_DATE_CD", isFirstLowBlank: true }],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                // 필드에 데이터 로드
                _loadedData = $.extend(true, {}, result);
				$.ifvLoadFormData(result, this.fields, this.optionFields);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getPgmMgtPlcyDetail"/>', {
                rid: this.getRid(),
                pgmRid: this.getPgmRid()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnMgtPlcySave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                this.popupClose();
            }.bind(this));
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

			/* submit을 위한 Form 데이터 파라미터 세팅 */
			var _setSubmitParams = function () {
				
				var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
				
				_updatedData = $.extend(true, {}, vObj);		


                vObj["pgmRid"] = this.getPgmRid();
				if (!this.isNew) {
					vObj['rid'] = this.getRid();
				}
				return vObj;
			}

            /* 제출 후 알럿창 및 화면 이동*/
            var _afterSubmit = function () {

                if (!this.isNew) {
                    // 변경 내역 계산 후 세팅
                    var chgCate = $("#mgtCate option:selected").html();
                    calculateChanges(_loadedData, _updatedData, [], "MGT", chgCate, this.optionFields, this.getPgmRid());
                }
                alert('<spring:message code="L00127"/>');
                // 팝업 창 닫고
                this.popupClose();
                // 리스트 리로드 => 수정
                ifvGlobal.pgmMgtPlcyGrid.setGridAndDataLoad();
            }

            var submitUrl = this.isNew ? '<ifvm:action name="addPgmMgtPlcy"/>' : '<ifvm:action name="editPgmMgtPlcy"/>';
            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm())
                this.onSubmit();
        }, 
        this.popupClose = function () {
        	$.fn.ifvmPopupClose();
        }, 
        this.setFieldDisabled = function () {
        	$("#mgtCate").prop('disabled', true);
        },
        this.init = function () {
            this.setButtons();
            if (!this.isNew) {
                this.formDataLoad();
                this.setFieldDisabled();
            } else {
                $.ifvSetSelectOptions(this.optionFields);
            }
        }
	}
	
	$(document).ready(function () {
	    var pgmMgtPlcyPop = new PgmMgtPlcyPop();
	    pgmMgtPlcyPop.init();
	});
</script>