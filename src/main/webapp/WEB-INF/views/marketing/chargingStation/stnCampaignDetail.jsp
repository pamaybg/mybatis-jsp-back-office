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
//*FormNew.jsp 파일 내 initPopupHeight 함수 호출로 인한 스크립트 깨짐 방지용
function initPopupHeight(){};

//캠페인아이디
var camId = '<%= cleanXss(request.getParameter("id")) %>'; 
if(camId == '' || camId == 'null') {	camId = null;	}

var camStatusCd; //캠페인상태코드
var chnlNo; //충전소코드

var segId = null;

var validation;
var loadFlag = false;
var approvalPopup;
var quickFlag = true;
var camFlag = 1;
var loadCamId = null;
var approvalDetailData = {
		htmlContents: '',
		status: '',
	};
	
var aprvStatus;

//혜택 및 메시지 저장
function quickSaveMessage(contentsId){
		
	var _bnftValidation = $("#" + $("#bnftType option:selected").val().toLowerCase() + "_DetailCon").ifvValidation();
	
	if(_bnftValidation.confirm()) {
		var _bnftType = $("#bnftType option:selected").val();
		var _obj = {};
		
		_obj.camId = camId;
		_obj.chnlType = $("#chnlType").val();
		_obj.bnftTypeCd = _bnftType;
		_obj.offerName = $("#bnftType option:selected").text();
		_obj.contentsId = contentsId;
		
		if(_bnftType == "CAR_WASH") { //무료세차권
			_obj.coupnNmCarWash = $("#coupnNmCarWash").val();
			_obj.coupnDescCarWash = $("#coupnDescCarWash").val();
			_obj.coupnUseGdncCarWash = $("#coupnUseGdncCarWash").val();
		} 
		else if(_bnftType == "DC_COUPON") { //할인쿠폰
			_obj.coupnNmDcCoupon = $("#coupnNmDcCoupon").val();
			_obj.coupnDescDcCoupon = $("#coupnDescDcCoupon").val();
			_obj.dcTypeCdDcCoupon = $("#dcTypeCdDcCoupon option:selected").val();
			_obj.dcAmtDcCoupon = Number($("#dcAmtDcCoupon").val());
			_obj.lowstSettlAmtDcCoupon = Number($("#lowstSettlAmtDcCoupon").val());
			_obj.coupnUseGdncDcCoupon = $("#coupnUseGdncDcCoupon").val();
		}
		else if(_bnftType == "POINT") { //포인트
			_obj.acrlTypePoint = $("#acrlTypePoint option:selected").val();
			_obj.acrlAmtPoint = Number($("#acrlAmtPoint").val());
			_obj.dealStartHourPoint = $("#dealStartHourPoint option:selected").val();
			_obj.dealEndHourPoint = $("#dealEndHourPoint option:selected").val();
			
			//거래일시 시작일 >= 종료일 인 경우 error
			if(Number(_obj.dealStartHourPoint) >= Number(_obj.dealEndHourPoint)) {
				alert('<spring:message code="S00069"/>');
				return false;
			}
		}
		else if(_bnftType == "DC_FIELD") { //현장할인
			_obj.acrlTypeField = $("#acrlTypeField option:selected").val();
			_obj.acrlAmtField = Number($("#acrlAmtField").val());
			_obj.lowstSettlAmtDcField = Number($("#lowstSettlAmtDcField").val());
			_obj.dealStartHourDcField = $("#dealStartHourDcField option:selected").val();
			_obj.dealEndHourDcField = $("#dealEndHourDcField option:selected").val();
			
			//거래일시 시작일 >= 종료일 인 경우 error
			if(Number(_obj.dealStartHourDcField) >= Number(_obj.dealEndHourDcField)) {
				alert('<spring:message code="S00069"/>');
				return false;
			}
		}
		
		$.ifvPostJSON('<ifvm:action name="setChargingStationOffer"/>', _obj
		,function(result) {
			if(result.errorType == 1) {
				alert("저장/수정 실패. 잘못된 혜택유형입니다.");
			}
		});
	}
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
	setRequiredTag();
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
	if(camId != null && camId != '' && camId != 'null'){
		$.ifvPostJSON('<ifvm:action name="getChargingStationCampaignDetail"/>'
		,{camId : camId, segId : segId}
		,function(result) {
			camStatusCd = result.camStatus;
			
			//상세화면인지 불러오기 화면이지 구분하기 위한 값
			var detailFlag = camId;
			
			aprvStatus = result.aprvStatus;
			camId = result.camId;
			chnlNo = result.chnlNo;
			
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
				$("#camStDate").val(result.startDate.split(' ', 1));
				$("#camEdDate").val(result.endDate.split(' ', 1));
				$("#camDispNo").val(result.dispNo);
				
				if(result.chnlType != null && result.chnlType != ''){
					$("#chnlType").val(result.chnlType);
				} else {
					$("#chnlType").val("NA");
				}
				
				$("input[name='camTypeCd']:input[value='"+ result.camTypeCd.toLowerCase() +"']").attr('checked','checked');
				//캠페인유형(MASS/TARGET)에 따른 대상고객(Radio), 타겟팅방법(Radio) 세팅
				camTypeCdSetting();
				enableBenefitSetting();
				
				$("#camDesc").val(result.camDesc);
				$("#camStatus").val(result.camStatusMarkName);
				
				approvalDetailData.status = result.status;
				approvalDetailData.htmlContents = result.contetnt;
				
				//혜택 정보 불러오기
				if(result.offerType != null){
					var _bnftType = result.offerName;
					$("#bnftType").children().each(function(idx, e) {
						if(result.offerName == e.text) {
							_bnftType = e.id;
							$("#" + _bnftType).attr('selected', 'selected');
							$("#" + _bnftType).change();
							return false; // break; 와 똑같이 동작한다.
						}
					});
					
					if(_bnftType == "CAR_WASH") {
						var _gdnc = "";
						_gdnc += result.coupnUseGdnc1  != null ?          result.coupnUseGdnc1  : "";
						_gdnc += result.coupnUseGdnc2  != null ? "\r\n" + result.coupnUseGdnc2  : "";
						_gdnc += result.coupnUseGdnc3  != null ? "\r\n" + result.coupnUseGdnc3  : "";
						_gdnc += result.coupnUseGdnc4  != null ? "\r\n" + result.coupnUseGdnc4  : "";
						_gdnc += result.coupnUseGdnc5  != null ? "\r\n" + result.coupnUseGdnc5  : "";
						_gdnc += result.coupnUseGdnc6  != null ? "\r\n" + result.coupnUseGdnc6  : "";
						_gdnc += result.coupnUseGdnc7  != null ? "\r\n" + result.coupnUseGdnc7  : "";
						_gdnc += result.coupnUseGdnc8  != null ? "\r\n" + result.coupnUseGdnc8  : "";
						_gdnc += result.coupnUseGdnc9  != null ? "\r\n" + result.coupnUseGdnc9  : "";
						_gdnc += result.coupnUseGdnc10 != null ? "\r\n" + result.coupnUseGdnc10 : "";
						
						$("#coupnNmCarWash").val(result.coupnNm);
						$("#coupnDescCarWash").val(result.coupnDesc);
						$("#coupnUseGdncCarWash").val(_gdnc);
					}
					else if(_bnftType == "DC_COUPON") {
						var _gdnc = "";
						_gdnc += result.coupnUseGdnc1  != null ?          result.coupnUseGdnc1  : "";
						_gdnc += result.coupnUseGdnc2  != null ? "\r\n" + result.coupnUseGdnc2  : "";
						_gdnc += result.coupnUseGdnc3  != null ? "\r\n" + result.coupnUseGdnc3  : "";
						_gdnc += result.coupnUseGdnc4  != null ? "\r\n" + result.coupnUseGdnc4  : "";
						_gdnc += result.coupnUseGdnc5  != null ? "\r\n" + result.coupnUseGdnc5  : "";
						_gdnc += result.coupnUseGdnc6  != null ? "\r\n" + result.coupnUseGdnc6  : "";
						_gdnc += result.coupnUseGdnc7  != null ? "\r\n" + result.coupnUseGdnc7  : "";
						_gdnc += result.coupnUseGdnc8  != null ? "\r\n" + result.coupnUseGdnc8  : "";
						_gdnc += result.coupnUseGdnc9  != null ? "\r\n" + result.coupnUseGdnc9  : "";
						_gdnc += result.coupnUseGdnc10 != null ? "\r\n" + result.coupnUseGdnc10 : "";
						
						$("#coupnNmDcCoupon").val(result.coupnNm);
						$("#coupnDescDcCoupon").val(result.coupnDesc);
						$("#dcTypeCdDcCoupon").val(result.dcTypeCd);
						$("#dcAmtDcCoupon").val(result.dcAmt);
						$("#lowstSettlAmtDcCoupon").val(result.lowstSettlAmt);
						$("#coupnUseGdncDcCoupon").val(_gdnc);
					}
					else if(_bnftType == "POINT") {
						$("#acrlTypePoint").val(result.acrlType);
						$("#acrlAmtPoint").val(result.acrlAmt);
						$("#dealStartHourPoint").val(result.dealStartHour);
						$("#dealEndHourPoint").val(result.dealEndHour);
					}
					else if(_bnftType == "DC_FIELD") {
						$("#acrlTypeField").val(result.acrlType);
						$("#acrlAmtField").val(result.acrlAmt);
						$("#lowstSettlAmtDcField").val(result.lowstSettlAmt);
						$("#dealStartHourDcField").val(result.dealStartHour);
						$("#dealEndHourDcField").val(result.dealEndHour);
					}
				}
				
			}
			
			//타겟팅 상세 조회
			if(result.segItem != null && result.segItem.length > 0){
				
// 				//타겟팅 유형 라디오버튼 세팅
// 				var selectBoxValue = null; 
// 				if(result.segItem[0].segType == 'SEG') {
// 					selectBoxValue = 'segement';
// 				} else if(result.segItem[0].segType == 'IMP') {
// 					selectBoxValue = 'upload';
// 				} else if(result.segItem[0].segType == 'CND') {
// 					selectBoxValue = 'condition';
// 				}
// 				$('input:radio[name=targetMethod]:input[value=' + selectBoxValue + ']').trigger('click');
				
				if(result.segItem[0].segType == 'IMP'){ //타겟팅유형 : 파일업로드
					$("#uploadRadio").click();
					$("#importNewPageOpenBtn").click();
				
					
					$("#uploadResult").show();
					
					//결과화면 출력
					$("#savedArea").show();
					$("#importTgtNm").val(result.segItem[0].segName);
					$("#importType").text(result.segItem[0].fileType);
					$("#importResult").text(result.segItem[0].fileName);
					$("#importCnt").text(result.segItem[0].fileTotalCnt+'<spring:message code="M00130"/>');
					
					//최종저장 시 사용 객체
					saveTargetObj.dupCnt = result.dupCnt;
					saveTargetObj.allUploadCnt = result.targetCustCnt;
					saveTargetObj.targetCustCnt = result.targetCustCnt;
					saveTargetObj.fileName = result.segItem[0].fileName;
					saveTargetObj.memberList = result.memberList;
					saveTargetObj.successCnt = result.agreeCust;
					saveTargetObj.failCnt = result.segItem[0].fileFailCnt;
					
// 					$('input:radio[name=memType]:input[value=' + result.segItem[0].memType + ']').attr("checked", true);
					
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
					
				} else if(result.segItem[0].segType == 'SEG'){ //타겟팅유형 : 타겟그룹
					$("#segmentRadio").click();
					
					var targetGroupId = result.segItem[0].targetGroupId;
				    
				    //타겟그룹이 있을경우 타겟그룹 상세 화면 로드
				    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
				        //타겟그룹 상세화면 Load
				        targetGroupMain.targetGroupDetailLoad(targetGroupId);
					}
				} else if(result.segItem[0].segType == 'CND') { //타겟팅유형 : 조건추출
					$("#conditionRadio").click();
					var conditionId = result.segItem[0].conditionId;
				    
				    //조건추출이 있을경우 조건추출 상세 화면 로드
				    if ($.fn.ifvmIsNotEmpty(conditionId)) {
				        //조건추출 상세화면 Load
				        conditionMain.conditionDetailLoad(conditionId);
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
				
				setRequiredTag();
			}
			
			//캠페인이 실행중일 경우 전체 disable
			//[2017.12.29 전화영 추가] 충전소캠페인 결재진행중 또는 결재 승인 완료인 경우 전체 disable
			if(!loadFlag && (result.camStatus != 'W' 
					&& (result.camStatus == 'A' //활성
							|| result.camStatus == 'I' //비활성
							|| result.camStatus == 'S' //중지
							|| result.camStatus == 'C' //취소
							|| result.camStatus == 'E' //완료
							|| result.camStatus == '010' //결재진행중
							|| result.camStatus == '090' //승인완료 
							|| result.camStatus == '091'))){ //강제승인
				
				//저장 및 실행 버튼 숨김
				$("#camSaveBtn").hide();
				$("#segmentNewBtn").hide();
				$("#segmentLoadBtn").hide();
				$("#saveBtn").hide();
				$("#smsTestSendBtn").hide();
				$("#segmentEditBtn").hide();
				$("input[name='targetMethod']").attr('disabled', true);
				$("#saveConditionBtn").hide();
				$("#targetGroupMainSaveBtn").hide();
				$("#targetSaveBtn").hide();
				$("#searchFile").hide();
				$("#bnftRemoveBtn").hide();
				$("input[name='camTypeCd']").attr('disabled', true);
				$("#chnlType").attr('disabled', true);
				$("#bnftType").attr('disabled', true);
				
				//혜정샘이 css 화면 덮어주는거 만들어 주면 적용해야 함
				//[2018.01.04 전화영 추가] 결재진행 시에도 저장 버튼만 막고 화면 덮는 것은 제외
// 				$("#quickAccordion .e-content").addClass("disabledDiv");
			}
			
			
			if(detailFlag == null || detailFlag == 'null'){
				camId = loadCamId;
				loadFlag = false;
			}
		},function(result) {
			$.messageCheckr(result.message);
		},'body','bigsize_progressRoll');
	}
}

