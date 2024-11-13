 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.loyalty.membership.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.icignal.loyalty.membership.dto.response.*;
import com.icignal.systemmanagement.apispec.dto.vo.LoyHistArrayVo;
import com.icignal.systemmanagement.apispec.dto.vo.LoyMbrDeleteVo;
import com.icignal.systemmanagement.apispec.dto.vo.LoyMbrPushHistVo;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.response.LoyCampaignExecListResDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyMbrPtnTxnHistReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyPointAcrlRequestDTO;
import com.icignal.loyalty.benefit.point.dto.request.LoyPointRdmRequestDTO;
import com.icignal.loyalty.benefit.point.dto.response.LoyMbrPtnTxnHistListResDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyCustItemConfReqDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfListResDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyActiveReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyPredUserReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDropMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDropReasonReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDupMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyEmpSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyExecutivesViewReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrCampHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrCarHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChangeHistListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChgHistAddReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChgHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlRelReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDetailInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDivListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrEditPntUsePwReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrFamilyListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupAddInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupClubReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntactPurReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMemberCardListResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMgtInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPasswordReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPntYnReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAcrlReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAuthReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointDropReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointLimitReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProcReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProdCustListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRecomHistoryReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRenameReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnDetailListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTierBenefitHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTiersDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTmAgrHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrUploadItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrVocListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNegativeAccReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNewCustAddReqDto;
import com.icignal.loyalty.membership.dto.request.LoyPontBalanceB2cReqDto;
import com.icignal.loyalty.membership.dto.request.LoySimpleMbrRegProcReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTransPointListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardListResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardResDto;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierReqDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistResDto;



