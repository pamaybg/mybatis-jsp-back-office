/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: CampaignHomeService.java
 * 2. Package	: com.icignal.marketing.campaignhome.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 27. 오후 1:19:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.marketing.campaignhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.marketing.campaignhome.dto.request.CampaignHomeReqDto;
import com.icignal.marketing.campaignhome.dto.response.CampaignValatilityResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigNoticeResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigPromotionResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignBaseResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignCustTypeCdResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignPrchaseRecResDto;
import com.icignal.marketing.campaignhome.mapper.CampaignHomeMapper;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.response.ApprovalListResDto;


/*
 * 1. 클래스명	: CampaignHomeService
 * 2. 파일명	: CampaignHomeService.java
 * 3. 패키지명	: com.icignal.marketing.campaignhome.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class CampaignHomeService {
	
	@Autowired
	private CampaignHomeMapper campaignHomeMapper;

    /**
     * 
     * <pre>
     * infavor.marketing.campaignHome.service.impl.MKTCampaignHomeService.java
     *  |_ getCampaignPrchaseRec()
     * </pre>
     * @OverrideMethod		: getCampaignPrchaseRec
     * @OverrideMethod설명	: 캠페인 구매 반응률 조회
     * @param param
     * @return
     * @history
     * =================================================================================
     * 변경일				작성자			변경내용
     * =================================================================================
     * 2016. 11. 28.			wjlee			신규 생성
     * =================================================================================
     *
     * @SeeToOverriden		: @see infavor.marketing.campaignHome.service.IMKTCampaignHomeService#getCampaignPrchaseRec(infavor.marketing.campaignHome.dto.request.CampaignHomeReqDto)
     */
    public List<CampignPrchaseRecResDto> getCampaignPrchaseRec(CampaignHomeReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("t1");
        
	        return campaignHomeMapper.selectCampaignPrchaseRec(param);
    }
    

	 /*
	  * 1. 메소드명: getHomePromList
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 전체 캠페인 목록 조회
	 * 2. 사용법
	 *		PROM_STAT_CD = 'A'
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<CampigPromotionResDto> getHomePromList(CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setSVCAlias("t1");
    	return new GridPagingResHelper<CampigPromotionResDto>().newGridPagingResDto(
    			param.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomePromList(param));
	}

	 /*
	  * 1. 메소드명: getHomeNoticeList
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 30.
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
	public GridPagingResDto<CampigNoticeResDto> getHomeNoticeList(CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return new GridPagingResHelper<CampigNoticeResDto>().newGridPagingResDto(
    			param.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomeNoticeList(param));
	}

	 /*
	  * 1. 메소드명: getTotalCust
	  * 2. 클래스명: CampaignHomeService
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
	public CampignCustTypeCdResDto getTotalCust(CampaignHomeReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		
		return campaignHomeMapper.selectTotalCust(param);
	}

	 /*
	  * 1. 메소드명: getNewCustOfMonth
	  * 2. 클래스명: CampaignHomeService
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
	public CampignBaseResDto getNewCustOfMonth(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		CampignBaseResDto rtnValue = new CampignBaseResDto();
		CampignBaseResDto currData =campaignHomeMapper.selectNewCustOfMonth(param);
		CampignBaseResDto lastData =campaignHomeMapper.selectNewCustOfLastMonth(param);
		
		//마트 사용 안함
		//CampignBaseResDto currFirstMonthCnt = campaignHomeMartMapper.selectCurrFirstMonthCnt(param);  //당월 첫구매 고객
		//CampignBaseResDto preFirstPreMonthCnt = campaignHomeMartMapper.selectPreFirstPreMonthCnt(param);  //전월 첫구매 고객
		int firstPluscnt =0;
		
		/* 마트 사용 안함
		if(StringUtil.isNotEmpty(currFirstMonthCnt.getCurrFirstMonthCnt()) && StringUtil.isNotEmpty(currFirstMonthCnt.getPreFirstPreMonthCnt())) {

			firstPluscnt = Integer.parseInt(currFirstMonthCnt.getCurrFirstMonthCnt()) - Integer.parseInt(preFirstPreMonthCnt.getPreFirstPreMonthCnt());
		}
		*/

		int plusCnt=  Integer.parseInt(currData.getCurrCnt())- Integer.parseInt( lastData.getLastCnt()) ;
		
		rtnValue.setFirstPluscnt(firstPluscnt);
		//마트 사용 안함
		//rtnValue.setCurrFirstMonthCnt(currFirstMonthCnt.getCurrFirstMonthCnt());
		rtnValue.setCurrFirstMonthCnt("0");
		rtnValue.setCurrCnt(currData.getCurrCnt());
		rtnValue.setPlusCnt(plusCnt);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPromotionOfMonth
	  * 2. 클래스명: CampaignHomeService
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
	public int getPromotionOfMonth(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		return campaignHomeMapper.selectPromotionOfMonth(param);
	}


	 /*
	  * 1. 메소드명: getHomeVolatility
	  * 2. 클래스명: CampaignHomeService
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
	public GridPagingResDto<CampaignValatilityResDto> getHomeVolatility(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<CampaignValatilityResDto>().newGridPagingResDto(
				param, campaignHomeMapper.selectHomeVolatility(param));
	}


	 /*
	  * 1. 메소드명: getMyElapproval2
	  * 2. 클래스명: CampaignHomeService
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
	public GridPagingResDto<ApprovalListResDto> getHomeApprovalList(ApprovalListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<ApprovalListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomeApprovalList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getHomeApprovalReqList
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		결제요청 문서
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<ApprovalListResDto> getHomeApprovalReqList(ApprovalListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return 	new GridPagingResHelper<ApprovalListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomeApprovalReqList(reqDto),AnnotationType.CommCode);
	}
	 /*
	  * 1. 메소드명: getNewCustOfDay
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 01. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 금일 신규고객수
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */

	public CampignBaseResDto getNewCustOfDay(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		CampignBaseResDto rtnValue = new CampignBaseResDto();
		
		CampignBaseResDto curRtnValue = campaignHomeMapper.selectNewCustOfDay(param);  //당일 신규 고객
		CampignBaseResDto lastRtnValue = campaignHomeMapper.selectNewCustOfLastDay(param);  //전일 신규 고객

		CampignBaseResDto currFirstDayCnt = campaignHomeMapper.selectCurrFirstDayCnt(param);  //당일 첫구매 고객
		//마트 사용 안함
		//CampignBaseResDto preFirstDayCnt = campaignHomeMartMapper.selectPreFirstDayCnt(param);  //전일 첫구매 고객
		//int firstPluscnt =  Integer.parseInt(currFirstDayCnt.getCurrFirstDayCnt())- Integer.parseInt(preFirstDayCnt.getPreFirstDayCnt());
		int firstPluscnt =  0;
		int plusCnt = Integer.parseInt(curRtnValue.getCuurCntDay())- Integer.parseInt(lastRtnValue.getLastCnt()) ;
		
		rtnValue.setFirstPluscnt(firstPluscnt);
		rtnValue.setCurrFirstDayCnt(currFirstDayCnt.getCurrFirstDayCnt());
		rtnValue.setCuurCntDay(curRtnValue.getCuurCntDay());
		rtnValue.setPlusCnt(plusCnt);
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCampaignOfMonth
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 01. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 당월 캠페인 현황
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public CampignBaseResDto getCampaignOfMonth(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		CampignBaseResDto rtnValue = new CampignBaseResDto();
		int totCamCnt = campaignHomeMapper.selectCampaignOfMonth(param);
		rtnValue = campaignHomeMapper.selectCampaignTgtSucsCnt(param);
		rtnValue.setTotCampaignCnt(totCamCnt);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPointStatus
	  * 2. 클래스명: CampaignHomeService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 01. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 당월 포인트 현황
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public CampignBaseResDto getPointStatus(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		CampignBaseResDto rtnValue= new CampignBaseResDto();

		CampignBaseResDto xUseAvlPnt = campaignHomeMapper.selectXUseAvlPnt(param);
//		CampignBaseResDto basePnt = campaignHomeMapper.selectBasePnt(param);
//		CampignBaseResDto acrlMonth = campaignHomeMapper.selectAcrlMonth(param);
//		CampignBaseResDto rdmPnt = campaignHomeMapper.selectRdm(param);
//		CampignBaseResDto acrlBeforeDay = campaignHomeMapper.acrlBeforeDay(param);
//		CampignBaseResDto usePntBeforeDay = campaignHomeMapper.usePntBeforeDay(param);
//
//		rtnValue.setBasePnt(basePnt.getBasePnt());
//		rtnValue.setAcrlMonth(acrlMonth.getAcrlMonth());
//		rtnValue.setRdmPnt(rdmPnt.getRdmPnt());
//		rtnValue.setAcrlBeforeDay(acrlBeforeDay.getAcrlBeforeDay());
//		rtnValue.setUsePntBeforeDay(usePntBeforeDay.getUsePntBeforeDay());
		rtnValue.setBasePnt(xUseAvlPnt.getBasePnt());

		
		return rtnValue;
	}


	/*
	 * 1. 메소드명: getCrmHome
	 * 2. 클래스명: CampaignHomeService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 7. 30.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 F_CRM_HOME 집계테이블 조회
	 * 2. 사용법
	 *
	 *   @param param
	 *   @return
	 */
	public CampignBaseResDto getCrmHome(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		CampignBaseResDto rtnValue= new CampignBaseResDto();
		rtnValue = campaignHomeMapper.selectCrmHome(param);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: getHomeCamList
	 * 2. 클래스명: CampaignHomeService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 7. 30.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 전체 캠페인 목록 조회
	 * 2. 사용법
	 *		PROM_STAT_CD = 'W'
	 *   @param param
	 *   @return
	 */
	public GridPagingResDto<CampigPromotionResDto> getHomeCamList(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<CampigPromotionResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomeCamList(param));
	}	/*
	 * 1. 메소드명: getHomeCamList2
	 * 2. 클래스명: CampaignHomeService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 7. 30.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 전체 캠페인 목록 조회
	 * 2. 사용법
	 *		PROM_STAT_CD = 'W'
	 *   @param param
	 *   @return
	 */
	public GridPagingResDto<CampigPromotionResDto> getHomeCamList2(CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<CampigPromotionResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), campaignHomeMapper.selectHomeCamList2(param));
	}
}
