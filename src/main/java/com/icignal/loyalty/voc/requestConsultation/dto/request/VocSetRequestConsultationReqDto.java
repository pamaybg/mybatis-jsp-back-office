package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


@PersonalData
public class VocSetRequestConsultationReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String userId;
	
	private String ridCust;
	private String ridCrmuser;
	private String ridChnl;
	private String cnslgTypeCdL;
	private String cnslgTypeCdM;
	private String cnslgTypeCdS;
	private String cnslgTitle;
	private String cnslgSbst;
	private String rcpMeth;
	private String memNo;
	private String callId;
	@Encrypted
	private String memPtblNo;
	@Encrypted
	private String memNm;
	@Encrypted
	private String cntcDesk;
	@Encrypted
	private String emailAddr;
	private String cprtVndrHhoConvFail;
	private String cprtVndrCd;
	
	private String cipherKey;

	private String rid;
	private String crmName;
	private String groupCode;
	private String ridMbr;
	
	
	
	public String getRidMbr() {
		return ridMbr;
	}


	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}


	public String getGroupCode() {
		return groupCode;
	}


	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}


	public VocSetRequestConsultationReqDto(){
		/*try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtility.error(e);
		}*/
	}
	
	
	public String getCrmName() {
		return crmName;
	}
	

	public void setCrmName(String crmName) {
		this.crmName = crmName;
	}


	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRidCrmuser() {
		return ridCrmuser;
	}
	public void setRidCrmuser(String ridCrmuser) {
		this.ridCrmuser = ridCrmuser;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getCnslgTypeCdL() {
		return cnslgTypeCdL;
	}
	public void setCnslgTypeCdL(String cnslgTypeCdL) {
		this.cnslgTypeCdL = cnslgTypeCdL;
	}
	public String getCnslgTypeCdM() {
		return cnslgTypeCdM;
	}
	public void setCnslgTypeCdM(String cnslgTypeCdM) {
		this.cnslgTypeCdM = cnslgTypeCdM;
	}
	public String getCnslgTypeCdS() {
		return cnslgTypeCdS;
	}
	public void setCnslgTypeCdS(String cnslgTypeCdS) {
		this.cnslgTypeCdS = cnslgTypeCdS;
	}
	public String getCnslgTitle() {
		return cnslgTitle;
	}
	public void setCnslgTitle(String cnslgTitle) {
		this.cnslgTitle = cnslgTitle;
	}
	public String getCnslgSbst() {
		return cnslgSbst;
	}
	public void setCnslgSbst(String cnslgSbst) {
		this.cnslgSbst = cnslgSbst;
	}
	public String getRcpMeth() {
		return rcpMeth;
	}
	public void setRcpMeth(String rcpMeth) {
		this.rcpMeth = rcpMeth;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getCallId() {
		return callId;
	}
	public void setCallId(String callId) {
		this.callId = callId;
	}
	public String getMemPtblNo() {
		return memPtblNo;
	}
	public void setMemPtblNo(String memPtblNo) {
		this.memPtblNo = memPtblNo;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getCntcDesk() {
		return cntcDesk;
	}
	public void setCntcDesk(String cntcDesk) {
		this.cntcDesk = cntcDesk;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getCprtVndrHhoConvFail() {
		return cprtVndrHhoConvFail;
	}
	public void setCprtVndrHhoConvFail(String cprtVndrHhoConvFail) {
		this.cprtVndrHhoConvFail = cprtVndrHhoConvFail;
	}
	public String getCprtVndrCd() {
		return cprtVndrCd;
	}
	public void setCprtVndrCd(String cprtVndrCd) {
		this.cprtVndrCd = cprtVndrCd;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


	public String getRid() {
		return rid;
	}


	public void setRid(String rid) {
		this.rid = rid;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getRidCust() {
		return ridCust;
	}


	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	
}
