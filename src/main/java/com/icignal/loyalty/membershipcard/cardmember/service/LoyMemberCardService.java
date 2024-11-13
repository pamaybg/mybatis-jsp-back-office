/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrCardService.java
 * 2. Package	: com.icignal.loyalty.membershipcard.membercard.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 1:34:39
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmember.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardListResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardResDto;
import com.icignal.loyalty.membershipcard.cardmember.mapper.LoyMemberCardMapper;

/*
 * 1. 클래스명	: LoyMbrCardService
 * 2. 파일명	: LoyMbrCardService.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.membercard.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

@Service
public class LoyMemberCardService {
	
	@Autowired LoyMemberCardMapper loyMbrcardMapper;
	
	 /*
	  * 1. 메소드명: getMbrCardList
	  * 2. 클래스명: LoyMbrCardService
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
	public GridPagingResDto<LoyMbrCardResDto> getMbrCardList(LoyMbrCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		return new GridPagingResHelper<LoyMbrCardResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrcardMapper.selectMemeberCardList(reqDto),
				AnnotationType.PersonalData);
	}
	
	 /*
	  * 1. 메소드명: getMbrDaisoCardList
	  * 2. 클래스명: LoyMbrCardService
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
	public GridPagingResDto<LoyMbrCardListResDto> getMbrListCard(LoyMbrCardListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrCardListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrcardMapper.selectMbrListCard(reqDto), AnnotationType.PersonalData);
	}
	
	 /*
	  * 1. 메소드명: getCardList
	  * 2. 클래스명: LoyMemberCardService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
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
	public GridPagingResDto<LoyIssuedCardResDto> getCardList(LoyCardListReqDto param) {
		LogUtil.param(this.getClass(), param);
	    param.setSVCAlias("lmc");
	    GridPagingResDto<LoyIssuedCardResDto> rtnList =  new GridPagingResDto<LoyIssuedCardResDto>();
	  //값 체크
	     if(ObjectUtil.isEmpty(param.getRidMbr()) && param.getStrCondWhere().equals("1=1")){
	    	 rtnList.setSuccess(false);
	    	 rtnList.setMessage("조회조건이 충분하지 않습니다.");
	    	 return rtnList;
	     }else{
	    	 return new GridPagingResHelper<LoyIssuedCardResDto>().newGridPagingResDto(
	    			 param.init(CommonUtil.getInstance().getDBType()),
	 				loyMbrcardMapper.selectMbrCardList(param),
	 				AnnotationType.PersonalData);
	     }

	}
	
	 /*
	  * 1. 메소드명: getMbrOrangeCardDetail
	  * 2. 클래스명: LoyMemberCardService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
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
	public LoyMbrCardResDto getMbrCardDetail(LoyMbrCardListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		LoyMbrCardResDto loyMbrCardResDto = loyMbrcardMapper.selectMbrCardDetail(reqDto);
		return new AnnotationHelper<LoyMbrCardResDto>(AnnotationType.PersonalData, loyMbrCardResDto).getItem();
	}
	 /*
	  * 1. 메소드명: editMbrCardStat
	  * 2. 클래스명: LoyMbrService
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
	public StatusResDto editMbrCardStat(LoyMbrCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyMbrcardMapper.updateMbrCardStat(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
		
	}
	
}
