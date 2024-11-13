<%@ tag body-content="empty" pageEncoding="UTF-8" description="페이지 변경 Url 매핑 태그"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<c:set var="nameValue" value="${name}" />

<c:choose>
	<%-- error --%>
	<c:when test="${nameValue == 'errorIe6'}">${pageContext.request.contextPath}/marketing/common/errors/ie6</c:when>

	<%-- 로그인 --%>
	<c:when test="${nameValue == 'MKTLogin'}">${pageContext.request.contextPath}/login</c:when>

	<%-- 비밀번호 초기화 --%>
	<c:when test="${nameValue == 'passwordInitRequestPop'}">${pageContext.request.contextPath}/login/npopup/passwordInitRequestPop</c:when>



	<%-- 최초 로그인 시 비밀번호 변경 --%>
	<c:when test="${nameValue == 'modifyFirstLoginPwdPop'}">${pageContext.request.contextPath}/login/popup/modifyFirstLoginPwdPop</c:when>

	<%-- 로그인시 SMS 인증 --%>
	<c:when test="${nameValue == 'smsCertiPopup'}">${pageContext.request.contextPath}/login/npopup/smsCertiPopup</c:when>

	<%-- Home --%>
	<c:when test="${nameValue == 'MKTHome'}">${pageContext.request.contextPath}/home</c:when>

	<%-- 운영관리 - 권한 -------%>
	<%-- 운영관리 - 권한 --%>
	<c:when test="${nameValue == 'programDetail'}">${pageContext.request.contextPath}/marketing/manage/programDetail</c:when>
	<c:when test="${nameValue == 'programUpdate'}">${pageContext.request.contextPath}/marketing/manage/programUpdate</c:when>
	<c:when test="${nameValue == 'programList'}">${pageContext.request.contextPath}/marketiMKTHomeng/manage/programList</c:when>

	<c:when test="${nameValue == 'programListPop'}">${pageContext.request.contextPath}/marketing/manage/popup/programListPop</c:when>
	<c:when test="${nameValue == 'ownerListPop'}">${pageContext.request.contextPath}/marketing/manage/popup/ownerListPop</c:when>
	<c:when test="${nameValue == 'ownerGroupUpdate'}">${pageContext.request.contextPath}/marketing/manage/ownerGroupUpdate</c:when>
	<c:when test="${nameValue == 'ownerGroupList'}">${pageContext.request.contextPath}/marketing/manage/ownerGroupList</c:when>
	<c:when test="${nameValue == 'dataOwnerListPop'}">${pageContext.request.contextPath}/marketing/manage/popup/dataAuthOwnerListPop</c:when>
	<c:when test="${nameValue == 'deptListPop'}">${pageContext.request.contextPath}/marketing/manage/popup/deptListPop</c:when>
	<c:when test="${nameValue == 'menuListPop'}">${pageContext.request.contextPath}/marketing/manage/popup/menuListPop</c:when>
	<c:when test="${nameValue == 'menuList'}">${pageContext.request.contextPath}/marketing/manage/menuList</c:when>

	<%-- 운영관리 - 공통코드 --%>
	<c:when test="${nameValue == 'commCodeDetail'}">${pageContext.request.contextPath}/marketing/manage/commCodeDetail</c:when>
	<c:when test="${nameValue == 'commCodeAddByCopyModal'}">${pageContext.request.contextPath}/marketing/manage/popup/commCodeAddByCopyPop</c:when>

	<c:when test="${nameValue == 'camExecStatusList'}">${pageContext.request.contextPath}/marketing/executionStatus/camExecStatusList</c:when>

	<%-- 운영관리 - 공통코드 --%>
	<c:when test="${nameValue == 'commCodeExDetail'}">${pageContext.request.contextPath}/system/commcode/popup/commCodeExDetailPop</c:when>
	<c:when test="${nameValue == 'commCodeExGroupNamePop'}">${pageContext.request.contextPath}/system/commcode/popup/commCodeExGroupNamePop</c:when>
	<c:when test="${nameValue == 'commCodeExParCodePop'}">${pageContext.request.contextPath}/system/commcode/popup/commCodeExParCodePop</c:when>
	<c:when test="${nameValue == 'commCodeExDetail_tab'}">${pageContext.request.contextPath}/system/commcode/popup/commCodeExDetailPop_tab</c:when>

	<%--  타겟팅 --%>
	<c:when test="${nameValue == 'defaultInfo'}">${pageContext.request.contextPath}/marketing/targeting/include/defaultInfo</c:when>
	<c:when test="${nameValue == 'promptInfo'}">${pageContext.request.contextPath}/marketing/targeting/include/promptInfo</c:when>
	<c:when test="${nameValue == 'queryInfo'}">${pageContext.request.contextPath}/marketing/targeting/include/queryInfo</c:when>
	<c:when test="${nameValue == 'uiSettingPop'}">${pageContext.request.contextPath}/marketing/targeting/popup/uiSettingPop</c:when>
	<c:when test="${nameValue == 'segment'}">${pageContext.request.contextPath}/marketing/targeting/segment</c:when>
	<c:when test="${nameValue == 'segmentNamePop'}">${pageContext.request.contextPath}/marketing/targeting/popup/segmentNamePop</c:when>
	<c:when test="${nameValue == 'segmentLoadPop'}">${pageContext.request.contextPath}/marketing/targeting/popup/segmentLoadPop</c:when>
	<c:when test="${nameValue == 'segmentNewPop'}">${pageContext.request.contextPath}/marketing/targeting/popup/segmentNewPop</c:when>
	<c:when test="${nameValue == 'oPopupSegment'}">${pageContext.request.contextPath}/marketing/targeting/oPopup/segment</c:when>

	<%-- 퀵캠페인 --%>
	<c:when test="${nameValue == 'fileDownload'}">${pageContext.request.contextPath}/resources/fileDownload</c:when>
	<c:when test="${nameValue == 'quickCampaign'}">${pageContext.request.contextPath}/marketing/quickCampaign/quickCampaign</c:when>
	<c:when test="${nameValue == 'fileUpload'}">${pageContext.request.contextPath}/marketing/quickCampaign/include/fileUpload</c:when>

	<%-- 오퍼관리 --%>
	<c:when test="${nameValue == 'MKTOfferDetail'}">${pageContext.request.contextPath}/marketing/offer/offerDetailNew</c:when>
	<c:when test="${nameValue == 'MKTOfferDetailLoad'}">${pageContext.request.contextPath}/marketing/offer/load/offerDetailNew</c:when>
	<c:when test="${nameValue == 'MKTOfferList'}">${pageContext.request.contextPath}/marketing/offer/offerList</c:when>
	<c:when test="${nameValue == 'MKTOfferListPop'}">${pageContext.request.contextPath}/marketing/offer/popup/offerListPop</c:when>
	<c:when test="${nameValue == 'MKTFundOrgPop'}">${pageContext.request.contextPath}/marketing/offer/popup/fundOrgPop</c:when>
	<c:when test="${nameValue == 'MKTCouponPop'}">${pageContext.request.contextPath}/marketing/offer/popup/couponPop</c:when>
	<c:when test="${nameValue == 'MKTGiftCardPop'}">${pageContext.request.contextPath}/marketing/offer/popup/giftCardPop</c:when>
	<c:when test="${nameValue == 'oPopupOfferDetail'}">${pageContext.request.contextPath}/marketing/offer/oPopup/offerDetail</c:when>
	<c:when test="${nameValue == 'storeNamePop'}">${pageContext.request.contextPath}/marketing/offer/popup/storeNamePop</c:when>
	<c:when test="${nameValue == 'MKTOfferDevDetail'}">${pageContext.request.contextPath}/marketing/offer/offerDevDetailNew</c:when>
	<c:when test="${nameValue == 'coupnTmpDtlPop'}">${pageContext.request.contextPath}/marketing/offer/popup/coupnTmpDtlPop</c:when>
	<c:when test="${nameValue == 'offerPoint'}">${pageContext.request.contextPath}/marketing/offer/include/point</c:when>
	<c:when test="${nameValue == 'mCouponBox'}">${pageContext.request.contextPath}/marketing/offer/include/mCouponBox</c:when>
	<c:when test="${nameValue == 'searchChannelPop'}">${pageContext.request.contextPath}/marketing/offer/popup/searchChannelPop</c:when>
	<c:when test="${nameValue == 'searchProdPop'}">${pageContext.request.contextPath}/marketing/offer/popup/searchProdPop</c:when>
	<c:when test="${nameValue == 'useDeskPop'}">${pageContext.request.contextPath}/marketing/offer/popup/useDeskPop</c:when>
	<c:when test="${nameValue == 'gradeListPop'}">${pageContext.request.contextPath}/marketing/offer/popup/gradeListPop</c:when>
	<c:when test="${nameValue == 'gradeDtlPop'}">${pageContext.request.contextPath}/marketing/offer/popup/gradeDtlPop</c:when>
	<c:when test="${nameValue == 'productDtlPop'}">${pageContext.request.contextPath}/marketing/offer/popup/productDtlPopNew</c:when>
	<c:when test="${nameValue == 'productListPop'}">${pageContext.request.contextPath}/marketing/offer/popup/productListPop</c:when>
	<c:when test="${nameValue == 'expDividDtlPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/expDividDtlPopNew</c:when>
	<c:when test="${nameValue == 'expDividListPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/expDividListPop</c:when>
	<c:when test="${nameValue == 'expDividListPopNew'}">${pageContext.request.contextPath}/loyalty/offer/popup/expDividListPopNew</c:when>
	<c:when test="${nameValue == 'camCouponListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/camCouponListPop</c:when>
	<c:when test="${nameValue == 'parCamListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/parCamListPop</c:when>
	<c:when test="${nameValue == 'offerSearchHelp'}">${pageContext.request.contextPath}/marketing/offer/popup/offerSearchHelp</c:when>

	<%-- 오퍼관리 (NEW) --%>
	<c:when test="${nameValue == 'offerList'}">${pageContext.request.contextPath}/offer/offerList</c:when>
	<c:when test="${nameValue == 'offerDetail'}">${pageContext.request.contextPath}/offer/offerDetail</c:when>
	<c:when test="${nameValue == 'offerGroupList'}">${pageContext.request.contextPath}/offer/offerGroupList</c:when>
	<c:when test="${nameValue == 'offerGroupDetail'}">${pageContext.request.contextPath}/offer/offerGroupDetail</c:when>
	<c:when test="${nameValue == 'offerGroupChildOfferList'}">${pageContext.request.contextPath}/offer/include/offerGroupChildOfferList</c:when>
	<c:when test="${nameValue == 'offerJoinPgmList'}">${pageContext.request.contextPath}/offer/include/offerJoinPgmList</c:when>
	<c:when test="${nameValue == 'offerLoyPgmListPopup'}">${pageContext.request.contextPath}/offer/popup/offerLoyPgmListPopup</c:when>
	<c:when test="${nameValue == 'offerGroupChildOfferDetail'}">${pageContext.request.contextPath}/offer/popup/offerGroupChildOfferDetail</c:when>
	<c:when test="${nameValue == 'offerJoinChnlList'}">${pageContext.request.contextPath}/offer/include/offerJoinChnlList</c:when>
	<c:when test="${nameValue == 'offerLoyChnlListPopup'}">${pageContext.request.contextPath}/offer/popup/offerLoyChnlListPopup</c:when>
	<c:when test="${nameValue == 'offerJoinProdList'}">${pageContext.request.contextPath}/offer/include/offerJoinProdList</c:when>
	<c:when test="${nameValue == 'offerJoinProdNotList'}">${pageContext.request.contextPath}/offer/include/offerJoinProdNotList</c:when>
	<c:when test="${nameValue == 'offerLoyProdListPopup'}">${pageContext.request.contextPath}/offer/popup/offerLoyProdListPopup</c:when>
	<c:when test="${nameValue == 'offerLoyProdNotListPopup'}">${pageContext.request.contextPath}/offer/popup/offerLoyProdNotListPopup</c:when>
	<c:when test="${nameValue == 'offerJoinProdList'}">${pageContext.request.contextPath}/offer/include/offerJoinProdList</c:when>
	<c:when test="${nameValue == 'offerJoinGrpList'}">${pageContext.request.contextPath}/offer/include/offerJoinGrpList</c:when>
	<c:when test="${nameValue == 'offerCouponPoolList'}">${pageContext.request.contextPath}/offer/offerCouponPoolList</c:when>
	<c:when test="${nameValue == 'offerCpnPoolListCondPopup'}">${pageContext.request.contextPath}/offer/popup/offerCpnPoolListCondPopup</c:when>
	<c:when test="${nameValue == 'allNotUsedProdPopup'}">${pageContext.request.contextPath}/offer/popup/allNotUsedProdPopup</c:when>
	<c:when test="${nameValue == 'offerPointDetail'}">${pageContext.request.contextPath}/offer/offerPointDetail</c:when>
	<c:when test="${nameValue == 'offerPointList'}">${pageContext.request.contextPath}/offer/offerPointList</c:when>
	<c:when test="${nameValue == 'campaignCpnList'}">${pageContext.request.contextPath}/offer/campaignCpnList</c:when>
	<c:when test="${nameValue == 'offerCamDetail'}">${pageContext.request.contextPath}/offer/offerCamDetail</c:when>
	<c:when test="${nameValue == 'offerCampaignDetail'}">${pageContext.request.contextPath}/offer/offerCampaignDetail</c:when>

	<%-- 마케팅 플랜 --%>
	<c:when test="${nameValue == 'planList'}">${pageContext.request.contextPath}/marketing/plan/planList</c:when>
	<c:when test="${nameValue == 'planDtail'}">${pageContext.request.contextPath}/marketing/plan/planDetail</c:when>
	<c:when test="${nameValue == 'execDetailPop'}">${pageContext.request.contextPath}/marketing/plan/popup/execDetailPop</c:when>
	<c:when test="${nameValue == 'planOfferListPop'}">${pageContext.request.contextPath}/marketing/plan/popup/offerListPop</c:when>
	<c:when test="${nameValue == 'planContsListPop'}">${pageContext.request.contextPath}/marketing/plan/popup/contsListPop</c:when>
	<c:when test="${nameValue == 'planTgtGroupListPop'}">${pageContext.request.contextPath}/marketing/plan/popup/tgtGroupListPop</c:when>

	<%--Beacon Coupon List Pop --%>
	<c:when test="${nameValue == 'beaconCouponListPop'}">${pageContext.request.contextPath}/marketing/beacon/popup/beaconCouponListPop</c:when>

	<%-- 콘텐츠 관리 --%>
	<c:when test="${nameValue == 'MKTContentTypePop'}">${pageContext.request.contextPath}/marketing/content/popup/contentTypePop</c:when>
	<c:when test="${nameValue == 'MKTAttachImgPop'}">${pageContext.request.contextPath}/marketing/content/popup/attachImgPop</c:when>
	<c:when test="${nameValue == 'MKTsmsFormNew'}">${pageContext.request.contextPath}/marketing/content/smsFormNew</c:when>
	<c:when test="${nameValue == 'MKTemailFormNew'}">${pageContext.request.contextPath}/marketing/content/emailFormNew</c:when>
	<c:when test="${nameValue == 'MKTmmsFormNew'}">${pageContext.request.contextPath}/marketing/content/mmsFormNew</c:when>
	<c:when test="${nameValue == 'MKTSmsPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/smsPreviewPop</c:when>
	<c:when test="${nameValue == 'MKTMmsPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/mmsPreviewPop</c:when>
	<c:when test="${nameValue == 'MKTEmailPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/emailPreviewPop</c:when>
	
	<c:when test="${nameValue == 'MKTPushPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/pushPreviewPop</c:when>
	<c:when test="${nameValue == 'MKTAddImagePop'}">${pageContext.request.contextPath}/marketing/content/popup/addImagePop</c:when>
	<c:when test="${nameValue == 'MKTBarcodeListPop'}">${pageContext.request.contextPath}/marketing/content/popup/barcodeListPop</c:when>
	<c:when test="${nameValue == 'MKTLimitListPop'}">${pageContext.request.contextPath}/marketing/content/popup/LimitListPop</c:when>
	<c:when test="${nameValue == 'MKTFacebookPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/facebookPreviewPop</c:when>
	<c:when test="${nameValue == 'contentListPop'}">${pageContext.request.contextPath}/marketing/content/popup/contentListPop</c:when>
	<c:when test="${nameValue == 'MKTKakaoPreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/kakaoPreviewPop</c:when>
	<c:when test="${nameValue == 'MKTKakaoNoticePreviewPop'}">${pageContext.request.contextPath}/marketing/content/popup/kakaoNoticePreviewPop</c:when>
	<c:when test="${nameValue == 'loadMmsFormNew'}">${pageContext.request.contextPath}/marketing/content/load/mmsFormNew</c:when>
	<c:when test="${nameValue == 'loadSmsFormNew'}">${pageContext.request.contextPath}/marketing/content/load/smsFormNew</c:when>
	<c:when test="${nameValue == 'loadEmailFormNew'}">${pageContext.request.contextPath}/marketing/content/load/emailFormNew</c:when>
    <c:when test="${nameValue == 'contentListNew'}">${pageContext.request.contextPath}/marketing/content/contentListNew</c:when>
	<c:when test="${nameValue == 'frdKakaoFormNewTestBtnPop'}">${pageContext.request.contextPath}/marketing/content/popup/frdKakaoFormNewTestBtnPop</c:when>

	<c:when test="${nameValue == 'MKTWebFormNew'}">${pageContext.request.contextPath}/marketing/content/webFormNew</c:when>
	<c:when test="${nameValue == 'persnalTypePop'}">${pageContext.request.contextPath}/marketing/content/popup/persnalTypePop</c:when>

	<%-- 콘텐츠 관리 --%>
	<c:when test="${nameValue == 'MKTAddImagePopS3'}">${pageContext.request.contextPath}/marketing/content/popup/addImagePopS3</c:when>

	<%-- 채널 관리 --%>
	<c:when test="${nameValue == 'MKTContentNew'}">${pageContext.request.contextPath}</c:when>

	<%-- 스토어 --%>
	<c:when test="${nameValue == 'storeChnlListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/storeChnlListPop</c:when>

	<%-- jh.kim 멀티스테이지 --%>
	<c:when test="${nameValue == 'previousCampaignPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/previousCampaignPop</c:when>

	<%-- 조건 관리 --%>
	<c:when test="${nameValue == 'MKTScreenListPop'}">${pageContext.request.contextPath}/system/condition/popup/screenListPop</c:when>
	<c:when test="${nameValue == 'MKTTableListPop'}">${pageContext.request.contextPath}/system/condition/popup/tableListPop</c:when>
	<c:when test="${nameValue == 'MKTColumnListPop'}">${pageContext.request.contextPath}/system/condition/popup/columnListPop</c:when>
	<c:when test="${nameValue == 'MKTConditionListPop'}">${pageContext.request.contextPath}/system/condition/popup/conditionListPop</c:when>
	<c:when test="${nameValue == 'codeNameColumnsListPop'}">${pageContext.request.contextPath}/system/condition/popup/codeNameColumnsListPop</c:when>
	<c:when test="${nameValue == 'markNameColumnsListPop'}">${pageContext.request.contextPath}/system/condition/popup/markNameColumnsListPop</c:when>

	<%-- 로열티 캠페인 목록 --%>
	<c:when test="${nameValue == 'loyCampaignList'}">${pageContext.request.contextPath}/loyalty/campaign/loyCampaignListNew</c:when>
	<c:when test="${nameValue == 'campaignInfoPopNew'}">${pageContext.request.contextPath}/loyalty/campaign/campaignInfoPopNew</c:when>
	<c:when test="${nameValue == 'ofrPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/ofrPop</c:when>
	<c:when test="${nameValue == 'ofrIssPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/ofrIssPop</c:when>
	<c:when test="${nameValue == 'ofrPopVocChk'}">${pageContext.request.contextPath}/loyalty/campaign/popup/ofrPopVocChk</c:when>
	<c:when test="${nameValue == 'ofrPopPnt'}">${pageContext.request.contextPath}/loyalty/campaign/popup/ofrPopPnt</c:when>
	<c:when test="${nameValue == 'ofrPopPntReport'}">${pageContext.request.contextPath}/loyalty/campaign/popup/ofrPopPntReport</c:when>

	<%-- 캠페인 워크플로우 --%>
	<c:when test="${nameValue == 'campaignList'}">${pageContext.request.contextPath}/marketing/campaign/campaignList</c:when>
	<c:when test="${nameValue == 'campaignWorkFlow'}">${pageContext.request.contextPath}/marketing/campaign/campaignWorkFlow</c:when>
	<c:when test="${nameValue == 'campaignTempPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/campaignTempPop</c:when>
	<c:when test="${nameValue == 'programPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/programPop</c:when>
	<c:when test="${nameValue == 'budgetResourceInfoPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/budgetResourceInfoPop</c:when>
	<c:when test="${nameValue == 'benefitsPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/benefitsPop</c:when>
	<c:when test="${nameValue == 'benefitsOfferListPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/benefitsOfferListPop</c:when>
	<c:when test="${nameValue == 'campaignSubjectsPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/campaignSubjectsPop</c:when>
	<c:when test="${nameValue == 'loadApprovalDetail'}">${pageContext.request.contextPath}/onlineApproval/load/approvalDetail</c:when>

	<c:when test="${nameValue == 'roiCostDescPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/roiCostDescPop</c:when>

	<%-- 로열티 프로모션 워크플로우 --%>
	<c:when test="${nameValue == 'campaignWorkFlowLoy'}">${pageContext.request.contextPath}/loyalty/campaign/campaignWorkFlow</c:when>
	<c:when test="${nameValue == 'tgtGrpIncPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/tgtGrpIncPop</c:when>
	<c:when test="${nameValue == 'expectTgtGrpIncPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/expectTgtGrpIncPop</c:when>
	<c:when test="${nameValue == 'chnlTgtGrpPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/chnlTgtGrpPop</c:when>
	<c:when test="${nameValue == 'prodTgtGrpPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/prodTgtGrpPop</c:when>
	<c:when test="${nameValue == 'prodTgtGrpPop2'}">${pageContext.request.contextPath}/loyalty/campaign/popup/prodTgtGrpPop2</c:when>
	<c:when test="${nameValue == 'sa1RuleOfrPop'}">${pageContext.request.contextPath}/loyalty/campaign/popup/sa1RuleOfrPop</c:when>

	<%-- 캠페인 --%>
	<c:when test="${nameValue == 'campaignInfoPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/campaignInfoPop</c:when>
	<c:when test="${nameValue == 'campaignSearchHelp'}">${pageContext.request.contextPath}/marketing/campaign/popup/campaignSearchHelp</c:when>

	<%-- 프로모션 캠페인 : 다이소 신규 --%>
	<c:when test="${nameValue == 'promotionSearchHelp'}">${pageContext.request.contextPath}/loyalty/campaign/popup/promotionSearchHelp</c:when>
	<c:when test="${nameValue == 'promotionSearchHelpNew'}">${pageContext.request.contextPath}/loyalty/campaign/popup/promotionSearchHelpNew</c:when>

	<%-- 캠페인 대상자 반응결과 --%>
	<c:when test="${nameValue == 'reactionInfoList'}">${pageContext.request.contextPath}/marketing/campaignSubjects/campaignSubjectsList</c:when>
	<c:when test="${nameValue == 'channelUnsentPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/channelUnsentPop</c:when>
	<c:when test="${nameValue == 'errorHistoryPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/errorHistoryPop</c:when>

	<c:when test="${nameValue == 'campaignSubjectsList'}">${pageContext.request.contextPath}/marketing/executionStatus/camExecStatusList</c:when>
	<c:when test="${nameValue == 'camExecStatusDetail'}">${pageContext.request.contextPath}/marketing/executionStatus/camExecStatusDetail</c:when>
	<c:when test="${nameValue == 'execStatusErrorHistoryPop'}">${pageContext.request.contextPath}/marketing/executionStatus/popup/execStatusErrorHistoryPop</c:when>
	<c:when test="${nameValue == 'execStatusChannelUnsentPop'}">${pageContext.request.contextPath}/marketing/executionStatus/popup/execStatusChannelUnsentPop</c:when>

	<%-- 공통 팝업 --%>
	<c:when test="${nameValue == 'MKTContentsListPop'}">${pageContext.request.contextPath}/marketing/common/popup/contentsListPop</c:when>

	<%-- 부서 --%>
	<c:when test="${nameValue == 'MKTDeptManage'}">${pageContext.request.contextPath}/marketing/dept/deptManage</c:when>

	<%-- 전자 결제 --%>
	<c:when test="${nameValue == 'refusalPop'}">${pageContext.request.contextPath}/onlineApproval/popup/refusalPop</c:when>
	<c:when test="${nameValue == 'camListPop'}">${pageContext.request.contextPath}/onlineApproval/popup/camListPop</c:when>
	<c:when test="${nameValue == 'empListPop'}">${pageContext.request.contextPath}/onlineApproval/popup/empListPop</c:when>
	<c:when test="${nameValue == 'empRefListPop'}">${pageContext.request.contextPath}/onlineApproval/popup/empRefListPop</c:when>
	<c:when test="${nameValue == 'approvalDetail'}">${pageContext.request.contextPath}/onlineApproval/approvalDetail</c:when>
	<c:when test="${nameValue == 'approvalEmpListPop'}">${pageContext.request.contextPath}/onlineApproval/popup/approvalEmpListPop</c:when>
	<c:when test="${nameValue == 'previewCampaignPop'}">${pageContext.request.contextPath}/onlineApproval/popup/previewCampaign</c:when>
	<c:when test="${nameValue == 'approvalLineInfoPop'}">${pageContext.request.contextPath}/onlineApproval/popup/approvalLineInfoPop</c:when>
	<c:when test="${nameValue == 'approvalRejectDescPop'}">${pageContext.request.contextPath}/onlineApproval/popup/approvalRejectDescPop</c:when>

	<%-- 전자 결제 미리보기 --%>
	<c:when test="${nameValue == 'campaignReportPop'}">${pageContext.request.contextPath}/onlineApproval/popup/campaignReportPop</c:when>
	<c:when test="${nameValue == 'campaignReportHtml'}">${pageContext.request.contextPath}/onlineApproval/popup/campaignReportHtml</c:when>

	<%--개인화 속성 관리 --%>
	<c:when test="${nameValue == 'personalDetail'}">${pageContext.request.contextPath}/marketing/personal/personalDetail</c:when>
	<c:when test="${nameValue == 'personalList'}">${pageContext.request.contextPath}/marketing/personal/personalList</c:when>

	<%--피로도 관리 --%>
	<c:when test="${nameValue == 'fatigueDetail'}">${pageContext.request.contextPath}/marketing/fatigue/fatigueDetail</c:when>
	<c:when test="${nameValue == 'fatigueDetailNew'}">${pageContext.request.contextPath}/marketing/fatigue/fatigueDetailNew</c:when>
	<c:when test="${nameValue == 'fatigueList'}">${pageContext.request.contextPath}/marketing/fatigue/fatigueList</c:when>
	<c:when test="${nameValue == 'fatigueItemList'}">${pageContext.request.contextPath}/marketing/fatigue/include/fatigueItemList</c:when>
	<c:when test="${nameValue == 'fatigueItemDetailPop'}">${pageContext.request.contextPath}/marketing/fatigue/popup/fatigueItemDetailPop</c:when>

	<c:when test="${nameValue == 'targetLevel'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/targetLevel</c:when>
	<c:when test="${nameValue == 'levelJoin'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/levelJoin</c:when>
	<c:when test="${nameValue == 'targetTable'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/targetTable</c:when>
	<c:when test="${nameValue == 'targetColumn'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/targetColumn</c:when>
	<c:when test="${nameValue == 'subjectArea'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/subjectArea</c:when>
	<c:when test="${nameValue == 'subjectField'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/subjectField</c:when>
	<c:when test="${nameValue == 'joinDefinition'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/joinDefinition</c:when>
	<c:when test="${nameValue == 'joinDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/include/joinDetail</c:when>

	<%-- 외부 테이블  --%>
	<c:when test="${nameValue == 'outtargetLevel'}">${pageContext.request.contextPath}/marketing/outTable/include/targetLevel</c:when>
	<c:when test="${nameValue == 'outtargetTable'}">${pageContext.request.contextPath}/marketing/outTable/include/targetTable</c:when>
	<c:when test="${nameValue == 'outtargetColumn'}">${pageContext.request.contextPath}/marketing/outTable/include/targetColumn</c:when>
	<c:when test="${nameValue == 'outtargetLevelPop'}">${pageContext.request.contextPath}/marketing/outTable/popup/targetLevelPop</c:when>
	<c:when test="${nameValue == 'outtablePop'}">${pageContext.request.contextPath}/marketing/outTable/popup/tablePop</c:when>
	<c:when test="${nameValue == 'outcolumnPop'}">${pageContext.request.contextPath}/marketing/outTable/popup/columnPop</c:when>
	<c:when test="${nameValue == 'runChannel'}">${pageContext.request.contextPath}/marketing/outTable/include/runChannel</c:when>
	<c:when test="${nameValue == 'permission'}">${pageContext.request.contextPath}/marketing/outTable/include/permission</c:when>
	<c:when test="${nameValue == 'permissionColumnPop'}">${pageContext.request.contextPath}/marketing/outTable/popup/searchColumnPop</c:when>
	<c:when test="${nameValue == 'ftpConnect'}">${pageContext.request.contextPath}/marketing/outTable/include/ftpConnect</c:when>
	<c:when test="${nameValue == 'ftpConnectPop'}">${pageContext.request.contextPath}/marketing/outTable/popup/ftpConnectPop</c:when>
	<c:when test="${nameValue == 'emailHostPop'}">${pageContext.request.contextPath}/marketing/outTable/popup/emailHostPop</c:when>
    <c:when test="${nameValue == 'webServicePop'}">${pageContext.request.contextPath}/marketing/outTable/popup/webServicePop</c:when>

	<%-- 타겟팅 관리자  --%>
	<c:when test="${nameValue == 'targetLevelPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/targetLevelPop</c:when>
	<c:when test="${nameValue == 'tablePop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/tablePop</c:when>
	<c:when test="${nameValue == 'columnPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/columnPop</c:when>
	<c:when test="${nameValue == 'subjectDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/subjectDetail</c:when>
	<c:when test="${nameValue == 'fieldDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/fieldDetail</c:when>
	<c:when test="${nameValue == 'joinDefinitionDetail'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/joinDefinitionDetail</c:when>
	<c:when test="${nameValue == 'joinDetailPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/joinDetailPop</c:when>
	<c:when test="${nameValue == 'searchTablePop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchTablePop</c:when>
	<c:when test="${nameValue == 'searchColumnPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchColumnPop</c:when>
	<c:when test="${nameValue == 'searchJoinDefinitionPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchJoinDefinitionPop</c:when>
	<c:when test="${nameValue == 'searchFieldPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchFieldPop</c:when>
	<c:when test="${nameValue == 'levljoinDetailPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/levljoinDetailPop</c:when>
	<c:when test="${nameValue == 'searchFillterPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchFillterPop</c:when>
	<c:when test="${nameValue == 'searchAreaPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchSubjectAreaPop</c:when>
	<c:when test="${nameValue == 'searchTargetLevelPop'}">${pageContext.request.contextPath}/marketing/adminTargeting/popup/searchTargetLevelPop</c:when>

	<%-- 타겟팅 사용자 --%>
	<c:when test="${nameValue == 'userMain'}">${pageContext.request.contextPath}/marketing/userTargeting/userMain</c:when>
	<c:when test="${nameValue == 'userTargeting'}">${pageContext.request.contextPath}/marketing/userTargeting/userTargeting</c:when>
	<c:when test="${nameValue == 'segmentSearchPop'}">${pageContext.request.contextPath}/marketing/userTargeting/popup/segmentSearchPop</c:when>
	<c:when test="${nameValue == 'filterSettingPop'}">${pageContext.request.contextPath}/marketing/userTargeting/popup/filterSettingPop</c:when>
	<c:when test="${nameValue == 'segmentNewNamePop'}">${pageContext.request.contextPath}/marketing/userTargeting/popup/segmentNewNamePop</c:when>
	<c:when test="${nameValue == 'userMainLoad'}">${pageContext.request.contextPath}/marketing/userTargeting/load/userMain</c:when>
	<c:when test="${nameValue == 'userTargetingLoad'}">${pageContext.request.contextPath}/marketing/userTargeting/load/userTargeting</c:when>

	<%-- 반응정보 관리 --%>
	<c:when test="${nameValue == 'responseInfoList'}">${pageContext.request.contextPath}/system/responseInfo/responseInfoList</c:when>
	<c:when test="${nameValue == 'responseInfoDetail'}">${pageContext.request.contextPath}/system/responseInfo/responseInfoDetail</c:when>
	<c:when test="${nameValue == 'responseInfoListPop'}">${pageContext.request.contextPath}/system/responseInfo/popup/responseInfoListPop</c:when>

	<%--이미지 뷰 --%>
	<c:when test="${nameValue == 'imageView'}">${pageContext.request.contextPath}/common/imageView.do</c:when>
	<%--이미지 뷰 : AWS CloudFront --%>
	<c:when test="${nameValue == 'imageViewS3'}">${pageContext.request.contextPath}/common/imgViewS3.do?imagePath=</c:when>

	<%--Targeting Main --%>
	<c:when test="${nameValue == 'loadTargetingMain'}">${pageContext.request.contextPath}/marketing/targeting/load/targetingMain</c:when>

	<%--Targeting Main 충전소 --%>
	<c:when test="${nameValue == 'loadTargetingMainSTN'}">${pageContext.request.contextPath}/marketing/targeting/load/targetingMainSTN</c:when>

	<%-- reSendHistoryPop --%>
	<c:when test="${nameValue == 'resendHistoryPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/reSendHistoryPop</c:when>

	<%-- 어카운트 --%>
	<%-- <c:when test="${nameValue == 'accountDetail'}">${pageContext.request.contextPath}/system/account/accountDtl</c:when>
	<c:when test="${nameValue == 'accountList'}">${pageContext.request.contextPath}/system/account/accountListNew</c:when> --%>


	<%--
        Kepler URL Configuration Start
    --%>

	<%-- 공통 --%>
	<c:when test="${nameValue == 'commonLogicalComponentListPop'}">${pageContext.request.contextPath}/kepler/common/popup/logicalComponentListPop</c:when>
	<c:when test="${nameValue == 'folderDetailPop'}">${pageContext.request.contextPath}/kepler/common/popup/folderDetailPop</c:when>
	<c:when test="${nameValue == 'folderAddPop'}">${pageContext.request.contextPath}/kepler/common/popup/folderAddPop</c:when>
	<c:when test="${nameValue == 'analysisSetupPop'}">${pageContext.request.contextPath}/kepler/common/popup/analysisSetupPop</c:when>
	<c:when test="${nameValue == 'analysisSetupPromptPop'}">${pageContext.request.contextPath}/kepler/common/popup/analysisSetupPromptPop</c:when>
	<c:when test="${nameValue == 'dashboardSetupPromptPop'}">${pageContext.request.contextPath}/kepler/common/popup/dashboardSetupPromptPop</c:when>

	<%-- 대시보드 템플릿 --%>
	<c:when test="${nameValue == 'template'}">${pageContext.request.contextPath}/kepler/dashboard/include/template=</c:when>
	<c:when test="${nameValue == 'dashboardEmbedTypePop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardEmbedTypePop</c:when>
	<c:when test="${nameValue == 'dashboardSavePop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardSavePop</c:when>
	<c:when test="${nameValue == 'dashboardDetail'}">${pageContext.request.contextPath}/kepler/dashboard/dashboardDetail</c:when>
	<c:when test="${nameValue == 'dashboardPreviewPop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardPreviewPop</c:when>
	<c:when test="${nameValue == 'dashboardView'}">${pageContext.request.contextPath}/kepler/dashboard/dashboardView</c:when>
	<c:when test="${nameValue == 'dashboardListView'}">${pageContext.request.contextPath}/kepler/dashboard/dashboardListView</c:when>
	<c:when test="${nameValue == 'dashboardProgRegSetPop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardProgRegSetPop</c:when>

	<%-- 대시보드 프롬프트 --%>
	<c:when test="${nameValue == 'dashboardPromptPop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardPromptPop</c:when>
	<c:when test="${nameValue == 'dashboardPromptDetailPop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardPromptDetailPop</c:when>
	<c:when test="${nameValue == 'dashboardPromptValuePop'}">${pageContext.request.contextPath}/kepler/dashboard/popup/dashboardPromptValuePop</c:when>

	<%-- 로지컬 컴포넌트 --%>
	<c:when test="${nameValue == 'logicalComponentList'}">${pageContext.request.contextPath}/kepler/logicalComponent/logicalComponentList</c:when>
	<c:when test="${nameValue == 'logicalComponentDetail'}">${pageContext.request.contextPath}/kepler/logicalComponent/logicalComponentDetail</c:when>
	<c:when test="${nameValue == 'logicalComponentJoinSettingPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentJoinSettingPop</c:when>
	<c:when test="${nameValue == 'logicalComponentAttributeAddPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentAttributeAddPop</c:when>
	<c:when test="${nameValue == 'logicalComponentFieldSettingPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentFieldSettingPop</c:when>
	<c:when test="${nameValue == 'logicalComponentSaveAsPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentSaveAsPop</c:when>
	<c:when test="${nameValue == 'logicalComponentSqlPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentSqlPop</c:when>
	<c:when test="${nameValue == 'logicalComponentUsedSegRptListPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentUsedSegRptListPop</c:when>
	<c:when test="${nameValue == 'logicalComponentEditAttributeNamePop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentEditAttributeNamePop</c:when>
	<c:when test="${nameValue == 'logicalComponentColumnListPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentColumnListPop</c:when>
	<c:when test="${nameValue == 'logicalComponentGroupColumnSettingPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentGroupColumnSettingPop</c:when>
	<c:when test="${nameValue == 'logicalComponentListNew'}">${pageContext.request.contextPath}/kepler/logicalComponent/logicalComponentListNew</c:when>
	<c:when test="${nameValue == 'logicalComponentSelectSqlAttributeSettingPop'}">${pageContext.request.contextPath}/kepler/logicalComponent/popup/logicalComponentSelectSqlAttributeSettingPop</c:when>

	<%-- 세그먼트 --%>
	<c:when test="${nameValue == 'segmentList_KPR'}">${pageContext.request.contextPath}/kepler/segment/segmentListNew</c:when>
	<c:when test="${nameValue == 'segmentDetail_KPR'}">${pageContext.request.contextPath}/kepler/segment/segmentDetail</c:when>
	<c:when test="${nameValue == 'segmentNewPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentNewPop</c:when>
	<c:when test="${nameValue == 'segmentFilterSetPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentFilterSetPop</c:when>
	<c:when test="${nameValue == 'segmentFilterCombiPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentFilterCombiPop</c:when>
	<c:when test="${nameValue == 'targetGroupNewPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/targetGroupNewPop</c:when>
	<c:when test="${nameValue == 'segmentDetailPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentDetail</c:when>
	<c:when test="${nameValue == 'segmentNameEditPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentNameEditPop</c:when>
	<c:when test="${nameValue == 'segmentFilterSqlPop_KPR'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentFilterSqlPop</c:when>
	<c:when test="${nameValue == 'segmentDifferentSavePop'}">${pageContext.request.contextPath}/kepler/segment/popup/segmentDifferentSavePop</c:when>

	<%-- 타겟그룹 --%>
	<c:when test="${nameValue == 'targetGroupList'}">${pageContext.request.contextPath}/kepler/targetGroup/targetGroupListNew</c:when>
	<c:when test="${nameValue == 'targetGroupDetail'}">${pageContext.request.contextPath}/kepler/targetGroup/targetGroupDetail</c:when>
	<c:when test="${nameValue == 'targetGroupColumnSetPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/targetGroupColumnSetPop</c:when>
	<c:when test="${nameValue == 'targetGroupSegmentViewPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/segmentViewPop</c:when>
	<c:when test="${nameValue == 'targetGroupListPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/targetGroupListPop</c:when>
	<c:when test="${nameValue == 'targetGroupMain'}">${pageContext.request.contextPath}/kepler/targetGroup/targetGroupMain</c:when>
	<c:when test="${nameValue == 'targetGroupMainLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/targetGroupMain</c:when>
	<c:when test="${nameValue == 'targetGroupDetailLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/targetGroupDetail</c:when>
	<c:when test="${nameValue == 'targetGroupMainLoadSTN'}">${pageContext.request.contextPath}/kepler/targetGroup/load/targetGroupMainSTN</c:when>
	<c:when test="${nameValue == 'simpleTargeting'}">${pageContext.request.contextPath}/kepler/targetGroup/simpleTargeting</c:when>
	<c:when test="${nameValue == 'simpleFilterSetPopup'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/simpleFilterSetPopup</c:when>
	<c:when test="${nameValue == 'simpleTargetColumnSetPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/simpleTargetColumnSetPop</c:when>
	<c:when test="${nameValue == 'simpleTargetingListPopup'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/simpleTargetingListPopup</c:when>
	<c:when test="${nameValue == 'simpleTargetingDetailLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/simpleTargeting</c:when>

	<%-- 타겟SQL --%>
    <c:when test="${nameValue == 'targetSqlMainLoad'}"  >${pageContext.request.contextPath}/kepler/targetGroup/load/targetSqlMain</c:when>
    <c:when test="${nameValue == 'targetSqlDetail'}"    >${pageContext.request.contextPath}/kepler/targetGroup/targetSqlDetail</c:when>
    <c:when test="${nameValue == 'targetSqlDetailLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/targetSqlDetail</c:when>
    <c:when test="${nameValue == 'targetSqlPopup'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/targetSqlPopup</c:when>
    <c:when test="${nameValue == 'dbListPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/dbListPop</c:when>
    <c:when test="${nameValue == 'targetSqlListPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/targetSqlListPop</c:when>
    <c:when test="${nameValue == 'targetCafe24Detail'}"    >${pageContext.request.contextPath}/kepler/targetGroup/targetCafe24Detail</c:when>
    <c:when test="${nameValue == 'targetCafe24DetailLoad'}"    >${pageContext.request.contextPath}/kepler/targetGroup/load/targetCafe24Detail</c:when>

	<%-- 타겟Import --%>
	<c:when test="${nameValue == 'targetImportDetail'}"    >${pageContext.request.contextPath}/kepler/targetGroup/targetImportDetail</c:when>
	<c:when test="${nameValue == 'targetImportDetailLoad'}"    >${pageContext.request.contextPath}/kepler/targetGroup/load/targetImportDetail</c:when>
	<c:when test="${nameValue == 'searchMbrNoPop'}"    >${pageContext.request.contextPath}/kepler/targetGroup/popup/searchMbrNoPop</c:when>
	<c:when test="${nameValue == 'mbrExcelUploadPop'}"    >${pageContext.request.contextPath}/kepler/targetGroup/popup/mbrExcelUploadPop</c:when>

	<%-- 분석 --%>
	<c:when test="${nameValue == 'analysisList'}">${pageContext.request.contextPath}/kepler/analysis/analysisList</c:when>
	<c:when test="${nameValue == 'analysisProgRegSetPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisProgRegSetPop</c:when>
	<c:when test="${nameValue == 'custSrchDatePop'}">${pageContext.request.contextPath}/kepler/analysis/popup/custSrchDatePop</c:when>
	<c:when test="${nameValue == 'analysisDetail'}">${pageContext.request.contextPath}/kepler/analysis/analysisDetail</c:when>
	<c:when test="${nameValue == 'analysisColumnMeasurePop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisColumnMeasurePop</c:when>
	<c:when test="${nameValue == 'analysisColumnDimensionPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisColumnDimensionPop</c:when>
	<c:when test="${nameValue == 'analysisPromptPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisPromptPop</c:when>
	<c:when test="${nameValue == 'analysisPromptDateFuncPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisPromptDateFuncPop</c:when>
	<c:when test="${nameValue == 'analysisFilterPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisFilterPop</c:when>
	<c:when test="${nameValue == 'analysisFilterDetailPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisFilterDetailPop</c:when>
	<c:when test="${nameValue == 'analysisSavePop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisSavePop</c:when>
	<c:when test="${nameValue == 'analysisSaveAsPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisSaveAsPop</c:when>
	<c:when test="${nameValue == 'analysisPreviewPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisPreviewPop</c:when>
	<c:when test="${nameValue == 'analysisChartLabelDetailPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisChartLabelDetailPop</c:when>
	<c:when test="${nameValue == 'analysisExternalRequestPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisExternalRequestPop</c:when>
	<c:when test="${nameValue == 'analysisView'}">${pageContext.request.contextPath}/kepler/analysis/analysisView</c:when>
	<c:when test="${nameValue == 'analysisChartLabelFontDetailPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisChartLabelFontDetailPop</c:when>
	<c:when test="${nameValue == 'analysisTableDetailPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisTableDetailPop</c:when>

	<%-- 제거 필요 --%>
	<c:when test="${nameValue == 'analysisSqlPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/analysisSqlPop</c:when>

	<%-- 운영관리 --%>
	<c:when test="${nameValue == 'dbInform'}">${pageContext.request.contextPath}/kepler/operation/include/dbInform</c:when>
	<c:when test="${nameValue == 'dbRegistPop'}">${pageContext.request.contextPath}/kepler/operation/popup/dbInformPop</c:when>
	<c:when test="${nameValue == 'databaseUseSchemaAddPop'}">${pageContext.request.contextPath}/kepler/operation/popup/databaseUseSchemaAddPop</c:when>
	<c:when test="${nameValue == 'subjectAreaRegist'}">${pageContext.request.contextPath}/kepler/operation/include/subjectAreaRegist</c:when>
	<c:when test="${nameValue == 'subjectAreaRegistPop'}">${pageContext.request.contextPath}/kepler/operation/popup/subjectAreaRegistPop</c:when>
	<c:when test="${nameValue == 'subjectAreaService'}">${pageContext.request.contextPath}/kepler/operation/include/subjectAreaService</c:when>
	<c:when test="${nameValue == 'subjectAreaMaping'}">${pageContext.request.contextPath}/kepler/operation/include/subjectAreaMaping</c:when>
	<c:when test="${nameValue == 'subjectAreaPop'}">${pageContext.request.contextPath}/kepler/operation/popup/subjectAreaPop</c:when>
	<c:when test="${nameValue == 'tableProperDetail'}">${pageContext.request.contextPath}/kepler/operation/tableProperDetail</c:when>
	<c:when test="${nameValue == 'tableAdvancePop'}">${pageContext.request.contextPath}/kepler/operation/popup/tableAdvancePop</c:when>
	<c:when test="${nameValue == 'tableAddColPop'}">${pageContext.request.contextPath}/kepler/operation/popup/tableAddColPop</c:when>
	<c:when test="${nameValue == 'tableCreatPop'}">${pageContext.request.contextPath}/kepler/operation/popup/tableCreatPop</c:when>
	<c:when test="${nameValue == 'tableImportPop'}">${pageContext.request.contextPath}/kepler/operation/popup/tableImportPop</c:when>
	<c:when test="${nameValue == 'tableColConvertPop'}">${pageContext.request.contextPath}/kepler/operation/popup/tableColConvertPop</c:when>
	<c:when test="${nameValue == 'tableMstList'}">${pageContext.request.contextPath}/kepler/operation/tableMstList</c:when>
	<c:when test="${nameValue == 'tableMstListNew'}">${pageContext.request.contextPath}/kepler/operation/tableMstListNew</c:when>
	<c:when test="${nameValue == 'indexList'}">${pageContext.request.contextPath}/kepler/operation/include/indexList</c:when>
	<c:when test="${nameValue == 'indexColList'}">${pageContext.request.contextPath}/kepler/operation/include/indexColList</c:when>
	<c:when test="${nameValue == 'idxListPop'}">${pageContext.request.contextPath}/kepler/operation/popup/idxListPop</c:when>
	<c:when test="${nameValue == 'idxColListPop'}">${pageContext.request.contextPath}/kepler/operation/popup/idxColListPop</c:when>
	<c:when test="${nameValue == 'idxAdvancePop'}">${pageContext.request.contextPath}/kepler/operation/popup/idxAdvancePop</c:when>
	<c:when test="${nameValue == 'idxCreatPop'}">${pageContext.request.contextPath}/kepler/operation/popup/idxCreatPop</c:when>
	<c:when test="${nameValue == 'dbInfo'}">${pageContext.request.contextPath}/kepler/operation/dbInform</c:when>
	<c:when test="${nameValue == 'fileUploadPop'}">${pageContext.request.contextPath}/kepler/operation/popup/fileUploadPop</c:when>
	<c:when test="${nameValue == 'fileUpload1'}">${pageContext.request.contextPath}/kepler/operation/include/fileUpload1</c:when>
	<c:when test="${nameValue == 'fileUpload2'}">${pageContext.request.contextPath}/kepler/operation/include/fileUpload2</c:when>
	<c:when test="${nameValue == 'fileUpload3'}">${pageContext.request.contextPath}/kepler/operation/include/fileUpload3</c:when>
	<c:when test="${nameValue == 'fileUpload4'}">${pageContext.request.contextPath}/kepler/operation/include/fileUpload4</c:when>
	<c:when test="${nameValue == 'fileUpload5'}">${pageContext.request.contextPath}/kepler/operation/include/fileUpload5</c:when>
	<c:when test="${nameValue == 'uploadErrorPop'}">${pageContext.request.contextPath}/kepler/operation/popup/uploadErrorPop</c:when>
	<c:when test="${nameValue == 'anlDrillDownGroup'}">${pageContext.request.contextPath}/kepler/operation/anlDrillDownGroup</c:when>
	<c:when test="${nameValue == 'anlDrillDownGroupNamePop'}">${pageContext.request.contextPath}/kepler/operation/popup/anlDrillDownGroupNamePop</c:when>

	<%-- 외부 연결 설정 --%>
	<c:when test="${nameValue == 'externalRequestAnalysis'}">${pageContext.request.contextPath}/externalRequest/analysis</c:when>
	<c:when test="${nameValue == 'externalRequestDashboard'}">${pageContext.request.contextPath}/externalRequest/dashboard</c:when>
	<c:when test="${nameValue == 'externalAnalysisSetupPop'}">${pageContext.request.contextPath}/kepler/common/popup/analysisSetupPop</c:when>
	<c:when test="${nameValue == 'externalAnalysisSetupPromptPop'}">${pageContext.request.contextPath}/kepler/common/popup/analysisSetupPromptPop</c:when>

	<%--
        Kepler URL Configuration End
    --%>



	<%--
        Content Manager URL Configuration Start
    --%>

	<c:when test="${nameValue == 'cmsImgChooserPop'}">${pageContext.request.contextPath}/contentManager/common/popup/cmsImgChooserPop</c:when>
	<c:when test="${nameValue == 'createBbsPop'}">${pageContext.request.contextPath}/contentManager/bbs/popup/createBbsPop</c:when>
	<c:when test="${nameValue == 'bbsDetail'}">${pageContext.request.contextPath}/contentManager/bbs/bbsDetail</c:when>
	<c:when test="${nameValue == 'bbsList'}">${pageContext.request.contextPath}/contentManager/bbs/bbsList</c:when>
	<c:when test="${nameValue == 'contactDetailPop'}">${pageContext.request.contextPath}/contentManager/bbs/popup/contactDetailPop</c:when>

	<%--
        Content Manager URL Configuration End
    --%>



	<%--
        Loyalty URL Configuration Start
    --%>

	<%-- 공통 팝업 --%>
	<%-- 등급그룹조회 --%>
	<c:when test="${nameValue == 'tierGrpPop'}">${pageContext.request.contextPath}/common/view/popup/tierGrpPop</c:when>
    <%-- 등급조회 --%>
    <c:when test="${nameValue == 'tierPop'}">${pageContext.request.contextPath}/common/view/popup/tierPop</c:when>
	<%-- 채널조회 --%>
	<c:when test="${nameValue == 'chnlPop'}">${pageContext.request.contextPath}/common/view/popup/chnlPop</c:when>
	<%-- 프로그램조회 --%>
	<c:when test="${nameValue == 'pgmPop'}">${pageContext.request.contextPath}/common/view/popup/pgmPop</c:when>
	<%-- 고객조회/등록 --%>
	<c:when test="${nameValue == 'custPop'}">${pageContext.request.contextPath}/common/view/popup/custPop</c:when>
	<c:when test="${nameValue == 'custDetailPop'}">${pageContext.request.contextPath}/common/view/popup/custDetailPop</c:when>
	<%-- 법인 고객조회/등록 --%>
	<c:when test="${nameValue == 'corpCustPop'}">${pageContext.request.contextPath}/common/view/popup/corpCustPop</c:when>
	<%-- 카드 번호 조회 --%>
	<c:when test="${nameValue == 'cardBinListPop'}">${pageContext.request.contextPath}/common/view/popup/cardBinListPop</c:when>
	<%-- 우편번호 --%>
	<c:when test="${nameValue == 'postCodePop'}">${pageContext.request.contextPath}/common/view/popup/postCodePop</c:when>
	<%-- 등급 목록 조회 --%>
	<c:when test="${nameValue == 'tierGrpDtlListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierGrpDtlListPop</c:when>
	<%-- 캠페인마스터 조회 --%>
	<c:when test="${nameValue == 'camMstListPop'}">${pageContext.request.contextPath}/common/view/popup/camMstListPop</c:when>
	<%-- 카테고리 조회 --%>
	<c:when test="${nameValue == 'categoryPop'}">${pageContext.request.contextPath}/common/view/popup/categoryPop</c:when>
	<%-- 회원마스터 조회 --%>
	<c:when test="${nameValue == 'mbrMstListPop'}">${pageContext.request.contextPath}/common/view/popup/mbrMstListPop</c:when>
	<%-- 상품 조회 --%>
	<c:when test="${nameValue == 'prodPop'}">${pageContext.request.contextPath}/common/view/popup/prodPop</c:when>
	<%--포인트 상세 조회 --%>
	<c:when test="${nameValue == 'pointDtlPopList'}">${pageContext.request.contextPath}/common/view/popup/pointDtlPopList</c:when>
	<%--Voc포인트 요청 Pop --%>
	<c:when test="${nameValue == 'vocPntReq'}">${pageContext.request.contextPath}/common/view/popup/vocPntReqPop</c:when>
	<c:when test="${nameValue == 'vocPointAcrlRdmPop'}">${pageContext.request.contextPath}/loyalty/voc/popup/vocPointAcrlRdmPop</c:when>
	<c:when test="${nameValue == 'vocMemberList'}">${pageContext.request.contextPath}/loyalty/voc/vocMemberList</c:when>
	<c:when test="${nameValue == 'vocMemberDetail'}">${pageContext.request.contextPath}/loyalty/voc/vocMemberDetail</c:when>
	<%--카드 유형 조회 Pop --%>
	<c:when test="${nameValue == 'cardTypeListPop'}">${pageContext.request.contextPath}/common/view/popup/cardTypeListPop</c:when>
	<%--항목 상세 조회--%>
	<c:when test="${nameValue == 'purItemDtlPop'}">${pageContext.request.contextPath}/common/view/popup/purItemDtlPop</c:when>
	<%--결제 상세 조회--%>
	<c:when test="${nameValue == 'purPayDtlPop'}">${pageContext.request.contextPath}/common/view/popup/purPayDtlPop</c:when>
	<%--오퍼 목록 조회--%>
	<c:when test="${nameValue == 'offerPop'}">${pageContext.request.contextPath}/common/view/popup/offerPop</c:when>
	<%--오퍼 그룹 목록 조회--%>
	<c:when test="${nameValue == 'ofrgrpPop'}">${pageContext.request.contextPath}/common/view/popup/ofrgrpPop</c:when>
	<%--클럽 목록 조회--%>
	<c:when test="${nameValue == 'clubListPop'}">${pageContext.request.contextPath}/common/view/popup/clubListPop</c:when>
	<%--설문 목록 조회--%>
	<c:when test="${nameValue == 'surveyListPop'}">${pageContext.request.contextPath}/common/view/popup/surveyListPop</c:when>
	<%--스탬프/빙고 목록 조회--%>
	<c:when test="${nameValue == 'stampListPop'}">${pageContext.request.contextPath}/common/view/popup/stampListPop</c:when>
	<%--상품 멀티 select 조회--%>
	<c:when test="${nameValue == 'addProdItem'}">${pageContext.request.contextPath}/common/view/popup/addProdItem</c:when>
	<%--타겟그룹 조회--%>
	<c:when test="${nameValue == 'targetGroupPop'}">${pageContext.request.contextPath}/common/view/popup/targetGroupPop</c:when>
	<%--채널 multi select 조회--%>
	<c:when test="${nameValue == 'addChnlMultiItem'}">${pageContext.request.contextPath}/common/view/popup/addChnlMultiItem</c:when>
	<%--데이터셋 조회--%>
	<c:when test="${nameValue == 'dsPop'}">${pageContext.request.contextPath}/common/view/popup/datasetListPop</c:when>
	<%--카테고리 multi Select 조회--%>
	<c:when test="${nameValue == 'addCategory'}">${pageContext.request.contextPath}/common/view/popup/addCategory</c:when>
	<%--프로모션 조회--%>
	<c:when test="${nameValue == 'promotionSearch'}">${pageContext.request.contextPath}/common/view/popup/promotionSearch</c:when>
	<%--직원--%>
	<c:when test="${nameValue == 'empListCommonPop'}">${pageContext.request.contextPath}/common/view/popup/empListPop</c:when>
	<c:when test="${nameValue == 'pgmPopup'}">${pageContext.request.contextPath}/common/view/popup/pgmPopup</c:when>
	<%--로열티 프로그램--%>
	<c:when test="${nameValue == 'programPgmPop'}">${pageContext.request.contextPath}/common/view/popup/programPop</c:when>
	<%--사이트 관리--%>
	<c:when test="${nameValue == 'systemMgtListPop'}">${pageContext.request.contextPath}/common/view/popup/systemMgtListPop</c:when>
	<%--브랜드 조회--%>
	<c:when test="${nameValue == 'brandPop'}">${pageContext.request.contextPath}/common/view/popup/brandPop</c:when>

	<%--블랙리스트 회원 --%>
	<c:when test="${nameValue == 'blackMbrDetail'}">${pageContext.request.contextPath}/loyalty/blackListMbr/blackMbrDetail</c:when>
	<c:when test="${nameValue == 'blackListMbr'}">${pageContext.request.contextPath}/loyalty/blackListMbr/blackListMbr</c:when>


	<%--멤버쉽정책 프로그램  --%>
	<c:when test="${nameValue == 'pgmList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/pgmList</c:when>
	<c:when test="${nameValue == 'pgmDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/pgmDetail</c:when>
	<c:when test="${nameValue == 'pgmChnlList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmChnlList</c:when>
	<c:when test="${nameValue == 'pgmHistList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmHistList</c:when>
	<c:when test="${nameValue == 'pgmJoinPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmJoinPlcyList</c:when>
	<c:when test="${nameValue == 'pgmJoinPlcyDetailPop'}">${pageContext.request.contextPath}/loyalty/membership/pgm/popup/pgmJoinPlcyDetailPop</c:when>
	<c:when test="${nameValue == 'pgmPntPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmPntPlcyDetail</c:when>
	<c:when test="${nameValue == 'pgmFmlyPlcyDetail'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmFmlyPlcyDetail</c:when>
	<c:when test="${nameValue == 'pgmMgtPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmMgtPlcyList</c:when>
	<c:when test="${nameValue == 'pgmMgtPlcyDetailPop'}">${pageContext.request.contextPath}/loyalty/membership/pgm/popup/pgmMgtPlcyDetailPop</c:when>
	<c:when test="${nameValue == 'pgmClubPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmClubPlcyList</c:when>
	<c:when test="${nameValue == 'pgmChnlList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmChnlList</c:when>
	<c:when test="${nameValue == 'pgmBLPlcyList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmBLPlcyList</c:when>
	<c:when test="${nameValue == 'custItemConfList'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/custItemConfList</c:when>
	<c:when test="${nameValue == 'custItemConfPop'}">${pageContext.request.contextPath}/loyalty/membership/pgm/popup/custItemConfPop</c:when>
	<c:when test="${nameValue == 'searchItemCode'}">${pageContext.request.contextPath}/loyalty/membership/pgm/popup/searchItemCode</c:when>
	<c:when test="${nameValue == 'searchGroupCode'}">${pageContext.request.contextPath}/loyalty/membership/pgm/popup/searchGroupCode</c:when>

	<%-- 멤버쉽정책 채널 --%>
	<c:when test="${nameValue == 'chnlList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/chnlList</c:when>
	<c:when test="${nameValue == 'chnlDetail'}">${pageContext.request.contextPath}/loyalty/membership/chnl/chnlDetail</c:when>
	<c:when test="${nameValue == 'chnlAcrlHistList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/include/chnlAcrlHistList</c:when>
	<c:when test="${nameValue == 'chnlPosList'}">${pageContext.request.contextPath}/loyalty/membership/chnl/include/chnlPosList</c:when>
	<c:when test="${nameValue == 'chnlPosPop'}">${pageContext.request.contextPath}/loyalty/membership/chnl/popup/chnlPosPop</c:when>
	<c:when test="${nameValue == 'chnlDetailNewPage'}">${pageContext.request.contextPath}/loyalty/channel/chnlDetailNewPage</c:when>
	<c:when test="${nameValue == 'channelListNewPage'}">${pageContext.request.contextPath}/loyalty/channel/channelListNewPage</c:when>
	<c:when test="${nameValue == 'chnlParentPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlParentPop</c:when>
	<c:when test="${nameValue == 'chnlAddInfoDetail'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlAddInfoDetail</c:when>
	<c:when test="${nameValue == 'chnlLoyPgmListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlLoyPgmListNew</c:when>
	<c:when test="${nameValue == 'addChnlLoyPgmPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/addChnlLoyPgmPop</c:when>
	<c:when test="${nameValue == 'loyPgmListPopup'}">${pageContext.request.contextPath}/loyalty/channel/popup/loyPgmListPopup</c:when>
	<c:when test="${nameValue == 'chnlMbrRelListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlMbrRelListNew</c:when>
	<c:when test="${nameValue == 'chnlLoyPgmHistPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlLoyPgmHistPop</c:when>
	<c:when test="${nameValue == 'chnlSettleListNewPage'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlSettleListNewPage</c:when>
	<c:when test="${nameValue == 'addChnlSettlePop'}">${pageContext.request.contextPath}/loyalty/channel/popup/addChnlSettlePop</c:when>
	<c:when test="${nameValue == 'chnlLoyPgmListPopup'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlLoyPgmListPopup</c:when>
	<c:when test="${nameValue == 'chnlSettleHistPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlSettleHistPop</c:when>
	<c:when test="${nameValue == 'chnlSettleHistPopup'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlSettleHistPopup</c:when>
	<c:when test="${nameValue == 'chnlimgInfoDetailNewPage'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlimgInfoDetailNewPage</c:when>
	<c:when test="${nameValue == 'addChnlLoyImgNewPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/addChnlLoyImgNewPop</c:when>
	<c:when test="${nameValue == 'addChnlLoyImgDetail'}">${pageContext.request.contextPath}/loyalty/channel/popup/addChnlLoyImgDetail</c:when>
	<c:when test="${nameValue == 'chnlImgViewPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlImgViewPop</c:when>
	<c:when test="${nameValue == 'chnlListExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/chnlListExcelUploadPop</c:when>


	<%-- 멤버쉽정책 등급 --%>
	<c:when test="${nameValue == 'tierGroupDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierGroupDtl</c:when>
	<c:when test="${nameValue == 'tierDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierDtlPop</c:when>
	<c:when test="${nameValue == 'tierDtl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierDtl</c:when>
	<c:when test="${nameValue == 'tierChnl'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierChnl</c:when>
	<c:when test="${nameValue == 'tierUpMatrix'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierUpMatrix</c:when>
	<c:when test="${nameValue == 'tierBnftPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierBnftPop</c:when>
	<c:when test="${nameValue == 'tierUpMatrixPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierUpMatrixPop</c:when>
	<c:when test="${nameValue == 'tierRulePop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierRulePop</c:when>
	<c:when test="${nameValue == 'tierGroupListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierGroupListNew</c:when>
	<c:when test="${nameValue == 'tiersCond'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tiersCond</c:when>
	<c:when test="${nameValue == 'tiersCondDetailPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tiersCondDetailPop</c:when>

    <c:when test="${nameValue == 'prodListNew'}">${pageContext.request.contextPath}/loyalty/membership/product/prodListNew</c:when>
	<c:when test="${nameValue == 'prodDtlExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/prodDtlExcelUploadPop</c:when>
	<c:when test="${nameValue == 'prodDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/prodDtlPop</c:when>
	<c:when test="${nameValue == 'catDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/catDtlPop</c:when>
	<c:when test="${nameValue == 'brdDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/brdDtlPop</c:when>
	<c:when test="${nameValue == 'tierGroupDetailNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierGroupDetailNew</c:when>
	<c:when test="${nameValue == 'tierLoyPgmPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierLoyPgmPop</c:when>
	<c:when test="${nameValue == 'dataSetListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/dataSetListPop</c:when>
	<c:when test="${nameValue == 'tierGroupListNewPage'}">${pageContext.request.contextPath}/loyalty/membership/tiers/tierGroupListNewPage</c:when>
	<c:when test="${nameValue == 'tierListNewPage'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierListNewPage</c:when>
	<c:when test="${nameValue == 'addTierPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addTierPop</c:when>
	<c:when test="${nameValue == 'addTierBnftPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addTierBnftPop</c:when>
	<c:when test="${nameValue == 'tierBnftNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierBnftNew</c:when>
	<c:when test="${nameValue == 'tierGroupJobList'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierGroupJobList</c:when>
	<c:when test="${nameValue == 'addTierGroupJobPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addTierGroupJobPop</c:when>
	<c:when test="${nameValue == 'tierGrpDsListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierGrpDsListNew</c:when>
	<c:when test="${nameValue == 'addTierGrpDsPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addTierGrpDsPop</c:when>
	<c:when test="${nameValue == 'tierGrpDsDataSetPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierGrpDsDataSetPop</c:when>
	<c:when test="${nameValue == 'tierRuleListNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierRuleListNew</c:when>
	<c:when test="${nameValue == 'addTierRulePop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addTierRulePop</c:when>
	<c:when test="${nameValue == 'tierGrpListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierGrpListPop</c:when>
	<c:when test="${nameValue == 'dataSetItemListPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/dataSetItemListPop</c:when>
	<c:when test="${nameValue == 'tierGrpDsDataSetItemPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierGrpDsDataSetItemPop</c:when>
	<c:when test="${nameValue == 'tierGroupPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/tierGroupPop</c:when>
    <c:when test="${nameValue == 'prodCpnAvlPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/prodCpnAvlPop</c:when>

	<%-- 카드 --%>
	<c:when test="${nameValue == 'cardTypeList'}">${pageContext.request.contextPath}/loyalty/membership/card/cardTypeListNew</c:when>
	<c:when test="${nameValue == 'cardTypeDtl'}">${pageContext.request.contextPath}/loyalty/membership/card/cardTypeDtl</c:when>
	<c:when test="${nameValue == 'cardTypeCardList'}">${pageContext.request.contextPath}/loyalty/membership/card/include/cardListNew</c:when>
	<c:when test="${nameValue == 'cardTypeCardBinList'}">${pageContext.request.contextPath}/loyalty/membership/card/include/cardBinListNew</c:when>
	<c:when test="${nameValue == 'cardTypeCardNoPoolList'}">${pageContext.request.contextPath}/loyalty/membership/card/include/cardNoPoolListNew</c:when>
	<c:when test="${nameValue == 'newNumberPop'}">${pageContext.request.contextPath}/loyalty/membership/card/popup/newNumberPop</c:when>
	<c:when test="${nameValue == 'cardBinPop'}">${pageContext.request.contextPath}/loyalty/membership/card/popup/cardBinPop</c:when>
	<c:when test="${nameValue == 'genCardNoPop'}">${pageContext.request.contextPath}/loyalty/membership/card/popup/genCardNoPop</c:when>
	<c:when test="${nameValue == 'issuCardPop'}">${pageContext.request.contextPath}/loyalty/membership/card/popup/issuCardPop</c:when>

	<%-- 고객 --%>
	<c:when test="${nameValue == 'custList'}">${pageContext.request.contextPath}/loyalty/member/customer/custList</c:when>
	<c:when test="${nameValue == 'custListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/custListNew</c:when>
	<c:when test="${nameValue == 'custDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/custDetail</c:when>
	<c:when test="${nameValue == 'custAddInfoList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custAddInfoList</c:when>
	<c:when test="${nameValue == 'memberList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/memberList</c:when>
	<c:when test="${nameValue == 'custAddInfoPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custAddInfoPop</c:when>
	<c:when test="${nameValue == 'custDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/customer/custDetailNewPage</c:when>
	<c:when test="${nameValue == 'corpcustDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/customer/corpcustDetailNewPage</c:when>
	<c:when test="${nameValue == 'custListNewPage'}">${pageContext.request.contextPath}/loyalty/member/customer/custListNewPage</c:when>
	<c:when test="${nameValue == 'corpcustListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/corpcustListNew</c:when>
	<c:when test="${nameValue == 'custListNewPagePop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custListNewPagePop</c:when>
	<c:when test="${nameValue == 'custViewPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custViewPop</c:when>
    <c:when test="${nameValue == 'executivesViewPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/executivesViewPop</c:when>
	<c:when test="${nameValue == 'corpCustListNewPagePop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/corpCustListNewPagePop</c:when>
	<c:when test="${nameValue == 'custLoginHistoryListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custLoginHistoryListNew</c:when>
	<c:when test="${nameValue == 'certListPopupList'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/certListPopupList</c:when>
	<c:when test="${nameValue == 'custAgreListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custAgreListNew</c:when>
	<c:when test="${nameValue == 'agreHistpop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/agreHistpop</c:when>
	<c:when test="${nameValue == 'custUseHistListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custUseHistListNew</c:when>
	<c:when test="${nameValue == 'custWebHistListPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custWebHistListPop</c:when>
	<c:when test="${nameValue == 'custChangeHistListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custChangeHistListNew</c:when>
	<c:when test="${nameValue == 'custAlteristListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custAlteristListNew</c:when>
	<c:when test="${nameValue == 'custAppHistListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custAppHistListNew</c:when>
	<c:when test="${nameValue == 'custDetailMbrList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custDetailMbrList</c:when>
	<c:when test="${nameValue == 'webLoginInfPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/webLoginInfPop</c:when>
	<c:when test="${nameValue == 'custMbrRelList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custMbrRelList</c:when>
    <c:when test="${nameValue == 'custBranchList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custBranchList</c:when>
    <c:when test="${nameValue == 'custContractDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custContractDetail</c:when>
	<c:when test="${nameValue == 'custBranchPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custBranchPop</c:when>
	<c:when test="${nameValue == 'custBnftPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/custBnftPop</c:when>
	<c:when test="${nameValue == 'custSegmentRuleHist'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custSegmentRuleHist</c:when>
	<c:when test="${nameValue == 'corpMbrRelList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpMbrRelList</c:when>
	<c:when test="${nameValue == 'corpContractDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpContractDetail</c:when>
	<c:when test="${nameValue == 'corpBranchList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpBranchList</c:when>
	<c:when test="${nameValue == 'corpDetailMbrList'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpDetailMbrList</c:when>
	<c:when test="${nameValue == 'corpAgreListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpAgreListNew</c:when>
	<c:when test="${nameValue == 'corpUseHistListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpUseHistListNew</c:when>
	<c:when test="${nameValue == 'corpChangeHistListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/corpChangeHistListNew</c:when>
	


	<%-- 회원 --%>
	<c:when test="${nameValue == 'mbrList'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrList</c:when>
	<c:when test="${nameValue == 'mbrListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrListNew</c:when>
	<c:when test="${nameValue == 'mbrDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrDetailNew</c:when>
	<c:when test="${nameValue == 'certiOwnPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/certiOwnPop</c:when>
	<c:when test="${nameValue == 'certiByPhone'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/certiByPhone</c:when>
	<c:when test="${nameValue == 'certiByMypin'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/certiByMypin</c:when>
	<c:when test="${nameValue == 'searchCharge'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/searchCharge</c:when>
	<c:when test="${nameValue == 'addUnreceive'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addUnreceivePop</c:when>
	<c:when test="${nameValue == 'addCarHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addCarHistPop</c:when>
	<c:when test="${nameValue == 'viewMbrTaxiPntDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/viewMbrTaxiPntDetailPop</c:when>
	<c:when test="${nameValue == 'viewPwCngDataPop'}">${pageConftext.request.contextPath}/loyalty/member/mbr/popup/viewPwCngDate</c:when>
	<c:when test="${nameValue == 'transChnlSms'}">${pageContext.request.contextPath}/common/view/include/transChnlSms</c:when>
	<c:when test="${nameValue == 'transChnlEmail'}">${pageContext.request.contextPath}/common/view/include/transChnlEmail</c:when>
	<c:when test="${nameValue == 'changePhoneNumPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/changePhoneNumPop</c:when>
	<c:when test="${nameValue == 'addMbrGroupUserPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addMbrGroupUserPop</c:when>
	<c:when test="${nameValue == 'viewAvlPointPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/viewAvlPointPop</c:when>
	<c:when test="${nameValue == 'addTmAgrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addTmAgrPop</c:when>
	<c:when test="${nameValue == 'mbrDormancyPntListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrDormancyPntListPop</c:when>
	<c:when test="${nameValue == 'newCustAddPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/newCustAddPop</c:when>
	<c:when test="${nameValue == 'pgmListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pgmListPop</c:when>
	<c:when test="${nameValue == 'chnlListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/chnlListPop</c:when>
	<c:when test="${nameValue == 'adrSearchPop2'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/adrSearchPop2</c:when>
	<c:when test="${nameValue == 'storeChnlPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/storeChnlPop</c:when>
	<c:when test="${nameValue == 'corpMbrListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/corpMbrListPop</c:when>
	<c:when test="${nameValue == 'corpCustBranchListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/corpCustBranchListPop</c:when>
    <c:when test="${nameValue == 'prStoreNmPopListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/prStoreNmPopListPop</c:when>
    <c:when test="${nameValue == 'pntArclYnPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pntArclYnPop</c:when>
    <c:when test="${nameValue == 'pntRdmYnPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pntRdmYnPop</c:when>
    <c:when test="${nameValue == 'mbrListPopNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrListPopNew</c:when>
    <c:when test="${nameValue == 'pntRdmPwdYnPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pntRdmPwdYnPop</c:when>
    <c:when test="${nameValue == 'loginPwdChngPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/loginPwdChngPop</c:when>
    <c:when test="${nameValue == 'ofrPntPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/ofrPntPop</c:when>
    <c:when test="${nameValue == 'extncPamPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/extncPamPop</c:when>


	<c:when test="${nameValue == 'mbrCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCardList</c:when>
	<c:when test="${nameValue == 'mbrChnlRelList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrChnlRelList</c:when>
	<c:when test="${nameValue == 'mbrPtnTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPtnTxnHistList</c:when>
	<c:when test="${nameValue == 'mbrPurHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPurHistList</c:when>
	<c:when test="${nameValue == 'mbrCampHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCampHistList</c:when>
	<c:when test="${nameValue == 'mbrCardStatEditPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCardStatEditPop</c:when>
	<c:when test="${nameValue == 'mbrPtnBalList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPtnBalList</c:when>
	<c:when test="${nameValue == 'mbrFamilyList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrFamilyList</c:when>
	<c:when test="${nameValue == 'mbrRecommenderHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrRecommenderHistListNew</c:when>
	<c:when test="${nameValue == 'mbrLoginHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrLoginHistListNew</c:when>
	<c:when test="${nameValue == 'mbrPointListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPointListNew</c:when>
	<c:when test="${nameValue == 'mbrSurveyList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrSurveyList</c:when>

	<c:when test="${nameValue == 'addNewFmlyMbrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addNewFmlyMbrPop</c:when>
	<c:when test="${nameValue == 'searchFamilyMbr'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/searchFamilyMbr</c:when>
	<c:when test="${nameValue == 'mbrPwdEditPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrPwdEditPop</c:when>
	<c:when test="${nameValue == 'mbrNameEditPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrNameEditPop</c:when>
	<c:when test="${nameValue == 'mbrNoticeList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrNoticeList</c:when>
	<c:when test="${nameValue == 'mbrDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrDetailNewPage</c:when>
	<c:when test="${nameValue == 'martMbrDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/martMbrDetailNewPage</c:when>
	<c:when test="${nameValue == 'corpMbrDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/corpMbrDetailNewPage</c:when>
	<c:when test="${nameValue == 'buyDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/buyDetailPop</c:when>
	<c:when test="${nameValue == 'mbrMemberCardListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrMemberCardListNew</c:when>
	<c:when test="${nameValue == 'mbrBlackHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrBlackHistListNew</c:when>
	<c:when test="${nameValue == 'mbrRecommendHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrRecommendHistListNew</c:when>
	<c:when test="${nameValue == 'mbrEventHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrEventHistListNew</c:when>
	<c:when test="${nameValue == 'mbrTxnHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTxnHistListNew</c:when>
	<c:when test="${nameValue == 'mbrOnBoardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrOnBoardList</c:when>
	<c:when test="${nameValue == 'mbrAgreList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrAgreList</c:when>
	<c:when test="${nameValue == 'mbrStampList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrStampList</c:when>
	<c:when test="${nameValue == 'mbrChangeHistListNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrChangeHistListNewPage</c:when>
	<c:when test="${nameValue == 'mbrChngHistDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrChngHistDetailPop</c:when>
	<c:when test="${nameValue == 'brandNmListPop'}">${pageContext.request.contextPath}/loyalty/event/popup/brandNmListPop</c:when>
	<c:when test="${nameValue == 'categoryListPop'}">${pageContext.request.contextPath}/loyalty/event/popup/categoryListPop</c:when>
	<c:when test="${nameValue == 'excelUploadOrderPop'}">${pageContext.request.contextPath}/loyalty/event/popup/excelUploadOrderPop</c:when>
	<c:when test="${nameValue == 'addTierDtlPop'}">${pageContext.request.contextPath}/loyalty/event/popup/addTierDtlPop</c:when>
	<c:when test="${nameValue == 'modifyTierPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/modifyTierPop</c:when>
	<c:when test="${nameValue == 'tierHistListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/tierHistListPop</c:when>
	<c:when test="${nameValue == 'tierHistDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/tierHistDetailPop</c:when>
	<c:when test="${nameValue == 'mbrPointGiftPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrPointGiftPop</c:when>
	<c:when test="${nameValue == 'searchTgtMbrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/searchTgtMbrPop</c:when>
	<c:when test="${nameValue == 'mbrPointGiftForm'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPointGiftForm</c:when>
	<c:when test="${nameValue == 'mbrPointGiftHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPointGiftHist</c:when>
	<c:when test="${nameValue == 'mbrPgmChnlListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrPgmChnlListPop</c:when>
	<c:when test="${nameValue == 'mbrIntList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrIntList</c:when>
	<c:when test="${nameValue == 'mbrRdmPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrRdmPop</c:when>
	<c:when test="${nameValue == 'tierBenefitHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/tierBenefitHistPop</c:when>
	<c:when test="${nameValue == 'buyDetailPopOnline'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/buyDetailPopOnline</c:when>
	<c:when test="${nameValue == 'mbrIntSearchPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrIntSearchPop</c:when>
	<c:when test="${nameValue == 'executivesList'}">${pageContext.request.contextPath}/loyalty/member/mbr/executivesList</c:when>
	<c:when test="${nameValue == 'eMbrDetailNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/eMbrDetailNewPage</c:when>
	<c:when test="${nameValue == 'mbrDorHistPopup'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrDorHistPopup</c:when>
	<c:when test="${nameValue == 'ofrPntPopValidDateModifyPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/ofrPntPopValidDateModifyPop</c:when>
	<c:when test="${nameValue == 'mbrSurveyDetatilPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrSurveyDetatilPop</c:when>
	<c:when test="${nameValue == 'purDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/purDetailPop</c:when>

	<%-- 이상거래정책 --%>
	<c:when test="${nameValue == 'blackRuleDetail'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/blackRuleDetail</c:when>
	<c:when test="${nameValue == 'loyBlackTxnRuleList'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/loyBlackTxnRuleList</c:when>
	<c:when test="${nameValue == 'loyBlackTxnRuleList'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/loyBlackTxnRuleList</c:when>
	<c:when test="${nameValue == 'blackRuleList'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/include/blackRuleList</c:when>
	<c:when test="${nameValue == 'blackMbrList'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/include/blackMbrList</c:when>
	<c:when test="${nameValue == 'addBlackRuleDetailPop'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/popup/addBlackRuleDetailPop</c:when>
	<c:when test="${nameValue == 'addBlackMbrPopup'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/popup/addBlackMbrPopup</c:when>
	<c:when test="${nameValue == 'modifyStatCdPop'}">${pageContext.request.contextPath}/loyalty/blackTxnRule/popup/modifyStatCdPop</c:when>
	
	
	<%-- 가족화 --%>
	<c:when test="${nameValue == 'familyProcessPop'}">${pageContext.request.contextPath}/loyalty/family/popup/familyProcessPop</c:when>
	<c:when test="${nameValue == 'addNewFmlyPop'}">${pageContext.request.contextPath}/loyalty/family/popup/addNewFmlyPop</c:when>
	<c:when test="${nameValue == 'chiefMbrListPop'}">${pageContext.request.contextPath}/loyalty/family/popup/chiefMbrListPop</c:when>

	<%-- 이벤트 트리거 캠페인 --%>
	<c:when test="${nameValue == 'intactTypePop'}">${pageContext.request.contextPath}/marketing/campaign/popup/intactTypePop</c:when>
	<c:when test="${nameValue == 'campaignLgcCompListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/campaignLgcCompListPop</c:when>
	<c:when test="${nameValue == 'ruleFilterSetPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/ruleFilterSetPop</c:when>
	<c:when test="${nameValue == 'functionListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/functionListPop</c:when>
	<c:when test="${nameValue == 'planListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/planListPop</c:when>

	<c:when test="${nameValue == 'MKTEventDetailLoad'}">${pageContext.request.contextPath}/marketing/eventExecution/eventExecutuinDtl</c:when>
	<c:when test="${nameValue == 'MKTEventList'}">${pageContext.request.contextPath}/marketing/eventExecution/addBlackRuleDetailPop</c:when>


	<%-- 이벤트 기획/실행 --%>
	<c:when test="${nameValue == 'eventPlanExcution'}">${pageContext.request.contextPath}/loyalty/event/eventPlanExcution</c:when>
	<c:when test="${nameValue == 'eventPlanExcutionDetail'}">${pageContext.request.contextPath}/loyalty/event/eventPlanExcutionDetail</c:when>
	<c:when test="${nameValue == 'promotionDetailPop'}">${pageContext.request.contextPath}/loyalty/event/popup/promotionDetailPop</c:when>
	<c:when test="${nameValue == 'mbrSearchPopup'}">${pageContext.request.contextPath}/loyalty/event/popup/mbrSearchPopup</c:when>
	<c:when test="${nameValue == 'mbrApplctSearchPopup'}">${pageContext.request.contextPath}/loyalty/event/popup/mbrApplctSearchPopup</c:when>
	<c:when test="${nameValue == 'eventWinnerExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventWinnerExcelUploadPop</c:when>
	<c:when test="${nameValue == 'prodEntryExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/event/popup/prodEntryExcelUploadPop</c:when>
	<c:when test="${nameValue == 'eventImageViewPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventImageViewPop</c:when>
	<c:when test="${nameValue == 'eventPreviewTokenPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventPreviewTokenPop</c:when>
	<c:when test="${nameValue == 'imgViewPop'}">${pageContext.request.contextPath}/loyalty/event/popup/imageViewPop</c:when>
	<c:when test="${nameValue == 'evtApplicant'}">${pageContext.request.contextPath}/loyalty/event/include/evtApplicant</c:when>
	<c:when test="${nameValue == 'eventStorePreviewTokenPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventStorePreviewTokenPop</c:when>
	<c:when test="${nameValue == 'addPromPop'}">${pageContext.request.contextPath}/loyalty/event/popup/addPromPop</c:when>
	<c:when test="${nameValue == 'promotionDetailPop2'}">${pageContext.request.contextPath}/loyalty/event/popup/promotionDetailPop2</c:when>
	<c:when test="${nameValue == 'limitMbrAddPop'}">${pageContext.request.contextPath}/loyalty/event/popup/limitMbrAddPop</c:when>
	<c:when test="${nameValue == 'terminationPop'}">${pageContext.request.contextPath}/loyalty/event/popup/terminationPop</c:when>
	<c:when test="${nameValue == 'reservationDetailList'}">${pageContext.request.contextPath}/loyalty/event/reservationDetail</c:when>
	<c:when test="${nameValue == 'reservationListNew'}">${pageContext.request.contextPath}/loyalty/event/reservationListNew</c:when>
	<c:when test="${nameValue == 'winningCondPop'}">${pageContext.request.contextPath}/loyalty/event/popup/winningCondPop</c:when>
	<c:when test="${nameValue == 'limitWinMbrAddPop'}">${pageContext.request.contextPath}/loyalty/event/popup/limitWinMbrAddPop</c:when>
	<c:when test="${nameValue == 'winnerRdmPop'}">${pageContext.request.contextPath}/loyalty/event/popup/winnerRdmPop</c:when>
	<c:when test="${nameValue == 'bnftOfrPop'}">${pageContext.request.contextPath}/loyalty/event/popup/bnftOfrPop</c:when>
	<%-- 설문 --%>
	<c:when test="${nameValue == 'surveyList'}">${pageContext.request.contextPath}/loyalty/survey/surveyList</c:when>
	<c:when test="${nameValue == 'surveyDetail'}">${pageContext.request.contextPath}/loyalty/survey/surveyDetail</c:when>
	<c:when test="${nameValue == 'surveySectionList'}">${pageContext.request.contextPath}/loyalty/survey/include/surveySectionList</c:when>
	<c:when test="${nameValue == 'surveyMemberList'}">${pageContext.request.contextPath}/loyalty/survey/include/surveyMemberList</c:when>
	<c:when test="${nameValue == 'surveyOfferList'}">${pageContext.request.contextPath}/loyalty/survey/include/surveyOfferList</c:when>
	<c:when test="${nameValue == 'surveyResultList'}">${pageContext.request.contextPath}/loyalty/survey/include/surveyResultList</c:when>
	<c:when test="${nameValue == 'popupSurveySectionDetail'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveySectionDetailPop</c:when>
	<c:when test="${nameValue == 'popupSurveyItemDetail'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveyItemDetailPop</c:when>
	<c:when test="${nameValue == 'popupSurveyItemAttrDetail'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveyItemAttrDetailPop</c:when>
	<c:when test="${nameValue == 'popupSurveyOfferDetail'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveyOfferDetailPop</c:when>
	<c:when test="${nameValue == 'popupSurveyPreview'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveyPreviewPop</c:when>
	<c:when test="${nameValue == 'searchTextItemPop'}">${pageContext.request.contextPath}/loyalty/survey/popup/searchTextItemPop</c:when>
	<c:when test="${nameValue == 'surveySectionListPop'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveySectionListPop</c:when>
	<c:when test="${nameValue == 'surveyItemListPop'}">${pageContext.request.contextPath}/loyalty/survey/popup/surveyItemListPop</c:when>


	<%-- 혜택산출 계산 --%>
	<c:when test="${nameValue == 'pointCalc'}">${pageContext.request.contextPath}/loyalty/bnftCalc/pointCalc</c:when>

	<%-- 목표 및 ROI --%>
	<c:when test="${nameValue == 'roiTabMain'}">${pageContext.request.contextPath}/marketing/campaign/include/roiTabMain</c:when>
	<c:when test="${nameValue == 'goalTabMain'}">${pageContext.request.contextPath}/marketing/campaign/include/goalTabMain</c:when>
	<c:when test="${nameValue == 'roiCamExeListPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/roiCamExeListPop</c:when>

	<%-- Rule Set --%>
	<c:when test="${nameValue == 'loadRuleSetMain'}">${pageContext.request.contextPath}/loyalty/ruleSet/load/ruleSetMain</c:when>
	<c:when test="${nameValue == 'ruleSetMainRollback'}">${pageContext.request.contextPath}/loyalty/ruleSet/load/ruleSetMainRollback</c:when>

	<c:when test="${nameValue == 'grantedStandardInclude'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/grantedStandard</c:when>
	<c:when test="${nameValue == 'grantedStandardInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/grantedStandardInfoPop</c:when>
	<c:when test="${nameValue == 'tierListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/tierListPop</c:when>

	<c:when test="${nameValue == 'targetProductInclude'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/targetProduct</c:when>
	<c:when test="${nameValue == 'targetProductInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/targetProductInfoPop</c:when>
	<c:when test="${nameValue == 'loyProdListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyProdListPop</c:when>
	<c:when test="${nameValue == 'loyProdCategoryListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyProdCategoryListPop</c:when>

	<c:when test="${nameValue == 'destinationPathInclude'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/destinationPath</c:when>
	<c:when test="${nameValue == 'destinationPathInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/destinationPathInfoPop</c:when>
	<c:when test="${nameValue == 'loyBrandListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyBrandListPop</c:when>
	<c:when test="${nameValue == 'loyChannelListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyChannelListPop</c:when>

	<c:when test="${nameValue == 'paymentStandardInclude'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/paymentStandard</c:when>
	<c:when test="${nameValue == 'paymentStandardInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/paymentStandardInfoPop</c:when>

	<%-- <c:when test="${nameValue == 'ruleSetRefDtlPop'}">${pageContext.request.contextPath}/system/ruleSetRef/popup/ruleSetRefDtlPop</c:when> --%>

	<c:when test="${nameValue == 'prvBnfDtlPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/prvBnfDtlPop</c:when>


	<%-- Loyalty Offer --%>
	<c:when test="${nameValue == 'loyOfferDetailLoad'}">${pageContext.request.contextPath}/loyalty/offer/load/loyOfferDetailNew</c:when>

	<c:when test="${nameValue == 'loyOfferList'}">${pageContext.request.contextPath}/loyalty/offer/loyOfferList</c:when>
	<c:when test="${nameValue == 'loyOfferListNew'}">${pageContext.request.contextPath}/loyalty/offer/loyOfferListNew</c:when>
	<c:when test="${nameValue == 'loyOfferDetail'}">${pageContext.request.contextPath}/loyalty/offer/loyOfferDetail</c:when>
	<c:when test="${nameValue == 'loyOfferDetailNew'}">${pageContext.request.contextPath}/loyalty/offer/loyOfferDetailNew</c:when>

	<c:when test="${nameValue == 'loyOfferPntDtlInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferPntDtl</c:when>
	<c:when test="${nameValue == 'loyOfferPntDtlInfoPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/loyOfferPntDtlInfoPop</c:when>

	<c:when test="${nameValue == 'loyOfferCpnDtlInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferCpnDtl</c:when>

	<c:when test="${nameValue == 'loyOfferUseLmtChnlInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferUseLmtChnl</c:when>
	<c:when test="${nameValue == 'loyOfferUseLmtChnlInfoPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/loyOfferUseLmtChnlInfoPop</c:when>

	<c:when test="${nameValue == 'loyOfferUseLmtProdInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferUseLmtProd</c:when>
	<c:when test="${nameValue == 'loyOfferUseLmtProdInfoPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/loyOfferUseLmtProdInfoPop</c:when>

	<c:when test="${nameValue == 'loyOfferExpDividInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferExpDivid</c:when>
	<c:when test="${nameValue == 'loyOfferExpDividInfoPop'}">${pageContext.request.contextPath}/loyalty/offer/popup/loyOfferExpDividInfoPop</c:when>

	<c:when test="${nameValue == 'loyOfferRelCampaignInclude'}">${pageContext.request.contextPath}/loyalty/offer/include/loyOfferRelCampaign</c:when>

	<%-- Loyalty Simulation --%>
	<c:when test="${nameValue == 'memPop'}">${pageContext.request.contextPath}/loyalty/simulation/popup/memPop</c:when>
	<c:when test="${nameValue == 'memSearchPop'}">${pageContext.request.contextPath}/loyalty/simulation/popup/memSearchPop</c:when>

	<%-- Loyalty Unstruc --%>
	<c:when test="${nameValue == 'unstrucDetailPop'}">${pageContext.request.contextPath}/system/unstruc/popup/unstrucDetailPop</c:when>

	<%-- Loyalty Intact --%>
	<c:when test="${nameValue == 'intactDetailPop'}">${pageContext.request.contextPath}/system/intact/popup/intactDetailPop</c:when>

	<%--
        Loyalty URL Configuration End
    --%>
	<%-- Marketing Organization --%>
	<c:when test="${nameValue == 'organizationDetail'}">${pageContext.request.contextPath}/system/organization/organizationDetail</c:when>
	<c:when test="${nameValue == 'orgInfoPop'}">${pageContext.request.contextPath}/system/organization/popup/orgSearchPop</c:when>

	<%--
        Common Auth
     --%>
	<%--운영관리--%>
	<c:when test="${nameValue == 'menuList'}">${pageContext.request.contextPath}/system/auth/menuList</c:when>
	<c:when test="${nameValue == 'authMenuListPop'}">${pageContext.request.contextPath}/system/auth/popup/authMenuListPopModal</c:when>

