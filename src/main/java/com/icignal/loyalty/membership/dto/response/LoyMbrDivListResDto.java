package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
* @name : infavor.Loyalty.batchRgst.dto.response.LoyPntBatchRgstListResponseDTO
* @date : 2018. 11. 5.
* @author : hy.jun
* @description :
*/
@CommCode
public class LoyMbrDivListResDto extends GridPagingItemResDto {
	private String rid;
	private String uploadTypeCd;
	private String uploadTypeCdNm;
	private String procTypeCd;
	private String procTypeCdNm;
	private String filePath;
	private String fileName;
	private String fileUploadDt;
	private String fileUploadUserRid;
	private String fileUploadUserRidNm;
	private String pntApplyDt;
	private String confirmDt;
	private String confirmDtNm;
	private String confirmUserRid;
	private String confirmUserRidNm;
	private String uploadCnt; //대상건수
	private String uploadSuccessCnt; //성공건수
	private String uploadFailCnt; //실패건수
	private String ridCam;
	private String ridOffer;
	private String batchResultCd;
	@MarkName(groupCode="PNT_UPLOAD_BATCH_STATUS_CD", codeField="batchResultCd")
	private String batchResultCdNm;
	private String batchErrorDesc;
	private String totalAcrlAmt;
	
	private String batchSuccessCnt; //적립(배치)처리 성공건수
	private String batchFailCnt; //적립(배치)처리 실패건수
	
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
	public String getUploadTypeCdNm() {
		return uploadTypeCdNm;
	}
	public void setUploadTypeCdNm(String uploadTypeCdNm) {
		this.uploadTypeCdNm = uploadTypeCdNm;
	}
	public String getProcTypeCd() {
		return procTypeCd;
	}
	public void setProcTypeCd(String procTypeCd) {
		this.procTypeCd = procTypeCd;
	}
	public String getProcTypeCdNm() {
		return procTypeCdNm;
	}
	public void setProcTypeCdNm(String procTypeCdNm) {
		this.procTypeCdNm = procTypeCdNm;
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
	public String getFileUploadUserRidNm() {
		return fileUploadUserRidNm;
	}
	public void setFileUploadUserRidNm(String fileUploadUserRidNm) {
		this.fileUploadUserRidNm = fileUploadUserRidNm;
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
	public String getConfirmUserRidNm() {
		return confirmUserRidNm;
	}
	public void setConfirmUserRidNm(String confirmUserRidNm) {
		this.confirmUserRidNm = confirmUserRidNm;
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
	public String getBatchResultCdNm() {
		return batchResultCdNm;
	}
	public void setBatchResultCdNm(String batchResultCdNm) {
		this.batchResultCdNm = batchResultCdNm;
	}
	public String getBatchErrorDesc() {
		return batchErrorDesc;
	}
	public void setBatchErrorDesc(String batchErrorDesc) {
		this.batchErrorDesc = batchErrorDesc;
	}
	public String getUploadFailCnt() {
		return uploadFailCnt;
	}
	public void setUploadFailCnt(String uploadFailCnt) {
		this.uploadFailCnt = uploadFailCnt;
	}
	public String getUploadSuccessCnt() {
		return uploadSuccessCnt;
	}
	public void setUploadSuccessCnt(String uploadSuccessCnt) {
		this.uploadSuccessCnt = uploadSuccessCnt;
	}
	public String getTotalAcrlAmt() {
		return totalAcrlAmt;
	}
	public void setTotalAcrlAmt(String totalAcrlAmt) {
		this.totalAcrlAmt = totalAcrlAmt;
	}
	public String getBatchSuccessCnt() {
		return batchSuccessCnt;
	}
	public void setBatchSuccessCnt(String batchSuccessCnt) {
		this.batchSuccessCnt = batchSuccessCnt;
	}
	public String getBatchFailCnt() {
		return batchFailCnt;
	}
	public void setBatchFailCnt(String batchFailCnt) {
		this.batchFailCnt = batchFailCnt;
	}
}
