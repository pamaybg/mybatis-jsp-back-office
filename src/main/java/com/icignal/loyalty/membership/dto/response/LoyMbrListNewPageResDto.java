/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrListNewPageResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 8. 오후 2:58:06
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 8.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import java.util.Calendar;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrListNewPageResDto
 * 2. 파일명	: LoyMbrListNewPageResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 8.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
@PersonalData
public class LoyMbrListNewPageResDto extends GridPagingItemResDto{
	private String rid;
	private String mbRid;
	private String pgmNm;
	private String mbrNo;
	private String custNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	private String mbrStatCd;
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
	private String mbrStatCdNm;
	private String createDate;
	private String sbscChnlNm;
	private String sbscDate;
	private String sendEndDate;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	@Decrypted(masked = "none")
	private String unMaskEmail;
	@Decrypted(masked = "none")
	private String unMaskUserId;

	@Decrypted(masked = "email")
	private String maskEmail;

	private String pgmRid;
	private String genCd;
	@MarkName(groupCode="LOY_GEN_CD", codeField="genCd")
	private String genCdNm;
	private String birtHdt;
	
	@Decrypted(masked = "webId")
	private String userId;

	@Decrypted(masked = "none")
	private String email;
	
	private String svcDt;
	private String expectDormancyDate;
	private String executeDate;
	
	private String teamNm;
	private String empNo;
	private String statusCd;
	@MarkName(groupCode="LOY_STATUS_CD", codeField="statusCd")
	private String statusCdNm;
	private String chnlNm;
	private String companyNm;
	
	private String custTypeCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD",codeField="custTypeCd")
	private String custTypeCdNm;
	
	private String custTypeCdNm2;
	
	private String	livingFriends;
	private String  opinionLeader;
	private String  greenMate;
	private String  robinsonCustomer;
	
	private String tierCd;
	@MarkName(groupCode="LOY_MBR_TIER_TYPE_CD",codeField="tierCd")
	private String tierNm;
	private String drmncyDate;
	
	private String sbscFullChnlNm;
	private String mbrTypeCd;
	
	@MarkName(groupCode="LOY_MBR_TYPE_CD",codeField="mbrTypeCd")
	private String mbrTypeCdNm;

	private String sbscTypeCd;
	@MarkName(groupCode="LOY_SBSC_TYPE_CD",codeField="sbscTypeCd")
	private String sbscTypeCdNm;
	
	private String repYn;
	private String birthDate;
	private String ridMbr;
	private String ridCust;
	@Decrypted(masked = "none")
	private String unMaskEmailAddr;

	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DST", codeField = "tierDST")
	private String tierDSTNm;
	private String tierDST;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_UMB", codeField = "tierUMB")
	private String tierUMBNm;
	private String tierUMB;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCS", codeField = "tierLCS")
	private String tierLCSNm;
	private String tierLCS;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DSG", codeField = "tierDSG")
	private String tierDSGNm;
	private String tierDSG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCG", codeField = "tierLCG")
	private String tierLCGNm;
	private String tierLCG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_MSW", codeField = "tierMSW")
	private String tierMSWNm;
	private String tierMSW;

	private String proGolfYn;
	private String drcYn;

	public String getMaskEmail() {
		return maskEmail;
	}
	public void setMaskEmail(String maskEmail) {
		this.maskEmail = maskEmail;
	}

