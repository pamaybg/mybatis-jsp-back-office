/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTierMapper.java
 * 2. Package	: com.icignal.loyalty.tiers.membertier.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 3:09:48
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.membertier.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistListReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierReqDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistListResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierResDto;

/*
 * 1. 클래스명	: LoyMbrTierMapper
 * 2. 파일명	: LoyMbrTierMapper.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.membertier.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyMemberTierMapper {


	public List<LoyMbrTierResDto> selectMbrAllTierList(LoyMbrTierReqDto param);

	 /*
	  * 1. 메소드명: callProcMbrTierUpd
	  * 2. 클래스명: LoyMbrTiersMapper
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
	 */
	
	public void callProcMbrTierUpd(LoyMbrTierReqDto param);

	 /*
	  * 1. 메소드명: selectMbrTierHistList
	  * 2. 클래스명: LoyMemberTierMapper
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
	
	public List<LoyMbrTierHistListResDto> selectMbrTierHistList(LoyMbrTierHistListReqDto param);

	 /*
	  * 1. 메소드명: selectMbrTierHistList
	  * 2. 클래스명: LoyMemberTierMapper
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
	
	public List<LoyMbrTierHistResDto> selectMbrTierHistList(LoyMbrTierHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTierHistList2
	  * 2. 클래스명: LoyMemberTierMapper
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
	
	public List<LoyMbrTierHistListResDto> selectMbrTierHistList2(LoyMbrTierHistListReqDto param);

	

}
