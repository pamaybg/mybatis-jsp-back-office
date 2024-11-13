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

var camId = '<%= cleanXss(request.getParameter("id")) %>'; 	//캠페인 아이디
var segId = null;

var validation;
var loadFlag = false;
var loadContentsPopup;
var quickFlag = true;
var camFlag = 1;
var loadCamId = null;

//퀵캠페인 실행
function quickStart(){
	
	$.ifvPostJSON('<ifvm:action name="startQuickCampaign"/>', {camId : camId}
	,function(result) {
			alert("<spring:message code='M00614'/>");
			
			$("#camSaveBtn").hide();
			$("#camStartBtn").hide();
			$("#segmentNewBtn").hide();
			$("#segmentLoadBtn").hide();
			$("#saveBtn").hide();
			$("#smsTestSendBtn").hide();
			$("#segmentEditBtn").hide();
			
	},function(result) {
			
			if(result.errorType == "500300"){
				alert("<spring:message code='M00617'/>");
			}
			else if(result.errorType == "500200"){
				alert("<spring:message code='M00616'/>");
			}
			else if(result.errorType == "500100"){
				alert("<spring:message code='M00615'/>");
			}
			
	});
	
	
}


//혜택 및 메시지 저장
function quickSaveMessage(contentsId){
	
	var obj = {};
	obj.offerId = $("#benefitSelect option:selected").attr('id');
	obj.offerType = $("#benefitSelectBtn").val();
	obj.appStDate = $("#camStDate").val();
	obj.appEdDate	= $("#camEdDate").val();
	obj.offerName = $("#benefitDirectInput").val();
	obj.contentsId = contentsId;
	obj.camId = camId;
	obj.chnlType = $("#chnlType").val();
	
	$.ifvPostJSON('<ifvm:action name="setQuickOffer"/>', obj
	,function(result) {
			/* alert('<spring:message code="M00152"/>'); */
	});
	
	
}

//콘텐츠 목록 조회 클릭 시 수행
function changeContents(data){
	
	var url = data.path;
	//url = url.split('.')[0] + "?id=" + data.id;
	var i = url.split("/");
	var fileName = i[i.length-1];
	fileName = fileName.split('.')[0];
	url = '/marketing/content/load/' + fileName + "?id=" + data.id + '&type=' + data.contentsTypeCode;
	
	var obj = $.ifvCachedHtml(url);
	$('#contentsMessage').html(obj.responseText);
	loadUiSetting();
	
	//컨텐츠 신규로 등록
	detail = false;
	
	loadPopupClose();
}

//퀵캠페인 세그먼트 불러오기 하였을 경우 실행
function selectedSegmentLoad(data){
	
	$("#tempTable1").removeClass("disabledDiv");
	$("#tempTable2").removeClass("disabledDiv");
	$("#templateTypeWrap").removeClass("disabledDiv");
	
	loadFlag = true;
	loadCamId = camId;
	camId = data.camId;
	segId = data.segId;
	
	initCampaign(segId);
	
	segmentPopupClose();
}