//저장
function saveTarget() {
    if (camId != null && camId != '' && camId != 'null') {

        var validationCheck = importValidation.confirm();
        if (validationCheck == true) {
            if (saveTargetObj.memberList != null
                    && saveTargetObj.memberList.length > 0) {

            	$.ifvProgressControl(true);
            	
                saveTargetObj.camId = camId;
                saveTargetObj.segName = $("#importTgtNm").val();
                saveTargetObj.segType = 'IMP';
                saveTargetObj.fileType = $("#fileType").val();
                saveTargetObj.memType = $("#memType").val();

//                 //퀵캠페인 / 캠페인워크플로우 분기
//                 if (typeof campaignSubjectsPopData != "undefined"
//                             && $.fn.ifvmIsNotEmpty(campaignSubjectsPopData.campaignChnlType)) {
//                     //캠페인 워크플로우에서의 세그먼트 유형
//                     saveTargetObj.segType = campaignSubjectsPopData.campaignSegType;
//                     saveTargetObj.chnlType = campaignSubjectsPopData.campaignChnlType;
//                 }

                $.ifvPostJSON('<ifvm:action name="setSegment"/>', saveTargetObj
                , function(result) {
                    segName = result.message;

                    $("#savedArea").show();
                    $("#segNameTxt").text(segName);

                    $.ifvProgressControl(false);
                    
                    alert("<spring:message code='M00990'/>");
//                     $($("#quickAccordion").find('h3')[2]).trigger('click');

//                     //캠페인 워크플로우일 경우
//                     if (workflowFlag) {
//                         //캔버스 저장
//                         campaignTargetingPopSave();
//                     }
                } ,function(result) {
                	$.ifvProgressControl(false);
                    $ .messageCheckr(result.message);
                });
            }
            else {
                alert("<spring:message code='M00708'/>");
            }
        }
        else {
        }
    }
    else {
        alert("<spring:message code='M00710'/>");
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


//충전소캠페인 수정
function editChargingStationCmapaign(){
	
	validation = $("#chargingStationFormArea").ifvValidation();
	
	//해당 충전소캠페인이 작성중'001'인 경우에만 수정 허용
	if(validation.confirm() && (aprvStatus == null || aprvStatus == '' || aprvStatus == 'null' || aprvStatus == '001' )){
		var obj = {};
		
		obj.camId = camId;
		obj.camName = $("#camName").val();
		obj.camDesc = $("#camDesc").val();
		obj.chnlType = $("#chnlType").val();
		obj.startDate = $("#camStDate").val();
		obj.endDate = $("#camEdDate").val();
		obj.camTypeCd = $("input[name='camTypeCd']:checked").val().toUpperCase();
		
		$.ifvSyncPostJSON('<ifvm:action name="updateChargingStationCampaign"/>',obj,
			function(result) {
			camId = result.message;
			alert('<spring:message code="M00624"/>');
			
			//마스터 수정 후 타겟팅 아코디언 열기
// 			$($("#quickAccordion").find('h3')[1]).trigger('click');
		});
	} else {
		alert('<spring:message code="L01819"/>');
	}
}

//충전소캠페인 마스터 저장
function  setChargingStationCampaign(){
	validation = $("#chargingStationFormArea").ifvValidation();
	
	if(validation.confirm()){
		var obj = {};
		
		obj.camName = $("#camName").val();
		obj.camDesc = $("#camDesc").val();
		obj.chnlType = $("#chnlType").val();
		obj.startDate = $("#camStDate").val();
		obj.endDate = $("#camEdDate").val();
		obj.camTypeCd = $("input[name='camTypeCd']:checked").val().toUpperCase();
		
		$.ifvSyncPostJSON('<ifvm:action name="setChargingStationCampaign"/>',obj,
			function(result) {
			if(!result.success) {
				//저장실패
				alert('<spring:message code="M02248"/>');	
			} else if(result.message == 'invalid user') { 
				//세션 내 충전소 코드 미존재시 (icignal 직접 접속으로 판단한다.)
				alert('<spring:message code="S00036"/>');
			} else {
				//저장성공
				camId = result.message;
				alert('<spring:message code="M00623"/>');
				
				//마스터 저장 완료 후 타겟팅 accordion 열기
// 				$($("#quickAccordion").find('h3')[1]).trigger('click');
			}
		});
	}
}

//공통코드 조회 - 채널 유형
function chnlType(){
	$.ifvSyncPostJSON('<ifvm:action name="getChannelType"/>',{
	},function(result) {
		
		var obj = new Array();
		
		//충전소캠페인 채널유형은 SMS, LMS, PUSH, EMAIL, 영수증 만 사용한다.
		for(var i=0; i<result.length; i++) {
			if(		result[i].codeName == 'LMS' 
				|| 	result[i].codeName == 'RECEIPT' 
				|| 	result[i].codeName == 'SMS' ) {
				
				obj.push(result[i]);
			}
		}
		
		obj.push({typeid:'',typeCd:'미사용',codeName:'NA',path:'NA'});
		
		var temp = $("#runChanneltemp").tmpl(obj);
		$("#chnlType").append(temp);
	});
	
}; 

//공통코드 조회 - 할인 유형
function dcTypeCd() {
	$.fn.ifvmSetSelectOptionCommCode("dcTypeCd", "OFFER_DISCOUNT_TYPE_CD", null, null, true);
}

//공통코드 조회 - 포인트 보상 유형
function acrlTypePoint() {
	$.ifvPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'OBJECT_OPER_CODE'
	},function(result){
		var _rows = result.rows;
		var obj = new Array();
		
		for(var i=0; i<_rows.length; i++) {
			if(	_rows[i].codeName == '10' || _rows[i].codeName == '20' ) { //정액(더하기), 정율(곱하기)
				obj.push(_rows[i]);
			}
		}
		
		var temp = $("#benefitTemplate").tmpl(obj);
		$("#acrlTypePoint").append(temp);
	});
}

