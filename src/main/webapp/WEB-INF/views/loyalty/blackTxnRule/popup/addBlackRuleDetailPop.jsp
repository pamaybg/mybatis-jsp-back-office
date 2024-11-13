<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id='addBlackRuleDetailForm'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="기준유형"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" dto="basType" required="true" names="basType" id="basType" />
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="횟수(초과)"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="number" dto="gtOrEt" id="gtOrEt"  className="text-right"  required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="추출기간"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" dto="basDayMmCd" required="true" names="basDayMmCd" id="basDayMmCd" />
	        </div>
	        
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="기준일/월"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="number" dto="basDayCnt"  className="text-right"  id="basDayCnt" required="true" />
	        </div>
	        
	    </div>
	    
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><spring:message code="오퍼"/></label>
	        <div class="col-xs-4 control_content">
	        <div class="input-group">
	            <ifvm:inputNew type="text" dto="ofrNm" disabled="true" names="ofrNm" id="ofrNm" />
	            <span class="input-group-addon" id="ofrPopBtn">
							<a><i class="fa fa-search"></i></a>
				</span>
			</div>
	        </div>
	        
	    </div>
	    
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><spring:message code="데이터셋"/></label>
	        <div class="col-xs-4 control_content">
	        
	        <div class="input-group">
	            <ifvm:inputNew type="text" dto="dsNm" disabled="true" names="dsNm" id="dsNm" />
	            <span class="input-group-addon" id="dsPopBtn">
							<a><i class="fa fa-search"></i></a>
				</span>
	        </div>
	        </div>
	        
	        <label class="col-xs-2 control-label"><spring:message code="추출컬럼"/></label>
	        <div class="col-xs-4 control_content">
	        <div class="input-group">
	            <ifvm:inputNew type="text" dto="dsItemNm" disabled="true" names="dsItemNm" id="dsItemNm" />
	            <span class="input-group-addon" id="dsItemPopBtn">
							<a><i class="fa fa-search"></i></a>
				</span>
	        </div>
	        
	        
	    </div>


	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveBlackRuleBtn" objCode="addBlackRuleDetailPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="blackRuleCancelBtn" objCode="addBlackRuleDetailPopCancel_OBJ">
		<spring:message code="L01781"/>
		
	</button>
</div>

<div id="ofrPop" class="popup_container"></div>
<div id="datasetListPop" class="popup_container"></div>
<div id="datasetItemPop" class="popup_container"></div>

<script type="text/javascript">
	var addBlackRule_isNew;
	var ofrNo=null;
	var dsItemRid=null;
	var dataSetRid = null;
	function addBlackRulDetailInit() {
		$.fn.ifvmSetSelectOptionCommCode("basType", "LOY_FRAUD_RULE_TYPE", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("basDayMmCd", "LOY_FRAUD_RANAGE_CD", null, null, true);
		
		if (typeof blackRuleRid === 'undefined' || blackRuleRid == null) {
			addBlackRule_isNew = true;
		} else {
			addBlackRule_isNew = false;
			getBlackRuleDetail();
		}
	}
	
	function getBlackRuleDetail() {
		$.ifvSyncPostJSON('<ifvm:action name="getBlackRuleDetail"/>', {
			rid : blackRuleRid
		}, function(result) {
			 $("#addBlackRuleDetailForm").dataSetting(result);
			 $("#basType").val(result.basType);
			 $("#gtOrEt").val(result.gtOrEt);
			 $("#basDayMmCd").val(result.basDayMmCd);
			 $("#basDayCnt").val(result.basDayCnt);
			 ofrRid = result.ofrRid;
			 ofrNo = result.ofrNo;
			 dsItemRid = result.dsItemRid;
			 dataSetRid = result.dsRid;

		});
	}
	
	function offerPopup() {
		$("#ofrPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="ofrPop"/>',
	        contentType: "ajax",
	        title: '오퍼 조회',
	        width: 600,
	        close : 'ofrClosePop'
		});
	}
	function ofrClosePop() {
		ofrPop._destroy();
	}
	
	function dsPopup() {
		$("#datasetListPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="dsPop"/>',
	        contentType: "ajax",
	        title: '데이터셋 조회',
	        width: 600,
	        close : 'datasetClosePop'
		});
	}
	function datasetClosePop() {
		datasetPop._destroy();
	}
	
	function dsItemPopup() {
		$("#datasetItemPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="tierGrpDsDataSetItemPop"/>',
	        contentType: "ajax",
	        title: '데이터셋 아이템 조회',
	        width: 600,
	        close : 'tierGrpDsDataSetItemClosePop '
		});
	}
	function tierGrpDsDataSetItemClosePop() {
		datasetItemPop._destroy();
	}

	function saveBlackRule() {

		var validation = $("#addBlackRuleDetailForm").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = addBlackRule_isNew ? '<ifvm:action name="saveBlackRule"/>'
					: '<ifvm:action name="modifyBlackRule"/>';
			var varData = null;
			varData = {
				rid 		 : blackRuleRid,
				blackRuleRid : blackRuleRid,
				blackMstRid   : blackRuleDetail_rid,
				basType 		 : $("#basType").val(),
				gtOrEt   : 	$("#gtOrEt").val(),
				basDayMmCd 		 : $("#basDayMmCd").val(),
				basDayCnt : $("#basDayCnt").val(),
				dsItemRid : dsItemRid,
				dsRid : dataSetRid,
				ofrNo : ofrNo,
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addBlackRuleDetailClosePop();
					addBlackRule_isNew = false;
					blackRuleList._doAjax();
				}
			}, function(result) {
				if (result.message != null)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
		}
	}

	$(document).ready(function() {
		addBlackRulDetailInit();

		$("#saveBlackRuleBtn").click(function() {
			saveBlackRule();
		});

		$("#blackRuleCancelBtn").click(function() {
			addBlackRuleDetailClosePop();
		});
		
		$("#ofrPopBtn").click(function() {
			offerPopup();
		});
		
		$("#dsPopBtn").click(function() {
			dsPopup();
		});
		
		$("#dsItemPopBtn").click(function() {
			dsItemPopup();
		});
		

	});
</script>