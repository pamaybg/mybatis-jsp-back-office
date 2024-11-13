/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: EnDeCryptedService.java
 * 2. Package	: com.icignal.common.base.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 3. 오후 5:32:51
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.base.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.DbEnDecryptedDto;
import com.icignal.common.base.mapper.EnDeCryptedMapper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;

/*
 * 1. 클래스명	: EnDeCryptedService
 * 2. 파일명	: EnDeCryptedService.java
 * 3. 패키지명	: com.icignal.common.base.service
 * 4. 작성자명	: 서정환
 * 5. 작성일자	: 2020. 9. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service("enDeCryptedService")
public class EnDeCryptedService {
	
	@Autowired private EnDeCryptedMapper enDeCryptedMapper;
	
	/*
	  * 1. 메소드명: getDbEncrypted
	  * 2. 클래스명: CommonService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 9. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	DB 암호화 함수 호출	
	 * 2. 사용법
	 *	암호화라혀는 값과 ciperKey값을 보냄	
	 * </PRE>
	 *   @param fieldVal
	 *   @return	
	 */
	
	public String getDbEncrypted(String fieldVal) {
		LogUtil.param(this.getClass(), fieldVal);
		DbEnDecryptedDto mlr = new DbEnDecryptedDto();
		mlr.setCipherKey(BeansUtil.getDBEncryptKey());
		mlr.setFieldVal(fieldVal);
		//return enDeCryptedMapper.selectDbEncrypted(mlr);
		return fieldVal;
	}
	
	/*
	  * 1. 메소드명: getDbDecrypted
	  * 2. 클래스명: CommonService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 9. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	DB 복호화 함수 호출
	 * 2. 사용법
	 *  복화화라혀는 값과 ciperKey값을 보냄
	 * </PRE>
	 *   @param fieldVal
	 *   @return	
	 */
	
	public String getDbDecrypted(String fieldVal) {
		LogUtil.param(this.getClass(), fieldVal);
		DbEnDecryptedDto mlr = new DbEnDecryptedDto();
		mlr.setCipherKey(BeansUtil.getDBEncryptKey());
		mlr.setFieldVal(fieldVal);
		//return enDeCryptedMapper.selectDbDecrypted(mlr);
		return fieldVal;
	}
}
