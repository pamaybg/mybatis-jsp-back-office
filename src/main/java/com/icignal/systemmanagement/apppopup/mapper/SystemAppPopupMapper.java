/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemAppPopupMapper.java
 * 2. Package	: com.icignal.systemmanagement.apppopup.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 5:20:26
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.apppopup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopNoticeListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopMasterDetailResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopNoticeListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopSubDetailResDto;

/*
 * 1. 클래스명	: SystemAppPopupMapper
 * 2. 파일명	: SystemAppPopupMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.apppopup.mapper
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
public interface SystemAppPopupMapper {

	 /*
	  * 1. 메소드명: selectAppPopList
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	List<SystemAppPopListResDto> selectAppPopList(SystemAppPopListReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectNoticeSelectList
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	List<SystemAppPopNoticeListResDto> selectNoticeSelectList(SystemAppPopNoticeListReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateAppPopMaster
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	void updateAppPopMaster(SystemAppPopMasterInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertAppPopMaster
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	void insertAppPopMaster(SystemAppPopMasterInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectAppPopMaster
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	SystemAppPopMasterDetailResDto selectAppPopMaster(SystemAppPopMasterDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateAppPopSub
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	void updateAppPopSub(SystemAppPopSubInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertAppPopSub
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	void insertAppPopSub(SystemAppPopSubInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectAppPopSubDetail
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	SystemAppPopSubDetailResDto selectAppPopSubDetail(SystemAppPopSubDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectAppPopSubId
	  * 2. 클래스명: SystemAppPopupMapper
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
	
	String selectAppPopSubId(SystemAppPopSubDetailReqDto reqDTO);


	

}
