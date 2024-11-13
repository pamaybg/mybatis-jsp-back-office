/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrCardMapper.java
 * 2. Package	: com.icignal.loyalty.membershipcard.membercard.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 1:35:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmember.mapper;

import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardListResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardResDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/*
 * 1. 클래스명	: LoyMbrCardMapper
 * 2. 파일명	: LoyMbrCardMapper.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.membercard.mapper
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
public interface LoyMemberCardMapper {

	 /*
	  * 1. 메소드명: selectMbrCardList
	  * 2. 클래스명: LoyMbrCardMapper
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
	
	//List<LoyMbrCardResDto> selectMbrCardList(LoyMbrCardReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrCardList
	  * 2. 클래스명: LoyMemberCardMapper
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
	
	List<LoyIssuedCardResDto> selectMbrCardList(LoyCardListReqDto param);

	 /*
	  * 1. 메소드명: selectMbrOrangeCardDetail
	  * 2. 클래스명: LoyMemberCardMapper
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
	
	LoyMbrCardResDto selectMbrCardDetail(LoyMbrCardListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMemeberCardList
	  * 2. 클래스명: LoyMemberCardMapper
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
	
	List<LoyMbrCardResDto> selectMemeberCardList(LoyMbrCardReqDto reqDto);

	 /*
	  * 1. 메소드명: updateMbrCardStat
	  * 2. 클래스명: LoyMemberCardMapper
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
	 */
	
	void updateMbrCardStat(LoyMbrCardReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrListCard
	  * 2. 클래스명: LoyMemberCardMapper
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
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyMbrCardListResDto> selectMbrListCard(LoyMbrCardListReqDto reqDto);

	

}
