<%@ tag body-content="empty" pageEncoding="UTF-8"
	description="Java Controller 호출 태그"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<c:set var="nameValue" value="${name}" />

<c:choose>
	<%-- Login --%>
	<c:when test="${nameValue == 'MKTLogin'}">${pageContext.request.contextPath}/login/loginConfirm.do</c:when>
	<c:when test="${nameValue == 'getCrmUserIp'}">${pageContext.request.contextPath}/login/getCrmUserIp.do</c:when>
	<c:when test="${nameValue == 'MKTLogout'}">${pageContext.request.contextPath}/common/logout.do</c:when>
	<c:when test="${nameValue == 'transCertiSms'}">${pageContext.request.contextPath}/login/transCertiSms.do</c:when>
	<c:when test="${nameValue == 'checkTransCetiSms'}">${pageContext.request.contextPath}/login/checkTransCetiSms.do</c:when>
	 <%--<c:when test="${nameValue == 'MKTvalidEmailPwd'}">${pageContext.request.contextPath}/login/MKTvalidEmailPwd.do</c:when>--%>
	<c:when test="${nameValue == 'checkTelNum'}">${pageContext.request.contextPath}/login/checkTelNum.do</c:when>
	<c:when test="${nameValue == 'initPassword'}">${pageContext.request.contextPath}/login/initPassword.do</c:when>
	<c:when test="${nameValue == 'checkOperationPolicyInitPw'}">${pageContext.request.contextPath}/login/checkOperationPolicyInitPw.do</c:when>

	<%-- grid Excel Export --%>
	<c:when test="${nameValue == 'gridExcelExport'}">${pageContext.request.contextPath}/base/gridExcelExport.do</c:when>

	<%-- EncryptAES --%>
	<c:when test="${nameValue == 'MKTEncryptAes'}">${pageContext.request.contextPath}/base/getEncryptAES.do</c:when>
	<c:when test="${nameValue == 'getEncrypt'}">${pageContext.request.contextPath}/base/getEncrypt.do</c:when>

	<%--운영 관리 --%>
	<c:when test="${nameValue == 'getMenuFront'}">${pageContext.request.contextPath}/marketing/manage/getMenuFront.do</c:when>
	<c:when test="${nameValue == 'getMenuProgList'}">${pageContext.request.contextPath}/marketing/manage/getMenuProgList.do</c:when>
	<%-- <c:when test="${nameValue == 'getBusinessField'}">${pageContext.request.contextPath}/system/account/getBusinessField.do</c:when> --%>
	<c:when test="${nameValue == 'delProgramList'}">${pageContext.request.contextPath}/marketing/manage/delProgramList.do</c:when>

	<c:when test="${nameValue == 'getProgramList'}">${pageContext.request.contextPath}/marketing/manage/getProgramList.do</c:when>
	<c:when test="${nameValue == 'addProgramList'}">${pageContext.request.contextPath}/marketing/manage/addProgramList.do</c:when>
	<c:when test="${nameValue == 'getProgramDetail'}">${pageContext.request.contextPath}/marketing/manage/getProgramDetail.do</c:when>
	<c:when test="${nameValue == 'getOwnerProgList'}">${pageContext.request.contextPath}/marketing/manage/getOwnerProgList.do</c:when>
	<c:when test="${nameValue == 'getOwnerList'}">${pageContext.request.contextPath}/marketing/manage/getOwnerList.do</c:when>
	<c:when test="${nameValue == 'getOwnerGroup'}">${pageContext.request.contextPath}/marketing/manage/getOwnerGroup.do</c:when>
	<c:when test="${nameValue == 'delOwnerProgList'}">${pageContext.request.contextPath}/marketing/manage/delOwnerProgList.do</c:when>
	<c:when test="${nameValue == 'delOwnerList'}">${pageContext.request.contextPath}/marketing/manage/delOwnerList.do</c:when>
	<c:when test="${nameValue == 'getAuthGroup'}">${pageContext.request.contextPath}/marketing/manage/getAuthGroup.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupType'}">${pageContext.request.contextPath}/marketing/manage/getAuthGroupType.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupDetail'}">${pageContext.request.contextPath}/marketing/manage/getAuthGroupDetail.do</c:when>
	<c:when test="${nameValue == 'delMenuListProg'}">${pageContext.request.contextPath}/marketing/manage/delMenuListProg.do</c:when>
	<c:when test="${nameValue == 'addMenuList'}">${pageContext.request.contextPath}/marketing/manage/addMenuList.do</c:when>
	<c:when test="${nameValue == 'updateSortMenu'}">${pageContext.request.contextPath}/marketing/manage/updateSortMenu.do</c:when>
	<c:when test="${nameValue == 'getMenuList'}">${pageContext.request.contextPath}/marketing/manage/getMenuList.do</c:when>
	<c:when test="${nameValue == 'getSystem'}">${pageContext.request.contextPath}/marketing/manage/getSystem.do</c:when>
	<c:when test="${nameValue == 'addOwnerProgList'}">${pageContext.request.contextPath}/marketing/manage/addOwnerProgList.do</c:when>
	<c:when test="${nameValue == 'getOwnerProgListPop'}">${pageContext.request.contextPath}/marketing/manage/getOwnerProgListPop.do</c:when>
	<c:when test="${nameValue == 'addOwnerList'}">${pageContext.request.contextPath}/marketing/manage/addOwnerList.do</c:when>
	<c:when test="${nameValue == 'getMenuListPop'}">${pageContext.request.contextPath}/marketing/manage/getMenuListPop.do</c:when>
	<c:when test="${nameValue == 'addMenuListProg'}">${pageContext.request.contextPath}/marketing/manage/addMenuListProg.do</c:when>
	<c:when test="${nameValue == 'getOwnerListPop'}">${pageContext.request.contextPath}/marketing/manage/getOwnerListPop.do</c:when>
	<c:when test="${nameValue == 'deleteMenuList'}">${pageContext.request.contextPath}/marketing/manage/deleteMenuList.do</c:when>
	<c:when test="${nameValue == 'getDataAuthGroup'}">${pageContext.request.contextPath}/marketing/manage/getDataAuthGroup.do</c:when>
	<c:when test="${nameValue == 'getDataOwnerList'}">${pageContext.request.contextPath}/marketing/manage/getDataOwnerList.do</c:when>
	<c:when test="${nameValue == 'getEmpList'}">${pageContext.request.contextPath}/marketing/manage/getEmpList.do</c:when>
	<c:when test="${nameValue == 'getDeptList'}">${pageContext.request.contextPath}/marketing/manage/getDeptList.do</c:when>
	<c:when test="${nameValue == 'addDataAuthOwnerList'}">${pageContext.request.contextPath}/marketing/manage/addDataAuthOwnerList.do</c:when>
	<c:when test="${nameValue == 'delDataAuthOwnerList'}">${pageContext.request.contextPath}/marketing/manage/delDataAuthOwnerList.do</c:when>
	<c:when test="${nameValue == 'delDataAuthGroupList'}">${pageContext.request.contextPath}/marketing/manage/delDataAuthGroupList.do</c:when>
	<c:when test="${nameValue == 'getAccountId'}">${pageContext.request.contextPath}/marketing/manage/getAccountId.do</c:when>

	<%-- 운영관리 - 공통코드관리  --%>
	<c:when test="${nameValue == 'getCommCodeExGroupList'}">${pageContext.request.contextPath}/system/commcode/getCommCodeExGroupList.do</c:when>
	<c:when test="${nameValue == 'getCommCodeExCodeList'}">${pageContext.request.contextPath}/system/commcode/getCommCodeExCodeList.do</c:when>
	<c:when test="${nameValue == 'getCommCodeExParCodeList'}">${pageContext.request.contextPath}/system/commcode/getCommCodeExParCodeList.do</c:when>
	<c:when test="${nameValue == 'addCommCodeExGroupCode'}">${pageContext.request.contextPath}/system/commcode/addCommCodeExGroupCode.do</c:when>
	<c:when test="${nameValue == 'addCommCodeExCodeName'}">${pageContext.request.contextPath}/system/commcode/addCommCodeExCodeName.do</c:when>
	<c:when test="${nameValue == 'editCommCodeExGroupName'}">${pageContext.request.contextPath}/system/commcode/editCommCodeExGroupName.do</c:when>
	<c:when test="${nameValue == 'editCommCodeExCodeProperty'}">${pageContext.request.contextPath}/system/commcode/editCommCodeExCodeProperty.do</c:when>
	<c:when test="${nameValue == 'editCommCodeExCodeAttribProperty'}">${pageContext.request.contextPath}/system/commcode/editCommCodeExCodeAttribProperty.do</c:when>
	<c:when test="${nameValue == 'editCommCodeExGroupCodeDel'}">${pageContext.request.contextPath}/system/commcode/editCommCodeExGroupCodeDel.do</c:when>
	<c:when test="${nameValue == 'editCommCodeExCodeNameDel'}">${pageContext.request.contextPath}/system/commcode/editCommCodeExCodeNameDel.do</c:when>
	<c:when test="${nameValue == 'getCommCodeExCountryCode'}">${pageContext.request.contextPath}/system/commcode/getCommCodeExCountryCode.do</c:when>
	<c:when test="${nameValue == 'reApplyServerCommCode'}">${pageContext.request.contextPath}/system/commcode/reApplyServerCommCode.do</c:when>

	<%-- 캠페인 기획/실행 --%>
	<c:when test="${nameValue == 'getCampaignList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignList.do</c:when>
	<c:when test="${nameValue == 'getCampaignListExcludeMyCam'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignListExcludeMyCam.do</c:when>
	<c:when test="${nameValue == 'setCampaignCancel'}">${pageContext.request.contextPath}/marketing/campaign/setCampaignCancel.do</c:when>
	<c:when test="${nameValue == 'setCampaignStop'}">${pageContext.request.contextPath}/loyalty/campaign/setCampaignStop.do</c:when>
	<c:when test="${nameValue == 'setCampaignActive'}">${pageContext.request.contextPath}/loyalty/campaign/setCampaignActive.do</c:when>
	<c:when test="${nameValue == 'setCampaignComplete'}">${pageContext.request.contextPath}/marketing/campaign/setCampaignComplete.do</c:when>
	<c:when test="${nameValue == 'getTgtChnlChk'}">${pageContext.request.contextPath}/marketing/campaign/getTgtChnlChk.do</c:when>
	<c:when test="${nameValue == 'getOfferDataCheck'}">${pageContext.request.contextPath}/marketing/campaign/getOfferDataCheck.do</c:when>
	<c:when test="${nameValue == 'loadAndGoCampaignExecution'}">${pageContext.request.contextPath}/marketing/campaign/loadAndGoCampaignExecution.do</c:when>
	<c:when test="${nameValue == 'getTgtChnlChk'}">${pageContext.request.contextPath}/loyalty/campaign/getTgtChnlChk.do</c:when>
	<c:when test="${nameValue == 'getConidByCamid'}">${pageContext.request.contextPath}/loyalty/campaign/getConidByCamid.do</c:when>
	<c:when test="${nameValue == 'getFacebookDefaultInfo'}">${pageContext.request.contextPath}/marketing/campaign/getFacebookDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'selectCampaignAuth'}">${pageContext.request.contextPath}/marketing/campaign/selectCampaignAuth.do</c:when>


	<%-- 캠페인 기본정보 --%>
	<c:when test="${nameValue == 'getCampaignDefaultInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getCampaignDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'saveCampaignDefaultInfo'}">${pageContext.request.contextPath}/loyalty/campaign/saveCampaignDefaultInfo.do</c:when>

	<c:when test="${nameValue == 'getCampaignProgramList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignProgramList.do</c:when>
	<c:when test="${nameValue == 'addCampaignProgram'}">${pageContext.request.contextPath}/marketing/campaign/addCampaignProgram.do</c:when>
	<c:when test="${nameValue == 'removeCampaignProgram'}">${pageContext.request.contextPath}/marketing/campaign/removeCampaignProgram.do</c:when>

	<c:when test="${nameValue == 'removeCampaign'}">${pageContext.request.contextPath}/loyalty/campaign/removeCampaign.do</c:when>
	<c:when test="${nameValue == 'getCampaignPromotionDate'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignPromotionDate.do</c:when>

	<%-- 캠페인 예산 및 자원정보 --%>
	<c:when test="${nameValue == 'getCampaignResource'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignResource.do</c:when>
	<c:when test="${nameValue == 'saveCampaignResource'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignResource.do</c:when>

	<%-- 캠페인 목표 및 ROI --%>
	<c:when test="${nameValue == 'getCampaignRoiGoalDtl'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/getCampaignRoiGoalDtl.do</c:when>
	<c:when test="${nameValue == 'addCampaignRoiGoalDtl'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/addCampaignRoiGoalDtl.do</c:when>
	<c:when test="${nameValue == 'editCampaignRoiGoalDtl'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/editCampaignRoiGoalDtl.do</c:when>
	<c:when test="${nameValue == 'addCampaignRoiGoalCalcRslt'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/addCampaignRoiGoalCalcRslt.do</c:when>
	<c:when test="${nameValue == 'getCampaignExeItemList'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/getCampaignExeItemList.do</c:when>
	<c:when test="${nameValue == 'getCampaignRoiGoalResultList'}">${pageContext.request.contextPath}/marketing/campaignRoiGoal/getCampaignRoiGoalResultList.do</c:when>


	<%-- 캠페인 오퍼 --%>
	<c:when test="${nameValue == 'getCampaignOffer'}">${pageContext.request.contextPath}/loyalty/campaign/getCampaignOffer.do</c:when>
	<c:when test="${nameValue == 'saveCampaignOfferRel'}">${pageContext.request.contextPath}/loyalty/campaign/saveCampaignOfferRel.do</c:when>

	<%-- 캠페인 대상자 등록 --%>
	<c:when test="${nameValue == 'getCampaignTargetTotalCount'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignTargetTotalCount.do</c:when>
	<c:when test="${nameValue == 'getCampaignTarget'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignTarget.do</c:when>
	<c:when test="${nameValue == 'getCampaignTargetList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignTargetList.do</c:when>
	<c:when test="${nameValue == 'getCampaignTargetDtlList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignTargetDtlList.do</c:when>
	<c:when test="${nameValue == 'removeCampaignTarget'}">${pageContext.request.contextPath}/marketing/campaign/removeCampaignTarget.do</c:when>
	<c:when test="${nameValue == 'setDuplicateDelete'}">${pageContext.request.contextPath}/marketing/campaign/setDuplicateDelete.do</c:when>
	<c:when test="${nameValue == 'setFatigueCheckDelet'}">${pageContext.request.contextPath}/marketing/campaign/setFatigueCheckDelet.do</c:when>
	<c:when test="${nameValue == 'setPermissionCheckDelete'}">${pageContext.request.contextPath}/marketing/campaign/setPermissionCheckDelete.do</c:when>
	<c:when test="${nameValue == 'setControlGroup'}">${pageContext.request.contextPath}/marketing/campaign/setControlGroup.do</c:when>
	<c:when test="${nameValue == 'removeCampaignTargetDtl'}">${pageContext.request.contextPath}/marketing/campaign/removeCampaignTargetDtl.do</c:when>
	<c:when test="${nameValue == 'removeCancelCampaignTargetDtl'}">${pageContext.request.contextPath}/marketing/campaign/removeCancelCampaignTargetDtl.do</c:when>
	<c:when test="${nameValue == 'excelExportCampaignTargetList'}">${pageContext.request.contextPath}/marketing/campaign/excelExportCampaignTargetList.do</c:when>
	<c:when test="${nameValue == 'saveCampaignTarget'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignTarget.do</c:when>

	<%-- 캠페인 승인 --%>
	<c:when test="${nameValue == 'getCampaignApproval'}">${pageContext.request.contextPath}/loyalty/campaign/getCampaignApproval.do</c:when>
	<c:when test="${nameValue == 'getCampaignReportInfo'}">${pageContext.request.contextPath}/onlineApproval/getCampaignReportInfo.do</c:when>

	<%-- 캠페인 결재 SMS 정보 --%>
	<c:when test="${nameValue == 'getAprvContentsDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getAprvContentsDetail.do</c:when>

	<%-- 캠페인 실행정보 --%>
	<c:when test="${nameValue == 'getCampaignExecutionInfo'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignExecutionInfo.do</c:when>
	<c:when test="${nameValue == 'saveCampaignExecutionInfo'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignExecutionInfo.do</c:when>

	<c:when test="${nameValue == 'getCampaignLastExeDate'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignLastExeDate.do</c:when>
	<c:when test="${nameValue == 'getMassCampaignTargetCount'}">${pageContext.request.contextPath}/marketing/campaign/getMassCampaignTargetCount.do</c:when>

	<%-- 캠페인 ROI --%>
	<c:when test="${nameValue == 'getCampaignROI'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignROI.do</c:when>
	<c:when test="${nameValue == 'saveCampaignROI'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignROI.do</c:when>

	<%-- 캠페인 콘텐츠 채널 관계 --%>
	<c:when test="${nameValue == 'getCampaignContentsChnnelRel'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignContentsChnnelRel.do</c:when>
	<c:when test="${nameValue == 'saveCampaignContentsChnnelRel'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignContentsChnnelRel.do</c:when>
	<c:when test="${nameValue == 'getCampaignOfferCount'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignOfferCount.do</c:when>

	<%-- 캠페인 모니터링 --%>
	<c:when test="${nameValue == 'getExecutionResultList'}">${pageContext.request.contextPath}/marketing/campaign/getExecutionResultList.do</c:when>
	<c:when test="${nameValue == 'getCampaignMonitoringROI'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignMonitoringROI.do</c:when>
	<c:when test="${nameValue == 'saveCampaignMonitoringROI'}">${pageContext.request.contextPath}/marketing/campaign/saveCampaignMonitoringROI.do</c:when>

	<%-- 워크플로우 --%>
	<c:when test="${nameValue == 'getWorkflowPaletteList'}">${pageContext.request.contextPath}/loyalty/workflow/getWorkflowPaletteList.do</c:when>
	<c:when test="${nameValue == 'getWorkflowTask'}">${pageContext.request.contextPath}/loyalty/workflow/getWorkflowTask.do</c:when>
	<c:when test="${nameValue == 'saveWorkflowTask'}">${pageContext.request.contextPath}/loyalty/workflow/saveWorkflowTask.do</c:when>

	<c:when test="${nameValue == 'saveCampaignWorkflow'}">${pageContext.request.contextPath}/loyalty/campaign/saveCampaignWorkflow.do</c:when>
	<c:when test="${nameValue == 'getCampaignWorkflowStatusList'}">${pageContext.request.contextPath}/loyalty/campaign/getCampaignWorkflowStatusList.do</c:when>
	<c:when test="${nameValue == 'checkCampaignStatusSaveFlag'}">${pageContext.request.contextPath}/loyalty/campaign/checkCampaignStatusSaveFlag.do</c:when>
	<c:when test="${nameValue == 'getTgtGrpIncList'}">${pageContext.request.contextPath}/loyalty/campaign/getTgtGrpIncList.do</c:when>
	<c:when test="${nameValue == 'savePromotionKpi'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionKpi.do</c:when>
	<c:when test="${nameValue == 'getPromKpiInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromKpiInfo.do</c:when>
	<c:when test="${nameValue == 'removeActionTierItem'}">${pageContext.request.contextPath}/loyalty/campaign/removeActionTierItem.do</c:when>


	<%-- 캠페인 실행결과 --%>
	<c:when test="${nameValue == 'getExecutionResultList'}">${pageContext.request.contextPath}/marketing/campaign/getExecutionResultList.do</c:when>

	<%-- 캠페인 스토어 --%>
	<c:when test="${nameValue == 'getStoreList'}">${pageContext.request.contextPath}/marketing/store/getStoreList.do</c:when>
	<c:when test="${nameValue == 'saveStoreList'}">${pageContext.request.contextPath}/marketing/store/saveStoreList.do</c:when>
	<c:when test="${nameValue == 'removeStoreList'}">${pageContext.request.contextPath}/marketing/store/removeStoreList.do</c:when>
	<c:when test="${nameValue == 'getExceptIdsChannelList'}">${pageContext.request.contextPath}/marketing/store/getExceptIdsChannelList.do</c:when>

	<%-- 멀티스테이지 --%>
	<c:when test="${nameValue == 'getMultiStage'}">${pageContext.request.contextPath}/marketing/multiStage/getMultiStage.do</c:when>
	<c:when test="${nameValue == 'getMultiStageCondition'}">${pageContext.request.contextPath}/marketing/multiStage/getMultiStageCondition.do</c:when>
	<c:when test="${nameValue == 'saveMultiStage'}">${pageContext.request.contextPath}/marketing/multiStage/saveMultiStage.do</c:when>
	<c:when test="${nameValue == 'getCampaignListForMultistage'}">${pageContext.request.contextPath}/marketing/multiStage/getCampaignListForMultistage.do</c:when>

	<%-- 마케팅 플랜 --%>
	<c:when test="${nameValue == 'getPlanList'}">${pageContext.request.contextPath}/marketing/plan/getPlanList.do</c:when>
	<c:when test="${nameValue == 'getPlanDtl'}">${pageContext.request.contextPath}/marketing/plan/getPlanDtl.do</c:when>
	<c:when test="${nameValue == 'getPlanExecList'}">${pageContext.request.contextPath}/marketing/plan/getPlanExecList.do</c:when>

	<c:when test="${nameValue == 'addPlanDtl'}">${pageContext.request.contextPath}/marketing/plan/addPlanDtl.do</c:when>
	<c:when test="${nameValue == 'editPlanDtl'}">${pageContext.request.contextPath}/marketing/plan/editPlanDtl.do</c:when>
	<c:when test="${nameValue == 'removePlan'}">${pageContext.request.contextPath}/marketing/plan/removePlan.do</c:when>

	<c:when test="${nameValue == 'getExecList'}">${pageContext.request.contextPath}/marketing/plan/getExecList.do</c:when>
	<c:when test="${nameValue == 'addExecDtl'}">${pageContext.request.contextPath}/marketing/plan/addExecDtl.do</c:when>
	<c:when test="${nameValue == 'editExecDtl'}">${pageContext.request.contextPath}/marketing/plan/editExecDtl.do</c:when>
	<c:when test="${nameValue == 'removeExecDtl'}">${pageContext.request.contextPath}/marketing/plan/removeExecDtl.do</c:when>
	<c:when test="${nameValue == 'getPlanListExport'}">${pageContext.request.contextPath}/marketing/plan/getPlanListExport.do</c:when>


	<%-- 템플릿 --%>
	<c:when test="${nameValue == 'getTemplateList'}">${pageContext.request.contextPath}/marketing/targeting/getTemplateList.do</c:when>
	<c:when test="${nameValue == 'getRootTemplateList'}">${pageContext.request.contextPath}/marketing/targeting/getRootTemplateList.do</c:when>
	<c:when test="${nameValue == 'setTemplateInfo'}">${pageContext.request.contextPath}/marketing/targeting/setTemplateInfo.do</c:when>
	<c:when test="${nameValue == 'getTemplateInfo'}">${pageContext.request.contextPath}/marketing/targeting/getTemplateInfo.do</c:when>
	<c:when test="${nameValue == 'removeTemplate'}">${pageContext.request.contextPath}/marketing/targeting/removeTemplate.do</c:when>
	<c:when test="${nameValue == 'modifyTemplateInfo'}">${pageContext.request.contextPath}/marketing/targeting/modifyTemplateInfo.do</c:when>
	<c:when test="${nameValue == 'getPromptKeyword'}">${pageContext.request.contextPath}/marketing/targeting/getPromptKeyword.do</c:when>
	<c:when test="${nameValue == 'getTemplateAttrPromptInfo'}">${pageContext.request.contextPath}/marketing/targeting/getTemplateAttrPromptInfo.do</c:when>
	<c:when test="${nameValue == 'setTemplatePromptInfo'}">${pageContext.request.contextPath}/marketing/targeting/setTemplatePromptInfo.do</c:when>
	<c:when test="${nameValue == 'getTemplatePromptInfo'}">${pageContext.request.contextPath}/marketing/targeting/getTemplatePromptInfo.do</c:when>
	<c:when test="${nameValue == 'modifyTemplatePromptInfo'}">${pageContext.request.contextPath}/marketing/targeting/modifyTemplatePromptInfo.do</c:when>
	<c:when test="${nameValue == 'setTemplateQuery'}">${pageContext.request.contextPath}/marketing/targeting/setTemplateQuery.do</c:when>
	<c:when test="${nameValue == 'getTemplateQuery'}">${pageContext.request.contextPath}/marketing/targeting/getTemplateQuery.do</c:when>
	<c:when test="${nameValue == 'modifyTemplateQuery'}">${pageContext.request.contextPath}/marketing/targeting/modifyTemplateQuery.do</c:when>
	<c:when test="${nameValue == 'checkTemplatePrompt'}">${pageContext.request.contextPath}/marketing/targeting/checkTemplatePrompt.do</c:when>

	<%-- 조건관리 --%>
	<c:when test="${nameValue == 'menuList'}">${pageContext.request.contextPath}/system/condition/getMenuList.do</c:when>
	<c:when test="${nameValue == 'getConditionList'}">${pageContext.request.contextPath}/system/condition/getConditionList.do</c:when>
	<c:when test="${nameValue == 'getDropDownList'}">${pageContext.request.contextPath}/system/condition/getDropDownList.do</c:when>
	<c:when test="${nameValue == 'getBaseTableList'}">${pageContext.request.contextPath}/system/condition/getBaseTableList.do</c:when>
	<c:when test="${nameValue == 'getSrcColumList'}">${pageContext.request.contextPath}/system/condition/getSrcColumList.do</c:when>
	<c:when test="${nameValue == 'setCondition'}">${pageContext.request.contextPath}/system/condition/setCondition.do</c:when>
	<c:when test="${nameValue == 'getConditionDetail'}">${pageContext.request.contextPath}/system/condition/getConditionDetail.do</c:when>
	<c:when test="${nameValue == 'modifyCondition'}">${pageContext.request.contextPath}/system/condition/modifyCondition.do</c:when>
	<c:when test="${nameValue == 'removeCondition'}">${pageContext.request.contextPath}/system/condition/removeCondition.do</c:when>
	<c:when test="${nameValue == 'groupDetailList'}">${pageContext.request.contextPath}/system/condition/groupDetailList.do</c:when>
	<c:when test="${nameValue == 'getDropDownListColumList'}">${pageContext.request.contextPath}/system/condition/getDropDownListColumList.do</c:when>
	<c:when test="${nameValue == 'addTableList'}">${pageContext.request.contextPath}/system/condition/addTableList.do</c:when>


	<%-- 퀵캠페인 --%>
<%-- 	<c:when test="${nameValue == 'setFileUpload'}">${pageContext.request.contextPath}/marketing/quickCampaign/setFileUpload.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getSegmentList'}">${pageContext.request.contextPath}/marketing/quickCampaign/getSegmentList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'setQuickCampaign'}">${pageContext.request.contextPath}/marketing/quickCampaign/setQuickCampaign.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'modifyQuickCampaign'}">${pageContext.request.contextPath}/marketing/quickCampaign/modifyQuickCampaign.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getQuickCampaign'}">${pageContext.request.contextPath}/marketing/quickCampaign/getQuickCampaign.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'setSegment'}">${pageContext.request.contextPath}/marketing/quickCampaign/setSegment.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'modifySegment'}">${pageContext.request.contextPath}/marketing/quickCampaign/modifySegment.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getSegmentCustCnt'}">${pageContext.request.contextPath}/marketing/quickCampaign/getSegmentCustCnt.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'setQuickOffer'}">${pageContext.request.contextPath}/marketing/quickCampaign/setQuickOffer.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'startQuickCampaign'}">${pageContext.request.contextPath}/marketing/quickCampaign/startQuickCampaign.do</c:when> --%>

	<%-- 타겟팅 파일 업로드 --%>
	<c:when test="${nameValue == 'getTargetImportDtl'}">${pageContext.request.contextPath}/marketing/targetingImport/getTargetImportDtl.do</c:when>
	<c:when test="${nameValue == 'setTargetImport'}">${pageContext.request.contextPath}/marketing/targetingImport/setTargetImport.do</c:when>
	<c:when test="${nameValue == 'removeTargetImport'}">${pageContext.request.contextPath}/marketing/targetingImport/removeTargetImport.do</c:when>
	<c:when test="${nameValue == 'getTgtUploadTmpCount'}">${pageContext.request.contextPath}/marketing/targetingImport/getTgtUploadTmpCount.do</c:when>
	<c:when test="${nameValue == 'getImportMbrColumnInfo'}">${pageContext.request.contextPath}/marketing/targetingImport/getImportMbrColumnInfo.do</c:when>
	<c:when test="${nameValue == 'getImportMbrData'}">${pageContext.request.contextPath}/marketing/targetingImport/getImportMbrData.do</c:when>
	<c:when test="${nameValue == 'getImportList'}">${pageContext.request.contextPath}/marketing/targetingImport/getImportList.do</c:when>
	<c:when test="${nameValue == 'getTargetImportTmpList'}">${pageContext.request.contextPath}/marketing/targetingImport/getTargetImportTmpList.do</c:when>
	<c:when test="${nameValue == 'setImportFileUpload'}">${pageContext.request.contextPath}/marketing/targetingImport/setImportFileUpload.do</c:when>
	<c:when test="${nameValue == 'removeFileTargetTmpDtlList'}">${pageContext.request.contextPath}/marketing/targetingImport/removeFileTargetTmpDtlList.do</c:when>
	<c:when test="${nameValue == 'exportExcelTargetImportTargetList'}">${pageContext.request.contextPath}/marketing/targetingImport/exportExcelTargetImportTargetList.do</c:when>

	<%-- 바로실행 캠페인 --%>
<%-- 	<c:when test="${nameValue == 'getDirectCampaignList'}">${pageContext.request.contextPath}/marketing/directCampaign/getDirectCampaignList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'checkDirectCampaign'}">${pageContext.request.contextPath}/marketing/directCampaign/checkDirectCampaign.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getDirectSegment'}">${pageContext.request.contextPath}/marketing/directCampaign/getDirectSegment.do</c:when> --%>

	<%-- 오퍼 --%>
	<c:when test="${nameValue == 'getOfferList'}">${pageContext.request.contextPath}/offer/getOfferList.do</c:when>
    <c:when test="${nameValue == 'getOfferDetail'}">${pageContext.request.contextPath}/offer/getOfferDetail.do</c:when>
    <c:when test="${nameValue == 'addOffer'}">${pageContext.request.contextPath}/offer/addOffer.do</c:when>
    <c:when test="${nameValue == 'editOffer'}">${pageContext.request.contextPath}/offer/editOffer.do</c:when>
    <c:when test="${nameValue == 'removeOffer'}">${pageContext.request.contextPath}/offer/removeOffer.do</c:when>
	<c:when test="${nameValue == 'getOfferJoinPgmList'}">${pageContext.request.contextPath}/offer/getOfferJoinPgmList.do</c:when>
    <c:when test="${nameValue == 'addOfferJoinPgm'}">${pageContext.request.contextPath}/offer/addOfferJoinPgm.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinPgm'}">${pageContext.request.contextPath}/offer/removeOfferJoinPgm.do</c:when>
    <c:when test="${nameValue == 'getChildOfferGroupList'}">${pageContext.request.contextPath}/offer/getChildOfferGroupList.do</c:when>
    <c:when test="${nameValue == 'modifyOfferJoinPgm'}">${pageContext.request.contextPath}/offer/modifyOfferJoinPgm.do</c:when>

    <c:when test="${nameValue == 'getOfferGroupList'}">${pageContext.request.contextPath}/offerGroup/getOfferGroupList.do</c:when>
	<c:when test="${nameValue == 'getOfferGroupDetail'}">${pageContext.request.contextPath}/offerGroup/getOfferGroupDetail.do</c:when>
	<c:when test="${nameValue == 'addOfferGroup'}">${pageContext.request.contextPath}/offerGroup/addOfferGroup.do</c:when>
	<c:when test="${nameValue == 'editOfferGroup'}">${pageContext.request.contextPath}/offerGroup/editOfferGroup.do</c:when>
	<c:when test="${nameValue == 'removeOfferGroup'}">${pageContext.request.contextPath}/offerGroup/removeOfferGroup.do</c:when>

	<c:when test="${nameValue == 'getChildOfferList'}">${pageContext.request.contextPath}/offerGroup/getChildOfferList.do</c:when>
	<c:when test="${nameValue == 'getChildOfferDetail'}">${pageContext.request.contextPath}/offerGroup/getChildOfferDetail.do</c:when>
	<c:when test="${nameValue == 'addChildOffer'}">${pageContext.request.contextPath}/offerGroup/addChildOffer.do</c:when>
	<c:when test="${nameValue == 'editChildOffer'}">${pageContext.request.contextPath}/offerGroup/editChildOffer.do</c:when>
	<c:when test="${nameValue == 'removeChildOffer'}">${pageContext.request.contextPath}/offerGroup/removeChildOffer.do</c:when>

    <c:when test="${nameValue == 'getOfferJoinChnlList'}">${pageContext.request.contextPath}/offer/getOfferJoinChnlList.do</c:when>
    <c:when test="${nameValue == 'addOfferJoinChnl'}">${pageContext.request.contextPath}/offer/addOfferJoinChnl.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinChnl'}">${pageContext.request.contextPath}/offer/removeOfferJoinChnl.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinAllChnl'}">${pageContext.request.contextPath}/offer/removeOfferJoinAllChnl.do</c:when>
    <c:when test="${nameValue == 'exportExcelOfferJoinChnlTargetList'}">${pageContext.request.contextPath}/offer/exportExcelOfferJoinChnlTargetList.do</c:when>
    <c:when test="${nameValue == 'setOfferJoinChnlUpload'}">${pageContext.request.contextPath}/offer/setOfferJoinChnlUpload.do</c:when>
    <c:when test="${nameValue == 'setOfferJoinProdUpload'}">${pageContext.request.contextPath}/offer/setOfferJoinProdUpload.do</c:when>

    <c:when test="${nameValue == 'getOfferJoinProdList'}">${pageContext.request.contextPath}/offer/getOfferJoinProdList.do</c:when>
    <c:when test="${nameValue == 'getOfferJoinProdNotList'}">${pageContext.request.contextPath}/offer/getOfferJoinProdNotList.do</c:when>
    <c:when test="${nameValue == 'addOfferJoinProd'}">${pageContext.request.contextPath}/offer/addOfferJoinProd.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinProd'}">${pageContext.request.contextPath}/offer/removeOfferJoinProd.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinAllProd'}">${pageContext.request.contextPath}/offer/removeOfferJoinAllProd.do</c:when>
    <c:when test="${nameValue == 'removeOfferJoinNotAllProd'}">${pageContext.request.contextPath}/offer/removeOfferJoinNotAllProd.do</c:when>
    <c:when test="${nameValue == 'exportExcelOfferJoinProdTargetList'}">${pageContext.request.contextPath}/offer/exportExcelOfferJoinProdTargetList.do</c:when>
    <c:when test="${nameValue == 'exportExcelOfferJoinNotProdTargetList'}">${pageContext.request.contextPath}/offer/exportExcelOfferJoinNotProdTargetList.do</c:when>
    <c:when test="${nameValue == 'setOfferJoinProdUpload'}">${pageContext.request.contextPath}/offer/setOfferJoinProdUpload.do</c:when>

    <c:when test="${nameValue == 'getOfferCouponPoolList'}">${pageContext.request.contextPath}/offer/getOfferCouponPoolList.do</c:when>
    <c:when test="${nameValue == 'exportExcelOfferCpnPoolList'}">${pageContext.request.contextPath}/offer/exportExcelOfferCpnPoolList.do</c:when>
    <c:when test="${nameValue == 'getOfferCpnPoolListCond'}">${pageContext.request.contextPath}/offer/getOfferCpnPoolListCond.do</c:when>
    <c:when test="${nameValue == 'ofrCuponStatusExcelDownload'}">${pageContext.request.contextPath}/offer/ofrCuponStatusExcelDownload.do</c:when>
    <c:when test="${nameValue == 'getOfrCpnCnt'}">${pageContext.request.contextPath}/offer/getOfrCpnCnt.do</c:when>
    <c:when test="${nameValue == 'updateOfrStatCdStop'}">${pageContext.request.contextPath}/offer/updateOfrStatCdStop.do</c:when>
    <c:when test="${nameValue == 'updateOfrStatCdStart'}">${pageContext.request.contextPath}/offer/updateOfrStatCdStart.do</c:when>
    <c:when test="${nameValue == 'getOfferPointList'}">${pageContext.request.contextPath}/offer/getOfferPointList.do</c:when>
    <c:when test="${nameValue == 'getOfferPointCommCodeList'}">${pageContext.request.contextPath}/offer/getOfferPointCommCodeList.do</c:when>
    <c:when test="${nameValue == 'updateOfrStatCdStart'}">${pageContext.request.contextPath}/offer/updateOfrStatCdStart.do</c:when>

	<%--Beacon Coupon List --%>
<%-- 	<c:when test="${nameValue == 'getCommonBeaconCouponList'}">${pageContext.request.contextPath}/marketing/beacon/getCommonBeaconCouponList.do</c:when> --%>
	<%--Beacon Coupon Detail --%>
<%-- 	<c:when test="${nameValue == 'getCommonBeaconCouponDetail'}">${pageContext.request.contextPath}/marketing/beacon/getCommonBeaconCouponDetail.do</c:when> --%>

	<%-- 소스 이관 --%>
	<c:when test="${nameValue == 'getCampaignStatusList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignStatusList.do</c:when>
	<c:when test="${nameValue == 'getCampaignStatusDetailList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignStatusDetailList.do</c:when>
	<c:when test="${nameValue == 'getCampaignStatusErrorList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignStatusErrorList.do</c:when>
	<c:when test="${nameValue == 'getCampaignDetailList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignDetailList.do</c:when>
	<c:when test="${nameValue == 'getCampaignNotSendPopList'}">${pageContext.request.contextPath}/marketing/campaign/getCampaignNotSendPopList.do</c:when>
	<c:when test="${nameValue == 'excelCampaignDetailList'}">${pageContext.request.contextPath}/marketing/campaign/excelCampaignDetailList.do</c:when>
	<c:when test="${nameValue == 'chnlReSend'}">${pageContext.request.contextPath}/marketing/campaign/chnlReSend.do</c:when>
	<c:when test="${nameValue == 'chnlReSendHistory'}">${pageContext.request.contextPath}/marketing/campaign/chnlReSendHistory.do</c:when>
	<c:when test="${nameValue == 'getRspnsInfoMstList'}">${pageContext.request.contextPath}/marketing/campaign/getRspnsInfoMstList.do</c:when>

	<%-- 실행채널정보 --%>
	<c:when test="${nameValue == 'getCampaignListForExecResult'}">${pageContext.request.contextPath}/marketing/executionStatus/getCampaignListForExecResult.do</c:when>
	<c:when test="${nameValue == 'getCampaignPromExecList'}">${pageContext.request.contextPath}/marketing/executionStatus/getCampaignPromExecList.do</c:when>
	<c:when test="${nameValue == 'getCampaignChnlExecList'}">${pageContext.request.contextPath}/marketing/executionStatus/getCampaignChnlExecList.do</c:when>
	<c:when test="${nameValue == 'getCampaignTargetRspnsList'}">${pageContext.request.contextPath}/marketing/executionStatus/getCampaignTargetRspnsList.do</c:when>
	<c:when test="${nameValue == 'excelCampaignTargetRspnsList'}">${pageContext.request.contextPath}/marketing/executionStatus/excelCampaignTargetRspnsList.do</c:when>

	<c:when test="${nameValue == 'getExecutionStatusErrorList'}">${pageContext.request.contextPath}/marketing/executionStatus/getExecutionStatusErrorList.do</c:when>
	<c:when test="${nameValue == 'getExecutionStatusNotSendList'}">${pageContext.request.contextPath}/marketing/executionStatus/getExecutionStatusNotSendList.do</c:when>

	<%-- 콘텐츠 --%>
	<c:when test="${nameValue == 'getContent'}">${pageContext.request.contextPath}/marketing/content/getContent.do</c:when>
	<c:when test="${nameValue == 'getDetailContent'}">${pageContext.request.contextPath}/marketing/content/getDetailContent.do</c:when>
	<c:when test="${nameValue == 'getEmailDtlList'}">${pageContext.request.contextPath}/marketing/content/getEmailDtlList.do</c:when>
	<c:when test="${nameValue == 'getMmsDtlList'}">${pageContext.request.contextPath}/marketing/content/getMmsDtlList.do</c:when>
	<c:when test="${nameValue == 'getContenttypeList'}">${pageContext.request.contextPath}/marketing/content/getContenttypeList.do</c:when>
	<c:when test="${nameValue == 'getChnlConType'}">${pageContext.request.contextPath}/marketing/content/getChnlConType.do</c:when>
	<c:when test="${nameValue == 'getChannelType'}">${pageContext.request.contextPath}/marketing/content/getChannelType.do</c:when>
	<c:when test="${nameValue == 'getChnnl'}">${pageContext.request.contextPath}/marketing/content/getChnnl.do</c:when>
	<c:when test="${nameValue == 'getCouponList'}">${pageContext.request.contextPath}/marketing/content/getCouponList.do</c:when>
	<c:when test="${nameValue == 'getBarcode'}">${pageContext.request.contextPath}/marketing/content/getBarcode.do</c:when>
	<c:when test="${nameValue == 'sendChannelTest'}">${pageContext.request.contextPath}/marketing/content/sendChannelTest.do</c:when>
	<c:when test="${nameValue == 'getNewImgUpType'}">${pageContext.request.contextPath}/common/getNewImgUpType.do</c:when>
	<c:when test="${nameValue == 'getBarcodePath'}">${pageContext.request.contextPath}/marketing/content/getBarcodePath.do</c:when>
	<c:when test="${nameValue == 'getchnlCodeName'}">${pageContext.request.contextPath}/marketing/content/getchnlCodeName.do</c:when>
	<c:when test="${nameValue == 'getConPersonalList'}">${pageContext.request.contextPath}/marketing/content/getPersonalList.do</c:when>
	<c:when test="${nameValue == 'getChnlId'}">${pageContext.request.contextPath}/marketing/content/getChnlId.do</c:when>
	<c:when test="${nameValue == 'getChannelByCodeName'}">${pageContext.request.contextPath}/marketing/content/getChannelByCodeName.do</c:when>

	<c:when test="${nameValue == 'setContent'}">${pageContext.request.contextPath}/marketing/content/setContent.do</c:when>

	<c:when test="${nameValue == 'editResponseContent'}">${pageContext.request.contextPath}/marketing/content/editResponseContent.do</c:when>
	<c:when test="${nameValue == 'eidtDescFile'}">${pageContext.request.contextPath}/common/eidtDescFile.do</c:when>

	<c:when test="${nameValue == 'removeContent'}">${pageContext.request.contextPath}/marketing/content/removeContent.do</c:when>
	<c:when test="${nameValue == 'removeImage'}">${pageContext.request.contextPath}/common/removeImage.do</c:when>

	<%-- 컨텐츠 매니저 : S3 --%>
	<c:when test="${nameValue == 'removeImageS3'}">${pageContext.request.contextPath}/common/imageManageS3/removeImage.do</c:when>

	<%-- 콘텐츠 - Facebook --%>
	<c:when test="${nameValue == 'getFacebookPageInfo'}">${pageContext.request.contextPath}/marketing/content/getFacebookPageInfo.do</c:when>
	<c:when test="${nameValue == 'getFacebookPageInfoById'}">${pageContext.request.contextPath}/marketing/content/getFacebookPageInfoById.do</c:when>

	<c:when test="${nameValue == 'setPostId'}">${pageContext.request.contextPath}/marketing/content/setPostId.do</c:when>
	<c:when test="${nameValue == 'convertDateToUnixTimestamp'}">${pageContext.request.contextPath}/marketing/content/convertDateToUnixTimestamp.do</c:when>
	<c:when test="${nameValue == 'getFacebookOpenRangeInfo'}">${pageContext.request.contextPath}/marketing/content/getFacebookOpenRangeInfo.do</c:when>
	<c:when test="${nameValue == 'getAttachmentType'}">${pageContext.request.contextPath}/marketing/content/getAttachmentType.do</c:when>
	<c:when test="${nameValue == 'setReactionsRspnsInfo'}">${pageContext.request.contextPath}/marketing/content/setReactionsRspnsInfo.do</c:when>
	<c:when test="${nameValue == 'setSharedpostsRspnsInfo'}">${pageContext.request.contextPath}/marketing/content/setSharedpostsRspnsInfo.do</c:when>
	<c:when test="${nameValue == 'setCommentsRspnsInfo'}">${pageContext.request.contextPath}/marketing/content/setCommentsRspnsInfo.do</c:when>
	<c:when test="${nameValue == 'makeShortToLongLivedToken'}">${pageContext.request.contextPath}/marketing/content/makeShortToLongLivedToken.do</c:when>
	<c:when test="${nameValue == 'getFacebookDtlList'}">${pageContext.request.contextPath}/marketing/content/getFacebookDtlList.do</c:when>
	<c:when test="${nameValue == 'addVideoFile'}">${pageContext.request.contextPath}/common/fileupload/addFile.do</c:when>
	<c:when test="${nameValue == 'deleteVideoFile'}">${pageContext.request.contextPath}/common/fileupload/deleteFile.do</c:when>

	<%-- 콘텐츠 - Instagram --%>
	<c:when test="${nameValue == 'uploadImageToInsta'}">${pageContext.request.contextPath}/marketing/content/uploadImageToInsta.do</c:when>
	<c:when test="${nameValue == 'uploadVideoToInsta'}">${pageContext.request.contextPath}/marketing/content/uploadVideoToInsta.do</c:when>
	<c:when test="${nameValue == 'getInstagramInfo'}">${pageContext.request.contextPath}/marketing/content/getInstagramInfo.do</c:when>
	<c:when test="${nameValue == 'getInstagramInfoById'}">${pageContext.request.contextPath}/marketing/content/getInstagramInfoById.do</c:when>
	<c:when test="${nameValue == 'getInstagramDtlList'}">${pageContext.request.contextPath}/marketing/content/getInstagramDtlList.do</c:when>

	<%-- 콘텐츠 - 개인화 --%>
	<c:when test="${nameValue == 'getContsPrsnlFile'}">${pageContext.request.contextPath}/marketing/content/getContsPrsnlFile.do</c:when>
	<c:when test="${nameValue == 'uploadPrsnlFile'}">${pageContext.request.contextPath}/marketing/content/uploadPrsnlFile.do</c:when>
	<c:when test="${nameValue == 'removePrsnl'}">${pageContext.request.contextPath}/marketing/content/removePrsnl.do</c:when>

	<%-- 채널--%>
	<%-- <c:when test="${nameValue == 'setChannelStore'}">${pageContext.request.contextPath}/marketing/channel/setChannelStore.do</c:when>
	<c:when test="${nameValue == 'editCapaChannel'}">${pageContext.request.contextPath}/marketing/channel/editCapaChannel.do</c:when>
	<c:when test="${nameValue == 'getDetailCapa'}">${pageContext.request.contextPath}/marketing/channel/getDetailCapa.do</c:when>
	<c:when test="${nameValue == 'getImgDetailOption'}">${pageContext.request.contextPath}/marketing/channel/getImgDetailOption.do</c:when>
 --%>
	<%-- 공통 --%>
	<c:when test="${nameValue == 'setComCondLog'}">${pageContext.request.contextPath}/common/view/setComCondLog.do</c:when>


	<%-- 전자결제 --%>
	<c:when test="${nameValue == 'setApproval'}">${pageContext.request.contextPath}/onlineApproval/setApproval.do</c:when>
	<c:when test="${nameValue == 'editElapproval'}">${pageContext.request.contextPath}/onlineApproval/editElapproval.do</c:when>
	<c:when test="${nameValue == 'getCampaign'}">${pageContext.request.contextPath}/onlineApproval/getCampaign.do</c:when>
	<c:when test="${nameValue == 'getApproverList'}">${pageContext.request.contextPath}/onlineApproval/getApproverList.do</c:when>
	<c:when test="${nameValue == 'getStoreManagerInfo'}">${pageContext.request.contextPath}/onlineApproval/getStoreManagerInfo.do</c:when>
	<c:when test="${nameValue == 'getMember'}">${pageContext.request.contextPath}/onlineApproval/getMember.do</c:when>
	<c:when test="${nameValue == 'setItemApproval'}">${pageContext.request.contextPath}/onlineApproval/setItemApproval.do</c:when>
	<c:when test="${nameValue == 'getMyElapproval'}">${pageContext.request.contextPath}/onlineApproval/getMyElapproval.do</c:when>
	<c:when test="${nameValue == 'getMyElapproval2'}">${pageContext.request.contextPath}/onlineApproval/getMyElapproval2.do</c:when>
	<c:when test="${nameValue == 'getDetailAprv'}">${pageContext.request.contextPath}/onlineApproval/getDetailAprv.do</c:when>
	<c:when test="${nameValue == 'removeItem'}">${pageContext.request.contextPath}/onlineApproval/removeItem.do</c:when>
	<c:when test="${nameValue == 'editItem'}">${pageContext.request.contextPath}/onlineApproval/editItem.do</c:when>
	<c:when test="${nameValue == 'getAprvList'}">${pageContext.request.contextPath}/onlineApproval/getAprvList.do</c:when>
	<c:when test="${nameValue == 'getReftAprvList'}">${pageContext.request.contextPath}/onlineApproval/getReftAprvList.do</c:when>
	<c:when test="${nameValue == 'getApproverStatus'}">${pageContext.request.contextPath}/onlineApproval/getApproverStatus.do</c:when>
	<c:when test="${nameValue == 'editAprvType'}">${pageContext.request.contextPath}/onlineApproval/editAprvType.do</c:when>
	<c:when test="${nameValue == 'editReject'}">${pageContext.request.contextPath}/onlineApproval/editReject.do</c:when>
	<c:when test="${nameValue == 'getRefElapproval'}">${pageContext.request.contextPath}/onlineApproval/getRefElapproval.do</c:when>
	<c:when test="${nameValue == 'getMyRefCount'}">${pageContext.request.contextPath}/onlineApproval/getMyRefCount.do</c:when>
	<c:when test="${nameValue == 'getMyAgreeCount'}">${pageContext.request.contextPath}/onlineApproval/getMyAgreeCount.do</c:when>
	<c:when test="${nameValue == 'getMyAprvCount'}">${pageContext.request.contextPath}/onlineApproval/getMyAprvCount.do</c:when>

	<c:when test="${nameValue == 'removeElapproval'}">${pageContext.request.contextPath}/onlineApproval/removeElapproval.do</c:when>

	<%-- 부서관리 --%>
	<c:when test="${nameValue == 'getDeptInfo'}">${pageContext.request.contextPath}/marketing/dept/getDeptInfo.do</c:when>
	<c:when test="${nameValue == 'setDeptInfo'}">${pageContext.request.contextPath}/marketing/dept/setDeptInfo.do</c:when>
	<c:when test="${nameValue == 'updateDeptInfo'}">${pageContext.request.contextPath}/marketing/dept/updateDeptInfo.do</c:when>
	<c:when test="${nameValue == 'beSetStore'}">${pageContext.request.contextPath}/marketing/common/setStore.do</c:when>


	<%-- 직원 --%>
	<c:when test="${nameValue == 'addImage'}">${pageContext.request.contextPath}/marketing/content/addImage.do</c:when>


	<%-- 공통코드 관리 --%>

	<c:when test="${nameValue == 'getCommCodeList2'}">${pageContext.request.contextPath}/common/view/getCommCodeList2.do</c:when>
	<c:when test="${nameValue == 'getSelectBoxList'}">${pageContext.request.contextPath}/common/view/getSelectBoxList.do</c:when>
	<c:when test="${nameValue == 'getCommCodeAttr'}">${pageContext.request.contextPath}/marketing/common/getCommCodeAttr.do</c:when>
	<c:when test="${nameValue == 'getCommCodeGridList'}">${pageContext.request.contextPath}/marketing/manage/getCommCodeGridList.do</c:when>
	<c:when test="${nameValue == 'getCommCodeCountry'}">${pageContext.request.contextPath}/marketing/manage/getCommCodeCountry.do</c:when>
	<c:when test="${nameValue == 'editCommCodeFlag'}">${pageContext.request.contextPath}/marketing/manage/editCommCodeFlag.do</c:when>
	<c:when test="${nameValue == 'getCommCodeLangByIdList'}">${pageContext.request.contextPath}/marketing/manage/getCommCodeLangByIdList.do</c:when>
	<c:when test="${nameValue == 'getCommCodeDetail'}">${pageContext.request.contextPath}/marketing/manage/getCommCodeDetail.do</c:when>
	<c:when test="${nameValue == 'editCommCode'}">${pageContext.request.contextPath}/marketing/manage/editCommCode.do</c:when>
	<c:when test="${nameValue == 'addCommCode'}">${pageContext.request.contextPath}/marketing/manage/addCommCode.do</c:when>
	<c:when test="${nameValue == 'getHierarchyCommCodeList'}">${pageContext.request.contextPath}/marketing/common/getHierarchyCommCodeList.do</c:when>


	<%--  파일 업로드 --%>
	<%-- <c:when test="${nameValue == 'tempUpload'}"><%=infavor.util.IFVMCommon.getInstance().getBeaconConnectionUrl()%>/common/fileupload/tempUpload.do</c:when>
    <c:when test="${nameValue == 'tempUploadIE'}"><%=infavor.util.IFVMCommon.getInstance().getBeaconConnectionUrl()%>/common/fileupload/tempUploadIE.do</c:when> --%>
	<%-- <c:when test="${nameValue == 'tempUpload'}"><%=infavor.util.IFVMCommon.getInstance().getBeaconConnectionUrl()%>/base/fileupload/tempUpload.do</c:when>
    <c:when test="${nameValue == 'tempUploadIE'}"><%=infavor.util.IFVMCommon.getInstance().getBeaconConnectionUrl()%>/base/fileupload/tempUploadIE.do</c:when> --%>
	<c:when test="${nameValue == 'tempUpload'}">${pageContext.request.contextPath}/common/fileupload/tempUpload.do</c:when>
	<c:when test="${nameValue == 'tempUploadIE'}">${pageContext.request.contextPath}/common/fileupload/tempUploadIE.do</c:when>
	<c:when test="${nameValue == 'addfile'}">${pageContext.request.contextPath}/marketing/content/addfile.do</c:when>
	<c:when test="${nameValue == 'removeContentFile'}">${pageContext.request.contextPath}/marketing/content/removeContentFile.do</c:when>
	<c:when test="${nameValue == 'getFile'}">${pageContext.request.contextPath}/common/imageManage/getFile.do</c:when>
	<c:when test="${nameValue == 'getImageUpType'}">${pageContext.request.contextPath}/common/getImageUpType.do</c:when>
	<c:when test="${nameValue == 'getFileUpType'}">${pageContext.request.contextPath}/marketing/content/getFileUpType.do</c:when>

	<%-- 파일업로드 : S3 --%>
	<c:when test="${nameValue == 'tempUploadS3'}">${pageContext.request.contextPath}/common/fileupload/tempUploadS3.do</c:when>
	<c:when test="${nameValue == 'tempUploadIES3'}">${pageContext.request.contextPath}/common/fileupload/tempUploadIES3.do</c:when>
	<c:when test="${nameValue == 'addfileS3'}">${pageContext.request.contextPath}/marketing/content/addfile.do</c:when>
	<c:when test="${nameValue == 'removeContentFileS3'}">${pageContext.request.contextPath}/marketing/content/removeContentFile.do</c:when>
	<c:when test="${nameValue == 'getFileS3'}">${pageContext.request.contextPath}/common/getFile.do</c:when>
	<c:when test="${nameValue == 'getImageUpTypeS3'}">${pageContext.request.contextPath}/common/imageManageS3/getImageUpType.do</c:when>
	<c:when test="${nameValue == 'getFileUpTypeS3'}">${pageContext.request.contextPath}/marketing/content/getFileUpType.do</c:when>

	<%--  캠페인 켈린더 --%>
	<c:when test="${nameValue == 'getCampaignInCalendar'}">${pageContext.request.contextPath}/marketing/calendar/getCampaign.do</c:when>
	<c:when test="${nameValue == 'getCampaignType'}">${pageContext.request.contextPath}/marketing/calendar/getCampaignType.do</c:when>

	<%--  개인화 속성 관리 --%>
	<c:when test="${nameValue == 'getPersonalList'}">${pageContext.request.contextPath}/marketing/personal/getPersonalList.do</c:when>
	<c:when test="${nameValue == 'getPersonalDetail'}">${pageContext.request.contextPath}/marketing/personal/getPersonalDetail.do</c:when>
	<c:when test="${nameValue == 'addPersonal'}">${pageContext.request.contextPath}/marketing/personal/addPersonal.do</c:when>
	<c:when test="${nameValue == 'updatePersonal'}">${pageContext.request.contextPath}/marketing/personal/updatePersonal.do</c:when>
	<c:when test="${nameValue == 'deletePersonal'}">${pageContext.request.contextPath}/marketing/personal/deletePersonal.do</c:when>

	<%-- 캠페인 헤더 노드 리스트 출력 --%>
	<c:when test="${nameValue == 'getTempNodeList'}">${pageContext.request.contextPath}/marketing/campaign/getTempNodeList.do</c:when>
	<c:when test="${nameValue == 'getTemp'}">${pageContext.request.contextPath}/marketing/campaign/getTemp.do</c:when>
	<c:when test="${nameValue == 'callProcCamCopy'}">${pageContext.request.contextPath}/loyalty/campaign/callProcCamCopy.do</c:when>



	<%--  피로도 관리 --%>
	<c:when test="${nameValue == 'getFatigueList'}">${pageContext.request.contextPath}/marketing/fatigue/getFatigueList.do</c:when>
	<c:when test="${nameValue == 'getFatigueDetail'}">${pageContext.request.contextPath}/marketing/fatigue/getFatigueDetail.do</c:when>
	<c:when test="${nameValue == 'insertFatigue'}">${pageContext.request.contextPath}/marketing/fatigue/insertFatigue.do</c:when>
	<c:when test="${nameValue == 'deleteFatigue'}">${pageContext.request.contextPath}/marketing/fatigue/deleteFatigue.do</c:when>
	<c:when test="${nameValue == 'updateFatigue'}">${pageContext.request.contextPath}/marketing/fatigue/updateFatigue.do</c:when>
	<c:when test="${nameValue == 'applyFatigue'}">${pageContext.request.contextPath}/marketing/fatigue/applyFatigue.do</c:when>
	<c:when test="${nameValue == 'unApplyFatigue'}">${pageContext.request.contextPath}/marketing/fatigue/unApplyFatigue.do</c:when>
	<c:when test="${nameValue == 'getFatigueChnlItemList'}">${pageContext.request.contextPath}/marketing/fatigue/getFatigueChnlItemList.do</c:when>
	<c:when test="${nameValue == 'getFatigueItemDetail'}">${pageContext.request.contextPath}/marketing/fatigue/getFatigueItemDetail.do</c:when>
	<c:when test="${nameValue == 'removeFatigueChnlItem'}">${pageContext.request.contextPath}/marketing/fatigue/removeFatigueChnlItem.do</c:when>
	<c:when test="${nameValue == 'addFatiItem'}">${pageContext.request.contextPath}/marketing/fatigue/addFatiItem.do</c:when>
	<c:when test="${nameValue == 'editFatiItem'}">${pageContext.request.contextPath}/marketing/fatigue/editFatiItem.do</c:when>


	<%--  타겟팅 관리자 --%>
	<c:when test="${nameValue == 'setTargetLevels'}">${pageContext.request.contextPath}/marketing/adminTargeting/setTargetLevels.do</c:when>
	<c:when test="${nameValue == 'getTargetLevelsList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetLevelsList.do</c:when>
	<c:when test="${nameValue == 'getTargetLevels'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetLevels.do</c:when>
	<c:when test="${nameValue == 'modifyTargetLevels'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyTargetLevels.do</c:when>
	<c:when test="${nameValue == 'deleteTargetLevels'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteTargetLevels.do</c:when>
	<c:when test="${nameValue == 'getTargetTableList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetTableList.do</c:when>
	<c:when test="${nameValue == 'setTargetTable'}">${pageContext.request.contextPath}/marketing/adminTargeting/setTargetTable.do</c:when>
	<c:when test="${nameValue == 'getTargetTable'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetTable.do</c:when>
	<c:when test="${nameValue == 'deleteTargetTable'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteTargetTable.do</c:when>
	<c:when test="${nameValue == 'modifyTargetTable'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyTargetTable.do</c:when>

	<c:when test="${nameValue == 'getTargetColumList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetColumList.do</c:when>
	<c:when test="${nameValue == 'setTargetColum'}">${pageContext.request.contextPath}/marketing/adminTargeting/setTargetColum.do</c:when>
	<c:when test="${nameValue == 'deleteTargetColum'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteTargetColum.do</c:when>
	<c:when test="${nameValue == 'modifyTargetColum'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyTargetColum.do</c:when>
	<c:when test="${nameValue == 'getTargetColum'}">${pageContext.request.contextPath}/marketing/adminTargeting/getTargetColum.do</c:when>

	<c:when test="${nameValue == 'setSubjectArea'}">${pageContext.request.contextPath}/marketing/adminTargeting/setSubjectArea.do</c:when>
	<c:when test="${nameValue == 'modifySubjectArea'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifySubjectArea.do</c:when>
	<c:when test="${nameValue == 'deleteSubjectArea'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteSubjectArea.do</c:when>
	<c:when test="${nameValue == 'getSubjectArea'}">${pageContext.request.contextPath}/marketing/adminTargeting/getSubjectArea.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getSubjectAreaList.do</c:when>


	<c:when test="${nameValue == 'getFieldList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getFieldList.do</c:when>
	<c:when test="${nameValue == 'setField'}">${pageContext.request.contextPath}/marketing/adminTargeting/setField.do</c:when>
	<c:when test="${nameValue == 'modifyField'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyField.do</c:when>
	<c:when test="${nameValue == 'deleteField'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteField.do</c:when>
	<c:when test="${nameValue == 'getField'}">${pageContext.request.contextPath}/marketing/adminTargeting/getField.do</c:when>

	<c:when test="${nameValue == 'getJoinDefList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getJoinDefList.do</c:when>
	<c:when test="${nameValue == 'setJoinDef'}">${pageContext.request.contextPath}/marketing/adminTargeting/setJoinDef.do</c:when>
	<c:when test="${nameValue == 'modifyJoinDef'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyJoinDef.do</c:when>
	<c:when test="${nameValue == 'deleteJoinDef'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteJoinDef.do</c:when>
	<c:when test="${nameValue == 'getJoinDef'}">${pageContext.request.contextPath}/marketing/adminTargeting/getJoinDef.do</c:when>
	<c:when test="${nameValue == 'getJoinDetailList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getJoinDetailList.do</c:when>


	<c:when test="${nameValue == 'deleteJoinDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/deleteJoinDetail.do</c:when>
	<c:when test="${nameValue == 'modifyJoinDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/modifyJoinDetail.do</c:when>
	<c:when test="${nameValue == 'setJoinDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/setJoinDetail.do</c:when>
	<c:when test="${nameValue == 'getJoinDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/getJoinDetail.do</c:when>

	<c:when test="${nameValue == 'getLvlJoin'}">${pageContext.request.contextPath}/marketing/adminTargeting/getLvlJoin.do</c:when>
	<c:when test="${nameValue == 'getLvlJoinlList'}">${pageContext.request.contextPath}/marketing/adminTargeting/getLvlJoinlList.do</c:when>
	<c:when test="${nameValue == 'editLvlJoin'}">${pageContext.request.contextPath}/marketing/adminTargeting/editLvlJoin.do</c:when>
	<c:when test="${nameValue == 'setTgtLevelJoin'}">${pageContext.request.contextPath}/marketing/adminTargeting/setTgtLevelJoin.do</c:when>
	<c:when test="${nameValue == 'getGroupCode'}">${pageContext.request.contextPath}/marketing/adminTargeting/getGroupCode.do</c:when>
	<c:when test="${nameValue == 'getLvlJoinMainTbl'}">${pageContext.request.contextPath}/marketing/adminTargeting/getLvlJoinMainTbl.do</c:when>
	<c:when test="${nameValue == 'removeLevJoin'}">${pageContext.request.contextPath}/marketing/adminTargeting/removeLevJoin.do</c:when>



	<%--  타겟팅 사용자 --%>
	<c:when test="${nameValue == 'getSubjectFieldList'}">${pageContext.request.contextPath}/marketing/userTargeting/getSubjectFieldList.do</c:when>
	<c:when test="${nameValue == 'getTargetCount'}">${pageContext.request.contextPath}/marketing/userTargeting/getTargetCount.do</c:when>
	<c:when test="${nameValue == 'getTargetLevelList'}">${pageContext.request.contextPath}/marketing/userTargeting/getTargetLevelList.do</c:when>
	<c:when test="${nameValue == 'setNewSegment'}">${pageContext.request.contextPath}/marketing/userTargeting/setNewSegment.do</c:when>
	<c:when test="${nameValue == 'getSegmentList'}">${pageContext.request.contextPath}/marketing/userTargeting/getSegmentList.do</c:when>
	<c:when test="${nameValue == 'getFieldValueList'}">${pageContext.request.contextPath}/marketing/userTargeting/getFieldValueList.do</c:when>

	<c:when test="${nameValue == 'editFilterValue'}">${pageContext.request.contextPath}/marketing/userTargeting/editFilterValue.do</c:when>
	<c:when test="${nameValue == 'setFilterValue'}">${pageContext.request.contextPath}/marketing/userTargeting/setFilterValue.do</c:when>
	<c:when test="${nameValue == 'getSegmentList2'}">${pageContext.request.contextPath}/marketing/userTargeting/getSegmentList.do</c:when>
	<c:when test="${nameValue == 'getFieldvalue'}">${pageContext.request.contextPath}/marketing/userTargeting/getFieldvalue.do</c:when>
	<c:when test="${nameValue == 'getFieldDefValue'}">${pageContext.request.contextPath}/marketing/userTargeting/getFieldDefValue.do</c:when>

	<c:when test="${nameValue == 'deleteFilterValue'}">${pageContext.request.contextPath}/marketing/userTargeting/deleteFilterValue.do</c:when>
	<c:when test="${nameValue == 'getFieldFilterList'}">${pageContext.request.contextPath}/marketing/userTargeting/getFieldFilterList.do</c:when>
	<c:when test="${nameValue == 'setTargetSegment'}">${pageContext.request.contextPath}/marketing/userTargeting/setTargetSegment.do</c:when>
	<c:when test="${nameValue == 'getSegmentQuery'}">${pageContext.request.contextPath}/marketing/userTargeting/getSegmentQuery.do</c:when>
	<c:when test="${nameValue == 'setEmptyField'}">${pageContext.request.contextPath}/marketing/userTargeting/setEmptyField.do</c:when>
	<c:when test="${nameValue == 'updateAndOr'}">${pageContext.request.contextPath}/marketing/userTargeting/updateAndOr.do</c:when>
	<c:when test="${nameValue == 'targetLoadCheck'}">${pageContext.request.contextPath}/marketing/userTargeting/targetLoadCheck.do</c:when>
	<c:when test="${nameValue == 'targetCopySegment'}">${pageContext.request.contextPath}/marketing/userTargeting/targetCopySegment.do</c:when>
	<c:when test="${nameValue == 'segFilterSeq'}">${pageContext.request.contextPath}/marketing/userTargeting/segFilterSeq.do</c:when>
	<c:when test="${nameValue == 'setGroupFilterList'}">${pageContext.request.contextPath}/marketing/userTargeting/setGroupFilterList.do</c:when>

	<c:when test="${nameValue == 'getSegColNames'}">${pageContext.request.contextPath}/marketing/userTargeting/getSegColNames.do</c:when>
	<c:when test="${nameValue == 'getSegDataList'}">${pageContext.request.contextPath}/marketing/userTargeting/getSegDataList.do</c:when>
	<c:when test="${nameValue == 'excelExportSegmentTargetList'}">${pageContext.request.contextPath}/marketing/userTargeting/excelExportSegmentTargetList.do</c:when>

	<c:when test="${nameValue == 'getGroupFieldList'}">${pageContext.request.contextPath}/marketing/userTargeting/getGroupFieldList.do</c:when>

	<c:when test="${nameValue == 'checkFilterType'}">${pageContext.request.contextPath}/marketing/userTargeting/checkFilterType.do</c:when>

	<%-- 반응정보 관리 --%>
	<c:when test="${nameValue == 'getResponseInfoList'}">${pageContext.request.contextPath}/system/responseinfo/getResponseInfoList.do</c:when>
	<c:when test="${nameValue == 'getResponseInfoDetail'}">${pageContext.request.contextPath}/system/responseinfo/getResponseInfoDetail.do</c:when>
	<c:when test="${nameValue == 'insertResponseInfo'}">${pageContext.request.contextPath}/system/responseinfo/insertResponseInfo.do</c:when>
	<c:when test="${nameValue == 'updateResponseInfo'}">${pageContext.request.contextPath}/system/responseinfo/updateResponseInfo.do</c:when>
	<c:when test="${nameValue == 'deleteResponseInfo'}">${pageContext.request.contextPath}/system/responseinfo/deleteResponseInfo.do</c:when>


	<%-- 박지열 외부 테이블 --%>
	<c:when test="${nameValue == 'getTgtLevelList'}">${pageContext.request.contextPath}/marketing/outTable/getTgtLevelList.do</c:when>
	<c:when test="${nameValue == 'getTableList'}">${pageContext.request.contextPath}/marketing/outTable/getTableList.do</c:when>
	<c:when test="${nameValue == 'getcolumnList'}">${pageContext.request.contextPath}/marketing/outTable/getcolumnList.do</c:when>
	<c:when test="${nameValue == 'getDtlTgtLevel'}">${pageContext.request.contextPath}/marketing/outTable/getDtlTgtLevel.do</c:when>
	<c:when test="${nameValue == 'getDtlTable'}">${pageContext.request.contextPath}/marketing/outTable/getDtlTable.do</c:when>
	<c:when test="${nameValue == 'getDtlcolumn'}">${pageContext.request.contextPath}/marketing/outTable/getDtlcolumn.do</c:when>

	<c:when test="${nameValue == 'setOutColumn'}">${pageContext.request.contextPath}/marketing/outTable/setOutColumn.do</c:when>
	<c:when test="${nameValue == 'setOutTable'}">${pageContext.request.contextPath}/marketing/outTable/setOutTable.do</c:when>
	<c:when test="${nameValue == 'setTgtLevel'}">${pageContext.request.contextPath}/marketing/outTable/setTgtLevel.do</c:when>
	<c:when test="${nameValue == 'setChnlRel'}">${pageContext.request.contextPath}/marketing/outTable/setChnlRel.do</c:when>

	<c:when test="${nameValue == 'removeOutTbl'}">${pageContext.request.contextPath}/marketing/outTable/removeOutTbl.do</c:when>
	<c:when test="${nameValue == 'removeOutColumn'}">${pageContext.request.contextPath}/marketing/outTable/removeOutColumn.do</c:when>
	<c:when test="${nameValue == 'removeOutTgtLvl'}">${pageContext.request.contextPath}/marketing/outTable/removeOutTgtLvl.do</c:when>
	<c:when test="${nameValue == 'removeChnlRel'}">${pageContext.request.contextPath}/marketing/outTable/removeChnlRel.do</c:when>
	<c:when test="${nameValue == 'removeColConChnlRel'}">${pageContext.request.contextPath}/marketing/outTable/removeColConChnlRel.do</c:when>
	<%-- <c:when test="${nameValue == 'removeTblConCol'}">${pageContext.request.contextPath}/marketing/outTable/removeTblConCol.do</c:when> --%>
	<c:when test="${nameValue == 'removeTvlConTable'}">${pageContext.request.contextPath}/marketing/outTable/removeTvlConTable.do</c:when>

	<c:when test="${nameValue == 'editOutTbl'}">${pageContext.request.contextPath}/marketing/outTable/editOutTbl.do</c:when>
	<c:when test="${nameValue == 'editOutColumn'}">${pageContext.request.contextPath}/marketing/outTable/editOutColumn.do</c:when>
	<c:when test="${nameValue == 'editOutTgtLvl'}">${pageContext.request.contextPath}/marketing/outTable/editOutTgtLvl.do</c:when>

	<c:when test="${nameValue == 'getoutchannel'}">${pageContext.request.contextPath}/marketing/outTable/getchannel.do</c:when>
	<c:when test="${nameValue == 'getoutchannelrel'}">${pageContext.request.contextPath}/marketing/outTable/getchannelrel.do</c:when>
	<c:when test="${nameValue == 'getpermissionList'}">${pageContext.request.contextPath}/marketing/outTable/getpermissionList.do</c:when>

	<c:when test="${nameValue == 'getTblcountCheck'}">${pageContext.request.contextPath}/marketing/outTable/getTblcountCheck.do</c:when>
	<c:when test="${nameValue == 'getcolCountCheck'}">${pageContext.request.contextPath}/marketing/outTable/getcolCountCheck.do</c:when>
    <c:when test="${nameValue == 'modifyCouponStatus'}">${pageContext.request.contextPath}/marketing/offer/modifyCouponStatus.do</c:when>

	<c:when test="${nameValue == 'campaignStatusCheck'}">${pageContext.request.contextPath}/loyalty/campaign/campaignStatusCheck.do</c:when>
	<c:when test="${nameValue == 'campaignStatusCheckMkt'}">${pageContext.request.contextPath}/marketing/campaign/campaignStatusCheck.do</c:when>

	<c:when test="${nameValue == 'getFtpConnect'}">${pageContext.request.contextPath}/marketing/outTable/getFtpConnect.do</c:when>
	<c:when test="${nameValue == 'getEmailHost'}">${pageContext.request.contextPath}/marketing/outTable/getEmailHost.do</c:when>
	<c:when test="${nameValue == 'getwebService'}">${pageContext.request.contextPath}/marketing/outTable/getwebService.do</c:when>
    <c:when test="${nameValue == 'getwebServiceDetailPop'}">${pageContext.request.contextPath}/marketing/outTable/getwebServiceDetailPop.do</c:when>
	<c:when test="${nameValue == 'getDetailEmailHost'}">${pageContext.request.contextPath}/marketing/outTable/getDetailEmailHost.do</c:when>
	<c:when test="${nameValue == 'setemailHost'}">${pageContext.request.contextPath}/marketing/outTable/setemailHost.do</c:when>
	<c:when test="${nameValue == 'editemailHost'}">${pageContext.request.contextPath}/marketing/outTable/editemailHost.do</c:when>
	<c:when test="${nameValue == 'removeEmailHost'}">${pageContext.request.contextPath}/marketing/outTable/removeEmailHost.do</c:when>
	<c:when test="${nameValue == 'saveEmailHost'}">${pageContext.request.contextPath}/marketing/outTable/saveEmailHost.do</c:when>
	<c:when test="${nameValue == 'editFtpConnect'}">${pageContext.request.contextPath}/marketing/outTable/editFtpConnect.do</c:when>
	<c:when test="${nameValue == 'removeFtpConnect'}">${pageContext.request.contextPath}/marketing/outTable/removeFtpConnect.do</c:when>
    <c:when test="${nameValue == 'insertWebService'}">${pageContext.request.contextPath}/marketing/outTable/insertWebService.do</c:when>
    <c:when test="${nameValue == 'updateWebService'}">${pageContext.request.contextPath}/marketing/outTable/updateWebService.do</c:when>
    <c:when test="${nameValue == 'deleteWebService'}">${pageContext.request.contextPath}/marketing/outTable/deleteWebService.do</c:when>
	<c:when test="${nameValue == 'setFtpConnect'}">${pageContext.request.contextPath}/marketing/outTable/setFtpConnect.do</c:when>

	<%-- 어카운트 --%>
	<%-- <c:when test="${nameValue == 'getAccountList'}">${pageContext.request.contextPath}/system/account/getAccountList.do</c:when>
	<c:when test="${nameValue == 'getAccount'}">${pageContext.request.contextPath}/system/account/getAccount.do</c:when>
	<c:when test="${nameValue == 'setAccount'}">${pageContext.request.contextPath}/system/account/setAccount.do</c:when>
	<c:when test="${nameValue == 'modifyAccount'}">${pageContext.request.contextPath}/system/account/modifyAccount.do</c:when>
	<c:when test="${nameValue == 'accntNmchk'}">${pageContext.request.contextPath}/system/account/accntNmchk.do</c:when> --%>


	<%--
         Kepler Action URL Configuration Start
     --%>
	<c:when test="${nameValue == 'getCommonColumnValueList'}">${pageContext.request.contextPath}/kepler/common/getCommonColumnValueList.do</c:when>
	<c:when test="${nameValue == 'getCommonDateCodeList'}">${pageContext.request.contextPath}/kepler/common/getCommonDateCodeList.do</c:when>

	<%-- Common Folder/Analysis Node List --%>
	<c:when test="${nameValue == 'getNodeList'}">${pageContext.request.contextPath}/kepler/common/getNodeList.do</c:when>
	<c:when test="${nameValue == 'addFolder'}">${pageContext.request.contextPath}/kepler/common/addFolder.do</c:when>
	<c:when test="${nameValue == 'editFolder'}">${pageContext.request.contextPath}/kepler/common/editFolder.do</c:when>
	<c:when test="${nameValue == 'removeFolder'}">${pageContext.request.contextPath}/kepler/common/removeFolder.do</c:when>

	<%-- Logical Component --%>
	<c:when test="${nameValue == 'addLogicalComponent'}">${pageContext.request.contextPath}/kepler/logicalComponent/addLogicalComponent.do</c:when>
	<c:when test="${nameValue == 'addLogicalComponentSaveAs'}">${pageContext.request.contextPath}/kepler/logicalComponent/addLogicalComponentSaveAs.do</c:when>
	<c:when test="${nameValue == 'editLogicalComponent'}">${pageContext.request.contextPath}/kepler/logicalComponent/editLogicalComponent.do</c:when>
	<c:when test="${nameValue == 'editLogicalComponentAttributeGroupColumnName'}">${pageContext.request.contextPath}/kepler/logicalComponent/editLogicalComponentAttributeGroupColumnName.do</c:when>
	<c:when test="${nameValue == 'removeLogicalComponent'}">${pageContext.request.contextPath}/kepler/logicalComponent/removeLogicalComponent.do</c:when>
	<c:when test="${nameValue == 'getLogicalComponentList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getLogicalComponentList.do</c:when>
	<c:when test="${nameValue == 'getLogicalComponentDetail'}">${pageContext.request.contextPath}/kepler/logicalComponent/getLogicalComponentDetail.do</c:when>

	<c:when test="${nameValue == 'getJoinAccordionList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getJoinAccordionList.do</c:when>
	<c:when test="${nameValue == 'getJoinDbServiceComboList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getJoinDbServiceComboList.do</c:when>
	<c:when test="${nameValue == 'getJoinColumnMasterList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getJoinColumnMasterList.do</c:when>
	<c:when test="${nameValue == 'getLgcCompGrpColMstList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getLgcCompGrpColMstList.do</c:when>
	<c:when test="${nameValue == 'getJoinColumnMasterPopupList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getJoinColumnMasterPopupList.do</c:when>

	<c:when test="${nameValue == 'getAttributeGroupLeftAccordionList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getAttributeGroupLeftAccordionList.do</c:when>
	<c:when test="${nameValue == 'getAttributeGroupTreeNodeList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getAttributeGroupTreeNodeList.do</c:when>
	<c:when test="${nameValue == 'addAttributeGroup'}">${pageContext.request.contextPath}/kepler/logicalComponent/addAttributeGroup.do</c:when>
	<c:when test="${nameValue == 'checkAttributeCalField'}">${pageContext.request.contextPath}/kepler/logicalComponent/checkAttributeCalField.do</c:when>
	<c:when test="${nameValue == 'getSegRptUsedList'}">${pageContext.request.contextPath}/kepler/logicalComponent/getSegRptUsedList.do</c:when>

	<%-- Dashboard --%>
	<c:when test="${nameValue == 'getDashboardLayoutList'}">${pageContext.request.contextPath}/kepler/dashboard/getDashboardLayoutList.do</c:when>
	<c:when test="${nameValue == 'getDashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/getDashboardDetail.do</c:when>
	<c:when test="${nameValue == 'getDashboardNameCheck'}">${pageContext.request.contextPath}/kepler/dashboard/getDashboardNameCheck.do</c:when>

	<c:when test="${nameValue == 'addDashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/addDashboardDetail.do</c:when>
	<c:when test="${nameValue == 'editDashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/editDashboardDetail.do</c:when>
	<c:when test="${nameValue == 'editDashboardDetailSave'}">${pageContext.request.contextPath}/kepler/dashboard/editDashboardDetailSave.do</c:when>
	<c:when test="${nameValue == 'editDashboardDetailSaveAs'}">${pageContext.request.contextPath}/kepler/dashboard/editDashboardDetailSaveAs.do</c:when>
	<c:when test="${nameValue == 'removeDashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/removeDashboardDetail.do</c:when>

	<c:when test="${nameValue == 'addDashboardAnalysisDetail'}">${pageContext.request.contextPath}/kepler/dashboard/addDashboardAnalysisDetail.do</c:when>
	<c:when test="${nameValue == 'removeDashboardAnalysisDetail'}">${pageContext.request.contextPath}/kepler/dashboard/removeDashboardAnalysisDetail.do</c:when>
	<c:when test="${nameValue == 'removeDashboardAnalysisList'}">${pageContext.request.contextPath}/kepler/dashboard/removeDashboardAnalysisList.do</c:when>

	<c:when test="${nameValue == 'getPublishDashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/getPublishDashboardDetail.do</c:when>
	<c:when test="${nameValue == 'selectDashBoardPromptCheck'}">${pageContext.request.contextPath}/kepler/dashboardPrompt/selectDashBoardPromptCheck.do</c:when>


	<%-- 리포트 --%>
	<c:when test="${nameValue == 'getSelectStoreCd'}">${pageContext.request.contextPath}/kepler/report/getSelectStoreCd.do</c:when>
	<c:when test="${nameValue == 'daysSalseList'}">${pageContext.request.contextPath}/kepler/report/daysSalseList.do</c:when>
	<c:when test="${nameValue == 'daysSalseExport'}">${pageContext.request.contextPath}/kepler/report/daysSalseExport.do</c:when>
	<c:when test="${nameValue == 'monthSalseList'}">${pageContext.request.contextPath}/kepler/report/monthSalseList.do</c:when>
	<c:when test="${nameValue == 'monthSalseExport'}">${pageContext.request.contextPath}/kepler/report/monthSalseExport.do</c:when>
	<c:when test="${nameValue == 'noneBuyMbr'}">${pageContext.request.contextPath}/kepler/report/noneBuyMbr.do</c:when>
	<c:when test="${nameValue == 'timesSalList'}">${pageContext.request.contextPath}/kepler/report/timesSalList.do</c:when>
	<c:when test="${nameValue == 'timesSalListExport'}">${pageContext.request.contextPath}/kepler/report/timesSalListExport.do</c:when>
	<c:when test="${nameValue == 'getSelectIncreaseMbr'}">${pageContext.request.contextPath}/kepler/report/getSelectIncreaseMbr.do</c:when>
	<c:when test="${nameValue == 'increaseMbrExport'}">${pageContext.request.contextPath}/kepler/report/increaseMbrExport.do</c:when>
	<c:when test="${nameValue == 'mbrCaseList'}">${pageContext.request.contextPath}/kepler/report/mbrCaseList.do</c:when>
	<c:when test="${nameValue == 'mbrCaseListExport'}">${pageContext.request.contextPath}/kepler/report/mbrCaseListExport.do</c:when>
	<c:when test="${nameValue == 'mbrPntSaveUseList'}">${pageContext.request.contextPath}/kepler/report/mbrPntSaveUseList.do</c:when>
	<c:when test="${nameValue == 'mbrPntSaveUseExport'}">${pageContext.request.contextPath}/kepler/report/mbrPntSaveUseExport.do</c:when>
	<c:when test="${nameValue == 'mbrMonthSalList'}">${pageContext.request.contextPath}/kepler/report/mbrMonthSalList.do</c:when>
	<c:when test="${nameValue == 'mbrMonthSalListExport'}">${pageContext.request.contextPath}/kepler/report/mbrMonthSalListExport.do</c:when>
	<c:when test="${nameValue == 'salCntAmtList'}">${pageContext.request.contextPath}/kepler/report/salCntAmtList.do</c:when>
	<c:when test="${nameValue == 'salCntAmtListExport'}">${pageContext.request.contextPath}/kepler/report/salCntAmtListExport.do</c:when>
	<c:when test="${nameValue == 'campaignChnReaction'}">${pageContext.request.contextPath}/kepler/report/campaignChnReaction.do</c:when>
	<c:when test="${nameValue == 'getCampaignExeInfoList'}">${pageContext.request.contextPath}/kepler/report/getCampaignExeInfoList.do</c:when>
	<c:when test="${nameValue == 'getCampaignExeInfo'}">${pageContext.request.contextPath}/kepler/report/getCampaignExeInfo.do</c:when>
	<c:when test="${nameValue == 'getSendCampaignInfo'}">${pageContext.request.contextPath}/kepler/report/getSendCampaignInfo.do</c:when>
	<c:when test="${nameValue == 'getPurReactionInfoList'}">${pageContext.request.contextPath}/kepler/report/getPurReactionInfoList.do</c:when>
	<c:when test="${nameValue == 'getTransReport2'}">${pageContext.request.contextPath}/kepler/report/getTransReport2.do</c:when>
	<c:when test="${nameValue == 'getCrossReport'}">${pageContext.request.contextPath}/kepler/report/getCrossReport.do</c:when>
	<c:when test="${nameValue == 'getIncReport'}">${pageContext.request.contextPath}/kepler/report/getIncReport.do</c:when>
	<c:when test="${nameValue == 'getCrossDtlReport'}">${pageContext.request.contextPath}/kepler/report/getCrossDtlReport.do</c:when>
	<c:when test="${nameValue == 'getSegMstList'}">${pageContext.request.contextPath}/kepler/report/getSegMstList.do</c:when>
	<c:when test="${nameValue == 'ordPntListExcelDown'}">${pageContext.request.contextPath}/kepler/report/ordPntListExcelDown.do</c:when>
	
	<%-- 락앤락 리포트  --%>
	<c:when test="${nameValue == 'getTotMbrList'}">${pageContext.request.contextPath}/kepler/report/getTotMbrList.do</c:when>
	<c:when test="${nameValue == 'getKprChnlList'}">${pageContext.request.contextPath}/kepler/report/getKprChnlList.do</c:when>
	<c:when test="${nameValue == 'getMbrFlagList'}">${pageContext.request.contextPath}/kepler/report/getMbrFlagList.do</c:when>
	<c:when test="${nameValue == 'getMbrPerformList'}">${pageContext.request.contextPath}/kepler/report/getMbrPerformList.do</c:when>
	<c:when test="${nameValue == 'getTierMbrList'}">${pageContext.request.contextPath}/kepler/report/getTierMbrList.do</c:when>
	<c:when test="${nameValue == 'getOrdPntList'}">${pageContext.request.contextPath}/kepler/report/getOrdPntList.do</c:when>
	<c:when test="${nameValue == 'getOrdPntList2'}">${pageContext.request.contextPath}/kepler/report/getOrdPntList2.do</c:when>
	<c:when test="${nameValue == 'getDayTierSaleList'}">${pageContext.request.contextPath}/kepler/report/getDayTierSaleList.do</c:when>
	<c:when test="${nameValue == 'getDayTierSaleList2'}">${pageContext.request.contextPath}/kepler/report/getDayTierSaleList2.do</c:when>
	<c:when test="${nameValue == 'getCamTotList'}">${pageContext.request.contextPath}/kepler/report/getCamTotList.do</c:when>
	<c:when test="${nameValue == 'getKprCamlList'}">${pageContext.request.contextPath}/kepler/report/getKprCamlList.do</c:when>
	<c:when test="${nameValue == 'getCamTotList2'}">${pageContext.request.contextPath}/kepler/report/getCamTotList2.do</c:when>
	<c:when test="${nameValue == 'getTierMbrList2'}">${pageContext.request.contextPath}/kepler/report/getTierMbrList2.do</c:when>
	<c:when test="${nameValue == 'getTotMbrList2'}">${pageContext.request.contextPath}/kepler/report/getTotMbrList2.do</c:when>
	<c:when test="${nameValue == 'getMbrFlagList2'}">${pageContext.request.contextPath}/kepler/report/getMbrFlagList2.do</c:when>

	<c:when test="${nameValue == 'getOrdDayWeekList'}">${pageContext.request.contextPath}/kepler/report/getOrdDayWeekList.do</c:when>
	<c:when test="${nameValue == 'getOrdAgeList'}">${pageContext.request.contextPath}/kepler/report/getOrdAgeList.do</c:when>
	<c:when test="${nameValue == 'getOrdAgeList2'}">${pageContext.request.contextPath}/kepler/report/getOrdAgeList2.do</c:when>
	<c:when test="${nameValue == 'getOrdProdList'}">${pageContext.request.contextPath}/kepler/report/getOrdProdList.do</c:when>
	<c:when test="${nameValue == 'getOrdCrossList'}">${pageContext.request.contextPath}/kepler/report/getOrdCrossList.do</c:when>
	<c:when test="${nameValue == 'getPathDevice'}">${pageContext.request.contextPath}/kepler/report/getPathDevice.do</c:when>
	<c:when test="${nameValue == 'getOffPromList'}">${pageContext.request.contextPath}/kepler/report/getOffPromList.do</c:when>
	<c:when test="${nameValue == 'getKprPromList'}">${pageContext.request.contextPath}/kepler/report/getKprPromList.do</c:when>
	<c:when test="${nameValue == 'getMbrPerformList2'}">${pageContext.request.contextPath}/kepler/report/getMbrPerformList2.do</c:when>
	<c:when test="${nameValue == 'getOrdDayWeekList2'}">${pageContext.request.contextPath}/kepler/report/getOrdDayWeekList2.do</c:when>
	<c:when test="${nameValue == 'getRecommReportList'}">${pageContext.request.contextPath}/kepler/report/getRecommReportList.do</c:when>
	<c:when test="${nameValue == 'getRecommendedPersonList'}">${pageContext.request.contextPath}/kepler/report/getRecommendedPersonList.do</c:when>
	<c:when test="${nameValue == 'getOrdProdpurMbrCnt'}">${pageContext.request.contextPath}/kepler/report/getOrdProdpurMbrCnt.do</c:when>
	<c:when test="${nameValue == 'getEmpAggPntReport'}">${pageContext.request.contextPath}/kepler/report/getEmpAggPntReport.do</c:when>
	<c:when test="${nameValue == 'getStoreAggPntReport'}">${pageContext.request.contextPath}/kepler/report/getStoreAggPntReport.do</c:when>
	<c:when test="${nameValue == 'getStoreAggPntReport2'}">${pageContext.request.contextPath}/kepler/report/getStoreAggPntReport2.do</c:when>
	<c:when test="${nameValue == 'getStoreEmpAggPntReport'}">${pageContext.request.contextPath}/kepler/report/getStoreEmpAggPntReport.do</c:when>
	<c:when test="${nameValue == 'getStoreEmpAggPntReport2'}">${pageContext.request.contextPath}/kepler/report/getStoreEmpAggPntReport2.do</c:when>
	<c:when test="${nameValue == 'getOffPromList2'}">${pageContext.request.contextPath}/kepler/report/getOffPromList2.do</c:when>
	<c:when test="${nameValue == 'getOrdProdList2'}">${pageContext.request.contextPath}/kepler/report/getOrdProdList2.do</c:when>
    <c:when test="${nameValue == 'getEmpAggUsePntReport'}">${pageContext.request.contextPath}/kepler/report/getEmpAggUsePntReport.do</c:when>
	<c:when test="${nameValue == 'getOnlineOrderPerfomList'}">${pageContext.request.contextPath}/kepler/report/getOnlineOrderPerfomList.do</c:when>
	<c:when test="${nameValue == 'getOnlineOrderDetail'}">${pageContext.request.contextPath}/kepler/report/getOnlineOrderDetail.do</c:when>
	<%-- Dashboard Prompt --%>
	<c:when test="${nameValue == 'getDashboardCommonColumnList'}">${pageContext.request.contextPath}/kepler/dashboardPrompt/getDashboardCommonColumnList.do</c:when>
	<c:when test="${nameValue == 'getDashboardPromptList'}">${pageContext.request.contextPath}/kepler/dashboardPrompt/getDashboardPromptList.do</c:when>
	<c:when test="${nameValue == 'saveDashboardPrompt'}">${pageContext.request.contextPath}/kepler/dashboardPrompt/saveDashboardPrompt.do</c:when>

	<%-- Common Logical Component Tree List --%>
	<c:when test="${nameValue == 'getLogicalComponentTreeList'}">${pageContext.request.contextPath}/kepler/common/getLogicalComponentTreeList.do</c:when>

	<%-- Common Logical Component List--%>
	<c:when test="${nameValue == 'getCommonLogicalComponentList'}">${pageContext.request.contextPath}/kepler/common/getCommonLogicalComponentList.do</c:when>

	<%-- Segment List--%>
	<c:when test="${nameValue == 'getSegmentList_KPR'}">${pageContext.request.contextPath}/kepler/segment/getSegmentList.do</c:when>

	<%-- Segment Logical Component List--%>
	<c:when test="${nameValue == 'getSegmentLogicalComponentList'}">${pageContext.request.contextPath}/kepler/segment/getLogicalComponentList.do</c:when>

	<%-- Segment Add--%>
	<c:when test="${nameValue == 'addSegment'}">${pageContext.request.contextPath}/kepler/segment/addSegment.do</c:when>

	<%-- Segment attribute group column value list--%>
	<c:when test="${nameValue == 'getAttributeGroupColumnValueList'}">${pageContext.request.contextPath}/kepler/segment/getAttributeGroupColumnValueList.do</c:when>

	<%-- Segment all count--%>
	<c:when test="${nameValue == 'getSegmentAllCount'}">${pageContext.request.contextPath}/kepler/segment/getSegmentAllCount.do</c:when>

	<%-- Segment Detail--%>
	<c:when test="${nameValue == 'getSegmentDetail'}">${pageContext.request.contextPath}/kepler/segment/getSegmentDetail.do</c:when>

	<%-- Segment filter save--%>
	<c:when test="${nameValue == 'saveSegmentFilter'}">${pageContext.request.contextPath}/kepler/segment/saveSegmentFilter.do</c:when>

	<%-- Segment Detail Different save--%>
	<c:when test="${nameValue == 'saveAsDifferentSegment'}">${pageContext.request.contextPath}/kepler/segment/saveAsDifferentSegment.do</c:when>

	<%-- Segment Detail save--%>
	<c:when test="${nameValue == 'saveSegment'}">${pageContext.request.contextPath}/kepler/segment/saveSegment.do</c:when>

	<%-- Segment remove--%>
	<c:when test="${nameValue == 'removeSegment'}">${pageContext.request.contextPath}/kepler/segment/removeSegment.do</c:when>

	<%-- Segment logical component id edit --%>
	<c:when test="${nameValue == 'editSegmentLogicalComponentId'}">${pageContext.request.contextPath}/kepler/segment/editSegmentLogicalComponentId.do</c:when>

	<%-- Segment logical component column list --%>
	<c:when test="${nameValue == 'getLogicalComponentColumnList'}">${pageContext.request.contextPath}/kepler/segment/getLogicalComponentColumnList.do</c:when>

	<%-- Segment reset all filter count --%>
	<c:when test="${nameValue == 'resetAllSegmentFilterCount'}">${pageContext.request.contextPath}/kepler/segment/resetAllSegmentFilterCount.do</c:when>
	<c:when test="${nameValue == 'resetSegmentFilterCount'}">${pageContext.request.contextPath}/kepler/segment/resetSegmentFilterCount.do</c:when>

	<%-- targetGroup List--%>
	<c:when test="${nameValue == 'getTargetGroupList'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupList.do</c:when>
	<c:when test="${nameValue == 'getTargetGroupImportList'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupImportList.do</c:when>

	<%-- targetGroup add--%>
	<c:when test="${nameValue == 'getTargetGroup'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroup.do</c:when>
	<c:when test="${nameValue == 'getTargetGroupCount'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupCount.do</c:when>
	<c:when test="${nameValue == 'getMbrNoFromCust'}">${pageContext.request.contextPath}/kepler/targetGroup/getMbrNoFromCust.do</c:when>

	<%-- targetGroup target List--%>
	<c:when test="${nameValue == 'getTargetGroupTargetList'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupTargetList.do</c:when>

	<%-- targetGroup add--%>
	<c:when test="${nameValue == 'addTargetGroup'}">${pageContext.request.contextPath}/kepler/targetGroup/addTargetGroup.do</c:when>

	<%-- targetGroup edit--%>
	<c:when test="${nameValue == 'editTargetGroup'}">${pageContext.request.contextPath}/kepler/targetGroup/editTargetGroup.do</c:when>

	<%-- targetGroup remove--%>
	<c:when test="${nameValue == 'removeTargetGroup'}">${pageContext.request.contextPath}/kepler/targetGroup/removeTargetGroup.do</c:when>

	<%-- targetGroup column List--%>
	<c:when test="${nameValue == 'getTargetGroupColumnList'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupColumnList.do</c:when>

	<%-- targetGroup column All List--%>
	<c:when test="${nameValue == 'getTargetGroupColumnAllList'}">${pageContext.request.contextPath}/kepler/targetGroup/getTargetGroupColumnAllList.do</c:when>

	<%-- targetGroup column save --%>
	<c:when test="${nameValue == 'saveTargetGroupColumn'}">${pageContext.request.contextPath}/kepler/targetGroup/saveTargetGroupColumn.do</c:when>

	<%-- targetGroup export excel target List --%>
	<c:when test="${nameValue == 'exportExcelTargetGroupTargetList'}">${pageContext.request.contextPath}/kepler/targetGroup/exportExcelTargetGroupTargetList.do</c:when>

	<%-- SimpleTargeting --%>
	<c:when test="${nameValue == 'getTargetSimpleList'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleList.do</c:when>
	<c:when test="${nameValue == 'getTargetSimpleGroupName'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleGroupName.do</c:when>
	<c:when test="${nameValue == 'getTargetSimpleListColNameCondition'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleListColNameCondition.do</c:when>
	<c:when test="${nameValue == 'getTargetSimpleGroupTopNameCondition'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleGroupTopNameCondition.do</c:when>
	<c:when test="${nameValue == 'setTargetSimpleGroupNameTargetingGroupCondition'}">${pageContext.request.contextPath}/kepler/targetSimple/setTargetSimpleGroupNameTargetingGroupCondition.do</c:when>
	<c:when test="${nameValue == 'getTargetGroupOfSimple'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetGroupOfSimple.do</c:when>
	<c:when test="${nameValue == 'getTargetSimpleGroupValue'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleGroupValue.do</c:when>
	<c:when test="${nameValue == 'getTargetSimpleGroupUpdate'}">${pageContext.request.contextPath}/kepler/targetSimple/getTargetSimpleGroupUpdate.do</c:when>
	<c:when test="${nameValue == 'setTargetingCountBtn'}">${pageContext.request.contextPath}/kepler/targetSimple/setTargetingCountBtn.do</c:when>
	<c:when test="${nameValue == 'getSimpleTargetList'}">${pageContext.request.contextPath}/kepler/targetSimple/getSimpleTargetList.do</c:when>
	<c:when test="${nameValue == 'getSimpleGridListExport'}">${pageContext.request.contextPath}/kepler/targetSimple/getSimpleGridListExport.do</c:when>
	<c:when test="${nameValue == 'getSimpleList'}">${pageContext.request.contextPath}/kepler/targetSimple/getSimpleList.do</c:when>
	<c:when test="${nameValue == 'getSimpleTargetGroupColumnAllList'}">${pageContext.request.contextPath}/kepler/targetSimple/getSimpleTargetGroupColumnAllList.do</c:when>
	<c:when test="${nameValue == 'getSimpleTargetGroupColumnList'}">${pageContext.request.contextPath}/kepler/targetSimple/getSimpleTargetGroupColumnList.do</c:when>

	<%-- target sql --%>
	<c:when test="${nameValue == 'getTargetSqlDetail'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetSqlDetail.do</c:when>
	<c:when test="${nameValue == 'getTargetSqlDBInfo'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetSqlDBInfo.do</c:when>
	<c:when test="${nameValue == 'getTargetSqlTargetList'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetSqlTargetList.do</c:when>
	<c:when test="${nameValue == 'exportExcelTargetSqlTargetList'}">${pageContext.request.contextPath}/kepler/targetSql/exportExcelTargetSqlTargetList.do</c:when>
	<c:when test="${nameValue == 'targetSqlValidation'}">${pageContext.request.contextPath}/kepler/targetSql/targetSqlValidation.do</c:when>
	<c:when test="${nameValue == 'saveTargetSql'}">${pageContext.request.contextPath}/kepler/targetSql/saveTargetSql.do</c:when>
	<c:when test="${nameValue == 'getTargetSqlCount'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetSqlCount.do</c:when>
	<c:when test="${nameValue == 'getTargetSqlList'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetSqlList.do</c:when>
	<c:when test="${nameValue == 'getTargetCafe24List'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetCafe24List.do</c:when>
	<c:when test="${nameValue == 'exportExcelTargetCafe24List'}">${pageContext.request.contextPath}/kepler/targetSql/exportExcelTargetCafe24List.do</c:when>
	<c:when test="${nameValue == 'getTargetCafe24YnFlag'}">${pageContext.request.contextPath}/kepler/targetSql/getTargetCafe24YnFlag.do</c:when>

    <%-- Target Import --%>
    <c:when test="${nameValue == 'getTargetGroupImportDetail'}">${pageContext.request.contextPath}/kepler/targetImport/getTargetGroupImportDetail.do</c:when>
    <c:when test="${nameValue == 'saveTargetGroupImport'}">${pageContext.request.contextPath}/kepler/targetImport/saveTargetGroupImport.do</c:when>
    <c:when test="${nameValue == 'setTargetGroupItemUpload'}">${pageContext.request.contextPath}/kepler/targetImport/setTargetGroupItemUpload.do</c:when>
    <c:when test="${nameValue == 'getTargetGroupImportColumnList'}">${pageContext.request.contextPath}/kepler/targetImport/getTargetGroupImportColumnList.do</c:when>
    <c:when test="${nameValue == 'getTargetGroupImportTargetList'}">${pageContext.request.contextPath}/kepler/targetImport/getTargetGroupImportTargetList.do</c:when>
    <c:when test="${nameValue == 'exportExcelTargetGroupImportTargetList'}">${pageContext.request.contextPath}/kepler/targetImport/exportExcelTargetGroupImportTargetList.do</c:when>
    <c:when test="${nameValue == 'copytgtImportData'}">${pageContext.request.contextPath}/kepler/targetImport/copytgtImportData.do</c:when>


     <%-- 카페24타겟팅 --%>
 	<c:when test="${nameValue == 'saveCf24TargetGroup'}">${pageContext.request.contextPath}/kepler/targetSql/saveCf24TargetGroup.do</c:when>

	<%-- Analysis Common --%>
	<c:when test="${nameValue == 'getAnalysisModifyCheck'}">${pageContext.request.contextPath}/kepler/common/getAnalysisModifyCheck.do</c:when>

	<%-- Analysis Master --%>
	<c:when test="${nameValue == 'getAnalysisList'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisDetail'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisDetail.do</c:when>
	<c:when test="${nameValue == 'getAnalysisName'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisName.do</c:when>

	<c:when test="${nameValue == 'addAnalysisDetail'}">${pageContext.request.contextPath}/kepler/analysis/addAnalysisDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisDetailSave'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisDetailSave.do</c:when>
	<c:when test="${nameValue == 'editAnalysisDetailSaveAs'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisDetailSaveAs.do</c:when>
	<c:when test="${nameValue == 'editAnalysisLogicalCompId'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisLogicalCompId.do</c:when>
	<c:when test="${nameValue == 'resetAnalysisDetail'}">${pageContext.request.contextPath}/kepler/analysis/resetAnalysisDetail.do</c:when>
	<c:when test="${nameValue == 'removeAnalysisDetail'}">${pageContext.request.contextPath}/kepler/analysis/removeAnalysisDetail.do</c:when>

	<c:when test="${nameValue == 'editAnalysisColumnGroupFlag'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisColumnGroupFlag.do</c:when>
	<c:when test="${nameValue == 'editAnalysisChartTypeChange'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisChartTypeChange.do</c:when>

	<c:when test="${nameValue == 'getAnalysisAtribGroupColumnList'}">${pageContext.request.contextPath}/kepler/analysisCommon/getAnalysisAtribGroupColumnList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisAtribGroupColumnDetail'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisAtribGroupColumnDetail.do</c:when>

	<c:when test="${nameValue == 'getAnalysisExtenalRequestBase'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisExtenalRequestBase.do</c:when>

	<c:when test="${nameValue == 'getAnalyticsExportData'}">${pageContext.request.contextPath}/kepler/analytics/getAnalyticsExportData.do</c:when>

	<c:when test="${nameValue == 'editAnalysisDetailCopy'}">${pageContext.request.contextPath}/kepler/analysis/editAnalysisDetailCopy.do</c:when>
	<c:when test="${nameValue == 'editDashboardDetailCopy'}">${pageContext.request.contextPath}/kepler/dashboard/editDashboardDetailCopy.do</c:when>

	<c:when test="${nameValue == 'getAnalysisAtribGroupColumnValueList'}">${pageContext.request.contextPath}/kepler/analysis/getAnalysisAtribGroupColumnValueList.do</c:when>

	<%-- Analysis Column --%>
	<c:when test="${nameValue == 'getAnalysisColumnList'}">${pageContext.request.contextPath}/kepler/analysisColumn/getAnalysisColumnList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisColumnDetail'}">${pageContext.request.contextPath}/kepler/analysisColumn/getAnalysisColumnDetail.do</c:when>
	<c:when test="${nameValue == 'addAnalysisColumnDetail'}">${pageContext.request.contextPath}/kepler/analysisColumn/addAnalysisColumnDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisColumnDetail'}">${pageContext.request.contextPath}/kepler/analysisColumn/editAnalysisColumnDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisColumnAllSequence'}">${pageContext.request.contextPath}/kepler/analysisColumn/editAnalysisColumnAllSequence.do</c:when>
	<c:when test="${nameValue == 'editAnalysisColumnTypeCodeChange'}">${pageContext.request.contextPath}/kepler/analysisColumn/editAnalysisColumnTypeCodeChange.do</c:when>
	<c:when test="${nameValue == 'editAnalysisColumnCombTypeChange'}">${pageContext.request.contextPath}/kepler/analysisColumn/editAnalysisColumnCombTypeChange.do</c:when>
	<c:when test="${nameValue == 'removeAnalysisColumnDetail'}">${pageContext.request.contextPath}/kepler/analysisColumn/removeAnalysisColumnDetail.do</c:when>
	<c:when test="${nameValue == 'getAnalysisSameTableColumnList'}">${pageContext.request.contextPath}/kepler/analysisColumn/getAnalysisSameTableColumnList.do</c:when>


	<%-- Analysis Prompt --%>
	<c:when test="${nameValue == 'getAnalysisPromptList'}">${pageContext.request.contextPath}/kepler/analysisPrompt/getAnalysisPromptList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisPromptDetail'}">${pageContext.request.contextPath}/kepler/analysisPrompt/getAnalysisPromptDetail.do</c:when>
	<c:when test="${nameValue == 'addAnalysisPromptDetail'}">${pageContext.request.contextPath}/kepler/analysisPrompt/addAnalysisPromptDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisPromptDetail'}">${pageContext.request.contextPath}/kepler/analysisPrompt/editAnalysisPromptDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisPromptAllSequence'}">${pageContext.request.contextPath}/kepler/analysisPrompt/editAnalysisPromptAllSequence.do</c:when>
	<c:when test="${nameValue == 'removeAnalysisPromptDetail'}">${pageContext.request.contextPath}/kepler/analysisPrompt/removeAnalysisPromptDetail.do</c:when>
	<c:when test="${nameValue == 'selectAnalysisPromptCheck'}">${pageContext.request.contextPath}/kepler/analysisPrompt/selectAnalysisPromptCheck.do</c:when>

	<%-- Analysis Filter --%>
	<c:when test="${nameValue == 'getAnalysisFilterBase'}">${pageContext.request.contextPath}/kepler/analysisFilter/getAnalysisFilterBase.do</c:when>
	<c:when test="${nameValue == 'getAnalysisFilterList'}">${pageContext.request.contextPath}/kepler/analysisFilter/getAnalysisFilterList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisFilterDetailBase'}">${pageContext.request.contextPath}/kepler/analysisFilter/getAnalysisFilterDetailBase.do</c:when>
	<c:when test="${nameValue == 'getAnalysisFilterCheck'}">${pageContext.request.contextPath}/kepler/analysisFilter/getAnalysisFilterCheck.do</c:when>
	<c:when test="${nameValue == 'saveAnalysisFilterList'}">${pageContext.request.contextPath}/kepler/analysisFilter/saveAnalysisFilterList.do</c:when>

	<%-- Analysis Chart Setting --%>
	<c:when test="${nameValue == 'getAnalysisChartLabelDetail'}">${pageContext.request.contextPath}/kepler/analysisChartSetting/getAnalysisChartLabelDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisChartLabelDetail'}">${pageContext.request.contextPath}/kepler/analysisChartSetting/editAnalysisChartLabelDetail.do</c:when>

	<%-- Analysis Data --%>
	<c:when test="${nameValue == 'getAnalysisDateFilterCheck'}">${pageContext.request.contextPath}/kepler/analysisData/getAnalysisDateFilterCheck.do</c:when>
	<c:when test="${nameValue == 'getAnalysisPublishReport'}">${pageContext.request.contextPath}/kepler/analysisData/getAnalysisPublishReport.do</c:when>
	<c:when test="${nameValue == 'getAnalysisSetupPromptList'}">${pageContext.request.contextPath}/kepler/common/getAnalysisSetupPromptList.do</c:when>
	<c:when test="${nameValue == 'getAnalysisSetupColumnList'}">${pageContext.request.contextPath}/kepler/common/getAnalysisSetupColumnList.do</c:when>

	<%-- Analysis Table Setting --%>
	<c:when test="${nameValue == 'getAnalysisTableDetail'}">${pageContext.request.contextPath}/kepler/analysisTableSetting/getAnalysisTableDetail.do</c:when>
	<c:when test="${nameValue == 'editAnalysisTableDetail'}">${pageContext.request.contextPath}/kepler/analysisTableSetting/editAnalysisTableDetail.do</c:when>

	<%-- Customer Analysis --%>
	<c:when test="${nameValue == 'getAnalysisListByCustType'}">${pageContext.request.contextPath}/kepler/customerAnalysis/getAnalysisListByCustType.do</c:when>
	<c:when test="${nameValue == 'getAnalysisListByCustTier'}">${pageContext.request.contextPath}/kepler/customerAnalysis/getAnalysisListByCustTier.do</c:when>

	<%-- 운영관리 --%>
	<c:when test="${nameValue == 'getDbInformList'}">${pageContext.request.contextPath}/kepler/operation/getDbInformList.do</c:when>
	<c:when test="${nameValue == 'removeDbInform'}">${pageContext.request.contextPath}/kepler/operation/removeDbInform.do</c:when>
	<c:when test="${nameValue == 'dbInformDelChk'}">${pageContext.request.contextPath}/kepler/operation/dbInformDelChk.do</c:when>
	<c:when test="${nameValue == 'getDbRegist'}">${pageContext.request.contextPath}/kepler/operation/getDbRegist.do</c:when>
	<c:when test="${nameValue == 'getDbChkRegist'}">${pageContext.request.contextPath}/kepler/operation/getDbChkRegist.do</c:when>
	<c:when test="${nameValue == 'editDbRegist'}">${pageContext.request.contextPath}/kepler/operation/editDbRegist.do</c:when>
	<c:when test="${nameValue == 'setDbRegist'}">${pageContext.request.contextPath}/kepler/operation/setDbRegist.do</c:when>
	<c:when test="${nameValue == 'getIpPortChk'}">${pageContext.request.contextPath}/kepler/operation/getIpPortChk.do</c:when>
	<c:when test="${nameValue == 'saveTableImport'}">${pageContext.request.contextPath}/kepler/operation/saveTableImport.do</c:when>
	<c:when test="${nameValue == 'getDatabaseUseSchema'}">${pageContext.request.contextPath}/kepler/operation/getDatabaseUseSchema.do</c:when>
	<c:when test="${nameValue == 'saveDatabaseUseSchemaList'}">${pageContext.request.contextPath}/kepler/operation/saveDatabaseUseSchemaList.do</c:when>
	<c:when test="${nameValue == 'getDatabaseConCheck'}">${pageContext.request.contextPath}/kepler/operation/getDatabaseConCheck.do</c:when>

	<c:when test="${nameValue == 'getSubjectAreaRegistList'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaList.do</c:when>
	<c:when test="${nameValue == 'removeSubjectAreaRegist'}">${pageContext.request.contextPath}/kepler/operation/removeSubjectArea.do</c:when>
	<c:when test="${nameValue == 'subjectAreaDelChk'}">${pageContext.request.contextPath}/kepler/operation/subjectAreaDelChk.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaRegist'}">${pageContext.request.contextPath}/kepler/operation/getSubjectArea.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaChkRegist'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaChkRegist.do</c:when>
	<c:when test="${nameValue == 'editSubjectAreaRegist'}">${pageContext.request.contextPath}/kepler/operation/editSubjectArea.do</c:when>
	<c:when test="${nameValue == 'setSubjectAreaRegist'}">${pageContext.request.contextPath}/kepler/operation/setSubjectArea.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaMapping'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaMapping.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaPop'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaPop.do</c:when>
	<c:when test="${nameValue == 'getMapping'}">${pageContext.request.contextPath}/kepler/operation/getMapping.do</c:when>
	<c:when test="${nameValue == 'setMapping'}">${pageContext.request.contextPath}/kepler/operation/setMapping.do</c:when>
	<c:when test="${nameValue == 'editMapping'}">${pageContext.request.contextPath}/kepler/operation/editMapping.do</c:when>
	<c:when test="${nameValue == 'subjectDBDelChk'}">${pageContext.request.contextPath}/kepler/operation/subjectDBDelChk.do</c:when>
	<c:when test="${nameValue == 'removeSubjectDb'}">${pageContext.request.contextPath}/kepler/operation/removeSubjectDb.do</c:when>
	<c:when test="${nameValue == 'editSubjectDb'}">${pageContext.request.contextPath}/kepler/operation/editSubjectDb.do</c:when>

	<c:when test="${nameValue == 'getTableMstList_KPR'}">${pageContext.request.contextPath}/kepler/operation/getTableMstList.do</c:when>
	<c:when test="${nameValue == 'getDbServiceComboList'}">${pageContext.request.contextPath}/kepler/operation/getDbServiceComboList.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaComboList_KPR'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaComboList.do</c:when>
	<c:when test="${nameValue == 'getTblTypeComboList_KPR'}">${pageContext.request.contextPath}/kepler/operation/getTblTypeComboList.do</c:when>
	<c:when test="${nameValue == 'getTableList_KPR'}">${pageContext.request.contextPath}/kepler/operation/getTableList.do</c:when>
	<c:when test="${nameValue == 'setTableList_KPR'}">${pageContext.request.contextPath}/kepler/operation/setTableList.do</c:when>
	<c:when test="${nameValue == 'editTableList_KPR'}">${pageContext.request.contextPath}/kepler/operation/editTableList.do</c:when>
	<c:when test="${nameValue == 'tableNmChk'}">${pageContext.request.contextPath}/kepler/operation/tableNmChk.do</c:when>
	<c:when test="${nameValue == 'tableIdReturn'}">${pageContext.request.contextPath}/kepler/operation/tableIdReturn.do</c:when>
	<c:when test="${nameValue == 'tableAddColDelChk'}">${pageContext.request.contextPath}/kepler/operation/tableAddColDelChk.do</c:when>
	<c:when test="${nameValue == 'getTableLgcChk'}">${pageContext.request.contextPath}/kepler/operation/getTableLgcChk.do</c:when>

	<c:when test="${nameValue == 'getTableColList'}">${pageContext.request.contextPath}/kepler/operation/getTableColList.do</c:when>
	<c:when test="${nameValue == 'getTableAddColList'}">${pageContext.request.contextPath}/kepler/operation/getTableAddColList.do</c:when>
	<c:when test="${nameValue == 'editTableAddColList'}">${pageContext.request.contextPath}/kepler/operation/editTableAddColList.do</c:when>
	<c:when test="${nameValue == 'setTableAddColList'}">${pageContext.request.contextPath}/kepler/operation/setTableAddColList.do</c:when>
	<c:when test="${nameValue == 'removeTableAddColList'}">${pageContext.request.contextPath}/kepler/operation/removeTableAddColList.do</c:when>
	<c:when test="${nameValue == 'getTableAddColSeq'}">${pageContext.request.contextPath}/kepler/operation/getTableAddColSeq.do</c:when>
	<c:when test="${nameValue == 'getTblColNmChk'}">${pageContext.request.contextPath}/kepler/operation/getTblColNmChk.do</c:when>
	<c:when test="${nameValue == 'getCreatTblCol'}">${pageContext.request.contextPath}/kepler/operation/getCreatTblCol.do</c:when>

	<c:when test="${nameValue == 'getTableColListByType'}">${pageContext.request.contextPath}/kepler/operation/getTableColListByType.do</c:when>
	<c:when test="${nameValue == 'editTableColsType'}">${pageContext.request.contextPath}/kepler/operation/editTableColsType.do</c:when>

	<c:when test="${nameValue == 'getTableAdvance'}">${pageContext.request.contextPath}/kepler/operation/getTableAdvance.do</c:when>
	<c:when test="${nameValue == 'editTableAdvance'}">${pageContext.request.contextPath}/kepler/operation/editTableAdvance.do</c:when>

	<c:when test="${nameValue == 'getDbType'}">${pageContext.request.contextPath}/kepler/operation/getDbType.do</c:when>

	<c:when test="${nameValue == 'getIdxList'}">${pageContext.request.contextPath}/kepler/operation/getIdxList.do</c:when>
	<c:when test="${nameValue == 'getIdxInform'}">${pageContext.request.contextPath}/kepler/operation/getIdxInform.do</c:when>
	<c:when test="${nameValue == 'setIdxList'}">${pageContext.request.contextPath}/kepler/operation/setIdxList.do</c:when>
	<c:when test="${nameValue == 'editIdxList'}">${pageContext.request.contextPath}/kepler/operation/editIdxList.do</c:when>
	<c:when test="${nameValue == 'removeIdxList'}">${pageContext.request.contextPath}/kepler/operation/removeIdxList.do</c:when>
	<c:when test="${nameValue == 'getIdxNmChk'}">${pageContext.request.contextPath}/kepler/operation/getIdxNmChk.do</c:when>

	<c:when test="${nameValue == 'getIdxColList'}">${pageContext.request.contextPath}/kepler/operation/getIdxColList.do</c:when>
	<c:when test="${nameValue == 'getIdxColInform'}">${pageContext.request.contextPath}/kepler/operation/getIdxColInform.do</c:when>
	<c:when test="${nameValue == 'setIdxColList'}">${pageContext.request.contextPath}/kepler/operation/setIdxColList.do</c:when>
	<c:when test="${nameValue == 'editIdxColList'}">${pageContext.request.contextPath}/kepler/operation/editIdxColList.do</c:when>
	<c:when test="${nameValue == 'removeIdxColList'}">${pageContext.request.contextPath}/kepler/operation/removeIdxColList.do</c:when>
	<c:when test="${nameValue == 'getIdxColNmChk'}">${pageContext.request.contextPath}/kepler/operation/getIdxColNmChk.do</c:when>
	<c:when test="${nameValue == 'getCreatIdxCol'}">${pageContext.request.contextPath}/kepler/operation/getCreatIdxCol.do</c:when>

	<c:when test="${nameValue == 'getIdxAdvance'}">${pageContext.request.contextPath}/kepler/operation/getIdxAdvance.do</c:when>
	<c:when test="${nameValue == 'editIdxAdvance'}">${pageContext.request.contextPath}/kepler/operation/editIdxAdvance.do</c:when>

	<c:when test="${nameValue == 'getSourceTreeMySqlData'}">${pageContext.request.contextPath}/kepler/operation/getSourceTreeMySqlData.do</c:when>
	<c:when test="${nameValue == 'getSourceTreeOracleData'}">${pageContext.request.contextPath}/kepler/operation/getSourceTreeOracleData.do</c:when>
	<c:when test="${nameValue == 'getSourceTreeData'}">${pageContext.request.contextPath}/kepler/operation/getSourceTreeData.do</c:when>
	<c:when test="${nameValue == 'getTargetTreeData'}">${pageContext.request.contextPath}/kepler/operation/getTargetTreeData.do</c:when>
	<c:when test="${nameValue == 'getTableColImport'}">${pageContext.request.contextPath}/kepler/operation/getTableColImport.do</c:when>
	<c:when test="${nameValue == 'setTableImport'}">${pageContext.request.contextPath}/kepler/operation/setTableImport.do</c:when>
	<c:when test="${nameValue == 'setTableColImport'}">${pageContext.request.contextPath}/kepler/operation/setTableColImport.do</c:when>
	<c:when test="${nameValue == 'tableLgcChk'}">${pageContext.request.contextPath}/kepler/operation/tableLgcChk.do</c:when>
	<c:when test="${nameValue == 'removeTableColumn'}">${pageContext.request.contextPath}/kepler/operation/removeTableColumn.do</c:when>
	<c:when test="${nameValue == 'removeTable'}">${pageContext.request.contextPath}/kepler/operation/removeTable.do</c:when>
	<c:when test="${nameValue == 'getSubjectAreaNmRtn'}">${pageContext.request.contextPath}/kepler/operation/getSubjectAreaNmRtn.do</c:when>

	<c:when test="${nameValue == 'setTableCreat'}">${pageContext.request.contextPath}/kepler/operation/setTableCreat.do</c:when>
	<c:when test="${nameValue == 'setIndexCreat'}">${pageContext.request.contextPath}/kepler/operation/setIndexCreat.do</c:when>

	<c:when test="${nameValue == 'getAccountNm'}">${pageContext.request.contextPath}/kepler/operation/getAccountNm.do</c:when>
	<c:when test="${nameValue == 'getMappingColInfo'}">${pageContext.request.contextPath}/kepler/operation/getMappingColInfo.do</c:when>
	<c:when test="${nameValue == 'getExcelHaedList'}">${pageContext.request.contextPath}/kepler/operation/getExcelHaedList.do</c:when>
	<c:when test="${nameValue == 'setExcelUpload'}">${pageContext.request.contextPath}/kepler/operation/setExcelUpload.do</c:when>
	<c:when test="${nameValue == 'setReExcelUpload'}">${pageContext.request.contextPath}/kepler/operation/setReExcelUpload.do</c:when>
	<c:when test="${nameValue == 'getExcelUpResult'}">${pageContext.request.contextPath}/kepler/operation/getExcelUpResult.do</c:when>
	<c:when test="${nameValue == 'getExcelUpResultList'}">${pageContext.request.contextPath}/kepler/operation/getExcelUpResultList.do</c:when>

	<c:when test="${nameValue == 'getUploadErrorList'}">${pageContext.request.contextPath}/kepler/operation/getUploadErrorList.do</c:when>

	<%-- Analysis Drill Down Group --%>
	<c:when test="${nameValue == 'getMetaServiceList'}">${pageContext.request.contextPath}/kepler/operation/getMetaServiceList.do</c:when>
	<c:when test="${nameValue == 'getMetaTableColumnList'}">${pageContext.request.contextPath}/kepler/operation/getMetaTableColumnList.do</c:when>
	<c:when test="${nameValue == 'getDrillDownGroupList'}">${pageContext.request.contextPath}/kepler/operation/getDrillDownGroupList.do</c:when>
	<c:when test="${nameValue == 'addDrillDownGroup'}">${pageContext.request.contextPath}/kepler/operation/addDrillDownGroup.do</c:when>
	<c:when test="${nameValue == 'editDrillDownGroup'}">${pageContext.request.contextPath}/kepler/operation/editDrillDownGroup.do</c:when>
	<c:when test="${nameValue == 'removeDrillDownGroup'}">${pageContext.request.contextPath}/kepler/operation/removeDrillDownGroup.do</c:when>

	<%-- 외부 연동 --%>
	<c:when
		test="${nameValue == 'getExternalAttributeGroupColumnValueList'}">${pageContext.request.contextPath}/externalRequest/getExternalAttributeGroupColumnValueList.do</c:when>
	<c:when test="${nameValue == 'getExternalAnalysisPublishReport'}">${pageContext.request.contextPath}/externalRequest/getExternalAnalysisPublishReport.do</c:when>

	<%--
         Kepler Action URL Configuration End
     --%>



	<%--
        Content Manager URL Configuration Start
    --%>

	<%-- 공통 --%>
	<c:when test="${nameValue == 'getCmsImgList'}">${pageContext.request.contextPath}/contentManager/common/getCmsImgList.do</c:when>
	<c:when test="${nameValue == 'editCmsImgDesc'}">${pageContext.request.contextPath}/contentManager/common/editCmsImgDesc.do</c:when>
	<c:when test="${nameValue == 'editImageFileDel'}">${pageContext.request.contextPath}/contentManager/common/editImageFileDel.do</c:when>
	<c:when test="${nameValue == 'editAttachFileDel'}">${pageContext.request.contextPath}/contentManager/common/editAttachFileDel.do</c:when>
	<c:when test="${nameValue == 'addAttachFile'}">${pageContext.request.contextPath}/contentManager/common/addAttachFile.do</c:when>

	<%-- kj.kang BBS 및 CONTENT--%>
	<c:when test="${nameValue == 'getBbsList'}">${pageContext.request.contextPath}/contentManager/bbs/getBbsList.do</c:when>
	<c:when test="${nameValue == 'getBbsContentList'}">${pageContext.request.contextPath}/contentManager/bbs/getBbsContentList.do</c:when>
	<c:when test="${nameValue == 'addBbs'}">${pageContext.request.contextPath}/contentManager/bbs/addBbs.do</c:when>
	<c:when test="${nameValue == 'editBbsDel'}">${pageContext.request.contextPath}/contentManager/bbs/editBbsDel.do</c:when>
	<c:when test="${nameValue == 'editContentDel'}">${pageContext.request.contextPath}/contentManager/bbs/editContentDel.do</c:when>
	<c:when test="${nameValue == 'addBbsContent'}">${pageContext.request.contextPath}/contentManager/bbs/addBbsContent.do</c:when>
	<c:when test="${nameValue == 'getBbsContentItem'}">${pageContext.request.contextPath}/contentManager/bbs/getBbsContentItem.do</c:when>
	<c:when test="${nameValue == 'editBbsContent'}">${pageContext.request.contextPath}/contentManager/bbs/editBbsContent.do</c:when>
	<c:when test="${nameValue == 'editBbs'}">${pageContext.request.contextPath}/contentManager/bbs/editBbs.do</c:when>
	<c:when test="${nameValue == 'getAttachFileList'}">${pageContext.request.contextPath}/contentManager/bbs/getAttachFileList.do</c:when>

	<%-- 컨택정보 조회 --%>
	<c:when test="${nameValue == 'getContactList'}">${pageContext.request.contextPath}/contentManager/bbs/getContactList.do</c:when>
	<c:when test="${nameValue == 'editContactDel'}">${pageContext.request.contextPath}/contentManager/bbs/editContactDel.do</c:when>
	<c:when test="${nameValue == 'editContactMemo'}">${pageContext.request.contextPath}/contentManager/bbs/editContactMemo.do</c:when>

	<%--
        Content Manager URL Configuration End
    --%>



	<%--
        Loyalty Action URL Configuration Start
    --%>
	<c:when test="${nameValue == 'excelExport'}">${pageContext.request.contextPath}/common/view/excelExport.do</c:when>
	<%-- 공통팝업  시작--%>

	<%-- 등급그룹 조회 팝업--%>
	<c:when test="${nameValue == 'getTierGrpPopup'}">${pageContext.request.contextPath}/common/view/getTierGrpPopup.do</c:when>
	<%-- 등급 조회 팝업--%>
	<c:when test="${nameValue == 'getCommTierListPop'}">${pageContext.request.contextPath}/common/view/getCommTierListPop.do</c:when>
	<%-- 채널마스터 조회 팝업--%>
	<c:when test="${nameValue == 'getChnlPopup'}">${pageContext.request.contextPath}/common/view/getChnlPopup.do</c:when>
	<%-- 프로그램 조회 팝업--%>
	<c:when test="${nameValue == 'getPgmPopup'}">${pageContext.request.contextPath}/common/view/getPgmPopup.do</c:when>
	<%-- 회원마스터 조회 팝업--%>
	<c:when test="${nameValue == 'getMbrMstPop'}">${pageContext.request.contextPath}/common/view/getMbrMstPop.do</c:when>
	<c:when test="${nameValue == 'getMbrMstClearMask'}">${pageContext.request.contextPath}/common/view/getMbrMstClearMask.do</c:when>
	<%-- 캠페인마스터 조회 팝업--%>
	<c:when test="${nameValue == 'getCamMstListPop'}">${pageContext.request.contextPath}/common/view/getCamMstListPop.do</c:when>
	<%-- 상품 카테고리 조회  팝업 --%>
	<c:when test="${nameValue == 'getCategoryListPop'}">${pageContext.request.contextPath}/common/view/getCategoryListPop.do</c:when>
	<%-- 상품 조회  팝업 --%>
	<c:when test="${nameValue == 'getProdListPop'}">${pageContext.request.contextPath}/common/view/getProdListPop.do</c:when>
	<%-- 포인트 상세 팝업 --%>
	<c:when test="${nameValue == 'getPointDtlPopupList'}">${pageContext.request.contextPath}/common/view/getPointDtlPopupList.do</c:when>
	<%-- 항목 상세 팝업 --%>
	<c:when test="${nameValue == 'getPurItemDtlPopList'}">${pageContext.request.contextPath}/common/view/getPurItemDtlPopList.do</c:when>
	<%-- 결제 상세 팝업 --%>
	<c:when test="${nameValue == 'getPurPayDtlPopList'}">${pageContext.request.contextPath}/common/view/getPurPayDtlPopList.do</c:when>
	<c:when test="${nameValue == 'clearMaskPurPayDtl'}">${pageContext.request.contextPath}/common/view/clearMaskPurPayDtl.do</c:when>
	<%-- 오퍼 조회 팝업 --%>
	<c:when test="${nameValue == 'getOfferListPop'}">${pageContext.request.contextPath}/common/view/getOfferListPop.do</c:when>
	<c:when test="${nameValue == 'getOfferIssListPop'}">${pageContext.request.contextPath}/common/view/getOfferIssListPop.do</c:when>
	<c:when test="${nameValue == 'getOfferListPopVoc'}">${pageContext.request.contextPath}/common/view/getOfferListPopVoc.do</c:when>
	<c:when test="${nameValue == 'getOfferListPopCpn'}">${pageContext.request.contextPath}/common/view/getOfferListPop.do</c:when>

	<%-- 채널 멀티 팝업 --%>
	<c:when test="${nameValue == 'getChnlMulitPopup'}">${pageContext.request.contextPath}/common/view/getChnlMulitPopup.do</c:when>
	<c:when test="${nameValue == 'getChnlMulitExcPopup'}">${pageContext.request.contextPath}/common/view/getChnlMulitExcPopup.do</c:when>

	<%-- 직원 조회 --%>
	<c:when test="${nameValue == 'getEmpListPop'}">${pageContext.request.contextPath}/common/view/getEmpList.do</c:when>
	<%-- 사이트 관리 --%>
	<c:when test="${nameValue == 'getSystemMgtListPop'}">${pageContext.request.contextPath}/common/view/getSystemMgtListPop.do</c:when>
	<%-- 공통코드 팝업 --%>
	<c:when test="${nameValue == 'getCommCodeListNew'}">${pageContext.request.contextPath}/common/view/getCommCodeListNew.do</c:when>
	<c:when test="${nameValue == 'getCommCodeItemList'}">${pageContext.request.contextPath}/common/view/getCommCodeItemList.do</c:when>

	<%-- 공통팝업  끝--%>

	<%-- 등급 --%>
	<c:when test="${nameValue == 'getTierGroupList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGroupList.do</c:when>
	<c:when test="${nameValue == 'getTierGrpDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpDtl.do</c:when>
	<c:when test="${nameValue == 'setTierGrp'}">${pageContext.request.contextPath}/loyalty/membership/tiers/setTierGrp.do</c:when>
	<c:when test="${nameValue == 'editTierGrp'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierGrp.do</c:when>
	<c:when test="${nameValue == 'getTierDtlList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierDtlList.do</c:when>
	<c:when test="${nameValue == 'getTierDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierDtl.do</c:when>
	<c:when test="${nameValue == 'setTierDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/setTierDtl.do</c:when>
	<c:when test="${nameValue == 'editTierDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierDtl.do</c:when>
	<c:when test="${nameValue == 'chkValid'}">${pageContext.request.contextPath}/loyalty/membership/tiers/chkValid.do</c:when>
	<c:when test="${nameValue == 'getTierListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierListPop.do</c:when>
	<c:when test="${nameValue == 'getTierChnlList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierChnlList.do</c:when>
	<c:when test="${nameValue == 'setTierChnl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/setTierChnl.do</c:when>
	<c:when test="${nameValue == 'editTierChnl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierChnl.do</c:when>
	<c:when test="${nameValue == 'removeTierChnl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierChnl.do</c:when>
	<c:when test="${nameValue == 'getTierUpMatrixList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierUpMatrixList.do</c:when>
	<c:when test="${nameValue == 'getTierUpMatrix'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierUpMatrix.do</c:when>
	<c:when test="${nameValue == 'getTierUpMatrixDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierUpMatrixDtl.do</c:when>
	<c:when test="${nameValue == 'setTierUpMatrix'}">${pageContext.request.contextPath}/loyalty/membership/tiers/setTierUpMatrix.do</c:when>
	<c:when test="${nameValue == 'editTierUpMatrix'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierUpMatrix.do</c:when>
	<c:when test="${nameValue == 'removeTierupMatrix'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierupMatrix.do</c:when>
	<c:when test="${nameValue == 'getTierBnftList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierBnftList.do</c:when>
	<c:when test="${nameValue == 'getTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierBnft.do</c:when>
	<c:when test="${nameValue == 'setTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/setTierBnft.do</c:when>
	<c:when test="${nameValue == 'editTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierBnft.do</c:when>
	<c:when test="${nameValue == 'removeTierGrp'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierGrp.do</c:when>
	<c:when test="${nameValue == 'getTierListByGroup'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierListByGroup.do</c:when>
	<c:when test="${nameValue == 'getTierRuleDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierRuleDetail.do</c:when>
	<c:when test="${nameValue == 'saveTierRuleDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/saveTierRuleDetail.do</c:when>
	<c:when test="${nameValue == 'editTierRuleDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTierRuleDetail.do</c:when>
	<c:when test="${nameValue == 'removeTierRuleDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierRuleDetail.do</c:when>

	<c:when test="${nameValue == 'getTiersCond'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTiersCond.do</c:when>
	<c:when test="${nameValue == 'getTierCondList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierCondList.do</c:when>
	<c:when test="${nameValue == 'removeTiersCondAll'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTiersCondAll.do</c:when>
	<c:when test="${nameValue == 'removeTiersCond'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTiersCond.do</c:when>
	<c:when test="${nameValue == 'editTiersCond'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTiersCond.do</c:when>
	<c:when test="${nameValue == 'getTierGroupListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGroupListNew.do</c:when>
	<c:when test="${nameValue == 'getTierGroupDetailNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGroupDetailNew.do</c:when>
	<c:when test="${nameValue == 'savetierGroup'}">${pageContext.request.contextPath}/loyalty/membership/tiers/savetierGroup.do</c:when>
	<c:when test="${nameValue == 'modifytierGroup'}">${pageContext.request.contextPath}/loyalty/membership/tiers/modifytierGroup.do</c:when>
	<c:when test="${nameValue == 'getDatasetList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getDatasetList.do</c:when>
	<c:when test="${nameValue == 'getTierListNewPage'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierListNewPage.do</c:when>
	<c:when test="${nameValue == 'getTierDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierDetail.do</c:when>
	<c:when test="${nameValue == 'saveTier'}">${pageContext.request.contextPath}/loyalty/membership/tiers/saveTier.do</c:when>
	<c:when test="${nameValue == 'modifyTier'}">${pageContext.request.contextPath}/loyalty/membership/tiers/modifyTier.do</c:when>
	<c:when test="${nameValue == 'getTierBnftListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierBnftListNew.do</c:when>
	<c:when test="${nameValue == 'getTierBnftDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierBnftDetail.do</c:when>
	<c:when test="${nameValue == 'saveTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/saveTierBnft.do</c:when>
	<c:when test="${nameValue == 'modifyTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/modifyTierBnft.do</c:when>
	<c:when test="${nameValue == 'removeTierBnft'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierBnft.do</c:when>
	<c:when test="${nameValue == 'getTierGroupJobList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGroupJobList.do</c:when>
	<c:when test="${nameValue == 'removeTierGrpJob'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierGrpJob.do</c:when>
	<c:when test="${nameValue == 'getTierGrpJobDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpJobDetail.do</c:when>
	<c:when test="${nameValue == 'saveTierGrpJob'}">${pageContext.request.contextPath}/loyalty/membership/tiers/saveTierGrpJob.do</c:when>
	<c:when test="${nameValue == 'modifyTierGrpJob'}">${pageContext.request.contextPath}/loyalty/membership/tiers/modifyTierGrpJob.do</c:when>
	<c:when test="${nameValue == 'getTierGrpDsListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpDsListNew.do</c:when>
	<c:when test="${nameValue == 'getTierGrpDsDetail'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpDsDetail.do</c:when>
	<c:when test="${nameValue == 'saveTierGrpDs'}">${pageContext.request.contextPath}/loyalty/membership/tiers/saveTierGrpDs.do</c:when>
	<c:when test="${nameValue == 'modifyTierGrpDs'}">${pageContext.request.contextPath}/loyalty/membership/tiers/modifyTierGrpDs.do</c:when>
	<c:when test="${nameValue == 'removeTierGrpDs'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierGrpDs.do</c:when>
	<c:when test="${nameValue == 'getTierGrpDsDatasetList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpDsDatasetList.do</c:when>
	<c:when test="${nameValue == 'getTierRuleListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierRuleListNew.do</c:when>
	<c:when test="${nameValue == 'getTierGrpRuleList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpRuleList.do</c:when>
	<c:when test="${nameValue == 'getTierGrpRuleDetailPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGrpRuleDetailPop.do</c:when>
	<c:when test="${nameValue == 'getDataSetList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getDataSetList.do</c:when>
	<c:when test="${nameValue == 'getDataSetItemList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getDataSetItemList.do</c:when>
	<c:when test="${nameValue == 'editTiersRule'}">${pageContext.request.contextPath}/loyalty/membership/tiers/editTiersRule.do</c:when>
	<c:when test="${nameValue == 'getTiersDatasetItemList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTiersDatasetItemList.do</c:when>
	<c:when test="${nameValue == 'removeTierRule'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTierRule.do</c:when>
	<c:when test="${nameValue == 'removeTiersGrp'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTiersGrp.do</c:when>
	<c:when test="${nameValue == 'removeTier'}">${pageContext.request.contextPath}/loyalty/membership/tiers/removeTier.do</c:when>
	<c:when test="${nameValue == 'tierBatchCall'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierBatchCall.do</c:when>
	<c:when test="${nameValue == 'tierInitCall'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierInitCall.do</c:when>
	<c:when test="${nameValue == 'getTierGroupListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTierGroupListPop.do</c:when>
	<c:when test="${nameValue == 'getTiersListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getTiersListPop.do</c:when>


	<%-- 상품 --%>
	<c:when test="${nameValue == 'getProdList'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdList.do</c:when>
    <c:when test="${nameValue == 'getTProdList'}">${pageContext.request.contextPath}/loyalty/membership/product/getTProdList.do</c:when>
	<c:when test="${nameValue == 'getProdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdDtl.do</c:when>
	<c:when test="${nameValue == 'setProdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/setProdDtl.do</c:when>
	<c:when test="${nameValue == 'setProdMultiDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/setProdMultiDtl.do</c:when>
	<c:when test="${nameValue == 'editProdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/editProdDtl.do</c:when>
	<c:when test="${nameValue == 'getProdChk'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdChk.do</c:when>
	<c:when test="${nameValue == 'removeProduct'}">${pageContext.request.contextPath}/loyalty/membership/product/removeProduct.do</c:when>
	<c:when test="${nameValue == 'getSettleMonDownList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonDownList.do</c:when>
	<c:when test="${nameValue == 'settleMonExeDown'}">${pageContext.request.contextPath}/loyalty/settle/settleMonExeDown.do</c:when>
    <c:when test="${nameValue == 'getProdListExport'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdListExport.do</c:when>
    <c:when test="${nameValue == 'getTProdListExport'}">${pageContext.request.contextPath}/loyalty/membership/product/getTProdListExport.do</c:when>
    <c:when test="${nameValue == 'getProdPosList'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdPosList.do</c:when>
    <c:when test="${nameValue == 'getTProdListYnPop'}">${pageContext.request.contextPath}/loyalty/membership/product/getTProdListYnPop.do</c:when>
    <c:when test="${nameValue == 'saveTProdListYnPop'}">${pageContext.request.contextPath}/loyalty/membership/product/saveTProdListYnPop.do</c:when>
    <c:when test="${nameValue == 'getAllowUseProdList'}">${pageContext.request.contextPath}/loyalty/membership/product/getAllowUseProdList.do</c:when>
    <c:when test="${nameValue == 'getAllowNotUseProdList'}">${pageContext.request.contextPath}/loyalty/membership/product/getAllowNotUseProdList.do</c:when>
    

	<%-- 상품 카테고리 --%>
	<c:when test="${nameValue == 'getCategoryList'}">${pageContext.request.contextPath}/loyalty/membership/product/getCategoryList.do</c:when>
	<c:when test="${nameValue == 'getCategoryDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/getCategoryDtl.do</c:when>
	<c:when test="${nameValue == 'setCategoryDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/setCategoryDtl.do</c:when>
	<c:when test="${nameValue == 'editCategoryDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/editCategoryDtl.do</c:when>
	<c:when test="${nameValue == 'getCategoryChk'}">${pageContext.request.contextPath}/loyalty/membership/product/getCategoryChk.do</c:when>
	<c:when test="${nameValue == 'removeCategory'}">${pageContext.request.contextPath}/loyalty/membership/product/removeCategory.do</c:when>
    <c:when test="${nameValue == 'getCategoryListExport'}">${pageContext.request.contextPath}/loyalty/membership/product/getCategoryListExport.do</c:when>

	<%-- 브랜드 --%>
	<c:when test="${nameValue == 'getBrandList'}">${pageContext.request.contextPath}/loyalty/membership/brand/getBrandList.do</c:when>
	<c:when test="${nameValue == 'getBrandDetail'}">${pageContext.request.contextPath}/loyalty/membership/brand/getBrandDetail.do</c:when>
	<c:when test="${nameValue == 'addBrand'}">${pageContext.request.contextPath}/loyalty/membership/brand/addBrand.do</c:when>
	<c:when test="${nameValue == 'editBrand'}">${pageContext.request.contextPath}/loyalty/membership/brand/editBrand.do</c:when>
	<c:when test="${nameValue == 'removeBrand'}">${pageContext.request.contextPath}/loyalty/membership/brand/removeBrand.do</c:when>
	<%--<c:when test="${nameValue == 'getBrdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/getBrdDtl.do</c:when>
	<c:when test="${nameValue == 'setBrdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/setBrdDtl.do</c:when>
	<c:when test="${nameValue == 'editBrdDtl'}">${pageContext.request.contextPath}/loyalty/membership/product/editBrdDtl.do</c:when>
	<c:when test="${nameValue == 'getBrdChk'}">${pageContext.request.contextPath}/loyalty/membership/product/getBrdChk.do</c:when>--%>

	<%-- 프로그램 --%>
	<c:when test="${nameValue == 'getPgmList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmList.do</c:when>
	<c:when test="${nameValue == 'getPgmDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmDetail.do</c:when>
	<c:when test="${nameValue == 'addPgm'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgm.do</c:when>
	<c:when test="${nameValue == 'editPgm'}">${pageContext.request.contextPath}/loyalty/membership/pgm/editPgm.do</c:when>
	<c:when test="${nameValue == 'removePgm'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removePgm.do</c:when>
	<c:when test="${nameValue == 'getPgmChnlList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmChnlList.do</c:when>
	<c:when test="${nameValue == 'addPgmHist'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgmHist.do</c:when>
	<c:when test="${nameValue == 'getPgmJoinPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmJoinPlcyList.do</c:when>
	<c:when test="${nameValue == 'getPgmJoinPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmJoinPlcyDetail.do</c:when>
	<c:when test="${nameValue == 'addPgmJoinPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgmJoinPlcy.do</c:when>
	<c:when test="${nameValue == 'editPgmJoinPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/editPgmJoinPlcy.do</c:when>
	<c:when test="${nameValue == 'removePgmJoinPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removePgmJoinPlcy.do</c:when>
	<c:when test="${nameValue == 'getPgmPntPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmPntPlcyDetail.do</c:when>
	<c:when test="${nameValue == 'addPgmPntPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgmPntPlcy.do</c:when>
	<c:when test="${nameValue == 'editPgmPntPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/editPgmPntPlcy.do</c:when>
	<c:when test="${nameValue == 'removePgmPntPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removePgmPntPlcy.do</c:when>
	<c:when test="${nameValue == 'getPgmFmlyPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmFmlyPlcyDetail.do</c:when>
	<c:when test="${nameValue == 'addPgmFmlyPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgmFmlyPlcy.do</c:when>
	<c:when test="${nameValue == 'editPgmFmlyPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/editPgmFmlyPlcy.do</c:when>
	<c:when test="${nameValue == 'removePgmFmlyPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removePgmFmlyPlcy.do</c:when>
    <c:when test="${nameValue == 'getPgmMgtPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmMgtPlcyList.do</c:when>
    <c:when test="${nameValue == 'getPgmMgtPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmMgtPlcyDetail.do</c:when>
    <c:when test="${nameValue == 'addPgmMgtPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/addPgmMgtPlcy.do</c:when>
    <c:when test="${nameValue == 'editPgmMgtPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/editPgmMgtPlcy.do</c:when>
    <c:when test="${nameValue == 'removePgmMgtPlcy'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removePgmMgtPlcy.do</c:when>
 	<c:when test="${nameValue == 'getPgmJoinPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmJoinPlcyList.do</c:when>
	<c:when test="${nameValue == 'getPgmClubPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmClubPlcyList.do</c:when>
	<c:when test="${nameValue == 'getPgmChnlList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmChnlList.do</c:when>
	<c:when test="${nameValue == 'getPgmBLPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmBLPlcyList.do</c:when>
	<c:when test="${nameValue == 'getPgmHistList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getPgmHistList.do</c:when>
	<c:when test="${nameValue == 'getCustItemConfList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getCustItemConfList.do</c:when>
	<c:when test="${nameValue == 'getCustItemConfDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getCustItemConfDetail.do</c:when>
	<c:when test="${nameValue == 'saveCustItemConfDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/saveCustItemConfDetail.do</c:when>
	<c:when test="${nameValue == 'modifyCustItemConfDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/modifyCustItemConfDetail.do</c:when>
	<c:when test="${nameValue == 'removeCustItemConf'}">${pageContext.request.contextPath}/loyalty/membership/pgm/removeCustItemConf.do</c:when>
	<c:when test="${nameValue == 'getItemCodeList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getItemCodeList.do</c:when>
	<c:when test="${nameValue == 'checkLoyPgmCnt'}">${pageContext.request.contextPath}/loyalty/membership/pgm/checkLoyPgmCnt.do</c:when>
	<c:when test="${nameValue == 'getGroupCodeListPop'}">${pageContext.request.contextPath}/loyalty/membership/pgm/getGroupCodeListPop.do</c:when>

	<%-- 채널 --%>
	<c:when test="${nameValue == 'getChnlList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/getChnlList.do</c:when>
	<c:when test="${nameValue == 'getChnlDetail'}">${pageContext.request.contextPath}/loyalty/membership/chnl/getChnlDetail.do</c:when>
	<c:when test="${nameValue == 'addChnl'}">${pageContext.request.contextPath}/loyalty/membership/chnl/addChnl.do</c:when>
	<c:when test="${nameValue == 'editChnl'}">${pageContext.request.contextPath}/loyalty/membership/chnl/editChnl.do</c:when>
	<c:when test="${nameValue == 'removeChnl'}">${pageContext.request.contextPath}/loyalty/membership/chnl/removeChnl.do</c:when>
	<c:when test="${nameValue == 'getChnlAcrlHistList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/getChnlAcrlHistList.do</c:when>
	<c:when test="${nameValue == 'editChnlAcrlPsblYn'}">${pageContext.request.contextPath}/loyalty/membership/chnl/editChnlAcrlPsblYn.do</c:when>
	<c:when test="${nameValue == 'removeChnlAcrlHist'}">${pageContext.request.contextPath}/loyalty/membership/chnl/removeChnlAcrlHist.do</c:when>

	<c:when test="${nameValue == 'channelListNewPage'}">${pageContext.request.contextPath}/loyalty/channel/channelListNewPage.do</c:when>
	<c:when test="${nameValue == 'getChnlDetailNew'}">${pageContext.request.contextPath}/loyalty/channel/getChnlDetailNew.do</c:when>

	<c:when test="${nameValue == 'getChnlPosList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/getChnlPosList.do</c:when>
	<c:when test="${nameValue == 'getChnlPosDetail'}">${pageContext.request.contextPath}/loyalty/membership/chnl/getChnlPosDetail.do</c:when>
	<c:when test="${nameValue == 'addChnlPos'}">${pageContext.request.contextPath}/loyalty/membership/chnl/addChnlPos.do</c:when>
	<c:when test="${nameValue == 'editChnlPos'}">${pageContext.request.contextPath}/loyalty/membership/chnl/editChnlPos.do</c:when>
	<c:when test="${nameValue == 'removeChnlPos'}">${pageContext.request.contextPath}/loyalty/membership/chnl/removeChnlPos.do</c:when>
	<c:when test="${nameValue == 'getStoreCd'}">${pageContext.request.contextPath}/loyalty/channel/getStoreCd.do</c:when>
	<c:when test="${nameValue == 'setChnlMbr'}">${pageContext.request.contextPath}/loyalty/channel/setChnlMbr.do</c:when>
	<c:when test="${nameValue == 'removeChnlMbr'}">${pageContext.request.contextPath}/loyalty/channel/removeChnlMbr.do</c:when>
	<c:when test="${nameValue == 'callKakaoApi'}">${pageContext.request.contextPath}/external/kakaoservice/callKakaoApi.do</c:when>
	<c:when test="${nameValue == 'getChnlListPage'}">${pageContext.request.contextPath}/loyalty/channel/getChnlListPage.do</c:when>
	<c:when test="${nameValue == 'getChnlAddInfoDetailNew'}">${pageContext.request.contextPath}/loyalty/channel/getChnlAddInfoDetailNew.do</c:when>
	<c:when test="${nameValue == 'getLoyPgmListNew'}">${pageContext.request.contextPath}/loyalty/channel/getLoyPgmListNew.do</c:when>
	<c:when test="${nameValue == 'saveChnlLoyPgm'}">${pageContext.request.contextPath}/loyalty/channel/saveChnlLoyPgm.do</c:when>
	<c:when test="${nameValue == 'modifyChnlLoyPgm'}">${pageContext.request.contextPath}/loyalty/channel/modifyChnlLoyPgm.do</c:when>
	<c:when test="${nameValue == 'getChnlMbrRelList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlMbrRelList.do</c:when>
	<c:when test="${nameValue == 'getChnlLoyPgmListNew'}">${pageContext.request.contextPath}/loyalty/channel/getChnlLoyPgmListNew.do</c:when>
	<c:when test="${nameValue == 'saveChnlSettle'}">${pageContext.request.contextPath}/loyalty/channel/saveChnlSettle.do</c:when>
	<c:when test="${nameValue == 'modifyChnlSettle'}">${pageContext.request.contextPath}/loyalty/channel/modifyChnlSettle.do</c:when>
	<c:when test="${nameValue == 'getLoyChnlPgmDetailNew'}">${pageContext.request.contextPath}/loyalty/channel/getLoyChnlPgmDetailNew.do</c:when>
	<c:when test="${nameValue == 'getChnlLoyPgmHist'}">${pageContext.request.contextPath}/loyalty/channel/getChnlLoyPgmHist.do</c:when>
	<c:when test="${nameValue == 'getChnlSettleHist'}">${pageContext.request.contextPath}/loyalty/channel/getChnlSettleHist.do</c:when>
	<c:when test="${nameValue == 'removeChnlChannel'}">${pageContext.request.contextPath}/loyalty/channel/removeChnlChannel.do</c:when>
	<c:when test="${nameValue == 'removeChnlLoyPgm'}">${pageContext.request.contextPath}/loyalty/channel/removeChnlLoyPgm.do</c:when>
	<c:when test="${nameValue == 'removeChnlSettle'}">${pageContext.request.contextPath}/loyalty/channel/removeChnlSettle.do</c:when>
	<c:when test="${nameValue == 'callGetSiGugun'}">${pageContext.request.contextPath}/external/kakaoservice/callGetSiGugun.do</c:when>

	<%-- 카드유형 --%>
	<c:when test="${nameValue == 'getCardTypeList'}">${pageContext.request.contextPath}/loyalty/membership/card/getCardTypeList.do</c:when>
	<c:when test="${nameValue == 'getCardTypeDetail'}">${pageContext.request.contextPath}/loyalty/membership/card/getCardTypeDetail.do</c:when>
	<c:when test="${nameValue == 'setCardType'}">${pageContext.request.contextPath}/loyalty/membership/card/setCardType.do</c:when>
	<c:when test="${nameValue == 'editCardType'}">${pageContext.request.contextPath}/loyalty/membership/card/editCardType.do</c:when>
	<c:when test="${nameValue == 'getIssuedCardList'}">${pageContext.request.contextPath}/loyalty/membership/card/getIssuedCardList.do</c:when>
	<c:when test="${nameValue == 'getCardBinList'}">${pageContext.request.contextPath}/loyalty/membership/card/getCardBinList.do</c:when>
	<c:when test="${nameValue == 'getCardBinDetail'}">${pageContext.request.contextPath}/loyalty/membership/card/getCardBinDetail.do</c:when>
	<c:when test="${nameValue == 'saveCardBin'}">${pageContext.request.contextPath}/loyalty/membership/card/saveCardBin.do</c:when>
	<c:when test="${nameValue == 'removeCardBin'}">${pageContext.request.contextPath}/loyalty/membership/card/removeCardBin.do</c:when>
    <c:when test="${nameValue == 'getCardNoPoolList'}">${pageContext.request.contextPath}/loyalty/membership/card/getCardNoPoolList.do</c:when>
    <c:when test="${nameValue == 'genCardNo'}">${pageContext.request.contextPath}/loyalty/membership/card/genCardNo.do</c:when>
    <c:when test="${nameValue == 'genCardNoDown'}">${pageContext.request.contextPath}/loyalty/membership/card/genCardNoDown.do</c:when>
    <c:when test="${nameValue == 'uploadCardNo'}">${pageContext.request.contextPath}/loyalty/membership/card/uploadCardNo.do</c:when>
    <c:when test="${nameValue == 'exportExcelCardNoPool'}">${pageContext.request.contextPath}/loyalty/membership/card/exportExcelCardNoPool.do</c:when>

	<%-- 캠페인 쿠폰 --%>
	<c:when test="${nameValue == 'getCouponDtl'}">${pageContext.request.contextPath}/loyalty/coupon/getCouponDtl.do</c:when>
	<c:when test="${nameValue == 'getCampaignCouponList'}">${pageContext.request.contextPath}/loyalty/coupon/getCampaignCouponList.do</c:when>
	<c:when test="${nameValue == 'addCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/addCoupon.do</c:when>
	<c:when test="${nameValue == 'editCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/editCoupon.do</c:when>
	<c:when test="${nameValue == 'removeCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/removeCoupon.do</c:when>
	<c:when test="${nameValue == 'paymentCpnMultiUpload'}">${pageContext.request.contextPath}/loyalty/coupon/paymentCpnMultiUpload.do</c:when>
	<c:when test="${nameValue == 'getCouponUploadList'}">${pageContext.request.contextPath}/loyalty/coupon/getCouponUploadList.do</c:when>
	<c:when test="${nameValue == 'saveMbrCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/saveMbrCoupon.do</c:when>
	<c:when test="${nameValue == 'useMbrCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/useMbrCoupon.do</c:when>
	<c:when test="${nameValue == 'saveCnclMbrCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/saveCnclMbrCoupon.do</c:when>
	<c:when test="${nameValue == 'useCnclMbrCoupon'}">${pageContext.request.contextPath}/loyalty/coupon/useCnclMbrCoupon.do</c:when>
	<c:when test="${nameValue == 'getCpnOffer'}">${pageContext.request.contextPath}/loyalty/coupon/getCpnOffer.do</c:when>
	<c:when test="${nameValue == 'getCpnChnl'}">${pageContext.request.contextPath}/loyalty/coupon/getCpnChnl.do</c:when>



	<%-- 모니터링 - 쿠폰발급현황 --%>
	<c:when test="${nameValue == 'getCamCouponIssuedList'}">${pageContext.request.contextPath}/loyalty/coupon/getCamCouponIssuedList.do</c:when>
	<c:when test="${nameValue == 'getCamCouponCount'}">${pageContext.request.contextPath}/loyalty/coupon/getCamCouponCount.do</c:when>
	<c:when test="${nameValue == 'getCamCouponIssuedListExport'}">${pageContext.request.contextPath}/loyalty/coupon/getCamCouponIssuedListExport.do</c:when>

	<%-- 고객 --%>
	<c:when test="${nameValue == 'getCustList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustList.do</c:when>
	<c:when test="${nameValue == 'getCustDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustDetail.do</c:when>
	<c:when test="${nameValue == 'addCust'}">${pageContext.request.contextPath}/loyalty/member/customer/addCust.do</c:when>
	<c:when test="${nameValue == 'editCust'}">${pageContext.request.contextPath}/loyalty/member/customer/editCust.do</c:when>
	<c:when test="${nameValue == 'removeCust'}">${pageContext.request.contextPath}/loyalty/member/customer/removeCust.do</c:when>
	<c:when test="${nameValue == 'clearMaskCust'}">${pageContext.request.contextPath}/loyalty/member/customer/clearMaskCust.do</c:when>
	<c:when test="${nameValue == 'getCustAddInfoList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustAddInfoList.do</c:when>
	<c:when test="${nameValue == 'getCustAddInfoDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustAddInfoDetail.do</c:when>
	<c:when test="${nameValue == 'addCustAddInfo'}">${pageContext.request.contextPath}/loyalty/member/customer/addCustAddInfo.do</c:when>
	<c:when test="${nameValue == 'editCustAddInfo'}">${pageContext.request.contextPath}/loyalty/member/customer/editCustAddInfo.do</c:when>
	<c:when test="${nameValue == 'removeCustAddInfo'}">${pageContext.request.contextPath}/loyalty/member/customer/removeCustAddInfo.do</c:when>
	<c:when test="${nameValue == 'getMemberList'}">${pageContext.request.contextPath}/loyalty/member/customer/getMemberList.do</c:when>
	<c:when test="${nameValue == 'getCustListPage'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustListPage.do</c:when>
	<c:when test="${nameValue == 'getCustDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustDetailNewPage.do</c:when>
	<c:when test="${nameValue == 'getCorpCustListPage'}">${pageContext.request.contextPath}/loyalty/member/customer/getCorpCustListPage.do</c:when>
	<c:when test="${nameValue == 'getCorpCustDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/customer/getCorpCustDetailNewPage.do</c:when>
	<c:when test="${nameValue == 'clearMaskCustList'}">${pageContext.request.contextPath}/loyalty/member/customer/clearMaskCustList.do</c:when>
	<c:when test="${nameValue == 'clearMaskCorpCustList'}">${pageContext.request.contextPath}/loyalty/member/customer/clearMaskCorpCustList.do</c:when>
	<c:when test="${nameValue == 'getCertList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCertList.do</c:when>
	<c:when test="${nameValue == 'getCustLoginList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustLoginList.do</c:when>
	<c:when test="${nameValue == 'getCustAgreList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustAgreList.do</c:when>
	<c:when test="${nameValue == 'getCustAgreHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustAgreHistList.do</c:when>
	<c:when test="${nameValue == 'getCustSvrHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustSvrHistList.do</c:when>
	<c:when test="${nameValue == 'getCustWebHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustWebHistList.do</c:when>
	<c:when test="${nameValue == 'getAlterSvrHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getAlterSvrHistList.do</c:when>
	<c:when test="${nameValue == 'getAppSvrHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getAppSvrHistList.do</c:when>
	<c:when test="${nameValue == 'getChangeHistList'}">${pageContext.request.contextPath}/loyalty/member/customer/getChangeHistList.do</c:when>
	<c:when test="${nameValue == 'getCustDetailMbrList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustDetailMbrList.do</c:when>
	<c:when test="${nameValue == 'getCustLoginInfo'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustLoginInfo.do</c:when>
	<c:when test="${nameValue == 'getCustMbrRelList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustMbrRelList.do</c:when>
    <c:when test="${nameValue == 'getCustBranchList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustBranchList.do</c:when>
    <c:when test="${nameValue == 'getCustBranchDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustBranchDetail.do</c:when>
    <c:when test="${nameValue == 'addCustBranch'}">${pageContext.request.contextPath}/loyalty/member/customer/addCustBranch.do</c:when>
    <c:when test="${nameValue == 'editCustBranch'}">${pageContext.request.contextPath}/loyalty/member/customer/editCustBranch.do</c:when>
    <c:when test="${nameValue == 'removeCustBranch'}">${pageContext.request.contextPath}/loyalty/member/customer/removeCustBranch.do</c:when>
    <c:when test="${nameValue == 'getCustBnftList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustBnftList.do</c:when>
    <c:when test="${nameValue == 'getCustBnftDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustBnftDetail.do</c:when>
    <c:when test="${nameValue == 'addCustBnft'}">${pageContext.request.contextPath}/loyalty/member/customer/addCustBnft.do</c:when>
    <c:when test="${nameValue == 'editCustBnft'}">${pageContext.request.contextPath}/loyalty/member/customer/editCustBnft.do</c:when>
    <c:when test="${nameValue == 'removeCustBnft'}">${pageContext.request.contextPath}/loyalty/member/customer/removeCustBnft.do</c:when>
    <c:when test="${nameValue == 'getCustSettleDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustSettleDetail.do</c:when>
    <c:when test="${nameValue == 'addCustSettle'}">${pageContext.request.contextPath}/loyalty/member/customer/addCustSettle.do</c:when>
    <c:when test="${nameValue == 'editCustSettle'}">${pageContext.request.contextPath}/loyalty/member/customer/editCustSettle.do</c:when>
    <c:when test="${nameValue == 'removeCustSettle'}">${pageContext.request.contextPath}/loyalty/member/customer/removeCustSettle.do</c:when>
	<c:when test="${nameValue == 'getCustSegmentRuleHist'}">${pageContext.request.contextPath}/loyalty/member/customer/getCustSegmentRuleHist.do</c:when>
    <c:when test="${nameValue == 'getMobileCustLoginInfo'}">${pageContext.request.contextPath}/loyalty/member/customer/getMobileCustLoginInfo.do</c:when>
    <c:when test="${nameValue == 'getMbrMobileLoginPopGrid'}">${pageContext.request.contextPath}/loyalty/member/customer/getMbrMobileLoginPopGrid.do</c:when>
	<c:when test="${nameValue == 'loginFailCntInit'}">${pageContext.request.contextPath}/loyalty/member/customer/loginFailCntInit.do</c:when>


	<%-- cafe24 회원 --%>
	<c:when test="${nameValue == 'getCafe24MemList'}">${pageContext.request.contextPath}/loyalty/member/customer/getCafe24MemList.do</c:when>
	<c:when test="${nameValue == 'getCafe24MemDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/getCafe24MemDetail.do</c:when>
	<c:when test="${nameValue == 'getCafe24MbrCamHist'}">${pageContext.request.contextPath}/loyalty/member/customer/getCafe24MbrCamHist.do</c:when>
	<c:when test="${nameValue == 'clearMaskCf24MbrList'}">${pageContext.request.contextPath}/loyalty/member/customer/clearMaskCf24MbrList.do</c:when>


	<%-- 회원 --%>
	<c:when test="${nameValue == 'getMbrList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrList.do</c:when>
	<c:when test="${nameValue == 'clearMaskMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskMbr.do</c:when>
	<c:when test="${nameValue == 'getMbrDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrDetail.do</c:when>
	<c:when test="${nameValue == 'getMbrCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCardList.do</c:when>
	<c:when test="${nameValue == 'getMbrChnlRelList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrChnlRelList.do</c:when>
	<c:when test="${nameValue == 'getMbrPtnBalList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPtnBalList.do</c:when>
	<c:when test="${nameValue == 'getMbrTierHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTierHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrPurHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPurHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrCampHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCampHistList.do</c:when>
	<c:when test="${nameValue == 'editMbrCardStat'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrCardStat.do</c:when>

	<c:when test="${nameValue == 'getMbrFamilyList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrFamilyList.do</c:when>
	<c:when test="${nameValue == 'saveNewFmlyMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveNewFmlyMbr.do</c:when>
	<c:when test="${nameValue == 'checkFmlyChief'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkFmlyChief.do</c:when>
	<c:when test="${nameValue == 'removeFmlyMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/removeFmlyMbr.do</c:when>
	<c:when test="${nameValue == 'blackRuleFmly'}">${pageContext.request.contextPath}/loyalty/member/mbr/blackRuleFmly.do</c:when>

	<c:when test="${nameValue == 'getMbrstatus'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrstatus.do</c:when>
	<c:when test="${nameValue == 'addMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/addMbr.do</c:when>
	<c:when test="${nameValue == 'editMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbr.do</c:when>
	<c:when test="${nameValue == 'dropMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbr.do</c:when>
	<c:when test="${nameValue == 'getChargeYM'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChargeYM.do</c:when>
	<c:when test="${nameValue == 'getChargeList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChargeList.do</c:when>
	<c:when test="${nameValue == 'getChargeInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChargeInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrCarHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCarHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrCarHistInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCarHistInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrSegHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSegHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrPointLimitInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPointLimitInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrBlackList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrBlackList.do</c:when>
	<c:when test="${nameValue == 'getMbrBlackInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrBlackInfo.do</c:when>
	<c:when test="${nameValue == 'addMbrBlackHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/addMbrBlackHist.do</c:when>
	<c:when test="${nameValue == 'updateMbrBlackHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/updateMbrBlackHist.do</c:when>
	<c:when test="${nameValue == 'setMbrPointLimit'}">${pageContext.request.contextPath}/loyalty/member/mbr/setMbrPointLimit.do</c:when>
	<c:when test="${nameValue == 'getMbrTaxiHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTaxiHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrTaxiPntHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTaxiPtnHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrTaxiPntDetailList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTaxiPntDetailList.do</c:when>
	<c:when test="${nameValue == 'getMbrSignInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSignInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrChnlHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrChnlHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrChnlHistContents'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrChnlHistContents.do</c:when>
	<c:when test="${nameValue == 'getMbrInsurHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrInsurHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrChnlHistSubList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrChnlHistSubList.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupAddInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupAddInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupUserList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupUserList.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupPointTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupPointTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupChnList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupChnList.do</c:when>
	<c:when test="${nameValue == 'getChargeSum'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChargeSum.do</c:when>
	<c:when test="${nameValue == 'editMbrGroupAddInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrGroupAddInfo.do</c:when>
	<c:when test="${nameValue == 'getChangeTaxiList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChangeTaxiList.do</c:when>
	<c:when test="${nameValue == 'addChangeTaxi'}">${pageContext.request.contextPath}/loyalty/member/mbr/addChangeTaxi.do</c:when>
	<c:when test="${nameValue == 'requestApprovTaxi'}">${pageContext.request.contextPath}/loyalty/member/mbr/requestApprovTaxi.do</c:when>
	<c:when test="${nameValue == 'unReqApprovTaxi'}">${pageContext.request.contextPath}/loyalty/member/mbr/unReqApprovTaxi.do</c:when>
	<c:when test="${nameValue == 'getMbrPwChgDate'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPwChgDate.do</c:when>
	<c:when test="${nameValue == 'getMbrTmAtrHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTmAtrHistList.do</c:when>
	<c:when test="${nameValue == 'reqTaxiConv'}">${pageContext.request.contextPath}/loyalty/member/mbr/reqTaxiConv.do</c:when>
	<c:when test="${nameValue == 'approvTaxi'}">${pageContext.request.contextPath}/loyalty/member/mbr/approvTaxi.do</c:when>
	<c:when test="${nameValue == 'reqCertiCode'}">${pageContext.request.contextPath}/loyalty/member/mbr/reqCertiCode.do</c:when>
	<c:when test="${nameValue == 'changeNmbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/changeNmbr.do</c:when>
	<c:when test="${nameValue == 'checkCertiCode'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkCertiCode.do</c:when>
	<c:when test="${nameValue == 'checkMypinNum'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkMypinNum.do</c:when>
	<c:when test="${nameValue == 'rereqCertiCode'}">${pageContext.request.contextPath}/loyalty/member/mbr/rereqCertiCode.do</c:when>
	<c:when test="${nameValue == 'addMbrGroupUser'}">${pageContext.request.contextPath}/loyalty/member/mbr/addMbrGroupUser.do</c:when>
	<c:when test="${nameValue == 'dropMbrGroupUser'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrGroupUser.do</c:when>
	<c:when test="${nameValue == 'editMbrName'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrName.do</c:when>
	<c:when test="${nameValue == 'getAvlPoint'}">${pageContext.request.contextPath}/loyalty/member/mbr/getAvlPoint.do</c:when>
	<c:when test="${nameValue == 'getChangeTaxiInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChangeTaxiInfo.do</c:when>
	<c:when test="${nameValue == 'checkMypinNum4Rename'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkMypinNum4Rename.do</c:when>
	<c:when test="${nameValue == 'checkCertiCode4Rename'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkCertiCode4Rename.do</c:when>
	<c:when test="${nameValue == 'addMbrTmAgrHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/addMbrTmAgrHist.do</c:when>
	<c:when test="${nameValue == 'getMbrTmAgrInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTmAgrInfo.do</c:when>
	<c:when test="${nameValue == 'updateMbrTmAgrHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/updateMbrTmAgrHist.do</c:when>
	<c:when test="${nameValue == 'getMbrSemiVipHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSemiVipHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrCouponTrnsList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCouponTrnsList.do</c:when>
	<c:when test="${nameValue == 'delPhoneNum'}">${pageContext.request.contextPath}/loyalty/member/mbr/delPhoneNum.do</c:when>
	<c:when test="${nameValue == 'addVocPntTxn'}">${pageContext.request.contextPath}/loyalty/member/mbr/addVocPntTxn.do</c:when>
	<c:when test="${nameValue == 'getPontBalanceB2c'}">${pageContext.request.contextPath}/loyalty/member/mbr/getPontBalanceB2c.do</c:when>
	<c:when test="${nameValue == 'dropReason'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropReason.do</c:when>
	<c:when test="${nameValue == 'editCustName'}">${pageContext.request.contextPath}/loyalty/member/mbr/editCustName.do</c:when>
	<c:when test="${nameValue == 'dropMbrCancel'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrCancel.do</c:when>
	<c:when test="${nameValue == 'updateResetfailCnt'}">${pageContext.request.contextPath}/loyalty/member/mbr/updateResetfailCnt.do</c:when>
	<c:when test="${nameValue == 'getMbrAllTierList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrAllTierList.do</c:when>
	<c:when test="${nameValue == 'editMbrTier'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrTier.do</c:when>
	<c:when test="${nameValue == 'validAuthCheck'}">${pageContext.request.contextPath}/loyalty/member/mbr/validAuthCheck.do</c:when>
	<c:when test="${nameValue == 'clearMaskDrop'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskDrop.do</c:when>
	<c:when test="${nameValue == 'clearMaskRecomm'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskRecomm.do</c:when>
	<c:when test="${nameValue == 'dropReasonPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropReasonPop.do</c:when>
	<c:when test="${nameValue == 'getTotAcrlPoint'}">${pageContext.request.contextPath}/loyalty/member/mbr/getTotAcrlPoint.do</c:when>
	<c:when test="${nameValue == 'getTotRdmPoint'}">${pageContext.request.contextPath}/loyalty/member/mbr/getTotRdmPoint.do</c:when>
	<c:when test="${nameValue == 'getAlertList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getAlertList.do</c:when>

	<c:when test="${nameValue == 'getDormancyPntListByMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/getDormancyPntListByMbr.do</c:when>
	<c:when test="${nameValue == 'getDupMbrList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getDupMbrList.do</c:when>
	<c:when test="${nameValue == 'getMbrTermsHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTermsHistList.do</c:when>
	<c:when test="${nameValue == 'editMbrPntUsePw'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrPntUsePw.do</c:when>
	<c:when test="${nameValue == 'clearDupMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearDupMbr.do</c:when>
	<c:when test="${nameValue == 'getMbrPntAcrlUseYn'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPntAcrlUseYn.do</c:when>
	<c:when test="${nameValue == 'getMbrFamliyInfoList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrFamliyInfoList.do</c:when>
	<c:when test="${nameValue == 'selectTransList'}">${pageContext.request.contextPath}/loyalty/member/mbr/selectTransList.do</c:when>
	<c:when test="${nameValue == 'transPntReason'}">${pageContext.request.contextPath}/loyalty/member/mbr/transPntReason.do</c:when>
	<c:when test="${nameValue == 'transPointExec'}">${pageContext.request.contextPath}/loyalty/member/mbr/transPointExec.do</c:when>
	<c:when test="${nameValue == 'transPointHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/transPointHist.do</c:when>
	<c:when test="${nameValue == 'getMbrPntGiftHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPntGiftHistList.do</c:when>
	<c:when test="${nameValue == 'getfamOfferList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getfamOfferList.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpHistListDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpHistListDetail.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpBnftHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpBnftHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpTxnList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpTxnList.do</c:when>
	<c:when test="${nameValue == 'getMbrPointCouponList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPointCouponList.do</c:when>
	<c:when test="${nameValue == 'getMbrPointCouponDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPointCouponDetail.do</c:when>
	<c:when test="${nameValue == 'getMbrTierHistList2'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTierHistList2.do</c:when>
	<c:when test="${nameValue == 'acrlStmp'}">${pageContext.request.contextPath}/loyalty/member/mbr/acrlStmp.do</c:when>
	<c:when test="${nameValue == 'getMbrRecomHistoryList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrRecomHistoryList.do</c:when>
	<c:when test="${nameValue == 'validAuthCheck'}">${pageContext.request.contextPath}/loyalty/member/mbr/validAuthCheck.do</c:when>
	<c:when test="${nameValue == 'maxPointLabel'}">${pageContext.request.contextPath}/loyalty/member/mbr/maxPointLabel.do</c:when>
	<c:when test="${nameValue == 'getMbrLoginHistoryList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrLoginHistoryList.do</c:when>
	<c:when test="${nameValue == 'getMbrAttendEventHistoryList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrAttendEventHistoryList.do</c:when>
	<c:when test="${nameValue == 'mbrPointMallList'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrPointMallList.do</c:when>
	<c:when test="${nameValue == 'pointCancelApiRequest'}">${pageContext.request.contextPath}/loyalty/member/mbr/pointCancelApiRequest.do</c:when>
	<c:when test="${nameValue == 'getMbrListNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrListNewPage.do</c:when>
	<c:when test="${nameValue == 'getmbrCustList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getmbrCustList.do</c:when>
	<c:when test="${nameValue == 'getMbrPointHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPointHistList.do</c:when>
	<c:when test="${nameValue == 'getMmbrDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMmbrDetailNewPage.do</c:when>
	<c:when test="${nameValue == 'getChnlRelHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getChnlRelHistList.do</c:when>
	<c:when test="${nameValue == 'getCouponList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCouponList.do</c:when>
	<c:when test="${nameValue == 'getAlterHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getAlterHistList.do</c:when>
	<c:when test="${nameValue == 'getAlterHistConts'}">${pageContext.request.contextPath}/loyalty/member/mbr/getAlterHistConts.do</c:when>
	<c:when test="${nameValue == 'editMbrPntUsePwLL'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrPntUsePwLL.do</c:when>
	<c:when test="${nameValue == 'editMbrLoiginPwLL'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrLoiginPwLL.do</c:when>
	
	
	<c:when test="${nameValue == 'getMemberCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMemberCardList.do</c:when>
	<c:when test="${nameValue == 'getBlackHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getBlackHistList.do</c:when>
	<c:when test="${nameValue == 'getRecommendHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getRecommendHistList.do</c:when>
	<c:when test="${nameValue == 'saveNewCust'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveNewCust.do</c:when>
	<c:when test="${nameValue == 'saveJoinCustAll'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveJoinCustAll.do</c:when>
	<c:when test="${nameValue == 'custItemConfVal'}">${pageContext.request.contextPath}/loyalty/member/mbr/custItemConfVal.do</c:when>
	<c:when test="${nameValue == 'termsListVal'}">${pageContext.request.contextPath}/loyalty/member/mbr/termsListVal.do</c:when>
	<c:when test="${nameValue == 'termsMktRcvListVal'}">${pageContext.request.contextPath}/loyalty/member/mbr/termsMktRcvListVal.do</c:when>
	<c:when test="${nameValue == 'getMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrDetailPop.do</c:when>
	<c:when test="${nameValue == 'getCorpMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCorpMbrDetailPop.do</c:when>
	<c:when test="${nameValue == 'getMbrTermsDetailList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTermsDetailList.do</c:when>
	<c:when test="${nameValue == 'saveMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveMbrDetailPop.do</c:when>
	<c:when test="${nameValue == 'saveCorpMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveCorpMbrDetailPop.do</c:when>
	<c:when test="${nameValue == 'getCorpMbrListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCorpMbrListPop.do</c:when>
	<c:when test="${nameValue == 'getCorpBranchListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCorpBranchListPop.do</c:when>
	<c:when test="${nameValue == 'withdrawMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/withdrawMbr.do</c:when>
	<c:when test="${nameValue == 'withdrawMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/withdrawMbr.do</c:when>
	<c:when test="${nameValue == 'checkCardNumber'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkCardNumber.do</c:when>
	<c:when test="${nameValue == 'checkUserId'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkUserId.do</c:when>
	<c:when test="${nameValue == 'checkRcmmdNo'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkRcmmdNo.do</c:when>
	<c:when test="${nameValue == 'getPgmMgtPlcy'}">${pageContext.request.contextPath}/loyalty/member/mbr/getPgmMgtPlcy.do</c:when>
    <c:when test="${nameValue == 'getMbrCustTypeCd'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCustTypeCd.do</c:when>

	<c:when test="${nameValue == 'getMbrTierListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTierListNew.do</c:when>
	<c:when test="${nameValue == 'getMbrEventHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrEventHistListNew.do</c:when>
	<c:when test="${nameValue == 'getMbrTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrOnBoardHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrOnBoardHistList.do</c:when>
	<c:when test="${nameValue == 'purAcrlPointProc'}">${pageContext.request.contextPath}/loyalty/member/mbr/purAcrlPointProc.do</c:when>
	<c:when test="${nameValue == 'searchMbrGiftPntTgtMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/searchMbrGiftPntTgtMbr.do</c:when>
	<c:when test="${nameValue == 'setMbrPointGiftProc'}">${pageContext.request.contextPath}/loyalty/member/mbr/setMbrPointGiftProc.do</c:when>
	<c:when test="${nameValue == 'getGiftPointHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getGiftPointHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrUsePurMax'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrUsePurMax.do</c:when>
	<c:when test="${nameValue == 'getMbrTxnHistSumList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTxnHistSumList.do</c:when>
	<c:when test="${nameValue == 'getMbrPntHistSumList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPntHistSumList.do</c:when>
	<c:when test="${nameValue == 'getCpnIssueOfferList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCpnIssueOfferList.do</c:when>
	<c:when test="${nameValue == 'getMbrTxnHistDeliSumList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTxnHistDeliSumList.do</c:when>
	

	<c:when test="${nameValue == 'getCustSegmentHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCustSegmentHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrTierHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrTierHistListNew.do</c:when>
	<c:when test="${nameValue == 'getMbrPgmChnlPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPgmChnlPop.do</c:when>
	<c:when test="${nameValue == 'getMbrIntList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrIntList.do</c:when>
	<c:when test="${nameValue == 'saveMbrInt'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveMbrInt.do</c:when>
	<c:when test="${nameValue == 'removeMbrInt'}">${pageContext.request.contextPath}/loyalty/member/mbr/removeMbrInt.do</c:when>
    <c:when test="${nameValue == 'clearMaskMbrInt'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskMbrInt.do</c:when>
    <c:when test="${nameValue == 'getTierBenefitHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getTierBenefitHistList.do</c:when>
    

    <c:when test="${nameValue == 'executivesViewSelect'}">${pageContext.request.contextPath}/loyalty/member/mbr/executivesViewSelect.do</c:when>
    <c:when test="${nameValue == 'executivesExistSelect'}">${pageContext.request.contextPath}/loyalty/member/mbr/executivesExistSelect.do</c:when>
    <c:when test="${nameValue == 'empNoUpdateExecutives'}">${pageContext.request.contextPath}/loyalty/member/mbr/empNoUpdateExecutives.do</c:when>
    <c:when test="${nameValue == 'StatCdUpdateExecutives'}">${pageContext.request.contextPath}/loyalty/member/mbr/StatCdUpdateExecutives.do</c:when>

    <c:when test="${nameValue == 'buyDetailSelect'}">${pageContext.request.contextPath}/loyalty/member/mbr/buyDetailSelect.do</c:when>
	<c:when test="${nameValue == 'purDetailSelect'}">${pageContext.request.contextPath}/loyalty/member/mbr/purDetailSelect.do</c:when>
    <c:when test="${nameValue == 'getProdCustList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getProdCustList.do</c:when>
    <c:when test="${nameValue == 'prodCustListDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/prodCustListDetail.do</c:when>
    <c:when test="${nameValue == 'getDorMantList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getDorMantList.do</c:when>
    <c:when test="${nameValue == 'getBeforeDorMantList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getBeforeDorMantList.do</c:when>
    <c:when test="${nameValue == 'getexecutivesList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getexecutivesList.do</c:when>
    <c:when test="${nameValue == 'getExecutivesPopComm'}">${pageContext.request.contextPath}/loyalty/member/mbr/getExecutivesPopComm.do</c:when>
    <c:when test="${nameValue == 'getPrStoreNmPopList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getPrStoreNmPopList.do</c:when>
    <c:when test="${nameValue == 'getCampaignExecList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCampaignExecList.do</c:when>
    <c:when test="${nameValue == 'getNegativeAccList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getNegativeAccList.do</c:when>
    <c:when test="${nameValue == 'clearMaskNegativeAccList'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskNegativeAccList.do</c:when>
    <c:when test="${nameValue == 'negativeAccListExcelList'}">${pageContext.request.contextPath}/loyalty/member/mbr/negativeAccListExcelList.do</c:when>
    <c:when test="${nameValue == 'buyDetailSelectOnline'}">${pageContext.request.contextPath}/loyalty/member/mbr/buyDetailSelectOnline.do</c:when>


	<c:when test="${nameValue == 'getMbrMgtInfoList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrMgtInfoList.do</c:when>
	<c:when test="${nameValue == 'addMbrMgtInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/addMbrMgtInfo.do</c:when>
	<c:when test="${nameValue == 'updateMbrMgtInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/updateMbrMgtInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrMgtInfoHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrMgtInfoHistList.do</c:when>
	<c:when test="${nameValue == 'deleteMbrMgtInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/deleteMbrMgtInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrMgtInfoBeforeUpdate'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrMgtInfoBeforeUpdate.do</c:when>
	<c:when test="${nameValue == 'checkAttrCdAttrSubCd'}">${pageContext.request.contextPath}/loyalty/member/mbr/checkAttrCdAttrSubCd.do</c:when>
	<c:when test="${nameValue == 'getOnlineMallCouponHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getOnlineMallCouponHistList.do</c:when>
	<c:when test="${nameValue == 'getNewMallCouponList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getNewMallCouponList.do</c:when>
	<c:when test="${nameValue == 'updatePntYn'}">${pageContext.request.contextPath}/loyalty/member/mbr/updatePntYn.do</c:when>
	<c:when test="${nameValue == 'updateRdmPntYn'}">${pageContext.request.contextPath}/loyalty/member/mbr/updateRdmPntYn.do</c:when>
	<c:when test="${nameValue == 'getOfrPntList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getOfrPntList.do</c:when>
	<c:when test="${nameValue == 'getExtncList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getExtncList.do</c:when>
	<c:when test="${nameValue == 'getMbrIntListSearch'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrIntListSearch.do</c:when>
	<c:when test="${nameValue == 'saveTgtMbrInt'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveTgtMbrInt.do</c:when>
	<c:when test="${nameValue == 'getMbrListNewPageExcelDown'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrListNewPageExcelDown.do</c:when>
	<c:when test="${nameValue == 'getExecutivesListExcelDown'}">${pageContext.request.contextPath}/loyalty/member/mbr/getExecutivesListExcelDown.do</c:when>
	<c:when test="${nameValue == 'saveMbrDorDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveMbrDorDetailPop.do</c:when>
	<c:when test="${nameValue == 'getMbrSurveyList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSurveyList.do</c:when>
	<c:when test="${nameValue == 'getMbrSurveyDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSurveyDetailPop.do</c:when>

	<%-- 채널 전송 --%>
	<c:when test="${nameValue == 'transChnl'}">${pageContext.request.contextPath}/common/view/transChnl.do</c:when>


	<%-- 회원 비밀번호 --%>
	<c:when test="${nameValue == 'getMbrPwdDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrPwdDetail.do</c:when>
	<c:when test="${nameValue == 'editMbrPwd'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrPwd.do</c:when>

	<%-- 가족화 --%>
	<c:when test="${nameValue == 'getFamilyList'}">${pageContext.request.contextPath}/loyalty/family/getFamilyList.do</c:when>
	<c:when test="${nameValue == 'clearMaskFamilyList'}">${pageContext.request.contextPath}/loyalty/family/clearMaskFamilyList.do</c:when>
	<c:when test="${nameValue == 'saveApprProcess'}">${pageContext.request.contextPath}/loyalty/family/saveApprProcess.do</c:when>
	<c:when test="${nameValue == 'saveCanlProcess'}">${pageContext.request.contextPath}/loyalty/family/saveCanlProcess.do</c:when>
	<c:when test="${nameValue == 'saveNewFmly'}">${pageContext.request.contextPath}/loyalty/family/saveNewFmly.do</c:when>



	<%-- 혜택산출--%>
	<c:when test="${nameValue == 'calRealPoint'}">${pageContext.request.contextPath}/loyalty/bnftCalc/pointCalc/calRealPoint.do</c:when>


	<%-- 이벤트 트리거 캠페인 --%>
	<c:when test="${nameValue == 'getETCampaignCond'}">${pageContext.request.contextPath}/marketing/campaign/getETCampaignCond.do</c:when>
	<c:when test="${nameValue == 'saveETCampaignCond'}">${pageContext.request.contextPath}/marketing/campaign/saveETCampaignCond.do</c:when>
	<c:when test="${nameValue == 'getETCampaignAct'}">${pageContext.request.contextPath}/marketing/campaign/getETCampaignAct.do</c:when>
	<c:when test="${nameValue == 'saveETCampaignAct'}">${pageContext.request.contextPath}/marketing/campaign/saveETCampaignAct.do</c:when>
	<c:when test="${nameValue == 'getETIntactTypeList'}">${pageContext.request.contextPath}/marketing/campaign/getETIntactTypeList.do</c:when>
	<c:when test="${nameValue == 'getETLogicalComponentList'}">${pageContext.request.contextPath}/marketing/campaign/getETLogicalComponentList.do</c:when>
	<c:when test="${nameValue == 'getETLogicalComponentColumnList'}">${pageContext.request.contextPath}/marketing/campaign/getETLogicalComponentColumnList.do</c:when>
	<c:when test="${nameValue == 'getETFunctionList'}">${pageContext.request.contextPath}/marketing/campaign/getETFunctionList.do</c:when>

	<%-- 이벤트 트리거 데몬 실행관리 --%>
	<%-- <c:when test="${nameValue == 'getEventExecutionList'}">${pageContext.request.contextPath}/marketing/eventExecution/getEventExecutionList.do</c:when>
	<c:when test="${nameValue == 'getEventProcessInfo'}">${pageContext.request.contextPath}/marketing/eventExecution/getEventProcessInfo.do</c:when>
	<c:when test="${nameValue == 'getEventTriggerDetail'}">${pageContext.request.contextPath}/marketing/eventExecution/getEventTriggerDetail.do</c:when>
	<c:when test="${nameValue == 'removeEventTrigger'}">${pageContext.request.contextPath}/marketing/eventExecution/removeEventTrigger.do</c:when>
	<c:when test="${nameValue == 'addEventTrigger'}">${pageContext.request.contextPath}/marketing/eventExecution/addEventTrigger.do</c:when>
	<c:when test="${nameValue == 'editEventTrigger'}">${pageContext.request.contextPath}/marketing/eventExecution/editEventTrigger.do</c:when>
	<c:when test="${nameValue == 'getEventExeHistoryList'}">${pageContext.request.contextPath}/marketing/eventExecution/getEventExeHistoryList.do</c:when> --%>

	<%-- 캠페인 홈 --%>
	<%-- <c:when test="${nameValue == 'getCampaignStatus'}">${pageContext.request.contextPath}/marketing/campaignhome/getCampaignStatus.do</c:when> --%>
	<c:when test="${nameValue == 'getCampaignPrchaseRec'}">${pageContext.request.contextPath}/marketing/campaignhome/getCampaignPrchaseRec.do</c:when>
	<c:when test="${nameValue == 'getHomePromList'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomePromList.do</c:when>
	<%-- <c:when test="${nameValue == 'getCampaignAllAct'}">${pageContext.request.contextPath}/marketing/campaignhome/getCampaignAllAct.do</c:when> --%>
	<c:when test="${nameValue == 'getHomeNoticeList'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeNoticeList.do</c:when>
	<c:when test="${nameValue == 'getHomeVolatility'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeVolatility.do</c:when>
	<c:when test="${nameValue == 'getHomeApprovalList'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeApprovalList.do</c:when>
	<c:when test="${nameValue == 'getHomeApprovalReqList'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeApprovalReqList.do</c:when>

	<c:when test="${nameValue == 'getTotalCust'}">${pageContext.request.contextPath}/marketing/campaignhome/getTotalCust.do</c:when>
	<c:when test="${nameValue == 'getNewCustOfMonth'}">${pageContext.request.contextPath}/marketing/campaignhome/getNewCustOfMonth.do</c:when>
	<c:when test="${nameValue == 'getExitSignCust'}">${pageContext.request.contextPath}/marketing/campaignhome/getExitSignCust.do</c:when>
	<c:when test="${nameValue == 'getPromotionOfMonth'}">${pageContext.request.contextPath}/marketing/campaignhome/getPromotionOfMonth.do</c:when>
	<c:when test="${nameValue == 'getReactRateForPromOfMonth'}">${pageContext.request.contextPath}/marketing/campaignhome/getReactRateForPromOfMonth.do</c:when>
	<c:when test="${nameValue == 'getNewCustOfDay'}">${pageContext.request.contextPath}/marketing/campaignhome/getNewCustOfDay.do</c:when>
	<c:when test="${nameValue == 'getCampaignOfMonth'}">${pageContext.request.contextPath}/marketing/campaignhome/getCampaignOfMonth.do</c:when>
	<c:when test="${nameValue == 'getPointStatus'}">${pageContext.request.contextPath}/marketing/campaignhome/getPointStatus.do</c:when>
	<c:when test="${nameValue == 'getCrmHome'}">${pageContext.request.contextPath}/marketing/campaignhome/getCrmHome.do</c:when>
	<c:when test="${nameValue == 'getHomeCamList'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeCamList.do</c:when>
	<c:when test="${nameValue == 'getHomeCamList2'}">${pageContext.request.contextPath}/marketing/campaignhome/getHomeCamList2.do</c:when>

	<%-- api --%>
	<c:when test="${nameValue == 'getPointBalance'}">${pageContext.request.contextPath}/loyalty/api/point/getPointBalance.do</c:when>
	<c:when test="${nameValue == 'getMemberIdentity'}">${pageContext.request.contextPath}/loyalty/api/member/getMemberIdentity.do</c:when>
	<c:when test="${nameValue == 'rdmPoint'}">${pageContext.request.contextPath}/loyalty/api/point/rdmPoint.do</c:when>
	<c:when test="${nameValue == 'acrlPoint'}">${pageContext.request.contextPath}/loyalty/api/point/acrlPoint.do</c:when>
	<c:when test="${nameValue == 'createMember'}">${pageContext.request.contextPath}/loyalty/api/member/createMember.do</c:when>
	<c:when test="${nameValue == 'dropMember'}">${pageContext.request.contextPath}/loyalty/api/member/dropMember.do</c:when>

	<c:when test="${nameValue == 'daisoDropMember'}">${pageContext.request.contextPath}/loyalty/member/mbr/daisoDropMember.do</c:when>

	<%-- RuelSet 캠페인 --%>
	<c:when test="${nameValue == 'saveRuleSet'}">${pageContext.request.contextPath}/loyalty/ruleSet/saveRuleSet.do</c:when>
	<c:when test="${nameValue == 'getRuleSet'}">${pageContext.request.contextPath}/loyalty/ruleSet/getRuleSet.do</c:when>
	<c:when test="${nameValue == 'getTierList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getTierList.do</c:when>
	<c:when test="${nameValue == 'getLoyProdList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getLoyProdList.do</c:when>
	<c:when test="${nameValue == 'getLoyProdCategoryList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getLoyProdCategoryList.do</c:when>
	<c:when test="${nameValue == 'getLoyBrdCategoryList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getLoyBrdCategoryList.do</c:when>
	<c:when test="${nameValue == 'getLoyChannelList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getLoyChannelList.do</c:when>

	<%-- Ruleset 캠페인 : 다이소 신규 --%>
	<c:when test="${nameValue == 'excelDownloadChannelTemplate'}">${pageContext.request.contextPath}/loyalty/ruleSet/excelDownloadChannelTemplate.do</c:when>
	<c:when test="${nameValue == 'excelUploadChannelTemplate'}">${pageContext.request.contextPath}/loyalty/ruleSet/excelUploadChannelTemplate.do</c:when>

	<%-- Loyalty RuleSet 관리 --%>
	<%-- <c:when test="${nameValue == 'getRuleSetRefListByRidPgm'}">${pageContext.request.contextPath}/system/ruleSetRef/getRuleSetRefListByRidPgm.do</c:when>
	<c:when test="${nameValue == 'getRuleSetRefGridByRidPgm'}">${pageContext.request.contextPath}/system/ruleSetRef/getRuleSetRefGridByRidPgm.do</c:when>
	<c:when test="${nameValue == 'getRuleSetRefItem'}">${pageContext.request.contextPath}/system/ruleSetRef/getRuleSetRefItem.do</c:when>
	<c:when test="${nameValue == 'getRuleSetRefItemByPromId'}">${pageContext.request.contextPath}/system/ruleSetRef/getRuleSetRefItemByPromId.do</c:when>
	<c:when test="${nameValue == 'addRuleSetRef'}">${pageContext.request.contextPath}/system/ruleSetRef/addRuleSetRef.do</c:when>
	<c:when test="${nameValue == 'editRuleSetRef'}">${pageContext.request.contextPath}/system/ruleSetRef/editRuleSetRef.do</c:when>
	<c:when test="${nameValue == 'removeRuleSetRef'}">${pageContext.request.contextPath}/system/ruleSetRef/removeRuleSetRef.do</c:when>
	<c:when test="${nameValue == 'ruleSetRefduplChk'}">${pageContext.request.contextPath}/system/ruleSetRef/ruleSetRefduplChk.do</c:when> --%>
	<%-- Loyalty Offer --%>
	<c:when test="${nameValue == 'getLoyOfferMstList'}">${pageContext.request.contextPath}/loyalty/offer/getLoyOfferMstList.do</c:when>
	<c:when test="${nameValue == 'getLoyOfferDetail'}">${pageContext.request.contextPath}/loyalty/offer/getLoyOfferDetail.do</c:when>
	<c:when test="${nameValue == 'saveLoyOffer'}">${pageContext.request.contextPath}/loyalty/offer/saveLoyOffer.do</c:when>
	<c:when test="${nameValue == 'checkActCamUsingOffer'}">${pageContext.request.contextPath}/loyalty/offer/checkActCamUsingOffer.do</c:when>
	<c:when test="${nameValue == 'getOfferChnlList'}">${pageContext.request.contextPath}/loyalty/offer/getOfferChnlList.do</c:when>
	<c:when test="${nameValue == 'insertOfferChnl'}">${pageContext.request.contextPath}/loyalty/offer/insertOfferChnl.do</c:when>
	<c:when test="${nameValue == 'deleteOfferChnl'}">${pageContext.request.contextPath}/loyalty/offer/deleteOfferChnl.do</c:when>
	<c:when test="${nameValue == 'getOfferProdList'}">${pageContext.request.contextPath}/loyalty/offer/getOfferProdList.do</c:when>
	<c:when test="${nameValue == 'insertOfferProd'}">${pageContext.request.contextPath}/loyalty/offer/insertOfferProd.do</c:when>
	<c:when test="${nameValue == 'deleteOfferProd'}">${pageContext.request.contextPath}/loyalty/offer/deleteOfferProd.do</c:when>
	<c:when test="${nameValue == 'getLoyOfferUseLmtChnlList'}">${pageContext.request.contextPath}/loyalty/offer/getLoyOfferUseLmtChnlList.do</c:when>
	<c:when test="${nameValue == 'getOfferCheck'}">${pageContext.request.contextPath}/loyalty/offer/getOfferCheck.do</c:when>
	<%-- Loyalty Simulation --%>
	<c:when test="${nameValue == 'getChnlComboList'}">${pageContext.request.contextPath}/loyalty/simulation/getChnlComboList.do</c:when>
	<c:when test="${nameValue == 'getMemList'}">${pageContext.request.contextPath}/loyalty/simulation/getMemList.do</c:when>

	<%-- 포인트 관리 --%>
	<c:when test="${nameValue == 'getPointList'}">${pageContext.request.contextPath}/loyalty/point/getPointList.do</c:when>
	<%-- 정산 관리 --%>
	<c:when test="${nameValue == 'getSettleDayAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleDayAList.do</c:when>
	<c:when test="${nameValue == 'getSettleDayCList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleDayCList.do</c:when>
	<c:when test="${nameValue == 'getSettleMonAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonAList.do</c:when>
	<c:when test="${nameValue == 'getSettleMonCList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonCList.do</c:when>
	<c:when test="${nameValue == 'getSettleHistoryList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleHistoryList.do</c:when>
	<c:when test="${nameValue == 'getSettleHistoryDetail'}">${pageContext.request.contextPath}/loyalty/settle/getSettleHistoryDetail.do</c:when>
	<c:when test="${nameValue == 'getSettleLogList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleLogList.do</c:when>
	<c:when test="${nameValue == 'getAffiliateTransList'}">${pageContext.request.contextPath}/loyalty/settle/getAffiliateTransList.do</c:when>
	<c:when test="${nameValue == 'addAccountDetail'}">${pageContext.request.contextPath}/loyalty/settle/addAccountDetail.do</c:when>
	<c:when test="${nameValue == 'getSettleLogDetail'}">${pageContext.request.contextPath}/loyalty/settle/getSettleLogDetail.do</c:when>
	<c:when test="${nameValue == 'getSettleDetailPointSum'}">${pageContext.request.contextPath}/loyalty/settle/getSettleDetailPointSum.do</c:when>
	<c:when test="${nameValue == 'updateAccountDetail'}">${pageContext.request.contextPath}/loyalty/settle/updateAccountDetail.do</c:when>
	<c:when test="${nameValue == 'settleApprovalReq'}">${pageContext.request.contextPath}/loyalty/settle/settleApprovalReq.do</c:when>
	<c:when test="${nameValue == 'getAffiliateTransDtlList'}">${pageContext.request.contextPath}/loyalty/settle/getAffiliateTransDtlList.do</c:when>
	<c:when test="${nameValue == 'getSettleDetailSeqCheck'}">${pageContext.request.contextPath}/loyalty/settle/getSettleDetailSeqCheck.do</c:when>
	<c:when test="${nameValue == 'getAffiliateSum'}">${pageContext.request.contextPath}/loyalty/settle/getAffiliateSum.do</c:when>
	<c:when test="${nameValue == 'cancelSettleAppr'}">${pageContext.request.contextPath}/loyalty/settle/cancelSettleAppr.do</c:when>
	<c:when test="${nameValue == 'updateSettleDetailSum'}">${pageContext.request.contextPath}/loyalty/settle/updateSettleDetailSum.do</c:when>
	<c:when test="${nameValue == 'confirmSettle'}">${pageContext.request.contextPath}/loyalty/settle/confirmSettle.do</c:when>
	<c:when test="${nameValue == 'getSettlePntSavList'}">${pageContext.request.contextPath}/loyalty/settle/getSettlePntSavList.do</c:when>
	<c:when test="${nameValue == 'pntSavExeDwon'}">${pageContext.request.contextPath}/loyalty/settle/pntSavExeDwon.do</c:when>
	<c:when test="${nameValue == 'pntUseExeDown'}">${pageContext.request.contextPath}/loyalty/settle/pntUseExeDown.do</c:when>
	<c:when test="${nameValue == 'getSettlePntUseList'}">${pageContext.request.contextPath}/loyalty/settle/getSettlePntUseList.do</c:when>
	<c:when test="${nameValue == 'getCSPointAcrlList'}">${pageContext.request.contextPath}/loyalty/settle/getCSPointAcrlList.do</c:when>
	<c:when test="${nameValue == 'getCSPointAcrlSum'}">${pageContext.request.contextPath}/loyalty/settle/getCSPointAcrlSum.do</c:when>
	<c:when test="${nameValue == 'getCSPointAcrlListExcel'}">${pageContext.request.contextPath}/loyalty/settle/getCSPointAcrlListExcel.do</c:when>
	<%-- Loyalty 이벤트 함수 유형 관리 --%>
	<c:when test="${nameValue == 'getUnstrucList'}">${pageContext.request.contextPath}/system/unstruc/getUnstrucList.do</c:when>
	<c:when test="${nameValue == 'getUnstrucItem'}">${pageContext.request.contextPath}/system/unstruc/getUnstrucItem.do</c:when>

	<c:when test="${nameValue == 'getUnstrucUsingByCampaignChk'}">${pageContext.request.contextPath}/system/unstruc/getUnstrucUsingByCampaignChk.do</c:when>
	<c:when test="${nameValue == 'getUnstrucChk'}">${pageContext.request.contextPath}/system/unstruc/getUnstrucChk.do</c:when>
	<c:when test="${nameValue == 'addUnstrucItem'}">${pageContext.request.contextPath}/system/unstruc/addUnstrucItem.do</c:when>
	<c:when test="${nameValue == 'editUnstrucItem'}">${pageContext.request.contextPath}/system/unstruc/editUnstrucItem.do</c:when>
	<c:when test="${nameValue == 'removeUnstrucItem'}">${pageContext.request.contextPath}/system/unstruc/removeUnstrucItem.do</c:when>
	<%-- Loyalty 인터렉션 유형 관리 --%>
	<c:when test="${nameValue == 'getIntactList'}">${pageContext.request.contextPath}/system/intact/getIntactList.do</c:when>
	<c:when test="${nameValue == 'getIntactItem'}">${pageContext.request.contextPath}/system/intact/getIntactItem.do</c:when>

	<c:when test="${nameValue == 'checkCampaignsUsingIntect'}">${pageContext.request.contextPath}/system/intact/checkCampaignsUsingIntect.do</c:when>
	<c:when test="${nameValue == 'checkDuplicationIntactType'}">${pageContext.request.contextPath}/system/intact/checkDuplicationIntactType.do</c:when>
	<c:when test="${nameValue == 'addIntactItem'}">${pageContext.request.contextPath}/system/intact/addIntactItem.do</c:when>
	<c:when test="${nameValue == 'editIntactItem'}">${pageContext.request.contextPath}/system/intact/editIntactItem.do</c:when>
	<c:when test="${nameValue == 'removeIntactItem'}">${pageContext.request.contextPath}/system/intact/removeIntactItem.do</c:when>
	<%--
        Loyalty Action URL Configuration End
    --%>

	<%--
        Loyalty TXN Action URL Configuration Start

    <c:when test="${nameValue == 'loyTxnFindMember'}">${pageContext.request.contextPath}/loyalty/loytxn/loyTxnFindMember.do</c:when>
    <c:when test="${nameValue == 'loyTxnFindPoint'}">${pageContext.request.contextPath}/loyalty/loytxn/loyTxnFindPoint.do</c:when>
    <c:when test="${nameValue == 'loyTxnAcrlPoint'}">${pageContext.request.contextPath}/loyalty/loytxn/loyTxnAcrlPoint.do</c:when>
    <c:when test="${nameValue == 'loyTxnRdmPoint'}">${pageContext.request.contextPath}/loyalty/loytxn/loyTxnRdmPoint.do</c:when>
    --%>
	<%--
        Loyalty TXN Action URL Configuration End
    --%>


	<%-- VOC 포인트  --%>
	<c:when test="${nameValue == 'vocPntReq'}">${pageContext.request.contextPath}/loyalty/common/vocPntReq.do</c:when>
	<c:when test="${nameValue == 'getVocMemberList'}">${pageContext.request.contextPath}/loyalty/voc/getVocMemberList.do</c:when>
	<c:when test="${nameValue == 'getVocMemberDetail'}">${pageContext.request.contextPath}/loyalty/voc/getVocMemberDetail.do</c:when>
	<c:when test="${nameValue == 'getVocInitPopupData'}">${pageContext.request.contextPath}/loyalty/voc/getVocInitPopupData.do</c:when>
	<c:when test="${nameValue == 'addVocPointAcrlRdm'}">${pageContext.request.contextPath}/loyalty/voc/addVocPointAcrlRdm.do</c:when>

	<c:when test="${nameValue == 'getOrganizationList'}">${pageContext.request.contextPath}/system/organization/getOrganizationList.do</c:when>
	<c:when test="${nameValue == 'getOrganizationDetail'}">${pageContext.request.contextPath}/system/organization/getOrganizationDetail.do</c:when>
	<c:when test="${nameValue == 'getOrganizationInfoList'}">${pageContext.request.contextPath}/system/organization/getOrganizationInfoList.do</c:when>
	<c:when test="${nameValue == 'updateOrganization'}">${pageContext.request.contextPath}/system/organization/updateOrganization.do</c:when>
	<c:when test="${nameValue == 'insertOrganization'}">${pageContext.request.contextPath}/system/organization/insertOrganization.do</c:when>
	<c:when test="${nameValue == 'getOrganizationNodeList'}">${pageContext.request.contextPath}/system/organization/getOrganizationNodeList.do</c:when>

	<%-- Common Auth  --%>
	<c:when test="${nameValue == 'getMenuListAuth'}">${pageContext.request.contextPath}/system/menu/getMenuList.do</c:when>
	<c:when test="${nameValue == 'getAuthMenuProgList'}">${pageContext.request.contextPath}/system/menu/getAuthMenuProgList.do</c:when>
	<c:when test="${nameValue == 'deleteAuthMenuList'}">${pageContext.request.contextPath}/system/menu/deleteMenuList.do</c:when>
	<c:when test="${nameValue == 'addAuthMenuList'}">${pageContext.request.contextPath}/system/menu/addAuthMenuList.do</c:when>
	<c:when test="${nameValue == 'getAuthMenuListPop'}">${pageContext.request.contextPath}/system/menu/getAuthMenuListPop.do</c:when>
	<c:when test="${nameValue == 'addAuthMenuListProg'}">${pageContext.request.contextPath}/system/menu/addAuthMenuListProg.do</c:when>
	<c:when test="${nameValue == 'delAuthMenuListProg'}">${pageContext.request.contextPath}/system/menu/delAuthMenuListProg.do</c:when>
	<c:when test="${nameValue == 'updateAuthSortMenu'}">${pageContext.request.contextPath}/system/menu/updateSortMenu.do</c:when>
	<c:when test="${nameValue == 'getAuthSelectedMenuList'}">${pageContext.request.contextPath}/system/menu/getAuthMenuList.do</c:when>
	<c:when test="${nameValue == 'updateMenuIcon'}">${pageContext.request.contextPath}/system/menu/updateMenuIcon.do</c:when>
	<c:when test="${nameValue == 'removeMenuIcon'}">${pageContext.request.contextPath}/system/menu/removeMenuIcon.do</c:when>

	<c:when test="${nameValue == 'getEmpAddListModalForCallCenter'}">${pageContext.request.contextPath}/system/auth/getEmpAddListModalForCallCenter.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupDivisionList'}">${pageContext.request.contextPath}/system/auth/getAuthGroupDivisionList.do</c:when>
	<c:when test="${nameValue == 'deleteDivisionList'}">${pageContext.request.contextPath}/system/auth/deleteDivisionList.do</c:when>
	<c:when test="${nameValue == 'getDivisionAddListModal'}">${pageContext.request.contextPath}/system/auth/getDivisionAddListModal.do</c:when>
	<c:when test="${nameValue == 'addDivisionList'}">${pageContext.request.contextPath}/system/auth/addDivisionList.do</c:when>
	<c:when test="${nameValue == 'getAuthObjectListPop'}">${pageContext.request.contextPath}/system/auth/getAuthObjectListPop.do</c:when>
	<c:when test="${nameValue == 'setAuthObjRel'}">${pageContext.request.contextPath}/system/auth/setAuthObjRel.do</c:when>
	<c:when test="${nameValue == 'modifyUserPwd'}">${pageContext.request.contextPath}/system/auth/modifyUserPwd.do</c:when>
	<c:when test="${nameValue == 'getManageTabList'}">${pageContext.request.contextPath}/system/auth/getManageTabList.do</c:when>
	<c:when test="${nameValue == 'deleteManageTabList'}">${pageContext.request.contextPath}/system/auth/deleteManageTabList.do</c:when>
	<c:when test="${nameValue == 'modifyManageTab'}">${pageContext.request.contextPath}/system/auth/modifyManageTab.do</c:when>
	<c:when test="${nameValue == 'setManageTab'}">${pageContext.request.contextPath}/system/auth/setManageTab.do</c:when>
	<c:when test="${nameValue == 'getManageTabPopDetail'}">${pageContext.request.contextPath}/system/auth/getManageTabPopDetail.do</c:when>
	<c:when test="${nameValue == 'modifyUserFirstLoginFlg'}">${pageContext.request.contextPath}/system/auth/modifyUserFirstLoginFlg.do</c:when>

	<%-- 부서 및 매장관리 내 사용자 및 권한 그룹 --%>
	<c:when test="${nameValue == 'getLoyPgmListPop'}">${pageContext.request.contextPath}/system/auth/getLoyPgmListPop.do</c:when>
	<%--공통 로그 --%>
	<c:when test="${nameValue == 'getExcelDownloadLogList'}">${pageContext.request.contextPath}/common/log/getExcelDownloadLogList.do</c:when>
	<c:when test="${nameValue == 'getCondLogHistoryList'}">${pageContext.request.contextPath}/common/log/getCondLogHistoryList.do</c:when>
	<c:when test="${nameValue == 'getAuthLogHistoryList'}">${pageContext.request.contextPath}/common/log/getAuthLogHistoryList.do</c:when>
	<c:when test="${nameValue == 'clearMaskCondLogHistList'}">${pageContext.request.contextPath}/common/log/clearMaskCondLogHistList.do</c:when>

	<%--스탬프 --%>
	<%--<c:when test=" ${nameValue == 'getStampTxnList'}">${pageContext.request.contextPath}/loyalty/stamp/stampTxnList.do</c:when>
	<c:when test="${nameValue == 'testViewList'}">${pageContext.request.contextPath}/loyalty/test/testViewList.do</c:when>
	<c:when test="${nameValue == 'getStampDetail'}">${pageContext.request.contextPath}/loyalty/stamp/getStampDetail.do</c:when>
	<c:when test="${nameValue == 'getStampDetailPop'}">${pageContext.request.contextPath}/loyalty/stamp/getStampDetailPop.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpList'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpList.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpDetail'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpDetail.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpDetail2'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpDetail2.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpItemList'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpItemList.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpStoreList'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpStoreList.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpMbrList'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpMbrList.do</c:when>
	<c:when test="${nameValue == 'setLoyStmp'}">${pageContext.request.contextPath}/loyalty/stamp/setLoyStmp.do</c:when>
	<c:when test="${nameValue == 'removeLoyStmp'}">${pageContext.request.contextPath}/loyalty/stamp/removeLoyStmp.do</c:when>
	<c:when test="${nameValue == 'activeStmp'}">${pageContext.request.contextPath}/loyalty/stamp/activeStmp.do</c:when>
	<c:when test="${nameValue == 'editLoyStmp'}">${pageContext.request.contextPath}/loyalty/stamp/editLoyStmp.do</c:when>
	<c:when test="${nameValue == 'editLoyStmpItem'}">${pageContext.request.contextPath}/loyalty/stamp/editLoyStmpItem.do</c:when>
	<c:when test="${nameValue == 'excelDownLoyStmpStoreList'}">${pageContext.request.contextPath}/loyalty/stamp/excelDownLoyStmpStoreList.do</c:when>
	<c:when test="${nameValue == 'excelDownLoyStmpMbrList'}">${pageContext.request.contextPath}/loyalty/stamp/excelDownLoyStmpMbrList.do</c:when>
	<c:when test="${nameValue == 'excelUploadStmpStoreTemplate'}">${pageContext.request.contextPath}/loyalty/stamp/excelUploadStmpStoreTemplate.do</c:when>
	<c:when test="${nameValue == 'removeLoyStmpStore'}">${pageContext.request.contextPath}/loyalty/stamp/removeLoyStmpStore.do</c:when>
	<c:when test="${nameValue == 'getStmpItemDetail'}">${pageContext.request.contextPath}/loyalty/stamp/getStmpItemDetail.do</c:when>
	<c:when test="${nameValue == 'inactiveStmp'}">${pageContext.request.contextPath}/loyalty/stamp/inactiveStmp.do</c:when>
	<c:when test="${nameValue == 'setLoyStmpStore'}">${pageContext.request.contextPath}/loyalty/stamp/setLoyStmpStore.do</c:when>
	<c:when test="${nameValue == 'getLoyStmpMbrTgtList'}">${pageContext.request.contextPath}/loyalty/stamp/getLoyStmpMbrTgtList.do</c:when>
	<c:when test="${nameValue == 'removeLoyStmpMbrTgt'}">${pageContext.request.contextPath}/loyalty/stamp/removeLoyStmpMbrTgt.do</c:when>
	<c:when test="${nameValue == 'excelUploadStmpMbrTgtTemplate'}">${pageContext.request.contextPath}/loyalty/stamp/excelUploadStmpMbrTgtTemplate.do</c:when>
	<c:when test="${nameValue == 'excelDownLoyStmpMbrTgtList'}">${pageContext.request.contextPath}/loyalty/stamp/excelDownLoyStmpMbrTgtList.do</c:when>
	<c:when test="${nameValue == 'excelDownloadMbrTgtTemplate'}">${pageContext.request.contextPath}/loyalty/stamp/excelDownloadMbrTgtTemplate.do</c:when>
	<c:when test="${nameValue == 'setLoyStmpMbrTgt'}">${pageContext.request.contextPath}/loyalty/stamp/setLoyStmpMbrTgt.do</c:when>
	<c:when test="${nameValue == 'removeLoyStmpMbrTgt2'}">${pageContext.request.contextPath}/loyalty/stamp/removeLoyStmpMbrTgt2.do</c:when>
	<c:when test="${nameValue == 'removeLoyStmpItemCamNo'}">${pageContext.request.contextPath}/loyalty/stamp/removeLoyStmpItemCamNo.do</c:when>
 --%>

	<%--스탬프/빙고 --%>
    <c:when test="${nameValue == 'getStampBingoList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoList.do</c:when>
    <c:when test="${nameValue == 'exportExcelStampBingoList'}">${pageContext.request.contextPath}/loyalty/stampBingo/exportExcelStampBingoList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoDetail'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoDetail.do</c:when>
    <c:when test="${nameValue == 'addStampBingo'}">${pageContext.request.contextPath}/loyalty/stampBingo/addStampBingo.do</c:when>
    <c:when test="${nameValue == 'editStampBingo'}">${pageContext.request.contextPath}/loyalty/stampBingo/editStampBingo.do</c:when>
    <c:when test="${nameValue == 'removeStampBingo'}">${pageContext.request.contextPath}/loyalty/stampBingo/removeStampBingo.do</c:when>
    <c:when test="${nameValue == 'stopStampBingo'}">${pageContext.request.contextPath}/loyalty/stampBingo/stopStampBingo.do</c:when>
    <c:when test="${nameValue == 'getStampBingoStepList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoStepList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoStepDetail'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoStepDetail.do</c:when>
    <c:when test="${nameValue == 'addStampBingoStep'}">${pageContext.request.contextPath}/loyalty/stampBingo/addStampBingoStep.do</c:when>
    <c:when test="${nameValue == 'editStampBingoStep'}">${pageContext.request.contextPath}/loyalty/stampBingo/editStampBingoStep.do</c:when>
    <c:when test="${nameValue == 'removeStampBingoStep'}">${pageContext.request.contextPath}/loyalty/stampBingo/removeStampBingoStep.do</c:when>
    <c:when test="${nameValue == 'getStampBingoMbrList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoMbrList.do</c:when>
    <c:when test="${nameValue == 'exportExcelStampBingoMbrList'}">${pageContext.request.contextPath}/loyalty/stampBingo/exportExcelStampBingoMbrList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoMbrHistList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoMbrHistList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoChnlList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoChnlList.do</c:when>
    <c:when test="${nameValue == 'addStampBingoChnl'}">${pageContext.request.contextPath}/loyalty/stampBingo/addStampBingoChnl.do</c:when>
    <c:when test="${nameValue == 'removeStampBingoChnl'}">${pageContext.request.contextPath}/loyalty/stampBingo/removeStampBingoChnl.do</c:when>
    <c:when test="${nameValue == 'getStampBingoChnlHistList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoChnlHistList.do</c:when>
    <c:when test="${nameValue == 'exportExcelStampBingoChnlHistList'}">${pageContext.request.contextPath}/loyalty/stampBingo/exportExcelStampBingoChnlHistList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoBenfList'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoBenfList.do</c:when>
    <c:when test="${nameValue == 'getStampBingoBenfDetail'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampBingoBenfDetail.do</c:when>
    <c:when test="${nameValue == 'addStampBingoBenf'}">${pageContext.request.contextPath}/loyalty/stampBingo/addStampBingoBenf.do</c:when>
    <c:when test="${nameValue == 'editStampBingoBenf'}">${pageContext.request.contextPath}/loyalty/stampBingo/editStampBingoBenf.do</c:when>
    <c:when test="${nameValue == 'removeStampBingoBenf'}">${pageContext.request.contextPath}/loyalty/stampBingo/removeStampBingoBenf.do</c:when>
	<c:when test="${nameValue == 'getStampListPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/getStampListPop.do</c:when>

    <%--  게임 --%>
    <c:when test="${nameValue == 'getGameList'}">${pageContext.request.contextPath}/loyalty/game/getGameList.do</c:when>
    <c:when test="${nameValue == 'exportExcelGameList'}">${pageContext.request.contextPath}/loyalty/game/exportExcelGameList.do</c:when>
    <c:when test="${nameValue == 'getGameDetail'}">${pageContext.request.contextPath}/loyalty/game/getGameDetail.do</c:when>
    <c:when test="${nameValue == 'addGame'}">${pageContext.request.contextPath}/loyalty/game/addGame.do</c:when>
    <c:when test="${nameValue == 'editGame'}">${pageContext.request.contextPath}/loyalty/game/editGame.do</c:when>
    <c:when test="${nameValue == 'removeGame'}">${pageContext.request.contextPath}/loyalty/game/removeGame.do</c:when>
    <c:when test="${nameValue == 'stopGame'}">${pageContext.request.contextPath}/loyalty/game/stopGame.do</c:when>
    <c:when test="${nameValue == 'getGameSubDetail'}">${pageContext.request.contextPath}/loyalty/game/getGameSubDetail.do</c:when>
    <c:when test="${nameValue == 'editGameSub'}">${pageContext.request.contextPath}/loyalty/game/editGameSub.do</c:when>
    <c:when test="${nameValue == 'removeGameSub'}">${pageContext.request.contextPath}/loyalty/game/removeGameSub.do</c:when>
    <c:when test="${nameValue == 'getGameRuleList'}">${pageContext.request.contextPath}/loyalty/game/getGameRuleList.do</c:when>
    <c:when test="${nameValue == 'getGameRuleDetail'}">${pageContext.request.contextPath}/loyalty/game/getGameRuleDetail.do</c:when>
    <c:when test="${nameValue == 'addGameRule'}">${pageContext.request.contextPath}/loyalty/game/addGameRule.do</c:when>
    <c:when test="${nameValue == 'editGameRule'}">${pageContext.request.contextPath}/loyalty/game/editGameRule.do</c:when>
    <c:when test="${nameValue == 'removeGameRule'}">${pageContext.request.contextPath}/loyalty/game/removeGameRule.do</c:when>
    <c:when test="${nameValue == 'getGameJoinList'}">${pageContext.request.contextPath}/loyalty/game/getGameJoinList.do</c:when>
    <c:when test="${nameValue == 'exportExcelGameJoinList'}">${pageContext.request.contextPath}/loyalty/game/exportExcelGameJoinList.do</c:when>
    <c:when test="${nameValue == 'getGameTicketList'}">${pageContext.request.contextPath}/loyalty/game/getGameTicketList.do</c:when>
    <c:when test="${nameValue == 'exportExcelGameTicketList'}">${pageContext.request.contextPath}/loyalty/game/exportExcelGameTicketList.do</c:when>

	<%-- 가맹점  --%>
	<c:when test="${nameValue == 'getChannelSearchHelp'}">${pageContext.request.contextPath}/loyalty/channel/getChannelSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getChannelList'}">${pageContext.request.contextPath}/loyalty/channel/getChannelList.do</c:when>
	<c:when test="${nameValue == 'getChannelDetail'}">${pageContext.request.contextPath}/loyalty/channel/getChannelDetail.do</c:when>
	<c:when test="${nameValue == 'saveChannelDetail'}">${pageContext.request.contextPath}/loyalty/channel/saveChannelDetail.do</c:when>
	<c:when test="${nameValue == 'editChannelDetail'}">${pageContext.request.contextPath}/loyalty/channel/editChannelDetail.do</c:when>
	<c:when test="${nameValue == 'getDonationPointList'}">${pageContext.request.contextPath}/loyalty/channel/getDonationPointList.do</c:when>
	<c:when test="${nameValue == 'getDonationPointResultList'}">${pageContext.request.contextPath}/loyalty/channel/getDonationPointResultList.do</c:when>
	<c:when test="${nameValue == 'donationPointRdmRequest'}">${pageContext.request.contextPath}/loyalty/channel/donationPointRdmRequest.do</c:when>
	<c:when test="${nameValue == 'getChnlTxnMemList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlTxnMemList.do</c:when>
	<c:when test="${nameValue == 'getChnlSubList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlSubList.do</c:when>
	<c:when test="${nameValue == 'getChnlAcrlInfoList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlAcrlInfoList.do</c:when>
	<c:when test="${nameValue == 'getChnlRdmInfoList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlRdmInfoList.do</c:when>
	<c:when test="${nameValue == 'getChnlStlInfoList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlStlInfoList.do</c:when>
	<c:when test="${nameValue == 'getChnlAddInfo'}">${pageContext.request.contextPath}/loyalty/channel/getChnlAddInfo.do</c:when>
	<c:when test="${nameValue == 'editChnlAddInfo'}">${pageContext.request.contextPath}/loyalty/channel/editChnlAddInfo.do</c:when>
	<c:when test="${nameValue == 'getChnlChangeHistList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlChangeHistList.do</c:when>
	<c:when test="${nameValue == 'getChnlPointChangeHistList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlPointChangeHistList.do</c:when>
	<c:when test="${nameValue == 'selectE1ChannelSetting'}">${pageContext.request.contextPath}/loyalty/channel/selectE1ChannelSetting.do</c:when>
	<c:when test="${nameValue == 'getChnlTxnHistList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getChnlSubTxnHistList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlSubTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getChnlStnPntTxnList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlStnPntTxnList.do</c:when>
	<c:when test="${nameValue == 'getOcaChannelSearchHelp'}">${pageContext.request.contextPath}/loyalty/channel/getOcaChannelSearchHelp.do</c:when>
	<%-- <c:when test="${nameValue == 'ChnlExecDown'}">${pageContext.request.contextPath}/loyalty/channel/ChnlExecDown.do</c:when> --%>

	<%-- 채널 --%>
	<c:when test="${nameValue == 'removeChannel'}">${pageContext.request.contextPath}/loyalty/channel/removeChannel.do</c:when>
	<c:when test="${nameValue == 'getChannelDefaultInfo'}">${pageContext.request.contextPath}/loyalty/channel/getChannelDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'saveChnlAddInfo'}">${pageContext.request.contextPath}/loyalty/channel/saveChnlAddInfo.do</c:when>
	<c:when test="${nameValue == 'callGetAddrApi'}">${pageContext.request.contextPath}/external/kakaoservice/callGetAddrApi.do</c:when>
	<c:when test="${nameValue == 'callGetAddrXYApi'}">${pageContext.request.contextPath}/loyalty/channel/callGetAddrXYApi.do</c:when>
	<c:when test="${nameValue == 'saveChnlDetail'}">${pageContext.request.contextPath}/loyalty/channel/saveChnlDetail.do</c:when>
	<c:when test="${nameValue == 'modifyChnlDetail'}">${pageContext.request.contextPath}/loyalty/channel/modifyChnlDetail.do</c:when>
	<c:when test="${nameValue == 'getParentChnlTList'}">${pageContext.request.contextPath}/loyalty/channel/getParentChnlTList.do</c:when>
	<c:when test="${nameValue == 'saveChnlAddInfoDetail'}">${pageContext.request.contextPath}/loyalty/channel/saveChnlAddInfoDetail.do</c:when>
	<c:when test="${nameValue == 'modifyChnlAddInfoDetail'}">${pageContext.request.contextPath}/loyalty/channel/modifyChnlAddInfoDetail.do</c:when>
	<c:when test="${nameValue == 'getChnlLoyPgmList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlLoyPgmList.do</c:when>
	<c:when test="${nameValue == 'getLoyPgmDetailNew'}">${pageContext.request.contextPath}/loyalty/channel/getLoyPgmDetailNew.do</c:when>
	<c:when test="${nameValue == 'getChnlSettleList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlSettleList.do</c:when>
	<c:when test="${nameValue == 'getChnlLoyImgInfoList'}">${pageContext.request.contextPath}/loyalty/channel/getChnlLoyImgInfoList.do</c:when>
	<c:when test="${nameValue == 'getLoyImgDesc'}">${pageContext.request.contextPath}/loyalty/channel/getLoyImgDesc.do</c:when>
	<c:when test="${nameValue == 'getLoyImgDel'}">${pageContext.request.contextPath}/loyalty/channel/getLoyImgDel.do</c:when>
	<c:when test="${nameValue == 'addChnlImgInfo'}">${pageContext.request.contextPath}/loyalty/channel/addChnlImgInfo.do</c:when>
	<c:when test="${nameValue == 'saveImgDetail'}">${pageContext.request.contextPath}/loyalty/channel/saveImgDetail.do</c:when>
	<c:when test="${nameValue == 'excelDownChannel'}">${pageContext.request.contextPath}/loyalty/channel/excelDownChannel.do</c:when>
	<c:when test="${nameValue == 'setChnlMultiUpload'}">${pageContext.request.contextPath}/loyalty/channel/setChnlMultiUpload.do</c:when>


	<%-- 회원 --%>
	<c:when test="${nameValue == 'getMbrGroupList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupList.do</c:when>
	<c:when test="${nameValue == 'getMbrSearchHelp'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getDropMbrList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getDropMbrList.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupDetail.do</c:when>
	<c:when test="${nameValue == 'savMbrGroupDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/savMbrGroupDetail.do</c:when>
	<c:when test="${nameValue == 'editMbrGroupDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrGroupDetail.do</c:when>
	<c:when test="${nameValue == 'getEmpSearchHelp'}">${pageContext.request.contextPath}/loyalty/member/mbr/getEmpSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getMbrRenameReqList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrRenameReqList.do</c:when>
	<c:when test="${nameValue == 'getMbrRenameReqDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrRenameReqDetail.do</c:when>
	<c:when test="${nameValue == 'saveMbrRenameReqDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveMbrRenameReqDetail.do</c:when>
	<c:when test="${nameValue == 'editMbrRenameReqDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrRenameReqDetail.do</c:when>
	<c:when test="${nameValue == 'getMbrOrangeCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrOrangeCardList.do</c:when>
	<c:when test="${nameValue == 'getMbrListCard'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrListCard.do</c:when>
	<c:when test="${nameValue == 'getMbrVocList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrVocList.do</c:when>
    <c:when test="${nameValue == 'getMbrVocListDesc'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrVocListDesc.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrStmpInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStmpInfo.do</c:when>
	<c:when test="${nameValue == 'getMbrStnPntTxnList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrStnPntTxnList.do</c:when>
	<c:when test="${nameValue == 'getMbrChangeHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrChangeHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrGroupCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrGroupCardList.do</c:when>
	<c:when test="${nameValue == 'getMbrDetailInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrDetailInfo.do</c:when>
	<c:when test="${nameValue == 'editMbrGroupDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrGroupDetail.do</c:when>
	<c:when test="${nameValue == 'dropMbrProc'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrProc.do</c:when>
	<c:when test="${nameValue == 'editMbrName'}">${pageContext.request.contextPath}/loyalty/member/mbr/editMbrName.do</c:when>
	<c:when test="${nameValue == 'getMbrEventHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrEventHistList.do</c:when>
	<c:when test="${nameValue == 'getMbrCampaignResList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCampaignResList.do</c:when>
	<c:when test="${nameValue == 'getMbrAllCount'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrAllCount.do</c:when>
	<c:when test="${nameValue == 'clearMaskListMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/clearMaskListMbr.do</c:when>
	<c:when test="${nameValue == 'getMbrAgreList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrAgreList.do</c:when>
	<c:when test="${nameValue == 'mbrSecsnMbrToAble'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrSecsnMbrToAble.do</c:when>
	<c:when test="${nameValue == 'setCustDorChange'}">${pageContext.request.contextPath}/loyalty/member/mbr/setCustDorChange.do</c:when>


	<%--포인트 거래 --%>
	<c:when test="${nameValue == 'getTransactionList'}">${pageContext.request.contextPath}/loyalty/trans/getTransactionList.do</c:when>
	<c:when test="${nameValue == 'getPointDetailPop'}">${pageContext.request.contextPath}/loyalty/trans/getPointDetailPop.do</c:when>
	<c:when test="${nameValue == 'getTransactionDetail'}">${pageContext.request.contextPath}/loyalty/trans/getTransactionDetail.do</c:when>
	<c:when test="${nameValue == 'getTransArchiveDetail'}">${pageContext.request.contextPath}/loyalty/trans/getTransArchiveDetail.do</c:when>
	<c:when test="${nameValue == 'getTransactAddInfo'}">${pageContext.request.contextPath}/loyalty/trans/getTransactAddInfo.do</c:when>
	<c:when test="${nameValue == 'getTransPromoList'}">${pageContext.request.contextPath}/loyalty/trans/getTransPromoList.do</c:when>
	<c:when test="${nameValue == 'transactListMaskClear'}">${pageContext.request.contextPath}/loyalty/trans/transactListMaskClear.do</c:when>
	<c:when test="${nameValue == 'getPntTxnItemList'}">${pageContext.request.contextPath}/loyalty/trans/getPntTxnItemList.do</c:when>
	<c:when test="${nameValue == 'getTransSearchTestList'}">${pageContext.request.contextPath}/loyalty/trans/getTransSearchTestList.do</c:when>
	<c:when test="${nameValue == 'clearMaskTrans'}">${pageContext.request.contextPath}/loyalty/trans/clearMaskTrans.do</c:when>
	<c:when test="${nameValue == 'excelDownTransaction'}">${pageContext.request.contextPath}/loyalty/trans/excelDownTransaction.do</c:when>
	<c:when test="${nameValue == 'getPointUseTxnList'}">${pageContext.request.contextPath}/loyalty/trans/getPointUseTxnList.do</c:when>


	<c:when test="${nameValue == 'getMonthOfPoint'}">${pageContext.request.contextPath}/loyalty/trans/getMonthOfPoint.do</c:when>

	<c:when test="${nameValue == 'getTransPntGiftHistList'}">${pageContext.request.contextPath}/loyalty/trans/getTransPntGiftHistList.do</c:when>
	<c:when test="${nameValue == 'getTransStmpHistList'}">${pageContext.request.contextPath}/loyalty/trans/getTransStmpHistList.do</c:when>
	<c:when test="${nameValue == 'gePurTxnHistList'}">${pageContext.request.contextPath}/loyalty/trans/gePurTxnHistList.do</c:when>
	<c:when test="${nameValue == 'getPurNotMbrTxnHistList'}">${pageContext.request.contextPath}/loyalty/trans/getPurNotMbrTxnHistList.do</c:when>
	<c:when test="${nameValue == 'clearPutTxnMbr'}">${pageContext.request.contextPath}/loyalty/trans/clearPutTxnMbr.do</c:when>
	<c:when test="${nameValue == 'gePurTxnOptionHistList'}">${pageContext.request.contextPath}/loyalty/trans/gePurTxnOptionHistList.do</c:when>
	<c:when test="${nameValue == 'purTxnOptionHistExcelList'}">${pageContext.request.contextPath}/loyalty/trans/purTxnOptionHistExcelList.do</c:when>


	<%-- SMS 수신거부 --%>
	<c:when test="${nameValue == 'getSmsRejectList'}">${pageContext.request.contextPath}/loyalty/sms/getSmsRejectList.do</c:when>
	<c:when test="${nameValue == 'getSmsRejectDetail'}">${pageContext.request.contextPath}/loyalty/sms/getSmsRejectDetail.do</c:when>
	<c:when test="${nameValue == 'saveSmsRejectDetail'}">${pageContext.request.contextPath}/loyalty/sms/saveSmsRejectDetail.do</c:when>
	<c:when test="${nameValue == 'editSmsRejectDetail'}">${pageContext.request.contextPath}/loyalty/sms/editSmsRejectDetail.do</c:when>
	<%--수동요청 --%>
	<c:when test="${nameValue == 'getManualReqList'}">${pageContext.request.contextPath}/loyalty/manual/getManualReqList.do</c:when>
	<c:when test="${nameValue == 'getManualDetail'}">${pageContext.request.contextPath}/loyalty/manual/getManualDetail.do</c:when>
	<c:when test="${nameValue == 'insertManualInfo'}">${pageContext.request.contextPath}/loyalty/manual/insertManualInfo.do</c:when>
	<c:when test="${nameValue == 'updateManualInfo'}">${pageContext.request.contextPath}/loyalty/manual/updateManualInfo.do</c:when>
	<c:when test="${nameValue == 'checkMemCount'}">${pageContext.request.contextPath}/loyalty/manual/checkMemCount.do</c:when>
	<c:when test="${nameValue == 'checkVocRqt'}">${pageContext.request.contextPath}/loyalty/manual/checkVocRqt.do</c:when>
	<c:when test="${nameValue == 'checkMemStatus'}">${pageContext.request.contextPath}/loyalty/manual/checkMemStatus.do</c:when>
	<c:when test="${nameValue == 'updateActcInfo'}">${pageContext.request.contextPath}/loyalty/manual/updateActcInfo.do</c:when>
	<c:when test="${nameValue == 'updateVanApproval'}">${pageContext.request.contextPath}/loyalty/manual/updateVanApproval.do</c:when>
	<c:when test="${nameValue == 'inspectionReq'}">${pageContext.request.contextPath}/loyalty/manual/inspectionReq.do</c:when>
	<c:when test="${nameValue == 'vanImmediateApproval'}">${pageContext.request.contextPath}/loyalty/manual/vanImmediateApproval.do</c:when>
	<c:when test="${nameValue == 'vanApproval'}">${pageContext.request.contextPath}/loyalty/manual/vanApproval.do</c:when>
	<c:when test="${nameValue == 'vanApprovalReq'}">${pageContext.request.contextPath}/loyalty/manual/vanApprovalReq.do</c:when>
	<c:when test="${nameValue == 'cancelManualIns'}">${pageContext.request.contextPath}/loyalty/manual/cancelManualIns.do</c:when>

	<%--VOC 상담요청--%>
	<c:when test="${nameValue == 'getConsultList'}">${pageContext.request.contextPath}/voc/requestConsultation/getConsultList.do</c:when>
	<c:when test="${nameValue == 'getConsultDetail'}">${pageContext.request.contextPath}/voc/requestConsultation/getConsultDetail.do</c:when>
	<c:when test="${nameValue == 'getActyHistoryList'}">${pageContext.request.contextPath}/voc/requestConsultation/getActyHistoryList.do</c:when>
	<c:when test="${nameValue == 'getTransactionListByRidMbr'}">${pageContext.request.contextPath}/voc/requestConsultation/getTransactionListByRidMbr.do</c:when>
	<c:when test="${nameValue == 'getRgstCardListByRidMbr'}">${pageContext.request.contextPath}/voc/requestConsultation/getRgstCardListByRidMbr.do</c:when>
	<c:when test="${nameValue == 'setActyHistory'}">${pageContext.request.contextPath}/voc/requestConsultation/setActyHistory.do</c:when>
	<c:when test="${nameValue == 'modifyRequestConsultation'}">${pageContext.request.contextPath}/voc/requestConsultation/modifyRequestConsultation.do</c:when>
	<c:when test="${nameValue == 'setRequestConsultation'}">${pageContext.request.contextPath}/voc/requestConsultation/setRequestConsultation.do</c:when>
	<c:when test="${nameValue == 'getRecordFileListForNexus'}">${pageContext.request.contextPath}/voc/requestConsultation/getRecordFileListForNexus.do</c:when>
	<c:when test="${nameValue == 'getPbxRecordFileListForNexus'}">${pageContext.request.contextPath}/voc/requestConsultation/getPbxRecordFileListForNexus.do</c:when>
	<c:when test="${nameValue == 'getRecordFileListForCCA'}">${pageContext.request.contextPath}/voc/requestConsultation/getRecordFileListForCCA.do</c:when>
	<c:when test="${nameValue == 'getCtiRecordUrl'}">${pageContext.request.contextPath}/voc/requestConsultation/getCtiRecordUrl.do</c:when>
	<c:when test="${nameValue == 'modifyActyHistory'}">${pageContext.request.contextPath}/voc/requestConsultation/modifyActyHistory.do</c:when>
	<c:when test="${nameValue == 'getActyHistoryMsg'}">${pageContext.request.contextPath}/voc/requestConsultation/getActyHistoryMsg.do</c:when>
	<c:when test="${nameValue == 'getConsultMasking'}">${pageContext.request.contextPath}/voc/requestConsultation/getConsultMasking.do</c:when>
	<c:when test="${nameValue == 'getTmCampaignList'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmCampaignList.do</c:when>
	<c:when test="${nameValue == 'getTmCampaignDetail'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmCampaignDetail.do</c:when>
	<c:when test="${nameValue == 'getTmTargetMemList'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmTargetMemList.do</c:when>
	<c:when test="${nameValue == 'getTmAssignCount'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmAssignCount.do</c:when>
	<c:when test="${nameValue == 'getTmConsultantList'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmConsultantList.do</c:when>
	<c:when test="${nameValue == 'setUnAsnTm'}">${pageContext.request.contextPath}/voc/tmCampaign/setUnAsnTm.do</c:when>
	<c:when test="${nameValue == 'getTmCamTgtDetail'}">${pageContext.request.contextPath}/voc/tmCampaign/getTmCamTgtDetail.do</c:when>
	<c:when test="${nameValue == 'getReplyHistoryList'}">${pageContext.request.contextPath}/voc/requestConsultation/getReplyHistoryList.do</c:when>


	<%--VOC 콜/콜백/자동응답문자 이력 --%>
<%-- 	<c:when test="${nameValue == 'getCallList'}">${pageContext.request.contextPath}/voc/call/getCallList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getCallbackList'}">${pageContext.request.contextPath}/voc/call/getCallbackList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getAutoRespMsgList'}">${pageContext.request.contextPath}/voc/call/getAutoRespMsgList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'modifyChangeCBStatus'}">${pageContext.request.contextPath}/voc/call/modifyChangeCBStatus.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getCBStatusDetail'}">${pageContext.request.contextPath}/voc/call/getCBStatusDetail.do</c:when> --%>

	<%--VOC 음성사서함 관리 --%>
<%-- 	<c:when test="${nameValue == 'getVoiceMailBoxList'}">${pageContext.request.contextPath}/voc/voiceMailBox/getVoiceMailBoxList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getRealCustDetail'}">${pageContext.request.contextPath}/voc/voiceMailBox/getRealCustDetail.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getCustAddInfoDetailForVoc'}">${pageContext.request.contextPath}/voc/voiceMailBox/getCustAddInfoDetail.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'checkCardValid'}">${pageContext.request.contextPath}/voc/voiceMailBox/checkCardValid.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'registerAddCard'}">${pageContext.request.contextPath}/voc/voiceMailBox/registerAddCard.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'registerNewCard'}">${pageContext.request.contextPath}/voc/voiceMailBox/registerNewCard.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'modifyCallContactOccuringError'}">${pageContext.request.contextPath}/voc/voiceMailBox/modifyCallContactOccuringError.do</c:when> --%>

	<%--VOC IVR --%>
<%-- 	<c:when test="${nameValue == 'callScreenPopup'}">${pageContext.request.contextPath}/voc/ivr/callContact/callScreenPopup.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getAlliTypeList'}">${pageContext.request.contextPath}/voc/ivr/callContact/getAlliTypeList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'callTransferHst'}">${pageContext.request.contextPath}/voc/ivr/callContact/callTransferHst.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'outboundCallHst'}">${pageContext.request.contextPath}/voc/ivr/callContact/outboundCallHst.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'callEnd'}">${pageContext.request.contextPath}/voc/ivr/callContact/callEnd.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getCallTransferList'}">${pageContext.request.contextPath}/voc/ivr/callContact/getCallTransferList.do</c:when> --%>

	<%-- VOC MAIN --%>
	<c:when test="${nameValue == 'getExtension'}">${pageContext.request.contextPath}/voc/getExtension.do</c:when>


	<%--포인트 기준 관리 --%>
	<c:when test="${nameValue == 'getStandardPointList'}">${pageContext.request.contextPath}/loyalty/standardPoint/getStandardPointList.do</c:when>
	<c:when test="${nameValue == 'insertPointAdm'}">${pageContext.request.contextPath}/loyalty/standardPoint/insertPointAdm.do</c:when>
	<c:when test="${nameValue == 'getPointItemBaseList'}">${pageContext.request.contextPath}/loyalty/standardPoint/getPointItemBaseList.do</c:when>
	<c:when test="${nameValue == 'getStandardPointDetail'}">${pageContext.request.contextPath}/loyalty/standardPoint/getStandardPointDetail.do</c:when>
	<c:when test="${nameValue == 'insertPointItem'}">${pageContext.request.contextPath}/loyalty/standardPoint/insertPointItem.do</c:when>
	<c:when test="${nameValue == 'deletePointItem'}">${pageContext.request.contextPath}/loyalty/standardPoint/deletePointItem.do</c:when>
	<c:when test="${nameValue == 'pointSearchHelp'}">${pageContext.request.contextPath}/loyalty/standardPoint/pointSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getStandardPointDetail'}">${pageContext.request.contextPath}/loyalty/standardPoint/getStandardPointDetail.do</c:when>
	<c:when test="${nameValue == 'getPntSaveDtl'}">${pageContext.request.contextPath}/loyalty/standardPoint/getPntSaveDtl.do</c:when>
	<c:when test="${nameValue == 'updatePointItem'}">${pageContext.request.contextPath}/loyalty/standardPoint/updatePointItem.do</c:when>
	<c:when test="${nameValue == 'updatePointStatusCd'}">${pageContext.request.contextPath}/loyalty/standardPoint/updatePointStatusCd.do</c:when>
	<c:when test="${nameValue == 'getPntAdustInfo'}">${pageContext.request.contextPath}/loyalty/standardPoint/getPntAdustInfo.do</c:when>
	<c:when test="${nameValue == 'updatePointAdjustItem'}">${pageContext.request.contextPath}/loyalty/standardPoint/updatePointAdjustItem.do</c:when>
	<c:when test="${nameValue == 'getPntUseInfo'}">${pageContext.request.contextPath}/loyalty/standardPoint/getPntUseInfo.do</c:when>
	<c:when test="${nameValue == 'updatePointUseItem'}">${pageContext.request.contextPath}/loyalty/standardPoint/updatePointUseItem.do</c:when>
	<c:when test="${nameValue == 'updatePointAdm'}">${pageContext.request.contextPath}/loyalty/standardPoint/updatePointAdm.do</c:when>
	<%-- 마스킹  --%>
	<c:when test="${nameValue == 'getMasking'}">${pageContext.request.contextPath}/common/getMasking.do</c:when>
	<%--상품  --%>
	<c:when test="${nameValue == 'getProdSearchHelp'}">${pageContext.request.contextPath}/loyalty/product/getProdSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getProductList'}">${pageContext.request.contextPath}/loyalty/product/getProductList.do</c:when>
	<c:when test="${nameValue == 'insertProductDetail'}">${pageContext.request.contextPath}/loyalty/product/insertProductDetail.do</c:when>
	<c:when test="${nameValue == 'getProductDetail'}">${pageContext.request.contextPath}/loyalty/product/getProductDetail.do</c:when>
	<c:when test="${nameValue == 'getProductPriceList'}">${pageContext.request.contextPath}/loyalty/product/getProductPriceList.do</c:when>
	<c:when test="${nameValue == 'insertProductPrice'}">${pageContext.request.contextPath}/loyalty/product/insertProductPrice.do</c:when>
	<c:when test="${nameValue == 'deleteProductPrice'}">${pageContext.request.contextPath}/loyalty/product/deleteProductPrice.do</c:when>
	<c:when test="${nameValue == 'getProductCodeList'}">${pageContext.request.contextPath}/loyalty/product/getProductCodeList.do</c:when>
	<c:when test="${nameValue == 'insertProductCodeDetail'}">${pageContext.request.contextPath}/loyalty/product/insertProductCodeDetail.do</c:when>
	<c:when test="${nameValue == 'deleteProductCode'}">${pageContext.request.contextPath}/loyalty/product/deleteProductCode.do</c:when>
	<c:when test="${nameValue == 'updateProductDetail'}">${pageContext.request.contextPath}/loyalty/product/updateProductDetail.do</c:when>
	<c:when test="${nameValue == 'updateProdStatusCd'}">${pageContext.request.contextPath}/loyalty/product/updateProdStatusCd.do</c:when>
	<c:when test="${nameValue == 'getProductPriceDtl'}">${pageContext.request.contextPath}/loyalty/product/getProductPriceDtl.do</c:when>
	<c:when test="${nameValue == 'updateProductPrice'}">${pageContext.request.contextPath}/loyalty/product/updateProductPrice.do</c:when>
	<c:when test="${nameValue == 'getProductCodeDetail'}">${pageContext.request.contextPath}/loyalty/product/getProductCodeDetail.do</c:when>
	<%--일괄등록 --%>
	<c:when test="${nameValue == 'getBatchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/getBatchRgstList.do</c:when>
	<c:when test="${nameValue == 'getUpldItemList'}">${pageContext.request.contextPath}/system/batchRgst/getUpldItemList.do</c:when>
	<c:when test="${nameValue == 'uploadExcel'}">${pageContext.request.contextPath}/system/batchRgst/uploadExcel.do</c:when>
	<c:when test="${nameValue == 'excelUploadAjax'}">${pageContext.request.contextPath}/system/batchRgst/excelUploadAjax.do</c:when>
	<c:when test="${nameValue == 'excelSampleDown'}">${pageContext.request.contextPath}/system/batchRgst/excelSampleDown.do</c:when>
	<c:when test="${nameValue == 'getBatchRgstDetail'}">${pageContext.request.contextPath}/system/batchRgst/getBatchRgstDetail.do</c:when>
	<c:when test="${nameValue == 'updateVanPntStatus'}">${pageContext.request.contextPath}/system/batchRgst/updateVanPntStatus.do</c:when>
	<c:when test="${nameValue == 'callLookUpValue'}">${pageContext.request.contextPath}/system/batchRgst/callLookUpValue.do</c:when>
	<c:when test="${nameValue == 'batchRgstVanApproval'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstVanApproval.do</c:when>
	<c:when test="${nameValue == 'updateBatchRgstDetail'}">${pageContext.request.contextPath}/system/batchRgst/updateBatchRgstDetail.do</c:when>
	<c:when test="${nameValue == 'gridExcelDown'}">${pageContext.request.contextPath}/system/batchRgst/gridExcelDown.do</c:when>
	<c:when test="${nameValue == 'batchRgstReVanApproval'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstReVanApproval.do</c:when>
	<c:when test="${nameValue == 'batchRgstVanCancel'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstVanCancel.do</c:when>
	<c:when test="${nameValue == 'cancelBatchIns'}">${pageContext.request.contextPath}/system/batchRgst/cancelBatchIns.do</c:when>
	<c:when test="${nameValue == 'cancelBatchRequest'}">${pageContext.request.contextPath}/system/batchRgst/cancelBatchRequest.do</c:when>
	<c:when test="${nameValue == 'setBatchLog'}">${pageContext.request.contextPath}/system/batchRgst/setBatchLog.do</c:when>
	<c:when test="${nameValue == 'getAprLogDetail'}">${pageContext.request.contextPath}/system/batchRgst/getAprLogDetail.do</c:when>
	<c:when test="${nameValue == 'setApprFailList'}">${pageContext.request.contextPath}/system/batchRgst/setApprFailList.do</c:when>
	<c:when test="${nameValue == 'uploadSmsUnSubExcel'}">${pageContext.request.contextPath}/system/batchRgst/uploadSmsUnSubExcel.do</c:when>
	<c:when test="${nameValue == 'getTxnCodeList'}">${pageContext.request.contextPath}/system/batchRgst/getTxnCodeList.do</c:when>
	<c:when test="${nameValue == 'clearMaskPntItemMbr'}">${pageContext.request.contextPath}/system/batchRgst/clearMaskPntItemMbr.do</c:when>
	<c:when test="${nameValue == 'blackRuleTest'}">${pageContext.request.contextPath}/system/batchRgst/blackRuleTest.do</c:when>


	<c:when test="${nameValue == 'cancelUnRgstUploadRequest'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/cancelUnRgstUploadRequest.do</c:when>

	<%--일괄등록 --%>
	<c:when test="${nameValue == 'uploadExcelPnt'}">${pageContext.request.contextPath}/system/batchRgst/uploadExcelPnt.do</c:when>
	<c:when test="${nameValue == 'getPntBatchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/getPntBatchRgstList.do</c:when>
	<c:when test="${nameValue == 'getPntUpldItemList'}">${pageContext.request.contextPath}/system/batchRgst/getPntUpldItemList.do</c:when>
	<c:when test="${nameValue == 'confirmPntBatchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/confirmPntBatchRgstList.do</c:when>
	<c:when test="${nameValue == 'deletePntBatchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/deletePntBatchRgstList.do</c:when>
	<c:when test="${nameValue == 'getUnSubExcelUploadList'}">${pageContext.request.contextPath}/system/batchRgst/getUnSubExcelUploadList.do</c:when>
	<c:when test="${nameValue == 'smsUpldItemList'}">${pageContext.request.contextPath}/system/batchRgst/smsUpldItemList.do</c:when>
	<c:when test="${nameValue == 'excelUploadSmsUnSub'}">${pageContext.request.contextPath}/system/batchRgst/excelUploadSmsUnSub.do</c:when>
	<c:when test="${nameValue == 'callUnSubscribeSms'}">${pageContext.request.contextPath}/system/batchRgst/callUnSubscribeSms.do</c:when>
	<c:when test="${nameValue == 'useConfirmPntBatchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/useConfirmPntBatchRgstList.do</c:when>

	<%-- 승인 --%>
	<c:when test="${nameValue == 'requestApproval'}">${pageContext.request.contextPath}/onlineApproval/requestApproval.do</c:when>
	<c:when test="${nameValue == 'campaignRequestApproval'}">${pageContext.request.contextPath}/onlineApproval/campaignRequestApproval.do</c:when>
	<c:when test="${nameValue == 'getApprovalAdminList'}">${pageContext.request.contextPath}/onlineApproval/getApprovalAdminList.do</c:when>
	<c:when test="${nameValue == 'getApprovalAdminDetail'}">${pageContext.request.contextPath}/onlineApproval/getApprovalAdminDetail.do</c:when>
	<c:when test="${nameValue == 'saveApprovalAdminDetail'}">${pageContext.request.contextPath}/onlineApproval/saveApprovalAdminDetail.do</c:when>
	<c:when test="${nameValue == 'editApprovalAdminDetail'}">${pageContext.request.contextPath}/onlineApproval/editApprovalAdminDetail.do</c:when>
	<c:when test="${nameValue == 'deleteApprovalAdminDetail'}">${pageContext.request.contextPath}/onlineApproval/deleteApprovalAdminDetail.do</c:when>
	<c:when test="${nameValue == 'setRequiredItemApproval'}">${pageContext.request.contextPath}/onlineApproval/setRequiredItemApproval.do</c:when>

	<%--정산 --%>
	<%-- <c:when test="${nameValue == 'getInsureContList'}">${pageContext.request.contextPath}/loyalty/settle/getInsureContList.do</c:when>
	<c:when test="${nameValue == 'getSettleSolPayHistoryList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayHistoryList.do</c:when>
	<c:when test="${nameValue == 'getSettleSolPayHistoryAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayHistoryAList.do</c:when>
	<c:when test="${nameValue == 'getSettleSolPayPromExList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayPromExList.do</c:when>
	<c:when test="${nameValue == 'getSettleSolPayPromAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayPromAList.do</c:when>
	<c:when test="${nameValue == 'getSettleMbrExctPointExList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMbrExctPointExList.do</c:when>
	<c:when test="${nameValue == 'getSettleMbrExctPointAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMbrExctPointAList.do</c:when>
	<c:when test="${nameValue == 'getSettleMbrExctPointDetailAList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMbrExctPointDetailAList.do</c:when>
	<c:when test="${nameValue == 'getSettleMbrExctPointDetailExeDown'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMbrExctPointDetailExeDown.do</c:when> --%>

	<%--간편회원가입 리스트--%>
	<c:when test="${nameValue == 'getSimpleMemRegList'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/getSimpleMemRegList.do</c:when>
	<c:when test="${nameValue == 'getSimpleMemRegDetail'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/getSimpleMemRegDetail.do</c:when>
	<c:when test="${nameValue == 'updateSimpleMemRegInfo'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/updateSimpleMemRegInfo.do</c:when>
	<c:when test="${nameValue == 'checkMemRegIsYN'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/checkMemRegIsYN.do</c:when>
	<c:when test="${nameValue == 'memRegCheckCertiCode'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/memRegCheckCertiCode.do</c:when>
	<c:when test="${nameValue == 'memRegcheckMypinNum'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/memRegcheckMypinNum.do</c:when>
	<c:when test="${nameValue == 'simpleMemTransList'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/simpleMemTransList.do</c:when>

	<%--우편번호--%>
	<c:when test="${nameValue == 'getZipCodeList'}">${pageContext.request.contextPath}/common/view/getZipCodeList.do</c:when>

	<%-- 모니터링 데모 --%>

	<%-- Job 목록 조회 --%>
	<c:when test="${nameValue == 'getJobList'}">${pageContext.request.contextPath}/system/job/getJobList.do</c:when>
	<%-- Job 신규 저장 --%>
	<c:when test="${nameValue == 'addJob'}">${pageContext.request.contextPath}/system/job/addJob.do</c:when>
	<%-- Job 상세 조회 --%>
	<c:when test="${nameValue == 'getJobDetail'}">${pageContext.request.contextPath}/system/job/getJobDetail.do</c:when>
	<%-- Job 수정 --%>
	<c:when test="${nameValue == 'editJob'}">${pageContext.request.contextPath}/system/job/editJob.do</c:when>
	<%-- Job 목록 삭제 --%>
	<c:when test="${nameValue == 'removeJobList'}">${pageContext.request.contextPath}/system/job/removeJobList.do</c:when>
	<%-- Job 수동 실행 --%>
	<c:when test="${nameValue == 'executeJob'}">${pageContext.request.contextPath}/system/job/executeJob.do</c:when>
	<%-- 실행인수 목록 조회 --%>
	<c:when test="${nameValue == 'getExecParamList'}">${pageContext.request.contextPath}/system/job/getExecParamList.do</c:when>
	<%-- 실행인수 신규 저장 --%>
	<c:when test="${nameValue == 'addExecParam'}">${pageContext.request.contextPath}/system/job/addExecParam.do</c:when>
	<%-- 실행인수 상세 조회 --%>
	<c:when test="${nameValue == 'getExecParamDetail'}">${pageContext.request.contextPath}/system/job/getExecParamDetail.do</c:when>
	<%-- 실행인수 수정 --%>
	<c:when test="${nameValue == 'editExecParam'}">${pageContext.request.contextPath}/system/job/editExecParam.do</c:when>
	<%-- 실행인수 목록 삭제 --%>
	<c:when test="${nameValue == 'removeExecParamList'}">${pageContext.request.contextPath}/system/job/removeExecParamList.do</c:when>
	<%-- 실행이력 목록 조회 --%>
	<c:when test="${nameValue == 'getJobLogList'}">${pageContext.request.contextPath}/system/job/getLogList.do</c:when>
	<%-- 실행이력 엑셀 다운로드 --%>
	<c:when test="${nameValue == 'downloadLogExcel'}">${pageContext.request.contextPath}/system/job/downloadLogExcel.do</c:when>
	<%-- 로그 상세 목록 조회 --%>
	<c:when test="${nameValue == 'getLogDtlList'}">${pageContext.request.contextPath}/system/job/getLogDtlList.do</c:when>
	<%-- 로그 상세 엑셀 다운로드 --%>
	<c:when test="${nameValue == 'downloadLogDtlExcel'}">${pageContext.request.contextPath}/system/job/downloadLogDtlExcel.do</c:when>
	<%-- 트리거 신규 저장 --%>
	<c:when test="${nameValue == 'addTrgr'}">${pageContext.request.contextPath}/system/job/addTrgr.do</c:when>
	<%-- 트리거 목록 조회 --%>
	<c:when test="${nameValue == 'getTrgrList'}">${pageContext.request.contextPath}/system/job/getTrgrList.do</c:when>
	<%-- 트리거 상세 조회 --%>
	<c:when test="${nameValue == 'getTrgrDetail'}">${pageContext.request.contextPath}/system/job/getTrgrDetail.do</c:when>
	<%-- 트리거 수정 --%>
	<c:when test="${nameValue == 'editTrgr'}">${pageContext.request.contextPath}/system/job/editTrgr.do</c:when>
	<%-- 트리거 목록 삭제 --%>
	<c:when test="${nameValue == 'removeTrgrList'}">${pageContext.request.contextPath}/system/job/removeTrgrList.do</c:when>
	<%-- 트리거 시작/정지 --%>
	<c:when test="${nameValue == 'startPauseTrgr'}">${pageContext.request.contextPath}/system/job/startPauseTrgr.do</c:when>
	<%-- 알람 신규 저장 --%>
	<c:when test="${nameValue == 'addAlrt'}">${pageContext.request.contextPath}/system/job/addAlrt.do</c:when>
	<%-- 알람 목록 조회 --%>
	<c:when test="${nameValue == 'getAlrtList'}">${pageContext.request.contextPath}/system/job/getAlrtList.do</c:when>
	<%-- 알람 상세 조회 --%>
	<c:when test="${nameValue == 'getAlrtDetail'}">${pageContext.request.contextPath}/system/job/getAlrtDetail.do</c:when>
	<%-- 알람 수정 --%>
	<c:when test="${nameValue == 'editAlrt'}">${pageContext.request.contextPath}/system/job/editAlrt.do</c:when>
	<%-- 알람 목록 삭제 --%>
	<c:when test="${nameValue == 'removeAlrtList'}">${pageContext.request.contextPath}/system/job/removeAlrtList.do</c:when>
	<%-- 후속 실행 Job 신규 저장 --%>
	<c:when test="${nameValue == 'addSbsqnt'}">${pageContext.request.contextPath}/system/job/addSbsqnt.do</c:when>
	<%-- 후속 실행 Job 목록 조회 --%>
	<c:when test="${nameValue == 'getSbsqntList'}">${pageContext.request.contextPath}/system/job/getSbsqntList.do</c:when>
	<%-- 후속 실행 Job 상세 조회 --%>
	<c:when test="${nameValue == 'getSbsqntDetail'}">${pageContext.request.contextPath}/system/job/getSbsqntDetail.do</c:when>
	<%-- 후속 실행 Job 수정 --%>
	<c:when test="${nameValue == 'editSbsqnt'}">${pageContext.request.contextPath}/system/job/editSbsqnt.do</c:when>
	<%-- 후속 실행 Job 목록 삭제 --%>
	<c:when test="${nameValue == 'removeSbsqntList'}">${pageContext.request.contextPath}/system/job/removeSbsqntList.do</c:when>
	<%-- 선택할 Job 목록 조회 --%>
	<c:when test="${nameValue == 'getChoiceJobList'}">${pageContext.request.contextPath}/system/job/getChoiceJobList.do</c:when>
	<%-- 타겟 Job 신규 저장 --%>
	<c:when test="${nameValue == 'addTargetJob'}">${pageContext.request.contextPath}/system/job/addTargetJob.do</c:when>
	<%-- 타겟 Job 목록 조회 --%>
	<c:when test="${nameValue == 'getTargetJobList'}">${pageContext.request.contextPath}/system/job/getTargetJobList.do</c:when>
	<%-- 타겟 Job 상세 조회 --%>
	<c:when test="${nameValue == 'getTargetJobDetail'}">${pageContext.request.contextPath}/system/job/getTargetJobDetail.do</c:when>
	<%-- 타겟 Job 수정 --%>
	<c:when test="${nameValue == 'editTargetJob'}">${pageContext.request.contextPath}/system/job/editTargetJob.do</c:when>
	<%-- 타겟 Job 목록 삭제 --%>
	<c:when test="${nameValue == 'removeTargetJobList'}">${pageContext.request.contextPath}/system/job/removeTargetJobList.do</c:when>
	<%-- Job step 목록 조회 --%>
	<c:when test="${nameValue == 'getJobStepList'}">${pageContext.request.contextPath}/system/job/getJobStepList.do</c:when>
	<%-- Job step Mapper 목록 조회 --%>
	<c:when test="${nameValue == 'getJobStepMapperList'}">${pageContext.request.contextPath}/system/job/getJobStepMapperList.do</c:when>
	<%-- Job  Log 목록 조회 --%>
	<c:when test="${nameValue == 'getJobLogHistory'}">${pageContext.request.contextPath}/system/job/getJobLogList.do</c:when>
	<c:when test="${nameValue == 'getJobStepDtl'}">${pageContext.request.contextPath}/system/job/getJobStepDtl.do</c:when>
	<c:when test="${nameValue == 'addJobStep'}">${pageContext.request.contextPath}/system/job/addJobStep.do</c:when>
	<c:when test="${nameValue == 'editJobStep'}">${pageContext.request.contextPath}/system/job/editJobStep.do</c:when>
	<c:when test="${nameValue == 'removeJobStep'}">${pageContext.request.contextPath}/system/job/removeJobStep.do</c:when>
	<c:when test="${nameValue == 'getJobStepMapperDtl'}">${pageContext.request.contextPath}/system/job/getJobStepMapperDtl.do</c:when>
	<c:when test="${nameValue == 'addJobStepMapper'}">${pageContext.request.contextPath}/system/job/addJobStepMapper.do</c:when>
	<c:when test="${nameValue == 'editJobStepMapper'}">${pageContext.request.contextPath}/system/job/editJobStepMapper.do</c:when>
	<c:when test="${nameValue == 'removeJobStepMapper'}">${pageContext.request.contextPath}/system/job/removeJobStepMapper.do</c:when>
	<c:when test="${nameValue == 'getBatchLogList'}">${pageContext.request.contextPath}/system/job/getBatchLogList.do</c:when>

	<%-- Job step Command 신규 --%>
	<c:when test="${nameValue == 'getJobStepCommandList'}">${pageContext.request.contextPath}/system/job/getJobStepCommandList.do</c:when>
	<c:when test="${nameValue == 'getJobStepCommandDtl'}">${pageContext.request.contextPath}/system/job/getJobStepCommandDtl.do</c:when>
	<c:when test="${nameValue == 'addJobStepCommand'}">${pageContext.request.contextPath}/system/job/addJobStepCommand.do</c:when>
	<c:when test="${nameValue == 'editJobStepCommand'}">${pageContext.request.contextPath}/system/job/editJobStepCommand.do</c:when>
	<c:when test="${nameValue == 'removeJobStepCommand'}">${pageContext.request.contextPath}/system/job/removeJobStepCommand.do</c:when>

	<%-- batchParameter --%>
	<c:when test="${nameValue == 'getBatchParameterList'}">${pageContext.request.contextPath}/system/job/getBatchParameterList.do</c:when>
	<c:when test="${nameValue == 'addBatchParameter'}">${pageContext.request.contextPath}/system/job/addBatchParameter.do</c:when>
	<c:when test="${nameValue == 'editBatchParameter'}">${pageContext.request.contextPath}/system/job/editBatchParameter.do</c:when>
	<c:when test="${nameValue == 'removeBatchParameter'}">${pageContext.request.contextPath}/system/job/removeBatchParameter.do</c:when>
	<c:when test="${nameValue == 'getBatchParameterDtl'}">${pageContext.request.contextPath}/system/job/getBatchParameterDtl.do</c:when>

	<%-- jobStepParameter  --%>
	<c:when test="${nameValue == 'getJobStepParamList'}">${pageContext.request.contextPath}/system/job/getJobStepParamList.do</c:when>
	<c:when test="${nameValue == 'addJobStepParam'}">${pageContext.request.contextPath}/system/job/addJobStepParam.do</c:when>
	<c:when test="${nameValue == 'editJobStepParam'}">${pageContext.request.contextPath}/system/job/editJobStepParam.do</c:when>
	<c:when test="${nameValue == 'removeJobStepParam'}">${pageContext.request.contextPath}/system/job/removeJobStepParam.do</c:when>
	<c:when test="${nameValue == 'getJobStepParamDtl'}">${pageContext.request.contextPath}/system/job/getJobStepParamDtl.do</c:when>
	<c:when test="${nameValue == 'getInfoExecuteParam'}">${pageContext.request.contextPath}/system/job/getInfoExecuteParam.do</c:when>
	<c:when test="${nameValue == 'getParamInfoDtl'}">${pageContext.request.contextPath}/system/job/getParamInfoDtl.do</c:when>
	<c:when test="${nameValue == 'saveParamInfo'}">${pageContext.request.contextPath}/system/job/saveParamInfo.do</c:when>
	<c:when test="${nameValue == 'editParamInfo'}">${pageContext.request.contextPath}/system/job/editParamInfo.do</c:when>
	<c:when test="${nameValue == 'deleteParamInfo'}">${pageContext.request.contextPath}/system/job/deleteParamInfo.do</c:when>
	<c:when test="${nameValue == 'getjobProcLogList'}">${pageContext.request.contextPath}/system/job/getjobProcLogList.do</c:when>


	<%--과거 캠페인 조회 --%>
	<c:when test="${nameValue == 'getPastCampaignList'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCampaignList.do</c:when>
	<c:when test="${nameValue == 'getPastCamChnlDtl'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCamChnlDtl.do</c:when>
	<c:when test="${nameValue == 'getPastCamPromoDtl'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCamPromoDtl.do</c:when>
	<c:when test="${nameValue == 'getPastCamDtl'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCamDtl.do</c:when>
	<c:when test="${nameValue == 'getPastCamTgtList'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCamTgtList.do</c:when>
	<c:when test="${nameValue == 'getPastCamMsgList'}">${pageContext.request.contextPath}/marketing/pastCampaign/getPastCamMsgList.do</c:when>
	<c:when test="${nameValue == 'getEmsilSendList'}">${pageContext.request.contextPath}/marketing/pastCampaign/getEmsilSendList.do</c:when>

	<%--로그관리 --%>
	<%-- <c:when test="${nameValue == 'getLogList'}">${pageContext.request.contextPath}/marketing/logManage/getLogList.do</c:when> --%>


	<%-- 맴버십정책 상품에서 상품 스펙 추가 --%>
	<c:when test="${nameValue == 'getProdSpecList'}">${pageContext.request.contextPath}/loyalty/membership/product/getProdSpecList.do</c:when>
	<c:when test="${nameValue == 'saveProdSpec'}">${pageContext.request.contextPath}/loyalty/membership/product/saveProdSpec.do</c:when>
	<c:when test="${nameValue == 'deleteProdSpec'}">${pageContext.request.contextPath}/loyalty/membership/product/deleteProdSpec.do</c:when>
	<c:when test="${nameValue == 'deleteProd'}">${pageContext.request.contextPath}/loyalty/membership/product/deleteProd.do</c:when>

	<%-- 구매 --%>
	<c:when test="${nameValue == 'getPurList'}">${pageContext.request.contextPath}/loyalty/pur/getPurList.do</c:when>

	<%--프로모션 상세조건 --%>
	<c:when test="${nameValue == 'getCondTierList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/getCondTierList.do</c:when>

	<%--프로모션 기획/실행 --%>
	<c:when test="${nameValue == 'getPromotionListNew'}">${pageContext.request.contextPath}/loyalty/campaign/getPromotionListNew.do</c:when>
	<c:when test="${nameValue == 'savePromotionDefaultInfo'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'getActionTierList'}">${pageContext.request.contextPath}/loyalty/campaign/getActionTierList.do</c:when>
	<c:when test="${nameValue == 'savePromotionAction'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAction.do</c:when>
	<c:when test="${nameValue == 'getPromActionInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromActionInfo.do</c:when>
	<c:when test="${nameValue == 'removeActionTier'}">${pageContext.request.contextPath}/loyalty/campaign/removeActionTier.do</c:when>
	<c:when test="${nameValue == 'getPromRuleInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromRuleInfo.do</c:when>
	<c:when test="${nameValue == 'savePromotionRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionRule.do</c:when>
	<c:when test="${nameValue == 'savePromotionSa1Rule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionSa1Rule.do</c:when>
	<c:when test="${nameValue == 'getChnlTgtGrpList'}">${pageContext.request.contextPath}/loyalty/campaign/getChnlTgtGrpList.do</c:when>
	<c:when test="${nameValue == 'getProdTgtGrpList'}">${pageContext.request.contextPath}/loyalty/campaign/getProdTgtGrpList.do</c:when>
	<c:when test="${nameValue == 'getPromSa1RuleInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromSa1RuleInfo.do</c:when>
	<c:when test="${nameValue == 'removeRuleSa1Xm'}">${pageContext.request.contextPath}/loyalty/campaign/removeRuleSa1Xm.do</c:when>
	<c:when test="${nameValue == 'removeSa1Rule'}">${pageContext.request.contextPath}/loyalty/campaign/removeSa1Rule.do</c:when>
	<c:when test="${nameValue == 'savePromotionSa1AniRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionSa1AniRule.do</c:when>
	<c:when test="${nameValue == 'getPromSa1AniDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromSa1AniDetail.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc2ConRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc2ConRule.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc2AgrRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc2AgrRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc2ConDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc2ConDetail.do</c:when>
	<c:when test="${nameValue == 'getPromAc2AgrDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc2AgrDetail.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc2SurRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc2SurRule.do</c:when>
	<c:when test="${nameValue == 'savePromotionSa2SumRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionSa2SumRule.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc2OnRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc2OnRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc2OnRuleInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc2OnRuleInfo.do</c:when>
	<c:when test="${nameValue == 'getPromAc2AddRuleInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc2AddRuleInfo.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc2AddRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc2AddRule.do</c:when>
	<c:when test="${nameValue == 'getPromSa2SumRuleInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromSa2SumRuleInfo.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc1JoinRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc1JoinRule.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc1FrndRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc1FrndRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc1JoinDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc1JoinDetail.do</c:when>
	<c:when test="${nameValue == 'getPromAc1FrndDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc1FrndDetail.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc1FamRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc1FamRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc1FamDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc1FamDetail.do</c:when>
	<c:when test="${nameValue == 'getPromAc1CardDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc1CardDetail.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc1CardRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc1CardRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc1ClbDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc1ClbDetail.do</c:when>
	<c:when test="${nameValue == 'savePromotionAc1ClbRule'}">${pageContext.request.contextPath}/loyalty/campaign/savePromotionAc1ClbRule.do</c:when>
	<c:when test="${nameValue == 'getPromAc2SurDetail'}">${pageContext.request.contextPath}/loyalty/campaign/getPromAc2SurDetail.do</c:when>
	<c:when test="${nameValue == 'removeRuleAc2Add'}">${pageContext.request.contextPath}/loyalty/campaign/removeRuleAc2Add.do</c:when>
	<c:when test="${nameValue == 'removeRuleSa2Sum'}">${pageContext.request.contextPath}/loyalty/campaign/removeRuleSa2Sum.do</c:when>
	<c:when test="${nameValue == 'removeRuleAc2On'}">${pageContext.request.contextPath}/loyalty/campaign/removeRuleAc2On.do</c:when>
	<c:when test="${nameValue == 'getPromotionListPop'}">${pageContext.request.contextPath}/loyalty/campaign/getPromotionListPop.do</c:when>
	<c:when test="${nameValue == 'saveLoyaltyContentsChnnelRel'}">${pageContext.request.contextPath}/loyalty/campaign/saveLoyaltyContentsChnnelRel.do</c:when>
	<c:when test="${nameValue == 'getBuyNotiYn'}">${pageContext.request.contextPath}/loyalty/campaign/getBuyNotiYn.do</c:when>
	<c:when test="${nameValue == 'getPromBuyNotiYn'}">${pageContext.request.contextPath}/loyalty/campaign/getPromBuyNotiYn.do</c:when>
	<c:when test="${nameValue == 'getPromInfo'}">${pageContext.request.contextPath}/loyalty/campaign/getPromInfo.do</c:when>


	<%--클럽조건 --%>
	<c:when test="${nameValue == 'getClubTypeList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTypeList.do</c:when>
	<c:when test="${nameValue == 'getLoadClubTypeList'}">${pageContext.request.contextPath}/loyalty/membership/club/getLoadClubTypeList.do</c:when>
	<c:when test="${nameValue == 'getTabChnlList'}">${pageContext.request.contextPath}/loyalty/membership/club/getTabChnlList.do</c:when>
	<c:when test="${nameValue == 'addClub'}">${pageContext.request.contextPath}/loyalty/membership/club/addClub.do</c:when>
	<c:when test="${nameValue == 'editClub'}">${pageContext.request.contextPath}/loyalty/membership/club/editClub.do</c:when>
	<c:when test="${nameValue == 'getClubTypeDetail'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTypeDetail.do</c:when>
	<c:when test="${nameValue == 'addLoyClubChnl'}">${pageContext.request.contextPath}/loyalty/membership/club/addLoyClubChnl.do</c:when>
	<c:when test="${nameValue == 'chkdup'}">${pageContext.request.contextPath}/loyalty/membership/club/chkdup.do</c:when>
	<c:when test="${nameValue == 'getChnlLimitPop'}">${pageContext.request.contextPath}/loyalty/membership/club/getChnlLimitPop.do</c:when>
	<c:when test="${nameValue == 'updateLimitPop'}">${pageContext.request.contextPath}/loyalty/membership/club/updateLimitPop.do</c:when>
	<c:when test="${nameValue == 'deleteLoyClubChnl'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteLoyClubChnl.do</c:when>
	<c:when test="${nameValue == 'getTabMemberList'}">${pageContext.request.contextPath}/loyalty/membership/club/getTabMemberList.do</c:when>
	<c:when test="${nameValue == 'deleteClub'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClub.do</c:when>
	<c:when test="${nameValue == 'addLoyClubMbr'}">${pageContext.request.contextPath}/loyalty/membership/club/addLoyClubMbr.do</c:when>
	<c:when test="${nameValue == 'editLoyClubMbr'}">${pageContext.request.contextPath}/loyalty/membership/club/editLoyClubMbr.do</c:when>
	<c:when test="${nameValue == 'trmntLoyClubMbr'}">${pageContext.request.contextPath}/loyalty/membership/club/trmntLoyClubMbr.do</c:when>
	<c:when test="${nameValue == 'getClubCardKindList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubCardKindList.do</c:when>
	<c:when test="${nameValue == 'getClubBenfList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfList.do</c:when>
	<c:when test="${nameValue == 'insertClubBenf'}">${pageContext.request.contextPath}/loyalty/membership/club/insertClubBenf.do</c:when>
	<c:when test="${nameValue == 'getClubBenfDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfDtl.do</c:when>
	<c:when test="${nameValue == 'updateClubBenf'}">${pageContext.request.contextPath}/loyalty/membership/club/updateClubBenf.do</c:when>
	<c:when test="${nameValue == 'deleteClubBenf'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubBenf.do</c:when>
	<c:when test="${nameValue == 'getClubBenfhListTd'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfhListTd.do</c:when>
	<c:when test="${nameValue == 'getClubBenfSearchList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfSearchList.do</c:when>
	<c:when test="${nameValue == 'getClubBenfTabList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfTabList.do</c:when>
	<c:when test="${nameValue == 'addClubBenfTab'}">${pageContext.request.contextPath}/loyalty/membership/club/addClubBenfTab.do</c:when>
	<c:when test="${nameValue == 'editClubBenfTab'}">${pageContext.request.contextPath}/loyalty/membership/club/editClubBenfTab.do</c:when>
	<c:when test="${nameValue == 'deleteClubBenfTab'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubBenfTab.do</c:when>
	<c:when test="${nameValue == 'getClubBenfTabDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubBenfTabDtl.do</c:when>

	<c:when test="${nameValue == 'getClubTierTabList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTierTabList.do</c:when>
	<c:when test="${nameValue == 'addClubTierTab'}">${pageContext.request.contextPath}/loyalty/membership/club/addClubTierTab.do</c:when>
	<c:when test="${nameValue == 'editClubTierTab'}">${pageContext.request.contextPath}/loyalty/membership/club/editClubTierTab.do</c:when>
	<c:when test="${nameValue == 'deleteClubTierTab'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubTierTab.do</c:when>
	<c:when test="${nameValue == 'getClubTierTabDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTierTabDtl.do</c:when>
	<c:when test="${nameValue == 'getClubJoinCondTabList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubJoinCondTabList.do</c:when>
	<c:when test="${nameValue == 'addClubJoinCondTab'}">${pageContext.request.contextPath}/loyalty/membership/club/addClubJoinCondTab.do</c:when>
	<c:when test="${nameValue == 'editClubJoinCondTab'}">${pageContext.request.contextPath}/loyalty/membership/club/editClubJoinCondTab.do</c:when>
	<c:when test="${nameValue == 'deleteClubJoinCondTab'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubJoinCondTab.do</c:when>
	<c:when test="${nameValue == 'getClubJoinCondTabDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubJoinCondTabDtl.do</c:when>
	<c:when test="${nameValue == 'getClubProdSearchHelp'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubProdSearchHelp.do</c:when>
	<c:when test="${nameValue == 'getClubTierDtlTabList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTierDtlTabList.do</c:when>
	<c:when test="${nameValue == 'addClubTierDtlTab'}">${pageContext.request.contextPath}/loyalty/membership/club/addClubTierDtlTab.do</c:when>
	<c:when test="${nameValue == 'editClubTierDtlTab'}">${pageContext.request.contextPath}/loyalty/membership/club/editClubTierDtlTab.do</c:when>
	<c:when test="${nameValue == 'deleteClubTierDtlTab'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubTierDtlTab.do</c:when>
	<c:when test="${nameValue == 'getClubTierDtlTabDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubTierDtlTabDtl.do</c:when>

	<c:when test="${nameValue == 'getClubPartenariatTabList'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubPartenariatTabList.do</c:when>
	<c:when test="${nameValue == 'addClubPartenariatTab'}">${pageContext.request.contextPath}/loyalty/membership/club/addClubPartenariatTab.do</c:when>
	<c:when test="${nameValue == 'editClubPartenariatTab'}">${pageContext.request.contextPath}/loyalty/membership/club/editClubPartenariatTab.do</c:when>
	<c:when test="${nameValue == 'deleteClubPartenariatTab'}">${pageContext.request.contextPath}/loyalty/membership/club/deleteClubPartenariatTab.do</c:when>
	<c:when test="${nameValue == 'getClubPartenariatTabDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/getClubPartenariatTabDtl.do</c:when>

	<%-- 이벤트트리거 scoring --%>
	<c:when test="${nameValue == 'getScoringList'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringList.do</c:when>
	<c:when test="${nameValue == 'getScoringDefaultInfo'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'saveScoringDefaultInfo'}">${pageContext.request.contextPath}/loyalty/scoring/saveScoringDefaultInfo.do</c:when>
	<c:when test="${nameValue == 'checkScoringStatusSaveFlag'}">${pageContext.request.contextPath}/loyalty/scoring/checkScoringStatusSaveFlag.do</c:when>
	<c:when test="${nameValue == 'saveScoringWorkflow'}">${pageContext.request.contextPath}/loyalty/scoring/saveScoringWorkflow.do</c:when>
	<c:when test="${nameValue == 'getScoringWorkflowStatusList'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringWorkflowStatusList.do</c:when>
	<c:when test="${nameValue == 'removeScoring'}">${pageContext.request.contextPath}/loyalty/scoring/removeScoring.do</c:when>
	<c:when test="${nameValue == 'saveETScoringCond'}">${pageContext.request.contextPath}/loyalty/scoring/saveETScoringCond.do</c:when>
	<c:when test="${nameValue == 'getETScoringAct'}">${pageContext.request.contextPath}/loyalty/scoring/getETScoringAct.do</c:when>
	<c:when test="${nameValue == 'saveETScoringAct'}">${pageContext.request.contextPath}/loyalty/scoring/saveETScoringAct.do</c:when>
	<c:when test="${nameValue == 'getETScoringCond'}">${pageContext.request.contextPath}/loyalty/scoring/getETScoringCond.do</c:when>
	<c:when test="${nameValue == 'scoringStatusCheck'}">${pageContext.request.contextPath}/loyalty/scoring/scoringStatusCheck.do</c:when>
	<c:when test="${nameValue == 'editScoringStatus'}">${pageContext.request.contextPath}/loyalty/scoring/editScoringStatus.do</c:when>
	<c:when test="${nameValue == 'getScoringAttributeGroupColumnValueList'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringAttributeGroupColumnValueList.do</c:when>

	<%-- 이벤트트리거 scoring 전자결재 --%>
	<c:when test="${nameValue == 'getScoringApproval'}">${pageContext.request.contextPath}/loyalty/scoring/approval/getScoringApproval.do</c:when>
	<c:when test="${nameValue == 'scoringRequestApproval'}">${pageContext.request.contextPath}/loyalty/scoring/approval/scoringRequestApproval.do</c:when>
	<c:when test="${nameValue == 'getScoringDetailAprv'}">${pageContext.request.contextPath}/loyalty/scoring/approval/getScoringDetailAprv.do</c:when>

	<%-- 이벤트트리거 scoring 지수조회 --%>
	<c:when test="${nameValue == 'getScoringResultList'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringResultList.do</c:when>
	<c:when test="${nameValue == 'getScoringResultDetailList'}">${pageContext.request.contextPath}/loyalty/scoring/getScoringResultDetailList.do</c:when>

	<%-- NoticeBoard Management --%>
	<c:when test="${nameValue == 'getNoticeList'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/getNoticeList.do</c:when>
	<c:when test="${nameValue == 'insertNotice'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/insertNotice.do</c:when>
	<c:when test="${nameValue == 'getNoticeDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/getNoticeDetail.do</c:when>
	<c:when test="${nameValue == 'increaseNoticeCount'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/increaseNoticeCount.do</c:when>
	<c:when test="${nameValue == 'insertNoticeMaster'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/insertNoticeMaster.do</c:when>
	<c:when test="${nameValue == 'getNoticeMasterDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/getNoticeMasterDetail.do</c:when>
	<c:when test="${nameValue == 'removeNotice'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/removeNotice.do</c:when>

	<%-- Partner Management --%>
	<c:when test="${nameValue == 'getPartnerList'}">${pageContext.request.contextPath}/system/partner/getPartnerList.do</c:when>
	<c:when test="${nameValue == 'insertPartnerMaster'}">${pageContext.request.contextPath}/system/partner/insertPartnerMaster.do</c:when>
	<c:when test="${nameValue == 'getPartnerMasterDetail'}">${pageContext.request.contextPath}/system/partner/getPartnerMasterDetail.do</c:when>
	<c:when test="${nameValue == 'insertPartner'}">${pageContext.request.contextPath}/system/partner/insertPartner.do</c:when>
	<c:when test="${nameValue == 'getPartnerDetail'}">${pageContext.request.contextPath}/system/partner/getPartnerDetail.do</c:when>

	<%-- FAQ Management --%>
	<c:when test="${nameValue == 'getFAQList'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/getFAQList.do</c:when>
	<c:when test="${nameValue == 'increaseFaqCount'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/increaseFaqCount.do</c:when>
	<c:when test="${nameValue == 'insertFaq'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/insertFaq.do</c:when>
	<c:when test="${nameValue == 'getFaqDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/getFaqDetail.do</c:when>
	<c:when test="${nameValue == 'insertMasterFaq'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/insertMasterFaq.do</c:when>
	<c:when test="${nameValue == 'getFaqMasterDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/getFaqMasterDetail.do</c:when>
	<c:when test="${nameValue == 'removeFaq'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/removeFaq.do</c:when>
	<c:when test="${nameValue == 'faqExcelDownload' }">${pageContext.request.contextPath}/loyalty/custChnl/faq/faqExcelDownload.do</c:when>
	<c:when test="${nameValue == 'uploadExcelFaq' }">${pageContext.request.contextPath}/loyalty/custChnl/faq/uploadExcelFaq.do</c:when>
	<c:when test="${nameValue == 'faqExcelDownList'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/faqExcelDownList.do</c:when>
	<c:when test="${nameValue == 'updateUploadExcelFaq'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/popup/updateUploadExcelFaq.do</c:when>

	<%-- QNA Management --%>
	<c:when test="${nameValue == 'getQnaList'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/getQnaList.do</c:when>
	<c:when test="${nameValue == 'getQnaDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/getQnaDetail.do</c:when>
	<c:when test="${nameValue == 'updateQna'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/updateQna.do</c:when>
	<c:when test="${nameValue == 'updateQnaStatus'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/updateQnaStatus.do</c:when>
	<c:when test="${nameValue == 'qnaClearMaskMbr'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/qnaClearMaskMbr.do</c:when>

	<%-- AppVer Management --%>
	<c:when test="${nameValue == 'getAppVerList'}">${pageContext.request.contextPath}/system/appversion/getAppVerList.do</c:when>
	<c:when test="${nameValue == 'insertAppVer'}">${pageContext.request.contextPath}/system/appversion/insertAppVer.do</c:when>
	<c:when test="${nameValue == 'getAppDetail'}">${pageContext.request.contextPath}/system/appversion/getAppDetail.do</c:when>

	<%-- Event Management --%>
	<c:when test="${nameValue == 'getEventList'}">${pageContext.request.contextPath}/system/event/getEventList.do</c:when>
	<c:when test="${nameValue == 'insertEventInfo'}">${pageContext.request.contextPath}/system/event/insertEventInfo.do</c:when>
	<c:when test="${nameValue == 'getEventInfoDetail'}">${pageContext.request.contextPath}/system/event/getEventInfoDetail.do</c:when>
	<c:when test="${nameValue == 'getEventParti'}">${pageContext.request.contextPath}/system/event/getEventParti.do</c:when>
	<c:when test="${nameValue == 'updateWinnerFlag'}">${pageContext.request.contextPath}/system/event/updateWinnerFlag.do</c:when>
	<c:when test="${nameValue == 'updateAnnounce'}">${pageContext.request.contextPath}/system/event/updateAnnounce.do</c:when>
	<c:when test="${nameValue == 'getEventSubInfoDetail'}">${pageContext.request.contextPath}/system/event/getEventSubInfoDetail.do</c:when>
	<c:when test="${nameValue == 'insertEventSubInfo'}">${pageContext.request.contextPath}/system/event/insertEventSubInfo.do</c:when>
	<c:when test="${nameValue == 'getAnnounceDetail'}">${pageContext.request.contextPath}/system/event/getAnnounceDetail.do</c:when>

	<%-- App Popup --%>
	<c:when test="${nameValue == 'getAppPopList'}">${pageContext.request.contextPath}/system/apppopup/getAppPopList.do</c:when>
	<c:when test="${nameValue == 'getNoticeSelectList'}">${pageContext.request.contextPath}/system/apppopup/getNoticeSelectList.do</c:when>
	<c:when test="${nameValue == 'insertAppPopMaster'}">${pageContext.request.contextPath}/system/apppopup/insertAppPopMaster.do</c:when>
	<c:when test="${nameValue == 'getAppPopMaster'}">${pageContext.request.contextPath}/system/apppopup/getAppPopMaster.do</c:when>
	<c:when test="${nameValue == 'insertAppPopSub'}">${pageContext.request.contextPath}/system/apppopup/insertAppPopSub.do</c:when>
	<c:when test="${nameValue == 'getAppPopSubDetail'}">${pageContext.request.contextPath}/system/apppopup/getAppPopSubDetail.do</c:when>

	<%-- Push Message --%>
	<c:when test="${nameValue == 'getPushMsgList'}">${pageContext.request.contextPath}/system/pushMsg/getPushMsgList.do</c:when>
	<c:when test="${nameValue == 'insertPushMsg'}">${pageContext.request.contextPath}/system/pushMsg/insertPushMsg.do</c:when>
	<c:when test="${nameValue == 'getPushMsgDetail'}">${pageContext.request.contextPath}/system/pushMsg/getPushMsgDetail.do</c:when>
	<c:when test="${nameValue == 'getPushMsgCancel'}">${pageContext.request.contextPath}/system/pushMsg/getPushMsgCancel.do</c:when>
	<c:when test="${nameValue == 'getPushMemberList'}">${pageContext.request.contextPath}/system/pushMsg/getPushMemberList.do</c:when>
	<c:when test="${nameValue == 'getTestPushResultList'}">${pageContext.request.contextPath}/system/pushMsg/getTestPushResultList.do</c:when>

	<%-- 매장만족도 --%>
<%-- 	<c:when test="${nameValue == 'getStoreSatisfactionList'}">${pageContext.request.contextPath}/loyalty/storeSatisfaction/getStoreSatisfactionList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getStoreSatisfactionListByMbr'}">${pageContext.request.contextPath}/loyalty/storeSatisfaction/getStoreSatisfactionListByMbr.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getStoreSatisfactionListByChnl'}">${pageContext.request.contextPath}/loyalty/storeSatisfaction/getStoreSatisfactionListByChnl.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getStoreSatisfactionDetail'}">${pageContext.request.contextPath}/loyalty/storeSatisfaction/getStoreSatisfactionDetail.do</c:when> --%>

	<%-- 약관관리   --%>
	<c:when test="${nameValue == 'getTermsList'}">${pageContext.request.contextPath}/loyalty/terms/getTermsList.do</c:when>
	<c:when test="${nameValue == 'getTermsInfoDetail'}">${pageContext.request.contextPath}/loyalty/terms/getTermsInfoDetail.do</c:when>
	<c:when test="${nameValue == 'saveTermsList'}">${pageContext.request.contextPath}/loyalty/terms/saveTermsList.do</c:when>
	<c:when test="${nameValue == 'getTermsDetail'}">${pageContext.request.contextPath}/loyalty/terms/getTermsDetail.do</c:when>
	<c:when test="${nameValue == 'modifyTermsList'}">${pageContext.request.contextPath}/loyalty/terms/modifyTermsList.do</c:when>
	<c:when test="${nameValue == 'getTermsVerList'}">${pageContext.request.contextPath}/loyalty/terms/getTermsVerList.do</c:when>
	<c:when test="${nameValue == 'getTermsRcvChnl'}">${pageContext.request.contextPath}/loyalty/terms/getTermsRcvChnl.do</c:when>
	<c:when test="${nameValue == 'saveTermsVersion'}">${pageContext.request.contextPath}/loyalty/terms/saveTermsVersion.do</c:when>
	<c:when test="${nameValue == 'removeTermsVersion'}">${pageContext.request.contextPath}/loyalty/terms/removeTermsVersion.do</c:when>
	<c:when test="${nameValue == 'getTermsVerDetail'}">${pageContext.request.contextPath}/loyalty/terms/getTermsVerDetail.do</c:when>
	<c:when test="${nameValue == 'modifyTermsVersion'}">${pageContext.request.contextPath}/loyalty/terms/modifyTermsVersion.do</c:when>
	<c:when test="${nameValue == 'removeTermsList'}">${pageContext.request.contextPath}/loyalty/terms/removeTermsList.do</c:when>
	<c:when test="${nameValue == 'getTermsContent'}">${pageContext.request.contextPath}/loyalty/terms/getTermsContent.do</c:when>
	<c:when test="${nameValue == 'saveTermsContent'}">${pageContext.request.contextPath}/loyalty/terms/saveTermsContent.do</c:when>
	<c:when test="${nameValue == 'saveTermsRcvChnl'}">${pageContext.request.contextPath}/loyalty/terms/saveTermsRcvChnl.do</c:when>
	<c:when test="${nameValue == 'modifyTermsRcvChnl'}">${pageContext.request.contextPath}/loyalty/terms/modifyTermsRcvChnl.do</c:when>
	<c:when test="${nameValue == 'getTermsLoyPgmList'}">${pageContext.request.contextPath}/loyalty/terms/getTermsLoyPgmList.do</c:when>
	<c:when test="${nameValue == 'getLoyPgmTList'}">${pageContext.request.contextPath}/loyalty/terms/getLoyPgmTList.do</c:when>
	<c:when test="${nameValue == 'getRcvChnlDetail'}">${pageContext.request.contextPath}/loyalty/terms/getRcvChnlDetail.do</c:when>
	<c:when test="${nameValue == 'getLoyPgmDetail'}">${pageContext.request.contextPath}/loyalty/terms/getLoyPgmDetail.do</c:when>
	<c:when test="${nameValue == 'saveTermsLoyPgm'}">${pageContext.request.contextPath}/loyalty/terms/saveTermsLoyPgm.do</c:when>
	<c:when test="${nameValue == 'modifyTermsLoyPgm'}">${pageContext.request.contextPath}/loyalty/terms/modifyTermsLoyPgm.do</c:when>
	<c:when test="${nameValue == 'removeLoyPgm'}">${pageContext.request.contextPath}/loyalty/terms/removeLoyPgm.do</c:when>
	<c:when test="${nameValue == 'removeRcvChnl'}">${pageContext.request.contextPath}/loyalty/terms/removeRcvChnl.do</c:when>
	<c:when test="${nameValue == 'validLoyaltyPgm'}">${pageContext.request.contextPath}/loyalty/terms/validLoyaltyPgm.do</c:when>
	<c:when test="${nameValue == 'validTermsStatCheck'}">${pageContext.request.contextPath}/loyalty/terms/validTermsStatCheck.do</c:when>
	<c:when test="${nameValue == 'removeTermsLoyPgm'}">${pageContext.request.contextPath}/loyalty/terms/removeTermsLoyPgm.do</c:when>
	<c:when test="${nameValue == 'removeTermsRcvChnl'}">${pageContext.request.contextPath}/loyalty/terms/removeTermsRcvChnl.do</c:when>
    
    <c:when test="${nameValue == 'getTermsGrp'}">${pageContext.request.contextPath}/loyalty/terms/getTermsGrp.do</c:when>
    <c:when test="${nameValue == 'insertTermsGrp'}">${pageContext.request.contextPath}/loyalty/terms/insertTermsGrp.do</c:when>
    <c:when test="${nameValue == 'getTermsGrpTermsPop'}">${pageContext.request.contextPath}/loyalty/terms/getTermsGrpTermsPop.do</c:when>
    <c:when test="${nameValue == 'getAlreadyTermsGrp'}">${pageContext.request.contextPath}/loyalty/terms/getAlreadyTermsGrp.do</c:when>
    <c:when test="${nameValue == 'updateTermsGrp'}">${pageContext.request.contextPath}/loyalty/terms/updateTermsGrp.do</c:when>
    <c:when test="${nameValue == 'deleteTermsGrp'}">${pageContext.request.contextPath}/loyalty/terms/deleteTermsGrp.do</c:when>
    <c:when test="${nameValue == 'getTermsGrpTermsList'}">${pageContext.request.contextPath}/loyalty/terms/getTermsGrpTermsList.do</c:when>
    <c:when test="${nameValue == 'insertTermsGrpTerms'}">${pageContext.request.contextPath}/loyalty/terms/insertTermsGrpTerms.do</c:when>
    <c:when test="${nameValue == 'getAlreadyTermsGrpTerms'}">${pageContext.request.contextPath}/loyalty/terms/getAlreadyTermsGrpTerms.do</c:when>
    <c:when test="${nameValue == 'updateTermsListGrp'}">${pageContext.request.contextPath}/loyalty/terms/updateTermsListGrp.do</c:when>
    <c:when test="${nameValue == 'deleteGrpTerms'}">${pageContext.request.contextPath}/loyalty/terms/deleteGrpTerms.do</c:when>

	<%-- 채널 가이드 셋팅  --%>
	<c:when test="${nameValue == 'getChnlGuide'}">${pageContext.request.contextPath}/marketing/content/getChnlGuide.do</c:when>

	<%-- 소멸예정자 조회   --%>
	<c:when test="${nameValue == 'getPointDropList'}">${pageContext.request.contextPath}/loyalty/pointdrop/getPointDropList.do</c:when>


	<%-- MainBanner Management --%>
	<c:when test="${nameValue == 'getBannerList'}">${pageContext.request.contextPath}/system/banner/getBannerList.do</c:when>
	<c:when test="${nameValue == 'insertBanner'}">${pageContext.request.contextPath}/system/banner/insertBanner.do</c:when>
	<c:when test="${nameValue == 'getBannerDetail'}">${pageContext.request.contextPath}/system/banner/getBannerDetail.do</c:when>
	<c:when test="${nameValue == 'increaseBannerCount'}">${pageContext.request.contextPath}/system/banner/increaseBannerCount.do</c:when>
	<c:when test="${nameValue == 'insertBannerMaster'}">${pageContext.request.contextPath}/system/banner/insertBannerMaster.do</c:when>
	<c:when test="${nameValue == 'getBannerMasterDetail'}">${pageContext.request.contextPath}/system/banner/getBannerMasterDetail.do</c:when>

	<c:when test="${nameValue == 'getDormancyList'}">${pageContext.request.contextPath}/loyalty/dormancy/getDormancyList.do</c:when>
	<c:when test="${nameValue == 'getDormancyPredUser'}">${pageContext.request.contextPath}/loyalty/dormancy/getDormancyPredUser.do</c:when>
	<c:when test="${nameValue == 'selectCustNm'}">${pageContext.request.contextPath}/loyalty/dormancy/selectCustNm.do</c:when>
	<c:when test="${nameValue == 'activeDorMbr'}">${pageContext.request.contextPath}/loyalty/dormancy/activeDorMbr.do</c:when>

	<%-- 영수증 사후 적립 : 다이소 신규 --%>
<%-- 	<c:when test="${nameValue == 'getRcptAftrRgstList'}">${pageContext.request.contextPath}/system/batchRgst/getRcptAftrRgstList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getRcptAftrRgstItemList'}">${pageContext.request.contextPath}/system/batchRgst/getRcptAftrRgstItemList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'callGetReceiptDetail'}">${pageContext.request.contextPath}/system/batchRgst/callGetReceiptDetail.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'callGetReceiptDetailVoc'}">${pageContext.request.contextPath}/system/batchRgst/callGetReceiptDetailVoc.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getCampaginInfoForRcptAftr'}">${pageContext.request.contextPath}/system/batchRgst/getCampaginInfoForRcptAftr.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'setRcptAftrPntAcrl'}">${pageContext.request.contextPath}/system/batchRgst/setRcptAftrPntAcrl.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'setRcptAftrPntAcrl'}">${pageContext.request.contextPath}/system/batchRgst/setRcptAftrPntAcrl.do</c:when> --%>

	<%-- HMAC_SHA256 암호화 : 다이소 신규 --%>
	<c:when test="${nameValue == 'getHmacSha256'}">${pageContext.request.contextPath}/loyalty/common/getHmacSha256.do</c:when>

	<%-- VOCInfo: 다이소 신규 --%>
	<c:when test="${nameValue == 'getVocInfoList'}">${pageContext.request.contextPath}/loyalty/voc/getVocInfoList.do</c:when>
	<c:when test="${nameValue == 'exeTest'}">${pageContext.request.contextPath}/loyalty/voc/exeTest.do</c:when>

	<%-- 관리자 이메일 인증 --%>
	<c:when test="${nameValue == 'emailAuthCheck'}">${pageContext.request.contextPath}/marketing/common/emailAuthCheck.do</c:when>



	<%-- 프로모션 캠페인 - 회원등급 조회 --%>
	<c:when test="${nameValue == 'getAllTierList'}">${pageContext.request.contextPath}/loyalty/ruleSet/getAllTierList.do</c:when>

	<%-- 프로모션 상품목록 --%>
	<c:when test="${nameValue == 'getPromProdListNew'}">${pageContext.request.contextPath}/loyalty/ruleSet/getPromProdListNew.do</c:when>
	<c:when test="${nameValue == 'getPromProductPopListNew'}">${pageContext.request.contextPath}/loyalty/ruleSet/getPromProductPopListNew.do</c:when>
	<c:when test="${nameValue == 'setPromProduct'}">${pageContext.request.contextPath}/loyalty/ruleSet/setPromProduct.do</c:when>
	<c:when test="${nameValue == 'getProductPromValid'}">${pageContext.request.contextPath}/loyalty/ruleSet/getProductPromValid.do</c:when>
	<c:when test="${nameValue == 'removeProductPromValid'}">${pageContext.request.contextPath}/loyalty/ruleSet/removeProductPromValid.do</c:when>
	<c:when test="${nameValue == 'removeProductPromAll'}">${pageContext.request.contextPath}/loyalty/ruleSet/removeProductPromAll.do</c:when>
	<c:when test="${nameValue == 'selectValidPromProd'}">${pageContext.request.contextPath}/loyalty/ruleSet/selectValidPromProd.do</c:when>

	<%-- 정산 - 신규 --%>
	<c:when test="${nameValue == 'getSettleSolPayChnlMonthHistoryList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayChnlMonthHistoryList.do</c:when>
	<c:when test="${nameValue == 'getSettleSolPayChnlMonthHistorySum'}">${pageContext.request.contextPath}/loyalty/settle/getSettleSolPayChnlMonthHistorySum.do</c:when>
	<c:when test="${nameValue == 'getSettleMonthAcculUseList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonthAcculUseList.do</c:when>
	<c:when test="${nameValue == 'getSettleMonthAcculUseListExcel'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonthAcculUseListExcel.do</c:when>
	<c:when test="${nameValue == 'getSettleCommCodeList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleCommCodeList.do</c:when>
	<c:when test="${nameValue == 'getSettleCommCodeHeader'}">${pageContext.request.contextPath}/loyalty/settle/getSettleCommCodeHeader.do</c:when>
	<c:when test="${nameValue == 'getSettleMonMinusPntList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonMinusPntList.do</c:when>
	<c:when test="${nameValue == 'getSettleMemMinusPntList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMemMinusPntList.do</c:when>
	<c:when test="${nameValue == 'getSettleDayPointExctList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleDayPointExctList.do</c:when>
	<c:when test="${nameValue == 'getSettleMonthPointExctList'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonthPointExctList.do</c:when>
	<c:when test="${nameValue == 'getSettleMonthPointExctListExcel'}">${pageContext.request.contextPath}/loyalty/settle/getSettleMonthPointExctListExcel.do</c:when>
	<c:when test="${nameValue == 'getSettlePointBalanceList'}">${pageContext.request.contextPath}/loyalty/settle/getSettlePointBalanceList.do</c:when>
	<c:when test="${nameValue == 'settlePointBalanceListExport'}">${pageContext.request.contextPath}/loyalty/settle/settlePointBalanceListExport.do</c:when>


	<%-- 부정적립 --%>
	<c:when test="${nameValue == 'getFraudEmpList'}">${pageContext.request.contextPath}/loyalty/fraud/getFraudEmpList.do</c:when>
	<c:when test="${nameValue == 'getFraudDayTxnTargetList'}">${pageContext.request.contextPath}/loyalty/fraud/getFraudDayTxnTargetList.do</c:when>
	<c:when test="${nameValue == 'getFraudChannelList'}">${pageContext.request.contextPath}/loyalty/fraud/getFraudChannelList.do</c:when>
	<c:when test="${nameValue == 'getFraudAcrlPntTopList'}">${pageContext.request.contextPath}/loyalty/fraud/getFraudAcrlPntTopList.do</c:when>
	<c:when test="${nameValue == 'getFraudAcrlCntTopList'}">${pageContext.request.contextPath}/loyalty/fraud/getFraudAcrlCntTopList.do</c:when>

	<%-- 멤버십 회원 구분 --%>
	<c:when test="${nameValue == 'getMbrDivList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrDivList.do</c:when>
	<c:when test="${nameValue == 'getMbrUpldItemList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrUpldItemList.do</c:when>
	<c:when test="${nameValue == 'uploadExcelMbr'}">${pageContext.request.contextPath}/system/batchRgst/uploadExcelMbr.do</c:when>

	
	<%-- 이벤트 기획/실행 --%>
	<c:when test="${nameValue == 'getEventPlanExcutionList'}">${pageContext.request.contextPath}/loyalty/event/getEventPlanExcutionList.do</c:when>
	<c:when test="${nameValue == 'getPromotionPopUpList'}">${pageContext.request.contextPath}/loyalty/event/getPromotionPopUpList.do</c:when>
	<c:when test="${nameValue == 'saveEventPlane'}">${pageContext.request.contextPath}/loyalty/event/saveEventPlane.do</c:when>
	<c:when test="${nameValue == 'eventPlanDetail'}">${pageContext.request.contextPath}/loyalty/event/eventPlanDetail.do</c:when>
	<c:when test="${nameValue == 'updateEventPlane'}">${pageContext.request.contextPath}/loyalty/event/updateEventPlane.do</c:when>
	<c:when test="${nameValue == 'deleteEventPlan'}">${pageContext.request.contextPath}/loyalty/event/deleteEventPlan.do</c:when>
	<c:when test="${nameValue == 'updateStopEventPlan'}">${pageContext.request.contextPath}/loyalty/event/updateStopEventPlan.do</c:when>
	<c:when test="${nameValue == 'updateStartEventPlan'}">${pageContext.request.contextPath}/loyalty/event/updateStartEventPlan.do</c:when>
	<c:when test="${nameValue == 'updateFinishEventPlan'}">${pageContext.request.contextPath}/loyalty/event/updateFinishEventPlan.do</c:when>
	<c:when test="${nameValue == 'getEventApplicantList'}">${pageContext.request.contextPath}/loyalty/event/getEventApplicantList.do</c:when>
	<c:when test="${nameValue == 'isThereWinnerInApplicant'}">${pageContext.request.contextPath}/loyalty/event/isThereWinnerInApplicant.do</c:when>
	<c:when test="${nameValue == 'evtApplicantDown'}">${pageContext.request.contextPath}/loyalty/event/evtApplicantDown.do</c:when>
	<c:when test="${nameValue == 'getProdEntryList'}">${pageContext.request.contextPath}/loyalty/event/getProdEntryList.do</c:when>
	<c:when test="${nameValue == 'insertTransferWinner'}">${pageContext.request.contextPath}/loyalty/event/insertTransferWinner.do</c:when>
	<c:when test="${nameValue == 'validWinnerTransfer'}">${pageContext.request.contextPath}/loyalty/event/validWinnerTransfer.do</c:when>
	<c:when test="${nameValue == 'cancelVote'}">${pageContext.request.contextPath}/loyalty/event/cancelVote.do</c:when>
	<c:when test="${nameValue == 'insertEvtWinner'}">${pageContext.request.contextPath}/loyalty/event/insertEvtWinner.do</c:when>
	<c:when test="${nameValue == 'insertEvtApplict'}">${pageContext.request.contextPath}/loyalty/event/insertEvtApplict.do</c:when>
	<c:when test="${nameValue == 'deleteEventWinner'}">${pageContext.request.contextPath}/loyalty/event/deleteEventWinner.do</c:when>
	<c:when test="${nameValue == 'benefitPayment'}">${pageContext.request.contextPath}/loyalty/event/benefitPayment.do</c:when>
	<c:when test="${nameValue == 'cancleBenefitPayment'}">${pageContext.request.contextPath}/loyalty/event/cancleBenefitPayment.do</c:when>
	<c:when test="${nameValue == 'eventWinnerReset'}">${pageContext.request.contextPath}/loyalty/event/eventWinnerReset.do</c:when>
	<c:when test="${nameValue == 'eventApplicantReset'}">${pageContext.request.contextPath}/loyalty/event/eventApplicantReset.do</c:when>
	<c:when test="${nameValue == 'setEventWinnerMultiUpload'}">${pageContext.request.contextPath}/loyalty/event/setEventWinnerMultiUpload.do</c:when>
	<c:when test="${nameValue == 'setEventApplicantMultiUpload'}">${pageContext.request.contextPath}/loyalty/event/setEventApplicantMultiUpload.do</c:when>
	<c:when test="${nameValue == 'getSelectProdEntryList'}">${pageContext.request.contextPath}/loyalty/event/getSelectProdEntryList.do</c:when>
	<c:when test="${nameValue == 'updateSendSuccess'}">${pageContext.request.contextPath}/loyalty/event/updateSendSuccess.do</c:when>
	<c:when test="${nameValue == 'updateSendCancel'}">${pageContext.request.contextPath}/loyalty/event/updateSendCancel.do</c:when>
	<c:when test="${nameValue == 'setProdEntryMultiUpload'}">${pageContext.request.contextPath}/loyalty/event/setProdEntryMultiUpload.do</c:when>
	<c:when test="${nameValue == 'eventWinnerExcelDown'}">${pageContext.request.contextPath}/loyalty/event/eventWinnerExcelDown.do</c:when>
	<c:when test="${nameValue == 'evtAppliClearMask'}">${pageContext.request.contextPath}/loyalty/event/evtAppliClearMask.do</c:when>
	<c:when test="${nameValue == 'evtWinnerClearMask'}">${pageContext.request.contextPath}/loyalty/event/evtWinnerClearMask.do</c:when>
	<c:when test="${nameValue == 'evtProdEntryClearMask'}">${pageContext.request.contextPath}/loyalty/event/evtProdEntryClearMask.do</c:when>
	<c:when test="${nameValue == 'getEventPreviewToken'}">${pageContext.request.contextPath}/loyalty/event/getEventPreviewToken.do</c:when>
	<c:when test="${nameValue == 'removeEventPreviewToken'}">${pageContext.request.contextPath}/loyalty/event/removeEventPreviewToken.do</c:when>
	<c:when test="${nameValue == 'setEventWinCmplt'}">${pageContext.request.contextPath}/loyalty/event/setEventWinCmplt.do</c:when>
	<c:when test="${nameValue == 'getEventWinCompleteYn'}">${pageContext.request.contextPath}/loyalty/event/getEventWinCompleteYn.do</c:when>
	<c:when test="${nameValue == 'eventProdEntryExcelDown'}">${pageContext.request.contextPath}/loyalty/event/eventProdEntryExcelDown.do</c:when>
	<c:when test="${nameValue == 'getMbrStoreList'}">${pageContext.request.contextPath}/loyalty/event/getMbrStoreList.do</c:when>
	<c:when test="${nameValue == 'mbrStoreListExport'}">${pageContext.request.contextPath}/loyalty/event/mbrStoreListExport.do</c:when>
	<c:when test="${nameValue == 'clearMaskingStore'}">${pageContext.request.contextPath}/loyalty/event/clearMaskingStore.do</c:when>
	<c:when test="${nameValue == 'getAttendanceList'}">${pageContext.request.contextPath}/loyalty/event/getAttendanceList.do</c:when>
	<c:when test="${nameValue == 'imageViewDown'}">${pageContext.request.contextPath}/loyalty/event/imageViewDown.do</c:when>
	<c:when test="${nameValue == 'getEventStorePreviewToken'}">${pageContext.request.contextPath}/loyalty/event/getEventStorePreviewToken.do</c:when>
	<c:when test="${nameValue == 'getStoreListRdmPoint'}">${pageContext.request.contextPath}/loyalty/event/getStoreListRdmPoint.do</c:when>
	<c:when test="${nameValue == 'getStoreListAcrlPoint'}">${pageContext.request.contextPath}/loyalty/event/getStoreListAcrlPoint.do</c:when>
	<c:when test="${nameValue == 'getAddPromList'}">${pageContext.request.contextPath}/loyalty/event/getAddPromList.do</c:when>
	<c:when test="${nameValue == 'addPromSave'}">${pageContext.request.contextPath}/loyalty/event/addPromSave.do</c:when>
	<c:when test="${nameValue == 'deleteProm'}">${pageContext.request.contextPath}/loyalty/event/deleteProm.do</c:when>
	<c:when test="${nameValue == 'InsertLimitMbr'}">${pageContext.request.contextPath}/loyalty/event/InsertLimitMbr.do</c:when>
	<c:when test="${nameValue == 'validLimitMbr'}">${pageContext.request.contextPath}/loyalty/event/validLimitMbr.do</c:when>
	<c:when test="${nameValue == 'getLimitMbrList'}">${pageContext.request.contextPath}/loyalty/event/getLimitMbrList.do</c:when>
	<c:when test="${nameValue == 'LimitMbrClearMask'}">${pageContext.request.contextPath}/loyalty/event/LimitMbrClearMask.do</c:when>
	<c:when test="${nameValue == 'terminationCancel'}">${pageContext.request.contextPath}/loyalty/event/terminationCancel.do</c:when>
	<c:when test="${nameValue == 'getWinningCond'}">${pageContext.request.contextPath}/loyalty/event/getWinningCond.do</c:when>
	<c:when test="${nameValue == 'tempUploadS3Delete'}">${pageContext.request.contextPath}/loyalty/event/tempUploadS3Delete.do</c:when>
	<c:when test="${nameValue == 'updateEventEmg'}">${pageContext.request.contextPath}/loyalty/event/updateEventEmg.do</c:when>
	<c:when test="${nameValue == 'validLimitProm'}">${pageContext.request.contextPath}/loyalty/event/validLimitProm.do</c:when>
	<c:when test="${nameValue == 'getUGCList'}">${pageContext.request.contextPath}/loyalty/event/getUGCList.do</c:when>
	<c:when test="${nameValue == 'getUGCAch'}">${pageContext.request.contextPath}/loyalty/event/getUGCAch.do</c:when>
	<c:when test="${nameValue == 'ugcMbrClearMasking'}">${pageContext.request.contextPath}/loyalty/event/ugcMbrClearMasking.do</c:when>
	<c:when test="${nameValue == 'ugcListExport'}">${pageContext.request.contextPath}/loyalty/event/ugcListExport.do</c:when>
	<c:when test="${nameValue == 'selectAddProm'}">${pageContext.request.contextPath}/loyalty/event/selectAddProm.do</c:when>
	<c:when test="${nameValue == 'updatePromSave'}">${pageContext.request.contextPath}/loyalty/event/updatePromSave.do</c:when>
	<c:when test="${nameValue == 'getAddPromCondVal'}">${pageContext.request.contextPath}/loyalty/event/getAddPromCondVal.do</c:when>
	<c:when test="${nameValue == 'getApplicantCnt'}">${pageContext.request.contextPath}/loyalty/event/getApplicantCnt.do</c:when>
	<c:when test="${nameValue == 'getRdmWinner'}">${pageContext.request.contextPath}/loyalty/event/getRdmWinner.do</c:when>
	<c:when test="${nameValue == 'validCheckWinnerTrans'}">${pageContext.request.contextPath}/loyalty/event/validCheckWinnerTrans.do</c:when>
	<c:when test="${nameValue == 'InsertMbrMsg'}">${pageContext.request.contextPath}/loyalty/event/InsertMbrMsg.do</c:when>
	<c:when test="${nameValue == 'getTierLimitList'}">${pageContext.request.contextPath}/loyalty/event/getTierLimitList.do</c:when>
	<c:when test="${nameValue == 'saveTierLimit'}">${pageContext.request.contextPath}/loyalty/event/saveTierLimit.do</c:when>


	<%-- 설문 --%>
	<c:when test="${nameValue == 'getSurveyList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyList.do</c:when>
	<c:when test="${nameValue == 'getSurveyDetail'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyDetail.do</c:when>
	<c:when test="${nameValue == 'addSurveyDetail'}">${pageContext.request.contextPath}/loyalty/survey/addSurveyDetail.do</c:when>
	<c:when test="${nameValue == 'modifySurveyDetail'}">${pageContext.request.contextPath}/loyalty/survey/modifySurveyDetail.do</c:when>
	<c:when test="${nameValue == 'removeSurveyDetail'}">${pageContext.request.contextPath}/loyalty/survey/removeSurveyDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveySectionList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveySectionList.do</c:when>
	<c:when test="${nameValue == 'getSurveySectionDetail'}">${pageContext.request.contextPath}/loyalty/survey/getSurveySectionDetail.do</c:when>
	<c:when test="${nameValue == 'addSurveySectionDetail'}">${pageContext.request.contextPath}/loyalty/survey/addSurveySectionDetail.do</c:when>
	<c:when test="${nameValue == 'modifySurveySectionDetail'}">${pageContext.request.contextPath}/loyalty/survey/modifySurveySectionDetail.do</c:when>
	<c:when test="${nameValue == 'removeSurveySectionDetail'}">${pageContext.request.contextPath}/loyalty/survey/removeSurveySectionDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveyItemList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyItemList.do</c:when>
	<c:when test="${nameValue == 'getSurveyItemDetail'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyItemDetail.do</c:when>
	<c:when test="${nameValue == 'addSurveyItemDetail'}">${pageContext.request.contextPath}/loyalty/survey/addSurveyItemDetail.do</c:when>
	<c:when test="${nameValue == 'modifySurveyItemDetail'}">${pageContext.request.contextPath}/loyalty/survey/modifySurveyItemDetail.do</c:when>
	<c:when test="${nameValue == 'removeSurveyItemDetail'}">${pageContext.request.contextPath}/loyalty/survey/removeSurveyItemDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveyItemAttrList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyItemAttrList.do</c:when>
	<c:when test="${nameValue == 'getSurveyItemAttrDetail'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyItemAttrDetail.do</c:when>
	<c:when test="${nameValue == 'addSurveyItemAttrDetail'}">${pageContext.request.contextPath}/loyalty/survey/addSurveyItemAttrDetail.do</c:when>
	<c:when test="${nameValue == 'modifySurveyItemAttrDetail'}">${pageContext.request.contextPath}/loyalty/survey/modifySurveyItemAttrDetail.do</c:when>
	<c:when test="${nameValue == 'removeSurveyItemAttrDetail'}">${pageContext.request.contextPath}/loyalty/survey/removeSurveyItemAttrDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveyMemberList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyMemberList.do</c:when>
	<c:when test="${nameValue == 'clearSurveyMemberMaskingDetail'}">${pageContext.request.contextPath}/loyalty/survey/clearSurveyMemberMaskingDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveyOfferList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyOfferList.do</c:when>
	<c:when test="${nameValue == 'getSurveyOfferDetail'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyOfferDetail.do</c:when>
	<c:when test="${nameValue == 'addSurveyOfferDetail'}">${pageContext.request.contextPath}/loyalty/survey/addSurveyOfferDetail.do</c:when>
	<c:when test="${nameValue == 'modifySurveyOfferDetail'}">${pageContext.request.contextPath}/loyalty/survey/modifySurveyOfferDetail.do</c:when>
	<c:when test="${nameValue == 'removeSurveyOfferDetail'}">${pageContext.request.contextPath}/loyalty/survey/removeSurveyOfferDetail.do</c:when>
	<c:when test="${nameValue == 'getSurveyResultList'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyResultList.do</c:when>
	<c:when test="${nameValue == 'selectSurveyResultDtlList'}">${pageContext.request.contextPath}/loyalty/survey/selectSurveyResultDtlList.do</c:when>
	<c:when test="${nameValue == 'getTextItemList'}">${pageContext.request.contextPath}/loyalty/survey/getTextItemList.do</c:when>
	<c:when test="${nameValue == 'initSurveyItemControlled'}">${pageContext.request.contextPath}/loyalty/survey/initSurveyItemControlled.do</c:when>
	<c:when test="${nameValue == 'getSurveyItemListPop'}">${pageContext.request.contextPath}/loyalty/survey/getSurveyItemListPop.do</c:when>

	<%-- 기프트카드 --%>
<%-- 	<c:when test="${nameValue == 'getGiftcardListNew'}">${pageContext.request.contextPath}/loyalty/giftishow/getGiftcardListNew.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'editGiftcard'}">${pageContext.request.contextPath}/loyalty/giftishow/editGiftcard.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'getGiftcardTxnList'}">${pageContext.request.contextPath}/loyalty/giftishow/getGiftcardTxnList.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'clearMaskGift'}">${pageContext.request.contextPath}/loyalty/giftishow/clearMaskGift.do</c:when> --%>
<%-- 	<c:when test="${nameValue == 'saveGiftCard'}">${pageContext.request.contextPath}/loyalty/giftishow/saveGiftCard.do</c:when> --%>

	<%-- SR Management --%>
	<c:when test="${nameValue == 'getQnaList'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/getQnaList.do</c:when>
	<c:when test="${nameValue == 'getQnaDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/getQnaDetail.do</c:when>
	<c:when test="${nameValue == 'updateQnaDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/updateQnaDetail.do</c:when>

	<%--개인정보 취급 이력 --%>
	<c:when test="${nameValue == 'getPiMaskDecList'}">${pageContext.request.contextPath}/common/log/getPiMaskDecList.do</c:when>
	<c:when test="${nameValue == 'getPiMaskDecExcelDn'}">${pageContext.request.contextPath}/common/log/getPiMaskDecExcelDn.do</c:when>

	<%--API 명세서 --%>
	<c:when test="${nameValue == 'getApiSpecList'}">${pageContext.request.contextPath}/system/apiSpec/getApiSpecList.do</c:when>
	<c:when test="${nameValue == 'insertApiSpec'}">${pageContext.request.contextPath}/system/apiSpec/insertApiSpec.do</c:when>
	<c:when test="${nameValue == 'deleteApiSpec'}">${pageContext.request.contextPath}/system/apiSpec/deleteApiSpec.do</c:when>
	<c:when test="${nameValue == 'updateApiSpec'}">${pageContext.request.contextPath}/system/apiSpec/updateApiSpec.do</c:when>
	<c:when test="${nameValue == 'apiSpecDetail'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecDetail.do</c:when>
	<c:when test="${nameValue == 'apiSpecUpload'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecUpload.do</c:when>
	<c:when test="${nameValue == 'apiSpecFileList'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecFileList.do</c:when>
	<c:when test="${nameValue == 'apiSpecDownload'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecDownload.do</c:when>
	<c:when test="${nameValue == 'fileRemove'}">${pageContext.request.contextPath}/system/apiSpec/fileRemove.do</c:when>
	<c:when test="${nameValue == 'fileDown'}">${pageContext.request.contextPath}/system/apiSpec/fileDown.do</c:when>
	<c:when test="${nameValue == 'getApiSendLogList'}">${pageContext.request.contextPath}/system/apiSpec/getApiSendLogList.do</c:when>
	<%-- <c:when test="${nameValue == 'apiSpecExcelDown'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecExcelDown.do</c:when> --%>
	<c:when test="${nameValue == 'getApiChnlList'}">${pageContext.request.contextPath}/system/apiSpec/getApiChnlList.do</c:when>
	<c:when test="${nameValue == 'apiSpecJoinChnl'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecJoinChnl.do</c:when>
	<c:when test="${nameValue == 'removeApiChnl'}">${pageContext.request.contextPath}/system/apiSpec/removeApiChnl.do</c:when>
	<c:when test="${nameValue == 'getApiSpecNo'}">${pageContext.request.contextPath}/system/apiSpec/getApiSpecNo.do</c:when>
	<c:when test="${nameValue == 'getApiSpecListPop'}">${pageContext.request.contextPath}/system/apiSpec/getApiSpecListPop.do</c:when>
	<c:when test="${nameValue == 'copyApiChnl'}">${pageContext.request.contextPath}/system/apiSpec/copyApiChnl.do</c:when>
	<c:when test="${nameValue == 'getApiParamList'}">${pageContext.request.contextPath}/system/apiSpec/getApiParamList.do</c:when>
	<c:when test="${nameValue == 'getApiParamResList'}">${pageContext.request.contextPath}/system/apiSpec/getApiParamResList.do</c:when>

	<c:when test="${nameValue == 'getParamResDetail'}">${pageContext.request.contextPath}/system/apiSpec/getParamResDetail.do</c:when>
	<c:when test="${nameValue == 'getParamReqDetail'}">${pageContext.request.contextPath}/system/apiSpec/getParamReqDetail.do</c:when>
	<c:when test="${nameValue == 'saveApiParamReq'}">${pageContext.request.contextPath}/system/apiSpec/saveApiParamReq.do</c:when>
	<c:when test="${nameValue == 'editApiParamReq'}">${pageContext.request.contextPath}/system/apiSpec/editApiParamReq.do</c:when>
	<c:when test="${nameValue == 'saveApiParamRes'}">${pageContext.request.contextPath}/system/apiSpec/saveApiParamRes.do</c:when>
	<c:when test="${nameValue == 'editApiParamRes'}">${pageContext.request.contextPath}/system/apiSpec/editApiParamRes.do</c:when>
	<c:when test="${nameValue == 'removeApiParam'}">${pageContext.request.contextPath}/system/apiSpec/removeApiParam.do</c:when>
	<c:when test="${nameValue == 'getParParamList'}">${pageContext.request.contextPath}/system/apiSpec/getParParamList.do</c:when>


	<%-- 알림공지 --%>
	<c:when test="${nameValue == 'getAlertMsgList'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/getAlertMsgList.do</c:when>
	<c:when test="${nameValue == 'insertAlertMsg'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/insertAlertMsg.do</c:when>
	<c:when test="${nameValue == 'deleteAlertMsg'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/deleteAlertMsg.do</c:when>
	<c:when test="${nameValue == 'updateAlertMsg'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/updateAlertMsg.do</c:when>
	<c:when test="${nameValue == 'getAlertMsgPopupDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/getAlertMsgPopupDetail.do</c:when>

	<%-- 메시지 프로퍼티 관리--%>
	<%-- <c:when test="${nameValue == 'getMsgPropertiesList'}">${pageContext.request.contextPath}/system/msgproperties/getMsgPropertiesList.do</c:when>
	<c:when test="${nameValue == 'getMsgAttrList'}">${pageContext.request.contextPath}/system/msgproperties/getMsgAttrList.do</c:when>
	<c:when test="${nameValue == 'addMsgProperties'}">${pageContext.request.contextPath}/system/msgproperties/addMsgProperties.do</c:when>
	<c:when test="${nameValue == 'editMsgProperties'}">${pageContext.request.contextPath}/system/msgproperties/editMsgProperties.do</c:when>
	<c:when test="${nameValue == 'delMsgProperties'}">${pageContext.request.contextPath}/system/msgproperties/delMsgProperties.do</c:when>
	<c:when test="${nameValue == 'addMsgAttr'}">${pageContext.request.contextPath}/system/msgproperties/addMsgAttr.do</c:when>
	<c:when test="${nameValue == 'editMsgAttr'}">${pageContext.request.contextPath}/system/msgproperties/editMsgAttr.do</c:when>
	<c:when test="${nameValue == 'delMsgAttr'}">${pageContext.request.contextPath}/system/msgproperties/delMsgAttr.do</c:when>
	<c:when test="${nameValue == 'msgAttrItemListExcel'}">${pageContext.request.contextPath}/system/msgproperties/msgAttrItemListExcel.do</c:when>
	<c:when test="${nameValue == 'uploadExcelMsg'}">${pageContext.request.contextPath}/system/msgproperties/uploadExcelMsg.do</c:when> --%>
	<c:when test="${nameValue == 'sendMailSmtp'}">${pageContext.request.contextPath}/loyalty/channel/sendMailSmtp.do</c:when>
	<c:when test="${nameValue == 'sendMailSmtp2'}">${pageContext.request.contextPath}/loyalty/channel/sendMailSmtp2.do</c:when>
	<c:when test="${nameValue == '	getmail'}">${pageContext.request.contextPath}/auth/email/emailAuth.do</c:when>
	<c:when test="${nameValue == '	authEmailConfirm'}">${pageContext.request.contextPath}/auth/email/authEmailConfirm.do</c:when>

	<c:when test="${nameValue == 'getAuthListNotGrid'}">${pageContext.request.contextPath}/system/auth/getAuthListNotGrid.do</c:when>
	<c:when test="${nameValue == 'authDetailsave'}">${pageContext.request.contextPath}/system/auth/authDetailsave.do</c:when>

	<c:when test="${nameValue == 'getObjInfoList'}">${pageContext.request.contextPath}/system/auth/getObjInfoList.do</c:when>
	<%-- LOY 캠페인 : 프로모션 리스트--%>
	<c:when test="${nameValue == 'getPromotionList'}">${pageContext.request.contextPath}/loyalty/campaign/getPromotionList.do</c:when>
	<%-- LOY캠페인 기본정보 --%>
	<c:when test="${nameValue == 'removeLOYCampaignProgram'}">${pageContext.request.contextPath}/loyalty/campaign/removeCampaignProgram.do</c:when>
	<%-- LOY캠페인 헤더 노드 리스트 출력 --%>
	<c:when test="${nameValue == 'getLoyTempNodeList'}">${pageContext.request.contextPath}/loyalty/campaign/getTempNodeList.do</c:when>
	<c:when test="${nameValue == 'getLoyTemp'}">${pageContext.request.contextPath}/loyalty/campaign/getTemp.do</c:when>

	<%-- LOY캠페인 프로모션 캠페인 - 가구화 --%>
	<c:when test="${nameValue == 'getMaxMinFamilyCnt'}">${pageContext.request.contextPath}/loyalty/campaign/getMaxMinFamilyCnt.do</c:when>
	<c:when test="${nameValue == 'saveCampaignWorkflowTemplateUse'}">${pageContext.request.contextPath}/loyalty/campaign/saveCampaignWorkflowTemplateUse.do</c:when>


	<c:when test="${nameValue == 'callProcCamCopyLoy'}">${pageContext.request.contextPath}/loyalty/campaign/callProcCamCopy.do</c:when>


	<%-- 시스템 운영  --%>

	<%-- 공통코드 --%>
	<c:when test="${nameValue == 'getCommCodeList'}">${pageContext.request.contextPath}/system/commcode/getCommCodeList.do</c:when>
	<c:when test="${nameValue == 'getCommCondLIst'}">${pageContext.request.contextPath}/system/commcode/getCommCondLIst.do</c:when>
	<c:when test="${nameValue == 'getParIdNullCodeList'}">${pageContext.request.contextPath}/system/commcode/getParIdNullCodeList.do</c:when>

	<%-- 실행 채널 시스템 관리 --%>
	<c:when test="${nameValue == 'getChannel'}">${pageContext.request.contextPath}/system/channel/getChannel.do</c:when>
	<c:when test="${nameValue == 'removeImgOption'}">${pageContext.request.contextPath}/system/channel/removeImgOption.do</c:when>
	<c:when test="${nameValue == 'DetailgetChannel'}">${pageContext.request.contextPath}/system/channel/DetailgetChannel.do</c:when>
	<c:when test="${nameValue == 'editChannel'}">${pageContext.request.contextPath}/system/channel/editChannel.do</c:when>
	<c:when test="${nameValue == 'getChannelCheck'}">${pageContext.request.contextPath}/system/channel/getChannelCheck.do</c:when>
	<c:when test="${nameValue == 'setChannel'}">${pageContext.request.contextPath}/system/channel/setChannel.do</c:when>
	<c:when test="${nameValue == 'deleteSnsAdtnInfo'}">${pageContext.request.contextPath}/system/channel/deleteSnsAdtnInfo.do</c:when>
	<c:when test="${nameValue == 'getDateInfo'}">${pageContext.request.contextPath}/system/channel/getDateInfo.do</c:when>
	<c:when test="${nameValue == 'getChannelStore'}">${pageContext.request.contextPath}/system/channel/getChannelStore.do</c:when>
	<c:when test="${nameValue == 'removeCapa'}">${pageContext.request.contextPath}/system/channel/removeCapa.do</c:when>
	<c:when test="${nameValue == 'getChannelOrg'}">${pageContext.request.contextPath}/system/channel/getChannelOrg.do</c:when>
	<c:when test="${nameValue == 'getSnsAdtnInfoList'}">${pageContext.request.contextPath}/system/channel/getSnsAdtnInfoList.do</c:when>
	<c:when test="${nameValue == 'getImgOption'}">${pageContext.request.contextPath}/system/channel/getImgOption.do</c:when>
	<c:when test="${nameValue == 'editImgOption'}">${pageContext.request.contextPath}/system/channel/editImgOption.do</c:when>
	<c:when test="${nameValue == 'getContypeId'}">${pageContext.request.contextPath}/system/channel/getContypeId.do</c:when>
	<c:when test="${nameValue == 'getImageOptionList'}">${pageContext.request.contextPath}/system/channel/getImageOptionList.do</c:when>
	<c:when test="${nameValue == 'setImgOption'}">${pageContext.request.contextPath}/system/channel/setImgOption.do</c:when>
	<c:when test="${nameValue == 'setChannelStore'}">${pageContext.request.contextPath}/system/channel/setChannelStore.do</c:when>
	<c:when test="${nameValue == 'editCapaChannel'}">${pageContext.request.contextPath}/system/channel/editCapaChannel.do</c:when>
	<c:when test="${nameValue == 'getDetailCapa'}">${pageContext.request.contextPath}/system/channel/getDetailCapa.do</c:when>
	<c:when test="${nameValue == 'getImgDetailOption'}">${pageContext.request.contextPath}/system/channel/getImgDetailOption.do</c:when>

	<%-- 실행 채널 시스템 관리 - 소셜부가정보 --%>
	<c:when test="${nameValue == 'insertSnsAdtnInfo'}">${pageContext.request.contextPath}/system/channel/insertSnsAdtnInfo.do</c:when>
	<c:when test="${nameValue == 'getDetailSnsAdtnInfo'}">${pageContext.request.contextPath}/system/channel/getDetailSnsAdtnInfo.do</c:when>
	<c:when test="${nameValue == 'updateSnsAdtnInfo'}">${pageContext.request.contextPath}/system/channel/updateSnsAdtnInfo.do</c:when>



	<%-- 프로그램 관리 --%>
	<c:when test="${nameValue == 'getProgAllList'}">${pageContext.request.contextPath}/system/program/getProgAllList.do</c:when>
	<c:when test="${nameValue == 'deleteProgList'}">${pageContext.request.contextPath}/system/program/deleteProgList.do</c:when>
	<c:when test="${nameValue == 'insertProgramDetail'}">${pageContext.request.contextPath}/system/program/insertProgramDetail.do</c:when>
	<c:when test="${nameValue == 'progListDetail'}">${pageContext.request.contextPath}/system/program/progListDetail.do</c:when>
	<c:when test="${nameValue == 'updateProgramDetail'}">${pageContext.request.contextPath}/system/program/updateProgramDetail.do</c:when>
	<c:when test="${nameValue == 'getObjAuthList'}">${pageContext.request.contextPath}/system/program/getObjAuthList.do</c:when>
	<c:when test="${nameValue == 'getObjectListNew'}">${pageContext.request.contextPath}/system/program/getObjectListNew.do</c:when>
	<c:when test="${nameValue == 'getAuthListPop'}">${pageContext.request.contextPath}/system/program/getAuthListPop.do</c:when>
	<c:when test="${nameValue == 'setAuthObjRelPopup'}">${pageContext.request.contextPath}/system/program/setAuthObjRelPopup.do</c:when>
	<c:when test="${nameValue == 'progDetail'}">${pageContext.request.contextPath}/system/program/progDetailNew</c:when>
	<c:when test="${nameValue == 'deleteUIObjectList'}">${pageContext.request.contextPath}/system/program/deleteUIObjectList.do</c:when>
	<c:when test="${nameValue == 'insertUIObjectDetail'}">${pageContext.request.contextPath}/system/program/insertUIObjectDetail.do</c:when>
	<c:when test="${nameValue == 'getProgramListPop'}">${pageContext.request.contextPath}/system/program/getProgramListPop.do</c:when>
	<c:when test="${nameValue == 'editProgramDown'}">${pageContext.request.contextPath}/system/program/editProgramDown.do</c:when>
	<c:when test="${nameValue == 'removeProgramDown'}">${pageContext.request.contextPath}/system/program/removeProgramDown.do</c:when>
	<c:when test="${nameValue == 'programAuthCheck'}">${pageContext.request.contextPath}/system/program/programAuthCheck.do</c:when>
	<c:when test="${nameValue == 'removeProgramAuth'}">${pageContext.request.contextPath}/system/program/removeProgramAuth.do</c:when>
	<c:when test="${nameValue == 'getAuthProgramList'}">${pageContext.request.contextPath}/system/program/getAuthProgramList.do</c:when>
	<c:when test="${nameValue == 'setAuthProgramAddRel'}">${pageContext.request.contextPath}/system/program/setAuthProgramAddRel.do</c:when>
	<c:when test="${nameValue == 'getProgramAuthList'}">${pageContext.request.contextPath}/system/program/getProgramAuthList.do</c:when>
	<c:when test="${nameValue == 'getLowProgramRel'}">${pageContext.request.contextPath}/system/program/getLowProgramRel.do</c:when>
	<c:when test="${nameValue == 'getProgramChildTab'}">${pageContext.request.contextPath}/system/program/getProgramChildTab.do</c:when>
	<c:when test="${nameValue == 'getLowProgListPop'}">${pageContext.request.contextPath}/system/program/getLowProgListPop.do</c:when>
	<c:when test="${nameValue == 'editParProgramDown'}">${pageContext.request.contextPath}/system/program/editParProgramDown.do</c:when>
	<c:when test="${nameValue == 'removeParProgramDown'}">${pageContext.request.contextPath}/system/program/removeParProgramDown.do</c:when>
	<c:when test="${nameValue == 'getDetailProgramList'}">${pageContext.request.contextPath}/system/program/getDetailProgramList.do</c:when>
	<c:when test="${nameValue == 'getDetailParProgList'}">${pageContext.request.contextPath}/system/program/getDetailParProgList.do</c:when>
	<c:when test="${nameValue == 'progRelExcelDown'}">${pageContext.request.contextPath}/system/program/progRelExcelDown.do</c:when>

	<c:when test="${nameValue == 'getExcelDownloadList'}">${pageContext.request.contextPath}/system/program/getExcelDownloadList.do</c:when>
	<c:when test="${nameValue == 'setProgramExcelFile'}">${pageContext.request.contextPath}/system/program/setProgramExcelFile.do</c:when>
	<c:when test="${nameValue == 'deleteExcelFile'}">${pageContext.request.contextPath}/system/program/deleteExcelFile.do</c:when>
	<c:when test="${nameValue == 'excelTempUpload'}">${pageContext.request.contextPath}/system/program/excelTempUpload.do</c:when>
	<c:when test="${nameValue == 'getDtlExcel'}">${pageContext.request.contextPath}/system/program/getDtlExcel.do</c:when>
	<c:when test="${nameValue == 'editExcelFile'}">${pageContext.request.contextPath}/system/program/editExcelFile.do</c:when>
	<c:when test="${nameValue == 'getDataMapList'}">${pageContext.request.contextPath}/system/program/getDataMapList.do</c:when>
	<c:when test="${nameValue == 'getDtlExcelData'}">${pageContext.request.contextPath}/system/program/getDtlExcelData.do</c:when>
	<c:when test="${nameValue == 'setExcelData'}">${pageContext.request.contextPath}/system/program/setExcelData.do</c:when>
	<c:when test="${nameValue == 'editExcelData'}">${pageContext.request.contextPath}/system/program/editExcelData.do</c:when>
	<c:when test="${nameValue == 'editExcelFile'}">${pageContext.request.contextPath}/system/program/editExcelFile.do</c:when>
	<c:when test="${nameValue == 'deleteDataMap'}">${pageContext.request.contextPath}/system/program/deleteDataMap.do</c:when>
	<c:when test="${nameValue == 'tempFileDownload'}">${pageContext.request.contextPath}/system/program/tempFileDownload.do</c:when>


	<%-- 오브젝트 관리 --%>
	<c:when test="${nameValue == 'getObjectList'}">${pageContext.request.contextPath}/system/object/getObjectList.do</c:when>
	<c:when test="${nameValue == 'insertObjectDetail'}">${pageContext.request.contextPath}/system/object/insertObjectDetail.do</c:when>
	<c:when test="${nameValue == 'getObjectDetail'}">${pageContext.request.contextPath}/system/object/getObjectDetail.do</c:when>
	<c:when test="${nameValue == 'updateObjectDetail'}">${pageContext.request.contextPath}/system/object/updateObjectDetail.do</c:when>
	<c:when test="${nameValue == 'deleteObjectList'}">${pageContext.request.contextPath}/system/object/deleteObjectList.do</c:when>
	<c:when test="${nameValue == 'getUIObjectList'}">${pageContext.request.contextPath}/system/object/getUIObjectList.do</c:when>
	<c:when test="${nameValue == 'getObjectCode'}">${pageContext.request.contextPath}/system/object/getObjectCode.do</c:when>
	<c:when test="${nameValue == 'updateUIObjectDetail'}">${pageContext.request.contextPath}/system/object/updateUIObjectDetail.do</c:when>
	<c:when test="${nameValue == 'getUIObjectDetail'}">${pageContext.request.contextPath}/system/object/getUIObjectDetail.do</c:when>

	<%-- 권한 관리 --%>
	<c:when test="${nameValue == 'getAuthList'}">${pageContext.request.contextPath}/system/auth/getAuthList.do</c:when>
	<c:when test="${nameValue == 'deleteAuthList'}">${pageContext.request.contextPath}/system/auth/deleteAuthList.do</c:when>
	<c:when test="${nameValue == 'authDetail'}">${pageContext.request.contextPath}/system/auth/authDetail.do</c:when>
	<c:when test="${nameValue == 'insertAuthDetail'}">${pageContext.request.contextPath}/system/auth/insertAuthDetail.do</c:when>
	<c:when test="${nameValue == 'updateAuthDetail'}">${pageContext.request.contextPath}/system/auth/updateAuthDetail.do</c:when>
	<c:when test="${nameValue == 'getMenuNameLang'}">${pageContext.request.contextPath}/system/auth/getMenuNameLang.do</c:when>
	<c:when test="${nameValue == 'getAuthMenuList'}">${pageContext.request.contextPath}/system/auth/getAuthMenuList.do</c:when>
	<c:when test="${nameValue == 'getProgramAccessList'}">${pageContext.request.contextPath}/system/auth/getProgramAccessList.do</c:when>
	<c:when test="${nameValue == 'setViewAuthList'}">${pageContext.request.contextPath}/system/auth/setViewAuthList.do</c:when>
	<c:when test="${nameValue == 'getAuthObjectList'}">${pageContext.request.contextPath}/system/auth/getAuthObjectList.do</c:when>
	<c:when test="${nameValue == 'deleteAuthObjRel'}">${pageContext.request.contextPath}/system/auth/deleteAuthObjRel.do</c:when>
	<c:when test="${nameValue == 'getProgList'}">${pageContext.request.contextPath}/system/auth/getProgList.do</c:when>
	<c:when test="${nameValue == 'callAuthCopyProc'}">${pageContext.request.contextPath}/system/auth/callAuthCopyProc.do</c:when>
	<c:when test="${nameValue == 'getAuthCopyList'}">${pageContext.request.contextPath}/system/auth/getAuthCopyList.do</c:when>
	<c:when test="${nameValue == 'getProgAuthList'}">${pageContext.request.contextPath}/system/auth/getProgAuthList.do</c:when>
	<c:when test="${nameValue == 'getAuthProgramListPop'}">${pageContext.request.contextPath}/system/auth/getAuthProgramListPop.do</c:when>
	<c:when test="${nameValue == 'addProgramAuth'}">${pageContext.request.contextPath}/system/auth/addProgramAuth.do</c:when>
	<c:when test="${nameValue == 'getAuthProgram'}">${pageContext.request.contextPath}/system/auth/getAuthProgram.do</c:when>
	<c:when test="${nameValue == 'removeProgramPrarentAuth'}">${pageContext.request.contextPath}/system/auth/removeProgramPrarentAuth.do</c:when>
	<c:when test="${nameValue == 'removeProgramChildAuth'}">${pageContext.request.contextPath}/system/auth/removeProgramChildAuth.do</c:when>
	<c:when test="${nameValue == 'getAuthProgramLChildistPop'}">${pageContext.request.contextPath}/system/auth/getAuthProgramLChildistPop.do</c:when>
	<c:when test="${nameValue == 'addProgramChildAuth'}">${pageContext.request.contextPath}/system/auth/addProgramChildAuth.do</c:when>
	<c:when test="${nameValue == 'delAuthObjRel'}">${pageContext.request.contextPath}/system/auth/delAuthObjRel.do</c:when>

	<%-- 권한 그룹 관리 --%>
	<c:when test="${nameValue == 'getAuthGroupList'}">${pageContext.request.contextPath}/system/authgroup/getAuthGroupList.do</c:when>
	<c:when test="${nameValue == 'deleteAuthGroupList'}">${pageContext.request.contextPath}/system/authgroup/deleteAuthGroupList.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupDetailNew'}">${pageContext.request.contextPath}/system/authgroup/getAuthGroupDetailNew.do</c:when>
	<c:when test="${nameValue == 'insertGroupDetail'}">${pageContext.request.contextPath}/system/authgroup/insertGroupDetail.do</c:when>
	<c:when test="${nameValue == 'updateGroupDetail'}">${pageContext.request.contextPath}/system/authgroup/updateGroupDetail.do</c:when>
	<c:when test="${nameValue == 'getAuthEmpList'}">${pageContext.request.contextPath}/system/authgroup/getAuthEmpList.do</c:when>
	<c:when test="${nameValue == 'deleteEmpList'}">${pageContext.request.contextPath}/system/authgroup/deleteEmpList.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupAuthList'}">${pageContext.request.contextPath}/system/authgroup/getAuthGroupAuthList.do</c:when>
	<c:when test="${nameValue == 'deleteGroupAuthList'}">${pageContext.request.contextPath}/system/authgroup/deleteGroupAuthList.do</c:when>
	<c:when test="${nameValue == 'getAuthAddListModal'}">${pageContext.request.contextPath}/system/authgroup/getAuthAddListModal.do</c:when>
	<c:when test="${nameValue == 'getEmpAddListModal'}">${pageContext.request.contextPath}/system/authgroup/getEmpAddListModal.do</c:when>
	<c:when test="${nameValue == 'addEmpList'}">${pageContext.request.contextPath}/system/authgroup/addEmpList.do</c:when>
	<c:when test="${nameValue == 'addAuthList'}">${pageContext.request.contextPath}/system/authgroup/addAuthList.do</c:when>

	<%-- 직원 관리 --%>
	<c:when test="${nameValue == 'MKTDeleteEmployee'}">${pageContext.request.contextPath}/system/employee/deleteEmployee.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupListByEmpIdAndRidUser'}">${pageContext.request.contextPath}/system/employee/getAuthGroupListByEmpIdAndRidUser.do</c:when>
	<c:when test="${nameValue == 'getUserListByEmpId'}">${pageContext.request.contextPath}/system/employee/getUserListByEmpId.do</c:when>
	<c:when test="${nameValue == 'MKTSelectEmployeeList'}">${pageContext.request.contextPath}/system/employee/selectEmployeeList.do</c:when>
	<c:when test="${nameValue == 'getIpAccessControlList'}">${pageContext.request.contextPath}/system/employee/getIpAccessControlList.do</c:when>
	<c:when test="${nameValue == 'removeIpAccessControl'}">${pageContext.request.contextPath}/system/employee/removeIpAccessControl.do</c:when>
	<c:when test="${nameValue == 'deleteAuthGroupByRid'}">${pageContext.request.contextPath}/system/employee/deleteAuthGroupByRid.do</c:when>
	<c:when test="${nameValue == 'deleteUserDetail'}">${pageContext.request.contextPath}/system/employee/deleteUserDetail.do</c:when>
	<c:when test="${nameValue == 'MKTSelectEmployeeDetail'}">${pageContext.request.contextPath}/system/employee/selectEmployeeDetail.do</c:when>
<%-- 	<c:when test="${nameValue == 'getOrganizationDetail'}">${pageContext.request.contextPath}/system/employee/getOrganizationDetail.do</c:when> --%>
	<c:when test="${nameValue == 'MKTInsertEmployee'}">${pageContext.request.contextPath}/system/employee/insertEmployee.do</c:when>
	<c:when test="${nameValue == 'MKTUpdateEmployee'}">${pageContext.request.contextPath}/system/employee/updateEmployee.do</c:when>
	<c:when test="${nameValue == 'getIpAccessControlDetail'}">${pageContext.request.contextPath}/system/employee/getIpAccessControlDetail.do</c:when>
	<c:when test="${nameValue == 'modifyIpAccessControl'}">${pageContext.request.contextPath}/system/employee/modifyIpAccessControl.do</c:when>
	<c:when test="${nameValue == 'setIpAccessControl'}">${pageContext.request.contextPath}/system/employee/setIpAccessControl.do</c:when>
	<c:when test="${nameValue == 'getIpAccessControlHistList'}">${pageContext.request.contextPath}/system/employee/getIpAccessControlHistList.do</c:when>
	<c:when test="${nameValue == 'getAuthGroupListByRidUser'}">${pageContext.request.contextPath}/system/employee/getAuthGroupListByRidUser.do</c:when>
	<c:when test="${nameValue == 'insertAuthGroupAndEmpId'}">${pageContext.request.contextPath}/system/employee/insertAuthGroupAndEmpId.do</c:when>
	<c:when test="${nameValue == 'getUserDetail'}">${pageContext.request.contextPath}/system/employee/getUserDetail.do</c:when>
	<c:when test="${nameValue == 'insertUserDetail'}">${pageContext.request.contextPath}/system/employee/insertUserDetail.do</c:when>
	<c:when test="${nameValue == 'updateUserDetail'}">${pageContext.request.contextPath}/system/employee/updateUserDetail.do</c:when>
	<c:when test="${nameValue == 'setActiveUserLoginHist'}">${pageContext.request.contextPath}/system/employee/setActiveUserLoginHist.do</c:when>
	<c:when test="${nameValue == 'MKTSelectEmployeePopUp'}">${pageContext.request.contextPath}/system/employee/selectEmployeePopUp.do</c:when>
	<c:when test="${nameValue == 'setCurrentdivision'}">${pageContext.request.contextPath}/system/employee/setCurrentdivision.do</c:when>

	<%-- 부서 및 매장관리 --%>
	<c:when test="${nameValue == 'getSubAccountList'}">${pageContext.request.contextPath}/system/department/getSubAccountList.do</c:when>
	<c:when test="${nameValue == 'getRootAccountList'}">${pageContext.request.contextPath}/system/department/getRootAccountList.do</c:when>
	<c:when test="${nameValue == 'setAccountLevel'}">${pageContext.request.contextPath}/system/department/setAccountLevel.do</c:when>


	<c:when test="${nameValue == 'getLoginHistoryList'}">${pageContext.request.contextPath}/common/log/getLoginHistoryList.do</c:when>
	<c:when test="${nameValue == 'naverLogin'}">${pageContext.request.contextPath}/naverLogin.do</c:when>
	<c:when test="${nameValue == 'facebookLogin'}">${pageContext.request.contextPath}/facebookLogin.do</c:when>
	<c:when test="${nameValue == 'googleLogin'}">${pageContext.request.contextPath}/googleLogin.do</c:when>
	<c:when test="${nameValue == 'kakaoLogin'}">${pageContext.request.contextPath}/kakaoLogin.do</c:when>

	<c:when test="${nameValue == 'naverLoginAuth'}">${pageContext.request.contextPath}/naverLoginAuth.do</c:when>
	<c:when test="${nameValue == 'facebookLoginAuth'}">${pageContext.request.contextPath}/facebookLoginAuth.do</c:when>
	<c:when test="${nameValue == 'googleLoginAuth'}">${pageContext.request.contextPath}/googleLoginAuth.do</c:when>
	<c:when test="${nameValue == 'kakaoLoginAuth'}">${pageContext.request.contextPath}/kakaoLoginAuth.do</c:when>
	<c:when test="${nameValue == 'kakaoAlterTalk'}">${pageContext.request.contextPath}/kakaoAlterTalk.do</c:when>
	<c:when test="${nameValue == 'ConfirmKakaoLogin'}">${pageContext.request.contextPath}/ConfirmKakaoLogin.do</c:when>
	<c:when test="${nameValue == 'ConfirmNaverLogin'}">${pageContext.request.contextPath}/ConfirmNaverLogin.do</c:when>

	<%-- 용어사전 관리 --%>
	<c:when test="${nameValue == 'getWordDictionaryList'}">${pageContext.request.contextPath}/system/wordDictionary/getWordDictionaryList.do</c:when>
	<c:when test="${nameValue == 'getWordDicDetail'}">${pageContext.request.contextPath}/system/wordDictionary/getWordDicDetail.do</c:when>
	<c:when test="${nameValue == 'getWordDictionaryChk'}">${pageContext.request.contextPath}/system/wordDictionary/getWordDictionaryChk.do</c:when>
	<c:when test="${nameValue == 'setWordDictionary'}">${pageContext.request.contextPath}/system/wordDictionary/setWordDictionary.do</c:when>
	<c:when test="${nameValue == 'editWordDictionary'}">${pageContext.request.contextPath}/system/wordDictionary/editWordDictionary.do</c:when>
	<c:when test="${nameValue == 'delWordDictionary'}">${pageContext.request.contextPath}/system/wordDictionary/delWordDictionary.do</c:when>

	<%-- 클럽 마스터(회원) --%>
	<c:when test="${nameValue == 'getClubList'}">${pageContext.request.contextPath}/loyalty/club/getClubList.do</c:when>
	<c:when test="${nameValue == 'getClubAttrList'}">${pageContext.request.contextPath}/loyalty/club/getClubAttrList.do</c:when>
	<c:when test="${nameValue == 'getClubOfferList'}">${pageContext.request.contextPath}/loyalty/club/getClubOfferList.do</c:when>
	<c:when test="${nameValue == 'getClubMbrList'}">${pageContext.request.contextPath}/loyalty/club/getClubMbrList.do</c:when>
	<c:when test="${nameValue == 'getClubDetail'}">${pageContext.request.contextPath}/loyalty/club/getClubDetail.do</c:when>
	<c:when test="${nameValue == 'saveClubDetail'}">${pageContext.request.contextPath}/loyalty/club/saveClubDetail.do</c:when>
	<c:when test="${nameValue == 'modifyClubDetail'}">${pageContext.request.contextPath}/loyalty/club/modifyClubDetail.do</c:when>
	<c:when test="${nameValue == 'removeClub'}">${pageContext.request.contextPath}/loyalty/club/removeClub.do</c:when>
	<c:when test="${nameValue == 'getClubAttrDetail'}">${pageContext.request.contextPath}/loyalty/club/getClubAttrDetail.do</c:when>
	<c:when test="${nameValue == 'saveClubAttrDetail'}">${pageContext.request.contextPath}/loyalty/club/saveClubAttrDetail.do</c:when>
	<c:when test="${nameValue == 'modifyClubAttrDetail'}">${pageContext.request.contextPath}/loyalty/club/modifyClubAttrDetail.do</c:when>
	<c:when test="${nameValue == 'removeClubAttr'}">${pageContext.request.contextPath}/loyalty/club/removeClubAttr.do</c:when>
	<c:when test="${nameValue == 'saveClubOfferDetail'}">${pageContext.request.contextPath}/loyalty/club/saveClubOfferDetail.do</c:when>
	<c:when test="${nameValue == 'modifyClubOfferDetail'}">${pageContext.request.contextPath}/loyalty/club/modifyClubOfferDetail.do</c:when>
	<c:when test="${nameValue == 'removeClubOffer'}">${pageContext.request.contextPath}/loyalty/club/removeClubOffer.do</c:when>
	<c:when test="${nameValue == 'getClubOfferDetail'}">${pageContext.request.contextPath}/loyalty/club/getClubOfferDetail.do</c:when>
	<c:when test="${nameValue == 'getClubAttrInMbr'}">${pageContext.request.contextPath}/loyalty/club/getClubAttrInMbr.do</c:when>
	<c:when test="${nameValue == 'saveClubMbrDetail'}">${pageContext.request.contextPath}/loyalty/club/saveClubMbrDetail.do</c:when>
	<c:when test="${nameValue == 'modifyClubMbrDetail'}">${pageContext.request.contextPath}/loyalty/club/modifyClubMbrDetail.do</c:when>
	<c:when test="${nameValue == 'getClubMbrDetail'}">${pageContext.request.contextPath}/loyalty/club/getClubMbrDetail.do</c:when>
	<c:when test="${nameValue == 'clubMbrFileupload'}">${pageContext.request.contextPath}/loyalty/club/clubMbrFileupload.do</c:when>
	<c:when test="${nameValue == 'clearMaskClubMbr'}">${pageContext.request.contextPath}/loyalty/club/clearMaskClubMbr.do</c:when>
	<c:when test="${nameValue == 'apprClubMbr'}">${pageContext.request.contextPath}/loyalty/club/apprClubMbr.do</c:when>
	<c:when test="${nameValue == 'saveResnRgst'}">${pageContext.request.contextPath}/loyalty/club/saveResnRgst.do</c:when>
	<c:when test="${nameValue == 'searchProcessDate'}">${pageContext.request.contextPath}/loyalty/club/searchProcessDate.do</c:when>
	<c:when test="${nameValue == 'getClubMbrValidCheck'}">${pageContext.request.contextPath}/loyalty/club/getClubMbrValidCheck.do</c:when>
	<%-- 회원(클럽) --%>
	<c:when test="${nameValue == 'getMbrListPop'}">${pageContext.request.contextPath}/common/view/getMbrListPop.do</c:when>
	<c:when test="${nameValue == 'clearMaskMbrNew'}">${pageContext.request.contextPath}/loyalty/club/clearMaskMbrNew.do</c:when>

	<%-- 고객식별관리(중복룰) --%>
	<c:when test="${nameValue == 'getCustDiList'}">${pageContext.request.contextPath}/loyalty/custdi/getCustDiList.do</c:when>
	<c:when test="${nameValue == 'getCustDiDetail'}">${pageContext.request.contextPath}/loyalty/custdi/getCustDiDetail.do</c:when>
	<c:when test="${nameValue == 'getCustDiValList'}">${pageContext.request.contextPath}/loyalty/custdi/getCustDiValList.do</c:when>
	<c:when test="${nameValue == 'saveCustDiDetail'}">${pageContext.request.contextPath}/loyalty/custdi/saveCustDiDetail.do</c:when>
	<c:when test="${nameValue == 'modifyCustDiDetail'}">${pageContext.request.contextPath}/loyalty/custdi/modifyCustDiDetail.do</c:when>
	<c:when test="${nameValue == 'saveCustDiValDetail'}">${pageContext.request.contextPath}/loyalty/custdi/saveCustDiValDetail.do</c:when>
	<c:when test="${nameValue == 'modifyCustDiValDetail'}">${pageContext.request.contextPath}/loyalty/custdi/modifyCustDiValDetail.do</c:when>
	<c:when test="${nameValue == 'getCustDiValDetail'}">${pageContext.request.contextPath}/loyalty/custdi/getCustDiValDetail.do</c:when>
	<c:when test="${nameValue == 'getCustDupRstList'}">${pageContext.request.contextPath}/loyalty/custdi/getCustDupRstList.do</c:when>
	<c:when test="${nameValue == 'removeCustDiVal'}">${pageContext.request.contextPath}/loyalty/custdi/removeCustDiVal.do</c:when>
	<c:when test="${nameValue == 'getDupRstDetail'}">${pageContext.request.contextPath}/loyalty/custdi/getDupRstDetail.do</c:when>
	<c:when test="${nameValue == 'custMergePrcs'}">${pageContext.request.contextPath}/loyalty/custdi/custMergePrcs.do</c:when>
	<c:when test="${nameValue == 'removeCustDi'}">${pageContext.request.contextPath}/loyalty/custdi/removeCustDi.do</c:when>
	<c:when test="${nameValue == 'getMaxSeq'}">${pageContext.request.contextPath}/loyalty/custdi/getMaxSeq.do</c:when>

	<c:when test="${nameValue == 'getCouponDetail'}">${pageContext.request.contextPath}/offer/getCouponDetail.do</c:when>
	<c:when test="${nameValue == 'editCouponNew'}">${pageContext.request.contextPath}/offer/editCoupon.do</c:when>
	<c:when test="${nameValue == 'addCouponNew'}">${pageContext.request.contextPath}/offer/addCoupon.do</c:when>
	<c:when test="${nameValue == 'getCouponExtAttr'}">${pageContext.request.contextPath}/offer/getCouponExtAttr.do</c:when>
	<c:when test="${nameValue == 'getCpnStatusList'}">${pageContext.request.contextPath}/offer/getCpnStatusList.do</c:when>
	<c:when test="${nameValue == 'getMbrCpnListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCpnListNew.do</c:when>
	<c:when test="${nameValue == 'getloyCouponList'}">${pageContext.request.contextPath}/loyalty/trans/getloyCouponList.do</c:when>
    <c:when test="${nameValue == 'purTxnHistExcelList'}">${pageContext.request.contextPath}/loyalty/trans/purTxnHistExcelList.do</c:when>
	<c:when test="${nameValue == 'editCoupGuide'}">${pageContext.request.contextPath}/offer/editCoupGuide.do</c:when>
	<c:when test="${nameValue == 'insertCpnAttr'}">${pageContext.request.contextPath}/offer/insertCpnAttr.do</c:when>
	<c:when test="${nameValue == 'updateCpnAttr'}">${pageContext.request.contextPath}/offer/updateCpnAttr.do</c:when>
	<c:when test="${nameValue == 'initOfrCouponDetail'}">${pageContext.request.contextPath}/offer/initOfrCouponDetail.do</c:when>
	<c:when test="${nameValue == 'initOfrCouponGuide'}">${pageContext.request.contextPath}/offer/initOfrCouponGuide.do</c:when>
    <c:when test="${nameValue == 'purTxnNotMbrHistExcelList'}">${pageContext.request.contextPath}/loyalty/trans/purTxnNotMbrHistExcelList.do</c:when>
    <c:when test="${nameValue == 'getMbrDorHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrDorHistList.do</c:when>
    <c:when test="${nameValue == 'dropMbrListExcelDown'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrListExcelDown.do</c:when>


	<c:when test="${nameValue == 'getCouponHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getCouponHistList.do</c:when>
	<c:when test="${nameValue == 'getCouponChk'}">${pageContext.request.contextPath}/offer/getCouponChk.do</c:when>
	<c:when test="${nameValue == 'addCouponGuide'}">${pageContext.request.contextPath}/offer/addCouponGuide.do</c:when>
	<c:when test="${nameValue == 'getCouponGuide'}">${pageContext.request.contextPath}/offer/getCouponGuide.do</c:when>
	<c:when test="${nameValue == 'updateCouponGuide'}">${pageContext.request.contextPath}/offer/updateCouponGuide.do</c:when>
	<c:when test="${nameValue == 'getMbrCouponHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCouponHistList.do</c:when>
	<c:when test="${nameValue == 'getTierMgtPlcy'}">${pageContext.request.contextPath}/loyalty/member/mbr/getTierMgtPlcy.do</c:when>
	<c:when test="${nameValue == 'saveApproval'}">${pageContext.request.contextPath}/loyalty/member/mbr/saveApproval.do</c:when>
	<c:when test="${nameValue == 'modifyTiers'}">${pageContext.request.contextPath}/loyalty/member/mbr/modifyTiers.do</c:when>
	<c:when test="${nameValue == 'getTierDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/getTierDetailPop.do</c:when>
	<c:when test="${nameValue == 'getMbrCouponTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/getMbrCouponTxnHistList.do</c:when>
	<c:when test="${nameValue == 'modifyPntValidDate'}">${pageContext.request.contextPath}/loyalty/member/mbr/modifyPntValidDate.do</c:when>


	<%-- DataSet관리 --%>
	<c:when test="${nameValue == 'getDataSetMasterList'}">${pageContext.request.contextPath}/system/dataset/getDataSetMasterList.do</c:when>
	<c:when test="${nameValue == 'dataSetDetail'}">${pageContext.request.contextPath}/system/dataset/dataSetDetail.do</c:when>
	<c:when test="${nameValue == 'getDataSetDetail'}">${pageContext.request.contextPath}/system/dataset/getDataSetDetail.do</c:when>
	<c:when test="${nameValue == 'saveDataSet'}">${pageContext.request.contextPath}/system/dataset/saveDataSet.do</c:when>
	<c:when test="${nameValue == 'modifyDataSet'}">${pageContext.request.contextPath}/system/dataset/modifyDataSet.do</c:when>
	<c:when test="${nameValue == 'getDataSetItem'}">${pageContext.request.contextPath}/system/dataset/getDataSetItem.do</c:when>
	<c:when test="${nameValue == 'removeDataSet'}">${pageContext.request.contextPath}/system/dataset/removeDataSet.do</c:when>
	<c:when test="${nameValue == 'getDataSetItemDetail'}">${pageContext.request.contextPath}/system/dataset/getDataSetItemDetail.do</c:when>
	<c:when test="${nameValue == 'saveDataSetItem'}">${pageContext.request.contextPath}/system/dataset/saveDataSetItem.do</c:when>
	<c:when test="${nameValue == 'modifyDataSetItem'}">${pageContext.request.contextPath}/system/dataset/modifyDataSetItem.do</c:when>
	<c:when test="${nameValue == 'removeDataSetItem'}">${pageContext.request.contextPath}/system/dataset/removeDataSetItem.do</c:when>
    <c:when test="${nameValue == 'getSysDataSetList'}">${pageContext.request.contextPath}/system/dataset/getSysDataSetList.do</c:when>
    <c:when test="${nameValue == 'getDataItemSetList'}">${pageContext.request.contextPath}/system/dataset/getDataItemSetList.do</c:when>
    <c:when test="${nameValue == 'getSrcQuery'}">${pageContext.request.contextPath}/system/dataset/getSrcQuery.do</c:when>


	<%-- 이상거래정책--%>
	<c:when test="${nameValue == 'getBlackRuleList'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackRuleList.do</c:when>
	<c:when test="${nameValue == 'getBlackRuleMstDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackRuleMstDetail.do</c:when>
	<c:when test="${nameValue == 'saveBlackRuleDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/saveBlackRuleDetail.do</c:when>
	<c:when test="${nameValue == 'modifyBlackRuleDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/modifyBlackRuleDetail.do</c:when>
	<c:when test="${nameValue == 'getBlackRuleListTab'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackRuleListTab.do</c:when>
	<c:when test="${nameValue == 'removeBlackRule'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/removeBlackRule.do</c:when>
	<c:when test="${nameValue == 'removeBlackMst'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/removeBlackMst.do</c:when>
	<c:when test="${nameValue == 'getBlackRuleDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackRuleDetail.do</c:when>
	<c:when test="${nameValue == 'saveBlackRule'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/saveBlackRule.do</c:when>
	<c:when test="${nameValue == 'modifyBlackRule'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/modifyBlackRule.do</c:when>
	<c:when test="${nameValue == 'getBlackMbrListTab'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackMbrListTab.do</c:when>
	<c:when test="${nameValue == 'saveBlackMbr'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/saveBlackMbr.do</c:when>
	<c:when test="${nameValue == 'modifyBlackMbr'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/modifyBlackMbr.do</c:when>
	<c:when test="${nameValue == 'saveBlackMbr'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/saveBlackMbr.do</c:when>
	<c:when test="${nameValue == 'modifyBlStat'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/modifyBlStat.do</c:when>
	<c:when test="${nameValue == 'clearMaskBlackMbr'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/clearMaskBlackMbr.do</c:when>
	<c:when test="${nameValue == 'removeBlackMbr'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/removeBlackMbr.do</c:when>
	<c:when test="${nameValue == 'getBlackMbrDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/getBlackMbrDetail.do</c:when>
	
	<%-- 블랙리스트 회원 --%>
	<c:when test="${nameValue == 'getBlackMbrList'}">${pageContext.request.contextPath}/loyalty/blackListMbr/getBlackMbrList.do</c:when>
	<c:when test="${nameValue == 'saveBlackMbrDetail'}">${pageContext.request.contextPath}/loyalty/blackListMbr/saveBlackMbrDetail.do</c:when>
	<c:when test="${nameValue == 'modifyBlackMbrDetail'}">${pageContext.request.contextPath}/loyalty/blackListMbr/modifyBlackMbrDetail.do</c:when>
	<c:when test="${nameValue == 'getBlackListMbrDetail'}">${pageContext.request.contextPath}/loyalty/blackListMbr/getBlackMbrDetail.do</c:when>
	<c:when test="${nameValue == 'clearMaskBlackListMbr'}">${pageContext.request.contextPath}/loyalty/blackListMbr/clearMaskBlackMbr.do</c:when>
	<c:when test="${nameValue == 'removeBlackListMbr'}">${pageContext.request.contextPath}/loyalty/blackListMbr/removeBlackListMbr.do</c:when>
	
	
	<%-- Customer Segment --%>
	<c:when test="${nameValue == 'getCustSegMartList'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegMartList.do</c:when>
	<c:when test="${nameValue == 'getCustSegMartDetail'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegMartDetail.do</c:when>
	<c:when test="${nameValue == 'addCustSegmentMart'}">${pageContext.request.contextPath}/kepler/customerSegment/addCustSegmentMart.do</c:when>
	<c:when test="${nameValue == 'editCustSegmentMart'}">${pageContext.request.contextPath}/kepler/customerSegment/editCustSegmentMart.do</c:when>
	<c:when test="${nameValue == 'removeCustSegmentMart'}">${pageContext.request.contextPath}/kepler/customerSegment/removeCustSegmentMart.do</c:when>
	<c:when test="${nameValue == 'getLogicalCompList'}">${pageContext.request.contextPath}/kepler/customerSegment/getLogicalCompList.do</c:when>
	<c:when test="${nameValue == 'getCustSegList'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegList.do</c:when>
	<c:when test="${nameValue == 'getCustSegDetail'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegDetail.do</c:when>
	<c:when test="${nameValue == 'removeCustSegment'}">${pageContext.request.contextPath}/kepler/customerSegment/removeCustSegment.do</c:when>
	<c:when test="${nameValue == 'addCustSegment'}">${pageContext.request.contextPath}/kepler/customerSegment/addCustSegment.do</c:when>
	<c:when test="${nameValue == 'editCustSegment'}">${pageContext.request.contextPath}/kepler/customerSegment/editCustSegment.do</c:when>
	<c:when test="${nameValue == 'getCustSegStageList'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegStageList.do</c:when>
	<c:when test="${nameValue == 'getCustSegStageDetail'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegStageDetail.do</c:when>
	<c:when test="${nameValue == 'addCustSegmentStage'}">${pageContext.request.contextPath}/kepler/customerSegment/addCustSegmentStage.do</c:when>
	<c:when test="${nameValue == 'editCustSegmentStage'}">${pageContext.request.contextPath}/kepler/customerSegment/editCustSegmentStage.do</c:when>
	<c:when test="${nameValue == 'removeCustSegmentStage'}">${pageContext.request.contextPath}/kepler/customerSegment/removeCustSegmentStage.do</c:when>
    <c:when test="${nameValue == 'addCustSegmentRule'}">${pageContext.request.contextPath}/kepler/customerSegment/addCustSegmentRule.do</c:when>
    <c:when test="${nameValue == 'getCustSegRuleList'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegRuleList.do</c:when>
    <c:when test="${nameValue == 'execSegMartSql'}">${pageContext.request.contextPath}/kepler/customerSegment/execSegMartSql.do</c:when>
    <c:when test="${nameValue == 'getCustRuleListBySegId'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustRuleListBySegId.do</c:when>
    <c:when test="${nameValue == 'removeCustSegmentRule'}">${pageContext.request.contextPath}/kepler/customerSegment/removeCustSegmentRule.do</c:when>
    <c:when test="${nameValue == 'getCustSegmentList'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegmentList.do</c:when>
    <c:when test="${nameValue == 'getCustSegStageIdx'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustSegStageIdx.do</c:when>
    <c:when test="${nameValue == 'setSegmentCond'}">${pageContext.request.contextPath}/kepler/customerSegment/setSegmentCond.do</c:when>
    <c:when test="${nameValue == 'getCustRuleNmForTxt'}">${pageContext.request.contextPath}/kepler/customerSegment/getCustRuleNmForTxt.do</c:when>





    <%-- 고객군 관리 --%>
	<c:when test="${nameValue == 'getTargetGrpList'}">${pageContext.request.contextPath}/loyalty/targetgrp/getTargetGrpList.do</c:when>
	<c:when test="${nameValue == 'getTgtGrpDetail'}">${pageContext.request.contextPath}/loyalty/targetgrp/getTgtGrpDetail.do</c:when>
	<c:when test="${nameValue == 'saveTgtDetail'}">${pageContext.request.contextPath}/loyalty/targetgrp/saveTgtDetail.do</c:when>
	<c:when test="${nameValue == 'modifyTgtDetail'}">${pageContext.request.contextPath}/loyalty/targetgrp/modifyTgtDetail.do</c:when>
	<c:when test="${nameValue == 'getTgtGrpXmList'}">${pageContext.request.contextPath}/loyalty/targetgrp/getTgtGrpXmList.do</c:when>
	<c:when test="${nameValue == 'removeTgtGrpXm'}">${pageContext.request.contextPath}/loyalty/targetgrp/removeTgtGrpXm.do</c:when>
	<c:when test="${nameValue == 'removeAllTgtGrpXm'}">${pageContext.request.contextPath}/loyalty/targetgrp/removeAllTgtGrpXm.do</c:when>
	<c:when test="${nameValue == 'uploadExcelTgtGrpXm'}">${pageContext.request.contextPath}/loyalty/targetgrp/uploadExcelTgtGrpXm.do</c:when>
	<c:when test="${nameValue == 'removeTgtGrp'}">${pageContext.request.contextPath}/loyalty/targetgrp/removeTgtGrp.do</c:when>


	<%-- 상품군 관리 --%>
	<c:when test="${nameValue == 'getProdGrpList'}">${pageContext.request.contextPath}/loyalty/prodgrp/getProdGrpList.do</c:when>
	<c:when test="${nameValue == 'getProdGrpDetail'}">${pageContext.request.contextPath}/loyalty/prodgrp/getProdGrpDetail.do</c:when>
	<c:when test="${nameValue == 'saveProdGrpDetail'}">${pageContext.request.contextPath}/loyalty/prodgrp/saveProdGrpDetail.do</c:when>
	<c:when test="${nameValue == 'modifyProdGrpDetail'}">${pageContext.request.contextPath}/loyalty/prodgrp/modifyProdGrpDetail.do</c:when>
	<c:when test="${nameValue == 'getProdItemList'}">${pageContext.request.contextPath}/loyalty/prodgrp/getProdItemList.do</c:when>
	<c:when test="${nameValue == 'removeAllTProdItem'}">${pageContext.request.contextPath}/loyalty/prodgrp/removeAllTProdItem.do</c:when>
	<c:when test="${nameValue == 'removeProdItem'}">${pageContext.request.contextPath}/loyalty/prodgrp/removeProdItem.do</c:when>
	<c:when test="${nameValue == 'uploadExcelProdGrpXm'}">${pageContext.request.contextPath}/loyalty/prodgrp/uploadExcelProdGrpXm.do</c:when>
	<c:when test="${nameValue == 'addProdItem'}">${pageContext.request.contextPath}/loyalty/prodgrp/addProdItem.do</c:when>
	<c:when test="${nameValue == 'getProdCategoryList'}">${pageContext.request.contextPath}/loyalty/prodgrp/getCategoryList.do</c:when>
	<c:when test="${nameValue == 'uploadExcelCategory'}">${pageContext.request.contextPath}/loyalty/prodgrp/uploadExcelCategory.do</c:when>
	<c:when test="${nameValue == 'removeProdCategory'}">${pageContext.request.contextPath}/loyalty/prodgrp/removeCategory.do</c:when>
	<c:when test="${nameValue == 'removeAllTCategory'}">${pageContext.request.contextPath}/loyalty/prodgrp/removeAllTCategory.do</c:when>
	<c:when test="${nameValue == 'addCategory'}">${pageContext.request.contextPath}/loyalty/prodgrp/addCategory.do</c:when>
	<c:when test="${nameValue == 'removeProdGrp'}">${pageContext.request.contextPath}/loyalty/prodgrp/removeProdGrp.do</c:when>
    <c:when test="${nameValue == 'getProdListItemPop'}">${pageContext.request.contextPath}/loyalty/prodgrp/getProdListItemPop.do</c:when>
    <c:when test="${nameValue == 'addCategory'}">${pageContext.request.contextPath}/loyalty/prodgrp/addCategory.do</c:when>
    <c:when test="${nameValue == 'getGiftsPopList'}">${pageContext.request.contextPath}/loyalty/prodgrp/getGiftsPopList.do</c:when>
    

	<%-- 채널군 관리 --%>
	<c:when test="${nameValue == 'getChnlGrpList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/getChnlGrpList.do</c:when>
	<c:when test="${nameValue == 'getChnlGrpDetail'}">${pageContext.request.contextPath}/loyalty/chnlgrp/getChnlGrpDetail.do</c:when>
	<c:when test="${nameValue == 'saveChnlGrpDetail'}">${pageContext.request.contextPath}/loyalty/chnlgrp/saveChnlGrpDetail.do</c:when>
	<c:when test="${nameValue == 'modifyChnlGrpDetail'}">${pageContext.request.contextPath}/loyalty/chnlgrp/modifyChnlGrpDetail.do</c:when>
	<c:when test="${nameValue == 'getChnlItemList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/getChnlItemList.do</c:when>
	<c:when test="${nameValue == 'removeAllTChnlItem'}">${pageContext.request.contextPath}/loyalty/chnlgrp/removeAllTChnlItem.do</c:when>
	<c:when test="${nameValue == 'removeChnlItem'}">${pageContext.request.contextPath}/loyalty/chnlgrp/removeChnlItem.do</c:when>
	<c:when test="${nameValue == 'uploadExcelChnlGrpXm'}">${pageContext.request.contextPath}/loyalty/chnlgrp/uploadExcelChnlGrpXm.do</c:when>
	<c:when test="${nameValue == 'addChnlItem'}">${pageContext.request.contextPath}/loyalty/chnlgrp/addChnlItem.do</c:when>
	<c:when test="${nameValue == 'removeChnlGrp'}">${pageContext.request.contextPath}/loyalty/chnlgrp/removeChnlGrp.do</c:when>
	<c:when test="${nameValue == 'addChnlExc'}">${pageContext.request.contextPath}/loyalty/chnlgrp/addChnlExc.do</c:when>
	<c:when test="${nameValue == 'removeChnlExc'}">${pageContext.request.contextPath}/loyalty/chnlgrp/removeChnlExc.do</c:when>
	<c:when test="${nameValue == 'removeAllTChnlExc'}">${pageContext.request.contextPath}/loyalty/chnlgrp/removeAllTChnlExc.do</c:when>
	<c:when test="${nameValue == 'getChnlExcList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/getChnlExcList.do</c:when>

	<%-- 프로모션 반응 --%>
	<c:when test="${nameValue == 'getPromReactionList'}">${pageContext.request.contextPath}/loyalty/promreaction/getPromReactionList.do</c:when>
	<c:when test="${nameValue == 'getPromReactDetail'}">${pageContext.request.contextPath}/loyalty/promreaction/getPromReactDetail.do</c:when>
	<c:when test="${nameValue == 'getPromMbrCalcList'}">${pageContext.request.contextPath}/loyalty/promreaction/getPromMbrCalcList.do</c:when>
	
	<%-- 관리자 알림내역 --%>
	<c:when test="${nameValue == 'getSystemAlertList'}">${pageContext.request.contextPath}/system/alert/getSystemAlertList.do</c:when>
	<c:when test="${nameValue == 'getSystemAlertDetail'}">${pageContext.request.contextPath}/system/alert/getSystemAlertDetail.do</c:when>
	
	<%-- 사이트 관리 --%>
	<c:when test="${nameValue == 'getSystemMgtList'}">${pageContext.request.contextPath}/system/systemmgt/getSystemMgtList.do</c:when>
	<c:when test="${nameValue == 'getSystemMgtDetail'}">${pageContext.request.contextPath}/system/systemmgt/getSystemMgtDetail.do</c:when>
	<c:when test="${nameValue == 'removeSystemMgt'}">${pageContext.request.contextPath}/system/systemmgt/removeSystemMgt.do</c:when>
	<c:when test="${nameValue == 'saveSystemMgtDetail'}">${pageContext.request.contextPath}/system/systemmgt/saveSystemMgtDetail.do</c:when>
	<c:when test="${nameValue == 'modifySystemMgtDetail'}">${pageContext.request.contextPath}/system/systemmgt/modifySystemMgtDetail.do</c:when>
	
	<%-- 공지사항(BO) --%>
	<c:when test="${nameValue == 'getNoticeBoList'}">${pageContext.request.contextPath}/system/noticebo/getNoticeBoList.do</c:when>
	<c:when test="${nameValue == 'saveNoticeBo'}">${pageContext.request.contextPath}/system/noticebo/saveNoticeBo.do</c:when>
	<c:when test="${nameValue == 'modifyNoticeBo'}">${pageContext.request.contextPath}/system/noticebo/modifyNoticeBo.do</c:when>
	<c:when test="${nameValue == 'removeNoticeBo'}">${pageContext.request.contextPath}/system/noticebo/removeNoticeBo.do</c:when>
	<c:when test="${nameValue == 'getNoticeBoDetail'}">${pageContext.request.contextPath}/system/noticebo/getNoticeBoDetail.do</c:when>
	<c:when test="${nameValue == 'getRoadAddressList'}">${pageContext.request.contextPath}/system/roadaddress/getRoadAddressList.do</c:when>
	<c:when test="${nameValue == 'uploadExcelRoadAddress'}">${pageContext.request.contextPath}/system/roadaddress/uploadExcelRoadAddress.do</c:when>

	<%-- 운영정책관리 --%>
	<c:when test="${nameValue == 'getOperationPolicyList'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOperationPolicyList.do</c:when>
	<c:when test="${nameValue == 'getOperationPolicyDetail1'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOperationPolicyDetail1.do</c:when>
	<c:when test="${nameValue == 'getOperationPolicyDetail2'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOperationPolicyDetail2.do</c:when>

	<c:when test="${nameValue == 'addOperationPolicy'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/addOperationPolicy.do</c:when>
	<c:when test="${nameValue == 'updateOperationPolicy'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/updateOperationPolicy.do</c:when>
	<c:when test="${nameValue == 'deleteOperationPolicy'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/deleteOperationPolicy.do</c:when>
	<c:when test="${nameValue == 'getOperationPolicyPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOperationPolicyPop.do</c:when>
	<c:when test="${nameValue == 'getOprDtlHist'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOprDtlHist.do</c:when>
	<c:when test="${nameValue == 'getOprPlcyAttrCodeList'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOprPlcyAttrCodeList.do</c:when>

	<c:when test="${nameValue == 'addOperationPolicyDetail'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/addOperationPolicyDetail.do</c:when>
	<c:when test="${nameValue == 'updateOperationPolicyDetail'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/updateOperationPolicyDetail.do</c:when>
	<c:when test="${nameValue == 'getOprPlcyDetailBeforeUpdate'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/getOprPlcyDetailBeforeUpdate.do</c:when>
	<c:when test="${nameValue == 'deleteOperationPolicyDetail'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/deleteOperationPolicyDetail.do</c:when>

	<c:when test="${nameValue == 'checkAttrCdSingleValYnForInsert'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/checkAttrCdSingleValYnForInsert.do</c:when>
	<c:when test="${nameValue == 'checkAttrCdSingleValYnForUpdate'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/checkAttrCdSingleValYnForUpdate.do</c:when>

    
    <%-- 고객 컨텐츠 관리 --%>
    <c:when test="${nameValue == 'LoyaltyContent'}">${pageContext.request.contextPath}/system/roadaddress/LoyaltyContent.do</c:when>

    <%-- 매장용 리포트 조회이력 --%>
    <c:when test="${nameValue == 'addStoreReportHist'}">${pageContext.request.contextPath}/system/storeReport/addStoreReportHist.do</c:when>
    <c:when test="${nameValue == 'getStoreReportHistList'}">${pageContext.request.contextPath}/system/storeReport/getStoreReportHistList.do</c:when>
	<c:when test="${nameValue == 'getStoreReportHistExcelDown'}">${pageContext.request.contextPath}/system/storeReport/getStoreReportHistExcelDown.do</c:when>


	<%-- 매장용 리포트 --%>
	<c:when test="${nameValue == 'getReportBrandList'}">${pageContext.request.contextPath}/marketing/storeReport/getReportBrandList.do</c:when>
	<c:when test="${nameValue == 'getReportBrandStoreList'}">${pageContext.request.contextPath}/marketing/storeReport/getReportBrandStoreList.do</c:when>

	<c:when test="${nameValue == 'getBrandCode'}">${pageContext.request.contextPath}/marketing/storeReport/getBrandCode.do</c:when>
	<c:when test="${nameValue == 'getShopCnt'}">${pageContext.request.contextPath}/marketing/storeReport/getShopCnt.do</c:when>
	<c:when test="${nameValue == 'getProductShopCnt'}">${pageContext.request.contextPath}/marketing/storeReport/getProductShopCnt.do</c:when>
	<%-- 매장용 리포트 - 회원 비교 --%>
	<c:when test="${nameValue == 'getMbrCompareGenderChart'}">${pageContext.request.contextPath}/marketing/storeReport/getMbrCompareGenderChart.do</c:when>
	<c:when test="${nameValue == 'getMbrCompare'}">${pageContext.request.contextPath}/marketing/storeReport/getMbrCompare.do</c:when>
	<c:when test="${nameValue == 'getMbrCompareAgeGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getMbrCompareAgeGrid.do</c:when>
	<c:when test="${nameValue == 'getMbrCompareAgeChart'}">${pageContext.request.contextPath}/marketing/storeReport/getMbrCompareAgeChart.do</c:when>
	<c:when test="${nameValue == 'getMbrCompareGenderGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getMbrCompareGenderGrid.do</c:when>
	<%-- 매장용 리포트 - 상품군 비교 --%>
	<c:when test="${nameValue == 'getProductCompareSalesRatioItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareSalesRatioItemGrid.do</c:when>
	<c:when test="${nameValue == 'getProductCompareSalesRatioTopItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareSalesRatioTopItemGrid.do</c:when>
	<c:when test="${nameValue == 'getProductCompareSalesRatioLowItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareSalesRatioLowItemGrid.do</c:when>
	<c:when test="${nameValue == 'getProductCompareTopItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareTopItemGrid.do</c:when>
	<c:when test="${nameValue == 'getProductCompareClassChart'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareClassChart.do</c:when>
	<c:when test="${nameValue == 'getProductCompareCategoryChart'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareCategoryChart.do</c:when>
	<c:when test="${nameValue == 'getProductCompareTopProductGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareTopProductGrid.do</c:when>
	<c:when test="${nameValue == 'getProductCompareLowItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getProductCompareLowItemGrid.do</c:when>
	<%-- 매장용 리포트 - 재구매 & 이탈 분석 --%>
	<c:when test="${nameValue == 'getRepeatBreakawayGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayGrid.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakaway'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakaway.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakawayBrand'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayBrand.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakawayAgeGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayAgeGrid.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakawayGradeChart'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayGradeChart.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakawayGradeAgeChart'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayGradeAgeChart.do</c:when>
	<c:when test="${nameValue == 'getRepeatBreakawayGenderGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getRepeatBreakawayGenderGrid.do</c:when>
	<%-- 매장용 리포트 - 최근 12개월 매출 추이 --%>
	<c:when test="${nameValue == 'getSalesChange'}">${pageContext.request.contextPath}/marketing/storeReport/getSalesChange.do</c:when>
	<%-- 매장용 리포트 - 등급별 회원 & 매출 성과 --%>
	<c:when test="${nameValue == 'getSalesPerformance'}">${pageContext.request.contextPath}/marketing/storeReport/getSalesPerformance.do</c:when>
	<%-- 매장용 리포트 - 구간 비교 --%>
	<c:when test="${nameValue == 'getDurCmpPieChart'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpPieChart.do</c:when>
	<c:when test="${nameValue == 'getDurCmpAgeChart'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpAgeChart.do</c:when>
	<c:when test="${nameValue == 'getDurCmpPurTotalGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpPurTotalGrid.do</c:when>
	<c:when test="${nameValue == 'getDurCmpPurMbrGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpPurMbrGrid.do</c:when>
	<c:when test="${nameValue == 'getDurCmpTopItemGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpTopItemGrid.do</c:when>
	<c:when test="${nameValue == 'getDurCmpTopProductGrid'}">${pageContext.request.contextPath}/marketing/storeReport/getDurCmpTopProductGrid.do</c:when>
	<%-- 테스트용 --%>
	<c:when test="${nameValue == 'testingGo'}">${pageContext.request.contextPath}/system/roadaddress/testingGo.do</c:when>

</c:choose>