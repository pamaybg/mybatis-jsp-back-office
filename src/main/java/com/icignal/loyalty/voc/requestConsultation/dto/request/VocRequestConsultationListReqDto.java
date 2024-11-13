package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.voc.requestConsultation.dto.request.VOCRequestConsultationListRequestDTO
 * @date : 2017. 10. 13.
 * @author : "dg.ryu"
 * @description : 상담요청 목록 Request DTO
 */
@PersonalData
public class VocRequestConsultationListReqDto extends CommonDataAuthReqDto {

	private String memNo;
	@Encrypted
	private String memName;
	@Encrypted
	private String phoneNo;
	@Encrypted
	private String email;
	@Encrypted
	private String contactInfo;
	private String processSituation;
	private String consultType1st;
	private String consultType2nd;
	private String consultType3rd;
	private String ridCrmuser;
	private String ridCrmuserFlag;
	private String ridCust;
	private String cipherKey;
	private String initFlag;
	private String startDateRcpDt;
	private String endDateRcpDt;
	private String rcpMeth;
	private String srNo;


	public VocRequestConsultationListReqDto(){
		/*try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtility.error(e);
		}*/
	}


	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContactInfo() {
		return contactInfo;
	}
	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}
	public String getProcessSituation() {
		return processSituation;
	}
	public void setProcessSituation(String processSituation) {
		this.processSituation = processSituation;
	}
	public String getConsultType1st() {
		return consultType1st;
	}
	public void setConsultType1st(String consultType1st) {
		this.consultType1st = consultType1st;
	}
	public String getConsultType2nd() {
		return consultType2nd;
	}
	public void setConsultType2nd(String consultType2nd) {
		this.consultType2nd = consultType2nd;
	}
	public String getConsultType3rd() {
		return consultType3rd;
	}
	public void setConsultType3rd(String consultType3rd) {
		this.consultType3rd = consultType3rd;
	}
	public String getRidCrmuser() {
		return ridCrmuser;
	}
	public void setRidCrmuser(String ridCrmuser) {
		this.ridCrmuser = ridCrmuser;
	}
	public String getRidCrmuserFlag() {
		return ridCrmuserFlag;
	}
	public void setRidCrmuserFlag(String ridCrmuserFlag) {
		this.ridCrmuserFlag = ridCrmuserFlag;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getInitFlag() {
		return initFlag;
	}
	public void setInitFlag(String initFlag) {
		this.initFlag = initFlag;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getStartDateRcpDt() {
		return startDateRcpDt;
	}
	public void setStartDateRcpDt(String startDateRcpDt) {
		this.startDateRcpDt = startDateRcpDt;
	}
	public String getEndDateRcpDt() {
		return endDateRcpDt;
	}
	public void setEndDateRcpDt(String endDateRcpDt) {
		this.endDateRcpDt = endDateRcpDt;
	}


	public String getRcpMeth() {
		return rcpMeth;
	}


	public void setRcpMeth(String rcpMeth) {
		this.rcpMeth = rcpMeth;
	}


	/**
	* @return the srNo
	*/
	public String getSrNo() {
		return srNo;
	}


	/**
	* @param srNo the srNo to set
	*/
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}

}


