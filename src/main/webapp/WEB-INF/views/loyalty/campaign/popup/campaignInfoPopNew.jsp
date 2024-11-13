<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal underline top_well" id="promotionDefault2InfoPop">
            <div class="row qt_border">

                <%-- <%-- 캠페인명 --%>
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="프로모션"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="promNo" names="promNo" dto="promNo" disabled="true" maxLength="50"  />
                </div>
                
                <div class="col-xs-7 control_content">
                    <ifvm:input type="text" id="promNm" dto="promNm" required="true" names="promNm" maxLength="50"  />
                </div> 
                
            </div>
            <div class="row qt_border">

                <div class="row qt_border">
				<label class="col-xs-1 control-label"><spring:message code="설명"/></label>
				<div class="col-xs-11 control_content">
					<ifvm:input type="textarea" maxLength="100" dto="descText" id="descText" rows="3"/>
				</div>
			</div> 
            </div>
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-1 control-label"><spring:message code="상태"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promStatCd" dto="promStatCd" disabled="true" names="promStatCd"  />
                </div>
                
                <label class="col-xs-1 control-label"><spring:message code="등록자"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="name" dto="name" names="name" disabled="true" />
                </div>
                 <div class="col-xs-3 control_content">
                    <ifvm:input type="text" id="divNm" dto="divNm" names="divNm" disabled="true" />
                </div>

            </div>
            <div class="row qt_border">

                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="프로그램"/></label>
                <div class="col-xs-5 control_content">
                    <div class="input-group">
                   		<ifvm:input type="text" id="pgmNm" names="pgmNm" required="true" dto="pgmNm" disabled="true"  />
                		<span class="input-group-addon" id="promotionPgmPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
                	</div>
                </div>
                
                <label class="col-xs-1 control-label"><spring:message code="등록일자"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="text" id="createDate" dto="createDate" names="createDate" disabled="true" />
                </div>
            </div>
            
            <div class="row qt_border">

                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="목적"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promGoalCd" required="true" names="promGoalCd" dto="promGoalCd"  />
                </div>
                
                <%-- <label class="col-xs-1 control-label"><spring:message code="선착순"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="number" id="maxRewardCnt" className="text-right" dto="maxRewardCnt" names="maxRewardCnt" />
                </div>
                <label class="control-label" style="margin-left:0px">명</label> --%>
            </div>
            

            <div class="row qt_border">
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="대유형"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promTypeLv1Cd" required="true" names="promTypeLv1Cd" dto="promTypeLv1Cd"  />
                </div>
                
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="소유형"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promTypeLv2Cd" required="true" names="promTypeLv2Cd" dto="promTypeLv2Cd" />
                </div>
			</div>
			
			<div class="row qt_border">
			
			<label class="col-xs-1 control-label"><spring:message code="제공오퍼등록"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promOfferAmtDefCd" names="promOfferAmtDefCd" dto="promOfferAmtDefCd" />
                </div>
			
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="오퍼"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="ofrNo" dto="ofrNo" required="true" names="ofrNo" disabled="true"  />
                </div>
                <div class="col-xs-3 control_content">
                	<div class="input-group">
                    	<ifvm:input type="text" id="ofrNm" names="ofrNm" dto="ofrNm" disabled="true"  />
                		<span class="input-group-addon" id="offerSearchPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
                </div>
                
                
			</div>
			
			<%-- <div class="row qt_border">
                <label class="col-xs-7 control-label"><spring:message code="스탬프/빙고"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="stampNo" dto="stampNo" names="stampNo" disabled="true"  />
                </div>
                <div class="col-xs-3 control_content">
                	<div class="input-group">
                    	<ifvm:input type="text" id="stampNm" names="stampNm" dto="stampNm" disabled="true"  />
                		<span class="input-group-addon" id="stampListPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
                </div>
                
                
			</div> --%>
			
			<div class="row qt_border">

                <label class="col-xs-1 control-label"><spring:message code="중복지급"/></label>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="checkbox" id="issDupYn"  names="issDupYn" checked="true" />
                </div>
                
                <label class="col-xs-1 control-label"><spring:message code="알림사용"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="checkbox" id="notiYn"  names="notiYn"/>
                </div>
                
                <label class="col-xs-1 control-label"><spring:message code="최대지급인원"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="number" id="maxRewardCnt" className="text-right" dto="maxRewardCnt" names="maxRewardCnt" />
                </div>
                <label class="control-label" style="margin-left:0px">명</label>
                
            </div>
			
            <%-- 마케팅 플랜 --%>
            <%-- <ifvm:input type="hidden" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm"/>
            <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" /> --%>
            <!-- <div class="row qt_border"> -->      
			            
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span style="font-size: 10pt">일정</span>
				</div>
			</div>

			<div class="row">
                <%-- 대분류 --%>
                <label class="col-xs-1 control-label"><span class="asterisk">*</span>기간</label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="date" id="validStartDate" required="true" names="validStartDate" dto="validStartDate"  />
                </div>
                	<ifvm:inputNew type="time" id="validStartTime" conClass="2" required="true"/>
                <div style="float: left">~</div>
                <!-- <label class="control-label" style="margin-left:0px">~ -->
                <div class="col-xs-2 control_content">
                    <ifvm:input type="date" id="validEndDate" names="validEndDate" dto="validEndDate"   />
                </div>
                	 <ifvm:inputNew type="time" id="validEndTime" conClass="2" required="true"/>
			</div>
			
			<div class="row">
				<label class="col-xs-1 control-label"><span class="asterisk">*</span>반복</label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="select" id="promCycleCd" required="true" names="promCycleCd" dto="promCycleCd"  />
                </div> 
			</div>
			
			<div class="row">
				<label class="col-xs-1 control-label">반복요일</label>
                <%-- 소분류 --%>
                <label class="radio-inline"><spring:message code="월"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleMonYn"/>
				</label>
				<label class="radio-inline"><spring:message code="화"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleTueYn"/>
				</label>
				<label class="radio-inline"><spring:message code="수"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleWedYn"/>
				</label>
				<label class="radio-inline"><spring:message code="목"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleThuYn"/>
				</label>
				<label class="radio-inline"><spring:message code="금"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleFriYn"/>
				</label>
				<label class="radio-inline"><spring:message code="토"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleSatYn"/>
				</label>
				<label class="radio-inline"><spring:message code="일"/>
				<ifvm:input type="checkbox" names="cycle"  id="cycleSunYn"/>
				</label>
			</div>

			<div class="row">
                <%-- 생성자 --%>
                <label class="col-xs-1 control-label"><spring:message code="반복일자"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="specialDayFrom" names="specialDayFrom" dto="specialDayFrom"   />
                </div>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="specialDayTo" names="specialDayTo" dto="specialDayTo"   />
                </div>
			</div>
			
			<div class="row">
                <%-- 생성자 --%>
                <label class="col-xs-1 control-label"><spring:message code="반복시각"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="specialTimeFrom" names="specialTimeFrom" dto="specialTimeFrom"   />
                </div>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="specialTimeTo" names="specialTimeTo" dto="specialTimeTo"   />
                </div>
			</div>
			
			
			<div class="row">
                <%-- 생성자 --%>
                <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="계산시점"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="select" id="promCalcCd" names="promCalcCd" required="true" dto="promCalcCd" readonly="true"  />
                </div>
			</div>
			
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span style="font-size: 10pt">고객<span>
				</div>
			</div>

			<div class="row">
				<label class="col-xs-1 control-label"><spring:message code="대상고객군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="tgtGrpNo" dto="tgtGrpNo" names="tgtGrpNo" disabled="true"  />
                </div>
                 <div class="col-xs-3 control_content">
                 	<div class="input-group">
                    <ifvm:input type="text" id="tgtGrpNm" names="tgtGrpNm" dto="tgtGrpNm" disabled="true"  />
                	<span class="input-group-addon" id="tgtGrpIncPopBtn">
							<a><i class="fa fa-search"></i></a>
					</span>
					</div>
                </div>
		
				<label class="col-xs-1 control-label"><spring:message code="제외고객군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="expectTgtGrpNo" names="expectTgtGrpNo" dto="expectTgtGrpNo" disabled="true"  />
                </div> 
                 <div class="col-xs-3 control_content">
                 <div class="input-group">
                    <ifvm:input type="text" id="expectTgtGrpNm" names="expectTgtGrpNm" dto="expectTgtGrpNm" disabled="true"  />
                	<span class="input-group-addon" id="expectTgtGrpIncPopBtn">
							<a><i class="fa fa-search"></i></a>
					</span>
                </div>
			</div>
        </div>
        
        <div class="row">
				<label class="col-xs-1 control-label"><spring:message code="대상채널군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="chnlGrpNo" dto="chnlGrpNo" names="chnlGrpNo" disabled="true"  />
                </div>
                <ifvm:inputNew type="hidden" id="chnlGrpRid" conClass="1"  disabled="true"/>
                 <div class="col-xs-3 control_content">
                 	<div class="input-group">
                    <ifvm:input type="text" id="chnlGrpNm" names="chnlGrpNm" dto="chnlGrpNm" disabled="true"  />
                	<span class="input-group-addon" id="chnlTgtGrpPopup">
							<a><i class="fa fa-search"></i></a>
					</span>
					</div>
                </div>
        </div>
    </div>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="promotionInfoPopSaveBtn" objCode="promotionInfoPopSave_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="promotionInfoPopCancelBtn" objCode="promotionInfoPopCancel_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="loyPgmListPop" class="popup_container"></div>
