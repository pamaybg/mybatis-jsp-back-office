/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: EnDeCryptedMapper.java
 * 2. Package	: com.icignal.common.base.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 3. 오후 5:33:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.base.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.request.DbEnDecryptedDto;

/*
 * 1. 클래스명	: EnDeCryptedMapper
 * 2. 파일명	: EnDeCryptedMapper.java
 * 3. 패키지명	: com.icignal.common.base.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface EnDeCryptedMapper {

	 /*
	  * 1. 메소드명: selectDbEncrypted
	  * 2. 클래스명: EnDeCryptedMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	
	String selectDbEncrypted(DbEnDecryptedDto mlr);

	 /*
	  * 1. 메소드명: selectDbDecrypted
	  * 2. 클래스명: EnDeCryptedMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	
	String selectDbDecrypted(DbEnDecryptedDto mlr);
	
}
