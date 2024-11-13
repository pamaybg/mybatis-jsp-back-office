package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyProdEntryResDto extends GridPagingItemResDto {
	 private String rid;                       
	 private String mbrNo;
	 @Decrypted(masked="custNm")
	 private String custNm;
	 private String mbrStatus;           
	 private String rdgDt;           
	 @Decrypted(masked="receiveCustNm")
	 private String receiveCustNm; 
	 
	 @Decrypted(masked="receiveHhpNo")
	 private String receiveHhpNo;   
	 private String receiveZipNo;   
	 private String receiveAddrH;
	 
	 @Decrypted(masked="receiveAddrD")
	 private String receiveAddrD;   
	 private String sendYn;                   
	 private String sendDt;
	 private String comment1;
	 private String ridMbr;
	 private String webId;
	 private String hhpNo;
	 
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getMbrStatus() {
		return mbrStatus;
	}
	public void setMbrStatus(String mbrStatus) {
		this.mbrStatus = mbrStatus;
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
	public String getComment1() {
		return comment1;
	}
	public void setComment1(String comment1) {
		this.comment1 = comment1;
	}
	public String getReceiveHhpNo() {
		return receiveHhpNo;
	}
	public void setReceiveHhpNo(String receiveHhpNo) {
		this.receiveHhpNo = receiveHhpNo;
	}
	 
	 
}
