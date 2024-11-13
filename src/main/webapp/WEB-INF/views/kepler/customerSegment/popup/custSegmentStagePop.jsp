<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="custStagePop">
	<div class="form-horizontal underline top_well">
		<div class="row">
			<!--고객 분류 -->
				<ifvm:inputNew type="select" id="csegCustCtgCd" names="csegCustCtgCd"  label="고객 분류" labelClass="3" conClass="9"  required="true" maxLength="32"/>
		</div>
		<div class="row">
			<!--고객 유형 -->
			<ifvm:inputNew type="select" id="csegCustTypeCd" names="csegCustTypeCd" label="유형" labelClass="3" conClass="9"  required="true" maxLength="32"/>
		</div>
		<div class="row">
			<!--세분화 단계 -->
			<ifvm:inputNew type="text" id="csegStageNm" label="세분화 단계" labelClass="3" conClass="9"  required="true" maxLength="32"/>
		</div>
		<div class="row">
			<!--세분화  -->
			<ifvm:inputNew type="number" id="csegStageIndex" label="단계 순서" labelClass="3" conClass="9"  required="true" maxLength="3"/>
		</div>	
		<div class="row">
			<!--고객 세분화 룰 -->
			<ifvm:inputNew type="text" id="csegCustRuleNm" label="고객 세분화 룰" labelClass="3" conClass="8"  required="true" maxLength="32" disabled="true"/>
			<ifvm:inputNew type="hidden" id="csegCustRuleId"/>
			<span class="input-group-addon" style="padding: 6px;" id="btnSegStagePop"> <a><i class="fa fa-search"></i></a></span>
		</div>
			
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="custSegStagebtnSave" objCode="custSegStagebtnSave_OBJ">
		<spring:message code="C00164" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="btnCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<script type="text/javascript">

var custStagePop = function () {
    var _rid = 	ifvGlobal["custSegStageRid"];
    var _custSegRid =  ifvGlobal["segDetailRid"];
	var _formId = "custStagePop";

    // 유효성 검사 초기화
    this.validation = $("#custStagePop").ifvValidation(),
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
    this.optionFields = [
        { fieldName: "csegCustCtgCd", commCode: "ANL_CSEG_CUST_CTG_CD"},
        { fieldName: "csegCustTypeCd", commCode: "ANL_CSEG_CUST_TYPE_CD" },
      ],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
    	
        var _callback = function (result) {
            // 필드에 데이터 로드
                        
			$.ifvLoadFormData(result, this.fields);
						  
        };

        $.ifvSyncPostJSON('<ifvm:action name="getCustSegStageDetail"/>', {
            rid: this.getRid()
	        }, _callback.bind(this));
        
        
    },
    /* 버튼 세팅 */
    this.setButtons = function () {
        $("#custSegStagebtnSave").click(function () {
        	
            this.saveAction();
        }.bind(this));

        $("#btnCancel").click(function () {
			$.fn.ifvmPopupClose();
        }.bind(this));

		
		/* 고객 세분화 룰 조회 팝업  */
		$('#btnSegStagePop').on('click', function () {
			$.fn.ifvmPopupOpen('popupPopupContainer', null,
				'<ifvm:url name="segmentRuleLogicalPop"/>',
				'고객 세분화 룰', 800, true, true);
		});

    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {
    	
        var submitUrl = this.isNew ? '<ifvm:action name="addCustSegmentStage"/>' : '<ifvm:action name="editCustSegmentStage"/>';
        
		/* submit을 위한 Form 데이터 파라미터 세팅 */
		var _setSubmitParams = function () {
			var vObj = $.ifvGetFieldData(this.fields, this.optionFields);
			vObj["csegCustRuleId"] =$("#csegCustRuleId").val();			
            vObj["csegMstId"] = _custSegRid;
			
			if (!this.isNew) vObj['rid'] = this.getRid();

			
			return vObj;
		}
		
        /* 제출 후 알럿창 및 화면 이동*/
        var _afterSubmit = function (result) {
        	
        	if(result.message){
        		alert(result.message);
        	}else{
            	alert('<spring:message code="L00127"/>');
               	$.fn.ifvmPopupClose();
                ifvGlobal.custSegmentStageList.setGridAndDataLoad();
        	}       	

        };

        $.ifvSyncPostJSON(submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
         if (this.validation.confirm()) this.onSubmit();
    },
    this.setCommaKeyup = function () {
    },
    this.getStageIndex = function (){
    	  var _IndexCallback = function (result) {
    	 	   	$("#csegStageIndex").val(result);
          };
    	
        $.ifvSyncPostJSON('<ifvm:action name="getCustSegStageIdx"/>', {
        	csegMstId: _custSegRid
	        }, _IndexCallback.bind(this));
    },
    this.init = function () {
        this.setButtons();
        this.getStageIndex();
    	$.ifvSetSelectOptions(this.optionFields);
        
    	this.setCommaKeyup();
        if (!this.isNew) {
        	
            this.formDataLoad();
        }
    }
}

$(document).ready(function () {
	var custStageGrid = new custStagePop();
	
	custStageGrid.init();
});
</script>