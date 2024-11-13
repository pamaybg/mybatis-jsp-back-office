<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var conditionId = '<%= cleanXss(request.getParameter("conditionId")) %>';
var isNew = false;
var conditionMain;
var conditionData = null; //조건추출 설정조건
var conditionPopup;

conditionMain = function() {
	this.saveBtnHide = false;
	
	var flag;
	try {flag = workflowFlag} catch(exception){ flag = false}
	
	if (flag) {
		this.saveBtnHide = true;
	}
}

//조건추출 팝업 열기
conditionMain.prototype.conditionPopupOpen = function() {
	$("#conditionPopupCon").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="stnConditionPopup"/>',
		contentType: "ajax",
		title: '<spring:message code="M00514"/>',
		width: 600,
		close : 'conditionMain.conditionPopupConClose'
	});
}

//조건추출 팝업 닫기
conditionMain.prototype.conditionPopupConClose = function() {
	conditionPopupCon._destroy();
}

//조건추출 팝업 확인버튼 클릭 시
conditionMain.prototype.setCondition = function(conditionId) {
	
	//캠페인마스터 저장여부 체크
	if(camId == null || camId == '') {
		alert('<spring:message code="M00855"/>');
		return false;
	}
	
	//부모창에 입력조건 세팅
	if(isSearched) {
		isNew = true;
		conditionMain.conditionDetailLoad(conditionId);
		conditionMain.conditionPopupConClose();
	} else {
		$.ifvCallValidationBox($("#searchMbrCountBtn"),'<spring:message code="M02363"/>');
	}
	
}

//조건추출 결과화면 Load
conditionMain.prototype.conditionDetailLoad = function(conditionId) {
    //main 화면 숨김
    $("#conditionMain_top").hide();
  	//content 화면 보이기
    $("#conditionMain_con").show();
  	
    //조건추출 결과화면 Load
    $.fn.ifvmLoadUiSetting("conditionMain_con", '<ifvm:url name="stnConditionDetailLoad"/>' + '?conditionId=' + conditionId);
}

//조건추출 상세화면 저장버튼 클릭 시 
conditionMain.prototype.saveCondition = function() {
	
	if(conditionData.camId != null && conditionData.camId != "") { //캠페인 마스터정보 존재
		if(conditionData.mbrCount > 0) { //회원수 1명 이상
			if(conditionId != null && conditionId != "null" && conditionId != "") { //수정
				conditionData.conditionId = conditionId;
				$.ifvProgressControl(true);
				$.ifvPostJSON('<ifvm:action name="editChargingStationCondition"/>', conditionData 
				, function(result) {
					if(result.success) {
						alert('<spring:message code="L00127"/>');
// 						$($("#quickAccordion").find('h3')[2]).trigger('click');
						$.ifvProgressControl(false);
					} else {
						alert('<spring:message code="I00742"/>');
						$.ifvProgressControl(false);
					}
				});
			} else { //신규등록
				$.ifvProgressControl(true);
				$.ifvPostJSON('<ifvm:action name="setChargingStationCondition"/>', conditionData 
				, function(result) {
					if(result.success) {
						alert('<spring:message code="L00127"/>');
// 						$($("#quickAccordion").find('h3')[2]).trigger('click');
						$.ifvProgressControl(false);
					} else {
						alert('<spring:message code="I00742"/>');
						$.ifvProgressControl(false);
					}
				});
			}

            //캠페인 워크플로우일 경우
            try {
                if (workflowFlag) {
                    //캔버스 저장
                    campaignTargetingPopSave();
                }
            }
            catch (e) {
            }
		} else {
			alert("<spring:message code='M00708'/>");
		}
	} else { //캠페인 마스터 우선 저장 필요 시 
		alert('<spring:message code="C00147"/>');
	}
}

$(document).ready(function() {
	conditionMain = new conditionMain();

	$("#conditionPopupBtn").on("click", function(){
	    conditionMain.conditionPopupOpen();
	});
});


</script>

<script id="conditionMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="conditionMainSaveBtn">    
	<i class="glyphicon glyphicon-check"></i>     
	<spring:message code="M00280"/>
</button>  
</script>

<style>
html, body{background:#fff;}
</style>

<div id="conditionMain_wrap">
    <div id="conditionMain_top">
        <div class="page_btn_area">
            <div class="col-xs-12">
                <span><spring:message code="S00008"/></span>
            </div>
        </div>
    	<div class="user_main_area">
    		<div class="main_area main2">
    			<p class="user_txt user_tit"><spring:message code="S00035"/></p>
    			<p class="user_txt user_desc"><spring:message code="S00033"/></p>
    			<button class="user_btn_list" id="conditionPopupBtn">
    				<spring:message code="S00034"/>
    			</button>
    		</div>
<!--     		<div class="main_area main2"> -->
<%--     			<p class="user_txt user_tit"><spring:message code="M01690"/></p> --%>
<%--     			<p class="user_txt user_desc"><spring:message code="M01691"/></p> --%>
<!--     			<button class="user_btn_list" id="segmentListOpenBtn"> -->
<%--     				<spring:message code="M01469"/> --%>
<!--     			</button> -->
<!--     		</div> -->
    	</div>
    </div>
    <div class="well form-horizontal well_wrap pad0" id="conditionMain_con">
    </div>
</div>