//공통코드 조회 - 현장할인 보상 유형
function acrlTypeField() {
	$.ifvPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'OBJECT_OPER_CODE'
	},function(result){
		var _rows = result.rows;
		var obj = new Array();
		
		for(var i=0; i<_rows.length; i++) {
			if(	_rows[i].codeName == '40' 
				|| _rows[i].codeName == '50'
				|| _rows[i].codeName == '60'
				|| _rows[i].codeName == '70'
				|| _rows[i].codeName == '80' ) { //리터당정액할인, 총금액정액할인, 리터당고정가, 리터당정률할인, 총금액정률할인
				obj.push(_rows[i]);
			}
		}
		
		var temp = $("#benefitTemplate").tmpl(obj);
		$("#acrlTypeField").append(temp);
	});
}

function accordionSetting(){
	$("#quickAccordion").ejAccordion({
		collapsible: true
		, enableMultipleOpen: true
	});
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
	
	if($("#chnlType").val() != "NA") {
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
			
			if($("#chnlType").val() == 'EMAIL') {
				setTimeout(function(){
					$('#htmlContentsArea_wrapper span[class="e-select"]').css('border-top','0 none');
					$('#htmlContentsArea_wrapper span[class="e-select"]').css('background-color','transparent');
					$("#htmlContentsArea_wrapper button").css('border-top','0 none');
					$("#htmlContentsArea_wrapper button").css('background-color','transparent');
				}, 2000);
			}
		}
	} else {
// 		$('#saveBtn').off('click'); //기존이벤트 제거 
// 		$("#saveBtn").on('click',function() {
// 			alert('<spring:message code="L00173"/>');
// 		});
	}
	
	setRequiredTag();
}