<div id="offerListPop" class="popup_container"></div>
<div id="offerissListPop" class="popup_container"></div>
<div id="tgtGrpIncPop" class="popup_container"></div>
<div id="expectTgtGrpIncPop" class="popup_container"></div>
<div id="chnlTgtGrpPop" class="popup_container"></div>
<script>
//캠페인기본정보 팝업 설정
function promotionDefaultInfoInit() {
    pageSetUp(); 

    //채널
    $.fn.ifvmSetSelectOptionCommCode("promStatCd", "MKT_CAM_STAT", "W");

    //캠페인 유형
    $.fn.ifvmSetSelectOptionCommCode("promGoalCd", "PROM_GOAL_TYPE", null, null, true);
    
    //캠페인상태
    $.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);

    //조직
    $.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", null, "promTypeLv1Cd", true);

    //기획그룹
    $.fn.ifvmSetSelectOptionCommCode("promOfferAmtDefCd", "PROM_OFFER_AMT_DEF", null, null, true);

    //대분류
    $.fn.ifvmSetSelectOptionCommCode("promCycleCd", "PROM_CYCLE_TYPE", null, null, true);

    //중분류
    $.fn.ifvmSetSelectOptionCommCode("specialDayFrom", "PROM_SPEICAL_DAY", null, null, true);

    //소분류
    $.fn.ifvmSetSelectOptionCommCode("specialDayTo", "PROM_SPEICAL_DAY", null, null, true);

    //세분류
    $.fn.ifvmSetSelectOptionCommCode("promCalcCd", "PROM_CALC_TYPE", null, null, true);

    //if (strType == 'LOY') {
        $('#campaignTypeCode').attr('disabled', true);
        $('#campaignTypeCode').val('PROMOTION');
		/* $('#promYn').prop('checked', true); */
    //}

    //팝업설정
    cDialog.model.title = '프로모션 상세 정보';
    $("#dialog_title").append('프로모션 상세 정보');
    cDialog.model.width = "1100";
    cDialog.model.close = "closeCampaignInfoPop";
}

