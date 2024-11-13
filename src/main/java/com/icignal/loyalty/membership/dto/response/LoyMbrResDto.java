/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
  * @fileName : LoyMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 응답 DTO
  */
@PersonalData
@CommCode
public class LoyMbrResDto  extends GridPagingItemResDto {
	
	private String pwdAmdDd;

    /** RID */
    private String rid;

    /** RID_고객 */
    private String ridCust;

    /** 고객명 */ 
    private String mbrNm;

    /** 고객명 */
    @Decrypted(masked = "custNm")
    private String custNm;

    /** 회원 구분 */
    private String memDiv;

    /** 웹ID */
    @Decrypted(masked = "email")
    private String wbMemId;

    /** 회원 등급 코드 */
    private String tierCd;

    /** 고객유형코드 */    
    private String custTypeCd;
    
    /** 고객유형 값 */    
    @MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
    private String custTypeNm;

    /** 식별 유형 코드 */  
    private String identiTypeCd;
    
    /** 식별 유형 값*/
    @MarkName(groupCode="LOY_IDENTI_TYPE_CD", codeField="identiTypeCd")
    private String identiTypeNm;
    
    /** 식별값 */
    //@Decrypted(masked = "none")
    private String identiVal;

    /** 회원 번호 */
    private String mbrNo;
    
    
    /** 생년월일 */
    private String birthDt;

    /** 회원 상태 코드 */
    private String mbrStatCd;

    /** 회원 상태 명 */
    private String mbrStatNm;

    /** 회원 유형 코드 */
    private String mbrTypeCd;

    /** 회원 유형명 */
    private String mbrTypeNm;

    /** 가입 일자 */
    private String joinDate;

    /** RID_등급 현재 */
    private String ridTierCur;

    /** 현재 등급명 */
    private String tierNm;

    /** 현재 등급 선정 일자 */
    private String curTierSelDate;

    /** RID_채널_가입 */
    private String ridChnlJoin;

    /** 가입채널명 */
    private String chnlJoinNm;

    /** RID_채널_주거래 */
    private String ridChnlPrimary;

    /** 주거래채널명 */
    private String chnlPrimaryNm;

    /** RID_PGM */
    private String ridPgm;

    /** PGM명 */
    private String pgmNm;

    /** 휴대폰 번호 */
    @Decrypted(masked = "tel")
    private String hhpNo;
    
    /** 휴대폰 번호(신규) */
    @Decrypted(masked = "tel")
    private String hhp;

    /** 집전화 번호 */
    @Decrypted(masked = "tel")
    private String homeTelNo;

    /** 사무실 전화 번호 */
    @Decrypted(masked = "tel")
    private String offTelNo;

    /** 이메일 주소 */
    @Decrypted(masked = "email")
    private String emailAddr;

    /** 이메일 주소(신규) */
    @Decrypted(masked = "email")
    private String email;

    /** 단체고객사 직원 이름 */
    @Decrypted(masked = "custNm")
    private String grpCustEmpName;

    /** 주소1_우편번호 */    
    private String addr1Zip;

    /** 주소1_기본 */
    private String addr1Dflt;

    /** 주소1_상세 */
    @Decrypted(masked = "none")
    private String addr1Dtl;

    /** 주소2_우편번호 */
    private String addr2Zip;

    /** 주소2_기본 */
    @Decrypted(masked = "none")
    private String addr2Dflt;

    /** 주소2_상세 */
    @Decrypted(masked = "none")
    private String addr2Dtl;

    /** 개인정보수집동의 */
    private String mktAgrePrvInfo;

    /** 마케팅 활용 동의 */
    private String mktAgreUse;

    /** 제3자 정보제공 동의 */
    private String mktAgreThirdSnd;

    /** 문자메시지 수신 동의 */
    private String chnlAgreSms;

    /** 이메일 수신동의 */
    private String chnlAgreEmail;

    /** TM 수신동의 */
    private String chnlAgreTel;

    /** DM 수신동의 */
    private String chnlAgreDm;

    /** 앱푸시메시지 수신 동의 */
    private String chnlAgrePush;