function setRequiredTag() {
	$("#selectForm #contentsName").attr("required", false);
	$("#selectForm #title").attr("required", false);
	$("#selectForm span[class='asterisk']").remove();
	$("#loadContentsBtn").remove();
	$("#schedulingBtn").remove();
	$("#contentsMessage .page_btn_area .searchbtn_r").append("<button class='btn btn-sm btn_gray' id='loadContentsBtn'><spring:message code='M00612'/></button>");
	$("#contentsMessage .page_btn_area .searchbtn_r").append("<button class='btn btn-sm btn_gray' id='schedulingBtn' style='margin-left:4px'><spring:message code='S00053'/></button>");
	
	loadContentsBtnEventSetting();
	
	$("#schedulingBtn").on('click', function() {
		if(camId != null && camId != 'null'){
			$("#schedulingPopup").ifvsfPopup({
				enableModal : true,
				enableResize: false,
				contentUrl: '<ifvm:url name="stnSchedulingPopup"/>',
				contentType: "ajax",
				title: '발송일정 수립(스케쥴링)',
				width: 900,
				close : 'schedulingPopupClose'
			});
		} else {
			alert('<spring:message code="C00147"/>');
			
		}
	});
}

//채널유형에 따른 대상고객 라디오 세팅
//-- SMS/LMS 유형의 경우 모든고객을 대상으로 할 수 없다. (MASS 캠페인 불가능)
function camTypeCdSetting() {
	var _chnlType = $("#chnlType").val(); 
	if( _chnlType == "LMS" || _chnlType == "SMS") {
		$("#camTypeCdTarget").trigger('click');
		$("#camTypeCdMass").attr('disabled', 'disabled');
	} else {
		$("#camTypeCdMass").removeAttr('disabled');
	}
	
	targetMethodSetting();
}