//캠페인 정보 조회
function initCampaign(segId){
	
	nodeId = [];
	if(camId != null && camId != 'null'){
	    $.ifvProgressControl(true);
		$.ifvPostJSON('<ifvm:action name="getQuickCampaign"/>'
				,{camId : camId, segId : segId}
				,function(result) {
					//피로도 체크
					if(result.fatiExceptYn == '1'){
						$("#fatigueExcept").attr('checked', true);
					}
					
					//상세화면인지 불러오기 화면이지 구분하기 위한 값
					var detailFlag = '<%= cleanXss(request.getParameter("id")) %>';
					
					camId = result.camId;
					
					if(!loadFlag){
						//조회 한 데이터 바로 저장할 수 있도록 데이터 셋팅
						memberList = null;
						memberList = result.memberList;
						
						targetCustCnt = result.targetCustCnt;
						agreeCust = result.agreeCust;
						fatiCnt = result.fatiCnt;
						prmsCnt = result.prmsCnt;
						dupCnt = result.dupCnt;
					}
					else{
						memberList = null;
					}
					
					
					
				if(!loadFlag){
					
					$("#camName").val(result.camName);
					$("#camGol").val(result.goalCode);
					$("#camStDate").val(result.startDate.split(' ', 1));
					$("#camEdDate").val(result.endDate.split(' ', 1));
					
					if(result.chnlType != null && result.chnlType != ''){
						$("#chnlType").val(result.chnlType);
					}
					
					//혜택 정보 불러오기
					if(result.offerType != null){
						$("#benefitSelectBtn").val(result.offerType);
						offerList(result.offerType);
						$("#" + result.offerId).attr("selected", "selected");
					}
					
				}
				
				//세그먼트 조회
				if(result.segItem != null && result.segItem.length > 0){
					
					if(result.segItem[0].segType == 'file'){
						$("#uploadRadio").click();
						
						$("#uploadResult").show();
						
						//결과화면 출력
						$("#savedArea").show();
						$("#segNameTxt").text(result.segItem[0].segName);
						
						//최종저장 시 사용 객체
						saveTargetObj.dupCnt = result.dupCnt;
						saveTargetObj.allUploadCnt = result.targetCustCnt;
						saveTargetObj.fileName = result.segItem[0].fileName;
						saveTargetObj.memberList = result.memberList;
						saveTargetObj.successCnt = result.agreeCust;
						saveTargetObj.failCnt = result.segItem[0].fileFailCnt;
						
						$('input:radio[name=memType]:input[value=' + result.segItem[0].memType + ']').attr("checked", true);
						
						//파일 순서 결정
						if( $(':radio[name="memType"]:checked').val() != 'internal'){
							result.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
						}
						
						$("#fileConfirmTextArea").text("<spring:message code='M00687'/>");
						gridData = null;
						$("#uploadMemberInfoGrid").empty();
						
						//업로드 결과 회원 정보 조회
						gridData = result.memberList;
						uploadMemberInfoGridFunc();
						
						//업로드 결과 건수 조회
						var resultGridList = new Array();
						var resultAllCnt = {};
						var resultSuccessCnt = {};
						var resultFailCnt = {};
						
						resultAllCnt.name = "<spring:message code='M00700'/>";
						resultAllCnt.uploadCnt = result.targetCustCnt;
						
						resultSuccessCnt.name = "<spring:message code='M00701'/>";
						resultSuccessCnt.uploadCnt = result.agreeCust;
						
						resultFailCnt.name = "<spring:message code='M00702'/>";
						resultFailCnt.uploadCnt = result.segItem[0].fileFailCnt;
						
						resultGridList.push(resultAllCnt);
						resultGridList.push(resultSuccessCnt);
						resultGridList.push(resultFailCnt);
						
						uploadData = resultGridList;
						uploadResultNumberGridFunc();
						
						$.ifvProgressControl(false);
					}
					else{
						var targetGroupId = result.segItem[0].targetGroupId;
					    
					    //타겟그룹이 있을경우 타겟그룹 상세 화면 로드
					    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
					        //타겟그룹 상세화면 Load
					        targetGroupMain.targetGroupDetailLoad(targetGroupId);
						}
					}
				}
				
				
				//혜택 및 메시지 조회
				
				if(result.path != null){
					var url = result.path;
					//url = url.split('.')[0] + "?id=" + data.id;
					var i = url.split("/");
					var fileName = i[i.length-1];
					fileName = fileName.split('.')[0];
					url = '/marketing/content/load/' + fileName + "?id=" + result.contentsId;
					
					var obj = $.ifvCachedHtml(url);
					$('#contentsMessage').html('');
					$('#contentsMessage').html(obj.responseText);
					loadUiSetting();
				}
				
				
				
				//캠페인이 실행중일 경우 전체 disable
				if(!loadFlag && result.camStatus != 'W'){
					
					//저장 및 실행 버튼 숨김
					$("#camSaveBtn").hide();
					$("#camStartBtn").hide();
					$("#segmentNewBtn").hide();
					$("#segmentLoadBtn").hide();
					$("#saveBtn").hide();
					$("#smsTestSendBtn").hide();
					$("#segmentEditBtn").hide();
					
					//혜정샘이 css 화면 덮어주는거 만들어 주면 적용해야 함
					$("#quickAccordion .e-content").addClass("disabledDiv");
				}
				
				
				if(detailFlag == null || detailFlag == 'null'){
					camId = loadCamId;
					loadFlag = false;
				}
				else{
					camId = '<%= cleanXss(request.getParameter("id")) %>';
				}
		}
		,function(result) {
	        $.messageCheckr(result.message);
	        
	        $.ifvProgressControl(false);
	    });
	}

}