    /** 위치정보 사업 동의 */
    private String mktAgreLbsBiz;

    /** 위치정보 서비스활용 동의 */
    private String mktAgreLbsSvc;

    /** 탈회 일자 */
    private String leavDate;

    /** 앱 토큰 아이디 */
    private String tokenId;

    /** 가용포인트 */
    private String availablePoints;

    /** CREATE_DATE */
    private String createDate;

    /** CREATE_BY */
    private String createBy;

    /** 수정일시 */
    private String modifyDate;

    /** MODIFY_BY */
    private String modifyBy;

    /** 비밀번호 존재여부 */
    private Integer isEmptyPntUsePw;

    /** 본인생일구분 */
    private String lunarGbnCd;

    /** 주소변경 일시 */
    private String ownhomeAdrChgDt;

    /** 도로명주소 */
    private String addr1Delt;

    /** 도로명주소 상세 */
    private String addrdtl;


    /** 가용포인트 */
    private String avlPoint;

    /** 선물받은포인트 */
    private String giftPoint;

    /** 선물가능포인트 */
    private String giftAvlPoint;

    /** 소멸예정월 */
    private String extncPamMonth;

    /** 소멸예정포인트 */
    private String extncPamPoint;

    /** 웹회원 */
    private String wbMemYn;


    /** 가입채널 */
    private String sbscChnlCdMarkName;

    private String cipherKey;

    private String pgmNo;

    private String chnlNo;

    private String ridChnlMbrRel;

    private String birth;

    private String webId;

    private String searchYM;

    private String searchDef;

    private String dealAmount;

    private String limitAmt;



    /*14세미만여부*/
    private String underForteenYn;
    
    /*휴면회원여부*/
    private String mbrLockYn;

    private String realnmCertiDate;
    
    /*(신규 등록) - 노형래*/
    private String custNo;
    private String birthday;
    private String tierDt;
    private String sbscDate;
    private String sbscCoursCd;
    private String ridSbscChnl;
    private String pntPwd;
    private String pntAcrlYn;
    private String pntRdmYn;
    private String pntGiftYn;
    private String instcYn;
    
    @Decrypted(masked = "none")
    private String unMaskCustNm;
    @Decrypted(masked = "none")
    private String unMaskHhp;
    @Decrypted(masked = "none")
    private String unMaskEmail;
    
    private String encCustNm;  //암호화된 이름
    private String encHhp;	   //암호화된 휴대폰번호
    private String chgTbl;
    private String chgCol;
    private String chgAData;
    private String chgBData;
    
    
    public String getChgAData() {
		return chgAData;
	}

	public void setChgAData(String chgAData) {
		this.chgAData = chgAData;
	}

	public String getChgBData() {
		return chgBData;
	}

	public void setChgBData(String chgBData) {
		this.chgBData = chgBData;
	}

	public String getChgTbl() {
		return chgTbl;
	}

	public void setChgTbl(String chgTbl) {
		this.chgTbl = chgTbl;
	}

	public String getChgCol() {
		return chgCol;
	}

	public void setChgCol(String chgCol) {
		this.chgCol = chgCol;
	}


	public String getEncCustNm() {
		return encCustNm;
	}

	public void setEncCustNm(String encCustNm) {
		this.encCustNm = encCustNm;
	}

	public String getEncHhp() {
		return encHhp;
	}

	public void setEncHhp(String encHhp) {
		this.encHhp = encHhp;
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

	public String getUnMaskEmail() {
		return unMaskEmail;
	}

	public void setUnMaskEmail(String unMaskEmail) {
		this.unMaskEmail = unMaskEmail;
	}



	//마지막로그인 일자
    private String lastLoginDate;
    
    public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getRidChnlMbrRel() {
		return ridChnlMbrRel;
	}

	public void setRidChnlMbrRel(String ridChnlMbrRel) {
		this.ridChnlMbrRel = ridChnlMbrRel;
	}

	

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getWebId() {
		return webId;
	}

	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getSearchYM() {
		return searchYM;
	}

	public void setSearchYM(String searchYM) {
		this.searchYM = searchYM;
	}

	public String getSearchDef() {
		return searchDef;
	}

	public void setSearchDef(String searchDef) {
		this.searchDef = searchDef;
	}

	public String getDealAmount() {
		return dealAmount;
	}

	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}

