/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyFaqMapper.java
 * 2. Package	: com.icignal.loyalty.faq.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 16. 오후 6:07:54
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 16.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.faq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.faq.dto.request.LoyFaqDetailReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqInsertReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqListReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqUploadReqDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqDetailResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqListResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqUploadResDto;

/*
 * 1. 클래스명	: LoyFaqMapper
 * 2. 파일명	: LoyFaqMapper.java
 * 3. 패키지명	: com.icignal.loyalty.faq.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyFaqMapper {

	 /*
	  * 1. 메소드명: selectFAQList
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	List<LoyFaqListResDto> selectFAQList(LoyFaqListReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void insertFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void updateFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: increaseFaqCount
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void increaseFaqCount(LoyFaqDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectFaqDetail
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	LoyFaqDetailResDto selectFaqDetail(LoyFaqDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateMasterFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void updateMasterFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: insertMasterFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void insertMasterFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectFaqMasterDetail
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	LoyFaqDetailResDto selectFaqMasterDetail(LoyFaqDetailReqDto reqDTO);

	 /*
	  * 1. 메소드명: removeMainFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void removeMainFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: removeSubFaq
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void removeSubFaq(LoyFaqInsertReqDto reqDTO);

	 /*
	  * 1. 메소드명: updateFaqGrid
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void updateFaqGrid(LoyFaqUploadReqDto reqDto);

	 /*
	  * 1. 메소드명: updateFaqMasterGrid
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	void updateFaqMasterGrid(LoyFaqUploadReqDto reqDto);

	 /*
	  * 1. 메소드명: selectFaqDetailList
	  * 2. 클래스명: LoyFaqMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
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
	
	List<LoyFaqUploadResDto> selectFaqDetailList(LoyFaqUploadReqDto reqDto);

}
