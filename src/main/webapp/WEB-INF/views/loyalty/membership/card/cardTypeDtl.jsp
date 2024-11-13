<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
        <spring:message code="V00297" />
        &gt; <spring:message code="L00028" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01941" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="CardTypeDtlBtnSave_OBJ" />
			<ifvm:inputNew type="button" text="M00002" id="btnList" objCode="CardTypeDtlBtnList_OBJ"/>
	    </div>
	</div>
    <div id="cardTypeDetail">
        <div class="form-horizontal underline top_well">
            <div class="row">
                <!-- 카드 유형 번호 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="cardKindNo" label="M01942" labelClass="2" conClass="9" disabled="true"/>
                </div>
                <!-- 카드 유형명 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="cardKindNm" label="M01949" labelClass="2" conClass="9" required="true"/>
                </div>
            </div>
            <div class="row ">
                <!-- 카드 유형 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="cardType" names="cardType" label="M01943" labelClass="2" conClass="9" required="true"/>
                </div>
                <!-- 관련 채널 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="chnlNm" label="L02858" labelClass="2" conClass="9" disabled="true" />
                    <span class="input-group-addon" style="padding: 6px;" id="btnChnlPop"> <a><i class="fa fa-search"></i></a>
                    </span>
                    <ifvm:inputNew type="hidden" id="ridChnl" />
                </div>
            </div>
            <div class="row ">
                <!-- 제작 유형 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="makeType" names="makeType" label="M01945" labelClass="2" conClass="9" required="true"/>
                </div>
                <!-- 관련 클럽 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="clubNm" label="L02859" labelClass="2" conClass="9" disabled="true" />
                    <span class="input-group-addon" style="padding: 6px;" id="btnClubPop"> <a><i class="fa fa-search"></i></a>
                    </span>
                    <ifvm:inputNew type="hidden" id="ridClub" />
                </div>
            </div>
            <div class="row ">
                <!-- 채번 시작번호 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="number" id="binNoRule" label="L02860" labelClass="2" conClass="9" required="true"/>
                </div>
                <!-- 관련 등급 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="text" id="tierNm" label="L02857" labelClass="2" conClass="9" disabled="true" />
                    <span class="input-group-addon" style="padding: 6px;" id="btnTierPop"> <a><i class="fa fa-search"></i></a>
                    </span>
                    <ifvm:inputNew type="hidden" id="ridTier" />
                </div>
            </div>
        </div>
    </div>
</div>

<div id="tabArea"></div>
<div id="popupContainer" class="popup_container"></div>

<script>
var tierGrpRid = null;

	var CardTypeDetail = function (rid) {
	    // 스탬프/빙고 RID
	    var _rid = rid;
	    var _formId = 'cardTypeDetail';
	    this.setRid = function (rid) {
	        ifvGlobal["cardTypeRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
	        return _rid;
	    },
	    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
	    this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
	    // 유효성 검사 초기화
	    this.validation = $("#"+ _formId ).ifvValidation(),
	    this.fields = $.ifvGetFields(_formId),
	    this.optionFields = [
	        { fieldName: "cardType", commCode: "LOY_CARD_TYPE"},
	        { fieldName: "makeType", commCode: "LOY_CARD_MAKE_TYPE" }
	    ],
	    /* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields, this.optionFields);
	            }
	        }
	        $.ifvSyncPostJSON('<ifvm:action name="getCardTypeDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	    },
	    /* 탭 초기화 */
	    this.setTabs = function () {
	        $("#tabArea").empty();
	        $("#tabArea").DrawTab({
	            item: items
	            /* [{
	                label: '<spring:message code="M01940"/>',
	                href: '<ifvm:url name="cardTypeCardList"/>'
	            },{
                    label: '<spring:message code="M02959"/>',
                    href: '<ifvm:url name="cardTypeCardBinList"/>'
                },{
                   label: '<spring:message code="M02960"/>',
                   href: '<ifvm:url name="cardTypeCardNoPoolList"/>'
                }] */
	        });
	    },
	    /* 버튼 세팅 */
	    this.setButtons = function () {
	        $("#btnSave").click(function () {
	            this.saveAction();
	        }.bind(this));

	        $("#btnList").click(function () {
	            qtjs.href('<ifvm:url name="cardTypeList"/>');
	        });
            /* 채널 조회 팝업  */
            $('#btnChnlPop').on('click', function () {
                $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="chnlPop"/>', '<spring:message code="L02858"/>');
            });
            /* 클럽 조회 팝업  */
            $('#btnClubPop').on('click', function () {
                $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="clubListPop"/>', '<spring:message code="L02859"/>');
            });
            /* 등급 조회 팝업  */
            $('#btnTierPop').on('click', function () {
                $.fn.ifvmPopupOpen('popupContainer', null, '<ifvm:url name="tierPop"/>', '<spring:message code="L02857"/>');
            });
	    },
	    /* Form 데이터 제출 */
	    this.onSubmit = function () {

	        var _submitUrl = this.isNew ? '<ifvm:action name="setCardType"/>' : '<ifvm:action name="editCardType"/>';

	        /* submit을 위한 Form 데이터 파라미터 세팅 */
	        var _setSubmitParams = function () {
	            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
	            if (!this.isNew) vObj['rid'] = this.getRid();
	            return vObj;
	        }

	        /* 제출 후 알럿창 */
	        var _afterSubmit = function () {
	            alert('<spring:message code="L00127"/>');
	            if (this.isNew)  {
	                qtjs.href('<ifvm:url name="cardTypeList"/>');
	            }
	        };
	        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
	    },
	    /* 저장 버튼클릭 시 확인 */
	    this.saveAction = function () {
            // 채번 숫자 8자리 이하로 입력 체크
            var _binNoCheck = function() {
                var binNo = $("#binNoRule").val();
                if (binNo.length >= 8) {
                    alert('<spring:message code="L02881"/>');
                    return false;
                }
                return true;
            };

	        if (this.validation.confirm() && _binNoCheck()) this.onSubmit();
	    },
        this.setFieldRequired = function() {
            // "제휴 카드" 이외 필수값 체크
            $("#cardType").bind('change', function() {
                var cardTypeCode = $(this).val();
                var binNoField = $("#binNoRule");
                if (cardTypeCode === "C") {
                    binNoField.attr("required", false);
                    binNoField.closest("div").prev()[0].children[0].remove();
                } else {
                    binNoField.attr("required", true);
                    binNoField.closest("div").prev().replaceWith('<label class="control-label col-xs-2"><span class="asterisk">*</span>채번시작번호</label>');
                }
            });
            $('#cardType').trigger('change');
        },
	    /* 페이지 초기화 */
	    this.init = function () {

	        if (!this.isNew) {
	            this.formDataLoad();
	            this.setTabs();
	        } else {
	            $.ifvSetSelectOptions(this.optionFields);
	        }
	        this.setButtons();
	        this.setFieldRequired();
	    }
	}

	$(document).ready(function () {
	    var urlParams = $.ifvGetParams();
	    var _rid = urlParams.rid;
    	ifvGlobal["cardTypeRid"] = _rid;
	    var cardTypeGrid = new CardTypeDetail(_rid);
	    cardTypeGrid.init();
	});

</script>
