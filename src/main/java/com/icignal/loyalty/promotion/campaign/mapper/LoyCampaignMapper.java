package com.icignal.loyalty.promotion.campaign.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.promotion.campaign.dto.request.CampaignApprovalReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignContentsChnnelRelReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignDefaultInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutableUserReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutionInfoItemReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutionInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetConidByCamidReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetTempNodeListReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignOfferReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignProgramReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignPromotionExeInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignRemoveReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqtDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignScheduleCheckReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTargetDtlReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTargetReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTgtChnlChkReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowStatusReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowTemplateReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1CardDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1ClbDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1FamDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1FrndDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1JoinDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2AddDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2AgrDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2OnDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2SurDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionActionDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionDefaultInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionKpiDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionRuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1AniDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1RuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1XmRuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa2SumDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionTierActionReqDto;
import com.icignal.loyalty.promotion.campaign.dto.response.CampaignWorkflowStatusListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LOYCampaignListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignApprovalResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignExecutableUserResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetConidByCamidResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetTempNodeListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignOfferListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignPromotionExeInfoResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignScheduleCheckResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyChnlTgtGrpResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyProdTgtGrpResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1CardDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1ClbDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1FamDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1FrndDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1JoinDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2AddDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2AgrDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2ConDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2ConDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2OnDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2SurDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionActionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionActionTierList;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionDefaultInfoResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionKpiDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1AniDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1RuleDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1XmRuleDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa2SumDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionTierActionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyTgtGrpListResDto;
import com.icignal.marketing.campaign.dto.request.MktCampaignContentsChnnelRelReqDto;
import com.icignal.marketing.campaign.dto.response.MktCampaignContentsChnnelRelResDto;


@Mapper
public interface LoyCampaignMapper {


	public List<LoyCampaignGetTempNodeListResDto> getTemp(LoyCampaignGetTempNodeListReqDto dto);

	public List<LoyCampaignGetTempNodeListResDto> getTempNodeList(LoyCampaignGetTempNodeListReqDto dto);

	public Map<String, String> proc_if_ifl_vanPromotionAll_ins(LoyCampaignPromotionExeInfoReqDto param);

