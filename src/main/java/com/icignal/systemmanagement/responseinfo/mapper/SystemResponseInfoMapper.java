/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemResponseInfoMapper.java
 * 2. Package	: com.icignal.systemmanagement.responseinfo.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 6. 오후 2:41:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.responseinfo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.responseinfo.dto.request.SystemCheckDuplicationReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemDelResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemGetResponseInfoDetailReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemModifyResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemSetResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemCheckDuplicationResDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemGetResponseInfoDetailResDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemResponseInfoResDto;

/*
 * 1. 클래스명	: SystemResponseInfoMapper
 * 2. 파일명	: SystemResponseInfoMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.responseinfo.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface SystemResponseInfoMapper {

	 /*
	  * 1. 메소드명: selectResponseInfoList
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param rir
	 *   @return	
	 */
	
	List<SystemResponseInfoResDto> selectResponseInfoList(SystemResponseInfoReqDto rir);

	 /*
	  * 1. 메소드명: selectResponseInfoDetail
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param grir
	 *   @return	
	 */
	
	SystemGetResponseInfoDetailResDto selectResponseInfoDetail(SystemGetResponseInfoDetailReqDto grir);

	 /*
	  * 1. 메소드명: selectCheckDuplicationSeq
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ckDupl
	 *   @return	
	 */
	
	String selectCheckDuplicationSeq(SystemCheckDuplicationReqDto ckDupl);

	 /*
	  * 1. 메소드명: selectCheckDuplicationCode
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ckDupl
	 *   @return	
	 */
	
	String selectCheckDuplicationCode(SystemCheckDuplicationReqDto ckDupl);

	 /*
	  * 1. 메소드명: selectCheckDuplicationName
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ckDupl
	 *   @return	
	 */
	
	String selectCheckDuplicationName(SystemCheckDuplicationReqDto ckDupl);

	 /*
	  * 1. 메소드명: insertResponseInfo
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param srir	
	 */
	
	void insertResponseInfo(SystemSetResponseInfoReqDto srir);

	 /*
	  * 1. 메소드명: selectcheckDuplication
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ckDupl
	 *   @return	
	 */
	
	SystemCheckDuplicationResDto selectcheckDuplication(SystemCheckDuplicationReqDto ckDupl);

	 /*
	  * 1. 메소드명: updateResponseInfo
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mrir	
	 */
	
	void updateResponseInfo(SystemModifyResponseInfoReqDto mrir);

	 /*
	  * 1. 메소드명: deleteAboutParId
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param drir	
	 */
	
	void deleteAboutParId(SystemDelResponseInfoReqDto drir);

	 /*
	  * 1. 메소드명: deleteResponseInfo
	  * 2. 클래스명: SystemResponseInfoMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param drir	
	 */
	
	void deleteResponseInfo(SystemDelResponseInfoReqDto drir);



}
