/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMemberTermMapper.java
 * 2. Package	: com.icignal.loyalty.terms.memberterm.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 21. 오후 3:32:25
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 21.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.terms.memberterm.mapper;

import java.util.List;

import com.icignal.loyalty.terms.memberterm.dto.request.LoyMbrTermsHistListReqDto;
import com.icignal.loyalty.terms.memberterm.dto.response.LoyMbrTermsHistListResDto;

/*
 * 1. 클래스명	: LoyMemberTermMapper
 * 2. 파일명	: LoyMemberTermMapper.java
 * 3. 패키지명	: com.icignal.loyalty.terms.memberterm.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public interface LoyMemberTermMapper {

	 /*
	  * 1. 메소드명: selectMbrTermsHistList
	  * 2. 클래스명: LoyMemberTermMapper
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
	
	List<LoyMbrTermsHistListResDto> selectMbrTermsHistList(LoyMbrTermsHistListReqDto reqDto);


}
