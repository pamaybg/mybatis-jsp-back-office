/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCategoryGrpListReqDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오후 5:34:02
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyCategoryGrpListReqDto
 * 2. 파일명	: LoyCategoryGrpListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyCategoryGrpListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String prodGrpRid;
	private String catId;
	private String catNm;
	private String uploadValidCheck;
	private String fileName;
	private String catRid;
	private String descText;
	private Integer grpCnt;
	
	private List<LoyCategoryGrpListReqDto> array;
	private List<LoyCategoryGrpListReqDto> ridList;
	private int cnt;
	private boolean message;
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
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
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
	public String getCatRid() {
		return catRid;
	}
	public void setCatRid(String catRid) {
		this.catRid = catRid;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public Integer getGrpCnt() {
		return grpCnt;
	}
	public void setGrpCnt(Integer grpCnt) {
		this.grpCnt = grpCnt;
	}
	public List<LoyCategoryGrpListReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyCategoryGrpListReqDto> array) {
		this.array = array;
	}
	public List<LoyCategoryGrpListReqDto> getRidList() {
		return ridList;
	}
	public void setRidList(List<LoyCategoryGrpListReqDto> ridList) {
		this.ridList = ridList;
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
	
	
}
