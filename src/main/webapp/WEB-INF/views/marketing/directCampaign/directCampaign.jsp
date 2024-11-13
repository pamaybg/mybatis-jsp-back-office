

<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var listLength;

var camId;		//캠페인 아이디
var conId;		//컨텐츠 아이디
var chnlType;	//채널 유형
var directFlag = true;	//컨텐츠 상세화면을 공유하기 때문에 다이렉트 캠페인 일경우만 플래그 처리
var segmentId;
var targetGroupNm;

//컨텐츠 조회
function getSegmentDetail(loadCamId){
	
		$.ifvPostJSON('<ifvm:action name="getDirectSegment"/>', {camId : loadCamId}
		,function(result) {
			
			//세그먼트 템플릿 넣기
			$("#conditionWrap").empty();
			for(var i = 0; i < result.segItem.length; i++) {
				if(result.segItem[i].fieldType == "NUMBER")
					result.segItem[i].filterValue = $.ifvNumberFormat( result.segItem[i].filterValue );
			}
			
			var temp = $("#directSegmentTemplate").tmpl(result.segItem);			
			$("#conditionWrap").append(temp);
			
		});
	
	
}


//바로실행 캠페인 실행
function runDirectCampaign(){
	//유효성 체크 - 하루 한번만 실행
	$.ifvSyncPostJSON('<ifvm:action name="checkDirectCampaign"/>', {camId : camId}
	,function(result) {
		
		//실제 실행
		$.ifvPostJSON('<ifvm:action name="loadAndGoCampaignExecution"/>', {id: camId, chnlType : chnlType}
		,function(result) {
			$("#disabledArea").show();
			$("#successPop").show();//성공시
			
			//카운트 업데이트
			$("#" + conId).find(".num_subjects").text(result.agreeCust);
			$("#" + conId).find(".num_all").text(result.targetCustCnt);
			
			$("#directList").empty();
			getDirectCampaign();
			
		}
		,function(result){
			$("#disabledArea").show();
			$("#failedPop").show();	//실패시
		});
		
	}
	,function(result){
		if(result.errorType == "200410"){
			alert("<spring:message code='M00022'/>");
		}
		else{
			alert("<spring:message code='M01097'/>");
		}
		
	});
	
	
}

//컨텐츠 저장 완료 후 수행
/* function directSaveMessage(rtnConId){

	$('#smsContentsArea').ejDialog('destroy');
	
	getContentsDetail(conId, chnlType);
	
} */

//컨텐츠 조회
function getContentsDetail(conId, chnlType){
	
	if(conId != null && conId != ""){
		
		$.ifvPostJSON('<ifvm:action name="getDetailContent"/>', {id : conId}
		,function(result) {
			$("#conTitle").text(result.title);
			$("#conDesc").text(result.contents);
			
			$("#chnlName").text(chnlType);
			
			if(chnlType == 'SMS' || chnlType == 'MMS' || chnlType == 'LMS'){
				$("#chnlIcon").attr('src', "<ifvm:image name='direct_ico_sms' />");
				
				if(chnlType == 'MMS'){
					var img = '<img src="/'+ result.imagepath +'" alt="" /><br />';
					$("#conDesc").prepend(img);
				}
			}
			else if(chnlType == 'PUSH'){
				$("#chnlIcon").attr('src', "<ifvm:image name='direct_ico_push' />");
			}
			
		});
	}
	else{
		alert("<spring:message code='M01100'/>");
	}
	
}

//바로캠페인 조회
function getDirectCampaign(){
	
	$.ifvPostJSON('<ifvm:action name="getDirectCampaignList"/>', {}
	,function(result) {
		for(var i = 0; i < result.campaignListItem.length; i++) {
			if(result.campaignListItem[i].finishFlag != null) // 서버작업이 완료되면 if 조건문을 "금일발송이 완료된경우" 로 변경
				var temp = $("#directCampaignDoneTemplate").tmpl(result.campaignListItem[i]);
			else
				var temp = $("#directCampaignListTemplate").tmpl(result.campaignListItem[i]);			
			$("#directList").append(temp);
		}
		
		var length = result.campaignListItem.length;
		if(length > 6){
			$("#arrImg").hide();
		}else if(length == 0){
			emptyInit();
		} else {
			listLength = length;
		}
		$("#directList .drcp_item.drcp_enable:first").trigger("click");
	});
	
}

//좌측 영역 높이 설정
function listHeightSetting(){
	var leftHeight = $('#sideMenu').outerHeight();
	var headerHeight = $('#header').outerHeight();
	var topTitleHeight = $('#topTitle').outerHeight();
	$("#drcpList").outerHeight(leftHeight - headerHeight - topTitleHeight);
}

