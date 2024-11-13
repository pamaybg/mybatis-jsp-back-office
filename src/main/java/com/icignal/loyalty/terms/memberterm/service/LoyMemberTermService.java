/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMemberTermService.java
 * 2. Package	: com.icignal.loyalty.terms.memberterm.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 21. 오후 3:32:04
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 21.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.terms.memberterm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.terms.memberterm.dto.request.LoyMbrTermsHistListReqDto;
import com.icignal.loyalty.terms.memberterm.dto.response.LoyMbrTermsHistListResDto;
import com.icignal.loyalty.terms.memberterm.mapper.LoyMemberTermMapper;

/*
 * 1. 클래스명	: LoyMemberTermService
 * 2. 파일명	: LoyMemberTermService.java
 * 3. 패키지명	: com.icignal.loyalty.terms.memberterm.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyMemberTermService {
	
	@Autowired LoyMemberTermMapper loyMemberTermMapper;
	
	 /*
	  * 1. 메소드명: getMbrTermsHistList
	  * 2. 클래스명: LoyMemberTermService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 회원상세 약관동의 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrTermsHistListResDto> getMbrTermsHistList(LoyMbrTermsHistListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("T1");
        
        return new GridPagingResHelper<LoyMbrTermsHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMemberTermMapper.selectMbrTermsHistList(reqDto));
        
	}
}