//달력
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


//캠페인 수정
function modifyQuickCampaign(){
	
	validation = $("#quickFormArea").ifvValidation();
	
	if(validation.confirm()){
		
	
		var obj = {};
		var fatiExceptYn = '0';
		
		//피로도 체크 여부 확인
		if($("input:checkbox[id='fatigueExcept']").is(":checked")){
			fatiExceptYn = '1';
		}
		
		obj.fatiExceptYn = fatiExceptYn;
		
		obj.camId = camId;
		obj.camName = $("#camName").val();
		obj.goalCode = $("#camGol").val();
		obj.startDate = $("#camStDate").val();
		//obj.startDate += ' 00:00:00';
		
		obj.endDate = $("#camEdDate").val();
		//obj.endDate += ' 00:00:00';
		
		obj.chnlType = $("#chnlType").val();
		
		$.ifvSyncPostJSON('<ifvm:action name="modifyQuickCampaign"/>',obj,
			function(result) {
			
			camId = result.message;
			
			alert('<spring:message code="M00624"/>');
		});
	}
}

//캠페인 마스터 저장
function  setQuickCampaign(){
	validation = $("#quickFormArea").ifvValidation();
	
	if(validation.confirm()){
		var obj = {};
		
		var fatiExceptYn = '0';
		
		//피로도 체크 여부 확인
		if($("input:checkbox[id='fatigueExcept']").is(":checked")){
			fatiExceptYn = '1';
		}
		
		obj.fatiExceptYn = fatiExceptYn;
		
		//if( validation.confirm() == true ){
			
			obj.camName = $("#camName").val();
			obj.goalCode = $("#camGol").val();
			obj.startDate = $("#camStDate").val();
			//obj.startDate += ' 00:00:00';
			
			obj.endDate = $("#camEdDate").val();
			//obj.endDate += ' 00:00:00';
			
			obj.chnlType = $("#chnlType").val();
			
			$.ifvSyncPostJSON('<ifvm:action name="setQuickCampaign"/>',obj,
				function(result) {
				
				camId = result.message;
				
				alert('<spring:message code="M00623"/>');
			});
		//}
	}
	
}

//오퍼 명 조회
function offerList(obj){
	$.ifvPostJSON('<ifvm:action name="getListOffer"/>',{
		offerTypeCd : obj, strOrderby : 'mof.create_date'
	},function(result) {
		
		//초기값이 직업입력일 경우 인풋창 활성화
		var defaultSet = false;
		if(result.rows == 0){
			defaultSet = true;
		}
		else{
			defaultSet = false;
		}
		
		//혜택명 지우고 다시 셋팅
		$("#benefitSelect").empty();
		var directSelected = {'offerName' : '<spring:message code="M00671"/>', 'codeName' : 'direct'};
		result.rows.push(directSelected);
		var temp = $("#offerListTemplate").tmpl(result.rows);
		$("#benefitSelect").append(temp);
		
		
		if(defaultSet){
			//초기값이 직업입력일 경우 인풋창 활성화
			$("#benefitDirectInput").show();
		}
		else{
			$("#benefitDirectInput").hide();
		}
		
	});
}

//공통코드 조회 - 혜택
function benefitType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'OFFER_TYPE_CD'
		, enableNA : true
	},function(result) {
		
		var temp = $("#benefitTemplate").tmpl(result.rows);
		$("#benefitSelectBtn").append(temp);
		
		//첫음 로드 시 혜택 명도 조회
		offerList(result.rows[0].codeName);
		
	});
}; 

//공통코드 조회 - 목적
function camGolType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAM_GOAL_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#camGolTemplate").tmpl(result.rows);
		$("#camGol").append(temp);
		
	});
}; 

//공통코드 조회 - 채널 유형
function chnlType(){
	/* $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAM_CHNL_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#chnlTypeTemplate").tmpl(result.rows);
		$("#chnlType").append(temp);
		
	}); */
	
	$.ifvSyncPostJSON('<ifvm:action name="getChannelType"/>',{
	},function(result) {
		var temp = $("#runChanneltemp").tmpl(result);
		$("#chnlType").append(temp);
	});
	
}; 

function accordionSetting(){
	$("#quickAccordion").ejAccordion({collapsible: true});
	$("#quickAccordion").width('inherit');
}

