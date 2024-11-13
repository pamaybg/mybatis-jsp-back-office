/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: EmailAuthMapper.java
 * 2. Package	: com.icignal.common.emailAuth.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 19. 오후 3:42:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 19.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.auth.emailAuth.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.auth.dto.request.LoginEmailAuthReqDto;


/*
 * 1. 클래스명	: EmailAuthMapper
 * 2. 파일명	: EmailAuthMapper.java
 * 3. 패키지명	: com.icignal.common.emailAuth.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface EmailAuthMapper {
	public void updateEmailAuth(LoginEmailAuthReqDto param);
	public int insertEmailAuth(LoginEmailAuthReqDto param);
	public int emailAuthLoginLimitDtCheck(LoginEmailAuthReqDto param);
	public int emailAuthLoginIdCheck(LoginEmailAuthReqDto param);
	public int emailAuthDtCheck(LoginEmailAuthReqDto param);
	public int emailAuthSuccessChk(String param);
	
	
	

	
}