//채널유형에 따른 가능혜택 세팅
//-- 영수증 유형의 경우 현장할인 이외에는 불가능
function enableBenefitSetting() {
	var _chnlType = $("#chnlType").val();
	if( _chnlType == "RECEIPT" ) {
		$("#bnftType").children().each(function(idx,item) {
			var _item = $(item);
			//채널유형 '영수증'의 경우 현장할인 혜택만 가능하다.
			if(_item.attr("id") == "DC_FIELD") { 
				_item.removeAttr('disabled');
			} else {
				_item.attr('disabled', 'disabled');
			}
		});
	} else {
		$("#bnftType").children().each(function(idx,item) {
			var _item = $(item);
			_item.removeAttr('disabled');
		});
	}
}

//대상고객유형에 따른 타겟팅방법 세팅
//대상고객 - 모든고객일 경우 타겟팅방법 '모든고객' 만 가능
//대상고객 - 특정고객일 경우 타겟팅방법 '목록에서선택','조건추출','업로드'만 가능
function targetMethodSetting() {
	if( $("#camTypeCdMass").is(":checked") ) {
		$("#massRadio").removeAttr('disabled');
		$("#massRadio").trigger('click');
		
		$("#segmentRadio").attr('disabled', 'disabled');
		$("#conditionRadio").attr('disabled', 'disabled');
		$("#uploadRadio").attr('disabled', 'disabled');
		
		$("#segmentConArea").hide();
		$("#conditionConArea").hide();
		$("#uploadConArea").hide();
		$("#massConArea").show();
	} else {
		$("#segmentRadio").removeAttr('disabled');
		$("#segmentRadio").trigger('click');
		
		$("#massRadio").attr('disabled', 'disabled');
		$("#conditionRadio").removeAttr('disabled');
		$("#uploadRadio").removeAttr('disabled');
	}
}

//혜택유형 목록 세팅
function bnftTypeSelectBoxSetting() {
	var obj = [];
	
	obj.push(	{codeName:'NA'			,markName:'<spring:message code="M01898"/>'}	);
	obj.push(	{codeName:'CAR_WASH'	,markName:'<spring:message code="S00057"/>'}	);
	obj.push(	{codeName:'DC_COUPON'	,markName:'<spring:message code="S00058"/>'}	);
	obj.push(	{codeName:'POINT'		,markName:'<spring:message code="S00059"/>'}	);
	obj.push(	{codeName:'DC_FIELD'	,markName:'<spring:message code="S00060"/>'}	);
	
	var temp = $("#benefitTemplate").tmpl(obj);
	$("#bnftType").append(temp);
}

//최초로드시 혜택상세 영역 모두 숨김처리
function bnftDetailSetting() {
	var _bnftType = $("#bnftType").val().toLowerCase() + "_DetailCon";
	
	$("#bnftDetailCon .well_sum").each(function(idx, e) {
		var _this = $(e);
		if( _bnftType != _this.attr('id') ) {
			_this.hide();
		} else {
			_this.show();
		}
	});
}

//타겟팅 Main Load
function targetingLoad(){
	$.fn.ifvmLoadUiSetting("targetingContents", '<ifvm:url name="stnTargetingMain"/>');
}

/* 팝업 닫기 */
function loadPopupClose(){
	loadContentsPopup._destroy();
}

/* 결재 팝업 닫기 */
function approvalPopupClose(){
	approvalPopup._destroy();
}

/* 오퍼(=혜택) 목록 팝업 닫기 */
function offerListPopupClose() {
	offerListPopup._destroy();
}

function schedulingPopupClose() {
	schedulingPopup._destroy();
}

/**
 * 메시지 불러오기 버튼 클릭 시
 * 발송채널 설정되지 않은 경우 팝업 대신 validationBox 호출
 */
function loadContentsBtnEventSetting() {
	//메시지 불러오기 버튼 클릭 시
	$('#loadContentsBtn').on('click', function(){
		
		//캠페인마스터 저장여부 우선 체크
		if(camId == null || camId == '') {
			alert('<spring:message code="M00855"/>');
			return false;
		}
		
		//발송채널 선택 여부 체크
		if($("#chnlType").val() == "NA") {
			if(!$($("#quickAccordion").find('h3')[0]).hasClass('e-active')) {
				$($("#quickAccordion").find('h3')[0]).trigger('click');
			}
			setTimeout(function(){
				$.ifvCallValidationBox($("#chnlType"), '발송채널을 선택해주세요.');
			}, 1000);
			return false;
		}
		
		$("#loadContentsPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTContentsListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00371"/>',
	        width: 600,
	        close : 'loadPopupClose'
	    });
	});
}

/**
 * 거래일시 세팅 (0-24) 
 */
