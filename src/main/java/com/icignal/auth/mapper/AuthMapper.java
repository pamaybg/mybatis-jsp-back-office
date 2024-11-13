
/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AuthMapper.java
 * 2. Package	: com.icignal.auth.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 21. 오후 6:57:55
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 21.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.auth.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.auth.dto.request.AuthorityReqDto;
import com.icignal.auth.dto.response.AuthorityDataListResDto;
import com.icignal.auth.dto.response.AuthorityGroupListResDto;
import com.icignal.auth.dto.response.AuthorityListResDto;
import com.icignal.auth.dto.response.AuthorityMenuListResDto;
import com.icignal.auth.dto.response.AuthorityObjectListResDto;
import com.icignal.auth.dto.response.AuthorityProgramListResDto;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.cache.dto.response.ProgramChildResDto;
import com.icignal.common.cache.dto.response.ProgramObject;

/*
 * 1. 클래스명	: AuthMapper
 * 2. 파일명	: AuthMapper.java
 * 3. 패키지명	: com.icignal.auth.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface AuthMapper {

	
	public List<AuthorityGroupListResDto> selectAuthGroupList(AuthorityReqDto reqDto);
	public List<AuthorityListResDto> selectAuthList(AuthorityReqDto reqDto);
	public List<AuthorityDataListResDto> selectAuthDataList(AuthorityReqDto reqDto);
	public List<AuthorityMenuListResDto> selectAuthMenuList(AuthorityReqDto reqDto);
	public List<AuthorityProgramListResDto> selectAuthProgramList(AuthorityReqDto reqDto);
	public List<AuthorityObjectListResDto> selectAuthObjectList(AuthorityReqDto reqDto);
	public List<String> selectSubAccountList(String accId);
	 /*
	  * 1. 메소드명: selectGetAuthId
	  * 2. 클래스명: AuthMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param id
	 *   @return	
	 */
	
	public List<String> selectGetAuthId(String id);
	 /*
	  * 1. 메소드명: selectGetObject
	  * 2. 클래스명: AuthMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param authId
	 *   @return	
	 */
	
	public List<ProgramObject> selectGetObject(List<String> authId);
	 /*
	  * 1. 메소드명: getAuthProgram
	  * 2. 클래스명: AuthMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param authId
	 *   @return	
	 */
	
	public List<ProgramCache> getAuthProgram(List<String> authId);
	 /*
	  * 1. 메소드명: getAuthProgramTabChild
	  * 2. 클래스명: AuthMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param authId
	 *   @return	
	 */
	
	public List<ProgramChildResDto> getAuthProgramTabChild(List<String> authId);


}