	public String getUnMaskEmailAddr() {
		return unMaskEmailAddr;
	}
	public void setUnMaskEmailAddr(String unMaskEmailAddr) {
		this.unMaskEmailAddr = unMaskEmailAddr;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getUnMaskUserId() {
		return unMaskUserId;
	}
	public void setUnMaskUserId(String unMaskUserId) {
		this.unMaskUserId = unMaskUserId;
	}
	public String getUnMaskEmail() {
		return unMaskEmail;
	}
	public void setUnMaskEmail(String unMaskEmail) {
		this.unMaskEmail = unMaskEmail;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getLivingFriends() {
		return livingFriends;
	}
	public void setLivingFriends(String livingFriends) {
		this.livingFriends = livingFriends;
	}
	public String getOpinionLeader() {
		return opinionLeader;
	}
	public void setOpinionLeader(String opinionLeader) {
		this.opinionLeader = opinionLeader;
	}
	public String getGreenMate() {
		return greenMate;
	}
	public void setGreenMate(String greenMate) {
		this.greenMate = greenMate;
	}
	public String getRobinsonCustomer() {
		return robinsonCustomer;
	}
	public void setRobinsonCustomer(String robinsonCustomer) {
		this.robinsonCustomer = robinsonCustomer;
	}
	public String getExecuteDate() {
		return executeDate;
	}
	public void setExecuteDate(String executeDate) {
		this.executeDate = executeDate;
	}
	public String getMbRid() {
		return mbRid;
	}
	public void setMbRid(String mbRid) {
		this.mbRid = mbRid;
	}
	public String getStatusCdNm() {
		return statusCdNm;
	}
	public void setStatusCdNm(String statusCdNm) {
		this.statusCdNm = statusCdNm;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public String getSvcDt() {
		return svcDt;
	}
	public void setSvcDt(String svcDt) {
		this.svcDt = svcDt;
	}
	public String getExpectDormancyDate() {
		return expectDormancyDate;
	}
	public void setExpectDormancyDate(String expectDormancyDate) {
		this.expectDormancyDate = expectDormancyDate;
	}
	public String getBirtHdt() {
		return birtHdt;
	}
	public void setBirtHdt(String birtHdt) {
		this.birtHdt = birtHdt;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGenCd() {
		return genCd;
	}
	public void setGenCd(String genCd) {
		this.genCd = genCd;
	}
	public String getGenCdNm() {
		return genCdNm;
	}
	public void setGenCdNm(String genCdNm) {
		this.genCdNm = genCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getSbscChnlNm() {
		return sbscChnlNm;
	}
	public void setSbscChnlNm(String sbscChnlNm) {
		this.sbscChnlNm = sbscChnlNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getDrmncyDate() {
		return drmncyDate;
	}
	public void setDrmncyDate(String drmncyDate) {
		this.drmncyDate = drmncyDate;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getSendEndDate() {
		return sendEndDate;
	}
	public void setSendEndDate(String sendEndDate) {
		this.sendEndDate = sendEndDate;
	}
	
	public String getCustTypeCdNm2() {
		return custTypeCdNm2;
	}
	public void setCustTypeCdNm2(String custTypeCdNm2) {
		this.custTypeCdNm2 = custTypeCdNm2;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
	}
	public String getSbscFullChnlNm() {
		return sbscFullChnlNm;
	}
	public void setSbscFullChnlNm(String sbscFullChnlNm) {
		this.sbscFullChnlNm = sbscFullChnlNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
	}
	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
	if(birthDate!=null){
	String[] ages = birthDate.split("-");
		
		int birthYear = Integer.parseInt(ages[0]);
		int birthMonth = Integer.parseInt(ages[1]);
		int birthDay = Integer.parseInt(ages[2]);
		
		//나이 구하기
        Calendar current = Calendar.getInstance();
        int currentYear  = current.get(Calendar.YEAR);
        int currentMonth = current.get(Calendar.MONTH) + 1;
        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
       
        int age = currentYear - birthYear;
        // 생일 안 지난 경우 -1
        if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
            age--;
        }
        birthDate = Integer.toString(age);
        
        if(birthDate.equals("0")) {
        	birthDate = null;
        }
        
		
	}
	this.birthDate = birthDate;
	}

	public String getTierDST() {
		return tierDST;
	}

	public void setTierDST(String tierDST) {
		this.tierDST = tierDST;
	}

	public String getTierUMB() {
		return tierUMB;
	}

	public void setTierUMB(String tierUMB) {
		this.tierUMB = tierUMB;
	}

	public String getTierLCS() {
		return tierLCS;
	}

	public void setTierLCS(String tierLCS) {
		this.tierLCS = tierLCS;
	}

	public String getTierDSG() {
		return tierDSG;
	}

	public void setTierDSG(String tierDSG) {
		this.tierDSG = tierDSG;
	}

	public String getTierLCG() {
		return tierLCG;
	}

	public void setTierLCG(String tierLCG) {
		this.tierLCG = tierLCG;
	}

	public String getTierMSW() {
		return tierMSW;
	}

	public void setTierMSW(String tierMSW) {
		this.tierMSW = tierMSW;
	}

	public String getProGolfYn() {
		return proGolfYn;
	}

	public void setProGolfYn(String proGolfYn) {
		this.proGolfYn = proGolfYn;
	}

	public String getDrcYn() {
		return drcYn;
	}

	public void setDrcYn(String drcYn) {
		this.drcYn = drcYn;
	}

	public String getTierDSTNm() {
		return tierDSTNm;
	}

	public void setTierDSTNm(String tierDSTNm) {
		this.tierDSTNm = tierDSTNm;
	}

	public String getTierUMBNm() {
		return tierUMBNm;
	}

	public void setTierUMBNm(String tierUMBNm) {
		this.tierUMBNm = tierUMBNm;
	}

	public String getTierLCSNm() {
		return tierLCSNm;
	}

	public void setTierLCSNm(String tierLCSNm) {
		this.tierLCSNm = tierLCSNm;
	}

	public String getTierDSGNm() {
		return tierDSGNm;
	}

	public void setTierDSGNm(String tierDSGNm) {
		this.tierDSGNm = tierDSGNm;
	}

	public String getTierLCGNm() {
		return tierLCGNm;
	}

	public void setTierLCGNm(String tierLCGNm) {
		this.tierLCGNm = tierLCGNm;
	}

	public String getTierMSWNm() {
		return tierMSWNm;
	}

	public void setTierMSWNm(String tierMSWNm) {
		this.tierMSWNm = tierMSWNm;
	}
}
