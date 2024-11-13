/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrMapper.java
 * 2. Package	: com.icignal.loyalty.blackMbr.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 10. 오후 3:39:29
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackMbr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrDetailReqDto;
import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrListReqDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrDetailResDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrListResDto;

/*
 * 1. 클래스명	: LoyBlackMbrMapper
 * 2. 파일명	: LoyBlackMbrMapper.java
 * 3. 패키지명	: com.icignal.loyalty.blackMbr.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyBlackMbrMapper {

	 /*
	  * 1. 메소드명: selectBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 10.
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
	
	List<LoyBlackMbrListResDto> selectBlackMbrList(LoyBlackMbrListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	LoyBlackMbrDetailResDto selectBlackMbrDetail(LoyBlackMbrListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	void insertBlackMbrDetail(LoyBlackMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	void updateBlackMbrDetail(LoyBlackMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClearMaskBlackMbr
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	LoyBlackMbrListResDto selectClearMaskBlackMbr(LoyBlackMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteBlackListMbr
	  * 2. 클래스명: LoyBlackMbrMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	void deleteBlackListMbr(LoyBlackMbrDetailReqDto reqDto);

}
