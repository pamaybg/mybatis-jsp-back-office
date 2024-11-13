/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCardMasterMapper.java
 * 2. Package	: com.icignal.loyalty.membershipcard.cardmaster.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 25. 오후 1:49:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmaster.mapper;

import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardBinReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardNoPoolReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardTypeReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyIssuedCardReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardBinResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardNoPoolResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardTypeResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/*
 * 1. 클래스명	: LoyCardMasterMapper
 * 2. 파일명	: LoyCardMasterMapper.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.cardmaster.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyCardMasterMapper {

	 /*
	  * 1. 메소드명: selectCardTypeList
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	List<LoyCardTypeResDto> selectCardTypeList(LoyCardTypeReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCardDtl
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	LoyCardTypeResDto selectCardTypeDtl(LoyCardTypeReqDto reqDto);

	int updateCardTypeDtl(LoyCardTypeReqDto reqDto);


	 /*
	  * 1. 메소드명: insertCardTypeDtl
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	int insertCardTypeDtl(LoyCardTypeReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCardList
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	List<LoyIssuedCardResDto> selectIssuedCardList(LoyIssuedCardReqDto reqDto);
	/*
	  * 1. 메소드명: selectCardBinList
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
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
	List<LoyCardBinResDto> selectCardBinList(LoyCardBinReqDto reqDto);

	/*
	 * 1. 메소드명: selectCardBinList
	 * 2. 클래스명: LoyCardMasterMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 10.
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
	LoyCardBinResDto selectCardBinDetail(LoyCardBinReqDto reqDto);

	 /*
	  * 1. 메소드명: insertCardBin
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
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
	void insertCardBin(LoyCardBinReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updateCardBin
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
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
	void updateCardBin(LoyCardBinReqDto reqDto);
	
	 /*
	  * 1. 메소드명: deleteCardBin
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
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
	void deleteCardBin(LoyCardBinReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectCardNoPoolList
	  * 2. 클래스명: LoyCardMasterMapper
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
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
	List<LoyCardNoPoolResDto> selectCardNoPoolList(LoyCardNoPoolReqDto reqDto);

	List<LoyCardNoPoolResDto> selectCardNoPoolListForExcelExport(LoyCardNoPoolReqDto reqDto);

	void updateCardNoPool(String reqDto);

	void callGenCardNoBulk(Map map);
	
	void deleteCardNoPoolTemp(String reqDto);
}