function setDealSelectBoxSetting() {
	var _obj = [];
	var _i = ""
	for(var i=0; i<25; i++) {
		_i = i.toString().length < 2 ? "0"+i : i.toString();
		_obj.push({codeName : _i, markName : _i})
	}
	
	$("#dealStartHourPoint").append($("#offerCommCodeTemp").tmpl(_obj));
	$("#dealEndHourPoint").append($("#offerCommCodeTemp").tmpl(_obj));
	$("#dealStartHourDcField").append($("#offerCommCodeTemp").tmpl(_obj));
	$("#dealEndHourDcField").append($("#offerCommCodeTemp").tmpl(_obj));
}

/**
 * 쿠폰 사용안내 입력 글자수를 제한한다. 100Byte*10Line
 *
 * @param input (input 영역 id)
 */
function setCoupnUseGdncLength(input) {
	$("#" + input).on('keyup', function() {
		var checkedText = "";
		var _gdnc = $("#" + input).val().split("\n");
		var _gdncNew = [];
		$.each(_gdnc, function(idx, item) {
			if(item.length > 100) {
				_gdncNew.push(item.substring(0, 100));
			} else {
				_gdncNew.push(item);
			}
		})
		
		$.each(_gdncNew, function(idx, item) {
			if(idx < 10) {
				if(idx == 0) {
					checkedText += item;
				} else {
					checkedText += "\n" + item;
				}
			}
		}) 
		
		$("#" + input).val(checkedText);
	});
}

$(document).ready(function(){
	$.ifvmLnbSetting('stnCampaignList');
	
	$("#chargingStationFormArea").ifvValidation();
	
	setChannelCalendar();
	
	setDealSelectBoxSetting();
	
	//공통코드 조회 - 채널유형
	chnlType();
	
	//공통코드 조회 - 할인유형
	dcTypeCd();
	
	//공통코드 조회 - 포인트 보상 유형
	acrlTypePoint();
	
	//공통코드 조회 - 현장할인 보상 유형
	acrlTypeField();
	
	//혜택유형 세팅
	bnftTypeSelectBoxSetting();
	
	//혜택상세 세팅 (초기로드시 선택된 혜택유형의 상세영역을 제외하고 모든 혜택상세영역 모두 숨김처리한다.)
	bnftDetailSetting();
	
	setCoupnUseGdncLength("coupnUseGdncCarWash");
	setCoupnUseGdncLength("coupnUseGdncDcCoupon");
	
	//타겟팅 로드
	targetingLoad();
	
	//캠페인 목록버튼 클릭 시
	$("#camListBtn").on('click', function(){
		qtjs.href('<ifvm:url name="stnCampaignList"/>');
	});
	
	//캠페인 결재
	$("#camApproBtn").on('click', function(){
		if(camId != null && camId != 'null'){
			$("#approvalPopup").ifvsfPopup({
				enableModal : true,
				enableResize: false,
				contentUrl: '<ifvm:url name="stnApprovalPopup"/>',
				contentType: "ajax",
				title: '<spring:message code="L01444"/>',
				width: 900,
				close : 'approvalPopupClose'
			});
		}
		else{
			alert('<spring:message code="C00147"/>');
		}
		
	});
	
	//채널 변경 시 혜택 및 메시지 내용 변경, SMS/LMS 의 경우 MASS 캠페인 불가능으로 모든고객 라디오버튼 disabled
	$("#chnlType").on('change', function(){
		contentsLoad();
		camTypeCdSetting();
		enableBenefitSetting();
	});
	
	$("input[name='camTypeCd']").on('change', function() {
		//모든 고객 (MASS 캠페인) 선택 시 
		if($("#camTypeCdMass").is(":checked")) {
			if(confirm('<spring:message code="S00070"/>')) {
				$.ifvProgressControl(true);
				$.ifvPostJSON('<ifvm:action name="removeTargeting"/>', {
					camId : camId
		        }, function(result) { //callback
		            $.ifvProgressControl(false);
		        }, function(result) { //errorCallback
		        	$.ifvProgressControl(false);
		        });
			} else {
				$("#camTypeCdTarget").attr('checked', true);
			}
		}
		camTypeCdSetting();
		enableBenefitSetting();
	})
	
	//충전소캠페인 저장버튼 클릭 시
	$("#camSaveBtn").on('click', function(){
		
		if(camId != null && camId != '' && camId != 'null'){
			editChargingStationCmapaign();
		}
		else{
			setChargingStationCampaign();
		}
		
		initCampaign(segId);
		
	});
	
	$("#bnftType").on('change', function() {
		bnftDetailSetting();
	});
	
	//혜택 선택 초기화
	$("#bnftRemoveBtn").on('click', function() {
		if( camId == null || camId == 'null' ) {
			alert('<spring:message code="C00147"/>');
			return false;
		}
		
		//등록된 혜택 삭제 확인
		if( confirm('<spring:message code="S00056"/>') ) {
			var _obj = {};
			_obj.bnftTypeCd = "NA";
			_obj.chnlType = "NA";
			_obj.camId = camId;
			_obj.isReset = 1; //초기화시 컨텐츠 관계 삭제되지 않기 위한 구분값
			
			var progress = $.ifvLoading($("#bnftRemoveBtn"));
			
			$.ifvPostJSON('<ifvm:action name="setChargingStationOffer"/>', _obj
			,function(result) {
				if(result.errorType == 1) {
					alert('<spring:message code="L00034"/>');
				} else if(result.errorType == 2) {
					alert('<spring:message code="L00034"/>');
				} else {
					alert('<spring:message code="V00219"/>');
					initCampaign(segId);
					$("#bnftType").val("NA");
					$("#bnftType").change();
				}
				
				$(progress).remove();
				$("#bnftRemoveBtn").removeAttr('disabled');
			});
			
		} else {
			return false;
		}
	});
	
	$("#uploadConArea").hide();
	
	//최초 저장 시 캠페인기간 오늘날짜 이전 선택 못하도록 세팅
	if(camId == null) {
		var date = new Date();
		date.setDate(date.getDate() + 1);
		date = $.ifvFormatDate('yyyy-mm-dd', date)
		$("#camStDate").val(date);
		$("#camEdDate").val(date);
		$("#camStDate").ifvDateChecker({minDate:date});
	}
	
	//캠페인 정보 조회
	initCampaign(segId);
	
	//컨텐츠 로드
	contentsLoad();
	
	//아코디언 셋팅
	accordionSetting();
	
	$($("#quickAccordion").find('h3')[1]).on('click', function() {
		try {
			//2018.01.24 hy.jun 타겟팅방법에 따라 각각의 그리드 setWidth하도록 분기처리
			if($("input:radio[name='targetMethod']:checked").val() == 'segment') {
				targetGroupTargetListGrid.setWidth($('#targetGroupTargetListGrid').width());
			} else if($("input:radio[name='targetMethod']:checked").val() == 'condition') {
				conditionDetailGrid.setWidth($('#conditionDetailGrid').width());
			} else if($("input:radio[name='targetMethod']:checked").val() == 'upload') {
				uploadMemberInfoGrid.setWidth($('#uploadMemberInfoGrid').width());
			}
		} catch(e) {
			
		}
	});
	
	$('#quickAccordion h3').css('padding-top','.2em');
	$('#quickAccordion h3').css('padding-bottom','.2em');
});

