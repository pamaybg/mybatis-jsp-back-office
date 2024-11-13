<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
    var calculateChanges = function(loadedData, updatedData, ignorableFields, histType, chgCate, optionFields, pgmRid) {

        var optionFieldNames = (typeof optionFields !== "undefined") ? optionFields.map(function(op){ return op.fieldName }) : [];

        var Change = function (){
            this.histType = histType,
            this.chgCol = null,
            this.chgCate = chgCate || '',
            this.chgBfVal = null,
            this.chgAfVal = null
        };

        var changes = [];

        for (var prop in updatedData) {

            var lPropVal = (loadedData[prop] === null) ? "" : loadedData[prop] + "";
            var uPropVal = (updatedData[prop] === null) ? "" : updatedData[prop] + "";

            // 옵션 필드인지 판별
            var isOption = optionFieldNames.indexOf(prop) >= 0;

            if (isOption) {
                lPropVal = $.fn.ifvmIsNotEmpty(lPropVal) ? $("#" + prop + " option[value=" + lPropVal + "]").html() : "";
                uPropVal = $.fn.ifvmIsNotEmpty(uPropVal) ? $("#" + prop + " option[value=" + uPropVal + "]").html() : "";
            }

            function filterToEmptyString(val) {
                if (val === "undefined" || val === "null" || val === "NaN") return '';
                return val;
            }

            lPropVal = filterToEmptyString(lPropVal);
            uPropVal = filterToEmptyString(uPropVal);

            var isIgnorable = ignorableFields.indexOf(prop) >= 0;

            if (!isIgnorable && lPropVal !== uPropVal ) {
                var change = new Change();
                // 라벨명 가져오는 로직
                var labelName = $('#'+ prop ).closest("div").prev()[0].innerText;
                // span 텍스트 가져올 때 * 있을 경우 제거
                var changedColumn = (labelName[0] === '*') ? labelName.substring(1) : labelName;
                changedColumn = (changedColumn === '~') ? "구성인원수" : changedColumn;

                change["chgBfVal"] = lPropVal;
                change["chgAfVal"] = uPropVal;
                change["chgCol"] = changedColumn;
                change["pgmRid"] = pgmRid;

                changes.push(change);
            }
        }

        if (changes.length > 0) $.ifvSyncPostJSON('<ifvm:action name="addPgmHist"/>', changes, function(){});

    };

	var PgmDetail = function (rid) {
		// 프로그램 RID
		var _rid = rid;
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
		var _formId = "pgmDetailValid";

		this.setRid = function (rid) {
	    	ifvGlobal["pgmRid"] = rid;
			_rid = rid;
		},
		this.getRid = function () {
			return _rid;
		},
		// 파라미터에 rid 존재 유무에 따라 신규인지 아닌지 판별
		this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
		// 유효성 검사 초기화
		this.validation = $("#" + _formId).ifvValidation(),
        this.fields = $.ifvGetFields(_formId),
		this.optionFields = [
			{ fieldName: "pgmStat", commCode: "LOY_PGM_STAT_CD" },
			{ fieldName: "pgmType", commCode: "LOY_PGM_JOIN_CD" },
			{ fieldName: "pgmSubType", commCode: "LOY_PGM_SUB_JOIN_CD", parField: "pgmType" }
		],
		/* Form 데이터 로드 */
		this.formDataLoad = function () {
			var _callback = function (result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					// 필드의 데이터 로드
					_loadedData = $.extend(true, {}, result);
					$.ifvLoadFormData(result, this.fields, this.optionFields);
				}
			}
			$.ifvSyncPostJSON('<ifvm:action name="getPgmDetail"/>', { rid: this.getRid() }, _callback.bind(this));
		},
		/* 탭 초기화 */
		this.setTabs = function () {
			$("#tabArea").empty();
			$("#tabArea").DrawTab({
				item: items
					
					/* [{
					label: '<spring:message code="L02782"/>',   
					href: '<ifvm:url name="custItemConfList"/>'  
				}, {
					label: '<spring:message code="L02770"/>',    
					href: '<ifvm:url name="pgmPntPlcyDetail"/>'
				}
				, {
					label: '<spring:message code="L02723"/>',
					href: '<ifvm:url name="pgmChnlList"/>'
				}
				, {
					label: '<spring:message code="L02724"/>',
					href: '<ifvm:url name="pgmHistList"/>'
				}] */
			});
		},
		/* 버튼 세팅 */
		this.setButtons = function () {
			$("#btnSave").click(function () {
				this.saveAction();
			}.bind(this));
	
			$("#btnList").click(function () {
				qtjs.href('<ifvm:url name="pgmListNew"/>');
			});

			/* 채널 조회 팝업  */
			//$('#btnChnlPop').on('click', function () {
            //    var searchCond = { chnlTypeCd: "M" };
			//	$.fn.ifvmSearchHelpOpen(null, searchCond, 'popupContainer', '<ifvm:url name="chnlPop"/>', '<spring:message code="L00126"/>');
			//});

			/* 부모 프로그램 조회 팝업  */
			/* $('#btnParPgmPop').on('click', function () {
                var targetFields = { name: "parPgmNm", rid: "parPgmRid" };
                $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="pgmPop"/>', '<spring:message code="L02716"/>', 1040);
			}); */
            /* 카드유형 조회 팝업  */
            //$('#btnCardTypePop').on('click', function () {
            //    var targetFields = { name: "cardKindPrNm", rid: "cardKindPrRid" };
            //    $.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="cardTypeListPop"/>', '<spring:message code="M01917"/>', 1040);
            //});
            /* 대표 프로그램 조회 팝업  */
            //$('#btnRepPgmPop').on('click', function () {
            //    var targetFields = { name: "repPgmNm", rid: "repPgmRid" };
            //    var searchCond = { repYn: "Y" };
            //    $.fn.ifvmSearchHelpOpen(targetFields, searchCond, 'popupContainer', '<ifvm:url name="pgmPop"/>', '<spring:message code="L02716"/>', 1040);
            //});

		},
		/* 메뉴 세팅 */
		this.setMenu = function () {
			$.ifvmLnbSetting('pgmListNew');
		},
		/* Form 데이터 제출 */
		this.onSubmit = function () {
	
			var _submitUrl = this.isNew ? '<ifvm:action name="addPgm"/>' : '<ifvm:action name="editPgm"/>';
			
			/* submit을 위한 Form 데이터 파라미터 세팅 */
			var _setSubmitParams = function () {

				var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

				_updatedData = $.extend(true, {}, vObj);

				if (!this.isNew) {
				    vObj['rid'] = this.getRid();
				}

				return vObj;
			}
			
			/* 제출 후 알럿창 */
			var _afterSubmit = function () {
				alert('<spring:message code="L00127"/>');
				if (this.isNew)  {
					qtjs.href('<ifvm:url name="pgmListNew"/>');
				} else {
                    // 변경 내역 계산 후 세팅
                    var ignorableFields = ['chnlRid', 'parPgmRid', 'cardKindPrRid'];
                    if (!this.isNew) {
                        calculateChanges(_loadedData, _updatedData, ignorableFields, "PGM", "", this.optionFields, this.getRid());
                    }
					_loadedData = $.extend(true, {}, _updatedData);
				}
			};
			$.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));

		},
		/* 저장 버튼클릭 시 확인 */
		this.saveAction = function () {
			//로옅티 프로그램 대표 갯수 체크 로직 추가(대표프로그램이 1개 이상일수도 있다 하여 주석하였습니다.)
			/* var isValid = true;
			if($("#pgmDetailValid #repYn").is(":checked")){
				$.ifvSyncPostJSON('<ifvm:action name="checkLoyPgmCnt"/>',{ rid : this.getRid() }, function(result){
					if(result > 0) {
						alert('<spring:message code="D10305"/>');
						isValid = false;
						$("#pgmDetailValid #repYn").prop("checked", false);
					}
				});
			} */
			if(/* isValid && */ this.validation.confirm()) this.onSubmit();
		},
		this.setOptionDisabledIfEmpty = function() {

		    var setOptionEmpty = function () {
                var pgmType = $("#pgmType option:selected");
                var pgmTypeVal = pgmType.val();
                if (pgmTypeVal === "OP") $("#pgmSubType").attr("disabled", true);
                else $("#pgmSubType").attr("disabled", false);
		    }

		    setOptionEmpty();
		    $("#pgmType").on('change', function() { setOptionEmpty(); });

		},
		/* 페이지 초기화 */
		this.init = function () {
			if (!this.isNew) {
				this.formDataLoad();
				this.setTabs();
			} else {
				$.ifvSetSelectOptions(this.optionFields);
			}
            this.setOptionDisabledIfEmpty();
			this.setMenu();
			this.setButtons();
		}
	}


	function getChnlPop(){
		var searchCond = { chnlTypeCd: "M" };
		$.fn.ifvmSearchHelpOpen(null, searchCond, 'popupContainer', '<ifvm:url name="chnlPop"/>', '<spring:message code="L00126"/>');
	}

	function getCardTypePop(){
		var targetFields = { name: "cardKindPrNm", rid: "cardKindPrRid" };
		$.fn.ifvmSearchHelpOpen(targetFields, null, 'popupContainer', '<ifvm:url name="cardTypeListPop"/>', '<spring:message code="M01917"/>', 1040);
	}

	function getRepPgmPop(){
		var targetFields = { name: "repPgmNm", rid: "repPgmRid" };
		var searchCond = { repYn: "Y" };
		$.fn.ifvmSearchHelpOpen(targetFields, searchCond, 'popupContainer', '<ifvm:url name="pgmPop"/>', '<spring:message code="L02716"/>', 1040);
	}
	
	$(document).ready(function () {
	    var urlParams = $.ifvGetParams();
	    var rid = urlParams.rid;

    	ifvGlobal["pgmRid"] = rid;

	    var pgmGrid = new PgmDetail(rid);
	    pgmGrid.init();
	});
