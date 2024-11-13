<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well" id="custDiValDetailForm">
<br>
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="pgmNm" names="pgmNm" disabled="true" dto="pgmNm" label="L02701" labelClass="2" conClass="10" required="true" btnFunc="pgmSrchBtn"/>
		<ifvm:inputNew type="hidden" id="pgmNo" names="pgmNo" disabled="true" dto="pgmNo" required="true"/>
		<ifvm:inputNew type="hidden" id="pgmRid" names="pgmRid" disabled="true" dto="pgmRid" required="true" />
		<ifvm:inputNew type="hidden" id="rid" names="rid" disabled="true" dto="rid"  />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="custTypeCd"  names="custTypeCd"  label="M02328" labelClass="2" conClass="10" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="fieldNm" names="fieldNm"  label="필드명" labelClass="2" conClass="10" required="true"/>
		<!-- <span class="input-group-addon" style="padding : 4px;" id="fieldSrchBtn"> <a><i class="fa fa-search"></i></a></span> -->
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="columnNm" names="columnNm"  label="컬럼명" labelClass="2" conClass="10" disabled="true" required="true" btnFunc="fieldSrchBtn"/>
		<!-- <span class="input-group-addon" style="padding : 4px;" id="fieldSrchBtn"> <a><i class="fa fa-search"></i></a></span> -->
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="fieldDesc" names="fieldDesc"  label="L02601" labelClass="2" conClass="10" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="requiredYn" names="requiredYn" dto="requiredYn" label="L02707" labelClass="2" conClass="4"/>
		<ifvm:inputNew type="select" id="encodeYn" names="encodeYn" dto="encodeYn" label="암호화" labelClass="2" conClass="4"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="fieldValCd" names="fieldValCd" dto="fieldValCd" label="값유형" labelClass="2" conClass="4"/>
		<div id="gpNmArea">
			<ifvm:inputNew type="search" id="gpNm" names="gpNm" dto="gpNm" label="그룹코드" labelClass="2" conClass="4" btnFunc="searchGroupCodeList"/>
			<ifvm:inputNew type="hidden" id="gpCdNm" names="gpCdNm" dto="gpCdNm" conClass="2"/>
		</div>
	</div>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="savaItemBtn" objCode="custItemConfPopSavaItemBtn_OBJ">
		<spring:message code="L01695" />
	</button>
	<button class="btn btn-sm btn_gray"  id="saveContItemBtn" objCode="custItemConfPopSaveContItemBtn_OBJ">
		<spring:message code="O00215" />
	</button>
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="custItemConfPopCloseItemBtn_OBJ">
		<spring:message code="L00941" />
	</button> 
</div>

<div id="pgmSearchPopContainer" class="popup_container"></div>
<div id="fieldSearchPopContainer" class="popup_container"></div>
<div id="gpCdSearchPopContainer" class="popup_container"></div>