//load시 필요없는 항목 제거
function loadUiSetting(){
	$('.campaign_load_contents #header').remove();
	$('.campaign_load_contents #sideMenu').remove();
	$('.campaign_load_contents .page-title').remove();
	$("#contentsMessage .btn").addClass("btn_gray");
}

	//컨텐츠
	function contentsLoad(){
	
		
		
		var contentFlag = false;
		
		//채널 시스템
		$.ifvSyncPostJSON('<ifvm:action name="getChnnl"/>',{
			id : $("#chnlType").val()
		},function(result) {
			
			if(result.length > 0){
				contentFlag = true;
			}
			else{
				
				$('#contentsMessage').html('');
				
				alert('<spring:message code="M00503"/>');
			}
			
		
	});
	
	if(contentFlag){
		
		var conType = '';
		
		//콘텐츠 유형
		/* $.ifvSyncPostJSON('<ifvm:action name="getChnlConType"/>',{
			id : $("#chnlType option:selected").attr('id')
		},function(result) {
			
			conType = result[0].codeName;
			
		}); */
		
		
		var url = $("#chnlType option:selected").attr('path');
		//url = url.split('.')[0] + "?id=" + data.id;
		var i = url.split("/");
		var fileName = i[i.length-1];
		fileName = fileName.split('.')[0];
		url = '/marketing/content/load/' + fileName + '?type=' + conType + '&chnl=' +$("#chnlType option:selected").val() ;
		
		var obj = $.ifvCachedHtml(url);
		$('#contentsMessage').html(obj.responseText);
		loadUiSetting();
	}
	
	
}

//타겟팅 Main Load
function targetingLoad(){
	$.fn.ifvmLoadUiSetting("targetingContents", '<ifvm:url name="loadTargetingMain"/>');
}


/* 팝업 닫기 */
function loadPopupClose(){
	loadContentsPopup.destroy();
}

$(document).ready(function(){
	
	$("#quickFormArea").ifvValidation();
	
	setChannelCalendar();
	//혜택 코드 조회
	benefitType();
	
	//컴코드 목적 조회
	camGolType();
	
	//공통코드 조회 - 채널유형
	chnlType();
	
	//아코디언 셋팅
	accordionSetting();
	
	//타겟팅 로드
	targetingLoad();
	
	$("#camStartBtn").on('click', function(){
		
		//장용 - 캠페인 상태 체크
		$.ifvSyncPostJSON('<ifvm:action name="campaignStatusCheck"/>', {
			camId : camId
	    },
	    function(result) {
	    	
	    	if(result.message == '1'){
	    		alert("<spring:message code='M01386' />"); 
	    	}
	    	else if(result.message == '2'){
	    		alert("<spring:message code='M01387' />");
	    	}
	    	else{
	    		quickStart();
	    	}
		});
		
	});
	
	//채널 변경 시 혜택 및 메시지 내용 변경
	$("#chnlType").on('change', function(){
		contentsLoad();
	});
	
	//캠페인 저장
	$("#camSaveBtn").on('click', function(){
		if(camId != null && camId != 'null'){
			modifyQuickCampaign();
		}
		else{
			setQuickCampaign();
		}
		
	});
	
	//혜택 및 메시지 불러오기 시 실행
	$('#loadContentsBtn').on('click', function(){
		$("#loadContentsPopup").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTContentsListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00371"/>',
	        width: 600,
	        close : 'loadPopupClose'
	    });
		
		loadContentsPopup = $("#loadContentsPopup").data("ejDialog");
	});
	
	
	//혜택 셀렉트 박스 집접입력 선택 시 인풋창 노출
	$('#benefitSelect').on('change', function(){
		
		//var val = $("option:selected", this).text();
		var val = $("option:selected", this).attr('value');
		//if(val =='<spring:message code="M00110"/>'){
		if(val =='direct'){
			$("#benefitDirectInput").show();
		}else{
			$("#benefitDirectInput").hide();
		}
	});
	
	//혜택 변경 시 호출
	$('#benefitSelectBtn').on('change', function(){
		
		codeVal = this.selectedOptions[0].value;
		
		offerList(codeVal);
	});
	
	
	$("#uploadConArea").hide();
	
	//캠페인 정보 조회
	initCampaign(segId);
	
	//컨텐츠 로드
	contentsLoad();
	
    window.onload = function(){
        setTimeout(function(){
          $.ifvProgressControl(false);
        }, 0);
    }
	
});


