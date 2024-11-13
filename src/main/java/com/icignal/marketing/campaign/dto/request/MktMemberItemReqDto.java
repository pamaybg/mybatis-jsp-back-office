package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;



/**
 * @name : fileUpload
 * @date : 2015. 10. 24.
 * @author : 장  용
 * @description : 파일 업로드 조회
 */
public class MktMemberItemReqDto extends GridPagingReqDto {

	private String memId;	       //회원 아이디
	private String memFlag;		   //회원 유무 플래그
	private String emailFlag;	   //이메일 유무 플래그
	private String mobileFlag;	   //모바일 유무 플래그
	private String emailConFlag;   //이메일 동의 여부 플래그
	private String smsConFlag;     //sms 동의 여부 플래그
	private String email;		   //외부고객일 경우 이메일
	private String phoneNo;		   //외부고객일 경우 전화번호
	private String dupFlag;		   //회원 아이디 중복 플래그
	private String exceptFlag;	   //제외 여부
	private String prmsFlag;	   //퍼미션 플래그

	private int memSeq;		       //회원 리스트 순서

	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemFlag() {
		return memFlag;
	}
	public void setMemFlag(String memFlag) {
		this.memFlag = memFlag;
	}
	public String getEmailFlag() {
		return emailFlag;
	}
	public void setEmailFlag(String emailFlag) {
		this.emailFlag = emailFlag;
	}
	public String getMobileFlag() {
		return mobileFlag;
	}
	public void setMobileFlag(String mobileFlag) {
		this.mobileFlag = mobileFlag;
	}
	public String getEmailConFlag() {
		return emailConFlag;
	}
	public void setEmailConFlag(String emailConFlag) {
		this.emailConFlag = emailConFlag;
	}
	public String getSmsConFlag() {
		return smsConFlag;
	}
	public void setSmsConFlag(String smsConFlag) {
		this.smsConFlag = smsConFlag;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getDupFlag() {
		return dupFlag;
	}
	public void setDupFlag(String dupFlag) {
		this.dupFlag = dupFlag;
	}
	public int getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(int memSeq) {
		this.memSeq = memSeq;
	}
	public String getExceptFlag() {
		return exceptFlag;
	}
	public void setExceptFlag(String exceptFlag) {
		this.exceptFlag = exceptFlag;
	}
	public String getPrmsFlag() {
		return prmsFlag;
	}
	public void setPrmsFlag(String prmsFlag) {
		this.prmsFlag = prmsFlag;
	}


}