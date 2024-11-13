/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AppVersionMapper.java
 * 2. Package	: com.icignal.systemmanagement.appversion.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 4:32:04
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.appversion.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerDetailReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerInsertReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerListReqDto;
import com.icignal.systemmanagement.appversion.dto.response.SystemAppVerDetailResDto;
import com.icignal.systemmanagement.appversion.dto.response.SystemAppVerListResDto;

/*
 * 1. 클래스명	: AppVersionMapper
 * 2. 파일명	: AppVersionMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.appversion.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface SystemAppVersionMapper {

	 /*
	  * 1. 메소드명: selectAppVerList
	  * 2. 클래스명: SystemAppVersionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	
	List<SystemAppVerListResDto> selectAppVerList(SystemAppVerListReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateAppVersion
	  * 2. 클래스명: SystemAppVersionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO	
	 */
	
	void updateAppVersion(SystemAppVerInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertAppVersion
	  * 2. 클래스명: SystemAppVersionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO	
	 */
	
	void insertAppVersion(SystemAppVerInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectAppDetail
	  * 2. 클래스명: SystemAppVersionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	
	SystemAppVerDetailResDto selectAppDetail(SystemAppVerDetailReqDto reqDTO);

}