//달력
function setChannelCalendar() {
    var startDate = $("#validStartDate");
    var endDate = $("#validEndDate");
    var validStartTime= $("#validStartTime");
	var validEndTime= $("#validEndTime"); 
	endDate.val('2090-12-31');
	startDate.val($.ifvGetTodayDate());
	/* endDate.val($.ifvGetNewDate('m', +1).newDateS); */

	//설정
	startDate.ifvDateChecker({
	 maxDate : endDate
	});
	
	endDate.ifvDateChecker({
	 minDate : startDate
	});
	
    
    
     
    
    validStartTime.timepicker({
	      defaultTime : '00:00',
	      timeFormat: 'H:i',
	      showMeridian: false,
	      minuteStep: 5,
	      secondStep: 1
	   });
	
    validEndTime.timepicker({
	      defaultTime : '00:00',
	      timeFormat: 'H:i',
	      showMeridian: false,
	      minuteStep: 5,
	      secondStep: 1
	   });
    
    /* $("#validStartTime").val("00:00");
	$("#validEndTime").val("00:00"); */
}

function savePromotionDefaultInfo() {
	var campaignInfoPopVali2dation = $("#promotionDefault2InfoPop").ifvValidation();	
	if(campaignInfoPopVali2dation.confirm()) {
	
	if($('input:checkbox[id="cycleMonYn"]').is(":checked") == true){
		cycleMonYn = 'Y'
	}else{
		cycleMonYn = 'N'
	}
	
	if($('input:checkbox[id="cycleTueYn"]').is(":checked") == true){
		cycleTueYn = 'Y'
	}else{
		cycleTueYn = 'N'
	}
	
	if($('input:checkbox[id="cycleWedYn"]').is(":checked") == true){
		cycleWedYn = 'Y'
	}else{
		cycleWedYn = 'N'
	}
	
	if($('input:checkbox[id="cycleThuYn"]').is(":checked") == true){
		cycleThuYn = 'Y'
	}else{
		cycleThuYn = 'N'
	}
	
	if($('input:checkbox[id="cycleFriYn"]').is(":checked") == true){
		cycleFriYn = 'Y'
	}else{
		cycleFriYn = 'N'
	}
	
	if($('input:checkbox[id="cycleSatYn"]').is(":checked") == true){
		cycleSatYn = 'Y'
	}else{
		cycleSatYn = 'N'
	}
	
	if($('input:checkbox[id="cycleSunYn"]').is(":checked") == true){
		cycleSunYn = 'Y'
	}else{
		cycleSunYn = 'N'
	}
	
	if($('input:checkbox[id="issDupYn"]').is(":checked") == true){
		issDupYn = 'Y'
	}else{
		issDupYn = 'N'
	}
	
	if($('input:checkbox[id="notiYn"]').is(":checked") == true){
		notiYn = 'Y'
	}else{
		notiYn = 'N'
	}
	
	var varData = null;
	varData = $("#promotionDefault2InfoPop").getSubmitData();
	varData.rid = campaign.id;
	varData.cycleMonYn = cycleMonYn;
	varData.cycleTueYn = cycleTueYn;
	varData.cycleMonYn = cycleMonYn;
	varData.cycleWedYn = cycleWedYn;
	varData.cycleThuYn = cycleThuYn;
	varData.cycleFriYn = cycleFriYn;
	varData.cycleSatYn = cycleSatYn;
	varData.cycleSunYn = cycleSunYn;
	varData.notiYn     = notiYn;
	varData.issDupYn = issDupYn;
	varData.pgmRid = pgmRid;
	varData.ofrRid = offerRid;
	//varData.stampRid = stampRid;
	varData.tgtGrpRid = tgtGrpIncRid;
	varData.expectTgtGrpRid = expectTgtGrpRid;
	varData.validStartDate = $("#validStartDate").val()+' '+$("#validStartTime").val();
	varData.validEndDate = $("#validEndDate").val()+' '+$("#validEndTime").val();
	varData.chnlGrpRid = $("#chnlGrpRid").val();
	var checkStart = true;
	var checkchannel = false;
	$.each(diagram.model.nodes, function(index, node) {
		if(index>0){
			checkStart = false;
		}
		if(checkChnlNode(node.addInfo.nodeType) == true){
			checkchannel = true;
		}
	});
	
  	var buyYn = null;
	$.ifvSyncPostJSON('<ifvm:action name="getBuyNotiYn"/>',{
	}, function(result) {
		buyYn = result.useNotiYn;
	});
	
	
	if(checkStart == false){
		//알림 사용 해제
	    if ( $('input:checkbox[id="notiYn"]').is(":checked") == false) {
	    	if(checkchannel == true){
		    	if(confirm('알림사용 기능 비활성화시 등록된 채널 노드가 모두 삭제 됩니다. \n저장 하시겠습니까?')){
		    		$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
		    				, function(result) {
		    					if ($.fn.ifvmIsNotEmpty(result)) {
		    						
		    						diagram._selectedObject.actualTaskId = result.message;
		    						campaign.id = result.message;
		    						campaignId = campaign.id;
		    						 //set campaign ID
		    			            diagram._selectedObject.campaignId = result.message;
		    			            //set old campaign ID
		    			            diagram._selectedObject.oldCampaignId = result.message;
		    						/* alert("<spring:message code="C00094" />"); */
		    						removeAllNodes();
		    						
		    						saveWorkflow();
		    						closeCampaignInfoPop();
		    					}
		    				}, function(result) {
		    					alert("<spring:message code="M02248" />");
		    				});
	
		    	}
	    	 } else {
		    		$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
		    				, function(result) {
		    					if ($.fn.ifvmIsNotEmpty(result)) {
		    						
		    						diagram._selectedObject.actualTaskId = result.message;
		    						campaign.id = result.message;
		    						campaignId = campaign.id;
		    						 //set campaign ID
		    			            diagram._selectedObject.campaignId = result.message;
		    			            //set old campaign ID
		    			            diagram._selectedObject.oldCampaignId = result.message;
		    						/* alert("<spring:message code="C00094" />"); */
		    						removeAllNodes();
		    						
		    						saveWorkflow();
		    						closeCampaignInfoPop();
		    					}
		    				}, function(result) {
		    					alert("<spring:message code="M02248" />");
		    				});
	    	 }
	      } else {
	    		//프로모션의 구매 사용 여부 
	    		if($('#promTypeLv1Cd').val() == 'PUR'){
	    			//운영 정책의 구매 사용 여부
	    			if(buyYn == 'N'){
			    		$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
			    				, function(result) {
			    					if ($.fn.ifvmIsNotEmpty(result)) {
			    						
			    						diagram._selectedObject.actualTaskId = result.message;
			    						campaign.id = result.message;
			    						campaignId = campaign.id;
			    						 //set campaign ID
			    			            diagram._selectedObject.campaignId = result.message;
			    			            //set old campaign ID
			    			            diagram._selectedObject.oldCampaignId = result.message;
			    						/* alert("<spring:message code="C00094" />"); */
			    						
			    						saveWorkflow();
			    						closeCampaignInfoPop();
			    					}
			    				}, function(result) {
			    					alert("<spring:message code="M02248" />");
			    				});
		    		} else {
						if(notiYn == 'N'){
							$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
									, function(result) {
										if ($.fn.ifvmIsNotEmpty(result)) {
											
											diagram._selectedObject.actualTaskId = result.message;
											campaign.id = result.message;
											campaignId = campaign.id;
											 //set campaign ID
								            diagram._selectedObject.campaignId = result.message;
								            //set old campaign ID
								            diagram._selectedObject.oldCampaignId = result.message;
											/* alert("<spring:message code="C00094" />"); */
											
											saveWorkflow();
											closeCampaignInfoPop();
										}
									}, function(result) {
										alert("<spring:message code="M02248" />");
									});					
							
						} else {
							alert("<spring:message code="M03028" />");
						}
		    		}
	    		} else {
		    		$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
		    				, function(result) {
		    					if ($.fn.ifvmIsNotEmpty(result)) {
		    						
		    						diagram._selectedObject.actualTaskId = result.message;
		    						campaign.id = result.message;
		    						campaignId = campaign.id;
		    						 //set campaign ID
		    			            diagram._selectedObject.campaignId = result.message;
		    			            //set old campaign ID
		    			            diagram._selectedObject.oldCampaignId = result.message;
		    						/* alert("<spring:message code="C00094" />"); */
		    						
		    						saveWorkflow();
		    						closeCampaignInfoPop();
		    					}
		    				}, function(result) {
		    					alert("<spring:message code="M02248" />");
		    				});
	    		}
	      }
	 }
	if(checkStart == true){
		if($('#promTypeLv1Cd').val() == 'PUR'){
			if(buyYn == 'N'){
				$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
						, function(result) {
							if ($.fn.ifvmIsNotEmpty(result)) {
								
								diagram._selectedObject.actualTaskId = result.message;
								campaign.id = result.message;
								campaignId = campaign.id;
								 //set campaign ID
					            diagram._selectedObject.campaignId = result.message;
					            //set old campaign ID
					            diagram._selectedObject.oldCampaignId = result.message;
								/* alert("<spring:message code="C00094" />"); */
								
								saveWorkflow();
								closeCampaignInfoPop();
							}
						}, function(result) {
							alert("<spring:message code="M02248" />");
						});
			} else {
				if(notiYn == 'N'){
					$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
							, function(result) {
								if ($.fn.ifvmIsNotEmpty(result)) {
									
									diagram._selectedObject.actualTaskId = result.message;
									campaign.id = result.message;
									campaignId = campaign.id;
									 //set campaign ID
						            diagram._selectedObject.campaignId = result.message;
						            //set old campaign ID
						            diagram._selectedObject.oldCampaignId = result.message;
									/* alert("<spring:message code="C00094" />"); */
									
									saveWorkflow();
									closeCampaignInfoPop();
								}
							}, function(result) {
								alert("<spring:message code="M02248" />");
							});					
					
				} else {
					alert("<spring:message code="M03028" />");
				}
    		}
		} else {
    		$.ifvSyncPostJSON('<ifvm:action name="savePromotionDefaultInfo"/>', varData
    				, function(result) {
    					if ($.fn.ifvmIsNotEmpty(result)) {
    						
    						diagram._selectedObject.actualTaskId = result.message;
    						campaign.id = result.message;
    						campaignId = campaign.id;
    						 //set campaign ID
    			            diagram._selectedObject.campaignId = result.message;
    			            //set old campaign ID
    			            diagram._selectedObject.oldCampaignId = result.message;
    						/* alert("<spring:message code="C00094" />"); */
    						
    						saveWorkflow();
    						closeCampaignInfoPop();
    					}
    				}, function(result) {
    					alert("<spring:message code="M02248" />");
    				});
		}
	}
  }
}