<%-- 	<c:when test="${nameValue == 'authGroup'}">${pageContext.request.contextPath}/system/auth/authGroup</c:when> --%>

	<c:when test="${nameValue == 'dataAuth'}">${pageContext.request.contextPath}/system/auth/include/dataAuth</c:when>
	<c:when test="${nameValue == 'objectAuth'}">${pageContext.request.contextPath}/system/auth/include/objectAuth</c:when>
	<c:when test="${nameValue == 'dataAuthPopup'}">${pageContext.request.contextPath}/system/auth/popup/dataAuthModal</c:when>
	<c:when test="${nameValue == 'objectAuthPopup'}">${pageContext.request.contextPath}/system/auth/popup/objectAuthModal</c:when>
	<c:when test="${nameValue == 'modifyUserPwdPop'}">${pageContext.request.contextPath}/system/auth/popup/modifyUserPwdPop</c:when>
	<c:when test="${nameValue == 'addManageTabPop'}">${pageContext.request.contextPath}/system/auth/popup/addManageTabPop</c:when>

	<c:when test="${nameValue == 'loyPgmPop'}">${pageContext.request.contextPath}/marketing/departments/popup/loyPgmPop</c:when>

	<%--스탬프 --%>
	<c:when test="${nameValue == 'stampTxnDetail'}">${pageContext.request.contextPath}/loyalty/stamp/stampTxnDetail</c:when>
	<c:when test="${nameValue == 'stampTxnList'}">${pageContext.request.contextPath}/loyalty/stamp/stampTxnList</c:when>
	<c:when test="${nameValue == 'stampDetailPop'}">${pageContext.request.contextPath}/loyalty/stamp/popup/stampDetailPop</c:when>
	<c:when test="${nameValue == 'stmpList'}">${pageContext.request.contextPath}/loyalty/stamp/stmpList</c:when>
	<c:when test="${nameValue == 'stmpDetail'}">${pageContext.request.contextPath}/loyalty/stamp/stmpDetail</c:when>
	<c:when test="${nameValue == 'stmpItemList'}">${pageContext.request.contextPath}/loyalty/stamp/include/stmpItemList</c:when>
	<c:when test="${nameValue == 'stmpStoreList'}">${pageContext.request.contextPath}/loyalty/stamp/include/stmpStoreList</c:when>
	<c:when test="${nameValue == 'stmpMbrList'}">${pageContext.request.contextPath}/loyalty/stamp/include/stmpMbrList</c:when>
	<c:when test="${nameValue == 'stmpItemDetailPop'}">${pageContext.request.contextPath}/loyalty/stamp/popup/stmpItemDetailPop</c:when>
	<c:when test="${nameValue == 'promotionSearchHelpNewStmp'}">${pageContext.request.contextPath}/loyalty/stamp/popup/promotionSearchHelpNewStmp</c:when>
	<c:when test="${nameValue == 'stmpStorePop'}">${pageContext.request.contextPath}/loyalty/stamp/popup/stmpStorePop</c:when>
	<c:when test="${nameValue == 'stmpMbrTgtList'}">${pageContext.request.contextPath}/loyalty/stamp/include/stmpMbrTgtList</c:when>
	<c:when test="${nameValue == 'mbrSearchHelpStmp'}">${pageContext.request.contextPath}/loyalty/stamp/popup/mbrSearchHelpStmp</c:when>

	<%-- 스탬프/빙고 --%>
    <c:when test="${nameValue == 'stampBingoList'}">${pageContext.request.contextPath}/loyalty/stampBingo/stampBingoList</c:when>
    <c:when test="${nameValue == 'stampBingoDetail'}">${pageContext.request.contextPath}/loyalty/stampBingo/stampBingoDetail</c:when>
    <c:when test="${nameValue == 'stampBingoStepList'}">${pageContext.request.contextPath}/loyalty/stampBingo/include/stampBingoStepList</c:when>
    <c:when test="${nameValue == 'stampBingoStepDetailPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoStepDetailPop</c:when>
    <c:when test="${nameValue == 'stampBingoMbrList'}">${pageContext.request.contextPath}/loyalty/stampBingo/include/stampBingoMbrList</c:when>
    <c:when test="${nameValue == 'stampBingoMbrHistListPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoMbrHistListPop</c:when>
    <c:when test="${nameValue == 'stampBingoChnlList'}">${pageContext.request.contextPath}/loyalty/stampBingo/include/stampBingoChnlList</c:when>
    <c:when test="${nameValue == 'stampBingoChnlHistListPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoChnlHistListPop</c:when>
    <c:when test="${nameValue == 'stampBingoChnlListPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoChnlListPop</c:when>
    <c:when test="${nameValue == 'stampBingoBenfList'}">${pageContext.request.contextPath}/loyalty/stampBingo/include/stampBingoBenfList</c:when>
    <c:when test="${nameValue == 'stampBingoBenfDetailPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoBenfDetailPop</c:when>
    <c:when test="${nameValue == 'stampBingoStepPreviewPop'}">${pageContext.request.contextPath}/loyalty/stampBingo/popup/stampBingoStepPreviewPop</c:when>

    <%-- 게임 --%>
    <c:when test="${nameValue == 'gameList'}">${pageContext.request.contextPath}/loyalty/game/gameList</c:when>
    <c:when test="${nameValue == 'gameDetail'}">${pageContext.request.contextPath}/loyalty/game/gameDetail</c:when>
    <c:when test="${nameValue == 'gameSubDetail'}">${pageContext.request.contextPath}/loyalty/game/include/gameSubDetail</c:when>
    <c:when test="${nameValue == 'gameRuleDetailPop'}">${pageContext.request.contextPath}/loyalty/game/popup/gameRuleDetailPop</c:when>
    <c:when test="${nameValue == 'gameJoinList'}">${pageContext.request.contextPath}/loyalty/game/include/gameJoinList</c:when>
    <c:when test="${nameValue == 'gameTicketList'}">${pageContext.request.contextPath}/loyalty/game/include/gameTicketList</c:when>
    <c:when test="${nameValue == 'gameSubDetailPreview'}">${pageContext.request.contextPath}/loyalty/game/popup/gameSubDetailPreview</c:when>

	<%--포인트 --%>
	<c:when test="${nameValue == 'pointDetailPop'}">${pageContext.request.contextPath}/loyalty/trans/popup/pointDetailPop</c:when>
	<c:when test="${nameValue == 'transactionDetail'}">${pageContext.request.contextPath}/loyalty/trans/transactionDetail</c:when>
	<c:when test="${nameValue == 'transactionArchiveDetail'}">${pageContext.request.contextPath}/loyalty/trans/transactionArchiveDetail</c:when>
	<c:when test="${nameValue == 'transactionList'}">${pageContext.request.contextPath}/loyalty/trans/transactionList</c:when>
	<c:when test="${nameValue == 'transAddInfo'}">${pageContext.request.contextPath}/loyalty/trans/include/transAddInfo</c:when>
	<c:when test="${nameValue == 'transPromoList'}">${pageContext.request.contextPath}/loyalty/trans/include/transPromoList</c:when>
	<c:when test="${nameValue == 'transConsultReq'}">${pageContext.request.contextPath}/loyalty/trans/include/transConsultReq</c:when>
	<c:when test="${nameValue == 'transactionListPop'}">${pageContext.request.contextPath}/loyalty/trans/popup/transactionListPop</c:when>
	<c:when test="${nameValue == 'pntTxnItemListPop'}">${pageContext.request.contextPath}/loyalty/trans/popup/pntTxnItemListPop</c:when>
	<c:when test="${nameValue == 'loyPurHistList'}">${pageContext.request.contextPath}/loyalty/trans/loyPurHistList</c:when>


	<%-- 가맹점,단체 --%>
	<c:when test="${nameValue == 'channelSearchHelp'}">${pageContext.request.contextPath}/loyalty/channel/popup/channelSearchHelp</c:when>
	<c:when test="${nameValue == 'channelDetail'}">${pageContext.request.contextPath}/loyalty/channel/channelDetail</c:when>
	<c:when test="${nameValue == 'channelList'}">${pageContext.request.contextPath}/loyalty/channel/channelList</c:when>
	<c:when test="${nameValue == 'donationPointList'}">${pageContext.request.contextPath}/loyalty/channel/donationPointList</c:when>
	<c:when test="${nameValue == 'chnlTxnMemList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlTxnMemList</c:when>
	<c:when test="${nameValue == 'chnlSubList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlSubList</c:when>
	<c:when test="${nameValue == 'chnlAcrlInfoList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlAcrlInfoList</c:when>
	<c:when test="${nameValue == 'chnlRdmInfoList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlRdmInfoList</c:when>
	<c:when test="${nameValue == 'chnlStlInfoList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlStlInfoList</c:when>
	<c:when test="${nameValue == 'chnlAddInfo'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlAddInfo</c:when>
	<c:when test="${nameValue == 'chnlChangeHistList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlChangeHistList</c:when>
	<c:when test="${nameValue == 'chnlPointChangeHistList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlPointChangeHistList</c:when>
	<c:when test="${nameValue == 'chnlTxnHistList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlTxnHistList</c:when>
	<c:when test="${nameValue == 'chnlSubTxnHistList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlSubTxnHistList</c:when>
	<c:when test="${nameValue == 'chnlStnPntTxnList'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlStnPntTxnList</c:when>

	<%-- 채널 --%>
	<c:when test="${nameValue == 'adrSearchPop'}">${pageContext.request.contextPath}/loyalty/channel/popup/adrSearchPop</c:when>

	<%-- 회원--%>
	<c:when test="${nameValue == 'mbrSearchHelp'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrSearchHelp</c:when>
	<c:when test="${nameValue == 'dropMbrList'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrList</c:when>
	<c:when test="${nameValue == 'mbrGroupList'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrGroupList</c:when>
	<c:when test="${nameValue == 'mbrGroupDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrGroupDetail</c:when>
	<c:when test="${nameValue == 'empSearchHelp'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/empSearchHelp</c:when>
	<c:when test="${nameValue == 'mbrRenameReqList'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrRenameReqList</c:when>
	<c:when test="${nameValue == 'mbrRenameReqDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrRenameReqDetail</c:when>
	<c:when test="${nameValue == 'mbrOrangeCardList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrOrangeCardList</c:when>
	<c:when test="${nameValue == 'mbrOrangeCardDetail'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrOrangeCardDetail</c:when>
	<c:when test="${nameValue == 'mbrVocList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrVocList</c:when>
	<c:when test="${nameValue == 'mbrVocRequest'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrVocRequest</c:when>
	<c:when test="${nameValue == 'mbrPntVocRequest'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrPntVocRequest</c:when>
	<c:when test="${nameValue == 'mbrStmpTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrStmpTxnHistList</c:when>
	<c:when test="${nameValue == 'mbrStnPntTxnList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrStnPntTxnList</c:when>
	<c:when test="${nameValue == 'mbrEventHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrEventHistList</c:when>
	<c:when test="${nameValue == 'mbrInOutHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrInOutHistList</c:when>
	<c:when test="${nameValue == 'mbrInsurHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrInsurHistList</c:when>
	<c:when test="${nameValue == 'mbrTaxiHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTaxiHistList</c:when>
	<c:when test="${nameValue == 'mbrTaxiPntHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTaxiPntHistList</c:when>
	<c:when test="${nameValue == 'mbrSignInfo'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrSignInfo</c:when>
	<c:when test="${nameValue == 'addMbrGroupPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addMbrGroupPop</c:when>
	<c:when test="${nameValue == 'addchangeTaxiPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addchangeTaxiPop</c:when>
	<c:when test="${nameValue == 'mbrTmAgrHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTmAgrHistList</c:when>
	<c:when test="${nameValue == 'mbrSemiVipHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrSemiVipHistList</c:when>
	<c:when test="${nameValue == 'mbrCouponTrnsHist'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCouponTrnsHist</c:when>
	<c:when test="${nameValue == 'mbrVocPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrVocPop</c:when>
	<c:when test="${nameValue == 'dropReasonPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/dropReasonPop</c:when>
	<c:when test="${nameValue == 'mbrBlackList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrBlackList</c:when>
	<c:when test="${nameValue == 'mbrSegmentList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrSegmentList</c:when>
	<c:when test="${nameValue == 'mbrCarHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCarHistList</c:when>
	<c:when test="${nameValue == 'mbrCampaignResList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCampaignResList</c:when>
	<c:when test="${nameValue == 'mbrChangeHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrChangeHistList</c:when>
	<c:when test="${nameValue == 'addBlackListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addBlackListPop</c:when>
	<c:when test="${nameValue == 'mbrGroupUserList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrGroupUserList</c:when>
	<c:when test="${nameValue == 'mbrGroupPointTxnHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrGroupPointTxnHistList</c:when>
	<c:when test="${nameValue == 'mbrGroupPointStandard'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrGroupPointStandard</c:when>
	<c:when test="${nameValue == 'mbrGroupChangeHistList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrGroupChangeHistList</c:when>
	<c:when test="${nameValue == 'mbrChnlHistContents'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrChnlHistContents</c:when>
	<c:when test="${nameValue == 'mbrStnPntTxnDetailListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrStnPntTxnDetailListPop</c:when>
	<c:when test="${nameValue == 'mbrListNewPage'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrListNewPage</c:when>
	<c:when test="${nameValue == 'mbrCouponReiSavePop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponReiSavePop</c:when>
	<c:when test="${nameValue == 'mbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrDetailPop</c:when>
	<c:when test="${nameValue == 'corpMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/corpMbrDetailPop</c:when>
	<c:when test="${nameValue == 'dropMbrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/dropMbrPop</c:when>
	<c:when test="${nameValue == 'mbrCouponHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponHistPop</c:when>
	<c:when test="${nameValue == 'mbrCouponSavePop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponSavePop</c:when>
	<c:when test="${nameValue == 'mbrCouponSavePop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponSavePop</c:when>
	<c:when test="${nameValue == 'mbrCouponUsePop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponUsePop</c:when>
	<c:when test="${nameValue == 'addMbrIntPop'}">${pageContext.request.contextPath}/loyalty/membership/tiers/popup/addMbrIntPop</c:when>
	<c:when test="${nameValue == 'mbrCouponSearchListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponSearchListPop</c:when>
	<c:when test="${nameValue == 'custDormantList'}">${pageContext.request.contextPath}/loyalty/member/mbr/custDormantList</c:when>
	<c:when test="${nameValue == 'negativeAcc'}">${pageContext.request.contextPath}/loyalty/member/mbr/negativeAcc</c:when>
	<c:when test="${nameValue == 'custBeforeDormantList'}">${pageContext.request.contextPath}/loyalty/member/mbr/custBeforeDormantList</c:when>
	<c:when test="${nameValue == 'mbrNewMallCouponListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrNewMallCouponListPop</c:when>
	<c:when test="${nameValue == 'offerPopMbrCoupon'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/offerPopMbrCoupon</c:when>
	<c:when test="${nameValue == 'mbrCouponTxnHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrCouponTxnHistPop</c:when>



	<%-- 회원 --%>
	<c:when test="${nameValue == 'mbrDormancyPntListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrDormancyPntListNew</c:when>
	<c:when test="${nameValue == 'mbrTermsHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTermsHistListNew</c:when>
	<c:when test="${nameValue == 'mbrFamliyHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrFamliyHistListNew</c:when>
	<c:when test="${nameValue == 'editMbrPntUsePwPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/editMbrPntUsePwPop</c:when>
	<c:when test="${nameValue == 'poinTransMbrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/poinTransMbrPop</c:when>
	<c:when test="${nameValue == 'TransferPointConfirmPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/TransferPointConfirmPop</c:when>
	<c:when test="${nameValue == 'transPointHistNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/transPointHistNew</c:when>
	<c:when test="${nameValue == 'mbrPntGiftHistListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrPntGiftHistListNew</c:when>
	<c:when test="${nameValue == 'mbrStmpHistList'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrStmpHistList</c:when>
	<c:when test="${nameValue == 'stmpInfoItemList'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/stmpInfoItemList</c:when>
	<c:when test="${nameValue == 'stmpInfoStoreList'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/stmpInfoStoreList</c:when>
	<c:when test="${nameValue == 'mbrPointCouponListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrPointCouponListNew</c:when>
	<c:when test="${nameValue == 'eventListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/eventListNew</c:when>

	<c:when test="${nameValue == 'mbrStmpInfoPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrStmpInfoPop</c:when>
	<c:when test="${nameValue == 'mbrStmpHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrStmpHistPop</c:when>
	<c:when test="${nameValue == 'mbrStmpTxnHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrStmpTxnHistPop</c:when>
	<c:when test="${nameValue == 'mbrStmpBnftHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrStmpBnftHistPop</c:when>
	<c:when test="${nameValue == 'mbrPointCouponPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPointCouponPop</c:when>
	<c:when test="${nameValue == 'mbrTierListPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrTierListPop</c:when>

	<c:when test="${nameValue == 'mbrAttendEventHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrAttendEventHistListNew</c:when>
	<c:when test="${nameValue == 'mbrChnlRelListNewPage'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrChnlRelListNewPage</c:when>
	<c:when test="${nameValue == 'mbrTierListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrTierListNew</c:when>
	<c:when test="${nameValue == 'mbrCouponListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrCouponListNew</c:when>
	<c:when test="${nameValue == 'campaignExecList'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/campaignExecList</c:when>
	<c:when test="${nameValue == 'mbrAlterHistListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrAlterHistListNew</c:when>
	<c:when test="${nameValue == 'mbrCustSegmentHistListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrCustSegmentHistListNew</c:when>
	
	<c:when test="${nameValue == 'mbrMgtInfoList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrMgtInfoList</c:when>
	<c:when test="${nameValue == 'addMbrMgtInfoPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/addMbrMgtInfoPop</c:when>
	<c:when test="${nameValue == 'mbrMgtInfoHistPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrMgtInfoHistPop</c:when>
		
	<c:when test="${nameValue == 'mbrMobileLoginPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrMobileLoginPop</c:when>
	<c:when test="${nameValue == 'mbrAlterHistContsPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrAlterHistContsPop</c:when>
		

	<%-- 캠페인 일정 --%>
	<c:when test="${nameValue == 'schedulingRunOnce'}">${pageContext.request.contextPath}/marketing/campaign/include/schedulingRunOnce</c:when>
	<c:when test="${nameValue == 'schedulingRunRepeat'}">${pageContext.request.contextPath}/marketing/campaign/include/schedulingRunRepeat</c:when>
	<c:when test="${nameValue == 'schedulingRunLater'}">${pageContext.request.contextPath}/marketing/campaign/include/schedulingRunLater</c:when>
	<c:when test="${nameValue == 'schedulingRunPromotion'}">${pageContext.request.contextPath}/marketing/campaign/include/schedulingRunPromotion</c:when>


	<%-- SMS 수신거부 --%>
	<c:when test="${nameValue == 'smsRejectList'}">${pageContext.request.contextPath}/loyalty/sms/smsRejectList</c:when>
	<c:when test="${nameValue == 'smsRejectDetailPopup'}">${pageContext.request.contextPath}/loyalty/sms/popup/smsRejectDetailPopup</c:when>

	<%--수동요청 --%>
	<c:when test="${nameValue == 'manualDetail'}">${pageContext.request.contextPath}/loyalty/manual/manualDetail</c:when>
	<c:when test="${nameValue == 'manualDetailPop'}">${pageContext.request.contextPath}/loyalty/manual/popup/manualDetailPop</c:when>
	<c:when test="${nameValue == 'manualList'}">${pageContext.request.contextPath}/loyalty/manual/manualReqList</c:when>

	<%--미등록 카드 --%>
	<c:when test="${nameValue == 'cardDetailPop'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/popup/unRgstCardDetailPop</c:when>
	<c:when test="${nameValue == 'unRgstPromoDetailPop'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/popup/unRgstPromoDetailPop</c:when>
	<c:when test="${nameValue == 'unRgstExcelFileUploadPop'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/popup/unRgstExcelFileUploadPop</c:when>
	<c:when test="${nameValue == 'unRgstCardUpldItemList'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/include/unRgstCardUpldItemList</c:when>
	<c:when test="${nameValue == 'unRgstCardUploadList'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/unRgstCardUploadList</c:when>
	<c:when test="${nameValue == 'unRgstCardUploadDetail'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/unRgstCardUploadDetail</c:when>

	<%--등록 카드 --%>
	<c:when test="${nameValue == 'rgstCardDetailPop'}">${pageContext.request.contextPath}/loyalty/orangeCard/rgst/popup/rgstCardDetailPop</c:when>
	<c:when test="${nameValue == 'rgstPromoDetailPop'}">${pageContext.request.contextPath}/loyalty/orangeCard/rgst/popup/rgstPromoDetailPop</c:when>

	<%-- VOC 상담요청 --%>
	<c:when test="${nameValue == 'actyHistoryList'}">${pageContext.request.contextPath}/voc/requestConsultation/include/actyHistoryList</c:when>
	<c:when test="${nameValue == 'transactionListByRidMbr'}">${pageContext.request.contextPath}/voc/requestConsultation/include/transactionList</c:when>
	<c:when test="${nameValue == 'cardListByRidMbr'}">${pageContext.request.contextPath}/voc/requestConsultation/include/cardList</c:when>
	<c:when test="${nameValue == 'setPICPop'}">${pageContext.request.contextPath}/voc/requestConsultation/popup/setPICPop</c:when>
	<c:when test="${nameValue == 'actyHistoryMsgPop'}">${pageContext.request.contextPath}/voc/requestConsultation/popup/actyHistoryMsgPop</c:when>
	<c:when test="${nameValue == 'newActyHistoryPop'}">${pageContext.request.contextPath}/voc/requestConsultation/popup/newActyHistoryPop</c:when>
	<c:when test="${nameValue == 'newConsultPop'}">${pageContext.request.contextPath}/voc/requestConsultation/popup/newConsultPop</c:when>
	<c:when test="${nameValue == 'consultList'}">${pageContext.request.contextPath}/voc/requestConsultation/consultList</c:when>
	<c:when test="${nameValue == 'consultDetail'}">${pageContext.request.contextPath}/voc/requestConsultation/consultDetail</c:when>
	<c:when test="${nameValue == 'changeCBStatusPop'}">${pageContext.request.contextPath}/voc/call/popup/changeCBStatusPop</c:when>
	<c:when test="${nameValue == 'tmCampaignList'}">${pageContext.request.contextPath}/voc/tmCampaign/tmCampaignList</c:when>
	<c:when test="${nameValue == 'tmCampaignDetail'}">${pageContext.request.contextPath}/voc/tmCampaign/tmCampaignDetail</c:when>
	<c:when test="${nameValue == 'assignConsultantPop'}">${pageContext.request.contextPath}/voc/tmCampaign/popup/assignConsultantPop</c:when>
	<c:when test="${nameValue == 'tmCamTgtDetailPop'}">${pageContext.request.contextPath}/voc/tmCampaign/popup/tmCamTgtDetailPop</c:when>
	<c:when test="${nameValue == 'replyHistoryList'}">${pageContext.request.contextPath}/voc/requestConsultation/include/replyHistoryList</c:when>

	<%-- VOC 음성사서함 관리 --%>
	<c:when test="${nameValue == 'cardReg'}">${pageContext.request.contextPath}/voc/voiceMailBox/include/cardReg</c:when>
	<c:when test="${nameValue == 'consultReg'}">${pageContext.request.contextPath}/voc/voiceMailBox/include/consultReg</c:when>
	<c:when test="${nameValue == 'voiceMailBoxList'}">${pageContext.request.contextPath}/voc/voiceMailBox/voiceMailBoxList</c:when>
	<c:when test="${nameValue == 'callbackList'}">${pageContext.request.contextPath}/voc/call/callbackList</c:when>

	<%-- VOC IVR --%>
	<c:when test="${nameValue == 'playRecordFilePop'}">${pageContext.request.contextPath}/voc/ivr/callContact/popup/playRecordFilePop</c:when>
	<c:when test="${nameValue == 'modifyCallTransferPop'}">${pageContext.request.contextPath}/voc/ivr/callContact/popup/modifyCallTransferPop</c:when>
	<c:when test="${nameValue == 'setAlliTypePop'}">${pageContext.request.contextPath}/voc/ivr/callContact/popup/setAlliTypePop</c:when>

	<%--포인트 기준 관리 --%>
	<c:when test="${nameValue == 'standardPointDetail'}">${pageContext.request.contextPath}/loyalty/standardPoint/standardPointDetail</c:when>
	<c:when test="${nameValue == 'pointAdjustmentInfo'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointAdjustmentInfo</c:when>
	<c:when test="${nameValue == 'pointSaveListInfo'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointSaveListInfo</c:when>
	<c:when test="${nameValue == 'pointUseListInfo'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointUseListInfo</c:when>
	<c:when test="${nameValue == 'standardPointList'}">${pageContext.request.contextPath}/loyalty/standardPoint/standardPointList</c:when>
	<c:when test="${nameValue == 'pointSaveInfoPop'}">${pageContext.request.contextPath}/loyalty/standardPoint/popup/pointSaveInfoPop</c:when>
	<c:when test="${nameValue == 'pointUseInfoPop'}">${pageContext.request.contextPath}/loyalty/standardPoint/popup/pointUseInfoPop</c:when>
	<c:when test="${nameValue == 'pointAdjustInfoPop'}">${pageContext.request.contextPath}/loyalty/standardPoint/popup/pointAdjustInfoPop</c:when>
	<c:when test="${nameValue == 'pointSearchHelp'}">${pageContext.request.contextPath}/loyalty/standardPoint/popup/pointSearchHelp</c:when>


	<%--포인트 충전소 --%>
	<c:when test="${nameValue == 'pointChargeDetail'}">${pageContext.request.contextPath}/loyalty/pointCharge/pointChargeDetail</c:when>
	<c:when test="${nameValue == 'pointChargeList'}">${pageContext.request.contextPath}/loyalty/pointCharge/pointChargeList</c:when>
	<c:when test="${nameValue == 'pointChargeListPop'}">${pageContext.request.contextPath}/loyalty/pointCharge/popup/pointChargeListPop</c:when>

	<%--상품 searchHelp --%>
	<c:when test="${nameValue == 'prodSearchHelp'}">${pageContext.request.contextPath}/loyalty/product/popup/prodSearchHelp</c:when>
	<c:when test="${nameValue == 'productList'}">${pageContext.request.contextPath}/loyalty/product/productList</c:when>
	<c:when test="${nameValue == 'productDetail'}">${pageContext.request.contextPath}/loyalty/product/productDetail</c:when>
	<c:when test="${nameValue == 'productPriceList'}">${pageContext.request.contextPath}/loyalty/product/include/productPriceList</c:when>
	<c:when test="${nameValue == 'productCodeList'}">${pageContext.request.contextPath}/loyalty/product/include/productCodeList</c:when>
	<c:when test="${nameValue == 'accountCodeList'}">${pageContext.request.contextPath}/loyalty/product/include/accountCodeList</c:when>
	<c:when test="${nameValue == 'productPriceInfoPop'}">${pageContext.request.contextPath}/loyalty/product/popup/productPriceInfoPop</c:when>
	<c:when test="${nameValue == 'productCodeInfoPop'}">${pageContext.request.contextPath}/loyalty/product/popup/productCodeInfoPop</c:when>
	<%-- 승인 --%>
	<c:when test="${nameValue == 'approvalListNew'}">${pageContext.request.contextPath}/onlineApproval/approvalListNew</c:when>
	<c:when test="${nameValue == 'approvalListReqListNew'}">${pageContext.request.contextPath}/onlineApproval/approvalListReqListNew</c:when>
	<c:when test="${nameValue == 'approvalAdminList'}">${pageContext.request.contextPath}/onlineApproval/approvalAdminList</c:when>
	<c:when test="${nameValue == 'approvalAdminDetail'}">${pageContext.request.contextPath}/onlineApproval/popup/approvalAdminDetail</c:when>
	<c:when test="${nameValue == 'previewManualDetailPop'}">${pageContext.request.contextPath}/onlineApproval/popup/previewManualDetailPop</c:when>
	<c:when test="${nameValue == 'previewBatchRgstDetailPop'}">${pageContext.request.contextPath}/onlineApproval/popup/previewBatchRgstDetailPop</c:when>
	<c:when test="${nameValue == 'previewSettleDetailPop'}">${pageContext.request.contextPath}/onlineApproval/popup/previewSettleDetailPop</c:when>
	<c:when test="${nameValue == 'previewUnRgstCardDetailPop'}">${pageContext.request.contextPath}/onlineApproval/popup/previewUnRgstCardDetailPop</c:when>
	<c:when test="${nameValue == 'previewUnRgstCardUploadDetail'}">${pageContext.request.contextPath}/onlineApproval/popup/previewUnRgstCardUploadDetail</c:when>



	<%--정산 --%>
	<c:when test="${nameValue == 'insureContList'}">${pageContext.request.contextPath}/loyalty/settle/insureContList</c:when>
	<c:when test="${nameValue == 'settleHistoryDetail'}">${pageContext.request.contextPath}/loyalty/settle/settleHistoryDetail</c:when>
	<c:when test="${nameValue == 'settleHistoryList'}">${pageContext.request.contextPath}/loyalty/settle/settleHistoryList</c:when>
	<c:when test="${nameValue == 'settleLogPop'}">${pageContext.request.contextPath}/loyalty/settle/popup/settleLogPop</c:when>


	<%--정산 --%>
	<c:when test="${nameValue == 'zipCodeListPop'}">${pageContext.request.contextPath}/common/view/popup/zipCodeListPop</c:when>
	<%--정산 --%>
	<c:when test="${nameValue == 'commCodeListNew'}">${pageContext.request.contextPath}/common/view/popup/commCodeListNew</c:when>

	<%--채널전송 --%>
	<c:when test="${nameValue == 'transChnlPop'}">${pageContext.request.contextPath}/common/view/winpop/transChnlPop</c:when>
	<%--상담생성 --%>
	<c:when test="${nameValue == 'vocDetailPop'}">${pageContext.request.contextPath}/common/view/winpop/vocDetailPop</c:when>

	<%--일괄 등록 --%>
	<c:when test="${nameValue == 'upldItemList'}">${pageContext.request.contextPath}/system/batchRgst/include/upldItemList</c:when>
	<c:when test="${nameValue == 'excelFileUploadPop'}">${pageContext.request.contextPath}/system/batchRgst/popup/excelFileUploadPop</c:when>
	<c:when test="${nameValue == 'batchRgstDetail'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstDetail</c:when>
	<c:when test="${nameValue == 'batchRgstList'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstListNew</c:when>
	<c:when test="${nameValue == 'txnDetailPop'}">${pageContext.request.contextPath}/system/batchRgst/popup/txnDetailPop</c:when>	

	<%-- 일괄 등록  --%>
	<c:when test="${nameValue == 'pntBatchRgstDetailPop'}">${pageContext.request.contextPath}/system/batchRgst/popup/pntBatchRgstDetailPop</c:when>
	<c:when test="${nameValue == 'pntUpldItemList'}">${pageContext.request.contextPath}/system/batchRgst/include/pntUpldItemList</c:when>
	<c:when test="${nameValue == 'smsExcelFileUploadPop'}">${pageContext.request.contextPath}/system/batchRgst/popup/smsExcelFileUploadPop</c:when>
	<c:when test="${nameValue == 'smsUpldItemList'}">${pageContext.request.contextPath}/system/batchRgst/include/smsUpldItemList</c:when>

	<%-- 영수증 사후적립  --%>
	<c:when test="${nameValue == 'viewRcptFromB2C'}">${pageContext.request.contextPath}/system/batchRgst/popup/viewRcptFromB2C</c:when>
	<c:when test="${nameValue == 'rcptAftrRgstDetailPop'}">${pageContext.request.contextPath}/system/batchRgst/popup/rcptAftrRgstDetailPop</c:when>
	<c:when test="${nameValue == 'channelSearchHelpRcptAftr'}">${pageContext.request.contextPath}/system/batchRgst/popup/channelSearchHelp</c:when>
	<c:when test="${nameValue == 'mbrSearchHelpRcptAftr'}">${pageContext.request.contextPath}/system/batchRgst/popup/mbrSearchHelp</c:when>


	<%--간편 회원 가입 --%>
	<c:when test="${nameValue == 'simpleMemRegDetail'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/simpleMemRegDetail</c:when>
	<c:when test="${nameValue == 'simpleMemRegList'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/simpleMemRegList</c:when>
	<c:when test="${nameValue == 'authorizationPop'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/popup/authorizationPop</c:when>
	<c:when test="${nameValue == 'moblieAuthorization'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/include/moblieAuthorization</c:when>
	<c:when test="${nameValue == 'mypinAuthorization'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/include/mypinAuthorization</c:when>
	<c:when test="${nameValue == 'memRegCertiOwnPop'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/popup/memRegCertiOwnPop</c:when>
	<c:when test="${nameValue == 'memRegCertiByMypin'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/include/memRegCertiByMypin</c:when>
	<c:when test="${nameValue == 'memRegCertiByPhone'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/include/memRegCertiByPhone</c:when>
	<c:when test="${nameValue == 'memRegInputCertiCodePop'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/popup/memRegInputCertiCodePop</c:when>

	<%-- 충전소 캠페인 --%>
	<c:when test="${nameValue == 'stnCampaignList'}">${pageContext.request.contextPath}/marketing/chargingStation/stnCampaignList</c:when>
	<c:when test="${nameValue == 'stnCampaignDetail'}">${pageContext.request.contextPath}/marketing/chargingStation/stnCampaignDetail</c:when>
	<c:when test="${nameValue == 'stnApprovalPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnApprovalPopup</c:when>
	<c:when test="${nameValue == 'stnCampaignSubjectsDetail'}">${pageContext.request.contextPath}/marketing/chargingStation/stnCampaignSubjectsDetail</c:when>

	<%-- 충전소 캠페인 Targeting --%>
	<c:when test="${nameValue == 'stnTargetingMain'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnTargetingMain</c:when>
	<c:when test="${nameValue == 'stnTargetGroupMainLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnTargetGroupMain</c:when>
	<c:when test="${nameValue == 'stnConditionMainLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnConditionMain</c:when>
	<c:when test="${nameValue == 'stnConditionDetailLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnConditionDetail</c:when>
	<c:when test="${nameValue == 'stnConditionPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnConditionPopup</c:when>
	<c:when test="${nameValue == 'stnOfferListPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnOfferListPopup</c:when>
	<c:when test="${nameValue == 'stnConditionColumnPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnConditionColumnPopup</c:when>
	<c:when test="${nameValue == 'stnTargetGroupDetailLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnTargetGroupDetail</c:when>
	<c:when test="${nameValue == 'stnImportListPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnImportListPopup</c:when>
	<c:when test="${nameValue == 'stnImportTargetingMainLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnImportTargetingMain</c:when>
	<c:when test="${nameValue == 'stnSchedulingRunOnce'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnSchedulingRunOnce</c:when>
	<c:when test="${nameValue == 'stnSchedulingPopup'}">${pageContext.request.contextPath}/marketing/chargingStation/popup/stnSchedulingPopup</c:when>
	<c:when test="${nameValue == 'stnReactionInfoDetail'}">${pageContext.request.contextPath}/marketing/chargingStation/stnCampaignSubjectsDetail</c:when>
	<c:when test="${nameValue == 'stnMassMainLoad'}">${pageContext.request.contextPath}/marketing/chargingStation/load/stnMassMain</c:when>

	<%-- 충전소 BI --%>
	<c:when test="${nameValue == 'analysisTabStn'}">${pageContext.request.contextPath}/kepler/analysis/analysisTabStn</c:when>

	<c:when test="${nameValue == 'simpleTargetingMainLoad'}">${pageContext.request.contextPath}/marketing/targeting/include/simpleTargeting</c:when>

	<c:when test="${nameValue == 'importListPop'}">${pageContext.request.contextPath}/kepler/targetGroup/popup/importListPop</c:when>

	<c:when test="${nameValue == 'importTargetingDetail'}">${pageContext.request.contextPath}/kepler/targetGroup/importTargetingDetail</c:when>
	<c:when test="${nameValue == 'importTargetingMainLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/importTargetingMain</c:when>
	<c:when test="${nameValue == 'importTargetingDetailLoad'}">${pageContext.request.contextPath}/kepler/targetGroup/load/targetImportDetail</c:when>

	<%--과거 캠페인  --%>
	<c:when test="${nameValue == 'pastCampaignDtlPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/pastCampaignDtlPop</c:when>
	<c:when test="${nameValue == 'channelSendDtlPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/channelSendDtlPop</c:when>
	<c:when test="${nameValue == 'promotionDtlPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/promotionDtlPop</c:when>
	<c:when test="${nameValue == 'targetEmailPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/targetEmailPop</c:when>
	<c:when test="${nameValue == 'pastCampaignTargetListPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/pastCampaignTargetListPop</c:when>
	<c:when test="${nameValue == 'pastCamMsgListPop'}">${pageContext.request.contextPath}/marketing/pastCampaign/popup/pastCamMsgListPop</c:when>


	<%--오카지표 --%>
	<c:when test="${nameValue == 'ocaChannelSearchHelp'}">${pageContext.request.contextPath}/loyalty/orangeCard/indicator/popup/ocaChannelSearchHelp</c:when>

	<%--로그관리 --%>
	<c:when test="${nameValue == 'logManageList'}">${pageContext.request.contextPath}/marketing/logManage/logManageList</c:when>

	<%-- 충전소캠페인 대상자 반응결과 --%>
	<c:when test="${nameValue == 'stnCampaignSubjectsList'}">${pageContext.request.contextPath}/marketing/executionStatusStn/stnCamExecStatusList</c:when>
	<c:when test="${nameValue == 'stnCamExecStatusDetail'}">${pageContext.request.contextPath}/marketing/executionStatusStn/stnCamExecStatusDetail</c:when>
	<c:when test="${nameValue == 'stnExecStatusErrorHistoryPop'}">${pageContext.request.contextPath}/marketing/executionStatusStn/popup/stnExecStatusErrorHistoryPop</c:when>
	<c:when test="${nameValue == 'stnExecStatusChannelUnsentPop'}">${pageContext.request.contextPath}/marketing/executionStatusStn/popup/stnExecStatusChannelUnsentPop</c:when>

	<%-- 캠페인 결과 및 성과 -> 이벤트 성과분석 팝업 --%>
	<c:when test="${nameValue == 'eventResultAnalysisPop'}">${pageContext.request.contextPath}/kepler/analysis/popup/eventResultAnalysisPop</c:when>

	<%-- 이랜드용 셀프 오퍼 --%>
	<c:when test="${nameValue == 'childOfferDtlPop'}">${pageContext.request.contextPath}/marketing/offer/popup/childOfferDtlPop</c:when>
	<c:when test="${nameValue == 'childOfferListPop'}">${pageContext.request.contextPath}/marketing/offer/popup/childOfferListPop</c:when>


	<%-- Job관리--%>
	<%-- 실행인수 목록 팝업 --%>
	<c:when test="${nameValue == 'execParamListPop'}">${pageContext.request.contextPath}/system/job/popup/execParamListPop</c:when>
	<%-- Job 상세 팝업 --%>
	<c:when test="${nameValue == 'jobDetailPop'}">${pageContext.request.contextPath}/system/job/popup/jobDetailPop</c:when>
	<%-- 실행인수 상세 팝업 --%>
	<c:when test="${nameValue == 'execParamDetailPop'}">${pageContext.request.contextPath}/system/job/popup/execParamDetailPop</c:when>
	<%-- 실행이력 탭 --%>
	<c:when test="${nameValue == 'logListTab'}">${pageContext.request.contextPath}/system/job/include/logListTabNew</c:when>
	<%-- 로그 상세 팝업 --%>
	<c:when test="${nameValue == 'logDtlListPop'}">${pageContext.request.contextPath}/system/job/popup/logDtlListPop</c:when>
	<%-- 트리거 목록 탭 --%>
	<c:when test="${nameValue == 'trgrListTab'}">${pageContext.request.contextPath}/system/job/include/trgrListTabNew</c:when>
	<%-- 트리거 상세 팝업 --%>
	<c:when test="${nameValue == 'trgrDetailPop'}">${pageContext.request.contextPath}/system/job/popup/trgrDetailPop</c:when>
	<%-- 알람 목록 탭 --%>
	<c:when test="${nameValue == 'alrtListTab'}">${pageContext.request.contextPath}/system/job/include/alrtListTabNew</c:when>
	<%-- 알람 상세 팝업 --%>
	<c:when test="${nameValue == 'alrtDetailPop'}">${pageContext.request.contextPath}/system/job/popup/alrtDetailPop</c:when>
	<%-- 후속 실행 Job 목록 탭 --%>
	<c:when test="${nameValue == 'sbsqntListTab'}">${pageContext.request.contextPath}/system/job/include/sbsqntListTabNew</c:when>
	<%-- 후속 실행 Job 상세 팝업 --%>
	<c:when test="${nameValue == 'sbsqntDetailPop'}">${pageContext.request.contextPath}/system/job/popup/sbsqntDetailPop</c:when>
	<%-- 타겟 Job 상세 팝업 --%>
	<c:when test="${nameValue == 'targetJobDetailPop'}">${pageContext.request.contextPath}/system/job/popup/targetJobDetailPop</c:when>
	<%-- 타겟 Job 선택 팝업 --%>
	<c:when test="${nameValue == 'jobChoicePop'}">${pageContext.request.contextPath}/system/job/popup/jobChoicePop</c:when>
	<%-- jobStep--%>
	<c:when test="${nameValue == 'jobStepTab'}">${pageContext.request.contextPath}/system/job/include/jobStepTab</c:when>
	<%-- jobStep--%>
	<c:when test="${nameValue == 'jobStepMapperTab'}">${pageContext.request.contextPath}/system/job/include/jobStepMapperTab</c:when>
	<c:when test="${nameValue == 'jobStepDetailPop'}">${pageContext.request.contextPath}/system/job/popup/jobStepDetailPop</c:when>
	<c:when test="${nameValue == 'jobStepMapperDetailPop'}">${pageContext.request.contextPath}/system/job/popup/jobStepMapperDetailPop</c:when>
	<c:when test="${nameValue == 'jobLogTab'}">${pageContext.request.contextPath}/system/job/include/jobLogTab</c:when>
	<c:when test="${nameValue == 'batchExecutePop'}">${pageContext.request.contextPath}/system/job/popup/batchExecutePop</c:when>
	<c:when test="${nameValue == 'batchLogList'}">${pageContext.request.contextPath}/system/job/batchLogList</c:when>

	<%-- Job step Command 신규 --%>
	<c:when test="${nameValue == 'jobStepCommandTab'}">${pageContext.request.contextPath}/system/job/include/jobStepCommandTab</c:when>
	<c:when test="${nameValue == 'jobStepCommandDetailPop'}">${pageContext.request.contextPath}/system/job/popup/jobStepCommandDetailPop</c:when>
	
	<%--  batchParameter 탭 --%>
	<c:when test="${nameValue == 'batchParameterTab'}">${pageContext.request.contextPath}/system/job/include/batchParameterTab</c:when>
	<c:when test="${nameValue == 'batchParameterDetailPop'}">${pageContext.request.contextPath}/system/job/popup/batchParameterDetailPop</c:when>

	<%-- jobStep Parameter 탭 --%>
	<c:when test="${nameValue == 'jobStepParameterTab'}">${pageContext.request.contextPath}/system/job/include/jobStepParameterTab</c:when>
	<c:when test="${nameValue == 'jobStepParamDetailPop'}">${pageContext.request.contextPath}/system/job/popup/jobStepParamDetailPop</c:when>
	<c:when test="${nameValue == 'executeParamInfoPopUp'}">${pageContext.request.contextPath}/system/job/popup/executeParamInfoPopUp</c:when>


	<%-- QIM 관리 --%>
	<c:when test="${nameValue == 'qimAdmin'}">${pageContext.request.contextPath}/marketing/qim/qimAdmin</c:when>
	<c:when test="${nameValue == 'manageEncDetail'}">${pageContext.request.contextPath}/marketing/qim/manageEncDetail</c:when>
	<c:when test="${nameValue == 'accessInfoDetail'}">${pageContext.request.contextPath}/marketing/qim/accessInfoDetail</c:when>
	<c:when test="${nameValue == 'srcTgtDetail'}">${pageContext.request.contextPath}/marketing/qim/srcTgtDetail</c:when>
	<c:when test="${nameValue == 'interfaceDetail'}">${pageContext.request.contextPath}/marketing/qim/interfaceDetailNew</c:when>
	<c:when test="${nameValue == 'accessInfoPop'}">${pageContext.request.contextPath}/marketing/qim/popup/accessInfoPop</c:when>
	<c:when test="${nameValue == 'srcTrgInfoPop'}">${pageContext.request.contextPath}/marketing/qim/popup/srcTrgInfoPop</c:when>
	<c:when test="${nameValue == 'ifPramPop'}">${pageContext.request.contextPath}/marketing/qim/popup/ifPramPop</c:when>
	<c:when test="${nameValue == 'ifBatchPop'}">${pageContext.request.contextPath}/marketing/qim/popup/ifBatchPop</c:when>
	<c:when test="${nameValue == 'ifSocketPop'}">${pageContext.request.contextPath}/marketing/qim/popup/ifSocketPop</c:when>

	<c:when test="${nameValue == 'accessInfoList'}">${pageContext.request.contextPath}/marketing/qim/accessInfoListNew</c:when>
	<c:when test="${nameValue == 'srcTgtList'}">${pageContext.request.contextPath}/marketing/qim/srcTgtListNew</c:when>
	<c:when test="${nameValue == 'interfaceList'}">${pageContext.request.contextPath}/marketing/qim/interfaceListNew</c:when>

	<%-- 맴버십정책 상품에서 상품 스펙 추가 --%>
	<c:when test="${nameValue == 'prodSpecPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/prodSpecPop</c:when>
	<c:when test="${nameValue == 'prodExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/membership/product/popup/prodExcelUploadPop</c:when>




	<%-- 싱크퓨젼--%>
	<%-- 회원관리 --%>
	<c:when test="${nameValue == 'mbrCardListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCardListNew</c:when>
	<c:when test="${nameValue == 'mbrPtnTxnHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPtnTxnHistListNew</c:when>
	<c:when test="${nameValue == 'mbrDetailNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/mbrDetailNew</c:when>
	<c:when test="${nameValue == 'mbrPurHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrPurHistListNew</c:when>
	<c:when test="${nameValue == 'mbrVocListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrVocListNew</c:when>
    <c:when test="${nameValue == 'prodCustList'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/prodCustList</c:when>
	<c:when test="${nameValue == 'mbrInOutHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrInOutHistListNew</c:when>
	<c:when test="${nameValue == 'mbrChangeHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrChangeHistListNew</c:when>
	<c:when test="${nameValue == 'mbrCouponTrnsHistNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCouponTrnsHistNew</c:when>
	<c:when test="${nameValue == 'mbrTierHistListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrTierHistListNew</c:when>
	<c:when test="${nameValue == 'mbrBlackListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrBlackListNew</c:when>
	<c:when test="${nameValue == 'mbrChnlRelListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrChnlRelListNew</c:when>
	<c:when test="${nameValue == 'mbrCampaignResListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrCampaignResListNew</c:when>
    <c:when test="${nameValue == 'mbrWebLoginInf'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrWebLoginInf</c:when>
    <c:when test="${nameValue == 'mbrMobileLoginInf'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrMobileLoginInf</c:when>

	<%-- 회원관리 팝업 --%>
	<c:when test="${nameValue == 'pointDetailPopNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pointDetailPopNew</c:when>
	<c:when test="${nameValue == 'famOfferList'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/famOfferList</c:when>
	<c:when test="${nameValue == 'pointUseDetailPopNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/pointUseDetailPopNew</c:when>


	<%-- 간편 회원 관리 New --%>
	<c:when test="${nameValue == 'simpleMemRegListNew'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/simpleMemRegListNew</c:when>
	<c:when test="${nameValue == 'simpleMemRegDetailNew'}">${pageContext.request.contextPath}/loyalty/simpleMemReg/simpleMemRegDetailNew</c:when>
	<c:when test="${nameValue == 'unRgstCardListNew'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/unRgstCardListNew</c:when>
	<c:when test="${nameValue == 'rgstCardListNew'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/rgstCardListNew</c:when>
    <c:when test="${nameValue == 'cardDetailPopNew'}">${pageContext.request.contextPath}/loyalty/orangeCard/unRgst/popup/unRgstCardDetailPopNew</c:when>

	<%-- 거래이력 --%>
	<c:when test="${nameValue == 'pointDtlPopListNew'}">${pageContext.request.contextPath}/common/view/popup/pointDtlPopListNew</c:when>
	<c:when test="${nameValue == 'manualListNew'}">${pageContext.request.contextPath}/loyalty/manual/manualReqListNew</c:when>
	<c:when test="${nameValue == 'upldItemListNew'}">${pageContext.request.contextPath}/system/batchRgst/include/upldItemListNew</c:when>
	<c:when test="${nameValue == 'batchRgstListNew'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstListNew</c:when>
	<c:when test="${nameValue == 'pointListNew'}">${pageContext.request.contextPath}/loyalty/point/pointListNew</c:when>
	<c:when test="${nameValue == 'transPromoListNew'}">${pageContext.request.contextPath}/loyalty/trans/include/transPromoListNew</c:when>
	<c:when test="${nameValue == 'transSearchTestInfoNew'}">${pageContext.request.contextPath}/loyalty/trans/include/transSearchTestInfoNew</c:when>



	<%--  고객 --%>
	<c:when test="${nameValue == 'custAddInfoListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/custAddInfoListNew</c:when>
	<c:when test="${nameValue == 'memberListNew'}">${pageContext.request.contextPath}/loyalty/member/customer/include/memberListNew</c:when>
	<%--  가구화 --%>
	<%-- <c:when test="${nameValue == 'familyListNew'}">${pageContext.request.contextPath}/loyalty/member/family/familyListNew</c:when>
	<c:when test="${nameValue == 'familyAddInfoListNew'}">${pageContext.request.contextPath}/loyalty/member/family/include/familyAddInfoListNew</c:when>
	<c:when test="${nameValue == 'familyHistListNew'}">${pageContext.request.contextPath}/loyalty/member/family/include/familyHistListNew</c:when>
	<c:when test="${nameValue == 'familyBenefitsList'}">${pageContext.request.contextPath}/loyalty/member/family/include/familyBenefitsList</c:when>
	<c:when test="${nameValue == 'famliyPromotionList'}">${pageContext.request.contextPath}/loyalty/member/family/include/famliyPromotionList</c:when> --%>


	<c:when test="${nameValue == 'dropMbrListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/dropMbrListNew</c:when>
	<c:when test="${nameValue == 'dropConfirmMbrPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/dropConfirmMbrPop</c:when>

	<%-- 카페24 --%>
	<c:when test="${nameValue == 'genTargetGroupPop'}">${pageContext.request.contextPath}/loyalty/member/customer/popup/genTargetGroup</c:when>
	<c:when test="${nameValue == 'cafe24MbrDetail'}">${pageContext.request.contextPath}/loyalty/member/customer/cafe24MbrDetail</c:when>
	<c:when test="${nameValue == 'cafe24CamHist'}">${pageContext.request.contextPath}/loyalty/member/customer/include/cafe24CamHist</c:when>
	<c:when test="${nameValue == 'cafe24MemList'}">${pageContext.request.contextPath}/loyalty/member/customer/cafe24MemList</c:when>
	
	
	<%-- 상담 --%>
	<c:when test="${nameValue == 'consultListNew'}">${pageContext.request.contextPath}/voc/requestConsultation/consultListNew</c:when>
	<c:when test="${nameValue == 'callbackListNew'}">${pageContext.request.contextPath}/voc/call/callbackListNew</c:when>
	<c:when test="${nameValue == 'callListNew'}">${pageContext.request.contextPath}/voc/call/callListNew</c:when>
	<c:when test="${nameValue == 'tmCampaignListNew'}">${pageContext.request.contextPath}/voc/tmCampaign/tmCampaignListNew</c:when>

	<%-- 정산 관리--%>

	<%-- 대상자 추출 --%>
	<c:when test="${nameValue == 'batchRgstDetailNew'}">${pageContext.request.contextPath}/system/batchRgst/batchRgstDetailNew</c:when>

	<%-- 마케팅 정책 --%>
	<c:when test="${nameValue == 'fatigueListNew'}">${pageContext.request.contextPath}/marketing/fatigue/fatigueListNew</c:when>
	<c:when test="${nameValue == 'MKTOfferListNew'}">${pageContext.request.contextPath}/marketing/offer/offerListNew</c:when>
	<c:when test="${nameValue == 'useDeskPopNew'}">${pageContext.request.contextPath}/marketing/offer/popup/useDeskPopNew</c:when>
	<%-- 마케팅 기획/실행--%>
	<c:when test="${nameValue == 'camExecStatusDetailNew'}">${pageContext.request.contextPath}/marketing/executionStatus/camExecStatusDetailNew</c:when>

	<c:when test="${nameValue == 'dbInformNew'}">${pageContext.request.contextPath}/kepler/operation/include/dbInformNew</c:when>
	<c:when test="${nameValue == 'subjectAreaRegistNew'}">${pageContext.request.contextPath}/kepler/operation/include/subjectAreaRegistNew</c:when>
	<c:when test="${nameValue == 'camExecStatusListNew'}">${pageContext.request.contextPath}/marketing/executionStatus/camExecStatusListNew</c:when>

	<%-- 타겟 그룹 리스트  --%>
	<c:when test="${nameValue == 'targetGroupListNew'}">${pageContext.request.contextPath}/kepler/targetGroup/targetGroupListNew</c:when>

	<%-- 시스템 관리 --%>
	<c:when test="${nameValue == 'authMenuListPopNew'}">${pageContext.request.contextPath}/system/menu/popup/authMenuListPopModalNew</c:when>
	<c:when test="${nameValue == 'showMenuIcon'}">${pageContext.request.contextPath}/system/menu/popup/showMenuIcon</c:when>
	<c:when test="${nameValue == 'organizationNew'}">${pageContext.request.contextPath}/system/organization/organizationListNew</c:when>



	<%-- 외부ㅡ테이블 --%>
	<c:when test="${nameValue == 'outtargetLevelNew'}">${pageContext.request.contextPath}/marketing/outTable/include/targetLevelNew</c:when>
	<c:when test="${nameValue == 'outtargetTableNew'}">${pageContext.request.contextPath}/marketing/outTable/include/targetTableNew</c:when>
	<c:when test="${nameValue == 'outtargetColumnNew'}">${pageContext.request.contextPath}/marketing/outTable/include/targetColumnNew</c:when>
	<c:when test="${nameValue == 'ftpConnectNew'}">${pageContext.request.contextPath}/marketing/outTable/include/ftpConnectNew</c:when>
	<c:when test="${nameValue == 'emailHostURL'}">${pageContext.request.contextPath}/marketing/outTable/include/emailHostURL</c:when>
    <c:when test="${nameValue == 'webServiceURL'}">${pageContext.request.contextPath}/marketing/outTable/include/webServiceURL</c:when>
	<c:when test="${nameValue == 'permissionNew'}">${pageContext.request.contextPath}/marketing/outTable/include/permissionNew</c:when>
	<c:when test="${nameValue == 'runChannelNew'}">${pageContext.request.contextPath}/marketing/outTable/include/runChannelNew</c:when>
	<c:when test="${nameValue == 'permissionColumnPopNew'}">${pageContext.request.contextPath}/marketing/outTable/popup/searchColumnPopNew</c:when>



	<%--멤버십 정책 --%>

	<c:when test="${nameValue == 'pointAdjustmentInfoNew'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointAdjustmentInfoNew</c:when>
	<c:when test="${nameValue == 'pgmListNew'}">${pageContext.request.contextPath}/loyalty/membership/pgm/pgmListNew</c:when>
	<c:when test="${nameValue == 'pgmChnlListNew'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmChnlListNew</c:when>
	<c:when test="${nameValue == 'pgmHistListNew'}">${pageContext.request.contextPath}/loyalty/membership/pgm/include/pgmHistListNew</c:when>
	<c:when test="${nameValue == 'pointSaveListInfoNew'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointSaveListInfoNew</c:when>
	<c:when test="${nameValue == 'pointUseListInfoNew'}">${pageContext.request.contextPath}/loyalty/standardPoint/include/pointUseListInfoNew</c:when>
	<c:when test="${nameValue == 'tierDtlNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierDtlNew</c:when>
	<c:when test="${nameValue == 'tierChnlNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierChnlNew</c:when>
	<c:when test="${nameValue == 'tierUpMatrixNew'}">${pageContext.request.contextPath}/loyalty/membership/tiers/include/tierUpMatrixNew</c:when>

	<%-- 분석툴 관리--%>
	<c:when test="${nameValue == 'dbInfoNew'}">${pageContext.request.contextPath}/kepler/operation/dbInformNew</c:when>


	<%-- 스토어 &파트너 --%>
	<%-- <c:when test="${nameValue == 'chnlTxnMemListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlTxnMemListNew</c:when> --%>
	<c:when test="${nameValue == 'chnlStlInfoListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlStlInfoListNew</c:when>
	<c:when test="${nameValue == 'chnlSubListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlSubListNew</c:when>
	<c:when test="${nameValue == 'chnlTxnHistListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlTxnHistListNew</c:when>
	<c:when test="${nameValue == 'chnlSubTxnHistListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlSubTxnHistListNew</c:when>
	<c:when test="${nameValue == 'chnlChangeHistListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlChangeHistListNew</c:when>
	<c:when test="${nameValue == 'chnlPointChangeHistListNew'}">${pageContext.request.contextPath}/loyalty/channel/include/chnlPointChangeHistListNew</c:when>

	<%-- 구매 --%>
	<c:when test="${nameValue == 'missingPointAcrlPop'}">${pageContext.request.contextPath}/loyalty/pur/popup/missingPointAcrlPop</c:when>

	<%-- 프로모션 상세 --%>
	<c:when test="${nameValue == 'condAmount'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/condAmount</c:when>
	<c:when test="${nameValue == 'condChnl'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/condChnl</c:when>
	<c:when test="${nameValue == 'condOther'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/condOther</c:when>
	<c:when test="${nameValue == 'paymentPolicyTab'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/paymentPolicyTab</c:when>

	<%-- 프로모션 상세 --%>
	<c:when test="${nameValue == 'condTime'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/condTime</c:when>
	<c:when test="${nameValue == 'condTimeInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condTimeInfoPop</c:when>

	<c:when test="${nameValue == 'condChnlInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condChnlInfoPop</c:when>

	<c:when test="${nameValue == 'condOtherInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condOtherInfoPop</c:when>
	<c:when test="${nameValue == 'loyTierListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyTierListPop</c:when>
	<c:when test="${nameValue == 'condProdInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condProdInfoPop</c:when>
	<c:when test="${nameValue == 'condChnlListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condChnlListPop</c:when>
	<c:when test="${nameValue == 'paymentPolicyInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/paymentPolicyInfoPop</c:when>
	<c:when test="${nameValue == 'condProdListPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condProdListPop</c:when>
	<c:when test="${nameValue == 'condChnlSearchPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condChnlSearchPop</c:when>
	<c:when test="${nameValue == 'condAmtInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/condAmtInfoPop</c:when>

	<%-- Demo --%>
	<c:when test="${nameValue == 'eastarDemoPop'}">${pageContext.request.contextPath}/common/view/winpop/eastarDemoPop</c:when>

	<%-- 클럽 --%>
	<c:when test="${nameValue == 'clubTypeDtl'}">${pageContext.request.contextPath}/loyalty/membership/club/clubTypeDtl</c:when>
	<c:when test="${nameValue == 'clubChnlPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubChnlPop</c:when>
	<c:when test="${nameValue == 'chnlLimitPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/chnlLimitPop</c:when>
	<c:when test="${nameValue == 'clubTypeList'}">${pageContext.request.contextPath}/loyalty/membership/club/clubTypeList</c:when>
	<c:when test="${nameValue == 'clubMbrPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubMbrPop</c:when>
	<c:when test="${nameValue == 'clubMbrTrmntPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubMbrTrmntPop</c:when>
	<c:when test="${nameValue == 'clubBenfPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubBenfPop</c:when>
	<c:when test="${nameValue == 'tabClubBenfList'}">${pageContext.request.contextPath}/loyalty/membership/club/include/tabClubBenfList</c:when>
	<c:when test="${nameValue == 'clubBenfSearchHelp'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubBenfSearchHelp</c:when>
	<c:when test="${nameValue == 'clubOfferPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubOfferPop</c:when>
	<c:when test="${nameValue == 'clubTierListPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubTierListPop</c:when>
	<c:when test="${nameValue == 'clubTierPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubTierPop</c:when>
	<c:when test="${nameValue == 'clubJoinCondPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubJoinCondPop</c:when>
	<c:when test="${nameValue == 'clubProdSearchHelp'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubProdSearchHelp</c:when>
	<c:when test="${nameValue == 'clubCategorySearchHelp'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubCategorySearchHelp</c:when>
	<c:when test="${nameValue == 'tabClubTierDtlList'}">${pageContext.request.contextPath}/loyalty/membership/club/include/tabClubTierDtlList</c:when>
	<c:when test="${nameValue == 'clubTierTabDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubTierTabDtlPop</c:when>
	<c:when test="${nameValue == 'clubPartenariatPop'}">${pageContext.request.contextPath}/loyalty/membership/club/popup/clubPartenariatPop</c:when>

	<%-- 이벤트트리거 scoring --%>
	<c:when test="${nameValue == 'scoringList'}">${pageContext.request.contextPath}/loyalty/scoring/campaignList</c:when>
	<c:when test="${nameValue == 'scoringWorkFlow'}">${pageContext.request.contextPath}/loyalty/scoring/scoringWorkFlow</c:when>

	<%-- 이벤트트리거 scoring 핸들러 --%>
	<c:when test="${nameValue == 'scoringInfoPop'}">${pageContext.request.contextPath}/loyalty/scoring/popup/scoringInfoPop</c:when>
	<c:when test="${nameValue == 'loadScoringApprovalDetail'}">${pageContext.request.contextPath}/loyalty/scoring/approval/load/scoringApprovalDetail</c:when>
	<c:when test="${nameValue == 'scoringRuleFilterSetPop'}">${pageContext.request.contextPath}/loyalty/scoring/popup/scoringRuleFilterSetPop</c:when>

	<%-- 이벤트트리거 지수조회 --%>
	<c:when test="${nameValue == 'scoringResultDetailPop'}">${pageContext.request.contextPath}/loyalty/scoring/popup/scoringResultDetailPop</c:when>

	<c:when test="${nameValue == 'noticeListUrl'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/noticeList</c:when>
	<c:when test="${nameValue == 'noticeDetailUrl'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/noticeDetail</c:when>
	<c:when test="${nameValue == 'notice_lang'}">${pageContext.request.contextPath}/loyalty/custChnl/notice/include/notice_lang</c:when>

	<c:when test="${nameValue == 'partnerDetailUrl'}">${pageContext.request.contextPath}/system/partner/partnerDetail</c:when>
	<c:when test="${nameValue == 'partnerList'}">${pageContext.request.contextPath}/system/partner/partnerList</c:when>
	<c:when test="${nameValue == 'partnerInfo'}">${pageContext.request.contextPath}/system/partner/include/partnerInfo</c:when>

	<c:when test="${nameValue == 'pushMsgListUrl'}">${pageContext.request.contextPath}/system/pushMsg/pushMsgList</c:when>
	<c:when test="${nameValue == 'pushMsgDetailUrl'}">${pageContext.request.contextPath}/system/pushMsg/pushMsgDetail</c:when>

	<c:when test="${nameValue == 'eventListUrl'}">${pageContext.request.contextPath}/system/event/eventList</c:when>
	<c:when test="${nameValue == 'eventDetailUrl'}">${pageContext.request.contextPath}/system/event/eventDetail</c:when>

	<c:when test="${nameValue == 'eventInfoUrl'}">${pageContext.request.contextPath}/system/event/include/eventInfo</c:when>
	<c:when test="${nameValue == 'eventPartiUrl'}">${pageContext.request.contextPath}/system/event/include/eventParti</c:when>
	<c:when test="${nameValue == 'eventPrizewinnerUrl'}">${pageContext.request.contextPath}/system/event/include/eventPrizewinner</c:when>
		<c:when test="${nameValue == 'info_lang'}">${pageContext.request.contextPath}/system/event/include/info_lang</c:when>

	<c:when test="${nameValue == 'appListUrl'}">${pageContext.request.contextPath}/system/appversion/appList</c:when>

	<c:when test="${nameValue == 'appDetailPopUrl'}">${pageContext.request.contextPath}/system/appversion/popup/appDetailPop</c:when>

	<c:when test="${nameValue == 'appPopListUrl'}">${pageContext.request.contextPath}//system/apppopup/appPopList</c:when>
	<c:when test="${nameValue == 'appPopDetailUrl'}">${pageContext.request.contextPath}/system/apppopup/appPopDetail</c:when>

	<c:when test="${nameValue == 'faqListUrl'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/faqList</c:when>
	<c:when test="${nameValue == 'faqDetailUrl'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/faqDetail</c:when>
	<c:when test="${nameValue == 'faqUploadDetailPop'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/popup/faqUploadDetailPop</c:when>

	<c:when test="${nameValue == 'qnaManagementList'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/qnaManagementListNew</c:when>
	<c:when test="${nameValue == 'qnaManagementDetail'}">${pageContext.request.contextPath}/loyalty/custChnl/qna/qnaManagementDetail</c:when>





	<c:when test="${nameValue == 'faq_Ko'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/include/faq_Ko</c:when>
	<c:when test="${nameValue == 'faq_En'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/include/faq_En</c:when>
	<c:when test="${nameValue == 'faq_Ch'}">${pageContext.request.contextPath}/loyalty/custChnl/faq/include/faq_Ch</c:when>

	<c:when test="${nameValue == 'appPop_lang'}">${pageContext.request.contextPath}//system/apppopup/include/appPop_lang</c:when>

	<%-- 	약관 관리  --%>
	<c:when test="${nameValue == 'termsDetailList'}">${pageContext.request.contextPath}/loyalty/terms/termsDetailList</c:when>
	<c:when test="${nameValue == 'termsList'}">${pageContext.request.contextPath}/loyalty/terms/termsList</c:when>
   <c:when test="${nameValue == 'termsGrpList'}">${pageContext.request.contextPath}/loyalty/terms/termsGrpList</c:when>
	<c:when test="${nameValue == 'termsGrpList'}">${pageContext.request.contextPath}/loyalty/terms/termsGrpList</c:when>
	<c:when test="${nameValue == 'termsVerList'}">${pageContext.request.contextPath}/loyalty/terms/include/termsVerList</c:when>
	<c:when test="${nameValue == 'receiveChannelList'}">${pageContext.request.contextPath}/loyalty/terms/include/receiveChannelList</c:when>
	<c:when test="${nameValue == 'loyaltyProgramList'}">${pageContext.request.contextPath}/loyalty/terms/include/loyaltyProgramList</c:when>
	<c:when test="${nameValue == 'termsVersionPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsVersionPop</c:when>
	<c:when test="${nameValue == 'termsPreviewPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsPreviewPop</c:when>
	<c:when test="${nameValue == 'termsRcvChnlPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsRcvChnlPop</c:when>
	<c:when test="${nameValue == 'termsLoyPgmPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsLoyPgmPop</c:when>
	<c:when test="${nameValue == 'loyPgmTListPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/loyPgmTListPop</c:when>
    
    <c:when test="${nameValue == 'termsGrpPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsGrpPop</c:when>
    <c:when test="${nameValue == 'termsGrpModPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsGrpModPop</c:when>
    <c:when test="${nameValue == 'termsGrpTermsPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsGrpTermsPop</c:when>
    <c:when test="${nameValue == 'termsGrpListPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsGrpListPop</c:when>
    <c:when test="${nameValue == 'termsGrpListModPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsGrpListModPop</c:when>

	<c:when test="${nameValue == 'commentDetailPop'}">${pageContext.request.contextPath}/loyalty/storeSatisfaction/popup/commentDetailPop</c:when>
	<c:when test="${nameValue == 'termsInfoPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsInfoPop</c:when>
	<c:when test="${nameValue == 'termsMbrInfoPop'}">${pageContext.request.contextPath}/loyalty/terms/popup/termsMbrInfoPop</c:when>


	<c:when test="${nameValue == 'bannerDetailUrl'}">${pageContext.request.contextPath}/system/banner/bannerDetail</c:when>
	<c:when test="${nameValue == 'bannerListUrl'}">${pageContext.request.contextPath}/system/banner/banner</c:when>
	<c:when test="${nameValue == 'banner_lang'}">${pageContext.request.contextPath}/system/banner/include/banner_lang</c:when>

	<%-- 포인트 수동일괄등록 --%>
	<c:when test="${nameValue == 'promotionSearchHelpBatchRgst'}">${pageContext.request.contextPath}/system/batchRgst/popup/promotionSearchHelp</c:when>

	<%-- 승인서버 로그 --%>
	<c:when test="${nameValue == 'reqData'}">${pageContext.request.contextPath}/system/batchRgst/include/reqData</c:when>
	<c:when test="${nameValue == 'dblogList'}">${pageContext.request.contextPath}/system/batchRgst/include/dblogList</c:when>

	<%-- 프로모션 캠페인 : 룰셋 신규 --%>
	<c:when test="${nameValue == 'specificDayInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/specificDayInfoPop</c:when>
	<c:when test="${nameValue == 'loyTierDtlInfoPop'}">${pageContext.request.contextPath}/loyalty/ruleSet/popup/loyTierDtlInfoPop</c:when>



	<%-- 리포트  --%>
	<c:when test="${nameValue == 'searchStorePop'}">${pageContext.request.contextPath}/kepler/report/popup/searchStorePop</c:when>
	<c:when test="${nameValue == 'successCampaignPop'}">${pageContext.request.contextPath}/kepler/report/popup/successCampaignListNewPop</c:when>
	<c:when test="${nameValue == 'KprChnlListPop'}">${pageContext.request.contextPath}/kepler/report/popup/KprChnlListPop</c:when>
	<c:when test="${nameValue == 'KprCamListPop'}">${pageContext.request.contextPath}/kepler/report/popup/KprCamListPop</c:when>
	<c:when test="${nameValue == 'KprPromListPop'}">${pageContext.request.contextPath}/kepler/report/popup/KprPromListPop</c:when>
	<c:when test="${nameValue == 'recommendedPersonListPop'}">${pageContext.request.contextPath}/kepler/report/popup/recommendedPersonListPop</c:when>
	<c:when test="${nameValue == 'onlineOrderDetailPop'}">${pageContext.request.contextPath}/kepler/report/popup/onlineOrderDetailPop</c:when>
	
	<%-- 프로모션 상품목록  --%>
	<c:when test="${nameValue == 'targetProductListNew'}">${pageContext.request.contextPath}/loyalty/ruleSet/include/targetProductListNew</c:when>
	<c:when test="${nameValue == 'promProductInfoPop'}">${pageContext.request.contextPath}/marketing/campaign/popup/promProductInfoPop</c:when>

	<%-- 부정적립  --%>
	<c:when test="${nameValue == 'fraudEmp'}">${pageContext.request.contextPath}/loyalty/fraud/include/fraudEmp</c:when>
	<c:when test="${nameValue == 'fraudDayTxnTarget'}">${pageContext.request.contextPath}/loyalty/fraud/include/fraudDayTxnTarget</c:when>
	<c:when test="${nameValue == 'fraudChannel'}">${pageContext.request.contextPath}/loyalty/fraud/include/fraudChannel</c:when>
	<c:when test="${nameValue == 'fraudAcrlPntTop'}">${pageContext.request.contextPath}/loyalty/fraud/include/fraudAcrlPntTop</c:when>
	<c:when test="${nameValue == 'fraudAcrlCntTop'}">${pageContext.request.contextPath}/loyalty/fraud/include/fraudAcrlCntTop</c:when>

	<%--멤버십 회원 구분 --%>
	<c:when test="${nameValue == 'mbrDivUpldItemListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrDivUpldItemListNew</c:when>
	<c:when test="${nameValue == 'mbrUploadDetailPop'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/mbrUploadDetailPop</c:when>
    <c:when test="${nameValue == 'dropMemPopup'}">${pageContext.request.contextPath}/loyalty/member/mbr/popup/dropMemPopup</c:when>


	<%--로열티 운영 정책 --%>
	<c:when test="${nameValue == 'operBaseList'}">${pageContext.request.contextPath}/loyalty/membership/operBase/operBaseList</c:when>
	<c:when test="${nameValue == 'operDtlList'}">${pageContext.request.contextPath}/loyalty/membership/operBase/operDtlList</c:when>
	<c:when test="${nameValue == 'delOperBaseList'}">${pageContext.request.contextPath}/loyalty/membership/operBase/delOperBaseList</c:when>
	<c:when test="${nameValue == 'operAddPop'}">${pageContext.request.contextPath}/loyalty/membership/operBase/operAddPop</c:when>
	<c:when test="${nameValue == 'delOperBaseDtlList'}">${pageContext.request.contextPath}/loyalty/membership/operBase/delOperBaseDtlList</c:when>
	<c:when test="${nameValue == 'operBasePop'}">${pageContext.request.contextPath}/loyalty/membership/operBase/popup/operBasePop</c:when>
	<c:when test="${nameValue == 'operBaseDtlPop'}">${pageContext.request.contextPath}/loyalty/membership/operBase/popup/operBaseDtlPop</c:when>

	<%-- 이벤트 기획/실행 --%>
	<c:when test="${nameValue == 'promotionDetailPop'}">${pageContext.request.contextPath}/loyalty/event/popup/promotionDetailPop</c:when>
	<c:when test="${nameValue == 'mbrSearchPopup'}">${pageContext.request.contextPath}/loyalty/event/popup/mbrSearchPopup</c:when>
	<c:when test="${nameValue == 'eventWinnerExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventWinnerExcelUploadPop</c:when>
	<c:when test="${nameValue == 'eventApplicantExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventApplicantExcelUploadPop</c:when>
	<c:when test="${nameValue == 'prodEntryExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/event/popup/prodEntryExcelUploadPop</c:when>
	<c:when test="${nameValue == 'imgViewPop'}">${pageContext.request.contextPath}/loyalty/event/popup/imageViewPop</c:when>
	<c:when test="${nameValue == 'evtApplicant'}">${pageContext.request.contextPath}/loyalty/event/include/evtApplicant</c:when>
	<c:when test="${nameValue == 'eventStorePreviewTokenPop'}">${pageContext.request.contextPath}/loyalty/event/popup/eventStorePreviewTokenPop</c:when>
	<c:when test="${nameValue == 'addPromPop'}">${pageContext.request.contextPath}/loyalty/event/popup/addPromPop</c:when>
	<c:when test="${nameValue == 'promotionDetailPop2'}">${pageContext.request.contextPath}/loyalty/event/popup/promotionDetailPop2</c:when>
	<c:when test="${nameValue == 'limitMbrAddPop'}">${pageContext.request.contextPath}/loyalty/event/popup/limitMbrAddPop</c:when>
	<c:when test="${nameValue == 'terminationPop'}">${pageContext.request.contextPath}/loyalty/event/popup/terminationPop</c:when>
	<c:when test="${nameValue == 'reservationDetailList'}">${pageContext.request.contextPath}/loyalty/event/reservationDetail</c:when>
	<c:when test="${nameValue == 'reservationListNew'}">${pageContext.request.contextPath}/loyalty/event/reservationListNew</c:when>
	<c:when test="${nameValue == 'winningCondPop'}">${pageContext.request.contextPath}/loyalty/event/popup/winningCondPop</c:when>
	<c:when test="${nameValue == 'limitWinMbrAddPop'}">${pageContext.request.contextPath}/loyalty/event/popup/limitWinMbrAddPop</c:when>
	<c:when test="${nameValue == 'winnerRdmPop'}">${pageContext.request.contextPath}/loyalty/event/popup/winnerRdmPop</c:when>

	<%-- 이벤트 스토어 기획/실행 --%>
	<c:when test="${nameValue == 'eventStoreListNew'}">${pageContext.request.contextPath}/loyalty/event/eventStoreListNew</c:when>
	<c:when test="${nameValue == 'eventStoreDetail'}">${pageContext.request.contextPath}/loyalty/event/eventStoreDetail</c:when>


	<%-- 예약서비스 기획/실행 --%>
	<c:when test="${nameValue == 'reservationDetail'}">${pageContext.request.contextPath}/loyalty/event/reservationDetail</c:when>
	<c:when test="${nameValue == 'reservationPreviewTokenPop'}">${pageContext.request.contextPath}/loyalty/event/popup/reservationPreviewTokenPop</c:when>
	<c:when test="${nameValue == 'reservImageViewPop'}">${pageContext.request.contextPath}/loyalty/event/popup/reservImageViewPop</c:when>


    <%-- 레포트 > 활동회원 --%>
	<c:when test="${nameValue == 'activeMember'}">${pageContext.request.contextPath}/kepler/report/activeMember</c:when>
	<c:when test="${nameValue == 'ageGroup'}">${pageContext.request.contextPath}/kepler/report/ageGroup</c:when>


	<%-- 개인정보취급이력 --%>
	<c:when test="${nameValue == 'piMaskingDecList'}">${pageContext.request.contextPath}/loyalty/personalInform/piMaskingDecList</c:when>

	<%-- api명세서 --%>
	<c:when test="${nameValue == 'apiSpecNew'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecNew</c:when>
	<c:when test="${nameValue == 'apiSpecList'}">${pageContext.request.contextPath}/system/apiSpec/apiSpecList</c:when>
	<c:when test="${nameValue == 'apiSpecUploadPop'}">${pageContext.request.contextPath}/system/apiSpec/popup/apiSpecUploadPop</c:when>
	<c:when test="${nameValue == 'apiSendLogList'}">${pageContext.request.contextPath}/system/apiSpec/include/apiSendLogList</c:when>
	<c:when test="${nameValue == 'excelFileUpload'}">${pageContext.request.contextPath}/system/apiSpec/include/excelFileUpload</c:when>
	<c:when test="${nameValue == 'apiChnlList'}">${pageContext.request.contextPath}/system/apiSpec/include/apiChnlList</c:when>
	<c:when test="${nameValue == 'apiChnlJoinPop'}">${pageContext.request.contextPath}/system/apiSpec/popup/apiChnlJoinPop</c:when>
	<c:when test="${nameValue == 'apiSpecListPop'}">${pageContext.request.contextPath}/system/apiSpec/popup/apiSpecListPop</c:when>
	<c:when test="${nameValue == 'apiParamReqList'}">${pageContext.request.contextPath}/system/apiSpec/include/apiParamReqList</c:when>
	<c:when test="${nameValue == 'apiParamResList'}">${pageContext.request.contextPath}/system/apiSpec/include/apiParamResList</c:when>
	<c:when test="${nameValue == 'apiParamResDetail'}">${pageContext.request.contextPath}/system/apiSpec/popup/apiParamResDetail</c:when>
	<c:when test="${nameValue == 'apiParamReqDetail'}">${pageContext.request.contextPath}/system/apiSpec/popup/apiParamReqDetail</c:when>
	<c:when test="${nameValue == 'parParamPop'}">${pageContext.request.contextPath}/system/apiSpec/popup/parParamPop</c:when>
	<%-- 알림공지 --%>
	<c:when test="${nameValue == 'alertMsgListUrl'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/alertMsgList</c:when>
	<c:when test="${nameValue == 'alertMsgPop'}">${pageContext.request.contextPath}/loyalty/custChnl/alert/popup/alertMsgPop</c:when>

    <%-- 메시지 프로퍼티 --%>
	<%-- <c:when test="${nameValue == 'msgPropertiesList'}">${pageContext.request.contextPath}/system/msgproperties/msgPropertiesList</c:when>
	<c:when test="${nameValue == 'msgPropertiesPopup'}">${pageContext.request.contextPath}/system/msgproperties/popup/msgPropertiesPopup</c:when>
	<c:when test="${nameValue == 'msgAttrPopup'}">${pageContext.request.contextPath}/system/msgproperties/popup/msgAttrPopup</c:when>
	<c:when test="${nameValue == 'msgUploadDetailPop'}">${pageContext.request.contextPath}/system/msgproperties/popup/msgUploadDetailPop</c:when> --%>
	<c:when test="${nameValue == 'emailAuth'}">${pageContext.request.contextPath}/auth/email/emailAuth</c:when>
	<c:when test="${nameValue == 'emailAuth'}">${pageContext.request.contextPath}/loyalty/member/mbr/emailAuthNew</c:when>

	<c:when test="${nameValue == 'editAuthpop'}">${pageContext.request.contextPath}/system/auth/popup/editAuthpop</c:when>


	<%-- 시스템관리 --%>

	<%-- 실행 채널 시스템 관리 --%>
	<c:when test="${nameValue == 'MKTChannelDetail'}">${pageContext.request.contextPath}/system/channel/channelDetail</c:when>
	<c:when test="${nameValue == 'MKTChannelOrgPop'}">${pageContext.request.contextPath}/system/channel/popup/channelOrgPop</c:when>
	<c:when test="${nameValue == 'MKTChannelList'}">${pageContext.request.contextPath}/system/channel/mktChannelListNew</c:when>
	<c:when test="${nameValue == 'snsAdtnInfoPop'}">${pageContext.request.contextPath}/system/channel/popup/snsAdtnInfoPop</c:when>
	<c:when test="${nameValue == 'MKTCapacityPerChannelPop'}">${pageContext.request.contextPath}/system/channel/popup/capacityPerChannelPop</c:when>
	<c:when test="${nameValue == 'MKTImageFileLimitPop'}">${pageContext.request.contextPath}/system/channel/popup/imageFileLimitPop</c:when>

	<%-- 프로그램 관리 --%>
	<c:when test="${nameValue == 'progList'}">${pageContext.request.contextPath}/system/program/progListNew</c:when>
	<c:when test="${nameValue == 'progDetailNew'}">${pageContext.request.contextPath}/system/program/progDetailNew</c:when>
	<c:when test="${nameValue == 'progDetail'}">${pageContext.request.contextPath}/system/program/progDetailNew</c:when>
	<c:when test="${nameValue == 'progListNew'}">${pageContext.request.contextPath}/system/program/progListNew</c:when>
	<c:when test="${nameValue == 'getProgramList'}">${pageContext.request.contextPath}/system/program/popup/getProgramList</c:when>
	<c:when test="${nameValue == 'getAuthAddDialog'}">${pageContext.request.contextPath}/system/program/popup/getAuthAddDialog</c:when>
	<c:when test="${nameValue == 'lowProgramRel'}">${pageContext.request.contextPath}/system/program/include/lowProgramRel</c:when>
	<c:when test="${nameValue == 'programChildTab'}">${pageContext.request.contextPath}/system/program/include/programChildTab</c:when>
	<c:when test="${nameValue == 'authProgramConnection'}">${pageContext.request.contextPath}/system/program/include/authProgramConnection</c:when>
	<c:when test="${nameValue == 'getAddLowProgList'}">${pageContext.request.contextPath}/system/program/popup/getAddLowProgList</c:when>
	<c:when test="${nameValue == 'detailLowProgList'}">${pageContext.request.contextPath}/system/program/popup/detailLowProgList</c:when>
	<c:when test="${nameValue == 'detailProgramList'}">${pageContext.request.contextPath}/system/program/popup/detailProgramList</c:when>
	<c:when test="${nameValue == 'excelDownloadList'}">${pageContext.request.contextPath}/system/program/include/excelDownloadList</c:when>
	<c:when test="${nameValue == 'addExcelFilePop'}">${pageContext.request.contextPath}/system/program/popup/addExcelFilePop</c:when>
	<c:when test="${nameValue == 'ExcelDataMapPopup'}">${pageContext.request.contextPath}/system/program/popup/getExcelDataMapPop</c:when>

	<%-- 오브젝트 관리 --%>
	<c:when test="${nameValue == 'objectList'}">${pageContext.request.contextPath}/system/object/objectListNew</c:when>
	<c:when test="${nameValue == 'objectDetail'}">${pageContext.request.contextPath}/system/object/objectDetail</c:when>

	<%-- 권한 관리 --%>
	<c:when test="${nameValue == 'authList'}">${pageContext.request.contextPath}/system/auth/authListNew</c:when>
	<c:when test="${nameValue == 'authDetail'}">${pageContext.request.contextPath}/system/auth/authDetail</c:when>
	<c:when test="${nameValue == 'getAuthCopyPopup'}">${pageContext.request.contextPath}/system/auth/popup/getAuthCopyPopup</c:when>
	<c:when test="${nameValue == 'viewAuth'}">${pageContext.request.contextPath}/system/auth/include/viewAuth</c:when>
	<c:when test="${nameValue == 'objectAuthNew'}">${pageContext.request.contextPath}/system/auth/include/objectAuthNew</c:when>
	<c:when test="${nameValue == 'programViewAuth'}">${pageContext.request.contextPath}/system/auth/include/programViewAuth</c:when>
	<c:when test="${nameValue == 'programAuthpop'}">${pageContext.request.contextPath}/system/auth/popup/programAuthpop</c:when>
	<c:when test="${nameValue == 'programChildAuthpop'}">${pageContext.request.contextPath}/system/auth/popup/programChildAuthpop</c:when>
	<c:when test="${nameValue == 'uiObjectDetailModal'}">${pageContext.request.contextPath}/system/auth/popup/uiObjectDetailModal</c:when>
	<c:when test="${nameValue == 'objListPop'}">${pageContext.request.contextPath}/system/auth/popup/objListPop</c:when>
	<c:when test="${nameValue == 'getObjAuthPopup'}">${pageContext.request.contextPath}/system/auth/popup/getObjAuthPopup</c:when>


	<%-- 권한그룹 관리 --%>
	<c:when test="${nameValue == 'authGroupDetail'}">${pageContext.request.contextPath}/system/authgroup/authGroupDetail</c:when>
	<c:when test="${nameValue == 'authGroupNew'}">${pageContext.request.contextPath}/system/authgroup/authGroupNew</c:when>
	<c:when test="${nameValue == 'authAddListModal'}">${pageContext.request.contextPath}/system/authgroup/popup/authAddListModal</c:when>
	<c:when test="${nameValue == 'authAddListPop'}">${pageContext.request.contextPath}/system/authgroup/popup/authAddListPop</c:when>
	<c:when test="${nameValue == 'empAddListModal'}">${pageContext.request.contextPath}/system/authgroup/popup/empAddListModal</c:when>

	<%-- 직원 관리 --%>
	<c:when test="${nameValue == 'employeeDetailUrl2'}">${pageContext.request.contextPath}/system/employee/employeeDetail</c:when>
	<c:when test="${nameValue == 'beforeDeletePop'}">${pageContext.request.contextPath}/system/employee/popup/beforeDeletePop</c:when>
	<c:when test="${nameValue == 'setIpAcesCtrlPop'}">${pageContext.request.contextPath}/system/employee/popup/setIpAcesCtrlPop</c:when>
	<c:when test="${nameValue == 'ipAcesCtrlHistPop'}">${pageContext.request.contextPath}/system/employee/popup/ipAcesCtrlHistPop</c:when>
	<c:when test="${nameValue == 'authGroupPop'}">${pageContext.request.contextPath}/system/employee/popup/authGroupPop</c:when>
	<c:when test="${nameValue == 'userDetailPop'}">${pageContext.request.contextPath}/system/employee/popup/userDetailPop</c:when>
	<c:when test="${nameValue == 'loginHistPop'}">${pageContext.request.contextPath}/system/employee/popup/loginHistPop</c:when>
	<c:when test="${nameValue == 'MKTStorePopupList'}">${pageContext.request.contextPath}/system/employee/popup/storeListPop</c:when>
	<c:when test="${nameValue == 'employeeNew'}">${pageContext.request.contextPath}/system/employee/departmentsEmployeeNew</c:when>

	<%-- 부서 및 매장관리 --%>
	<c:when test="${nameValue == 'departmentsEmployeeUrlNew'}">${pageContext.request.contextPath}/marketing/departments/include/departmentsEmployeeNew</c:when>
	<c:when test="${nameValue == 'departmentsInfoUrl'}">${pageContext.request.contextPath}/marketing/departments/include/departmentsInfo</c:when>
	<c:when test="${nameValue == 'departmentsEmployeeUrl'}">${pageContext.request.contextPath}/marketing/departments/include/departmentsEmployee</c:when>
	<c:when test="${nameValue == 'employeeDetailUrl'}">${pageContext.request.contextPath}/marketing/departments/include/employeeDetail</c:when>
	<c:when test="${nameValue == 'employee'}">${pageContext.request.contextPath}/marketing/employee/departmentsEmployee</c:when>

	<%-- 용어사전 관리 --%>
	<c:when test="${nameValue == 'wordDictionaryList'}">${pageContext.request.contextPath}/system/wordDictionary/wordDictionaryList</c:when>
	<c:when test="${nameValue == 'wordDictionaryDetail'}">${pageContext.request.contextPath}/system/wordDictionary/wordDictionaryDetail</c:when>

	<%-- LOY캠페인 --%>
  	<c:when test="${nameValue == 'campaignTempPopLoy'}">${pageContext.request.contextPath}/loyalty/campaign/popup/campaignTempPop</c:when>

	<%-- 전자결재 --%>
	<c:when test="${nameValue == 'contentListPopAppr'}">${pageContext.request.contextPath}/marketing/approval/popup/contentListPop</c:when>

	<%-- SNS인증키 등록 --%>
	<c:when test="${nameValue == 'snsAuthKeyPop'}">${pageContext.request.contextPath}/system/auth/popup/snsAuthKeyPop</c:when>
	<c:when test="${nameValue == 'naverLogin'}">${pageContext.request.contextPath}/external/naverservice/naverLogin.do</c:when>
	
	<%-- 홈화면 --%>
	<c:when test="${nameValue == 'campaignHome'}">${pageContext.request.contextPath}/marketing/campaignhome/campaignHome</c:when>
	<c:when test="${nameValue == 'previewNoticeBo'}">${pageContext.request.contextPath}/marketing/campaignhome/popup/previewNoticeBo</c:when>

	<%-- 클럽 --%>
	<c:when test="${nameValue == 'clubList'}">${pageContext.request.contextPath}/loyalty/club/clubList</c:when>
	<c:when test="${nameValue == 'clubDetail'}">${pageContext.request.contextPath}/loyalty/club/clubDetail</c:when>
	<c:when test="${nameValue == 'clubAttrList'}">${pageContext.request.contextPath}/loyalty/club/include/clubAttrList</c:when>
	<c:when test="${nameValue == 'clubOfferList'}">${pageContext.request.contextPath}/loyalty/club/include/clubOfferList</c:when>
	<c:when test="${nameValue == 'clubMbrList'}">${pageContext.request.contextPath}/loyalty/club/include/clubMbrList</c:when>
	<c:when test="${nameValue == 'clubLoyPgmListPop'}">${pageContext.request.contextPath}/loyalty/club/popup/clubLoyPgmListPop</c:when>
	<c:when test="${nameValue == 'clubAttrDetailPop'}">${pageContext.request.contextPath}/loyalty/club/popup/clubAttrDetailPop</c:when>
	<c:when test="${nameValue == 'clubOfferDetailPop'}">${pageContext.request.contextPath}/loyalty/club/popup/clubOfferDetailPop</c:when>
	<c:when test="${nameValue == 'clubMbrDetailPop'}">${pageContext.request.contextPath}/loyalty/club/popup/clubMbrDetailPop</c:when>
	<c:when test="${nameValue == 'reasonRgstPop'}">${pageContext.request.contextPath}/loyalty/club/popup/reasonRgstPop</c:when>
	<c:when test="${nameValue == 'showImgPop'}">${pageContext.request.contextPath}/loyalty/club/popup/showImgPop</c:when>
	<%-- 회원(공통) --%>
	<c:when test="${nameValue == 'mbrListPop'}">${pageContext.request.contextPath}/common/view/popup/mbrListPop</c:when>
	<%-- 고객식별관리(중복룰) --%>
	<c:when test="${nameValue == 'custDiList'}">${pageContext.request.contextPath}/loyalty/custdi/custDiList</c:when>
	<c:when test="${nameValue == 'custDiDetail'}">${pageContext.request.contextPath}/loyalty/custdi/custDiDetail</c:when>
	<c:when test="${nameValue == 'custDiVal'}">${pageContext.request.contextPath}/loyalty/custdi/include/custDiVal</c:when>
	<c:when test="${nameValue == 'duplResult'}">${pageContext.request.contextPath}/loyalty/custdi/include/duplResult</c:when>
	<c:when test="${nameValue == 'custDiValPop'}">${pageContext.request.contextPath}/loyalty/custdi/popup/custDiValPop</c:when>
	<c:when test="${nameValue == 'dupRstDetailPop'}">${pageContext.request.contextPath}/loyalty/custdi/popup/dupRstDetailPop</c:when>

	<%-- 오퍼 쿠폰--%>
	<c:when test="${nameValue == 'offerCoupon'}">${pageContext.request.contextPath}/offer/include/offerCoupon</c:when>
	<c:when test="${nameValue == 'offerCouponDetail'}">${pageContext.request.contextPath}/offer/include/offerCouponDetail</c:when>
	<c:when test="${nameValue == 'offerCouponExtAttr'}">${pageContext.request.contextPath}/offer/include/offerCouponExtAttr</c:when>
	<c:when test="${nameValue == 'offerCouponStatus'}">${pageContext.request.contextPath}/offer/include/offerCouponStatus</c:when>
	<c:when test="${nameValue == 'offerCouponGifts'}">${pageContext.request.contextPath}/offer/include/offerCouponGifts</c:when>
	<c:when test="${nameValue == 'offerCouponGuide'}">${pageContext.request.contextPath}/offer/include/offerCouponGuide</c:when>
	<c:when test="${nameValue == 'loyCouponList'}">${pageContext.request.contextPath}/loyalty/trans/loyCouponList</c:when>
	<c:when test="${nameValue == 'mbrcpnListNew'}">${pageContext.request.contextPath}/loyalty/member/mbr/include/mbrcpnListNew</c:when>
	<c:when test="${nameValue == 'mbrCouponListNew'}">${pgeContext.request.contextPath}/loyalty/member/mbr/include/mbrCouponListNew</c:when>
    <c:when test="${nameValue == 'getGiftsListPop'}">${pageContext.request.contextPath}/offer/popup/getGiftsListPopup</c:when>
    <c:when test="${nameValue == 'offerJoinChnlExcelPop'}">${pageContext.request.contextPath}/offer/popup/offerJoinChnlExcelPop</c:when>
    <c:when test="${nameValue == 'offerJoinProdExcelPop'}">${pageContext.request.contextPath}/offer/popup/offerJoinProdExcelPop</c:when>
    <c:when test="${nameValue == 'offerJoinProdNotExcelPop'}">${pageContext.request.contextPath}/offer/popup/offerJoinProdNotExcelPop</c:when>



	<%-- 데이터셋 관리--%>
	<c:when test="${nameValue == 'dataSetDetail'}">${pageContext.request.contextPath}/system/dataset/dataSetDetail</c:when>
	<c:when test="${nameValue == 'dataSetItemList'}">${pageContext.request.contextPath}/system/dataset/include/dataSetItemList</c:when>
	<c:when test="${nameValue == 'dataSetMasterList'}">${pageContext.request.contextPath}/system/dataset/dataSetMasterList</c:when>
	<c:when test="${nameValue == 'addDataSetItemPop'}">${pageContext.request.contextPath}/system/dataset/popup/addDataSetItemPop</c:when>
    <c:when test="${nameValue == 'datasetNameSetPop'}">${pageContext.request.contextPath}/system/dataset/popup/datasetNameSetPop</c:when>
    <c:when test="${nameValue == 'datasetNameItemSetPop'}">${pageContext.request.contextPath}/system/dataset/popup/datasetNameItemSetPop</c:when>
    <c:when test="${nameValue == 'srcQueryPop'}">${pageContext.request.contextPath}/system/dataset/popup/srcQueryPop</c:when>
    

	<%-- 고객 세그먼트--%>
	<c:when test="${nameValue == 'custSegmentMartList'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentMartList</c:when>
	<c:when test="${nameValue == 'custSegmentMartDetail'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentMartDetail</c:when>
	<c:when test="${nameValue == 'segmentLogicalPop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/segmentLogicalPop</c:when>
	<c:when test="${nameValue == 'custSegmentRuleListNew'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentRuleListNew</c:when>
	<c:when test="${nameValue == 'custSegmentRuleDetail'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentRuleDetail</c:when>
	<c:when test="${nameValue == 'custSegmentRulePop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/custSegmentRulePop</c:when>
	<c:when test="${nameValue == 'custSegmentListNew'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentListNew</c:when>
	<c:when test="${nameValue == 'custSegmentDetailNew'}">${pageContext.request.contextPath}/kepler/customerSegment/custSegmentDetailNew</c:when>
	<c:when test="${nameValue == 'custSegmentStageList'}">${pageContext.request.contextPath}/kepler/customerSegment/include/custSegmentStageList</c:when>
	<c:when test="${nameValue == 'custSegmentStagePop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/custSegmentStagePop</c:when>
	<c:when test="${nameValue == 'segmentRuleLogicalPop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/segmentRuleLogicalPop</c:when>
	<c:when test="${nameValue == 'segmentCreatePop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/segmentCreatePop</c:when>
	<c:when test="${nameValue == 'custSegmentCondPop'}">${pageContext.request.contextPath}/kepler/customerSegment/popup/custSegmentCondPop</c:when>


	<%-- 고객군 관리--%>
	<c:when test="${nameValue == 'tgtGrpDetail'}">${pageContext.request.contextPath}/loyalty/targetgrp/tgtGrpDetail</c:when>
	<c:when test="${nameValue == 'tgtGrpXmList'}">${pageContext.request.contextPath}/loyalty/targetgrp/include/tgtGrpXmList</c:when>
	<c:when test="${nameValue == 'tgtGrpXmExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/targetgrp/popup/tgtGrpXmExcelUploadPop</c:when>
	<c:when test="${nameValue == 'targetGrpList'}">${pageContext.request.contextPath}/loyalty/targetgrp/targetGrpList</c:when>

	<%-- 상품군 관리--%>
	<c:when test="${nameValue == 'prodGrpList'}">${pageContext.request.contextPath}/loyalty/prodgrp/prodGrpList</c:when>
	<c:when test="${nameValue == 'prodGrpDetail'}">${pageContext.request.contextPath}/loyalty/prodgrp/prodGrpDetail</c:when>
	<c:when test="${nameValue == 'prodExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/prodgrp/popup/prodExcelUploadPop</c:when>
	<c:when test="${nameValue == 'prodGrpItemList'}">${pageContext.request.contextPath}/loyalty/prodgrp/include/prodGrpItemList</c:when>
	<c:when test="${nameValue == 'prodGrpCategoryList'}">${pageContext.request.contextPath}/loyalty/prodgrp/include/prodGrpCategoryList</c:when>
	<c:when test="${nameValue == 'categoryExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/prodgrp/popup/categoryExcelUploadPop</c:when>


	<%-- 채널군 관리--%>
	<c:when test="${nameValue == 'chnlGrpList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/chnlGrpList</c:when>
	<c:when test="${nameValue == 'chnlGrpDetail'}">${pageContext.request.contextPath}/loyalty/chnlgrp/chnlGrpDetail</c:when>
	<c:when test="${nameValue == 'chnlExcelUploadPop'}">${pageContext.request.contextPath}/loyalty/chnlgrp/popup/chnlExcelUploadPop</c:when>
	<c:when test="${nameValue == 'chnlGrpItemList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/include/chnlGrpItemList</c:when>
	<c:when test="${nameValue == 'chnlGrpExcList'}">${pageContext.request.contextPath}/loyalty/chnlgrp/include/chnlGrpExcList</c:when>
	<c:when test="${nameValue == 'addChnlMultiExc'}">${pageContext.request.contextPath}/loyalty/chnlgrp/popup/addChnlMultiExc</c:when>


	<%-- 프로모션 반응--%>
	<c:when test="${nameValue == 'promReactionDetail'}">${pageContext.request.contextPath}/loyalty/promreaction/promReactionDetail</c:when>
	<c:when test="${nameValue == 'promReactionList'}">${pageContext.request.contextPath}/loyalty/promreaction/promReactionList</c:when>
	<c:when test="${nameValue == 'promMbrCalc'}">${pageContext.request.contextPath}/loyalty/promreaction/include/promMbrCalc</c:when>

	<%-- 쿠폰 --%>
	<c:when test="${nameValue == 'couponUploadPop'}">${pageContext.request.contextPath}/loyalty/coupon/popup/couponUploadPop</c:when>
	
	<%-- 관리자 알림내역 --%>
	<c:when test="${nameValue == 'systemAlertDetailPop'}">${pageContext.request.contextPath}/system/alert/popup/systemAlertDetailPop</c:when>
	
	<%-- 사이트 관리 --%>
	<c:when test="${nameValue == 'systemMgtList'}">${pageContext.request.contextPath}/system/systemmgt/systemMgtList</c:when>
	<c:when test="${nameValue == 'systemMgtDetail'}">${pageContext.request.contextPath}/system/systemmgt/systemMgtDetail</c:when>
	
	<%-- 공지사항(BO) --%>
	<c:when test="${nameValue == 'noticeBoList'}">${pageContext.request.contextPath}/system/noticebo/noticeBoList</c:when>
	<c:when test="${nameValue == 'noticeBoDetailPop'}">${pageContext.request.contextPath}/system/noticebo/popup/noticeBoDetailPop</c:when>

	<%-- 도로명 주소 관리 --%>
	<c:when test="${nameValue == 'roadAddressExcelUploadPop'}">${pageContext.request.contextPath}/system/roadaddress/popup/roadAddressExcelUploadPop</c:when>

	<%-- 운영정책관리 --%>
	<c:when test="${nameValue == 'oprPlcySubGridList1'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/oprPlcySubGridList1</c:when>
	<c:when test="${nameValue == 'addOperationPolicyPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/addOperationPolicyPop</c:when>	
	<c:when test="${nameValue == 'updateOperationPolicyPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/updateOperationPolicyPop</c:when>
	<c:when test="${nameValue == 'loyaltyListPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/loyaltyListPop</c:when>
	<c:when test="${nameValue == 'oprDtlHist'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/oprDtlHist</c:when>
	
	<c:when test="${nameValue == 'addOperationPolicyDetailPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/addOperationPolicyDetailPop</c:when>	
	<c:when test="${nameValue == 'updateOperationPolicyDetailPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/updateOperationPolicyDetailPop</c:when>
	<c:when test="${nameValue == 'oprPlcyAttrCodeListPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/oprPlcyAttrCodeListPop</c:when>

	<c:when test="${nameValue == 'contentListNewPop'}">${pageContext.request.contextPath}/loyalty/operationpolicymgt/popup/contentListNewPop</c:when>


	<%-- 매장용 리포트 --%>

	<c:when test="${nameValue == 'brandStoreListPop'}">${pageContext.request.contextPath}/marketing/storeReport/popup/brandStoreListPop</c:when>
	<c:when test="${nameValue == 'brandListPop'}">${pageContext.request.contextPath}/marketing/storeReport/popup/brandListPop</c:when>
	<c:when test="${nameValue == 'explainTextPop'}">${pageContext.request.contextPath}/marketing/storeReport/popup/explainTextPop</c:when>

	<c:otherwise>
        ${pageContext.request.contextPath}${pre}/${name}
    </c:otherwise>
</c:choose>