/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackTxnRuleService.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 4:51:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckMbrDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleListReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBlackRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBalckMbrDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackMbrListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleListResDto;
import com.icignal.loyalty.blackTxnRule.mapper.LoyBlackTxnRuleMapper;

/*
 * 1. 클래스명	: LoyBlackTxnRuleService
 * 2. 파일명	: LoyBlackTxnRuleService.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyBlackTxnRuleService {

	@Autowired
	private LoyBlackTxnRuleMapper loyBlackTxnRuleMapper;
	
	 /*
	  * 1. 메소드명: getBlackRuleList
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	이상거래 정책 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<LoyBlackTxnRuleListResDto> getBlackRuleList(LoyBalckTxnRuleListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyBlackTxnRuleListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyBlackTxnRuleMapper.selectBlackRuleList(reqDto), AnnotationType.CommCode
				);
	}

	 /*
	  * 1. 메소드명: getBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	public LoyBlackTxnRuleDetailResDto selectBlackRuleMstDetail(LoyBalckTxnRuleListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyBlackTxnRuleMapper.selectBlackRuleMstDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	public StatusResDto saveBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		loyBlackTxnRuleMapper.insertBlackRuleDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	public StatusResDto modifyBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackTxnRuleMapper.updateBlackRuleDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBlackRuleListTab
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public GridPagingResDto<LoyBlackRuleListResDto> getBlackRuleListTab(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyBlackRuleListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyBlackTxnRuleMapper.selectBlackRuleListTab(reqDto), AnnotationType.CommCode
				);
	}

	 /*
	  * 1. 메소드명: removeBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public StatusResDto removeBlackRule(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackTxnRuleMapper.deleteBlackRule(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeBlackMst
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public StatusResDto removeBlackMst(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackTxnRuleMapper.deleteBlackMst(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public LoyBlackRuleDetailResDto getBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyBlackTxnRuleMapper.selectBlackRuleDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public StatusResDto saveBlackRule(LoyBlackRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		Integer cnt = loyBlackTxnRuleMapper.selectBasTypeCheck(reqDto);
		if(cnt<1) {
			reqDto.setRid(CommonUtil.newRid());
			String basTypeNm = loyBlackTxnRuleMapper.selectBaseTypeNm(reqDto);
			String basDayMmCdNm = loyBlackTxnRuleMapper.selectBaseDayNm(reqDto);
			reqDto.setBasTypeNm(basTypeNm);
			reqDto.setBasDayMmCdNm(basDayMmCdNm);
			loyBlackTxnRuleMapper.insertBlackRule(reqDto);
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setMessage("기준유형 중복 입력 불가합니다");
			rtnValue.setSuccess(false);
		}
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public StatusResDto modifyBlackRule(LoyBlackRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		Integer cnt = loyBlackTxnRuleMapper.selectBasTypeCheck(reqDto);
		if(cnt<1) {
			String basTypeNm = loyBlackTxnRuleMapper.selectBaseTypeNm(reqDto);
			String basDayMmCdNm = loyBlackTxnRuleMapper.selectBaseDayNm(reqDto);
			reqDto.setBasTypeNm(basTypeNm);
			reqDto.setBasDayMmCdNm(basDayMmCdNm);
			loyBlackTxnRuleMapper.updateBlackRule(reqDto);
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setMessage("기준유형 중복 입력 불가합니다");
			rtnValue.setSuccess(false);
		}
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBlackMbrListTab
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	public GridPagingResDto<LoyBlackMbrListResDto> getBlackMbrListTab(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyBlackMbrListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyBlackTxnRuleMapper.selectBlackMbrListTab(reqDto), AnnotationType.ALL
				);
	}

	 /*
	  * 1. 메소드명: saveBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public StatusResDto saveBlackMbr(LoyBalckMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		Integer cnt = loyBlackTxnRuleMapper.selectMbrCnt(reqDto);
		if(cnt<1) {
			reqDto.setRid(CommonUtil.newRid());
			loyBlackTxnRuleMapper.insertBlackMbr(reqDto);
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setMessage("이미 의심등록된 회원입니다.");
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public StatusResDto modifyBlackMbr(LoyBalckMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackTxnRuleMapper.updateBlackMbr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBlackMbrDetail
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public LoyBalckMbrDetailResDto getBlackMbrDetail(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyBalckMbrDetailResDto resDto = new LoyBalckMbrDetailResDto();
		resDto = loyBlackTxnRuleMapper.selectBlackMbrDetail(reqDto);
		
		return new AnnotationHelper<LoyBalckMbrDetailResDto>(AnnotationType.PersonalData, resDto).getItem();
	}

	 /*
	  * 1. 메소드명: modifyBlStat
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public StatusResDto modifyBlStat(LoyBalckMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		if("CONF".equals(reqDto.getStatCd())) {
			loyBlackTxnRuleMapper.updateStatCdConf(reqDto);
		} else if ("BL_CANL".equals(reqDto.getStatCd()) || "SUSP_CANL".equals(reqDto.getStatCd())) {
			loyBlackTxnRuleMapper.updateStatCdCanl(reqDto);
		} else {
			loyBlackTxnRuleMapper.updateStatCd(reqDto);
		}
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: clearMaskBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public LoyBlackMbrListResDto clearMaskBlackMbr(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyBlackMbrListResDto resDto = new LoyBlackMbrListResDto();
		resDto = loyBlackTxnRuleMapper.selectClearMaskBlackMbr(reqDto);
		
		return new AnnotationHelper<LoyBlackMbrListResDto>(AnnotationType.PersonalData, resDto).getItem();
	}

	 /*
	  * 1. 메소드명: removeBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	public StatusResDto removeBlackMbr(LoyBalckTxnRuleDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackTxnRuleMapper.deleteBlackMbr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

}