	public String getLimitAmt() {
		return limitAmt;
	}

	public void setLimitAmt(String limitAmt) {
		this.limitAmt = limitAmt;
	}


	public String getGiftPoint() {
		return giftPoint;
	}

	public void setGiftPoint(String giftPoint) {
		this.giftPoint = giftPoint;
	}

	public String getGiftAvlPoint() {
		return giftAvlPoint;
	}

	public void setGiftAvlPoint(String giftAvlPoint) {
		this.giftAvlPoint = giftAvlPoint;
	}

	public String getExtncPamMonth() {
		return extncPamMonth;
	}

	public void setExtncPamMonth(String extncPamMonth) {
		this.extncPamMonth = extncPamMonth;
	}

	public String getExtncPamPoint() {
		return extncPamPoint;
	}

	public void setExtncPamPoint(String extncPamPoint) {
		this.extncPamPoint = extncPamPoint;
	}

	public String getWbMemYn() {
		return wbMemYn;
	}

	public void setWbMemYn(String wbMemYn) {
		this.wbMemYn = wbMemYn;
	}

	

	public String getSbscChnlCdMarkName() {
		return sbscChnlCdMarkName;
	}

	public void setSbscChnlCdMarkName(String sbscChnlCdMarkName) {
		this.sbscChnlCdMarkName = sbscChnlCdMarkName;
	}

	public String getSbscChnlCd() {
		return sbscChnlCd;
	}

	public void setSbscChnlCd(String sbscChnlCd) {
		this.sbscChnlCd = sbscChnlCd;
	}

	public String getSbscChnlDtlCdMarkName() {
		return sbscChnlDtlCdMarkName;
	}

	public void setSbscChnlDtlCdMarkName(String sbscChnlDtlCdMarkName) {
		this.sbscChnlDtlCdMarkName = sbscChnlDtlCdMarkName;
	}

	public String getSbscChnlDtlCd() {
		return sbscChnlDtlCd;
	}

	public void setSbscChnlDtlCd(String sbscChnlDtlCd) {
		this.sbscChnlDtlCd = sbscChnlDtlCd;
	}



	/** 가입채널 */
    private String sbscChnlCd;

    /** 가입채널 상세 */
    private String sbscChnlDtlCdMarkName;

    /** 가입채널 상세 */
    private String sbscChnlDtlCd;

  

    /**
     * @return the isEmptyPntUsePw
     */
	public Integer getIsEmptyPntUsePw() {
        return isEmptyPntUsePw;
    }

    /**
     * @param isEmptyPntUsePw the isEmptyPntUsePw to set
     */
    public void setIsEmptyPntUsePw(Integer isEmptyPntUsePw) {
        this.isEmptyPntUsePw = isEmptyPntUsePw;
    }

    /**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}

	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	 * @return the ridCust
	 */
	public String getRidCust() {
		return ridCust;
	}

