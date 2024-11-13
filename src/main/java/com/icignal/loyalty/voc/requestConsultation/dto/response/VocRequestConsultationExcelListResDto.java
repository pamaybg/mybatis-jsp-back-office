/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: VocRequestConsultationExcelListResDto.java
 * 2. Package	: com.icignal.loyalty.voc.requestConsultation.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 8. 오후 6:10:37
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 8.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: VocRequestConsultationExcelListResDto
 * 2. 파일명	: VocRequestConsultationExcelListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.voc.requestConsultation.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 8.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
public class VocRequestConsultationExcelListResDto extends GridPagingItemResDto{
	private String rid;                     //TBL_PKEY자동채번
	private String accntId;                 //어카운트ID[[어카운트ID]]
	private String ridCust;                  //회원 RID[[회원 RID]]
	private String ridCrmuser;              //CRM사용자 RID[[CRM사용자 RID]]
	private String ridChnl;                 //채널 RID[[채널 RID]]
	private String srNo;                    //SR번호[[SR번호]]
	private String srTrtStatus;             //SR 처리상태[[SR 처리상태]]
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
	private String cnslgTypeCdLNm;
	private String cnslgTypeCdMNm;
	private String cnslgTypeCdSNm;
	private String srTrtStatusNm;
	@Decrypted(masked="none")
	private String writer; 					// 담당자[[담당자]]
	private String mbrIntCode;
	private String intMbrNo;
	
	
	public String getIntMbrNo() {
		return intMbrNo;
	}
	public void setIntMbrNo(String intMbrNo) {
		this.intMbrNo = intMbrNo;
	}
	public String getMbrIntCode() {
		return mbrIntCode;
	}
	public void setMbrIntCode(String mbrIntCode) {
		this.mbrIntCode = mbrIntCode;
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
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
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
	public String getCnslgTypeCdLNm() {
		return cnslgTypeCdLNm;
	}
	public void setCnslgTypeCdLNm(String cnslgTypeCdLNm) {
		this.cnslgTypeCdLNm = cnslgTypeCdLNm;
	}
	public String getCnslgTypeCdMNm() {
		return cnslgTypeCdMNm;
	}
	public void setCnslgTypeCdMNm(String cnslgTypeCdMNm) {
		this.cnslgTypeCdMNm = cnslgTypeCdMNm;
	}
	public String getCnslgTypeCdSNm() {
		return cnslgTypeCdSNm;
	}
	public void setCnslgTypeCdSNm(String cnslgTypeCdSNm) {
		this.cnslgTypeCdSNm = cnslgTypeCdSNm;
	}
	public String getSrTrtStatusNm() {
		return srTrtStatusNm;
	}
	public void setSrTrtStatusNm(String srTrtStatusNm) {
		this.srTrtStatusNm = srTrtStatusNm;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	
}
