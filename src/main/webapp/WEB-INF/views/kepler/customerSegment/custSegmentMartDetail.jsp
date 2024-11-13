<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var segMartDetail = function (rid) {

    var _rid = rid;
    var _formId = 'segMartDetail';
   

    this.setRid = function (rid) {
        ifvGlobal["segMartGrid"] = rid;
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
        { fieldName: "csegMtStatusCd", commCode: "ANL_CSEG_MT_STATUS_CD" }, /* 상태  */
        { fieldName: "csegMtCyclTypeCd", commCode: "ANL_CSEG_MT_CYCL_TYPE_CD" } /* 배치주기  */
    ],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
        var _callback = function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                // 필드의 데이터 로드
                $.ifvLoadFormData(result, this.fields, this.optionFields);
           		$("#aplyStartDd").val(result.aplyStartDd.substring(0,10));
        		$("#aplyStartTm").val(result.aplyStartDd.substring(11,16));
           		$("#aplyEendDd").val(result.aplyEendDd.substring(0,10));
        		$("#aplyEendTm").val(result.aplyEendDd.substring(11,16));
             }
        }

        $.ifvSyncPostJSON('<ifvm:action name="getCustSegMartDetail"/>', { rid: this.getRid()}, _callback.bind(this));
    },
    /* 버튼 세팅 */
    this.setButtons = function () {

		/* 세분화 마트 항목명 팝업  */
		$('#btnSegPop').on('click', function () {
			$.fn.ifvmPopupOpen('popupContainer', null,
				'<ifvm:url name="segmentLogicalPop"/>',
				'로지컬 컴포넌트 항목', 860, true, true);
		});
		
		/* 저장  */
		$("#btnSave").click(function () {
	            this.saveAction();
	     }.bind(this));
	
		$("#btnList").click(function () {
	          qtjs.href('<ifvm:url name="custSegmentMartList"/>');
	    });
		  
    },

    /* Form 데이터 제출 */
    this.onSubmit = function () {

        var _submitUrl = this.isNew ? '<ifvm:action name="addCustSegmentMart"/>' : '<ifvm:action name="editCustSegmentMart"/>';
        
        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {

            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

            if (!this.isNew) vObj['rid'] = this.getRid();
            vObj['aplyStartDd'] = $("#aplyStartDd").val()+$("#aplyStartTm").val();
            vObj['aplyEendDd'] = $("#aplyEendDd").val()+$("#aplyEendTm").val();
           
            return vObj;
        }
        
        /* 제출 후 알럿창 */
        var _afterSubmit = function () {
            alert('<spring:message code="L00127"/>');
            if (this.isNew)  {
                qtjs.href('<ifvm:url name="custSegmentMartList"/>');
            }
        };
        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
    },
    /* 저장 버튼클릭 시 확인 */
    this.saveAction = function () {
        if (this.validation.confirm()) this.onSubmit();
    },
    this.setCalendar = function(){
    	var aplyStartDd= $("#aplyStartDd");			
    	var aplyEendDd= $("#aplyEendDd");		
    	var aplyStartTm= $("#aplyStartTm");		
    	var aplyEendTm= $("#aplyEendTm");		
    	
    	aplyStartDd.ifvDateChecker({
    		maxDate : aplyStartDd
    	});
    	aplyEendDd.ifvDateChecker({
    		minDate : aplyEendDd
    	});
    	
    	aplyStartTm.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
  	
    	aplyEendTm.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
    	
   		if(this.isNew==true){
    		
    		$("#aplyStartDd").val($.ifvGetTodayDate());
    		$("#aplyEendDd").val($.ifvGetTodayDate());
    		
    	}
    },
    this.setCommaKeyup = function () {
	
    },
    /* 페이지 초기화 */
    this.init = function () {
        if (!this.isNew) {
            this.formDataLoad();
    		    
         } else {
            $.ifvSetSelectOptions(this.optionFields);
        }

        this.setCalendar();
        this.setCommaKeyup();
        this.setButtons();
    }
}

