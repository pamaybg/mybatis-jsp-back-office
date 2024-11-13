/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPntBatchRgstUploadReqDto.java
 * 2. Package	: com.icignal.systemmanagement.batchrgst.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 16. 오후 3:47:10
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.batchrgst.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/*
 * 1. 클래스명	: LoyPntBatchRgstUploadReqDto
 * 2. 파일명	: LoyPntBatchRgstUploadReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPntBatchRgstUploadReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String uploadTypeCd;
	private String procTypeCd;
	private String filePath;
	private String fileName;
	private String fileUploadDt;
	private String fileUploadUserRid;
	private String pntApplyDt;
	private String confirmDt;
	private String confirmDtNm;
	private String confirmUserRid;
	private String uploadCnt;
	private String ridCam;
	private String ridOffer;
	private String batchResultCd;
	private String batchErrorDesc;

	private String offerType;
	private String uploadValidCheck;

	private String ci;
	private String dispNo;

	/**
	 * 업로드 에러메시지 분기 위한 유형코드
	 *
	 * procTypeCd 	: TARGET_MEMBER (대상유형:회원)
	 * 1			: 회원번호 기준 회원정보 미존재
	 * 2			: 적립포인트 미존재
	 * 3			: 프로모션 캠페인 미존재
	 *
	 * procTypeCd 	: TARGET_EVENT (대상유형:이벤트)
	 * 1			: 성명 미존재
	 * 2			: 핸드폰번호 미존재
	 * 3			: 적립포인트 미존재
	 * 4			: 프로모션 캠페인 미존재
	 */
	private String validType;

	private List<LoyPntBatchRgstItemReqDto> array;
	
	private List<LoySmsUnSubscribeItemReqDto> nonSubArray;
	
	private String pRid;
	private String pType;
	private String pRst;
	private String pRstCd;
	private String pRstMsg;
	private String failUploadCnt;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUploadTypeCd() {
		return uploadTypeCd;
	}
	public void setUploadTypeCd(String uploadTypeCd) {
		this.uploadTypeCd = uploadTypeCd;
	}
	public String getProcTypeCd() {
		return procTypeCd;
	}
	public void setProcTypeCd(String procTypeCd) {
		this.procTypeCd = procTypeCd;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileUploadDt() {
		return fileUploadDt;
	}
	public void setFileUploadDt(String fileUploadDt) {
		this.fileUploadDt = fileUploadDt;
	}
	public String getFileUploadUserRid() {
		return fileUploadUserRid;
	}
	public void setFileUploadUserRid(String fileUploadUserRid) {
		this.fileUploadUserRid = fileUploadUserRid;
	}
	public String getPntApplyDt() {
		return pntApplyDt;
	}
	public void setPntApplyDt(String pntApplyDt) {
		this.pntApplyDt = pntApplyDt;
	}
	public String getConfirmDt() {
		return confirmDt;
	}
	public void setConfirmDt(String confirmDt) {
		this.confirmDt = confirmDt;
	}
	public String getConfirmDtNm() {
		return confirmDtNm;
	}
	public void setConfirmDtNm(String confirmDtNm) {
		this.confirmDtNm = confirmDtNm;
	}
	public String getConfirmUserRid() {
		return confirmUserRid;
	}
	public void setConfirmUserRid(String confirmUserRid) {
		this.confirmUserRid = confirmUserRid;
	}
	public String getUploadCnt() {
		return uploadCnt;
	}
	public void setUploadCnt(String uploadCnt) {
		this.uploadCnt = uploadCnt;
	}
	public String getRidCam() {
		return ridCam;
	}
	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}
	public String getRidOffer() {
		return ridOffer;
	}
	public void setRidOffer(String ridOffer) {
		this.ridOffer = ridOffer;
	}
	public String getBatchResultCd() {
		return batchResultCd;
	}
	public void setBatchResultCd(String batchResultCd) {
		this.batchResultCd = batchResultCd;
	}
	public String getBatchErrorDesc() {
		return batchErrorDesc;
	}
	public void setBatchErrorDesc(String batchErrorDesc) {
		this.batchErrorDesc = batchErrorDesc;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getValidType() {
		return validType;
	}
	public void setValidType(String validType) {
		this.validType = validType;
	}
	public List<LoyPntBatchRgstItemReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyPntBatchRgstItemReqDto> array) {
		this.array = array;
	}
	public List<LoySmsUnSubscribeItemReqDto> getNonSubArray() {
		return nonSubArray;
	}
	public void setNonSubArray(List<LoySmsUnSubscribeItemReqDto> nonSubArray) {
		this.nonSubArray = nonSubArray;
	}
	public String getpRid() {
		return pRid;
	}
	public void setpRid(String pRid) {
		this.pRid = pRid;
	}
	public String getpType() {
		return pType;
	}
	public void setpType(String pType) {
		this.pType = pType;
	}
	public String getpRst() {
		return pRst;
	}
	public void setpRst(String pRst) {
		this.pRst = pRst;
	}
	public String getpRstCd() {
		return pRstCd;
	}
	public void setpRstCd(String pRstCd) {
		this.pRstCd = pRstCd;
	}
	public String getpRstMsg() {
		return pRstMsg;
	}
	public void setpRstMsg(String pRstMsg) {
		this.pRstMsg = pRstMsg;
	}
	public String getFailUploadCnt() {
		return failUploadCnt;
	}
	public void setFailUploadCnt(String failUploadCnt) {
		this.failUploadCnt = failUploadCnt;
	}
	
	
}
