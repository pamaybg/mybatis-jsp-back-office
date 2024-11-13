/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpMapper.java
 * 2. Package	: com.icignal.loyalty.targetgrp.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 2:48:27
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpDetailReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpListReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTgtGrpXmListReqDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpDetailResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpListResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpXmListResDto;

/*
 * 1. 클래스명	: LoyTargetGrpMapper
 * 2. 파일명	: LoyTargetGrpMapper.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyTargetGrpMapper {

	 /*
	  * 1. 메소드명: selectTargetGrpList
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyTargetGrpListResDto> selectTargetGrpList(LoyTargetGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectTgtGrpDetail
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	LoyTargetGrpDetailResDto selectTgtGrpDetail(LoyTargetGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: insertTgtDetail
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void insertTgtDetail(LoyTargetGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: updateTgtDetail
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateTgtDetail(LoyTargetGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: selectTgtGrpXmList
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyTargetGrpXmListResDto> selectTgtGrpXmList(LoyTargetGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteTgtGrpXm
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteTgtGrpXm(LoyTargetGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteAllTgtGrpXm
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteAllTgtGrpXm(LoyTargetGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectMbrCustRid
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lplr
	 *   @return	
	 */
	
	LoyTgtGrpXmListReqDto selectMbrCustRid(LoyTgtGrpXmListReqDto lplr);

	 /*
	  * 1. 메소드명: selectProdIdCheck
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mbrRid
	 *   @return	
	 */
	
	Integer selectMbrRidCheck(LoyTgtGrpXmListReqDto mbrRid);

	 /*
	  * 1. 메소드명: deleteTgtGrp
	  * 2. 클래스명: LoyTargetGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteTgtGrp(LoyTargetGrpListReqDto bccr);



}
