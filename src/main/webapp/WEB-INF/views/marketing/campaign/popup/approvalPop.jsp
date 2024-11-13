<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
	var approvalPopup;

	var campaignApprovalData = {
		campaignInfo: {},
		campaignApproval: {}
	};

	//approvalPopupInitData
	function approvalPopupInitData() {
		campaignApprovalData = {
			campaignInfo: {},
			campaignApproval: {}
		};

		//캠페인 ID
		campaign.id = campaignListGrid.opt.gridControl.getSelectedRecords()[0].id;

		//캠페인기본정보 호출
		$.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
					id: campaign.id
				},
				function(result) {
					if ($.fn.ifvmIsNotEmpty(result)){
						campaignApprovalData.campaignInfo = result;
					}
				});

		//load 승인 폼
		loadApproval();
	}

	//load시 필요없는 항목 제거
	function approvalLoadUiSetting(){
		$('#approvalPopCon .page-title').remove();
		$('#approvalPopCon .page_btn_area:first').css({'border-top':'0'});
		$('#approvalPopCon .well').css({'margin-bottom':'0','border-bottom':'0'});
		//버튼 숨기기
		$("#approvalDetailBtnDiv").hide();
		$("#btnCampop").hide();

		setApprovalPopButton();
	}

	//전자결재 상태에 따른 버튼 설정
	function setApprovalPopButton() {
		//$("#approvalPopupAprvsendBtn").hide();
		//$("#approvalPopupSangsinCancelBtn").hide();

		setTimeout(function(){
			if (approvalDetailData.status == '001') {
				//작성중
				$("#approvalPopupAprvsendBtn").show();        //결재상신
				$("#approvalPopupSangsinCancelBtn").show();   //작성취소
			}
			else if (approvalDetailData.status == '010'
					|| approvalDetailData.status == '020'
					|| approvalDetailData.status == '090') {
				//결재상신 || 결재반려
				//$("#approvalPopupSaveBtn").hide();
			}
		}, 600);
	}

	//load 전자결재 등록화면
	function loadApproval() {

		//call 전자결재 조회
		var id = "null";
		$.ifvSyncPostJSON('<ifvm:action name="getCampaignApproval"/>', {
					campaignId: campaign.id
				},
				function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						id = result.approvalId;
						campaignApprovalData.campaignApproval = result;
					}
				});

		var obj = $.ifvCachedHtml('<ifvm:url name="loadApprovalDetail"/>?&id='+id);
		$('#approvalPopCon').html(obj.responseText);

		//승인대상 캠페인 지정
		$("#camId").text(campaignApprovalData.campaignInfo.id);
		$("#camId").val(campaignApprovalData.campaignInfo.campaignName);
		$("#camContent").val(campaignApprovalData.campaignInfo.description);
		$("#camContent").attr("disabled","true");

		approvalLoadUiSetting();
	}

	//승인 저장
	function approvalPopupSaveBtn() {
		//form 저장 버튼 클릭
		$("#btnSave").trigger("click");

		//저장 후 결재 아이디 확인
		var approvalId = chid;
		if ($.fn.ifvmIsNotEmpty(approvalId) && approvalId != "null") {
			campaignApprovalData.campaignApproval.approvalId = approvalId;

			/*diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
            diagram._selectedObject.data.campaignApproval = campaignApprovalData.campaignApproval;
            diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignApprovalData.campaignApproval);*/
		}

		setApprovalPopButton();
	}

	//결재상신
	function approvalPopupAprvsendBtn() {
		//form 저장 버튼 클릭
		$("#btnsend").trigger("click");

		//결재상신 후 결재 아이디 확인
		var approvalId = chid;
		if ($.fn.ifvmIsNotEmpty(approvalId) && approvalId != "null") {
			campaignApprovalData.campaignApproval.approvalId = approvalId;

			diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
			diagram._selectedObject.data.campaignApproval = campaignApprovalData.campaignApproval;
			diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignApprovalData.campaignApproval);
		}

		setApprovalPopButton();

	}

	//작성취소
	function approvalPopupSangsinCancelBtn() {
		$("#cancle").trigger("click");

		//작성취소 후 결재 아이디 확인
		var approvalId = chid;
		if ($.fn.ifvmIsNotEmpty(approvalId) && approvalId != "null") {
			campaignApprovalData.campaignApproval.approvalId = approvalId;

			diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
			diagram._selectedObject.data.campaignApproval = campaignApprovalData.campaignApproval;
			diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignApprovalData.campaignApproval);
		}

		setApprovalPopButton();
	}

	function empTypeChk(){
		if(empType != 'H'){
			$('#setAprv').hide();
			$('#aprvAdd').hide();
			$('#aprvDel').hide();
		}
	}

	$(document).ready(function () {

		approvalPopupInitData();


		//본사&매장 체크
		setTimeout(function(){
			empTypeChk();
		},100 );

		//콘텐츠 불러오기 시 실행
		$('#loadContentsBtn').on('click', function() {
			loadContentsBtn();
		});

		//신규 작성 클릭시
		$('#contentsDesignNewBtn').on('click', function() {
			loadContentsDesign();
		});

		//저장 클릭시
		$('#approvalPopupSaveBtn').on('click', function() {
			approvalPopupSaveBtn();
		});

		//결재상신 클릭시
		$('#approvalPopupAprvsendBtn').on('click', function() {

			//장용 추가 - 결재상신 버튼 클릭 시 결재자가 없을 경우 메시지 처리
			if (approverListGrid != null && approverListGrid.getRowData().length > 0) {
				approvalPopupSaveBtn();
				approvalPopupAprvsendBtn();
			}
			else {
				alert('<spring:message code="M00995"/>');
			}

		});

		//작성취소 클릭시
		$('#approvalPopupSangsinCancelBtn').on('click', function() {
			approvalPopupSangsinCancelBtn();
		});

		//취소 클릭시
		$('#approvalPopupCancelBtn').on('click', function() {
			approvalPopClose();
		});

	});
</script>

<div id="dialogPopupWrap">
	<input type="hidden" id="contentsType" value="">
	<input type="hidden" id="campaignWorkflowFlag" value="true">

	<div class="pop_inner_wrap form-horizontal">
		<div class="row" id="approvalPopCon">
		</div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" style="display:none;" id="approvalPopupAprvsendBtn" objCode="approvalPopupAprvsendBtn_OBJ">
			<spring:message code="M00987" />
		</button>
		<%--<button class="btn btn-sm btn_gray" id="approvalPopupSaveBtn" objCode="approvalPopupSaveBtn_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M01784"/>
		</button>--%>
		<%--	    <button class="btn btn-sm btn_lightGray2" style="display:none;" id="approvalPopupSangsinCancelBtn" objCode="approvalPopupSangsinCancelBtn_OBJ">
                    <spring:message code="M00940" />
                </button>--%>
		<button class="btn btn-sm btn_lightGray2 cancel" id="approvalPopupCancelBtn" objCode="approvalPopupCancelBtn_OBJ">
			<spring:message code="M00441"/>
		</button>
	</div>
</div>