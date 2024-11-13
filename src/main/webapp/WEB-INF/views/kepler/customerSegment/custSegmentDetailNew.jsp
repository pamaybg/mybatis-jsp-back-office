<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var custsegDetail = function (rid) {

    var _rid = rid;
    var _formId = 'custsegDetail';
   

    this.setRid = function (rid) {
        ifvGlobal["custSegRid"] = rid;
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
        { fieldName: "csegTypeCd", commCode: "ANL_CSEG_TYPE_CD"},
        { fieldName: "csegStatusCd", commCode: "ANL_CSEG_MT_STATUS_CD"},
        { fieldName: "csegCyclTypeCd", commCode: "ANL_CSEG_CYCL_TYPE_CD"}
      ],
    /* Form 데이터 로드 */
    this.formDataLoad = function () {
        var _callback = function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                // 필드의 데이터 로드
                 $.ifvLoadFormData(result, this.fields, this.optionFields);
           		
                }
        }

        $.ifvSyncPostJSON('<ifvm:action name="getCustSegDetail"/>', { rid: this.getRid()}, _callback.bind(this));
    },
    /* 버튼 세팅 */
    this.setButtons = function () {

		/* 채널 조회 팝업  */
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
	            qtjs.href('<ifvm:url name="custSegmentListNew"/>');
	        });
		  
    }, 
    /* 탭 초기화 */
    this.setTabs = function () {
        $("#tabArea").empty();
        $("#tabArea").DrawTab({
        	  item: items
	        });
	    },
    /* Form 데이터 제출 */
    this.onSubmit = function () {

        var _submitUrl = this.isNew ? '<ifvm:action name="addCustSegment"/>' : '<ifvm:action name="editCustSegment"/>';
        
        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {

            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

            if (!this.isNew) vObj['rid'] = this.getRid();
            vObj['aplyStartDd'] = $("#aplyStartDd").val()+$("#aplyStartTm").val();
            vObj['aplyEndDd'] = $("#aplyEndDd").val()+$("#aplyEndTm").val();
           
            return vObj;
        }
        
        /* 제출 후 알럿창 */
        var _afterSubmit = function (result) {
        	if(result.message){
        		alert(result.message);
        	}else{
            	alert('<spring:message code="L00127"/>');
            	if (this.isNew)  {
                       qtjs.href('<ifvm:url name="custSegmentListNew"/>');
                 }
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
    	var aplyEndDd= $("#aplyEndDd");		
    	var aplyStartTm= $("#aplyStartTm");		
    	var aplyEndTm= $("#aplyEndTm");		
    	
    	aplyStartDd.ifvDateChecker({
    		maxDate : aplyStartDd
    	});
    	aplyEndDd.ifvDateChecker({
    		minDate : aplyEndDd
    	});
    	
    	aplyStartTm.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
  	
    	aplyEndTm.timepicker({
		      defaultTime : '00:00',
		      timeFormat: 'H:i',
		      showMeridian : false
		   });
    	
   		if(this.isNew==true){
    		$("#aplyStartDd").val($.ifvGetTodayDate());
    		$("#aplyEndDd").val($.ifvGetTodayDate());
    	}
    },
    this.setCommaKeyup = function () {
	
    },
    /* 페이지 초기화 */
    this.init = function () {
        if (!this.isNew) {
        	this.formDataLoad();
            this.setTabs();
    		    
         } else {
            $.ifvSetSelectOptions(this.optionFields);
        }

        this.setCalendar();
        this.setCommaKeyup();
        this.setButtons();
    }
}

$(document).ready(function () {
	 $.ifvmLnbSetting('custSegmentListNew');
    var urlParams = $.ifvGetParams();
    var _rid = urlParams.rid;
   
   	ifvGlobal["segDetailRid"] = _rid;
    var custsegGrid = new custsegDetail(_rid);
    custsegGrid.init();
});
</script>
</script>

<div class="page-title">
	<h1>
		고객 세분화 조회 및 등록
		&gt; 상세
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>고객 세분화 상세</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="check" text="L00125" id="btnSave" objCode="btnSave_OBJ" />
			<button class="btn btn-sm" id="btnList" objCode="custSegMartDetailbtnList_OBJ">
				<spring:message code="M00002" />
			</button>
		</div>

	</div>
	<div id="custsegDetail">
		<div class="form-horizontal underline top_well">
			<div class="row">
				<!-- 로지컬 컴포넌트 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="csegNm" label="고객 세분화 명" labelClass="2" conClass="9"   required="true"  maxLength="32"/>
				</div>
				<!-- 로지컬 컴포넌트 그룹-->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="csegTypeCd" names="csegTypeCd"  label="고객 세분화 유형" labelClass="3" conClass="8" required="true"  maxLength="32" />
				</div>
			</div>
			<div class="row ">
				<!--로지컬 컴포넌트 항목 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="csegStatusCd" names="csegStatusCd" label="상태" labelClass="2" conClass="9"  required="true" maxLength="32"/>
			</div>
				<!-- 마트항목명 -->
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="csegCyclTypeCd" names="csegCyclTypeCd" label="배치 주기" labelClass="3" conClass="8"  required="true"/>
				
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
					<ifvm:inputNew type="date" id="aplyEndDd" label="적용 종료시간" labelClass="3" conClass="4"   required="true" />
					<ifvm:inputNew type="time" id="aplyEndTm" conClass="4"  required="true" />
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
					<ifvm:inputNew type="text" id="csegInfoDesc" label="설명" labelClass="1" conClass="10" maxLength="1000"/>
				</div>
				
</div>

<!-- 탭 -->
<div id="tabArea"></div>

<!-- 팝업 -->
<div id="popupContainer" class="popup_container"></div>

