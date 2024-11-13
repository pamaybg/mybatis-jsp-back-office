/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTgtGrpXmListReqDto.java
 * 2. Package	: com.icignal.loyalty.targetgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 1:37:51
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTgtGrpXmListReqDto
 * 2. 파일명	: LoyTgtGrpXmListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTgtGrpXmListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String custRid;
	private String mbrRid;
	private String custNo;
	private String mbrNo;
	private String uploadValidCheck;
	private String fileName;
	private String tgtGrpRid;
	
	private List<LoyTgtGrpXmListReqDto> array;
	private int cnt;
	private boolean message;
	
	
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getTgtGrpRid() {
		return tgtGrpRid;
	}
	public void setTgtGrpRid(String tgtGrpRid) {
		this.tgtGrpRid = tgtGrpRid;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public boolean isMessage() {
		return message;
	}
	public void setMessage(boolean message) {
		this.message = message;
	}
	public List<LoyTgtGrpXmListReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyTgtGrpXmListReqDto> array) {
		this.array = array;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}
	
	
}
