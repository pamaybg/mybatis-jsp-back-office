<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="childOfferPop">
	<div class="form-horizontal underline top_well">
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="ofrNm" dto="ofrNm" label="O00014" labelClass="3" conClass="8" disabled="true" />
				<span class="input-group-addon" style="padding: 6px;" id="btnOfrPop"> <a><i class="fa fa-search"></i></a></span>
				<ifvm:inputNew type="hidden" id="ridOfr" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="minAmt" label="O00073" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="maxAmt" label="O00074" labelClass="3" conClass="9" />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="clickAmt" label="O00075" labelClass="3" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="checkBox" id="reqYn" label="O00072" labelClass="3" conClass="2" />
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnChildOfferSave" objCode="offerGroupChildSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnChildOfferCancel">
		<spring:message code="M00441" />
	</button>
</div>
<div id="offerPopupContainer" class="popup_container"></div>

<script type="text/javascript">

var ChildOfferPop = function () {
    var _rid = 	ifvGlobal["childOfferRid"];
    var _offerGroupRid = ifvGlobal["offerGroupRid"];
	var _formId = "childOfferPop";

    // 유효성 검사 초기화
    this.validation = $("#childOfferPop").ifvValidation(),
    this.setRid = function (rid) {
    	ifvGlobal["childOfferRid"] = rid;
        _rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.getOfferGroupRid = function () {
    	return _offerGroupRid;
    },
    this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    this.priceFields = ["minAmt", "maxAmt", "clickAmt"],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {

        var _callback = function (result) {
            // 필드에 데이터 로드
			$.ifvLoadFormData(result, this.fields);
			this.priceFields.forEach(function(vf) { 
				var vfVal = $('#' + vf).val();						
				$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
				$('#' + vf).css("text-align", "right");
			});
        };

        $.ifvSyncPostJSON('<ifvm:action name="getChildOfferDetail"/>', {
            rid: this.getRid(),
            ridOfrgrp: this.getOfferGroupRid()
        }, _callback.bind(this));
    },
    /* 버튼 세팅 */
    this.setButtons = function () {
        $("#btnChildOfferSave").click(function () {
            this.saveAction();
        }.bind(this));

        $("#btnChildOfferCancel").click(function () {
			$.fn.ifvmPopupClose();
        }.bind(this));
        
		/* 오퍼 그룹 조회 팝업 */
		$('#btnOfrPop').on('click', function () {
		    var targetFields = { name : "ofrNm", rid: "ridOfr"};
			$.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopupContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="O00014"/>');
		});

    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {

        var submitUrl = this.isNew ? '<ifvm:action name="addChildOffer"/>' : '<ifvm:action name="editChildOffer"/>';
        
		/* submit을 위한 Form 데이터 파라미터 세팅 */
		var _setSubmitParams = function () {

			var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

            vObj["ridOfrgrp"] = _offerGroupRid;
			
			if (!this.isNew) vObj['rid'] = this.getRid();

			this.priceFields.forEach(function(vf) { 
				vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
			});
			
			return vObj;
		}
		
        /* 제출 후 알럿창 및 화면 이동*/
        var _afterSubmit = function () {
            alert('<spring:message code="L00127"/>');
            // 팝업 창 닫고
           	$.fn.ifvmPopupClose();
            ifvGlobal.childOfferGrid.setGridAndDataLoad();
        };

        $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
        if (this.validation.confirm()) this.onSubmit();
    },
    this.setCommaKeyup = function () {
		this.priceFields.forEach(function(vf) {
			$('#' + vf).keyup(function() {
				var vfVal = $('#' + vf).val();						
				$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
				$('#' + vf).css("text-align", "right");
			});
		})
    },
    this.init = function () {
        this.setButtons();

        this.setCommaKeyup();
        if (!this.isNew) {
            this.formDataLoad();
        }
    }
}

$(document).ready(function () {
	var childOfferPop = new ChildOfferPop();

	childOfferPop.init();
});
</script>