	public void updateStopSendingMessagesByCampaignId(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateStopSendingPushByCampaignId(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateStopSendingKakaoByCampaignId(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateCampaignExeInfoStatusActive(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateCampaignExeInfoStatusStop(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateCampaignStatus(LoyCampaignDefaultInfoReqDto mcdir);

	public List<LoyCampaignPromotionExeInfoResDto> selectExeInfoPromActiveList(
			LoyCampaignPromotionExeInfoReqDto promReq);

	public void updateStopSendingEmailByCampaignId(LoyCampaignDefaultInfoReqDto mcdir);

	public void deleteCampaignProgram(LoyCampaignProgramReqDto mcpr);

	public String selectTgtChk(LoyCampaignTgtChnlChkReqDto ccrsr);

	public List<String> selectChnlChk(LoyCampaignTgtChnlChkReqDto ccrsr);

	public Integer selectCampaignWorkflowTemplateCount(LoyCampaignWorkflowTemplateReqDto mcwtr);

	public void updateCampaignWorkflowTemplate(LoyCampaignWorkflowTemplateReqDto mcwtr);

	public void deleteCampaignWorkflowTemplate(LoyCampaignWorkflowTemplateReqDto mcwtr);

	public void updateCampaignTemplateFlag(LoyCampaignWorkflowTemplateReqDto mcwtr);

	public List<LOYCampaignListResDto> getPromotionList(LoyCampaignReqtDto mcr);

	public void insertCampaignOfferRel(LoyCampaignOfferReqDto mcor);

	public void updateCampaignOfferRel(LoyCampaignOfferReqDto mcor);

	public void deleteCampaignOfferRel(LoyCampaignOfferReqDto mcor);

	public void removeCampaign(LoyCampaignRemoveReqDto param);

	public void removeCampaignTemplates(LoyCampaignRemoveReqDto param);

	public LoyCampaignExecutableUserResDto isExecutableUser(LoyCampaignExecutableUserReqDto mceur);

	public String checkChnlExeInfo(LoyCampaignStatusCheckReqDto cscr);

	public String checkChnlExeInfoItem(LoyCampaignStatusCheckReqDto cscr);

	public List<LoyCampaignScheduleCheckResDto> chnlTypeCheck(LoyCampaignStatusCheckReqDto cscr);

	public int chnlTimeValidCheck(LoyCampaignScheduleCheckReqDto reqCamId);

	public String checkOfferInfo(LoyCampaignStatusCheckReqDto cscr);

	public String checkExeInfoItemId(LoyCampaignStatusCheckReqDto cscr);

	public int checkChnlInfo(LoyCampaignStatusCheckReqDto cscr);

	public String checkElecAprov(LoyCampaignStatusCheckReqDto cscr);

	public LoyCampaignApprovalResDto selectCampaignApproval(CampaignApprovalReqDto mcar);

	public LoyPromotionDefaultInfoResDto selectCampaignDefaultInfo(LoyCampaignReqDto camReq);

	public void procCamCopy(LoyCampaignReqDto param);

	public List<LoyCampaignGetConidByCamidResDto> selectConidByCamid(LoyCampaignGetConidByCamidReqDto param);

	public List<LoyCampaignOfferListResDto> selectCampaignOfferList(LoyCampaignOfferReqDto mcor);

	public void deleteCampaignOfferRelByCampaignId(LoyCampaignOfferReqDto mcor);

	public void deleteCampaignContentsChnnelRel(LoyCampaignContentsChnnelRelReqDto mcccrr);

	public void deleteCampaignContents(LoyCampaignContentsChnnelRelReqDto mcccrr);

	public void deleteCampaignTargetByCampaignId(LoyCampaignTargetReqDto mctr);

	public void deleteCampaignTargetDtlByCampaignId(LoyCampaignTargetDtlReqDto mctdr);

	public void deleteExecutionInfo(LoyCampaignExecutionInfoReqDto mceir);

	public void deleteExecutionInfoItemByExeInfoId(LoyCampaignExecutionInfoItemReqDto mceiir);

	public void deleteExecutionInfoByCampaignId(LoyCampaignExecutionInfoReqDto mceir);

	public void deleteExecutionInfoItemByCampaignId(LoyCampaignExecutionInfoItemReqDto mceiir);

	public void insertCampaignWorkflowStatus(LoyCampaignWorkflowStatusReqDto mcwsr);

	public void updateCampaignWorkflowStatus(LoyCampaignWorkflowStatusReqDto mcwsr);

	public void updateCampaignWorkflowRel(LoyCampaignWorkflowReqDto mcwr);

	public List<CampaignWorkflowStatusListResDto> selectCampaignWorkflowStatusList(
			LoyCampaignWorkflowStatusReqDto mcwsr);

	public void deleteAllCampaignWorkflowStatusByWorkflowId(LoyCampaignWorkflowStatusReqDto mcwsr);

	public String selectCampaignStatus(LoyCampaignReqDto mcr);

	public void updateCampaignMaster(LoyCampaignDefaultInfoReqDto mcdir);

	public void insertCampaignMaster(LoyCampaignDefaultInfoReqDto mcdir);

	public void updateCampaignDefaultInfoDesc(LoyCampaignDefaultInfoReqDto mcdir);

	 /*
	  * 1. 메소드명: selectPromotionListNew
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyPromotionListResDto> selectPromotionListNew(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromotionStatus
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public String selectPromotionStatus(LoyPromotionDefaultInfoReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionMaster
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionMaster(LoyPromotionDefaultInfoReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionMaster
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionMaster(LoyPromotionDefaultInfoReqDto mcr);

	 /*
	  * 1. 메소드명: selectTgtGrpIncList
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyTgtGrpListResDto> selectTgtGrpIncList(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionKpi
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionKpi(LoyPromotionKpiDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionKpi
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionKpi(LoyPromotionKpiDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromKpiInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionKpiDetailResDto selectPromKpiInfo(LoyPromotionKpiDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectActionTierList
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyPromotionActionTierList> selectActionTierList(LoyPromotionDefaultInfoReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAction
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAction(LoyPromotionActionDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAction
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAction(LoyPromotionActionDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionTierAction
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tierAction	
	 */
	
	public void insertPromotionTierAction(LoyPromotionTierActionReqDto tierAction);

	 /*
	  * 1. 메소드명: updatePromotionTierAction
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tierAction	
	 */
	
	public void updatePromotionTierAction(LoyPromotionTierActionReqDto tierAction);

	 /*
	  * 1. 메소드명: selectPromActionInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionActionDetailResDto selectPromActionInfo(LoyPromotionActionDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromTierAction
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public ArrayList<LoyPromotionTierActionDetailResDto> selectPromTierAction(LoyPromotionActionDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteActionTier
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteActionTier(LoyPromotionTierActionReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromRuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionDetailResDto selectPromRuleInfo(LoyPromotionTierActionReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotion
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotion(LoyPromotionRuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionSa1Rule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionSa1Rule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionSa1Rule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionSa1Rule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionSa1XmRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sa1XmRule	
	 */
	
	public void insertPromotionSa1XmRule(LoyPromotionSa1XmRuleDetailReqDto sa1XmRule);

	 /*
	  * 1. 메소드명: updatePromotionSa1XmRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sa1XmRule	
	 */
	
	public void updatePromotionSa1XmRule(LoyPromotionSa1XmRuleDetailReqDto sa1XmRule);

	 /*
	  * 1. 메소드명: selectChnlTgtGrpList
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyChnlTgtGrpResDto> selectChnlTgtGrpList(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectProdTgtGrpList
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyProdTgtGrpResDto> selectProdTgtGrpList(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromSa1RuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionSa1RuleDetailResDto selectPromSa1RuleInfo(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromSa1XmRuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public ArrayList<LoyPromotionSa1XmRuleDetailResDto> selectPromSa1XmRuleInfo(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteRuleSa1Xm
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteRuleSa1Xm(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteSa1Rule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteSa1Rule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromType
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromType(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromotionSa1AniRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionSa1AniDetailResDto selectPromSa1AniDetail(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionSa1AniRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionSa1AniRule(LoyPromotionSa1AniDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionSa1AniRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionSa1AniRule(LoyPromotionSa1AniDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc2ConRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc2ConRule(LoyPromotionAc2ConDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc2ConRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc2ConRule(LoyPromotionAc2ConDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteSa1AniRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteSa1AniRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc2ConRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc2ConRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc2AgrRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc2AgrRule(LoyPromotionAc2AgrDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc2AgrRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc2AgrRule(LoyPromotionAc2AgrDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc2ConDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc2ConDetailResDto selectPromAc2ConDetail(LoyPromotionAc2ConDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc2AgrDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc2AgrDetailResDto selectPromAc2AgrDetail(LoyPromotionAc2AgrDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc2SurRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc2SurRule(LoyPromotionAc2SurDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc2SurRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc2SurRule(LoyPromotionAc2SurDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionSa2SumRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sa2SumRule	
	 */
	
	public void insertPromotionSa2SumRule(LoyPromotionSa2SumDetailReqDto sa2SumRule);

	 /*
	  * 1. 메소드명: updatePromotionSa2SumRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sa2SumRule	
	 */
	
	public void updatePromotionSa2SumRule(LoyPromotionSa2SumDetailReqDto sa2SumRule);

	 /*
	  * 1. 메소드명: insertPromotionAc2OnRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ac2OnRule	
	 */
	
	public void insertPromotionAc2OnRule(LoyPromotionAc2OnDetailReqDto ac2OnRule);

	 /*
	  * 1. 메소드명: updatePromotionAc2OnRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ac2OnRule	
	 */
	
	public void updatePromotionAc2OnRule(LoyPromotionAc2OnDetailReqDto ac2OnRule);

	 /*
	  * 1. 메소드명: selectPromSa2SumRuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public ArrayList<LoyPromotionSa2SumDetailResDto> selectPromSa2SumRuleInfo(LoyPromotionSa2SumDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc2OnRuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public ArrayList<LoyPromotionAc2OnDetailResDto> selectPromAc2OnRuleInfo(LoyPromotionAc2OnDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc2AddRuleInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public ArrayList<LoyPromotionAc2AddDetailResDto> selectPromAc2AddRuleInfo(LoyPromotionAc2AddDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc2AddRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ac2AddRule	
	 */
	
	public void insertPromotionAc2AddRule(LoyPromotionAc2AddDetailReqDto ac2AddRule);

	 /*
	  * 1. 메소드명: updatePromotionAc2AddRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ac2AddRule	
	 */
	
	public void updatePromotionAc2AddRule(LoyPromotionAc2AddDetailReqDto ac2AddRule);

	 /*
	  * 1. 메소드명: insertPromotionAc1JoinRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc1JoinRule(LoyPromotionAc1JoinDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc1JoinRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc1JoinRule(LoyPromotionAc1JoinDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc1FrndRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc1FrndRule(LoyPromotionAc1FrndDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc1FrndRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc1FrndRule(LoyPromotionAc1FrndDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc1FrndDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1FrndDetailResDto selectPromAc1FrndDetail(LoyPromotionAc1FrndDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc1JoinDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1JoinDetailResDto selectPromAc1JoinDetail(LoyPromotionAc1JoinDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc1FamRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc1FamRule(LoyPromotionAc1FamDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc1FamRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc1FamRule(LoyPromotionAc1FamDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc1FamDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1FamDetailResDto selectPromAc1FamDetail(LoyPromotionAc1FamDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc1CardDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1CardDetailResDto selectPromAc1CardDetail(LoyPromotionAc1CardDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc1CardRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc1CardRule(LoyPromotionAc1CardDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc1CardRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc1CardRule(LoyPromotionAc1CardDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc1ClbDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1ClbDetailResDto selectPromAc1ClbDetail(LoyPromotionAc1ClbDetailReqDto mcr);

	 /*
	  * 1. 메소드명: insertPromotionAc1ClbRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void insertPromotionAc1ClbRule(LoyPromotionAc1ClbDetailReqDto mcr);

	 /*
	  * 1. 메소드명: updatePromotionAc1ClbRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void updatePromotionAc1ClbRule(LoyPromotionAc1ClbDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromAc2SurDetail
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc2SurDetailResDto selectPromAc2SurDetail(LoyPromotionAc2SurDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteSa1XmRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteSa1XmRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc2AgrRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc2AgrRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc2SurRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc2SurRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteSa2SumRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteSa2SumRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc2OnRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc2OnRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc2AddRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc2AddRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc1JoinRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc1JoinRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc1FrndRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc1FrndRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc1FamRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc1FamRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc1CardRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc1CardRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteAc1ClbRule
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteAc1ClbRule(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteRuleAc2Add
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteRuleAc2Add(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteRuleSa2Sum
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteRuleSa2Sum(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteRuleAc2On
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteRuleAc2On(LoyPromotionSa1RuleDetailReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromotionActionInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcwr
	 *   @return	
	 */
	
	public LoyPromotionActionDetailResDto selectPromotionActionInfo(LoyCampaignReqDto mcwr);

	 /*
	  * 1. 메소드명: selectPromStatCd
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public String selectPromStatCd(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulSa1GenInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionSa1RuleDetailResDto selectPrulSa1GenInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulSa1AniInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionSa1AniDetailResDto selectPrulSa1AniInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulSa2SumInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionSa2SumDetailResDto selectPrulSa2SumInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulAc1JoinInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1JoinDetailResDto selectPrulAc1JoinInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulAc1FamInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1FamDetailResDto selectPrulAc1FamInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulAc1ClbInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1ClbDetailResDto selectPrulAc1ClbInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulAc1CardInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1CardDetailResDto selectPrulAc1CardInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: selectPrulAc1FrndInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionAc1FrndDetailResDto selectPrulAc1FrndInfo(LoyCampaignReqDto mcr);

	 /*
	  * 1. 메소드명: deletePromotionActionTier
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deletePromotionActionTier(LoyPromotionActionDetailReqDto mcr);

	 /*
	  * 1. 메소드명: deleteActionTierItem
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	public void deleteActionTierItem(LoyPromotionTierActionReqDto mcr);

	 /*
	  * 1. 메소드명: selectPromotionListPop
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public List<LoyPromotionListResDto> selectPromotionListPop(LoyCampaignReqtDto mcr);

	 /*
	  * 1. 메소드명: deleteCampaignContentsChnnelRel
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr	
	 */
	
	public void deleteCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

	 /*
	  * 1. 메소드명: deleteCampaignContents
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr	
	 */
	
	public void deleteCampaignContents(MktCampaignContentsChnnelRelReqDto mcccrr);

	 /*
	  * 1. 메소드명: updateCampaignContentsChnnelRel
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr	
	 */
	
	public void updateCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

	 /*
	  * 1. 메소드명: updateCampaignContents
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr	
	 */
	
	public void updateCampaignContents(MktCampaignContentsChnnelRelReqDto mcccrr);

	 /*
	  * 1. 메소드명: insertCampaignContentsChnnelRel
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr	
	 */
	
	public void insertCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

	 /*
	  * 1. 메소드명: selectCampaignContentsChnnelRel
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcccrr
	 *   @return	
	 */
	
	public MktCampaignContentsChnnelRelResDto selectCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

	MktCampaignContentsChnnelRelResDto selectBuyNotiYn ();

	MktCampaignContentsChnnelRelResDto selectPromBuyNotiYn ();

	 /*
	  * 1. 메소드명: selectPromInfo
	  * 2. 클래스명: LoyCampaignMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr
	 *   @return	
	 */
	
	public LoyPromotionActionDetailResDto selectPromInfo(LoyPromotionActionDetailReqDto mcr);

}
