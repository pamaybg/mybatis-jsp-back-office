<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<!-- 마케팅 플랜 디테일 화면 -->

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/couponDetail.css"/>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/bootstrap-timepicker/bootstrap-timepicker.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.iframe-transport.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-ui.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-fp.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/jquery.multiFilestyle.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/MultiUploader.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/SimpleUploader.js'></script>
<script>
/*
 * 마케팅 플랜 디테일 화면 
 * 
 * @date 2020. 06. 11.
 * @author LEE GYEONG YOUNG
 * 
 */

var planId = '<%= cleanXss(request.getParameter("id")) %>';
var planDtlValidation;
var isValidation;
var execDtlValidation;
var isDtlValidation;
var validation;
var isValid;
var detail = false;
/* 캠페인 플랜의 그리드에서 더블클릭시에 캠페인의 ID값을 조회해서 화면에 뿌려줌. */
function enTrance(){
	if(planId != "null")
	{
		$.ifvSyncPostJSON('<ifvm:action name="selectIdPlanList"/>', {
			   id : planId
		}, function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
			    $("#planNm").val(result.planNm);
				$('#planPrpsCd').val(result.planPrps);
				$("#planDesc").val(result.planDesc);
				$("#planStartDt").val(result.planStart);
				$("#planEndDt").val(result.planEnd);
            }
           });
		detail = true;
	}else{

	}
	
}
			
		
//저장 버튼클릭 시 동작
function savePlan() {
	isValid = validation.confirm();

	//DataValidationCheck();

	if(isValid){
		//상세 페이지일 시 수정 작업 동작
		if(detail)
		{
				$.ifvSyncPostJSON('<ifvm:action name="updatePlan"/>', {
					       id : planId
						 	 , planNm : $("#planNm").val()
							 , planProps : $("#planPrpsCd").val()
							 , planDesc : $("#planDesc").val()
							 , planStart : $("#planStartDt").val()
							 , planEnd : $("#planEndDt").val()

				}, function(result) {
					if(result.success){
						alert('<spring:message code="M01048"/>');
					}
					else{
						alert('<spring:message code="M01050"/>');
					}
				    var url = '<ifvm:url name="planDetail"/>?type=&id=' + planId;
				    qtjs.href(url);
				});
		}

		//상세 페이지가 아닐 시 insert 동작
		else
		{
			//language code
			$.ifvSyncPostJSON('<ifvm:action name="addPlanDtl"/>', 
					{  planNm : $("#planNm").val()
					 , planProps : $("#planPrpsCd").val()
					 , planDesc : $("#planDesc").val()
					 , planStart : $("#planStartDt").val()
					 , planEnd : $("#planEndDt").val()
					}, function(result) {
				if(result.success){
					alert('<spring:message code="M01047"/>');
	 			    var url = '<ifvm:url name="planDetail"/>?type=MKT&id=' + result.message;
				    qtjs.href(url); 
				}
				else{
					alert('<spring:message code="M01050"/>');
				}
			});
		}
	}


}		
	

/**
 * 달력 
 * 
 * - 시작일
 * - 종료일 
 * 
 * @returns
 */
function setChannelCalendar() {

    var startDate = $(".start_date").find('input');
    var endDate = $(".end_date").find('input');
    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetTodayDate());

    startDate.ifvDateChecker({
        maxDate : endDate
    });
    endDate.ifvDateChecker({
        minDate : startDate
    });
}

$(document).ready(function() {
	
    // 메뉴 설정
    $.ifvmLnbSetting('planList');
    
    // 플랜 목적
   // $.fn.ifvmSetSelectOptionCommCode("planPrpsCd", "MKT_CAM_GOAL_CD", null, null, true);
	
    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAM_GOAL_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#planCommCodeTemp").tmpl(result.rows);
		$("#planPrpsCd").append(temp);
	});
    // 달력 설정
    setChannelCalendar();
    
    enTrance();
    
    
    // 저장 버튼 클릭 > 저장
    $("#planSaveBtn").click(function() {
    	validation = $("#planDtlDiv").ifvValidation();
    	savePlan();
    });
    
    // 실행계획 목록 버튼
    $('#planListBtn').click(function() {
		var url = '<ifvm:url name="planList"/>';
        qtjs.href(url);
    });
        
    // 상세 페이지
   // setPlanDetail();
    
});

</script>

<script id="planCommCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="planTypeDetailTemplate" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}

        <div class="filter_area">
            <div class="left">
                {searchBox}
            </div>
        </div>
    
        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            <div class="total_area">{total}</div>   
        <div>
    </div>
</script>


<div class="page-title">
    <h1>
        <spring:message code="M02290"/> &gt; <spring:message code="M02290"/>&nbsp;<spring:message code="L01543"/>
    </h1>
</div>
<div>
 		<div class="page_btn_area" id="headForm">
    		<div class="col-xs-7">
      	  		<span><spring:message code="M02290"/></span>
    		</div>
    	<div class="col-xs-5 searchbtn_r">
    		<%-- 저장버튼 --%>
        	<button class="btn btn-sm" id="planSaveBtn">
            	<i class="glyphicon glyphicon-check"></i>
            	<spring:message code="M00573"/>
        	</button>
        	<%-- 목록버튼 --%>
        	<button class="btn btn-sm" id="planListBtn">
            	<spring:message code="L01698"/>
        	</button> 
    	</div>
	</div>
	
</div>
<div class="well form-horizontal underline top_well" id="planDtlDiv" >
    
    <div class="row qt_border">
    
        <%-- 마케팅 플랜명 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02292"/></label>
        <div class="col-xs-9 control_content">
            <ifvm:input type="text" required="true" id="planNm" names="planNm" maxLength="30"/>
        </div>
    </div>
    
    <div class="row qt_border">
    
        <%-- 시작일 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00593"/></label>
        <div class="col-xs-4 control_content start_date">
            <ifvm:input type="date" required="true" id="planStartDt" names="planStartDt"/>
        </div>
    
        <%-- 종료일 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00594"/></label>
        <div class="col-xs-3 control_content cal_frt end_date">
            <ifvm:input type="date" required="true" id="planEndDt" names="planEndDt"/>
        </div>
    </div>
<div class="well form-horizontal underline" id="selectForm" >
    
    <div class="row qt_border">
    
        <%-- 목적 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00606"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" required="true" id="planPrpsCd" names="planPrpsCd"/>
        </div>
    </div>
</div>
    
    <div class="row qt_border">
    
        <%-- 비고 --%>
        <label class="col-xs-2 control-label"><spring:message code="M00883"/></label>
        <div class="col-xs-9 control_content">
            <ifvm:input type="textarea" className="planDesc" id="planDesc" maxLength="200"/>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/marketing/plan/include/planDetailScript.jsp"/>
    
<div id="dialog" class="popup_container"></div>