	/**
	 * @param ridCust the ridCust to set
	 */
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}

	/**
	 * @return the ridPgm
	 */
	public String getRidPgm() {
		return ridPgm;
	}

	/**
	 * @param ridPgm the ridPgm to set
	 */
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	/**
	 * @return the mbrNo
	 */
	public String getMbrNo() {
		return mbrNo;
	}

	/**
	 * @param mbrNo the mbrNo to set
	 */
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	/**
	 * @return the ridChnlJoin
	 */
	public String getRidChnlJoin() {
		return ridChnlJoin;
	}

	/**
	 * @param ridChnlJoin the ridChnlJoin to set
	 */
	public void setRidChnlJoin(String ridChnlJoin) {
		this.ridChnlJoin = ridChnlJoin;
	}

	/**
	 * @return the ridChnlPrimary
	 */
	public String getRidChnlPrimary() {
		return ridChnlPrimary;
	}

	/**
	 * @param ridChnlPrimary the ridChnlPrimary to set
	 */
	public void setRidChnlPrimary(String ridChnlPrimary) {
		this.ridChnlPrimary = ridChnlPrimary;
	}

	/**
	 * @return the mbrTypeCd
	 */
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}

	/**
	 * @param mbrTypeCd the mbrTypeCd to set
	 */
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}

	/**
	 * @return the mbrStatCd
	 */
	public String getMbrStatCd() {
		return mbrStatCd;
	}

	/**
	 * @param mbrStatCd the mbrStatCd to set
	 */
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}

	/**
	 * @return the joinDate
	 */
	public String getJoinDate() {
		return joinDate;
	}

	/**
	 * @param joinDate the joinDate to set
	 */
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	/**
	 * @return the leavDate
	 */
	public String getLeavDate() {
		return leavDate;
	}

	/**
	 * @param leavDate the leavDate to set
	 */
	public void setLeavDate(String leavDate) {
		this.leavDate = leavDate;
	}

	/**
	 * @return the ridTierCur
	 */
	public String getRidTierCur() {
		return ridTierCur;
	}

	/**
	 * @param ridTierCur the ridTierCur to set
	 */
	public void setRidTierCur(String ridTierCur) {
		this.ridTierCur = ridTierCur;
	}

	/**
	 * @return the curTierSelDate
	 */
	public String getCurTierSelDate() {
		return curTierSelDate;
	}

	/**
	 * @param curTierSelDate the curTierSelDate to set
	 */
	public void setCurTierSelDate(String curTierSelDate) {
		this.curTierSelDate = curTierSelDate;
	}

	/**
	 * @return the mktAgrePrvInfo
	 */
	public String getMktAgrePrvInfo() {
		return mktAgrePrvInfo;
	}

	/**
	 * @param mktAgrePrvInfo the mktAgrePrvInfo to set
	 */
	public void setMktAgrePrvInfo(String mktAgrePrvInfo) {
		this.mktAgrePrvInfo = mktAgrePrvInfo;
	}

	/**
	 * @return the mktAgreUse
	 */
	public String getMktAgreUse() {
		return mktAgreUse;
	}

	/**
	 * @param mktAgreUse the mktAgreUse to set
	 */
	public void setMktAgreUse(String mktAgreUse) {
		this.mktAgreUse = mktAgreUse;
	}

	/**
	 * @return the mktAgreLbsBiz
	 */
	public String getMktAgreLbsBiz() {
		return mktAgreLbsBiz;
	}

	/**
	 * @param mktAgreLbsBiz the mktAgreLbsBiz to set
	 */
	public void setMktAgreLbsBiz(String mktAgreLbsBiz) {
		this.mktAgreLbsBiz = mktAgreLbsBiz;
	}

	/**
	 * @return the mktAgreLbsSvc
	 */
	public String getMktAgreLbsSvc() {
		return mktAgreLbsSvc;
	}

	/**
	 * @param mktAgreLbsSvc the mktAgreLbsSvc to set
	 */
	public void setMktAgreLbsSvc(String mktAgreLbsSvc) {
		this.mktAgreLbsSvc = mktAgreLbsSvc;
	}

	/**
	 * @return the chnlAgreSms
	 */
	public String getChnlAgreSms() {
		return chnlAgreSms;
	}

	/**
	 * @param chnlAgreSms the chnlAgreSms to set
	 */
	public void setChnlAgreSms(String chnlAgreSms) {
		this.chnlAgreSms = chnlAgreSms;
	}

	/**
	 * @return the chnlAgreTel
	 */
	public String getChnlAgreTel() {
		return chnlAgreTel;
	}

	/**
	 * @param chnlAgreTel the chnlAgreTel to set
	 */
	public void setChnlAgreTel(String chnlAgreTel) {
		this.chnlAgreTel = chnlAgreTel;
	}

	/**
	 * @return the chnlAgreDm
	 */
	public String getChnlAgreDm() {
		return chnlAgreDm;
	}

	/**
	 * @param chnlAgreDm the chnlAgreDm to set
	 */
	public void setChnlAgreDm(String chnlAgreDm) {
		this.chnlAgreDm = chnlAgreDm;
	}

	/**
	 * @return the chnlAgrePush
	 */
	public String getChnlAgrePush() {
		return chnlAgrePush;
	}

	/**
	 * @param chnlAgrePush the chnlAgrePush to set
	 */
	public void setChnlAgrePush(String chnlAgrePush) {
		this.chnlAgrePush = chnlAgrePush;
	}

	/**
	 * @return the chnlAgreEmail
	 */
	public String getChnlAgreEmail() {
		return chnlAgreEmail;
	}

	/**
	 * @param chnlAgreEmail the chnlAgreEmail to set
	 */
	public void setChnlAgreEmail(String chnlAgreEmail) {
		this.chnlAgreEmail = chnlAgreEmail;
	}

	/**
	 * @return the addr1Zip
	 */
	public String getAddr1Zip() {
		return addr1Zip;
	}

	/**
	 * @param addr1Zip the addr1Zip to set
	 */
	public void setAddr1Zip(String addr1Zip) {
		this.addr1Zip = addr1Zip;
	}

	/**
	 * @return the addr1Dflt
	 */
	public String getAddr1Dflt() {
		return addr1Dflt;
	}

	/**
	 * @param addr1Dflt the addr1Dflt to set
	 */
	public void setAddr1Dflt(String addr1Dflt) {
		this.addr1Dflt = addr1Dflt;
	}

	/**
	 * @return the addr1Dtl
	 */
	public String getAddr1Dtl() {
		return addr1Dtl;
	}

	/**
	 * @param addr1Dtl the addr1Dtl to set
	 */
	public void setAddr1Dtl(String addr1Dtl) {
		this.addr1Dtl = addr1Dtl;
	}

	/**
	 * @return the addr2Zip
	 */
	public String getAddr2Zip() {
		return addr2Zip;
	}

	/**
	 * @param addr2Zip the addr2Zip to set
	 */
	public void setAddr2Zip(String addr2Zip) {
		this.addr2Zip = addr2Zip;
	}

	/**
	 * @return the addr2Dflt
	 */
	public String getAddr2Dflt() {
		return addr2Dflt;
	}

	/**
	 * @param addr2Dflt the addr2Dflt to set
	 */
	public void setAddr2Dflt(String addr2Dflt) {
		this.addr2Dflt = addr2Dflt;
	}

	/**
	 * @return the addr2Dtl
	 */
	public String getAddr2Dtl() {
		return addr2Dtl;
	}

	/**
	 * @param addr2Dtl the addr2Dtl to set
	 */
	public void setAddr2Dtl(String addr2Dtl) {
		this.addr2Dtl = addr2Dtl;
	}

	/**
	 * @return the hhpNo
	 */
	public String getHhpNo() {
		return hhpNo;
	}

	/**
	 * @param hhpNo the hhpNo to set
	 */
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}

	/**
	 * @return the homeTelNo
	 */
	public String getHomeTelNo() {
		return homeTelNo;
	}

	/**
	 * @param homeTelNo the homeTelNo to set
	 */
	public void setHomeTelNo(String homeTelNo) {
		this.homeTelNo = homeTelNo;
	}

	/**
	 * @return the offTelNo
	 */
	public String getOffTelNo() {
		return offTelNo;
	}

	/**
	 * @param offTelNo the offTelNo to set
	 */
	public void setOffTelNo(String offTelNo) {
		this.offTelNo = offTelNo;
	}

	/**
	 * @return the emailAddr
	 */
	public String getEmailAddr() {
		return emailAddr;
	}

	/**
	 * @param emailAddr the emailAddr to set
	 */
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	/**
	 * @return the tokenId
	 */
	public String getTokenId() {
		return tokenId;
	}

	/**
	 * @param tokenId the tokenId to set
	 */
	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}

	/**
	 * @return the grpCustEmpName
	 */
	public String getGrpCustEmpName() {
		return grpCustEmpName;
	}

	/**
	 * @param grpCustEmpName the grpCustEmpName to set
	 */
	public void setGrpCustEmpName(String grpCustEmpName) {
		this.grpCustEmpName = grpCustEmpName;
	}

	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}

	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	/**
	 * @return the createBy
	 */
	public String getCreateBy() {
		return createBy;
	}

	/**
	 * @param createBy the createBy to set
	 */
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	/**
	 * @return the modifyDate
	 */
	public String getModifyDate() {
		return modifyDate;
	}

	/**
	 * @param modifyDate the modifyDate to set
	 */
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	/**
	 * @return the modifyBy
	 */
	public String getModifyBy() {
		return modifyBy;
	}

	/**
	 * @param modifyBy the modifyBy to set
	 */
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	/**
	 * @return the mbrNm
	 */
	public String getMbrNm() {
		return mbrNm;
	}

	/**
	 * @param mbrNm the mbrNm to set
	 */
	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}

	/**
	 * @return the mbrStatNm
	 */
	public String getMbrStatNm() {
		return mbrStatNm;
	}

	/**
	 * @param mbrStatNm the mbrStatNm to set
	 */
	public void setMbrStatNm(String mbrStatNm) {
		this.mbrStatNm = mbrStatNm;
	}

	/**
	 * @return the pgmNm
	 */
	public String getPgmNm() {
		return pgmNm;
	}

	/**
	 * @param pgmNm the pgmNm to set
	 */
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	/**
	 * @return the mbrTypeNm
	 */
	public String getMbrTypeNm() {
		return mbrTypeNm;
	}

	/**
	 * @param mbrTypeNm the mbrTypeNm to set
	 */
	public void setMbrTypeNm(String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}

	/**
	 * @return the chnlJoinNm
	 */
	public String getChnlJoinNm() {
		return chnlJoinNm;
	}

	/**
	 * @param chnlJoinNm the chnlJoinNm to set
	 */
	public void setChnlJoinNm(String chnlJoinNm) {
		this.chnlJoinNm = chnlJoinNm;
	}

	/**
	 * @return the tierNm
	 */
	public String getTierNm() {
		return tierNm;
	}

	/**
	 * @param tierNm the tierNm to set
	 */
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	/**
	 * @return the identiTypeCd
	 */
	public String getIdentiTypeCd() {
		return identiTypeCd;
	}

	/**
	 * @param identiTypeCd the identiTypeCd to set
	 */
	public void setIdentiTypeCd(String identiTypeCd) {
		this.identiTypeCd = identiTypeCd;
	}



	/**
	 * @return the identiVal
	 */
	public String getIdentiVal() {
		return identiVal;
	}

	/**
	 * @param identiVal the identiVal to set
	 */
	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}

	/**
	 * @return the custTypeCd
	 */
	public String getCustTypeCd() {
		return custTypeCd;
	}

	/**
	 * @param custTypeCd the custTypeCd to set
	 */
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}

	/**
	 * @return the chnlPrimaryNm
	 */
	public String getChnlPrimaryNm() {
		return chnlPrimaryNm;
	}

	/**
	 * @param chnlPrimaryNm the chnlPrimaryNm to set
	 */
	public void setChnlPrimaryNm(String chnlPrimaryNm) {
		this.chnlPrimaryNm = chnlPrimaryNm;
	}

	/**
	 * @return the mktAgreThirdSnd
	 */
	public String getMktAgreThirdSnd() {
		return mktAgreThirdSnd;
	}

	/**
	 * @param mktAgreThirdSnd the mktAgreThirdSnd to set
	 */
	public void setMktAgreThirdSnd(String mktAgreThirdSnd) {
		this.mktAgreThirdSnd = mktAgreThirdSnd;
	}

	/**
	 * @return the availablePoints
	 */
	public String getAvailablePoints() {
		return availablePoints;
	}

	/**
	 * @param availablePoints the availablePoints to set
	 */
	public void setAvailablePoints(String availablePoints) {
		this.availablePoints = availablePoints;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getMemDiv() {
		return memDiv;
	}

	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}

	public String getWbMemId() {
		return wbMemId;
	}

	public void setWbMemId(String wbMemId) {
		this.wbMemId = wbMemId;
	}

	public String getTierCd() {
		return tierCd;
	}

	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}

	public String getBirthDt() {
		return birthDt;
	}

	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}

	public String getLunarGbnCd() {
		return lunarGbnCd;
	}

	public void setLunarGbnCd(String lunarGbnCd) {
		this.lunarGbnCd = lunarGbnCd;
	}

	public String getOwnhomeAdrChgDt() {
		return ownhomeAdrChgDt;
	}

	public void setOwnhomeAdrChgDt(String ownhomeAdrChgDt) {
		this.ownhomeAdrChgDt = ownhomeAdrChgDt;
	}

	public String getAddr1Delt() {
		return addr1Delt;
	}

	public void setAddr1Delt(String addr1Delt) {
		this.addr1Delt = addr1Delt;
	}

	public String getAddrdtl() {
		return addrdtl;
	}

	public void setAddrdtl(String addrdtl) {
		this.addrdtl = addrdtl;
	}


	public String getAvlPoint() {
		return avlPoint;
	}

	public void setAvlPoint(String avlPoint) {
		this.avlPoint = avlPoint;
	}

	public String getPwdAmdDd() {
		return pwdAmdDd;
	}

	public void setPwdAmdDd(String pwdAmdDd) {
		this.pwdAmdDd = pwdAmdDd;
	}

	public String getUnderForteenYn() {
		return underForteenYn;
	}

	public void setUnderForteenYn(String underForteenYn) {
		this.underForteenYn = underForteenYn;
	}



	public String getMbrLockYn() {
		return mbrLockYn;
	}

	public void setMbrLockYn(String mbrLockYn) {
		this.mbrLockYn = mbrLockYn;
	}

	public String getRealnmCertiDate() {
		return realnmCertiDate;
	}

	public void setRealnmCertiDate(String realnmCertiDate) {
		this.realnmCertiDate = realnmCertiDate;
	}

	public String getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	/**
	 * @return the identiTypeNm
	 */
	public String getIdentiTypeNm() {
		return identiTypeNm;
	}

	/**
	 * @param identiTypeNm the identiTypeNm to set
	 */
	public void setIdentiTypeNm(String identiTypeNm) {
		this.identiTypeNm = identiTypeNm;
	}

	/**
	 * @return the custTypeNm
	 */
	public String getCustTypeNm() {
		return custTypeNm;
	}

	/**
	 * @param custTypeNm the custTypeNm to set
	 */
	public void setCustTypeNm(String custTypeNm) {
		this.custTypeNm = custTypeNm;
	}

	public String getHhp() {
		return hhp;
	}

	public void setHhp(String hhp) {
		this.hhp = hhp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getTierDt() {
		return tierDt;
	}

	public void setTierDt(String tierDt) {
		this.tierDt = tierDt;
	}

	public String getSbscDate() {
		return sbscDate;
	}

	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}

	public String getSbscCoursCd() {
		return sbscCoursCd;
	}

	public void setSbscCoursCd(String sbscCoursCd) {
		this.sbscCoursCd = sbscCoursCd;
	}

	public String getRidSbscChnl() {
		return ridSbscChnl;
	}

	public void setRidSbscChnl(String ridSbscChnl) {
		this.ridSbscChnl = ridSbscChnl;
	}

	public String getPntPwd() {
		return pntPwd;
	}

	public void setPntPwd(String pntPwd) {
		this.pntPwd = pntPwd;
	}

	public String getPntAcrlYn() {
		return pntAcrlYn;
	}

	public void setPntAcrlYn(String pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}

	public String getPntRdmYn() {
		return pntRdmYn;
	}

	public void setPntRdmYn(String pntRdmYn) {
		this.pntRdmYn = pntRdmYn;
	}

	public String getPntGiftYn() {
		return pntGiftYn;
	}

	public void setPntGiftYn(String pntGiftYn) {
		this.pntGiftYn = pntGiftYn;
	}

	public String getInstcYn() {
		return instcYn;
	}

	public void setInstcYn(String instcYn) {
		this.instcYn = instcYn;
	}




}