<script type="text/javascript">



	var PgmCustDiValPop = function () {
	    var _rid = 	ifvGlobal["custDiValRid"];
	    var _pgmRid = $('#pgmRid').val();
		// 변경이력 검사용
		var _loadedData = {};
		var _updatedData = {};
		var _formId = "custDiValDetailForm";
	    // 유효성 검사 초기화
	    this.validation = $("#" + _formId ).ifvValidation(),
        this.setRid = function (rid) {
	    	ifvGlobal["custDiValRid"] = rid;
            _rid = rid;
        },
        this.getRid = function () {
            return _rid;
        },
		this.setPgmRid = function () {
			_pgmRid = $('#pgmRid').val();
		},
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.isNew = (!$.fn.ifvmIsNotEmpty(this.getRid())) ? true : false,
        this.fields = $.ifvGetFields(_formId),
        this.optionFields = [{ fieldName: "custTypeCd", commCode: "LOY_CUST_TYPE_CD", isFirstLowBlank: true },
                            { fieldName: "requiredYn", commCode: "REQUIRED_YN", isFirstLowBlank: false },
                            { fieldName: "encodeYn", commCode: "REQUIRED_YN", isFirstLowBlank: false },
                            { fieldName: "fraudYn", commCode: "FRAUD_YN", isFirstLowBlank: false },
                            { fieldName: "fieldValCd", commCode: "LOY_CUST_FIELD_VAL_CD", isFirstLowBlank: false }],
        /* Form 데이터 로드 */
        this.formDataLoad = function () {
            var _callback = function (result) {
                // 필드에 데이터 로드
                _loadedData = $.extend(true, {}, result);
				$.ifvLoadFormData(result, this.fields, this.optionFields);
            };

            $.ifvSyncPostJSON('<ifvm:action name="getCustItemConfDetail"/>', {
                rid: this.getRid(),
                ridPgm: this.getPgmRid()
            }, _callback.bind(this));
            
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#savaItemBtn").click(function () {
                this.saveAction();
            }.bind(this));

			$("#saveContItemBtn").click(function () {
				this.saveContAction();
			}.bind(this));

            $("#closePopBtn").click(function () {
                this.popupClose();
            }.bind(this));
            
    		$('#fieldValCd').change(function(){
    			fieldValCdChk();
    		}.bind(this));

			$('#pgmSrchBtn').on('click', function(){
				pgmSrchBtn();
			}.bind(this));
        },
        /* Form 데이터 제출 */
        this.onSubmit = function () {
            var submitUrl = this.isNew ? '<ifvm:action name="saveCustItemConfDetail"/>' : '<ifvm:action name="modifyCustItemConfDetail"/>';
			$.ifvSyncPostJSON(submitUrl, {
				rid : $('#rid').val(),
				ridPgm: $('#pgmRid').val(),
				custTypeCd: $('#custTypeCd').val(),
				fieldNm : $('#fieldNm').val(),
				fieldDesc : $('#fieldDesc').val(),
				requiredYn : $('#requiredYn').val(),
				encodeYn : $('#encodeYn').val(),
				fieldValCd : $('#fieldValCd').val(),
				gpCdNm : $('#gpCdNm').val(),
				columnNm : $('#columnNm').val()
			}, function(result) {
				alert('<spring:message code="L00127"/>');
			}, function(result) {
				if(result.message) alert(result.message);
				else alert('<spring:message code="이미 추가된 항목입니다."/>');
			});
        },
        /* 저장 버튼클릭 시 확인 */
        this.saveAction = function () {
            if (this.validation.confirm()) {
            	this.onSubmit();
				// 팝업 창 닫고
				this.popupClose();
				// 리스트 리로드 => 수정
				custItemConfListSearch();
            }
        },
		this.saveContAction = function () {
			if (this.validation.confirm()) {
				this.onSubmit();
				$("input").val("");
				$("select").prop("selectedIndex", 0);
				fieldValCdChk();
				custItemConfListSearch();
			}
		},
        this.popupClose = function () {
        	$.fn.ifvmPopupClose();
        },
        this.init = function () {
            this.setButtons();
            if (!this.isNew) {
                this.formDataLoad();
            } else {
                $.ifvSetSelectOptions(this.optionFields);
            }
            fieldValCdChk();
        }
	}
	
	function fieldValCdChk(){
		if($("#fieldValCd").val() =="GRP_CD"){
        	$("#gpNmArea").show();
		}else{
			$("#gpNmArea").hide();
			$("#gpCdNm").val("");
			$("#gpNm").val("");
		}
	}
	
	function fieldSrchBtn(){
        $.fn.ifvmPopupOpen('fieldSearchPopContainer', null,
                '<ifvm:url name="searchItemCode"/>',
                '<spring:message code="L02762"/>', 860);
	}


	function pgmSrchBtn(){
		$.fn.ifvmPopupOpen('pgmSearchPopContainer', null,
				'<ifvm:url name="loyPgmListPopup"/>',
				'<spring:message code="L02762"/>', 860);
	}
	
	function searchGroupCodeList(){
		$.fn.ifvmPopupOpen('gpCdSearchPopContainer', null,
                '<ifvm:url name="searchGroupCode"/>',
                '<spring:message code="그룹코드"/>', 860);
	}

	$(document).ready(function () {
		var pgmCustDiValPop = new PgmCustDiValPop();

		pgmCustDiValPop.init();
		
	})
</script>