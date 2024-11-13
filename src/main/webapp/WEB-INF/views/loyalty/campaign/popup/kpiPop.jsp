<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id='kpiDetailInfoForm'>

	<div class="form-horizontal underline top_well">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="KPI유형"/></label>
	        <div class="col-xs-5 control_content">
	            <ifvm:inputNew type="select" dto="promKpiCd" required="true" names="promKpiCd" id="promKpiCd"  maxLength="24"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="대조군"/></label>
	        <div class="col-xs-5 control_content">
	            <ifvm:inputNew type="select" dto="cntrlGrpCd" names="cntrlGrpCd" id="cntrlGrpCd"/>
	        </div>
	        
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"></label>
	        <div class="col-xs-3 control_content">
	            <ifvm:inputNew type="text" dto="tgtGrpNo" disabled="true" names="tgtGrpNo" id="tgtGrpNo" />
	        </div>
	        <div class="col-xs-4 control_content">
	        	<div class="input-group">
                    <ifvm:input type="text" id="tgtGrpNm" disabled="true" names="tgtGrpNm" dto="tgtGrpNm"   />
                    <span class="input-group-addon" id="tgtGrpCntrlPopBtn">
							<a><i class="fa fa-search"></i></a>
					</span>
				</div>
            </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="측정일"/></label>
	        <div class="col-xs-5 control_content">
	            <ifvm:inputNew type="select" dto="kpiDateTypeCd" required="true" names="kpiDateTypeCd" id="kpiDateTypeCd"  maxLength="24"/>
	        </div>
	        <div class="col-xs-2 control_content">
                    <ifvm:inputNew type="number" maxLength="4" id="dateVal" required="true" className="text-right" names="dateVal" dto="dateVal"   />
            </div>
            <label class="control-label" style="margin-left:0px">일</label>
	        
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="오퍼비용유형"/></label>
	        <div class="col-xs-5 control_content">
	            <ifvm:inputNew type="select" dto="kpiOfrCostCd" names="kpiOfrCostCd" id="kpiOfrCostCd"  maxLength="24"/>
	        </div>
	        <div class="col-xs-2 control_content">
                    <ifvm:inputNew type="text" id="kpiOfrCostAmt" className="text-right" names="kpiOfrCostAmt" dto="kpiOfrCostAmt"   />
            </div>
           <label class="control-label" style="margin-left:0px">원</label>
	        
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="기타비용"/></label>
	        <div class="col-xs-2 control_content">
	            <ifvm:inputNew type="text" dto="etcCostAmt" className="text-right" names="etcCostAmt" id="etcCostAmt"  maxLength="24"/>
	        	
	        </div>
	        <div style="float: left">원</div>
	        <div class="col-xs-5 control_content">
                    <ifvm:input type="text" id="etcCostDesc" names="etcCostDesc" dto="etcCostDesc"   />
            </div>
	        
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="인당 공헌이익"/></label>
	        <div class="col-xs-5 control_content">
	            <ifvm:inputNew type="select" dto="manProfitCd" names="manProfitCd" id="manProfitCd"  maxLength="24"/>
	        </div>
	        <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="manProfitAmt" className="text-right" names="manProfitAmt" dto="manProfitAmt"   />
            </div>
            <label class="control-label" style="margin-left:0px">원</label>
	        
	    </div>
	    
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="kpiSaveBtn" objCode="kpiSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="kpiPopCancel" objCode="kpiCancel_OBJ">
		<spring:message code="닫기"/>
	</button>
</div>

<div id="tgtGrpIncPop" class="popup_container"></div>