$(document).ready(function () {
	 $.ifvmLnbSetting('custSegmentMartList');
	var urlParams = $.ifvGetParams();
    var _rid = urlParams.rid;
   
   	ifvGlobal["segMartGrid"] = _rid;
    var segMartGrid = new segMartDetail(_rid);
    segMartGrid.init();
});
</script>
</script>

<div class="page-title">
	<h1>
		고객 세분화 기준정보
		&gt; 상세
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>고객 세분화 기준정보 상세</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="btnSave_OBJ" />
			<button class="btn btn-sm" id="btnList" objCode="custSegMartDetailbtnList_OBJ">
				<spring:message code="M00002" />
			</button>
		</div>

	</div>
	<div id="segMartDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 로지컬 컴포넌트 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="lgcCompNm" label="로지컬 컴포넌트" labelClass="2" conClass="9"   required="true" disabled="true" maxLength="32"/>
					<ifvm:inputNew type="hidden" id="lgcCompId" />
				</div>
				<!-- 로지컬 컴포넌트 그룹-->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="lgcCompTblIntNm" label="로지컬 컴포넌트 그룹" labelClass="3" conClass="8" required="true" disabled="true" maxLength="32" />
						<ifvm:inputNew type="hidden" id="lgcCompTblIntId" />
				</div>
			</div>
			<div class="row ">
				<!--로지컬 컴포넌트 항목 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="tblAliasColNm" label="ALIAS 컬럼명" labelClass="2" conClass="9"  required="true" disabled="true" maxLength="32"/>
					<ifvm:inputNew type="hidden" id="colId" />
				</div>
				<!-- 마트항목명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="csegMtNm" label="고객 세분화 마트 항목명" labelClass="3" conClass="7"  required="true" maxLength="100" disabled="true"/>
					<span class="input-group-addon" style="padding: 6px;" id="btnSegPop"> <a><i class="fa fa-search"></i></a></span>
				
				</div>
			</div>
			<div class="row ">
				<!-- 상태 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="csegMtStatusCd" names="csegMtStatusCd" label="상태" labelClass="2" conClass="9" required="true" />
				</div>
				<!-- 배치주기 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="csegMtCyclTypeCd" names="csegMtCyclTypeCd" label="배치주기" labelClass="3" conClass="8" required="true"/>
				</div>
			</div>
			<div class="row ">
			<div class="col-xs-6">
					<!-- 적용 시작시간 -->
					<ifvm:inputNew type="date" id="aplyStartDd" label="적용 시작시간" labelClass="2" conClass="5"  required="true" />
					<ifvm:inputNew type="time" id="aplyStartTm" conClass="4"  required="true" />
				
				</div>
				<!-- 적용 종료시간 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="date" id="aplyEendDd" label="적용 종료시간" labelClass="3" conClass="4"   required="true" />
					<ifvm:inputNew type="time" id="aplyEendTm" conClass="4"  required="true" />
				</div>
			
			</div>
			
			<div class="row">
				<div class="col-xs-6">
				<!-- 등록자 -->
					<ifvm:inputNew type="text" id="createBy" label="등록자" labelClass="2" conClass="9" disabled="true" />
				</div>
				<div class="col-xs-6">
					<!-- 수정자 -->
					<ifvm:inputNew type="text" id="modifyBy" label="수정자" labelClass="3" conClass="8" disabled="true"/>
				</div>
			</div>
			
			<div class="row">
				<div class="col-xs-6">
					<!-- 등록일시 -->
					<ifvm:inputNew type="text" id="createDate" label="등록일시" labelClass="2" conClass="9" disabled="true" />
				</div>
				<!-- 수정일시 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="modifyDate" label="수정일시" labelClass="3" conClass="8" disabled="true" />
				</div>
			</div>
			
				<div class="row">
				<!-- 설명 -->
					<ifvm:inputNew type="text" id="csegMtInfoDesc" label="설명" labelClass="1" conClass="10" maxLength="1000"/>
				</div>
			
			<div class="row">
				<!-- SQL-->
				<ifvm:inputNew type="textarea" id="sql" label="SQL" labelClass="1" conClass="10" rows="15" maxLength="4000" required="true"/>
			</div>
</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>

