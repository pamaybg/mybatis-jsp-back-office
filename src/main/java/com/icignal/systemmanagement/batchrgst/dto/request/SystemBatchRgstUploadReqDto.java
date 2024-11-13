package com.icignal.systemmanagement.batchrgst.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.Loyalty.batchRgst.dto.request.SystemBatchRgstUploadReqDto
* @date : 2017. 11. 28.
* @author : kimjunki
* @description :
*/
public class  SystemBatchRgstUploadReqDto extends CommonDataAuthReqDto {
	
	private String mbrId;
	private String saveStamp;
	private String dedutionDiv;
	private String mbrNo;
	private String upldId;
	private String insertUploadDataRid;
	
	private String purchDate;
	private String savePnt;
	private String saveMoney;
	
	private String reqPoint;
	
	private String rid;
	private String ridMbr;
	private String parRid;
	private String offerType;
	private String empId;
	private String fileName;
	private String filePath;
	
	private String fileUpldSucesCnt;
	private String fileUpldFailCnt;
	private String uploadRslt;
	
	
	private String uploadValidCheck;
	
	private List<SystemBatchRgstUploadReqDto> array;
	
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getSaveStamp() {
		return saveStamp;
	}
	public void setSaveStamp(String saveStamp) {
		this.saveStamp = saveStamp;
	}

	
	public String getInsertUploadDataRid() {
		return insertUploadDataRid;
	}
	public void setInsertUploadDataRid(String insertUploadDataRid) {
		this.insertUploadDataRid = insertUploadDataRid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getDedutionDiv() {
		return dedutionDiv;
	}
	public void setDedutionDiv(String dedutionDiv) {
		this.dedutionDiv = dedutionDiv;
	}
	public String getPurchDate() {
		return purchDate;
	}
	public void setPurchDate(String purchDate) {
		this.purchDate = purchDate;
	}
	public String getSavePnt() {
		return savePnt;
	}
	public void setSavePnt(String savePnt) {
		this.savePnt = savePnt;
	}
	public String getSaveMoney() {
		return saveMoney;
	}
	public void setSaveMoney(String saveMoney) {
		this.saveMoney = saveMoney;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public List<SystemBatchRgstUploadReqDto> getArray() {
		return array;
	}
	public void setArray(List<SystemBatchRgstUploadReqDto> array) {
		this.array = array;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileUpldSucesCnt() {
		return fileUpldSucesCnt;
	}
	public void setFileUpldSucesCnt(String fileUpldSucesCnt) {
		this.fileUpldSucesCnt = fileUpldSucesCnt;
	}
	public String getFileUpldFailCnt() {
		return fileUpldFailCnt;
	}
	public void setFileUpldFailCnt(String fileUpldFailCnt) {
		this.fileUpldFailCnt = fileUpldFailCnt;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getUploadRslt() {
		return uploadRslt;
	}
	public void setUploadRslt(String uploadRslt) {
		this.uploadRslt = uploadRslt;
	}
	public String getReqPoint() {
		return reqPoint;
	}
	public void setReqPoint(String reqPoint) {
		this.reqPoint = reqPoint;
	}
	public String getUpldId() {
		return upldId;
	}
	public void setUpldId(String upldId) {
		this.upldId = upldId;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}

	
	
}
