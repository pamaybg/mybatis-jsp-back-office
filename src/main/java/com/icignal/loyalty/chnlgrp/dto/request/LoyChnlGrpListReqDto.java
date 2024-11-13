/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpListReqDto.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오후 5:06:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlGrpListReqDto
 * 2. 파일명	: LoyChnlGrpListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlGrpListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String chnlGrpRid;
	private String chnlNo;
	private String chnlNm;
	private String uploadValidCheck;
	private String fileName;
	private String chnlRid;
	private String descText;
	private Integer grpCnt;
	private String lvlCd;
	
	private List<LoyChnlGrpListReqDto> array;
	private List<LoyChnlGrpListReqDto> ridList;
	private int cnt;
	private boolean message;
	
	
	public String getLvlCd() {
		return lvlCd;
	}
	public void setLvlCd(String lvlCd) {
		this.lvlCd = lvlCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public List<LoyChnlGrpListReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyChnlGrpListReqDto> array) {
		this.array = array;
	}
	public List<LoyChnlGrpListReqDto> getRidList() {
		return ridList;
	}
	public void setRidList(List<LoyChnlGrpListReqDto> ridList) {
		this.ridList = ridList;
	}
	public String getChnlGrpRid() {
		return chnlGrpRid;
	}
	public void setChnlGrpRid(String chnlGrpRid) {
		this.chnlGrpRid = chnlGrpRid;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	
	
}
