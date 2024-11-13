<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var PgmFmlyPlcyDetail = function () {
	    var _rid = null;
		var _pgmRid = ifvGlobal["pgmRid"];
	    
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
	    var _formId = "pgmFmlyPlcyValid";

	    this.setRid = function (rid) {
	    	ifvGlobal["fmlyPlcyRid"] = rid;
	        _rid = rid;
	    },
        this.getRid = function () {
            return _rid;
        },
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.isNew = false,
		this.validation = $("#" + _formId).ifvValidation(),
        this.fields = $.ifvGetFields(_formId),
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    // 일단 조회해 본 후 결과가 있다면 rid 세팅
                    this.setRid(result.rid);
                    this.isNew = $.fn.ifvmIsNotEmpty(this.getRid()) ? false : true;

					// 필드의 데이터 로드
					_loadedData = $.extend(true, {}, result);
					
					$.ifvLoadFormData(result, this.fields);

                } else {
                    this.isNew = true;
                    // 필드 데이터 초기화
                    $.ifvInitFields(this.fields);
                }
            };

            $.ifvSyncPostJSON('<ifvm:action name="getPgmFmlyPlcyDetail"/>', { pgmRid: this.getPgmRid() }, _callback.bind(this));
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddFmlyPlcy").click(function () {
                this.saveAction();
            }.bind(this));

            $("#btnRemoveFmlyPlcy").click(function () {
                this.removeAction();
            }.bind(this));
        },
        /* 삭제 액션 */
        this.removeAction = function () {
            var _success = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.formDataLoad();
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="L00086"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removePgmFmlyPlcy"/>', { rid: this.getRid(), pgmRid: this.getPgmRid() }, _success.bind(this), _fail.bind(this));
                    this.isNew = true;
                }
            }
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {
            	var vObj = {};

            	// 필드 데이터 가져오기
				var vObj = $.ifvGetFieldData(this.fields);
				
				_updatedData = $.extend(true, {}, vObj);

                vObj["pgmRid"] = this.getPgmRid();
                				
                if (!this.isNew) {
                    vObj['rid'] = this.getRid();
                }
                return vObj;
            }

            /* 제출 후 알럿창 */
            var _afterSubmit = function () {
                // 변경 내역 계산 후 세팅
                if (!this.isNew) calculateChanges(_loadedData, _updatedData, [], "FML", "", [], this.getPgmRid());
                alert('<spring:message code="L00127"/>');
                this.formDataLoad();
            }
            var submitUrl = (this.isNew) ? '<ifvm:action name="addPgmFmlyPlcy"/>' : '<ifvm:action name="editPgmFmlyPlcy"/>';

            $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {

            var _beforeSubmit = function () {
                var isValidFmlyNum = $('#minNum').val() >= 2 && $('#maxNum').val() >= 2;
                if (!isValidFmlyNum) alert('<spring:message code="L02856"/>');
                return isValidFmlyNum;
            }

            if (this.validation.confirm() && _beforeSubmit()) this.onSubmit();
        },
        this.init = function () {
            this.setButtons();
            this.formDataLoad();
        }
	};
	
	$(document).ready(function () {
		var pgmFmlyPlcyGrid = new PgmFmlyPlcyDetail();
		pgmFmlyPlcyGrid.init();
	});
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02719" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnAddFmlyPlcy" objCode="btnAddFmlyPlcy_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemoveFmlyPlcy" objCode="btnRemoveFmlyPlcy_OBJ"/>
	</div>
</div>
<div id="pgmFmlyPlcyValid">
	<div class="half_wrap top_well">
		<div class="half_content half_left">
			<div class="page_btn_area">
				<div class="col-xs-7">
					<span> <spring:message code="L02717" /></span>
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="number" id="minNum" label="L02735" minNum="2" labelClass="3" conClass="3" required="true" placeholder="L02739" />
					<div style="float: left">~</div>
					<ifvm:inputNew type="number" id="maxNum" conClass="3" minNum="2" required="true" placeholder="L02740"/>
				</div>
				<div class="row">
					<ifvm:inputNew type="number" id="recrDelayNum" label="L02736" labelClass="3" conClass="3" required="true" />(월)
				</div>
			</div>
		</div>
		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-7">
					<span> <spring:message code="L02722" /></span>
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="checkBox" id="pntShareYn" label="L02737" labelClass="4" conClass="2" required="true" />
					<ifvm:inputNew type="checkBox" id="tierShareYn" label="L02738" labelClass="4" conClass="2" required="true" />
				</div>
			</div>
		</div>
	</div>
</div>