</script>


<script id="runChanneltemp" type="text/x-jquery-tmpl">
<option id="${'${'}typeid}" value="${'${'}codeName}" path="${'${'}path}">${'${'}typeCd}</option>
</script>

<script id="offerListTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}id}" value="${'${'}codeName}">${'${'}offerName}</option>
</script>

<script id="benefitTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="camGolTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="chnlTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>



<style>
input[type=text].skip{display:none;}
.user_main_area .main_area.main2{border-bottom:0;}
</style>


<div class="page-title">
	<h1>
		<spring:message code="M00601"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00601"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
<%-- 		<button class="btn btn-sm" id='camSaveBtn'>
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00280"/>
		</button> 
 --%>		<%-- <button class="btn btn-sm" id=''>
			<spring:message code="M00602"/>
		</button>  --%>
		<button class="btn btn-sm" id='camStartBtn'>
			<spring:message code="M00603"/>
		</button> 
	</div>
</div>

 <div id="quickAccordion">
     <h3>
         <a href="#"><spring:message code="M00604"/></a>
     </h3>
     
     <div id='quickFormArea'>
     	<div class="campaign_load_contents">
			<div>
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="M00604"/></span>
					</div>
					<div class="col-xs-5 searchbtn_r">
						<button class="btn btn-sm btn_gray" id="camSaveBtn">
							<i class="glyphicon glyphicon-check"></i>
							<spring:message code="M00280"/>
							</button>
					</div>
				</div>
			</div>	     
		     
		     <div class="well form-horizontal well_sum">
		         <div class="row qt_border">
		         	<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00605"/></label>
		         	<div class="col-sm-4">
						<ifvm:input type="text" id="camName" required="true" maxLength="30"/>	
					</div>
					<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00606"/></label>
		         	<div class="col-sm-3">
						<ifvm:input type="select" id="camGol"/>	
					</div>
		         </div>
		         <div class="row qt_border">
		         	<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00607"/></label>
		         	<div class="col-sm-4">
						<div class="col-xs-6 cal_frt start_date">
							<ifvm:input type="date" id="camStDate"/>				
						</div>
						<div class="col-xs-1 swung_dash">~</div>
						<div class="col-xs-6 cal_scd end_date">
							<ifvm:input type="date" id="camEdDate"/>				
						</div>
					</div>
					<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00608"/></label>
		         	<div class="col-sm-3">
						<ifvm:input type="select" id="chnlType"/>	
					</div>
		         </div>
		         
		         <div class="row">
		       	  	<div class="col-sm-2 control-label">
		       	  		<label><spring:message code="M00618"/></label>
					</div>
		         	
		         	<div class="col-sm-4">
		         		<label class="checkbox-inline">
		         			<ifvm:input type="checkbox" id="fatigueExcept"/>
		         		</label>
					</div>
				</div> 
					
					
		     </div>
		</div>     
     </div>
     <h3>
         <a href="#"><spring:message code="M00609"/></a>
     </h3>
     <div class="well form-horizontal well_sum">
         <div id="targetingContents" class="campaign_load_contents border_style"></div>
     </div>
     <h3>
         <a href="#"><spring:message code="M00610"/></a>
     </h3>
     <div class="well form-horizontal well_sum">
	     <div class="row qt_border">
	     	<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00611"/></label>
	        <div class="col-sm-2">
				<ifvm:input type="select"  id="benefitSelectBtn" />
			</div>
			<div class="col-sm-3 quickCam_bene_input">
				<ifvm:input type="select"  id="benefitSelect"/>	
			</div>
			<div class="col-sm-3 quickCam_bene_input">
				<ifvm:input type="text" id="benefitDirectInput" className="skip" />	<!-- 직접입력시 text -->
			</div>
	     </div>
	     <div class="row qt_border">
	        <label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00612"/></label>
	        <div class="col-sm-10">
				<button class="btn_Load" id="loadContentsBtn">
					<img src="<ifvm:image name='ico_search'/>" alt="" />				
					<spring:message code="M00613"/>
				</button>	
			</div>
		</div>
		<div id="contentsMessage" class="campaign_load_contents"></div>
	</div>
</div>


<div id="loadContentsPopup" class="popup_container"></div>