//리스트 포커스 됐을 때
function focusList(_this){
	$(".drcp_item").removeClass("focus");
	$(_this).addClass("focus");
	$("#disabledArea").hide();
	arrowPosition();
	
	conId = _this.id;
	chnlType = _this.attributes.chnlType.value;
	camId = _this.attributes.camId.value;
	segmentId = _this.attributes.segId.value;
	targetGroupNm = _this.attributes.targetGroupNm.value;
	if(targetGroupNm.length > 12){
		targetGroupNm = targetGroupNm.substring(0,12)+"...";
	}

	document.getElementById("innerHTMLtxt").textContent = targetGroupNm;
	
	//세그먼트 상세 조회
	getSegmentDetail(camId);
	
	getContentsDetail(conId, chnlType);
}

//데이터 없을 때
function emptyInit(){
	$("#noDataArea").show();
	$("#iconArea").hide();
	$("#conditionWrap>div").hide();
	$("#disabledArea").show();
}

//달력 초기 세팅
function setCalendar() {
	var effectiveDate = $("#effectiveDate"); 
	effectiveDate.val($.ifvGetTodayDate());
}

//팝업 닫기
function smsContentsPopClose(){
	$("#smsContentsArea").ejDialog('destroy');
	getContentsDetail(conId, chnlType);
}

//화살표 위치
function arrowPosition(){
	var arr = [100, 228, 355, 481, 608, 735];
	for(var i=0; i<listLength; i++){
		
		if($("#directList .drcp_item").eq(i).hasClass("focus")){
			$("#arrImg").css("top", arr[i]);
		}
	}
}

//세그먼트 팝업 열기
function openSegmentViewPopup() {
    
    if ($.fn.ifvmIsNotEmpty(segmentId)) {
        $("#segmentViewPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="targetGroupSegmentViewPop"/>?segmentId=' + segmentId,
            contentType: "ajax",
            title: '<spring:message code="M00546" />',
            width: 800,
            close : 'segmentViewPopupClose'
        });
    } else {
        alert('<spring:message code="M01692" />');
    }
}

//세그먼트 팝업 닫기
function segmentViewPopupClose() {
    $('#segmentViewPopup').ejDialog('destroy');
    $('.tooltip').remove();
}

$(document).ready(function(){
	
	getDirectCampaign();
	
	$(window).on("resize load", function() {
		listHeightSetting();	
	});
	setCalendar();
	pageSetUp();
	
	
	//아이콘 클릭시 
	$('#iconArea').on('click', function(){
		var locationPop;
		if(chnlType != null){
			if(chnlType == 'PUSH' || chnlType == 'SMS' || chnlType == 'LMS'){
				locationPop = '<ifvm:url name="loadSmsFormNew"/>?id=' + conId;
			}
			else if(chnlType == 'MMS'){
				locationPop = '<ifvm:url name="loadMmsFormNew"/>?id=' + conId;
			}
			else{
				locationPop = '<ifvm:url name="loadEmailFormNew"/>?id=' + conId;
			}
			
			$("#smsContentsArea").ejDialog({
				enableModal : true,
		        enableResize: false,
		        contentUrl: locationPop,
		        contentType: "ajax",
		        title: '<spring:message code="M00745"/>',
		        width: 1024,
		        close : 'smsContentsPopClose',
		        open : function(){
		        	$("#smsContentsArea .page-title").remove();
		        }
		    });
			
		}
		
	});
	
	//실행 버튼
	$("#checkBtn").on("click", function(){
		
		runDirectCampaign();
		//$("#successPop").show();	//성공시
		//$("#failedPop").show();	//실패시
	});
	
	$("#price").css("text-align", "right")
	
    //세그먼트 팝업
    $('#targetGroupSegmentViewPopBtn').on('click', function(){
        openSegmentViewPopup();
    });
	
});

</script>

<style type="text/css">
	.targetHead {
	    min-height: 40px;
	    line-height: 39px;
	    border-bottom: 1px solid #c6c6c6;
	    font-weight: bold;
	    overflow: hidden;
	}
	    
	#innerHTMLtxt{
		font-size:15px;
		font-weight:bold;
	}
</style>

<script id="directSegmentTemplate" type="text/x-jquery-tmpl">
{{if fieldType == "DATE"}}
<div class="row row_mb">
	<label class="col-xs-4 control-label">${'${'}fieldNm}</label>
	<div class="col-xs-5 control_content">
		<ifvm:input type="date" values="${'${'}filterValue}" disabled="true"/>				
	</div>
</div>
{{/if}}
{{if fieldType != "DATE"}}
<div class="row row_mb">
	<label class="col-xs-4 control-label">${'${'}fieldNm}</label>
	<div class="col-xs-5 control_content">
		<ifvm:input type="text" values="${'${'}filterValue}" disabled="true"/>
	</div>
</div>
{{/if}}
</script>

<script id="directCampaignListTemplate" type="text/x-jquery-tmpl">
<div class="drcp_item drcp_enable" id="${'${'}conId}" chnlType="${'${'}chnlType}" camId="${'${'}camId}" segId="${'${'}segId}" targetGroupNm="${'${'}targetGroupNm}" onclick="focusList(this)">
	<div class="item_txt_area">
		<p class="main_title">${'${'}camName}</p>
		<p class="main_desc">${'${'}camDesc}</p>
	</div>
	<div class="item_num_area">
		<div class="num_wrap">
			<span class="num_subjects">${'${'}tgtCnt}</span>
			<span class="num_txt"><spring:message code="M01086"/></span>
		</div>
		<span class="num_slash">/</span>
		<div class="num_wrap">
			<span class="num_all">${'${'}tgtAllCnt}</span>
			<span class="num_txt"><spring:message code="M01085"/></span>
		</div>
	</div>
