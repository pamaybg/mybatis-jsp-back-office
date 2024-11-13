package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


/**
 * @name : infavor.voc.requestConsultation.dto.response.VOCRequestConsultationResponseDTO
 * @date : 2017. 10. 13.
 * @author : "dg.ryu"
 * @description : 상담요청 Response DTO
 */
@PersonalData
public class VocRequestConsultationResDto extends GridPagingItemResDto {
	
	private String ridMbr;
	private String rid;                     //TBL_PKEY자동채번
	private String accntId;                 //어카운트ID[[어카운트ID]]
	private String ridCust;                  //회원 RID[[회원 RID]]
	private String ridCrmuser;              //CRM사용자 RID[[CRM사용자 RID]]
	private String ridChnl;                 //채널 RID[[채널 RID]]
	private String srNo;                    //SR번호[[SR번호]]
	private String srTrtStatus;             //SR 처리상태[[SR 처리상태]]
	private String srTrtStatusNm;
	private String cnslgTypeCdL;            //상담유형코드L[[상담유형코드L]]
	private String cnslgTypeCdM;            //상담유형코드M[[상담유형코드M]]
	private String cnslgTypeCdS;            //상담유형코드S[[상담유형코드S]]
	private String cnslgTitle;              //상담제목[[상담제목]]
	private String cnslgSbst;               //상담내용[[상담내용]]
	private String cmpltDt;                 //완료일시[[완료일시]]
	private String rcpMeth;                 //접수방법[[접수방법]]
	private String rcpDt;                   //접수일시[[접수일시]]
	private String trcDt;                   //이관일시[[이관일시]]
	private String memWkplcTel;             //회원 직장전화[[회원 직장전화]]
	private String memOwnhomeTel;           //회원 자택전화[[회원 자택전화]]
	private String gen;                     //세대[[세대]]
	private String memNo;                   //회원번호[[회원번호]]
	private String callId;                  //통화ID[[통화ID]]
	@Decrypted(masked="tel")
	private String memPtblNo;               //회원 휴대폰번호[[회원 휴대폰번호]]
	@Decrypted(masked="custNm")
	private String memNm;                   //회원명[[회원명]]
	@Decrypted(masked="tel")
	private String cntcDesk;                //연락처[[연락처]]
	@Decrypted(masked="email")
	private String emailAddr;               //이메일주소[[이메일주소]]
	private String cprtVndrHhoConvFail;     //제휴업체 호전환 실패[[제휴업체 호전환 실패]]
	private String cprtVndrCd;              //제휴업체 코드[[제휴업체 코드]]
	private String ligCnslgYn;              //LIG 상담여부[[LIG 상담여부]]
	private String endDt;                   //종료일시[[종료일시]]
	private String crmuserId;
	private String crmuserName;
	private String chnlNo;
	private String chnlNm;
	private String createBy;
	
	@Decrypted(masked="none")
	private String unMaskMemNm;
	@Decrypted(masked="none")
	private String unMaskCntcDesc;
	@Decrypted(masked="none")
	private String unMaskEmailAddr;
	@Decrypted(masked="none")
	private String unMaskMemPtblNo;
	
	
	
	
	public String getUnMaskMemPtblNo() {
		return unMaskMemPtblNo;
	}

	public void setUnMaskMemPtblNo(String unMaskMemPtblNo) {
		this.unMaskMemPtblNo = unMaskMemPtblNo;
	}

	public String getUnMaskMemNm() {
		return unMaskMemNm;
	}

	public void setUnMaskMemNm(String unMaskMemNm) {
		this.unMaskMemNm = unMaskMemNm;
	}

	public String getUnMaskCntcDesc() {
		return unMaskCntcDesc;
	}

	public void setUnMaskCntcDesc(String unMaskCntcDesc) {
		this.unMaskCntcDesc = unMaskCntcDesc;
	}

	public String getUnMaskEmailAddr() {
		return unMaskEmailAddr;
	}

	public void setUnMaskEmailAddr(String unMaskEmailAddr) {
		this.unMaskEmailAddr = unMaskEmailAddr;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
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

	public String getSrNo() {
		return srNo;
	}

	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}

	public String getSrTrtStatus() {
		return srTrtStatus;
	}

	public void setSrTrtStatus(String srTrtStatus) {
		this.srTrtStatus = srTrtStatus;
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

	public String getCmpltDt() {
		return cmpltDt;
	}

	public void setCmpltDt(String cmpltDt) {
		this.cmpltDt = cmpltDt;
	}

	public String getRcpMeth() {
		return rcpMeth;
	}

	public void setRcpMeth(String rcpMeth) {
		this.rcpMeth = rcpMeth;
	}

	public String getRcpDt() {
		return rcpDt;
	}

	public void setRcpDt(String rcpDt) {
		this.rcpDt = rcpDt;
	}

	public String getTrcDt() {
		return trcDt;
	}

	public void setTrcDt(String trcDt) {
		this.trcDt = trcDt;
	}

	public String getMemWkplcTel() {
		return memWkplcTel;
	}

	public void setMemWkplcTel(String memWkplcTel) {
		this.memWkplcTel = memWkplcTel;
	}

	public String getMemOwnhomeTel() {
		return memOwnhomeTel;
	}

	public void setMemOwnhomeTel(String memOwnhomeTel) {
		this.memOwnhomeTel = memOwnhomeTel;
	}

	public String getGen() {
		return gen;
	}

	public void setGen(String gen) {
		this.gen = gen;
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

	public String getLigCnslgYn() {
		return ligCnslgYn;
	}

	public void setLigCnslgYn(String ligCnslgYn) {
		this.ligCnslgYn = ligCnslgYn;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getSrTrtStatusNm() {
		return srTrtStatusNm;
	}

	public void setSrTrtStatusNm(String srTrtStatusNm) {
		this.srTrtStatusNm = srTrtStatusNm;
	}

	public String getCrmuserName() {
		return crmuserName;
	}

	public void setCrmuserName(String crmuserName) {
		this.crmuserName = crmuserName;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getCrmuserId() {
		return crmuserId;
	}

	public void setCrmuserId(String crmuserId) {
		this.crmuserId = crmuserId;
	}

	public String getRidCust() {
		return ridCust;
	}

	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	
}