$("#chargingStationFormArea").removeClass("disabledDiv");
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

<script id="chnlTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script> 

<script id="offerCommCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
input[type=text].skip{display:none;}
.user_main_area .main_area.main2{border-bottom:0;}
.defaultInfo{
    background-color: transparent !important;
    background: transparent !important;
    border-bottom: 1px solid #cccccc;
    padding-left: 0px;
}
.borderBottomNone {border-bottom:0 none;}

textarea {
/* 	font-size:11px; */
	color:#555;
}

textarea::-webkit-input-placeholder {
color: #8EC0E4;
}
textarea:-moz-placeholder { /* Firefox 18- */
color: #666666;  
}
textarea::-moz-placeholder {  /* Firefox 19+ */
color: #666666;  
}
textarea:-ms-input-placeholder {
color: #666666;  
}
</style>


<div class="page-title">
	<h1>
		<spring:message code="S00001"/>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="S00001"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<div class="col-xs-5 searchbtn_r" style="float:right;">
			<button class="btn btn-sm" id="camApproBtn">
				<spring:message code="S00004"/>
			</button>
			<button class="btn btn-sm" id="camListBtn">
				<spring:message code="M01103"/>
			</button>
		</div>
	</div>
</div>

 <div id="quickAccordion">
     <h3>
         <a href="#"><spring:message code="M00604"/></a>
     </h3>
     <div id='chargingStationFormArea'>
     	<div class="campaign_load_contents">
			<div>
				<div class="page_btn_area defaultInfo">
					<div class="col-xs-7">
						<span><spring:message code="M00604"/></span>
					</div>
					<div class="col-xs-5 searchbtn_r">
						<button class="btn btn-sm" id="camSaveBtn">
							<spring:message code="M00280"/>
						</button>
					</div>
				</div>
			</div>	     
		     
		     <div class="well form-horizontal well_sum">
				<div class="row qt_border">
		         	<label class="col-sm-2 control-label"><spring:message code="S00048"/></label>
		         	<div class="col-sm-4">
						<ifvm:input type="text" id="camDispNo" disabled="true"/>	
					</div>
				</div>
		         <div class="row qt_border">
		         	<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00005"/></label>
		         	<div class="col-sm-4">
						<ifvm:input type="text" id="camName" required="true" maxLength="50"/>	
					</div>
		         	<label class="col-sm-2 control-label"><spring:message code="S00006"/></label>
		         	<div class="col-sm-3">
						<ifvm:input type="text" id="camStatus" disabled="true"/>	
					</div>
		         </div>
		         <div class="row qt_border">
<%-- 		         	<label class="col-sm-2 control-label"><spring:message code="L00795"/></label> --%>
<!-- 		         	<div class="col-sm-9"> -->
<!-- 		         		<textarea id="camDesc" rows="3" maxLength="250"></textarea> -->
		         		<ifvm:inputNew type="textarea" id="camDesc" rows="3" maxLength="250" label="L00795" labelClass="2" conClass="9"/>
<!-- 		         	</div> -->
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
					<label class="col-sm-8 control-label"><span class="asterisk">*</span><spring:message code="S00051"/></label>
		         	<div class="col-sm-3">
						<label class="radio-inline">
							<ifvm:input type="radio" names="camTypeCd" values="mass" checked="true" id="camTypeCdMass" />
							<spring:message code="S00049"/>
						</label>
						<label class="radio-inline">
							<ifvm:input type="radio" names="camTypeCd" values="target" checked="true" id="camTypeCdTarget" />
							<spring:message code="S00052"/>
						</label>
					</div>
		         </div>
		     </div>
		</div>     
     </div>
     <h3>
         <a href="#"><spring:message code="S00051"/></a>
     </h3>
     <div class="well form-horizontal well_sum">
         <div id="targetingContents" class="campaign_load_contents border_style"></div>
     </div>
     <h3>
         <a href="#"><spring:message code="M00610"/></a>
     </h3>
     <!-- 혜택 영역 -->
     <div class="well form-horizontal well_sum">
	     <div class="row qt_border">
			<!-- 혜택유형 -->
			<div class="page_btn_area">
				<div class="col-xs-7"><span><spring:message code="S00054"/></span></div>
			</div>
			<div class="well form-horizontal well_sum">
				<div class="row qt_border">
					<label class="col-sm-2 control-label"><spring:message code="S00054"/></label>
					<div class="col-xs-3">
						<ifvm:input type="select" id="bnftType"/>
					</div>
					<button class="btn btn-sm" style="margin-left:10px;" id="bnftRemoveBtn"><spring:message code="M01005"/></button>
				</div>
			</div>
			<!-- 헤택상세 -->
			<div class="well form-horizontal well_wrap pad0 borderBottomNone" id="bnftDetailCon">
				<div class="page_btn_area">
					<div class="col-xs-7"><span><spring:message code="S00055"/></span></div>
				</div>
				<!-- 무료세차권 상세 -->
				<div class="well form-horizontal well_sum" id="car_wash_DetailCon">
					<!-- 제목 -->
					<div class="row qt_border">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00061"/></label>
						<div class="col-xs-9">
							<ifvm:input type="text" id="coupnNmCarWash" maxLength="50" required="true"/>
						</div>
					</div>
					<!-- 내용 -->
					<div class="row qt_border">