</div>
</script>

<script id="directCampaignDoneTemplate" type="text/x-jquery-tmpl">
<div class="drcp_item drcp_item_done" id="${'${'}conId}" chnlType="${'${'}chnlType}" camId="${'${'}camId}">
	<div class="item_txt_area">
		<p class="main_title">${'${'}camName}</p>
		<p class="main_desc">${'${'}camDesc}</p>
		<p class="done_text"><spring:message code="M01101"/></p>
	</div>
	<div class="item_num_area">
		<div class="num_wrap">
			<span class="num_subjects">${'${'}tgtCnt}</span>
			<span class="num_txt"><spring:message code="M01086"/></span>
		</div>
		<span class="num_slash">/</span>
		<div class="num_wrap">
			<span class="num_all">${'${'}tgtAllCnt}</span>
			<span class="num_txt"><spring:message code="M01085"/></span>
		</div>
	</div>
</div>
</script>

<div class="page-title" id="topTitle">
	<h1>
		<spring:message code="M01084"/>
	</h1>
</div>

<div class="drcp_wrap">
	<div class="drcp_list" id="drcpList">
		<div class="contents_height">
			<p class="drcp_list_title"><spring:message code="M01098"/></p>
			<div id="directList">
				<div class="item_nodata" id="noDataArea">
					<spring:message code="M01099"/>
				</div>
			</div>
			
			<span class="list_arr" id="arrImg"><img src="<ifvm:image name='direct_img_arr' />" alt="" /></span>
		</div>
	</div>
	
	<div class="drcp_preview_area">
		
		<div class="drcp_preview">
			<div class="targetHead">
				<%-- <p class="preview_title"><spring:message code="M01087"/></p> --%>
				<div id="innerHTMLtxt" class="col-xs-7">
		            
		        </div>
				<div class="col-xs-5 searchbtn_r">
					<button class="btn btn-sm" id="targetGroupSegmentViewPopBtn"><i class="fa fa-search"></i>
	                	<spring:message code="M00546" />
	            	</button>
            	</div>
			</div>
			<!-- <div class="condition_wrap form-horizontal" id="conditionWrap"> -->
				<%-- <div class="row row_mb">
					<label class="col-xs-4 control-label"><spring:message code="M01088"/></label>
					<div class="col-xs-5 control_content">
						<ifvm:input type="date" id="effectiveDate"/>				
					</div>
				</div>
				<div class="row">
					<label class="col-xs-4 control-label"><spring:message code="M01089"/></label>
					<div class="col-xs-5 control_content">
						<ifvm:input type="text" id="price" values="0"/>
					</div>
				</div>  --%>
			<!-- </div> -->
			<div style="height:15px;"> </div>
			<div class="preview_title_area">
				<p class="preview_title"><spring:message code="M01090"/></p>
				<p class="preview_subtitle"><spring:message code="M01091"/></p>
				
				<!-- 메시지 변경 아이콘 -->
				<div class="ico_wrap" id="iconArea">
					<img src="" alt="" id="chnlIcon"/>
					<span class="ico_txt" id="chnlName"></span>
				</div>
			</div>
			<div class="preview_contents">
				<div class="text_area" id="conTitle"><!-- 메시지 제목 --></div>
				<pre class="text_area textarea_area" id="conDesc"><!-- 메시지 내용 --></pre>
			</div>
			<div class="check_area">
				<a href="javascript:;" id="checkBtn">
					<img src="<ifvm:image name='direct_ico_check' />" alt="" /><!-- 실행 버튼 -->
				</a>
			</div>
		</div>
		<p class="drcp_preview_txt"><span>※</span> <spring:message code="M01097"/></p>
	</div>
	
	<!-- disabled -->
	<div class="disabled_preview" id="disabledArea">
		<!-- 성공 팝업 -->	
		<div class="run_pop" id="successPop">
			<div class="success_area">
				<img src="<ifvm:image name='direct_ico_success' />" alt="" />
				<p class="pop_top_txt"><spring:message code="M01092"/></p>
			</div>
			<div class="pop_txt">
				<spring:message code="M01093"/>
			</div>
		</div>
			
		<!-- 실패 팝업 -->
		<div class="run_pop faild_pop" id="failedPop">
			<div class="failed_area">
				<img src="<ifvm:image name='direct_ico_failed' />" alt="" />
				<p class="pop_top_txt"><spring:message code="M01094"/></p>
			</div>
			<div class="pop_txt">
				<spring:message code="M01095"/>
				<p class="manager_tel"><spring:message code="M01096"/></p>
			</div>
		</div>			
	</div>
</div>
<div id="smsContentsArea" class="popup_container"></div>
<div id="segmentViewPopup"></div>