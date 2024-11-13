package com.icignal.onlineapproval.mapper;


import java.util.HashMap;
import java.util.List;

import com.icignal.onlineapproval.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.membership.dto.request.LoyMbrTiersDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTierApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalAdminDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalAdminListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmailTargetReqtDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalUpdateReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemDeleteReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemRejectReqDto;
import com.icignal.onlineapproval.dto.request.ApproverListReqDto;
import com.icignal.onlineapproval.dto.request.ApprvReqReqDto;
import com.icignal.onlineapproval.dto.request.AprvCountReqDto;
import com.icignal.onlineapproval.dto.request.AprvReportReqDto;
import com.icignal.onlineapproval.dto.request.AprvTemplateReqDto;
import com.icignal.onlineapproval.dto.request.CommonApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ManualDtlValidCheckReqDto;


@Mapper
public interface OnlineApprMapper {

	public String createAprvNo(ApprovalInsertReqDto reqDto);

	public void insertApproval(ApprovalInsertReqDto reqDto);

	public String selectRefItemSeq(ApproverItemInsertReqDto reqDto);
	
	public String selectItemSeq(ApproverItemInsertReqDto reqDto);

	public void updateItemType(ApproverItemInsertReqDto reqDto);

	public void insertItemApproval(ApproverItemInsertReqDto reqDto);

	public List<ApprovalListResDto> selectMyElapproval(ApprovalListReqDto reqDto);

	public List<ApprovalListResDto> selectMyElapproval2(ApprovalListReqDto reqDto);

	public List<ApprovalListResDto> selectRefElapproval(ApprovalListReqDto reqDto);

	public List<ApprovalDetailResDto> selectDetailAprv(ApprovalDetailReqDto reqDto);

	public List<ApprovalDetailResDto> selectDetailAprvByCamId(ApprovalDetailReqDto reqDto);

	public List<ApprvReqResDto> selectAprvList(ApprvReqReqDto reqDto);

	public List<ApprvReqResDto> selecReftAprvList(ApprvReqReqDto reqDto);

	public List<ApprvCamListResDto> selectCampaign(ApprvReqReqDto reqDto);

	public String selectElCode(ApprovalUpdateReqDto reqDto);

	public void updateItemReStatusType(ApprovalUpdateReqDto reqDto);

	public ApproverItemInsertReqDto selectSeqOne(ApprovalUpdateReqDto reqDto);

	public void deleteItemLogSave(ApprovalUpdateReqDto reqDto);

	public void updateItemStatusType(ApprovalUpdateReqDto reqDto);

	public void updateAprvType(ApprovalUpdateReqDto reqDto);

	public void deleteElapproval(ApprovalReqDto reqDto);

	public List<ApprovalEmpListResDto> selectApproverList(ApprovalEmpListReqDto reqDto);

	public ApprovalEmpResDto selectMember(ApprovalEmpReqDto reqDto);

	public void deleteItem(ApproverItemDeleteReqDto mid);

	public List<ApprvReqResDto> selectApproverStatus(ApprvReqReqDto mer);

	public void updateReject(ApproverItemRejectReqDto majr);

	public void updateReStatus(ApproverItemRejectReqDto majr);

	public AprvCountResDto selectMyRefCount(AprvCountReqDto mer);

	public AprvCountResDto selectMyAgreeCount(AprvCountReqDto mer);

	public AprvCountResDto selectMyAprvCount(AprvCountReqDto mer);

	public void updateItem(ApproverItemDeleteReqDto mid);

	public CommonReqApprovalMstInfoResDto selectReqApprovalMstInfo(CommonApprovalReqDto param);

	public String selectEmpEmail(String param);

	public String selectTableRecordExist(CommonApprovalReqDto param);

	public void insertApprovalHeader(CommonApprovalReqDto param);

	public void insertApprovalItem(ApproverListReqDto param);

	public void insertApprovalItem2(CommonApprovalReqDto param);

	public List<ApprovalAdminListResDto> selectApprovalAdminList(ApprovalAdminListReqDto mer);

	public ApprovalAdminDetailResDto selectApprovalAdminDetail(ApprovalAdminDetailReqDto mer);

	public void insertApprovalAdminDetail(ApprovalAdminDetailReqDto param);

	public void updateApprovalAdminDetail(ApprovalAdminDetailReqDto param);

	public void deleteApprovalAdminDetail(ApprovalAdminDetailReqDto param);

	public ManualDtlValidCheckReqDto selectMenualApproval(CommonApprovalReqDto param);

