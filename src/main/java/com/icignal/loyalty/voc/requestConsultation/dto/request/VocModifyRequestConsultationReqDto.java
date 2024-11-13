package com.icignal.loyalty.voc.requestConsultation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


@PersonalData
public class VocModifyRequestConsultationReqDto extends MKTBaseReqDto {
	
	private String empId;
	
	private String ridCust;
	private String ridCrmuser;
	private String srNo;
	private String cnslgTypeCdL;
	private String cnslgTypeCdM;
	private String cnslgTypeCdS;
	private String cnslgTitle;
	private String cnslgSbst;
	private String rcpMeth;
	private String callId;
	@Encrypted
	private String memPtblNo;
	private String memNo;
	@Encrypted
	private String memNm;
	@Encrypted
	private String cntcDesk;
	@Encrypted
	private String emailAddr;
	private String cprtVndrHhoConvFail;
	private String cprtVndrCd;
	private String rid;
	private String ridChnl;
	
	private String srTrtStatus;
	
	private String cipherKey;
	
	private List<String> ridList;
	private String crmName;
	private String updateCrmName;
	private String vocReqRid;
	private String ridMbr;

	
	public VocModifyRequestConsultationReqDto(){
		/*try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtility.error(e);
		}*/
	}
	



	public String getRidMbr() {
		return ridMbr;
	}




	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}




	public String getVocReqRid() {
		return vocReqRid;
	}


	public void setVocReqRid(String vocReqRid) {
		this.vocReqRid = vocReqRid;
	}


	public String getUpdateCrmName() {
		return updateCrmName;
	}


	public void setUpdateCrmName(String updateCrmName) {
		this.updateCrmName = updateCrmName;
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
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getSrTrtStatus() {
		return srTrtStatus;
	}
	public void setSrTrtStatus(String srTrtStatus) {
		this.srTrtStatus = srTrtStatus;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


	public List<String> getRidList() {
		return ridList;
	}


	public void setRidList(List<String> ridList) {
		this.ridList = ridList;
	}


	public String getRidCust() {
		return ridCust;
	}


	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
}
