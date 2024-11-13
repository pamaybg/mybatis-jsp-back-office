/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromReactionMapper.java
 * 2. Package	: com.icignal.loyalty.promreaction.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 10:03:32
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.promreaction.dto.request.LoyPromReactionListReqDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcExcelListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionDetailResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionListResDto;

/*
 * 1. 클래스명	: LoyPromReactionMapper
 * 2. 파일명	: LoyPromReactionMapper.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyPromReactionMapper {

	 /*
	  * 1. 메소드명: selectPromReactionList
	  * 2. 클래스명: LoyPromReactionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyPromReactionListResDto> selectPromReactionList(LoyPromReactionListReqDto bccr);

	 /*
	  * 1. 메소드명: selectPromReactDetail
	  * 2. 클래스명: LoyPromReactionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	LoyPromReactionDetailResDto selectPromReactDetail(LoyPromReactionListReqDto bccr);

	 /*
	  * 1. 메소드명: selectPromMbrCalcList
	  * 2. 클래스명: LoyPromReactionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyPromMbrCalcListResDto> selectPromMbrCalcList(LoyPromReactionListReqDto bccr);

	 /*
	  * 1. 메소드명: selectPromMbrCalcExcelList
	  * 2. 클래스명: LoyPromReactionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyPromMbrCalcExcelListResDto> selectPromMbrCalcExcelList(LoyPromReactionListReqDto bccr);



}
