package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyEvtApplctResDto  extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;                                           
	@Decrypted(masked="custNm")                                     
	private String custNm;                                          
	private String mbrStatus;                                       
	private String applctDt;                                        
	private String applctTicketCnt;                                 
	private String snsId;                                           
	private String applctUrl;                                       
	private Integer validCnt;                                       
	private String ridMbr;                                          
	private String ridEvtWinner;                                    
	private String winYn;                                           
	private String winDt;                                           
	private String bnfYn;                                           
	private String bnfDt;                                           
	private String age;                                             
	private String gender;                                          
	private String uploadPath;                                      
	@Decrypted(masked="email")                                      
	private String webId;
	private String ecommMbrNo;
	@Decrypted(masked="tel")
	private String hhpNo;
	
	@Decrypted(masked="none")
	private String unMaskHhp;
	@Decrypted(masked="none")
	private String unMaskWebId;
	@Decrypted(masked="none")
	private String unMaskCustNm;

	private String winCmpltYn; // 당첨여부
	private String sbscTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscTypeCd")
	private String sbscTypeCdNm;
	
	
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
	}
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getWinCmpltYn() {
		return winCmpltYn;
	}
	public void setWinCmpltYn(String winCmpltYn) {
		this.winCmpltYn = winCmpltYn;
	}
	
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getUnMaskWebId() {
		return unMaskWebId;
	}
	public void setUnMaskWebId(String unMaskWebId) {
		this.unMaskWebId = unMaskWebId;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getApplctDt() {
		return applctDt;
	}
	public void setApplctDt(String applctDt) {
		this.applctDt = applctDt;
	}
	public String getApplctTicketCnt() {
		return applctTicketCnt;
	}
	public void setApplctTicketCnt(String applctTicketCnt) {
		this.applctTicketCnt = applctTicketCnt;
	}
	public String getSnsId() {
		return snsId;
	}
	public void setSnsId(String snsId) {
		this.snsId = snsId;
	}
	public String getApplctUrl() {
		return applctUrl;
	}
	public void setApplctUrl(String applctUrl) {
		this.applctUrl = applctUrl;
	}
	public Integer getValidCnt() {
		return validCnt;
	}
	public void setValidCnt(Integer validCnt) {
		this.validCnt = validCnt;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getWinYn() {
		return winYn;
	}
	public void setWinYn(String winYn) {
		this.winYn = winYn;
	}
	public String getWinDt() {
		return winDt;
	}
	public void setWinDt(String winDt) {
		this.winDt = winDt;
	}
	public String getBnfYn() {
		return bnfYn;
	}
	public void setBnfYn(String bnfYn) {
		this.bnfYn = bnfYn;
	}
	public String getBnfDt() {
		return bnfDt;
	}
	public void setBnfDt(String bnfDt) {
		this.bnfDt = bnfDt;
	}
	public String getRidEvtWinner() {
		return ridEvtWinner;
	}
	public void setRidEvtWinner(String ridEvtWinner) {
		this.ridEvtWinner = ridEvtWinner;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}

}
