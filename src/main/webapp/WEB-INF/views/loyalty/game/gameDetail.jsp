<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var GameDetail = function (rid) {
	    // 게임 RID
	    var _rid = rid;
	    var _formId = 'gameDetail';
	    this.setRid = function (rid) {
	        ifvGlobal["gameRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
	        return _rid;
	    },
	    this.setGameType = function (type) {
	        ifvGlobal["gameType"] = type;
	    },
	    // 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
	    this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
	    // 유효성 검사 초기화
	    this.validation = $("#"+ _formId ).ifvValidation(),
	    this.fields = $.ifvGetFields(_formId),
	    this.optionFields = [
	        { fieldName: "statCd", commCode: "LOY_GAME_STAT_TYPE"},
	        { fieldName: "joinTypeCd", commCode: "LOY_GAME_JOIN_TYPE" },
	        { fieldName: "gameTypeCd", commCode: "LOY_GAME_TYPE" }
	    ],
	    this.numberFields = ["budgtAmt", "tcktRunCnt"],
	    /* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields, this.optionFields);
	                this.setCommaOnLoad();
	                this.setGameType(result.gameTypeCd);
	            }
	        }
	        $.ifvSyncPostJSON('<ifvm:action name="getGameDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	    },
	    /* 탭 초기화 */
	    this.setTabs = function () {
	        $("#tabArea").empty();
	        $("#tabArea").DrawTab({
	            item: items
	            /* [{
	                label: '<spring:message code="L02866"/>',
	                href: '<ifvm:url name="gameSubDetail"/>'
	            }, {
                    label: '<spring:message code="L02895"/>',
                    href: '<ifvm:url name="gameTicketList"/>'
                }, {
                    label: '<spring:message code="L02651"/>',
                    href: '<ifvm:url name="gameJoinList"/>'
                }] */
	        });
	    },
	    /* 버튼 세팅 */
	    this.setButtons = function () {
	        $("#btnSave").click(function () {
	            this.saveAction();
	        }.bind(this));

	        $("#btnList").click(function () {
	            qtjs.href('<ifvm:url name="gameList"/>');
	        });
	    },
	    /* 메뉴 세팅 */
	    this.setMenu = function () {
	        $.ifvmLnbSetting('gameList');
	    },
	    /* Form 데이터 제출 */
	    this.onSubmit = function () {

	        var _submitUrl = this.isNew ? '<ifvm:action name="addGame"/>' : '<ifvm:action name="editGame"/>';

	        /* submit을 위한 Form 데이터 파라미터 세팅 */
	        var _setSubmitParams = function () {
	            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
	            if (!this.isNew) vObj['rid'] = this.getRid();

                vObj = this.replaceCommaToSubmit(vObj);

	            return vObj;
	        }

	        /* 제출 후 알럿창 */
	        var _afterSubmit = function () {
	            alert('<spring:message code="L00127"/>');
	            if (this.isNew)  {
	                qtjs.href('<ifvm:url name="gameList"/>');
	            }
	        };
	        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
	    },
	    /* 저장 버튼클릭 시 확인 */
	    this.saveAction = function () {
	        if (this.validation.confirm()) this.onSubmit();
	    },
        this.setCommaOnKeyup = function () {
            var _this = this;
            this.numberFields.forEach(function(numberField) {
                $('#' + numberField).keyup(function() {
                    _this.setCommaInNumberField(numberField);
                });
            })
        },
        this.setCommaOnLoad = function () {
            var _this = this;
            this.numberFields.forEach(function(numberField) {
                _this.setCommaInNumberField(numberField);
             });
        },
        this.setCommaInNumberField = function(numberField) {
            var numberVal = $('#' + numberField).val();
            $('#'+ numberField).val($.fn.ifvmNumberWithCommas(numberVal));
            $('#' + numberField).css("text-align", "right");
        },
        this.replaceCommaToSubmit = function(vObj) {
            this.numberFields.forEach(function(vf) {
                vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
            });
            return vObj;
        },
	    this.setCalendar = function(){
	    	var validStartDate = $("#gameStartDate");
	    	var validEndDate = $("#gameEndDate");

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
	        this.setCommaOnKeyup();
	    	
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
    	ifvGlobal["gameRid"] = _rid;
	    var gameGrid = new GameDetail(_rid);
	    gameGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="L02863" />
		&gt; <spring:message code="L00028" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="O00041" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="gameDetailSave_OBJ"/>
			<ifvm:inputNew type="button" text="M00002" id="btnList" />
		</div>
	</div>
	<div id="gameDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 행사 번호 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="gameNo" label="L02796" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 행사명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="gameNm" label="L02795" labelClass="2" conClass="9" required="true"/>
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
					<ifvm:inputNew type="date" id="gameStartDate" label="L02798" labelClass="2" conClass="4" required="true"/>
					<div style="float: left">~</div>
					<ifvm:inputNew type="date" id="gameEndDate" conClass="4" required="true"/>
				</div>
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="statCd" names="statCd" label="L01630" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row ">
                <!-- 행사유형 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="gameTypeCd" names="gameTypeCd" label="L02800" labelClass="2" conClass="9" required="true"/>
                </div>
				<!-- 참여유형 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="joinTypeCd" names="joinTypeCd" label="L02862" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row">
				<!-- 예산 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="budgtAmt" label="L02864" labelClass="2" conClass="9" required="true" />
				</div>
				<!-- 티켓 당 횟수 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="tcktRunCnt" label="L02865" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<!-- 설명 -->
			<div class="row">
				<ifvm:inputNew type="textarea" id="descText" label="L00340" labelClass="1" conClass="10" rows="5" maxLength="2000" />
			</div>
		</div>
	</div>

</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>