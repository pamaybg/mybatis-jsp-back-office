/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: loggingMapper.java
 * 2. Package	: com.icignal.common.logging.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 2:40:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.logging.mapper;

import com.icignal.common.logging.dto.request.*;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.scheduling.annotation.Async;

import com.icignal.common.logging.request.LOYMaskReleaLogReqDto;

/*
 * 1. 클래스명	: loggingMapper
 * 2. 파일명	: loggingMapper.java
 * 3. 패키지명	: com.icignal.common.logging.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoggingMapper {

	 /*
	  * 1. 메소드명: insertCustMaskReleaLog
	  * 2. 클래스명: LoggingMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>	
	 */
	
	public void insertCustMaskReleaLog(LOYCustMaskReleaLogReqDto reqDto);

	 /*
	  * 1. 메소드명: insertServiceReqLog
	  * 2. 클래스명: LoggingMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 20.
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
	
	public void insertServiceReqLog(ServiceReqLogReqDto reqDto);

	 /*
	  * 1. 메소드명: insertMaskReleaLog
	  * 2. 클래스명: LoggingMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param logReq	
	 */
	
	public void insertMaskReleaLog(LOYMaskReleaLogReqDto logReq);

	 /*
	  * 1. 메소드명: insertExcelDownloadLog
	  * 2. 클래스명: LoggingMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param edlr	
	 */
	@Async
	public void insertExcelDownloadLog(ExcelDownloadLogReqDto edlr);

}
