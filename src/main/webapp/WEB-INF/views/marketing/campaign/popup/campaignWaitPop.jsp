<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var campaignWait = function() {

	var campaignWaitPopData = {
	};

	this.init = function() {
		
		$("#dialog_title").append('Wait');
		
		//set task type
		diagram._selectedObject.taskType = "WAIT";
		
		$.fn.ifvmSetSelectOptionCommCode("tgtTypeCd", "MKT_MULTI_STEP_TGT_TYPE_CD", "", null, true);
		
		//달력 설정
		this.campaignWaitPopCalendarSet();
		
		this.campaignWaitPopInitData();
	},
	
	/**
	 * 캠페인 시작일시, 종료일시 조회
	 */
	this.getCampaignDate = function() {
	
	    //캠페인 정보
	    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
	
	    //캠페인 기간 출력
	    $('#camTerm').text(campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignStartDate + ' ~ ' + campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignEndDate);
	},


	//dialog close
	this.campaignWaitPopCancelBtn = function(args) {
	    cDialog._destroy();
	},


 	this.campaignWaitPopInitData = function() {
	
		$.ifvProgressControl(true);
		
		var _this = this;
		
		//ID
		var rid = diagram._selectedObject.actualTaskId; 
		
	    //캠페인 Wait 조회
	    $.ifvSyncPostJSON('<ifvm:action name="getCampaignWait"/>', {
	        id: rid
	    },
	    function(result) {
	    	if ($.fn.ifvmIsNotEmpty(result)){
	    		campaignWaitPopData = result;
	    		
	    		//wait 정보 설정
	    		_this.campaignWaitPopDataSet(result);
	    	}
	    });
		
		$.ifvProgressControl(false);
	},

	// 데이터 설정
	this.campaignWaitPopDataSet = function(data) {
		if ($.fn.ifvmIsNotEmpty(data.exeDt)) {
			var exeDt = data.exeDt.substring(0, 4) + "-" + data.exeDt.substring(4, 6) + "-" + data.exeDt.substring(6, 8);
			$("#exeDt").val(exeDt);
		}
		
		if ($.fn.ifvmIsNotEmpty(data.exeTm)) {
			var exeTm = data.exeTm.substring(0, 2) + ":" + data.exeTm.substring(2, 4);
			$("#exeTm").val(exeTm);
		}
		
		$("#tgtTypeCd").val(data.tgtTypeCd);
		$("#tgtCnt").val(data.tgtCnt);
	},

	/**
	 * 달력
	 */
	this.campaignWaitPopCalendarSet = function() {
	    var exeDdDate = $('#exeDt');
	    exeDdDate.val($.ifvGetTodayDate());
	    exeDdDate.ifvDateChecker({});
	
	    $('#exeTm').timepicker({
	        showMeridian: false,
	        defaultTime: '00:00',
	        showSeconds: false,
	        minuteStep: 5,
	        secondStep: 1,
	    });
	},

	//저장
	this.campaignWaitPopSaveBtn = function() {
		var _this = this;
	
		$.ifvProgressControl(true);
		
		campaignWaitPopData.camId = campaign.id;
		campaignWaitPopData.exeDt = $("#exeDt").val().replaceAll("-", "");
		
		if ($("#exeTm").val() != "") {
			campaignWaitPopData.exeTm = $("#exeTm").val().replaceAll(":", "") + "00";
		}
		
		campaignWaitPopData.tgtTypeCd = $("#tgtTypeCd").val();
		campaignWaitPopData.tgtCnt = $("#tgtCnt").val();
		
	
	    //call 예산 및 자원 정보 저장
	    $.ifvPostJSON('<ifvm:action name="saveCampaignWait"/>',
	    		campaignWaitPopData,
	    function(result) {
	    	var id = result.message;
	    	
	        //set actual task ID
	        diagram._selectedObject.actualTaskId = id;
	
	        //set campaign ID
	        diagram._selectedObject.campaignId = campaign.id;
	
	        //set old campaign ID
	        diagram._selectedObject.oldCampaignId = campaign.id;
	
	        //save workflow
	        saveWorkflow();
	
	        //close popup
	        _this.campaignWaitPopCancelBtn();
	        
	        $.ifvProgressControl(false);
	    });
	}

}
var campaignWaitPop;
$(document).ready(function () {
	campaignWaitPop = new campaignWait();
	campaignWaitPop.init();
});


</script>


<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>대기실행일시</label>
			<div class="col-xs-4">
				<ifvm:input type="date" required="true" id="exeDt" />
			</div>
			<div class="col-xs-4 control_content" style="padding:0px">
				<ifvm:inputNew type="time" id="exeTm" />
			</div>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="tgtTypeCd" names="tgtTypeCd" label="대상자" nuc="true" labelClass="3" conClass="8" required="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="number" id="tgtCnt" label="대상자 수" nuc="true" labelClass="3" conClass="8" required="true"/>명
		</div>
 	</div>

    <div class="pop_btn_area">
    	<ifvm:inputNew type="button" id="campaignWaitPopSaveBtn" btnFunc="campaignWaitPop.campaignWaitPopSaveBtn" btnType="save" text="M00280" objCode="campaignWaitPopSaveBtn_obj"/>
    	<ifvm:inputNew type="button" id="campaignWaitPopCancelBtn" btnFunc="campaignWaitPop.campaignWaitPopCancelBtn" btnType="cancel" text="M00441" objCode="campaignWaitPopCancelBtn_obj"/>
    </div>
</div>
