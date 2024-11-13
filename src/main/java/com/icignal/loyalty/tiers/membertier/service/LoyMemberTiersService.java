/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTiersService.java
 * 2. Package	: com.icignal.loyalty.tiers.membertier.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 3:35:39
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.membertier.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistListReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierReqDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistListResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierResDto;
import com.icignal.loyalty.tiers.membertier.mapper.LoyMemberTierMapper;

/*
 * 1. 클래스명	: LoyMbrTiersService
 * 2. 파일명	: LoyMbrTiersService.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.membertier.service
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
public class LoyMemberTiersService {
	
	@Autowired LoyMemberTierMapper loyMbrTierMapper;
	
	 /*
	  * 1. 메소드명: getMbrTierHistList
	  * 2. 클래스명: LoyMbrTiersService
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
	 *   @return GridPagingResDto<LoyMbrTierHistListResDto>	
	 */
	/*public GridPagingResDto<LoyMbrTierHistListResDto> getMbrTierHistList(LoyMbrTierHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return new GridPagingResHelper<LoyMbrTierHistListResDto>().newGridPagingResDto(
				 param.init(Common.getInstance().getDBType()),
				 loyMbrTierMapper.selectMbrTierHistList(param));
	}*/
	
	 /*
	  * 1. 메소드명: getAllTierList
	  * 2. 클래스명: LoyMbrTiersService
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
	public GridPagingResDto<LoyMbrTierResDto> getAllTierList(LoyMbrTierReqDto param) {
		LogUtil.param(this.getClass(), param);

		return new GridPagingResHelper<LoyMbrTierResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 loyMbrTierMapper.selectMbrAllTierList(param));
	}
	
 /*
	  * 1. 메소드명: editMbrTier
	  * 2. 클래스명: LoyMbrTiersService
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
	public StatusResDto editMbrTier(LoyMbrTierReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
	    
		loyMbrTierMapper.callProcMbrTierUpd(param);
		
		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}
	
	/*
	  * 1. 메소드명: getMbrTierHistList
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
	public GridPagingResDto<LoyMbrTierHistResDto> getMbrTierHistList(LoyMbrTierHistReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("a");
	     
	     return new GridPagingResHelper<LoyMbrTierHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrTierMapper.selectMbrTierHistList(reqDto));
	}
	
	 /*
	  * 1. 메소드명: getMbrTierHistList2
	  * 2. 클래스명: LoyMemberTiersService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 11.
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
	public GridPagingResDto<LoyMbrTierHistListResDto> getMbrTierHistList2(LoyMbrTierHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return new GridPagingResHelper<LoyMbrTierHistListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyMbrTierMapper.selectMbrTierHistList2(param));
	}
	
	
}
