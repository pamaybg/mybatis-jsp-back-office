<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var StampBingoDetail = function (rid) {
	    // 스탬프/빙고 RID
	    var _rid = rid;
	    var _formId = 'stampBingoDetail';
	    this.setRid = function (rid) {
	        ifvGlobal["stampBingoRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
	        return _rid;
	    },
	    this.setStampBingoSize = function() {
	        var stampBingoSize = {};
	        var row = $("#rowSize").val();
	        var col = $("#colSize").val();
	        stampBingoSize["row"] = row;
	        stampBingoSize["col"] = col;
	        ifvGlobal['stampBingoSize'] = stampBingoSize;
	    },
	    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
	    this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
	    // 유효성 검사 초기화
	    this.validation = $("#"+ _formId ).ifvValidation(),
	    this.fields = $.ifvGetFields(_formId),
	    this.optionFields = [
	        { fieldName: "statCd", commCode: "LOY_STMP_STAT_TYPE"},
	        { fieldName: "promTypeCd", commCode: "LOY_STMP_PROM_TYPE" },
	        { fieldName: "joinTypeCd", commCode: "LOY_STMP_JOIN_TYPE" },
	        { fieldName: "chnlTypeCd", commCode: "LOY_STMP_CHNL_TYPE" },
	        { fieldName: "mbrType", commCode: "LOY_STMP_MBR_TYPE" },
	    ],
	    /* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields, this.optionFields);
	                this.setStampBingoSize();
	            }
	        }
	        $.ifvSyncPostJSON('<ifvm:action name="getStampBingoDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	    },
	    /* 탭 초기화 */
	    this.setTabs = function () {
	        $("#tabArea").empty();
	        $("#tabArea").DrawTab({
	            item: items
	           /*  [{
	                label: '<spring:message code="L02811"/>',
	                href: '<ifvm:url name="stampBingoStepList"/>'
	            },{
                    label: '<spring:message code="L02651"/>',
                    href: '<ifvm:url name="stampBingoMbrList"/>'
                },{
                   label: '<spring:message code="L02837"/>',
                   href: '<ifvm:url name="stampBingoChnlList"/>'
                },{
                   label: '<spring:message code="L02839"/>',
                   href: '<ifvm:url name="stampBingoBenfList"/>'
                 }] */
	        });
	    },
	    /* 버튼 세팅 */
	    this.setButtons = function () {
	        $("#btnSave").click(function () {
	            this.saveAction();
	        }.bind(this));

	        $("#btnList").click(function () {
	            qtjs.href('<ifvm:url name="stampBingoList"/>');
	        });
	    },
	    /* 메뉴 세팅 */
	    this.setMenu = function () {
	        $.ifvmLnbSetting('stampBingoList');
	    },
	    /* Form 데이터 제출 */
	    this.onSubmit = function () {

	        var _submitUrl = this.isNew ? '<ifvm:action name="addStampBingo"/>' : '<ifvm:action name="editStampBingo"/>';

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
	                qtjs.href('<ifvm:url name="stampBingoList"/>');
	            }
	            this.setStampBingoSize();
	        };
	        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
	    },
	    /* 저장 버튼클릭 시 확인 */
	    this.saveAction = function () {
	        if (this.validation.confirm()) this.onSubmit();
	    },
	    this.setCalendar = function(){
	    	var validStartDate = $("#validStartDate");
	    	var validEndDate = $("#validEndDate");

	    	var defaultStartDate = $.ifvGetTodayDate();
	    	var defaultEndDate = $.ifvGetNewDate('d', 30).newDateS;

	    	validStartDate.val(defaultStartDate);
	    	validEndDate.val(defaultEndDate);

	    	validStartDate.ifvDateChecker({
	    		maxDate : validEndDate
	    	});
	    	validEndDate.ifvDateChecker({
	    		minDate : validStartDate
	    	});
	    },
	    /* 페이지 초기화 */
	    this.init = function () {
	    	this.setCalendar();
	        this.setMenu();
	        this.setButtons();
	    	
	        if (!this.isNew) {
	            this.formDataLoad();
	            this.setTabs();
	        } else {
	            $.ifvSetSelectOptions(this.optionFields);
	        }

	    }
	}

	$(document).ready(function () {
	    var urlParams = $.ifvGetParams();
	    var _rid = urlParams.rid;
    	ifvGlobal["stampBingoRid"] = _rid;
	    var stampBingoGrid = new StampBingoDetail(_rid);
	    stampBingoGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="L02794" />
		&gt; <spring:message code="L00028" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="O00041" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="stampBingoDetailSave_OBJ"/>
			<ifvm:inputNew type="button" btnType="check" text="M00002" id="btnList" objCode="stampBingoDetailList_OBJ"/>
		</div>
	</div>
	<div id="stampBingoDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 행사 번호 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="stbgNo" label="L02796" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 행사명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="stbgNm" label="L02795" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row ">
				<!-- 등록일자 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createDate" label="L01125" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 등록자 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createBy" label="L01602" labelClass="2" conClass="9" disabled="true" />
				</div>
			</div>
			<div class="row ">
				<!-- 행사기간 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="date" id="validStartDate" label="L02798" labelClass="2" conClass="4" required="true"/>
					<div style="float: left">~</div>
					<ifvm:inputNew type="date" id="validEndDate" conClass="4" required="true"/>
				</div>
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="statCd" names="statCd" label="L01630" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row ">
				<!-- 참여횟수유형 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="joinTypeCd" names="joinTypeCd" label="L02799" labelClass="2" conClass="9" required="true"/>
				</div>
				<!-- 행사유형 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="promTypeCd" names="promTypeCd" label="L02800" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row ">
				<!-- 행사점 범위 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="chnlTypeCd" names="chnlTypeCd" label="L02801" labelClass="2" conClass="9" required="true"/>
				</div>
				<!-- 참여제한 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="mbrType" names="mbrType" label="L02803" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
            <div class="row ">
            	<div class="col-xs-6">
                    <!-- Size(행/열 갯수) -->
                    <ifvm:inputNew type="number" id="rowSize" label="L02802" labelClass="2" conClass="2" required="true"/>
                    <div style="float: left">/</div>
                    <ifvm:inputNew type="number" id="colSize" conClass="2" required="true"/>
                </div>
            </div>
			<!-- 설명 -->
			<div class="row">
				<ifvm:inputNew type="textarea" id="descText" label="L00340" labelClass="1" conClass="10" rows="5" maxLength="2000" />
			</div>
            <!-- 적립안내 -->
            <div class="row">
                <ifvm:inputNew type="textarea" id="acrlDescText" label="L02804" labelClass="1" conClass="10" rows="5" maxLength="2000" required="true"/>
            </div>
            <!-- 혜택안내 -->
            <div class="row">
                <ifvm:inputNew type="textarea" id="bnftDescText" label="L02805" labelClass="1" conClass="10" rows="5" maxLength="2000" required="true"/>
            </div>
            <!-- 유의사항 -->
            <div class="row">
                <ifvm:inputNew type="textarea" id="etcDescText" label="L02806" labelClass="1" conClass="10" rows="5" maxLength="2000" required="true"/>
            </div>
		</div>
	</div>

</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>