/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: CampaignHomeMapper.java
 * 2. Package	: com.icignal.marketing.campaignhome.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 27. 오후 1:20:53
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.marketing.campaignhome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.campaignhome.dto.request.CampaignHomeReqDto;
import com.icignal.marketing.campaignhome.dto.response.CampaignValatilityResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigNoticeResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigPromotionResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignBaseResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignCustTypeCdResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignPrchaseRecResDto;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.response.ApprovalListResDto;

/*
 * 1. 클래스명	: CampaignHomeMapper
 * 2. 파일명	: CampaignHomeMapper.java
 * 3. 패키지명	: com.icignal.marketing.campaignhome.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface CampaignHomeMapper {

	 /*
	  * 1. 메소드명: selectCampaignPrchaseRec
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 27.
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
	
	List<CampignPrchaseRecResDto> selectCampaignPrchaseRec(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectCampaignMyAct
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 27.
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
	
	List<CampigPromotionResDto> selectHomePromList(CampaignHomeReqDto param);


	 /*
	  * 1. 메소드명: selectCampaignSeg
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 27.
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
	
	List<CampigNoticeResDto> selectHomeNoticeList(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectTotalCust
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 -전체회원수 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	CampignCustTypeCdResDto selectTotalCust(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectNewCustOfMonth
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 당월 신규고객수
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	CampignBaseResDto selectNewCustOfMonth(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectPromotionOfMonth
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 당월 프로모션 진행건
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	Integer selectPromotionOfMonth(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectHomeVolatility
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 가입자 변동추이
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	List<CampaignValatilityResDto> selectHomeVolatility(CampaignHomeReqDto param);

	 /*
	  * 1. 메소드명: selectHomeApprovalList
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		결제할 문서
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<ApprovalListResDto> selectHomeApprovalList(ApprovalListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectHomeApprovalReqList
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		결제요청문서
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<ApprovalListResDto> selectHomeApprovalReqList(ApprovalListReqDto reqDto);
	 /*
	  * 1. 메소드명: getNewCustOfDay
	  * 2. 클래스명: CampaignHomeMapper
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 01. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		금일 신규 회원수 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	CampignBaseResDto selectNewCustOfDay(CampaignHomeReqDto param);

	Integer selectCampaignOfMonth(CampaignHomeReqDto param);

	CampignBaseResDto selectNewCustOfLastDay(CampaignHomeReqDto param);

	CampignBaseResDto selectNewCustOfLastMonth(CampaignHomeReqDto param);

	CampignBaseResDto selectBasePnt(CampaignHomeReqDto param);

	CampignBaseResDto selectRdm(CampaignHomeReqDto param);

	CampignBaseResDto selectAcrlMonth(CampaignHomeReqDto param);

	CampignBaseResDto acrlBeforeDay(CampaignHomeReqDto param);

	CampignBaseResDto usePntBeforeDay(CampaignHomeReqDto param);

	CampignBaseResDto selectCurrFirstDayCnt(CampaignHomeReqDto param);

	CampignBaseResDto selectXUseAvlPnt(CampaignHomeReqDto param);

    List<CampigPromotionResDto> selectHomePromList2(CampaignHomeReqDto param);

    CampignBaseResDto selectCrmHome(CampaignHomeReqDto param);

    List<CampigPromotionResDto> selectHomeCamList(CampaignHomeReqDto param);

	List<CampigPromotionResDto> selectHomeCamList2(CampaignHomeReqDto param);

	CampignBaseResDto selectCampaignTgtSucsCnt(CampaignHomeReqDto param);
}