	public ApproverListResDto selectApproverDetail(ApproverListReqDto param);

	public AprvTemplateResDto selectMailTemplate(AprvTemplateReqDto param);

	public ApprovalEmailTargetResDto selectEmailTargetInfo(ApprovalEmailTargetReqtDto targetReq);

	public ApprovalEmailInfoResDto selectEmailInfo(ApprovalEmailTargetReqtDto targetReq);

	public int editLastItemApproval(ApproverItemInsertReqDto mir);

	public String getApproverCount(ApproverItemInsertReqDto mir);

	public List<ApproverItemInsertReqDto> getRequiredItemApproval(ApproverItemInsertReqDto mir);

	public List<ApproverItemInsertReqDto> getNoRequiredItemApproval(ApproverItemInsertReqDto mir);

	public int setApprovalItemSave(ApproverListReqDto param);

	public int removeApprovalHeaderCampaign(CommonApprovalReqDto param);

	public void removeApprovalItemCampaign(CommonApprovalReqDto param);

	public CommonReqApprovalMstInfoResDto getReqApprovalMstInfo(CommonApprovalReqDto param);

	public String selectRejectNxId(ApproverItemRejectReqDto majr);

	public HashMap<String, String> getCampaignInfoByElecAprvId(ApprovalEmailInfoResDto infoRes);

	public List<ApprovalResDto> selectElapproval(ApprovalReqDto mer);

	public void updateElapproval(ApprovalUpdateReqDto mer);

	public List<AprvReportAprvResDto> selectApprovalList(AprvReportReqDto param);

	public AprvReportCampaignResDto selectCampaignDefaultInfo(AprvReportReqDto param);

	public AprvReportOfferResDto selectOfferInfo(AprvReportReqDto param);

	public AprvReportCoupnResDto selectCoupnInfo(AprvReportReqDto param);

	public AprvReportTargetingResDto selectTargetingInfo(AprvReportReqDto param);

	public AprvReportPromInfoResDto selectPromInfo(AprvReportReqDto param);

	public AprvReportSchedulingResDto selectSchedulingInfo(AprvReportReqDto param);

	public List<AprvReportSchedulingDtlResDto> selectSchedulingDtlList(AprvReportReqDto param);

	public List<AprvReportContsResDto> selectContsList(AprvReportReqDto param);

	public List<AprvReportNodeResDto> selectStartNodeList(AprvReportReqDto param);

	public AprvReportRuleResDto selectRuleInfo(AprvReportReqDto param);

	public AprvReportContsResDto selectContsInfo(AprvReportReqDto param);

	public List<AprvReportCampaignResDto> selectRelCampaignList(AprvReportReqDto param);

	public List<AprvReportNodeResDto> selectChildNodeList(AprvReportReqDto param);

	public String getRefApproverCount(ApproverItemInsertReqDto reqDto);

	public void updateRejectAprv(ApproverItemRejectReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTierApproval
	  * 2. 클래스명: OnlineApprMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	public void insertTierApproval(LoyTierApprovalReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTierApprovalItem
	  * 2. 클래스명: OnlineApprMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	public void insertTierApprovalItem(LoyTierApprovalReqDto reqDto);

	 /*
	  * 1. 메소드명: selectModfiyTier
	  * 2. 클래스명: OnlineApprMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param majr
	 *   @return	
	 */
	
	public LoyMbrTiersDetailReqDto selectModfiyTier(ApproverItemRejectReqDto majr);

	 /*
	  * 1. 메소드명: updateApprovalStatCd
	  * 2. 클래스명: OnlineApprMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param majr	
	 */
	
	public void updateApprovalStatCd(ApproverItemRejectReqDto majr);

	 /*
	  * 1. 메소드명: updateApprovalAttr
	  * 2. 클래스명: OnlineApprMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tierHistReqDto	
	 */
	
	public void updateApprovalAttr(LoyMbrTiersDetailReqDto tierHistReqDto);

	public AprvSendContsResDto getAprvContentsDetail(ApprovalListReqDto reqDto);

	public AprvSendContsResDto getAprvContentsVal(ApprovalListReqDto reqDto);

	public AprvSendContsResDto getMidAprvNo(ApprovalListReqDto reqDto);

	public List<ApprovalEmpListResDto> getStoreManagerInfo(ApprovalEmpListReqDto reqDto);

	public ApprovalEmpListResDto getEmpType(ApprovalEmpListReqDto reqDto);
}