//dialog close
function closeCampaignInfoPop(args) {
    //campaignDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

//캠페인기본정보 팝업 데이터 설정
function campaignDefaultInfoInitData() {
    //campaignDefaultInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "INFO";

    //캠페인 ID
    var id = diagram._selectedObject.actualTaskId;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        rid: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
			$("#promStatCd").attr("disabled",false);
        	$("#promotionDefault2InfoPop").dataSetting(result);
        	
			$.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);
			$("#promTypeLv1Cd").val(result.promTypeLv1Cd);
			
			$("#promGoalCd").val(result.promGoalCd);
			$.fn.ifvmSetSelectOptionCommCode("promGoalCd", "PROM_GOAL_TYPE",$("#promGoalCd").val(),null,true);
			
			$("#promCycleCd").val(result.promCycleCd);
			$.fn.ifvmSetSelectOptionCommCode("promCycleCd", "PROM_CYCLE_TYPE",$("#promCycleCd").val(),null,true);

		    $.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", $("#promTypeLv1Cd").val(), "promTypeLv1Cd", false);
			$("#promTypeLv2Cd").val(result.promTypeLv2Cd);
	
        	pgmRid = result.pgmRid;
        	offerRid = result.ofrRid;
        	tgtGrpIncRid = result.tgtGrpRid;
        	expectTgtGrpRid = result.expectTgtGrpRid;
        	$("#chnlGrpRid").val(result.chnlGrpRid);
        	//stampRid = result.stampRid;
        	
        	if(result.cycleMonYn=='Y'){
        		$("input:checkbox[id='cycleMonYn']").attr("checked", true);
        	}
        	if(result.cycleTueYn=='Y'){
        		$("input:checkbox[id='cycleTueYn']").attr("checked", true);
        	}
        	if(result.cycleWedYn=='Y'){
        		$("input:checkbox[id='cycleWedYn']").attr("checked", true);
        	}
        	if(result.cycleThuYn=='Y'){
        		$("input:checkbox[id='cycleThuYn']").attr("checked", true);
        	}
        	if(result.cycleFriYn=='Y'){
        		$("input:checkbox[id='cycleFriYn']").attr("checked", true);
        	}
        	if(result.cycleSatYn=='Y'){
        		$("input:checkbox[id='cycleSatYn']").attr("checked", true);
        	}
        	if(result.cycleSunYn=='Y'){
        		$("input:checkbox[id='cycleSunYn']").attr("checked", true);
        	}
        	if(result.issDupYn=='Y'){
        		$("input:checkbox[id='issDupYn']").attr("checked", true);
        	} else {
        		$("input:checkbox[id='issDupYn']").attr("checked", false);
        	}
        	if(result.cycleSunYn=='Y'){
        		$("input:checkbox[id='cycleSunYn']").attr("checked", true);
        	}
        	if(result.notiYn=='Y'){
        		$("input:checkbox[id='notiYn']").attr("checked", true);
        	}
        	$("#validStartDate").val(result.validStartDate.substring(0,10));
       		$("#validStartTime").val(result.validStartDate.substring(11,16));

       		$("#validEndDate").val(result.validEndDate.substring(0,10));
    		$("#validEndTime").val(result.validEndDate.substring(11,16));
        	
           /*  campaignDefaultInfo.camDefaultInfo = result;
            $("#campaignStartDate").val(result.campaignStartDate);
            $("#campaignEndDate").val(result.campaignEndDate); */
        }
    });
    //initModels(campaignDefaultInfo.camDefaultInfo);
}