</script>


<div class="page-title">
	<h1>
		<spring:message code="L00119" />
		&gt; <spring:message code="L00079" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00096" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="pgmDetailBtnSave_OBJ"/>
			<button class="btn btn-sm" id="btnList" objCode="pgmDetailbtnList_OBJ">
				<spring:message code="M00002" />
			</button>
		</div>
	</div>


	<div id="pgmDetailValid">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 프로그램 번호 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="pgmNo" label="L00087" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="pgmStat" names="pgmStat" required="true" label="L00337" labelClass="2" conClass="9" />
				</div>
			</div>
			<div class="row ">
				<!-- 프로그램명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="pgmNm" label="L00088" labelClass="2" conClass="9" required="true" />
				</div>
				<!-- 주관사 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="search" id="chnlNm" dto="chnlNm" label="대표채널" labelClass="2" conClass="9" disabled="true" required="true" btnFunc="getChnlPop" />
					<%-- <span class="input-group-addon" style="padding: 6px;" id="btnChnlPop"> <a><i class="fa fa-search"></i></a></span> --%>
					<ifvm:inputNew type="hidden" id="chnlRid" />
				</div>
			</div>
			<div class="row">
				<!-- 대표 여부 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="checkBox" id="repYn" label="L02714" labelClass="2" conClass="4" />
				</div>
				<!-- 상위 프로그램명 -->
				<%-- <div class="col-xs-6">
					<ifvm:inputNew type="text" id="parPgmNm" label="L02715" labelClass="2" conClass="9" disabled="true" />
					<span class="input-group-addon" style="padding: 6px;" id="btnParPgmPop"> <a><i class="fa fa-search"></i></a>
					</span>
					<ifvm:inputNew type="hidden" id="parPgmRid" />
				</div> --%>
			</div>
            <div class="row">
				<!-- 대표 카드 유형 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="search" id="cardKindPrNm" label="M01917" labelClass="2" conClass="9" disabled="true"  btnFunc="getCardTypePop"/>
					<%-- <span class="input-group-addon" style="padding: 6px;" id="btnCardTypePop"> <a><i class="fa fa-search"></i></a></span> --%>
					<ifvm:inputNew type="hidden" id="cardKindPrRid" />
				</div>
                <!-- 대표 프로그램명 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="search" id="repPgmNm" label="L02880" labelClass="2" conClass="9" disabled="true" btnFunc="getRepPgmPop" />
					<%--<span class="input-group-addon" style="padding: 6px;" id="btnRepPgmPop"> <a><i class="fa fa-search"></i></a></span> --%>
                    <ifvm:inputNew type="hidden" id="repPgmRid" />
                </div>
            </div>
            <div class="row">
                <!-- 유형 -->
                <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="pgmType" names="pgmType" required="true" label="L02730" labelClass="2" conClass="9" />
                </div>
                <!-- 세부 유형 -->
                 <div class="col-xs-6">
                    <ifvm:inputNew type="select" id="pgmSubType" names="pgmSubType" label="L02731" labelClass="2" conClass="9" />
                 </div>
            </div>
			<!-- 소개 -->
			<div class="row">
				<ifvm:inputNew type="textarea" id="contents" dto="contents" label="L00795" labelClass="1" conClass="10" rows="5" maxLength="2000" />
			</div>
		</div>
	</div>
</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>

