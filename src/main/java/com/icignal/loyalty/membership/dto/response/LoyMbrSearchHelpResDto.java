package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrPasswordResponseDTO
 * @date : 2017. 7. 18.
 * @author : jh.kim
 * @description : 로얄티 프로그램 회원 비밀번호 관리 Response DTO
 */
@PersonalData
@CommCode
public class LoyMbrSearchHelpResDto extends GridPagingItemResDto {

    private String rid;
    private String mbrNo;
    @Decrypted(masked = "custNm")
    private String custNm;
    private String mbrType;
    private String webMemId;
    @Decrypted(masked = "tel")
    private String hhpNo;
    private String realBirthDt;
    private String tierNm;
    
    @Decrypted(masked = "email")
    private String emailAddr;
    private String memDiv;
    private String tierCd;
    private String ridCust;

    // 회원상태
    private String mbrStatCd;
    
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
    private String mbrStatNm;
    
    private String mbrLockYn; //휴면여부

    public String getMbrStatCd() {
        return mbrStatCd;
    }

    public void setMbrStatCd(String mbrStatCd) {
        this.mbrStatCd = mbrStatCd;
    }

    public String getMbrStatNm() {
        return mbrStatNm;
    }

    public void setMbrStatNm(String mbrStatNm) {
        this.mbrStatNm = mbrStatNm;
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

    public String getMbrType() {
        return mbrType;
    }

    public void setMbrType(String mbrType) {
        this.mbrType = mbrType;
    }

    public String getWebMemId() {
        return webMemId;
    }

    public void setWebMemId(String webMemId) {
        this.webMemId = webMemId;
    }

    public String getHhpNo() {
        return hhpNo;
    }

    public void setHhpNo(String hhpNo) {
        this.hhpNo = hhpNo;
    }

    public String getRealBirthDt() {
        return realBirthDt;
    }

    public void setRealBirthDt(String realBirthDt) {
        this.realBirthDt = realBirthDt;
    }

    public String getTierNm() {
        return tierNm;
    }

    public void setTierNm(String tierNm) {
        this.tierNm = tierNm;
    }

    public String getEmailAddr() {
        return emailAddr;
    }

    public void setEmailAddr(String emailAddr) {
        this.emailAddr = emailAddr;
    }

    public String getMemDiv() {
        return memDiv;
    }

    public void setMemDiv(String memDiv) {
        this.memDiv = memDiv;
    }

    public String getTierCd() {
        return tierCd;
    }

    public void setTierCd(String tierCd) {
        this.tierCd = tierCd;
    }

    /**
     * @return the ridCust
     */
    public String getRidCust() {
        return ridCust;
    }

    /**
     * @param ridCust
     *            the ridCust to set
     */
    public void setRidCust(String ridCust) {
        this.ridCust = ridCust;
    }

	public String getMbrLockYn() {
		return mbrLockYn;
	}

	public void setMbrLockYn(String mbrLockYn) {
		this.mbrLockYn = mbrLockYn;
	}

}
