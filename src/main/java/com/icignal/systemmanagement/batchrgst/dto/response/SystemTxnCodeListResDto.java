/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemTxnCodeListResDto.java
 * 2. Package	: com.icignal.systemmanagement.batchrgst.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 7. 오후 1:25:41
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemTxnCodeListResDto
 * 2. 파일명	: SystemTxnCodeListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class SystemTxnCodeListResDto extends GridPagingItemResDto{
	private String rid;
	private String txnCodeName;
	private String txnCodeRid;
	private String codeName;
	private String markName;
	
	
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getTxnCodeName() {
		return txnCodeName;
	}
	public void setTxnCodeName(String txnCodeName) {
		this.txnCodeName = txnCodeName;
	}
	public String getTxnCodeRid() {
		return txnCodeRid;
	}
	public void setTxnCodeRid(String txnCodeRid) {
		this.txnCodeRid = txnCodeRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	
	
}