/**
 * 1. FileName	: LoyMbr.java
 * 2. Package	: com.icignal.loyalty.membership.mapper
 * 3. Comments	:
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 6. 오후 3:34:03
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 6.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: LoyMbr
 * 2. 파일명	: LoyMbr.java
 * 3. 패키지명	: com.icignal.loyalty.membership.mapper
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyMbrMapper {

	 /*
	  * 1. 메소드명: selectMbrList
	  * 2. 클래스명: LoyMbr
	  * 3. 작성자명: knlee
	  * 4. 작성일자: 2020. 2. 9.
	  */
	/**
	 * <PRE>
	 * 1. 멤버십 회원 리스트를 조회한다.
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param mbrRequst
	 *   @return
	 */

	public List<LoyMbrResDto> selectMbrList(LoyMbrReqDto reqDto);


	public LoyMbrItemResDto selectMbrDetail(LoyMbrItemReqDto reqDto);

	public LoyPontBalanceB2cReqDto selectPontBalanceB2c(LoyPontBalanceB2cReqDto lpbbr);

	 /*
	  * 1. 메소드명: updateMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param req
	 */

	public void updateMbr(LoyMbrReqDto req);

	 /*
	  * 1. 메소드명: selectMbrstatus
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param req
	 *   @return
	 */

	public LoyMbrResDto selectMbrstatus(LoyMbrReqDto req);

	 /*
	  * 1. 메소드명: selectMbrCardList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
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

	public List<LoyMbrCardResDto> selectMbrCardList(LoyMbrCardReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTierHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrTierHistResDto> selectMbrTierHistList(LoyMbrTierHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrIntactPurList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrIntactPurResDto> selectMbrIntactPurList(LoyMbrIntactPurReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrCampHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrCampHistResDto> selectMbrCampHistList(LoyMbrCampHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrChnlRelList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChnlRelResDto> selectMbrChnlRelList(LoyMbrChnlRelReqDto reqDto);

	 /*
	  * 1. 메소드명: getMbrPwdDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrPasswordResDto selectMbrPwdDetail(LoyMbrPasswordReqDto reqDto);

	 /*
	  * 1. 메소드명: getMbrLoginPwd
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public String getMbrLoginPwd(LoyMbrPasswordReqDto reqDto);

	 /*
	  * 1. 메소드명: mbrPwdLockCheck
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param rid
	 *   @return
	 */

	public Integer mbrPwdLockCheck(String rid);

	 /*
	  * 1. 메소드명: clearMaskDrop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyDropMbrResDto clearMaskDrop(LoyDropMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTierHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrSearchHelpResDto> selectMbrTierHistList(LoyMbrSearchHelpReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrDetailInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrDetailInfoResDto selectMbrDetailInfo(LoyMbrDetailInfoReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrRecomHistoryList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public List<LoyMbrRecomHistoryResDto> selectMbrRecomHistoryList(LoyMbrRecomHistoryReqDto param);

	 /*
	  * 1. 메소드명: selectMbrstatus
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrRecomHistoryResDto selectMbrstatus(LoyMbrRecomHistoryReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrChangeHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChangeHistListResDto> selectMbrChangeHistList(LoyMbrChangeHistListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectDropMbrListCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public Integer selectDropMbrListCnt(LoyDropMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: LoyDropMbrResDto
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyDropMbrResDto> selectDropMbrList(LoyDropMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteMbrDrop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public void deleteMbrDrop(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPointDrop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrPointDropResDto> selectMbrPointDrop(LoyMbrPointDropReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrResDto clearMaskMbr(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectDormancyList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyDormancyResDto> selectDormancyList(LoyDormancyReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustNm
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyDormancyResDto selectCustNm(LoyDormancyReqDto reqDto);

	 /*
	  * 1. 메소드명: activeDorMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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

	public void activeDorMbr(LoyDormancyActiveReqDto reqDto);


	 /*
	  * 1. 메소드명: selectPreDormancyList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyDormancyPredResDto> selectPreDormancyList(LoyDormancyPredUserReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrSearchHelp
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrSearchHelpResDto> selectMbrSearchHelp(LoyMbrSearchHelpReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrGroupResDto> selectMbrGroupList(LoyMbrGroupReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroup
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrGroupResDto selectMbrGroup(LoyMbrGroupReqDto reqDto);


	 /*
	  * 1. 메소드명: selectEmpSearchHelp
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyEmpSearchHelpResDto> selectEmpSearchHelp(LoyEmpSearchHelpReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrRenameReqList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrRenameResDto> selectMbrRenameReqList(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrRenameResDto selectMbrRenameReqDetail(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrRename
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<HashMap<String, String>> selectMbrRename(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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

	public void insertMbrRenameReqDetail(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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

	public void updateMbrRenameReqDetail(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrOrangeCardList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrCardListResDto> selectMbrOrangeCardList(LoyMbrCardListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectChargeYm
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List selectChargeYm(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectChargeList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChargeResDto> selectChargeList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrVocList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrVocListResDto> selectMbrVocList(LoyMbrVocListReqDto reqDto);

	public LoyMbrVocListResDto selectMbrVocListDesc(LoyMbrVocListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectChargeInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChargeResDto> selectChargeInfo(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrStnPntTxnList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrStnPntTxnListResDto> selectMbrStnPntTxnList(LoyMbrStnPntTxnListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrCarHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrCarHistResDto> selectMbrCarHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectEMbrTierHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrTierHistResDto> selectEMbrTierHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPointLimitInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrPointLimitResDto selectMbrPointLimitInfo(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPointLimiList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrPointLimitListResDto> selectMbrPointLimiList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrClubList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrClupListResDto> selectMbrClubList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupCardList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrGroupCardListResDto> selectMbrGroupCardList(LoyMbrGroupCardListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrStnPntTxnDetailList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrStnPntTxnDetailListReqDto> selectMbrStnPntTxnDetailList(LoyMbrStnPntTxnDetailListReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrCarHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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

	public void insertMbrCarHist(LoyMbrCarHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrOrangeCardDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrCardResDto selectMbrOrangeCardDetail(LoyMbrCardReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrPointLimit
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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

	public void updateMbrPointLimit(LoyMbrPointLimitReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrChgHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param chgHistDto
	 */

	public void insertMbrChgHist(LoyMbrChgHistReqDto chgHistDto);


	 /*
	  * 1. 메소드명: selectMbrSignInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrSignInfoResDto selectMbrSignInfo(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrChnlHistListCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public Integer selectMbrChnlHistListCnt(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrChnlHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChnlHistListResDto> selectMbrChnlHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrChnlHistSubList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChnlHistListResDto> selectMbrChnlHistSubList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrGroupeDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrGroupeDetail(LoyMbrGroupReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupAddInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrGroupAddInfoResDto selectMbrGroupAddInfo(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupUserList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrGroupClubListResDto> selectMbrGroupUserList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupPointTxnHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrGroupPointTxnHistListResDto> selectMbrGroupPointTxnHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupCngList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrGroupCngListResDto> selectMbrGroupCngList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: checkDupIdentiVal
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public Integer checkDupIdentiVal(LoyMbrItemReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrCngHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void insertMbrCngHist(LoyMbrChgHistAddReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrDetail(LoyMbrItemReqDto reqDto);


	 /*
	  * 1. 메소드명: updateCustDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateCustDetail(LoyMbrItemReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrGroupStat
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrGroupStat(LoyMbrGroupAddInfoReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrGroupAddInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrGroupAddInfo(LoyMbrGroupAddInfoReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrTmAgrHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void insertMbrTmAgrHist(LoyMbrTmAgrHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTmAgrInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrTmAgrHistListResDto selectMbrTmAgrInfo(LoyMbrTmAgrHistReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrTmAgrHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrTmAgrHist(LoyMbrTmAgrHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrSemiVipHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrSemiVipHistListResDto> selectMbrSemiVipHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrCampaignResListCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public Integer selectMbrCampaignResListCnt(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrCampaignResList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrCampResResDto> selectMbrCampaignResList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrAllCount
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @return
	 */

	public Integer selectMbrAllCount();


	 /*
	  * 1. 메소드명: selectDupMbrList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyDupMbrListResDto> selectDupMbrList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPntUsePw
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public String selectMbrPntUsePw(LoyMbrEditPntUsePwReqDto param);


	 /*
	  * 1. 메소드명: updateMbrPntUsePw
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public int updateMbrPntUsePw(LoyMbrEditPntUsePwReqDto param);


	 /*
	  * 1. 메소드명: clearDupMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyDupMbrListResDto> clearDupMbr(LoyDupMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: insertDropReason
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void insertDropReason(LoyDropReasonReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPntAcrlUseYn
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrPntYnResDto selectMbrPntAcrlUseYn(LoyMbrPntYnReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTransPoint
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyTransPointListResDto> selectTransPoint(LoyTransPointListReqDto reqDto);


	 /*
	  * 1. 메소드명: insertTransHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void insertTransHist(LoyDropReasonReqDto reqDto);


	 /*
	  * 1. 메소드명: transPointExec
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyTransCallExecResDto transPointExec(LoyTransPointListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTransPntHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyTransPntHistResDto> selectTransPntHist(LoyTransPointListReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrName
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void updateMbrName(LoyMbrRenameReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrDivList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public List<LoyMbrDivListResDto> selectMbrDivList(LoyMbrDivListReqDto param);


	 /*
	  * 1. 메소드명: selectMbrUpldItemList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public List<LoyMbrUploadItemResDto> selectMbrUpldItemList(LoyMbrUploadItemReqDto param);


	 /*
	  * 1. 메소드명: clearMaskRecomm
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrRecomHistoryResDto clearMaskRecomm(LoyMbrRecomHistoryReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMaxPointLabel
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrPointAuthResDto selectMaxPointLabel(LoyMbrPointAuthReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrGroupUser
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<HashMap<String, String>> selectMbrGroupUser(LoyMbrGroupClubReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrGroupUser
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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

	public void insertMbrGroupUser(LoyMbrGroupClubReqDto reqDto);


	 /*
	  * 1. 메소드명: dropMbrGroupUser
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void dropMbrGroupUser(LoyMbrGroupClubReqDto reqDto);


	 /*
	  * 1. 메소드명: callLoyProcInsertCard
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 */

	public void callLoyProcInsertCard(LoySimpleMbrRegProcReqDto param);


	 /*
	  * 1. 메소드명: joinMbrProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void joinMbrProc(LoyMbrProcReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrGroupCard
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void insertMbrGroupCard(LoyMbrGroupCardReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrCarHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void updateMbrCarHist(LoyMbrCarHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTmAgrHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrTmAgrHistListResDto> selectMbrTmAgrHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: updateLoyMbrInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void updateLoyMbrInfo(LoyMbrDetailInfoReqDto reqDto);


	 /*
	  * 1. 메소드명: updateLoyCustInfo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void updateLoyCustInfo(LoyMbrDetailInfoReqDto reqDto);


	 /*
	  * 1. 메소드명: dropMbrProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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

	public void dropMbrProc(LoyMbrProcReqDto reqDto);


	 /*
	  * 1. 메소드명: mbrPwdUnLock
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param rid
	 */

	public void mbrPwdUnLock(String rid);


	 /*
	  * 1. 메소드명: callProcMbrTierUpd
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 */

	public void callProcMbrTierUpd(LoyMbrTierReqDto param);


	 /*
	  * 1. 메소드명: delPhoneNum
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 25.
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

	public void delPhoneNum(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrListNewPage
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrListNewPageResDto> selectMbrListNewPage(LoyMbrReqDto reqDto);

	public List<LoyMbrListNewPageResDto> selectMbrListNewPageCnt(LoyMbrReqDto reqDto);


	/*
	  * 1. 메소드명: clearMaskListMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrListNewPageResDto clearMaskListMbr(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPointHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrPtnTxnHistListResDto> selectMbrPointHistList(LoyMbrPtnTxnHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrDetailNewPage
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public LoyMbrDetailNewPageResDto selectMbrDetailNewPage(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectChnlRelHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrChnlRelListResDto> selectChnlRelHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectCouponList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrCouponListResDto> selectCouponList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectAlterHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrAlterHistListResDto> selectAlterHistList(LoyMbrReqDto reqDto);

	/*
	  * 1. 메소드명: selectAllAboutAlterHistConts
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021. 02. 03.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 회원의 알림이력 탭에서 각 알림이력에 대한 '내용(컨텐츠)'에 관련된 것을 모두 조회하는 쿼리  
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyMbrAlterHistContsResDto selectAllAboutAlterHistConts(LoyMbrReqDto reqDto);

	/*
	  * 1. 메소드명: selectTagForAlterHistConts
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021. 02. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 알림이력 내용에 대응되는 태그 내용을 가져오는 메소드  
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyMbrAlterHistContsResDto> selectTagForAlterHistConts(LoyMbrReqDto reqDto);
	

	 /*
	  * 1. 메소드명: selectMemberCardList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrMemberCardListResDto> selectMemberCardList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectBlackHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrBlackHistListResDto> selectBlackHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectRecommendHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrRecommendHistListResDto> selectRecommendHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTierListNew
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrTiersListResDto> selectMbrTierListNew(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: inserNewCust
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	 *	       회원 가입
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	public void inserNewCust(LoyNewCustAddReqDto reqDto);

	public List<LoyMbrEventHistListResDto> selectMbrEventHistListNew(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustItemConfVal
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 *		고객정보수집 항목 가져오기(대표 프로그램)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyCustItemConfListResDto> selectCustItemConfVal(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTxnHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrTxnHistListResDto> selectMbrTxnHistList(LoyMbrReqDto reqDto);


	public List<LoyMbrCouponListResDto> selectMbrCpnListNew(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrOnBoardHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrOnBoardTxnHistListResDto> selectMbrOnBoardHistList(LoyMbrReqDto reqDto);


	public List<LoyMbrCouponListResDto> selectCouponHistList(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: addNewCustomer
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCallAddNewCustResDto addNewCustomer(LoyNewCustAddReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrAgreList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrAgreListResDto> selectMbrAgreList(LoyMbrReqDto reqDto);




	 /*
	  * 1. 메소드명: selectMbrPointExcelHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrPtnTxnHistListResDto> selectMbrPointExcelHistList(LoyMbrPtnTxnHistReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrOnBoardExcelHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public List<LoyMbrOnBoardTxnHistListResDto> selectMbrOnBoardExcelHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrFamilyList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 패밀리 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyMbrFamilyListResDto> selectMbrFamilyList(LoyMbrFamilyListReqDto reqDto);


//	public Integer checkExistFmly(LoyMbrFamilyListReqDto reqDto);
//	public Integer checkNewFmly(LoyMbrFamilyListReqDto reqDto);
//	public void insertNewFmlyMbr(LoyMbrFamilyListReqDto reqDto);


	 /*
	  * 1. 메소드명: checkFmlyChief
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 대표여부 확인
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public Integer checkFmlyChiefCnt(LoyMbrFamilyListReqDto reqDto);
	public LoyMbrFmlyResDto checkFmlyChief(LoyMbrFamilyListReqDto reqDto);


	 /*
	  * 1. 메소드명: saveNewFmlyMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 구성원 가입
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	public void saveNewFmlyMbr(LoyFamilyListReqDto reqDto);
	//신규 (type 사용)
	public void saveJoinCustAll(Map<String, Object> map);


	 /*
	  * 1. 메소드명: deleteFmlyMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	public void deleteFmlyMbr(LoyFamilyListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTermsListVal
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 약관리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyTermsListResDto> selectTermsListVal(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTermsMktRcvListVal
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 약관 마켓팅 수신동의 항목 리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyTermsRcvChnlListResDto> selectTermsMktRcvListVal(LoyTermsListReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrDetailPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyMbrDetailPopResDto selectMbrDetailPop(LoyMbrReqDto reqDto);
	 /*
	  * 1. 메소드명: selectCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCorpMbrDetailPopResDto selectCorpMbrDetailPop(LoyMbrReqDto reqDto);

	public LoyMbrDetailPopResDto seletMbrPrStore(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTermsDetailList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 동의이력 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyAgreTermsResDto> selectMbrTermsDetailList(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCorpMbrListPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 조회 (회원번호 뽑기)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyMbrListPopResDto> selectCorpMbrListPop(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectCorpBranchListPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 (고객) 브랜치 리스트 popup
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<LoyCustBranchResDto> selectCorpBranchListPop(LoyCustBranchReqDto reqDto);


	 /*
	  * 1. 메소드명: withdrawMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	public void withdrawMbr(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: checkCardNumber
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 법인카드번호 인증
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 * @return
	 */
	public LoyMbrCCardResDto checkCardNumber(LoyMbrReqDto reqDto);


	public List<LoyMbrCouponListResDto> selectMbrCouponHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: checkUserId
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 웹아이디 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrCCardResDto checkUserId(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: checkRcmmdNo
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 추천인코드 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrCCardResDto checkRcmmdNo(LoyMbrReqDto reqDto);


	
	 /*
	  * 1. 메소드명: updateMbrDetailPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param map	
	 */
	public void updateMbrDetailPop(Map<String, Object> map);

	
	 /*
	  * 1. 메소드명: updateCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param map	
	 */
	public void updateCorpMbrDetailPop(Map<String, Object> map);
	
	public List<LoyMbrSegmentHistListResDto> selectCustSegmentHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectCustItemConfList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public List<LoyCustItemConfListResDto> selectCustItemConfList(LoyMbrChangeHistListReqDto reqDto);


	/*
	  * 1. 메소드명: selectMbrCpnCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *		회원상세 보유쿠폰
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public Integer selectMbrCpnCnt(LoyMbrReqDto reqDto);

	
	 /*
	  * 1. 메소드명: selectRidPgm
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	 * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String selectRidPgm(LoyMbrChangeHistListReqDto reqDto);



	 /*
	  * 1. 메소드명: selectMbrTicketCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *		회원상세 보유티켓
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

	public Integer selectMbrTicketCnt(LoyMbrReqDto reqDto);


	
	/*
	  * 1. 메소드명: selectAchngMarkName
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	* 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String selectAchngMarkName(LoyMbrChangeHistListResDto reqDto);


	 /*
	  * 1. 메소드명: selectBchngMarkName
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

	
	public String selectBchngMarkName(LoyMbrChangeHistListResDto reqDto);
	
	/*
	  * 1. 메소드명: selectOneMbrEvt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *		회원상세 이벤트참여 최근1건
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

	public LoyMbrDetailNewPageResDto selectOneMbrEvt(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTierHistListNew
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public List<LoyMbrTiersListResDto> selectMbrTierHistListNew(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTierMgtPlcy
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public Integer selectTierMgtPlcy(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTierMgtPlcyYn
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public String selectTierMgtPlcyYn(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTierDetailPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoyMbrTiersDetailResDto selectTierDetailPop(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectTierApprovalPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoyMbrApprovalDetailResDto selectTierApprovalPop(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: insertTierHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public void insertTierHist(LoyMbrTiersDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrTier
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public void updateMbrTier(LoyMbrTiersDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrLiftTier
	  * 2. 클래스명: LoyMbrMapper
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
	
	public void updateMbrLiftTier(LoyMbrTiersDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: purAcrlPointProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 구매이력 적립
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void purAcrlPointProc(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: searchMbrGiftPntTgtMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트양도 타켓 회원 찾기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<LoyMbrListPopResDto> searchMbrGiftPntTgtMbr(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: setMbrPointGiftProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 프로시져
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void setMbrPointGiftProc(LoyMbrReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectGiftPointHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 이력 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<LoyMbrPointHistListResDto> selectGiftPointHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrUsePurMax
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 1일 최대사용치
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrPointAuthResDto selectMbrUsePurMax(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrPgmChnlPop
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도시 프로그램에 하위 채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<LoyChnlListResDto> selectMbrPgmChnlPop(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: getPgmMgtPlcy
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램별 법인회원가입 운영정책있는지 여부(1 : 있다 ,0 : 없다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public Integer selectPgmMgtPlcy(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: chkPntUsable
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램별 법인회원가입 운영정책있는지 여부(1 : 있다 ,0 : 없다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyWithdrawMbrCallResDto chkPntUsable(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: checkPgmRepYn
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대표 프로그램 여부 확인
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String checkPgmRepYn(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrIntList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public List<LoyMbrIntListResDto> selectMbrIntList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrIntCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public Integer selectMbrIntCnt(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: callSaveMbrInt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
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
	
	public void callSaveMbrInt(LoyMbrIntDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrIntCnt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public Integer selectMbrIntCnt(LoyMbrIntDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: removeMbrInt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
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
	
	public void removeMbrInt(LoyMbrIntDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrIntCode
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public String selectMbrIntCode(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: callProcPointAcrl
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void callProcPointAcrl(LoyPointAcrlRequestDTO param);


	 /*
	  * 1. 메소드명: callProcPointAcrl
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void callProcPointAcrl(LoyPointRdmRequestDTO param);


	 /*
	  * 1. 메소드명: callProcPointRdm
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void callProcPointRdm(LoyPointRdmRequestDTO param);


	 /*
	  * 1. 메소드명: clearMaskMbrInt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoyMbrIntListResDto clearMaskMbrInt(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: blackRuleFmly
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 이상거래정책 심사
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 *   @return	
	 */
	public void blackRuleFmly(LoyFamilyListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: executivesViewSelect
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 *   @return	
	 */
	public LoyExecutivesViewResDto executivesViewSelect(LoyExecutivesViewReqDto reqDto);

	public LoyExecutivesViewResDto executivesMemberCheck(LoyExecutivesViewReqDto reqDto);

	public LoyExecutivesViewResDto executivesExistSelect(LoyExecutivesViewReqDto reqDto);

	public void empNoUpdateExecutives(LoyExecutivesViewReqDto reqDto);


	public void mbrStatCdUpdateExecutives(LoyExecutivesViewReqDto reqDto);
	
	public void custStatCdUpdateExecutives(LoyExecutivesViewReqDto reqDto);

	public List<LoyMbrTxnHistListResDto> buyDetailSelect(LoyMbrReqDto reqDto);
	
	public List<LoyMbrProdCustListResDto> getProdCustList(LoyMbrReqDto reqDto);
	
	public LoyMbrProdCustDetailResDto prodCustListDetail(LoyMbrProdCustListReqDto reqDto);
	
	public List<LoyMbrListNewPageResDto> getDorMantList(LoyMbrReqDto reqDto);
	
	public List<LoyMbrListNewPageResDto> getBeforeDorMantList(LoyMbrReqDto reqDto);

	public List<LoyMbrListNewPageResDto> getexecutivesList(LoyMbrReqDto reqDto);
	
	public LoyExecutivesViewReqDto empNoFindFunctionExecutives(LoyExecutivesViewReqDto reqDto);
	
	public List<LoyMbrCommResDto> getExecutivesPopComm();

	public List<LoyChnlListResDto> getPrStoreNmPopList(LoyCommonReqDto reqDto);

	public List<LoyCampaignExecListResDto> getCampaignExecList(LoyMbrReqDto reqDto);
	
	public List<LoyNegativeAccResDto> getNegativeAccList(LoyNegativeAccReqDto reqDto);

	public LoyNegativeAccResDto clearMaskNegativeAccList(LoyNegativeAccReqDto reqDto);
	
	public List<LoyNegativeAccResDto> negativeAccListExcelList(LoyNegativeAccReqDto reqDto);
	
	
	public List<LoyMbrMgtInfoResDto> getMbrMgtInfoList(LoyMbrMgtInfoReqDto reqDto);
	
	public void addMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto);
	
	public void updateMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto);
	
	public void deleteMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto);
	
	public void addMbrMgtInfoHist(LoyMbrMgtInfoReqDto reqDto);
	
	public LoyMbrMgtInfoResDto getMbrMgtInfoBeforeUpdate(LoyMbrMgtInfoReqDto reqDto);
	
	public List<LoyMbrMgtInfoResDto> getMbrMgtInfoHistList(LoyMbrMgtInfoReqDto reqDto);
	
	public int countTheRecordMatched(LoyMbrMgtInfoReqDto reqDto);

	public List<LoyMbrCouponListResDto> selectOnlineMallCouponHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: updateTierHistYn
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 1. 25.
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
	
	public void updateTierHistYn(LoyMbrTiersDetailReqDto reqDto);

	


	 /*
	  * 1. 메소드명: getTierBenefitHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 1. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원의 (RID_MBR) 등급혜택이력을 조회하는 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 */
	public List<LoyMbrTierBenefitHistResDto> getTierBenefitHistList(LoyMbrTierBenefitHistReqDto reqDto);
		
	public LoyMbrListNewPageResDto selectMbrCustTypeCd(LoyMbrReqDto reqDto);
	 /*
	  * 1. 메소드명: selectMbrTxnHistSumList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 2sh.park 
	  * 4. 작성일자: 2022. 02. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 구매이력 판매금액,할인금액,최종 결제 금액 합계
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 */
	public List<LoyMbrTxnHistListResDto> selectMbrTxnHistSumList(LoyMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrPntHistSumList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2022. 02. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 포인트 결제금액, 포인트 합계
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 */
	public List<LoyMbrTxnHistListResDto> selectMbrPntHistSumList(LoyMbrReqDto reqDto);


	public List<LoyMbrCouponListResDto> selectNewMallCouponList(LoyMbrReqDto reqDto);


	public List<LoyClubOfferListResDto> selectCpnIssueOfferList(LoyClubOfferDetailReqDto reqDto);


	public List<LoyMbrCouponListResDto> selectMbrCouponTxnHistList(LoyMbrReqDto reqDto);


	public LoyMbrDetailNewPageResDto selectMbrDetailRepId(LoyMbrReqDto reqDto);


	public void updatePntYn(LoyMbrReqDto reqDto);


	public void updateRdmPntYn(LoyMbrReqDto reqDto);


	public void addMbrPntChngHistList(LoyMbrReqDto reqDto);


	public int updateMbrPntUsePwLL(LoyMbrEditPntUsePwReqDto param);


	public List<LoyMbrTxnHistListResDto> buyDetailSelectOffLine(LoyMbrReqDto reqDto);


	public List<LoyMbrTxnHistListResDto> buyDetailSelectOnline(LoyMbrReqDto reqDto);

	public List<LoyMbrTxnHistListResDto> purDetailSelect(LoyMbrReqDto reqDto);


	public void updateMbrLoiginPwLL(LoyMbrEditPntUsePwReqDto param);




	public LoyMbrItemResDto selectBfPwd(LoyMbrEditPntUsePwReqDto param);


	public void updatePwdSendChnl(LoyMbrEditPntUsePwReqDto param);


	public void addPwdSendChnl(LoyMbrEditPntUsePwReqDto param);


	public LoyMbrItemResDto selectChgVal(LoyMbrEditPntUsePwReqDto param);


	public LoyMbrItemResDto selectContsRid(LoyMbrEditPntUsePwReqDto param);


	public void addPwdSendChnlTag(LoyMbrEditPntUsePwReqDto param);


	public LoyMbrItemResDto selectChgNextDate(LoyMbrEditPntUsePwReqDto param);


	public List<LoyClubOfferListResDto> selectOfrPntList(LoyClubOfferDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrSecsnMbrToAble
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void updateMbrSecsnMbrIToAble(LoyMbrReqDto param);
	
	/*
	  * 1. 메소드명: updateMbrSecsnMbrToAble
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void updateMbrSecsnMbrCToAble(LoyMbrReqDto param);


	 /*
	  * 1. 메소드명: updateMbrSecsnMbrToAble
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void updateMbrSecsnMbrToAble(LoyMbrReqDto param);


	 /*
	  * 1. 메소드명: updateMbrSecsnMbr
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	public void updateMbrSecsnMbr(LoyMbrReqDto param);
	
	 /*
	  * 1. 메소드명: setCustDorChange
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 04. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 회원으로 전환 프로시저
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	
	public void setCustDorChange(LoyExecutivesViewReqDto param);

	public List<LoyClubOfferListResDto> getExtncList(LoyClubOfferDetailReqDto reqDto);

	

	 /*
	  * 1. 메소드명: selectMbrIntListSearch
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public List<LoyMbrResDto> selectMbrIntListSearch(LoyMbrReqDto param);


	 /*
	  * 1. 메소드명: updateMbrInt
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param req	
	 */
	
	public void updateMbrInt(LoyMbrReqDto req);


	 /*
	  * 1. 메소드명: updateMbrTierBnft
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param req	
	 */
	
	public void updateMbrTierBnft(LoyMbrReqDto req);


	 /*
	  * 1. 메소드명: insertChgHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 3.
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
	
	public void insertChgHist(LoyExecutivesViewReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrChgHistMbrStatCd
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 3.
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
	
	public void insertMbrChgHistMbrStatCd(LoyExecutivesViewReqDto reqDto);


	 /*
	  * 1. 메소드명: insertMbrChgHistCustStatCd
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 3.
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
	
	public void insertMbrChgHistCustStatCd(LoyExecutivesViewReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrTierBnftProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 5.
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
	
	public void updateMbrTierBnftProc(LoyMbrTiersDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: updateMbrTierUpBnftProc
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 5.
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
	
	public void updateMbrTierUpBnftProc(LoyMbrTiersDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrTxnHistDeliSumList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public List<LoyMbrTxnHistListResDto> selectMbrTxnHistDeliSumList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectMbrDorHistList
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public List<LoyMbrDorHistResDto> selectMbrDorHistList(LoyMbrReqDto reqDto);


	 /*
	  * 1. 메소드명: selectDorMbrDetail
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 6. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoyMbrResDto selectDorMbrDetail(LoyNewCustAddReqDto reqDto);


	 /*
	  * 1. 메소드명: insertDorCustChgHist
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 6. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param resDto	
	 */
	
	public void insertDorCustChgHist(LoyMbrResDto resDto);


	 /*
	  * 1. 메소드명: updateDorCust
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 6. 17.
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
	
	public void updateDorCust(LoyNewCustAddReqDto reqDto);


	 /*
	  * 1. 메소드명: updatePntValidDate
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 8. 2.
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
	
	public void updatePntValidDate(LoyMbrPointAcrlReqDto reqDto);

	/*
	 * 1. 메소드명: selectMbrSurveyList
	 * 2. 클래스명: LoyMbrMapper
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
    List<LoyMbrSurveyListResDto> selectMbrSurveyList(LoyMbrReqDto reqDto);

	/*
	 * 1. 메소드명: selectMbrSurveyDetailPop
	 * 2. 클래스명: LoyMbrMapper
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 - 설문결과 상세 팝업
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
    List<LoyMbrSurveyListResDto> selectMbrSurveyDetailPop(LoyMbrReqDto reqDto);

	/*
	 * 1. 메소드명: selectVocSvcReqCnt
	 * 2. 클래스명: LoyMbrMapper
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 고객문의 갯수
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
    LoyMbrDetailNewPageResDto selectVocSvcReqCnt(LoyMbrReqDto reqDto);


	/*
	 * 1. 메소드명: selectTierLvl
	 * 2. 클래스명: LoyMbrMapper
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 20.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 고객문의 갯수
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param tier
	 *   @return
	 */
    LoyMbrDetailNewPageResDto selectTierLvl(String tier);

    int selectMbrSurvSendTgt(LoyMbrReqDto reqDto);

	int selectMbrSurvJoin(LoyMbrReqDto reqDto);


    List<LoyMbrListNewPageResDto> getBeforeDorMantListTotalCnt(LoyMbrReqDto reqDto);
}