// dialog close
function closeCampaignInfoPop(args) {
    //campaignDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

function disableCheck() {
	if($("#promCycleCd").val() == "A"){
		/* $('#cycleMonYn').val('');
		$('#cycleTueYn').val('');
		$('#cycleWedYn').val('');
		$('#cycleThuYn').val('');
		$('#cycleFriYn').val('');
		$('#cycleSatYn').val('');
		$('#cycleSunYn').val(''); */
		
		$('#specialDayFrom').val('');
		$('#specialDayTo').val('');
		$('#specialTimeFrom').val('');
		$('#specialTimeTo').val('');
		
		$("input:checkbox[id='cycleMonYn']").attr("checked", false);
		$("input:checkbox[id='cycleTueYn']").attr("checked", false);
		$("input:checkbox[id='cycleWedYn']").attr("checked", false);
		$("input:checkbox[id='cycleThuYn']").attr("checked", false);
		$("input:checkbox[id='cycleFriYn']").attr("checked", false);
		$("input:checkbox[id='cycleSatYn']").attr("checked", false);
		$("input:checkbox[id='cycleSunYn']").attr("checked", false);
		
		$('#cycleMonYn').attr('disabled',true);
		$('#cycleTueYn').attr('disabled',true);
		$('#cycleWedYn').attr('disabled',true);
		$('#cycleThuYn').attr('disabled',true);
		$('#cycleFriYn').attr('disabled',true);
		$('#cycleSatYn').attr('disabled',true);
		$('#cycleSunYn').attr('disabled',true);
		
		$('#specialDayFrom').attr('disabled',true);
		$('#specialDayTo').attr('disabled',true);
		$('#specialTimeFrom').attr('disabled',true);
		$('#specialTimeTo').attr('disabled',true);
	} else if($("#promCycleCd").val() == "W"){
		/* $('#cycleMonYn').val('');
		$('#cycleTueYn').val('');
		$('#cycleWedYn').val('');
		$('#cycleThuYn').val('');
		$('#cycleFriYn').val('');
		$('#cycleSatYn').val('');
		$('#cycleSunYn').val(''); */
		/* $('#specialTimeFrom').val('');
		$('#specialTimeTo').val(''); */
		$('#specialDayFrom').val('');
		$('#specialDayTo').val('');
		
		$('#cycleMonYn').attr('disabled',false);
		$('#cycleTueYn').attr('disabled',false);
		$('#cycleWedYn').attr('disabled',false);
		$('#cycleThuYn').attr('disabled',false);
		$('#cycleFriYn').attr('disabled',false);
		$('#cycleSatYn').attr('disabled',false);
		$('#cycleSunYn').attr('disabled',false);
		
		$('#specialDayFrom').attr('disabled',true);
		$('#specialDayTo').attr('disabled',true);
		$('#specialTimeFrom').attr('disabled',false);
		$('#specialTimeTo').attr('disabled',false);
		
	} else if($("#promCycleCd").val() == "D"){
		/* $('#cycleMonYn').val('');
		$('#cycleTueYn').val('');
		$('#cycleWedYn').val('');
		$('#cycleThuYn').val('');
		$('#cycleFriYn').val('');
		$('#cycleSatYn').val('');
		$('#cycleSunYn').val(''); */
	
		
		$("input:checkbox[id='cycleMonYn']").attr("checked", false);
		$("input:checkbox[id='cycleTueYn']").attr("checked", false);
		$("input:checkbox[id='cycleWedYn']").attr("checked", false);
		$("input:checkbox[id='cycleThuYn']").attr("checked", false);
		$("input:checkbox[id='cycleFriYn']").attr("checked", false);
		$("input:checkbox[id='cycleSatYn']").attr("checked", false);
		$("input:checkbox[id='cycleSunYn']").attr("checked", false);
		
		$('#cycleMonYn').attr('disabled',true);
		$('#cycleTueYn').attr('disabled',true);
		$('#cycleWedYn').attr('disabled',true);
		$('#cycleThuYn').attr('disabled',true);
		$('#cycleFriYn').attr('disabled',true);
		$('#cycleSatYn').attr('disabled',true);
		$('#cycleSunYn').attr('disabled',true);
		
		$('#specialDayFrom').attr('disabled',false);
		$('#specialDayTo').attr('disabled',false);
		$('#specialTimeFrom').attr('disabled',false);
		$('#specialTimeTo').attr('disabled',false);
	}
}

function promotionPgmPop() {
	$("#loyPgmListPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="loyPgmListPopup"/>',
	    contentType: "ajax",
	    title: '<spring:message code="L02716"/>',
	    width: '600px',
	    close : 'loyPgmListClosePop',
	});
}