<%-- 						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00062"/></label> --%>
<!-- 						<div class="col-xs-9"> -->
							<ifvm:inputNew type="textarea" id="coupnDescCarWash" rows="2" maxLength="100" required="true" label="S00062" labelClass="2" conClass="9"/>
<!-- 						</div> -->
					</div>
					<!-- 쿠폰사용안내 -->
					<div class="row">
<%-- 						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00067"/></label> --%>
<!-- 						<div class="col-xs-9"> -->
							<ifvm:inputNew type="textarea" id="coupnUseGdncCarWash" rows="5" maxLength="1000" required="true" placeholder="S00068" label="S00067" labelClass="2" conClass="9"/>
<!-- 						</div> -->
					</div>
				</div>
				<!-- 할인쿠폰 상세 -->
				<div class="well form-horizontal well_sum" id="dc_coupon_DetailCon">
					<!-- 제목 -->
					<div class="row qt_border">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00061"/></label>
						<div class="col-xs-9">
							<ifvm:input type="text" id="coupnNmDcCoupon" maxLength="50" required="true"/>
						</div>
					</div>
					<!-- 내용 -->
					<div class="row qt_border">
<%-- 						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00062"/></label> --%>
<!-- 						<div class="col-xs-9"> -->
							<ifvm:inputNew type="textarea" id="coupnDescDcCoupon" rows="2" maxLength="100" required="true" label="S00062" labelClass="2" conClass="9"/>
<!-- 						</div> -->
					</div>
					<!-- 쿠폰사용안내 -->
					<div class="row qt_border">
<%-- 						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="S00067"/></label> --%>
<!-- 						<div class="col-xs-9"> -->
							<ifvm:inputNew type="textarea" id="coupnDescDcCoupon" rows="2" maxLength="100" required="true" label="S00062" labelClass="2" conClass="9"/>
<!-- 						</div> -->
					</div>
					<!-- 할인유형 -->
					<div class="row qt_border">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M00320"/></label>
						<div class="col-xs-1">
							<ifvm:input type="select" id="dcTypeCdDcCoupon" names="dcTypeCd"/>
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M00321"/></label>
						<div class="col-xs-1">
							<ifvm:input type="number" id="dcAmtDcCoupon" required="true"/>
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M02278"/></label>
						<div class="col-xs-1">
							<ifvm:input type="number" id="lowstSettlAmtDcCoupon" required="true"/>
						</div>
					</div>
				</div>
				<!-- 포인트 상세 -->
				<div class="well form-horizontal well_sum" id="point_DetailCon">
					<div class="row qt_border">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M02338"/></label>
						<div class="col-xs-1">
							<ifvm:input type="select" id="acrlTypePoint" names="acrlTypePoint" />
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M02339"/></label>
						<div class="col-xs-1">
							<ifvm:input type="number" required="true" id="acrlAmtPoint" names="acrlAmtPoint" />
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="L00604"/></label>
						<div class="col-xs-1" style="padding-right:13px;">
							<ifvm:input type="select" id="dealStartHourPoint" names="dealStartHourPoint"/>
						</div>
						<div class="col-xs-1 swung_dash">~</div>
						<div class="col-xs-1" style="padding-left:13px;">
							<ifvm:input type="select" id="dealEndHourPoint" names="dealEndHourPoint"/>
						</div>
					</div>
				</div>
				<!-- 현장할인 상세 -->
				<div class="well form-horizontal well_sum" id="dc_field_DetailCon">
					<div class="row qt_border">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="M02338"/></label>
						<div class="col-xs-2">
							<ifvm:input type="select" id="acrlTypeField" names="acrlTypeField" />
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M02339"/></label>
						<div class="col-xs-1">
							<ifvm:input type="number" required="true" id="acrlAmtField" names="acrlAmtField" />
						</div>
						<label class="col-sm-1 control-label"><span class="asterisk">*</span><spring:message code="M02278"/></label>
						<div class="col-xs-1">
							<ifvm:input type="number" required="true" id="lowstSettlAmtDcField" names="lowstSettlAmtDcField" />
						</div>
					</div>
					<div class="row">
						<label class="col-sm-2 control-label"><span class="asterisk">*</span><spring:message code="L00604"/></label>
						<div class="col-xs-1" style="padding-right:13px;">
							<ifvm:input type="select" id="dealStartHourDcField" names="dealStartHourDcField"/>
						</div>
						<div class="col-xs-1 swung_dash">~</div>
						<div class="col-xs-1" style="padding-left:13px;">
							<ifvm:input type="select" id="dealEndHourDcField" names="dealEndHourDcField"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="contentsMessage" class="campaign_load_contents"></div>
	</div>
</div>


<div id="loadContentsPopup" class="popup_container"></div>
<div id="approvalPopup" class="popup_container"></div>
<div id="offerListPopup" class="popup_container"></div>
<div id="schedulingPopup" class="popup_container"></div>