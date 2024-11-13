<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="pgmJoinPlcyPopValid">
	<div class="form-horizontal underline top_well">
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="joinCate" names="joinCate" dto="joinCate" label="L02461" labelClass="3" conClass="9" required="true" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="joinRange" names="joinRange" dto="joinRange" label="L02726" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="joinCond" names="joinCond" dto="joinCond" label="L02727" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="val" label="L02462" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="joinDate" names="joinDate" dto="joinDate" label="L02728" labelClass="3" conClass="9" />
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnJoinPlcySave" objCode="pgmJoinPlcyPoptBtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="pgmJoinPlcyPoptBtnCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	
	var PgmJoinPlcyPop = function () {
	    var _rid = 	ifvGlobal["joinPlcyRid"];
	    var _pgmRid = ifvGlobal["pgmRid"];
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
		var _formId = "pgmJoinPlcyPopValid";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId ).ifvValidation(),
        this.setRid = function (rid) {
	    	ifvGlobal["joinPlcyRid"] = rid;
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
        this.optionFields = [{ fieldName: "joinCate", commCode: "LOY_JOIN_CATE_CD", parField: "pgmType" },
                            { fieldName: "joinRange", commCode: "LOY_MGT_RANGE_CD", isFirstLowBlank: true },
                            { fieldName: "joinCond", commCode: "LOY_MGT_COND_CD", isFirstLowBlank: true },
                            { fieldName: "joinDate", commCode: "LOY_DATE_CD", isFirstLowBlank: true }],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                // 필드에 데이터 로드
                _loadedData = $.extend(true, {}, result);
				$.ifvLoadFormData(result, this.fields, this.optionFields);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getPgmJoinPlcyDetail"/>', {
                rid: this.getRid(),
                pgmRid: this.getPgmRid()
            }, _callback.bind(this));
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnJoinPlcySave").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnCancel").click(function () {
                this.popupClose();
            }.bind(this));
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            var submitUrl = this.isNew ? '<ifvm:action name="addPgmJoinPlcy"/>' : '<ifvm:action name="editPgmJoinPlcy"/>';
            
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

                if(!this.isNew) {
                    var chgCate =$("#joinCate option:selected").html();
                    calculateChanges(_loadedData, _updatedData, [], "JOIN", chgCate, this.optionFields, this.getPgmRid());
                }
                alert('<spring:message code="L00127"/>');
                // 팝업 창 닫고
                this.popupClose();
                // 리스트 리로드 => 수정
                ifvGlobal.pgmJoinPlcyGrid.setGridAndDataLoad();
            };

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) this.onSubmit();
        },
        this.popupClose = function () {
        	$.fn.ifvmPopupClose();
        },
        this.setFieldDisabled = function () {
        	$("#joinCate").prop('disabled', true);
        },
        this.init = function () {
            this.setButtons();
            if (!this.isNew) {
            	this.setFieldDisabled();
                this.formDataLoad();
            } else {
                $.ifvSetSelectOptions(this.optionFields);
            }
        }
	}
	
	$(document).ready(function () {
		var pgmJoinPlcyPop = new PgmJoinPlcyPop();
	
		pgmJoinPlcyPop.init();
	});
</script>