function loyPgmListClosePop() {
	loyPgmListPop._destroy();
}

function offerListPopup() {
	$("#offerListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPop"/>',
        contentType: "ajax",
        title: '오퍼 등록',
        width: 880,
        close : 'offerPopupClose'
	});
}

function offerissTypePopup() {
	ofrType=null;
	$("#offerissListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrIssPop"/>',
        contentType: "ajax",
        title: '오퍼 등록',
        width: 950,
        close : 'offerissPopupClose'
	});
}

function offerissPopupClose() {
	offerissListPop._destroy();
}

function offerPopupClose() {
	offerListPop._destroy();
}

function tgtGrpIncPopup() {
	$("#tgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpIncPop"/>',
        contentType: "ajax",
        title: '대상고객군 등록',
        width: 680,
        close : 'tgtGrpIncClosePop'
	});
}

function tgtGrpIncClosePop() {
	tgtGrpIncPop._destroy();
}

function expectTgtGrpIncPopup() {
	$("#expectTgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="expectTgtGrpIncPop"/>',
        contentType: "ajax",
        title: '제외고객군 등록',
        width: 680,
        close : 'expectTgtGrpIncClosePop'
	});
}

function expectTgtGrpIncClosePop() {
	expectTgtGrpIncPop._destroy();
}

