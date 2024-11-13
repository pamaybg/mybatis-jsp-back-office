<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var OfferGroupDetail = function (rid) {
	    // 프로그램 RID
	    var _rid = rid;
	    var _formId = "offerGroupDetail";
	
	    this.setRid = function (rid) {
	        ifvGlobal["offerGroupRid"] = rid;
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
	    this.priceFields = ["totAmt"],
	    this.optionFields = [
	        { fieldName: "statCd", commCode: "LOY_OFR_STAT_TYPE" },
	        { fieldName: "ofrgrpType", commCode: "LOY_OFRGRP_TYPE" },
	    ],
	    /* Form 데이터 로드 */
	    this.formDataLoad = function () {
	        var _callback = function (result) {
	            if ($.fn.ifvmIsNotEmpty(result)) {
	                // 필드의 데이터 로드
	                $.ifvLoadFormData(result, this.fields, this.optionFields);
	                
					this.priceFields.forEach(function(vf) { 
						var vfVal = $('#' + vf).val();						
						$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
						$('#' + vf).css("text-align", "right");
					});
	            }
	        }
	        $.ifvSyncPostJSON('<ifvm:action name="getOfferGroupDetail"/>', { rid: this.getRid() }, _callback.bind(this));
	    },
	    /* 탭 초기화 */
	    this.setTabs = function () {
	        $("#tabArea").empty();
	        $("#tabArea").DrawTab({
	            item: [{
	                label: '<spring:message code="O00068"/>',
	                href: '<ifvm:url name="offerGroupChildOfferList"/>'
	            }]
	        });
	    },
	    /* 버튼 세팅 */
	    this.setButtons = function () {
	        $("#btnSave").click(function () {
	            this.saveAction();
	        }.bind(this));
	
	        $("#btnList").click(function () {
	            qtjs.href('<ifvm:url name="offerGroupList"/>');
	        });
	
	    },
	    /* 메뉴 세팅 */
	    this.setMenu = function () {
	        $.ifvmLnbSetting('offerGroupList');
	    },
	    /* Form 데이터 제출 */
	    this.onSubmit = function () {
	
	        var _submitUrl = this.isNew ? '<ifvm:action name="addOfferGroup"/>' : '<ifvm:action name="editOfferGroup"/>';
	        
	        /* submit을 위한 Form 데이터 파라미터 세팅 */
	        var _setSubmitParams = function () {
	
	            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
	
	            if (!this.isNew) vObj['rid'] = this.getRid();
	            
				this.priceFields.forEach(function(vf) { 
					vObj[vf] = parseInt(vObj[vf].replace(/,/g,""));
				});
	            
	            return vObj;
	        }
	        
	        /* 제출 후 알럿창 */
	        var _afterSubmit = function () {
	            alert('<spring:message code="L00127"/>');
	            if (this.isNew)  {
	                qtjs.href('<ifvm:url name="offerGroupList"/>');
	            }
	        };
	        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
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
	    /* 페이지 초기화 */
	    this.init = function () {
	        if (!this.isNew) {
	            this.formDataLoad();
	            this.setTabs();
	        } else {
	            $.ifvSetSelectOptions(this.optionFields);
	        }
	
	        this.setCommaKeyup();
	        this.setMenu();
	        this.setButtons();
	    }
	}
	
	$(document).ready(function () {
	    var urlParams = $.ifvGetParams();
	    var _rid = urlParams.rid;
    	ifvGlobal["offerGroupRid"] = _rid;
	    var offerGroupGrid = new OfferGroupDetail(_rid);
	    offerGroupGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="O00005" />
		&gt; <spring:message code="O00065" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="O00041" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="offerGroupDetailSave_OBJ"/>
			<button class="btn btn-sm" id="btnList">
				<spring:message code="M00002" />
			</button>
		</div>
	</div>
	<div id="offerGroupDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 오퍼 그룹 번호 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="ofrgrpNo" label="O00071" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 오퍼 그룹명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="ofrgrpNm" label="O00007" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row ">
				<!-- 생성일 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createDate" label="O00013" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 생성자 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createBy" label="O00012" labelClass="2" conClass="9" disabled="true" />
				</div>
			</div>
			<div class="row ">
				<!-- 유형 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="ofrgrpType" names="ofrgrpType" label="O00051" labelClass="2" conClass="9" required="true"/>
				</div>
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="statCd" names="statCd" label="O00018" labelClass="2" conClass="9" required="true"/>
				</div>
			</div>
			<div class="row">
				<!-- 총액-->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="totAmt" label="O00067" labelClass="2" conClass="8" />(원)
				</div>
			</div>
			</div>
			<!-- 설명 -->
			<div class="row">
				<ifvm:inputNew type="textarea" id="descText" dto="descText" label="O00016" labelClass="1" conClass="10" rows="5" maxLength="2000" />
			</div>
		</div>
</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>

