package com.icignal.systemmanagement.pushmsg.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class SystemTestPushResultListResDto extends GridPagingItemResDto {

	private String rid;
	private String mbrNo;
	@Decrypted(masked ="custNm")
	private String custNm;
	@Decrypted(masked ="tel")
	private String hhpNo;
	private String webId;
	private String sendStatus;
	@Decrypted(masked ="email")
	private String emailAddr;
	
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
}