function chnlTgtGrpPopup() {
	$("#chnlTgtGrpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlTgtGrpPop"/>',
        contentType: "ajax",
        title: '채널 조회',
        width: 880,
        close : 'chnlTgtGrpClosePop'
	});
}

function chnlTgtGrpClosePop() {
	chnlTgtGrpPop._destroy();
}


$(function () {

    //달력 설정
    setChannelCalendar();
 
    //캠페인기본정보 폼 설정
    promotionDefaultInfoInit();

    //캠페인기본정보 데이터
    campaignDefaultInfoInitData();
    
    if(campaign.id == null) {
        $("#issStartTime").val("00:00");
    	$("#issEndTime").val("00:00");  
    }  
    
    disableCheck();
    
    $('#promCycleCd').change(function(){
		disableCheck();
	});
    //저장 클릭시
    $('#promotionInfoPopSaveBtn').on('click', function(){
        savePromotionDefaultInfo();
    });
    
    //저장 클릭시
    $('#promotionPgmPopBtn').on('click', function(){
    	promotionPgmPop();
    });
    
    $("#offerSearchPopBtn").click(function(){
    	if($("#promTypeLv2Cd").val()=='EVENT_FIRST') {
			offerissTypePopup();
		}else {
			offerListPopup();
		}
	});
    
    $("#tgtGrpIncPopBtn").click(function(){
    	tgtGrpIncPopup();
	});
    
    $("#expectTgtGrpIncPopBtn").click(function(){
    	expectTgtGrpIncPopup();
	});
  
    /* //draft 완료 클릭시
    $('#campaignInfoPopDramftSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    }); */

    //취소 클릭시
    $('#promotionInfoPopCancelBtn').on('click', function(){
        closeCampaignInfoPop();
    });
    
    $('#chnlTgtGrpPopup').on('click', function(){
    	chnlTgtGrpPopup();
    });
    
    promStatCheck();


    /* //이벤트유형 팝업 버튼
    $('#intactTypePopupBtn').on('click', function(){
        intactTypePopupOpen();
    });

    //마케팅 플랜 팝업 버튼
    $('#planListPopupBtn').on('click', function(){
        planListPopOpen();
    });

    //상위 캠페인 코드 팝업 버튼
    $('#parCamPopupBtn').on('click', function() {
        parCamPopupOpen();
    }); */

//     setTimeout(function() {
//         //popup 높이 맞추기
//         new ifvm.PopupHeight({
//             popupDivId : 'dialog',
//             contentsId : 'dialogPopupWrap'
//         });

//         cDialog.refresh();
//     }, 500);
});
</script>