<script>
function kpiPopupInit() {
	
	pageSetUp(); 

	$('#tgtGrpNo').val('');
	$('#tgtGrpNm').val('');
	
	 $("#kpiOfrCostAmt").attr("onKEYUP", "inputNumberAutoComma(this);");
	 $("#etcCostAmt").attr("onKEYUP", "inputNumberAutoComma(this);");
	 $("#manProfitAmt").attr("onKEYUP", "inputNumberAutoComma(this);");
	
	//채널
    $.fn.ifvmSetSelectOptionCommCode("promKpiCd", "PROM_KPI_TYPE", null, null, true);

    //캠페인 유형
    $.fn.ifvmSetSelectOptionCommCode("cntrlGrpCd", "PROM_CNTRL_GRP_TYPE", null, null, true);

    //캠페인상태
    $.fn.ifvmSetSelectOptionCommCode("kpiDateTypeCd", "PROM_KPI_DATE_TYPE",null,null,true);

    //기획그룹
    $.fn.ifvmSetSelectOptionCommCode("kpiOfrCostCd", "PROM_KPI_OFF_TYPE", null, null, true);

    //대분류
    $.fn.ifvmSetSelectOptionCommCode("manProfitCd", "PROM_KPI_PROF_TYPE", null, null, true);

	cDialog.model.title = 'KPI 기준 정보';
    $("#dialog_title").append('KPI 기준 정보');
    cDialog.model.width = "680";
    cDialog.model.close = "closeKpiPop";
    
    //ampaignInfoPopValidation = $("#campaignDefaultInfoPop").ifvValidation();
}

function inputNumberAutoComma(obj) {
	   
    // 콤마( , )의 경우도 문자로 인식되기때문에 콤마를 따로 제거한다.
    var deleteComma = obj.value.replace(/\,/g, "");
    // 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입한다.
    obj.value = inputNumberWithComma(inputNumberRemoveComma(obj.value));
}

// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
function inputNumberWithComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
}

function inputNumberRemoveComma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, "");
}

function removeComma(str)
{
	n = parseInt(str.replace(/,/g,""));
	return n;
}


function kpiInitData() {
	var promRid = campaign.id;
	
	//캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getPromKpiInfo"/>', {
    	promRid: promRid
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
        	$("#kpiDetailInfoForm").dataSetting(result);
        	promKpiRid = result.rid;
        	tgtGrpCntrlRid = result.tgtGrpCntrlRid;
        }
    });
}

//dialog close
function closeKpiPop(args) {
    //campaignDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

function tgtGrpIncPopup() {
	$("#tgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpIncPop"/>',
        contentType: "ajax",
        title: '대조고객군 등록',
        width: 680,
        close : 'tgtGrpIncClosePop'
	});
}

function tgtGrpIncClosePop() {
	tgtGrpIncPop._destroy();
}

function kpiSave() {
	
	var campaignInfoPopValidation = $("#kpiDetailInfoForm").ifvValidation();
	if(campaignInfoPopValidation.confirm()) {
	
	var varData = null;
	varData = $("#kpiDetailInfoForm").getSubmitData();
	varData.promRid = campaign.id;
	varData.rid = promKpiRid;
	varData.tgtGrpCntrlRid = tgtGrpCntrlRid;
	varData.kpiOfrCostAmt = removeComma($("#kpiOfrCostAmt").val());
	varData.etcCostAmt = removeComma($("#etcCostAmt").val());
	varData.manProfitAmt = removeComma($("#manProfitAmt").val());
	
	$.ifvSyncPostJSON('<ifvm:action name="savePromotionKpi"/>', varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					promKpiRid = result.message;
					//diagram._selectedObject.actualTaskId = result.message;
					//campaign.id = result.message;
					//campaignId = campaign.id;
					 //set campaign ID
		            //diagram._selectedObject.campaignId = result.message;
		            //set old campaign ID
		            //diagram._selectedObject.oldCampaignId = result.message;
					/* alert("<spring:message code="C00094" />"); */
					//saveWorkflow();
					alert("<spring:message code="C00094" />");
					closeKpiPop();
				}
			}, function(result) {
				alert("<spring:message code="M02248" />");
			});
	}
}

$(document).ready(function () {
	kpiPopupInit();	
	
	kpiInitData();
	
	 //저장 클릭시
    $('#kpiSaveBtn').on('click', function(){
        kpiSave();
    });
	 
  //취소 클릭시
    $('#kpiPopCancel').on('click', function(){
        closeKpiPop();
    });
  
    $("#tgtGrpCntrlPopBtn").click(function(){
    	tgtGrpIncPopup();
	});
});

</script>