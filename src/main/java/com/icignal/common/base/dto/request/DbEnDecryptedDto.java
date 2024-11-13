/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: EncryptedDto.java
 * 2. Package	: com.icignal.common.base.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 3. 오후 2:19:29
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.base.dto.request;

/*
 * 1. 클래스명	: EncryptedDto
 * 2. 파일명	: EncryptedDto.java
 * 3. 패키지명	: com.icignal.common.base.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class DbEnDecryptedDto {
	private String fieldVal;
	private String cipherKey;
	public String getFieldVal() {
		return fieldVal;
	}
	public void setFieldVal(String fieldVal) {
		this.fieldVal = fieldVal;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	
	
}
