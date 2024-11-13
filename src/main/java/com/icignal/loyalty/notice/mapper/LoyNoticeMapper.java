/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyNoticeMapper.java
 * 2. Package	: com.icignal.loyalty.notice.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 9. 오후 4:44:43
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 9.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.notice.mapper;

import java.util.List;

import com.icignal.loyalty.notice.dto.request.LoyNoticeDetailReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeInsertReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeListReqDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeDetailResDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeListResDto;

/*
 * 1. 클래스명	: LoyNoticeMapper
 * 2. 파일명	: LoyNoticeMapper.java
 * 3. 패키지명	: com.icignal.loyalty.notice.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public interface LoyNoticeMapper {

	 /*
	  * 1. 메소드명: selectNoticeList
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	List<LoyNoticeListResDto> selectNoticeList(LoyNoticeListReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateNotice
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void updateNotice(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertNotice
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void insertNotice(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: getNoticeId
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	String getNoticeId(LoyNoticeDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: getNoticeDetail
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	LoyNoticeDetailResDto getNoticeDetail(LoyNoticeDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: increaseNoticeCount
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void increaseNoticeCount(LoyNoticeDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateNoticeMaster
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void updateNoticeMaster(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertNoticeMaster
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void insertNoticeMaster(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: getNoticeMasterDetail
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	LoyNoticeDetailResDto getNoticeMasterDetail(LoyNoticeDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: deleteMstNotice
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void deleteMstNotice(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: deleteSubNotice
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	
	void deleteSubNotice(LoyNoticeInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectNoticeList
	  * 2. 클래스명: LoyNoticeMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	

}
