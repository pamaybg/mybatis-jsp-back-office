package com.icignal.loyalty.event.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyProdEntryReqDto extends CommonDataAuthReqDto{
	private String rid;           
	private String mbrNo;
	private String custNm;
	private String mbrStatus;     
	private String rdgDt;         
	private String receiveCustNm; 
	private String receiveHhpNo;
	private String receiveZipNo;  
	private String receiveAddrH;  
	private String receiveAddrD;  
	private String sendYn;        
	private String sendDt;
	private String comment;
	private String uploadValidCheck;
	private String fileName;
	private String eventRid;
	private String ridMbr;
	private String cipherKey;
	private String brndType;
	private String serialNo;
	private String color;
	private String stanYearMonth;
	private List<LoyProdEntryReqDto> array;
	
	
   /*public LoyProdEntryReqDto() {
        try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }
    }*/
	
	public String getBrndType() {
		return brndType;
	}

	public void setBrndType(String brndType) {
		this.brndType = brndType;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getStanYearMonth() {
		return stanYearMonth;
	}

	public void setStanYearMonth(String stanYearMonth) {
		this.stanYearMonth = stanYearMonth;
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

	public String getRdgDt() {
		return rdgDt;
	}

	public void setRdgDt(String rdgDt) {
		this.rdgDt = rdgDt;
	}

	public String getReceiveCustNm() {
		return receiveCustNm;
	}

	public void setReceiveCustNm(String receiveCustNm) {
		this.receiveCustNm = receiveCustNm;
	}

	public String getReceiveHhpNo() {
		return receiveHhpNo;
	}

	public void setReceiveHppNo(String receiveHhpNo) {
		this.receiveHhpNo = receiveHhpNo;
	}

	public String getReceiveZipNo() {
		return receiveZipNo;
	}

	public void setReceiveZipNo(String receiveZipNo) {
		this.receiveZipNo = receiveZipNo;
	}

	public String getReceiveAddrH() {
		return receiveAddrH;
	}

	public void setReceiveAddrH(String receiveAddrH) {
		this.receiveAddrH = receiveAddrH;
	}

	public String getReceiveAddrD() {
		return receiveAddrD;
	}

	public void setReceiveAddrD(String receiveAddrD) {
		this.receiveAddrD = receiveAddrD;
	}

	public String getSendYn() {
		return sendYn;
	}

	public void setSendYn(String sendYn) {
		this.sendYn = sendYn;
	}

	public String getSendDt() {
		return sendDt;
	}

	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public List<LoyProdEntryReqDto> getArray() {
		return array;
	}

	public void setArray(List<LoyProdEntryReqDto> array) {
		this.array = array;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getMbrStatus() {
		return mbrStatus;
	}

	public void setMbrStatus(String mbrStatus) {
		this.mbrStatus = mbrStatus;
	}
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getEventRid() {
		return eventRid;
	}

	public void setEventRid(String eventRid) {
		this.eventRid = eventRid;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

}
