/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpListReqDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 5:34:31
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyProdGrpListReqDto
 * 2. 파일명	: LoyProdGrpListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyProdGrpListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String prodGrpRid;
	private String prodId;
	private String prodNm;
	private String uploadValidCheck;
	private String fileName;
	private String prodRid;
	private String descText;
	private Integer grpCnt;
	
	private List<LoyProdGrpListReqDto> array;
	private List<LoyProdGrpListReqDto> ridList;
	private int cnt;
	private boolean message;
	
	
	
	
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getProdRid() {
		return prodRid;
	}
	public void setProdRid(String prodRid) {
		this.prodRid = prodRid;
	}
	public List<LoyProdGrpListReqDto> getRidList() {
		return ridList;
	}
	public void setRidList(List<LoyProdGrpListReqDto> ridList) {
		this.ridList = ridList;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdGrpRid() {
		return prodGrpRid;
	}
	public void setProdGrpRid(String prodGrpRid) {
		this.prodGrpRid = prodGrpRid;
	}
	public List<LoyProdGrpListReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyProdGrpListReqDto> array) {
		this.array = array;
	}
	public Integer getGrpCnt() {
		return grpCnt;
	}
	public void setGrpCnt(Integer grpCnt) {
		this.grpCnt = grpCnt;
	}
	
	
	
	
}
