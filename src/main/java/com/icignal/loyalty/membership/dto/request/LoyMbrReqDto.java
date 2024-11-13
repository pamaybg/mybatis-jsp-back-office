/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrReqDto
 * 2. 파일명	: LoyMbrReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@PersonalData
public class LoyMbrReqDto  extends CommonDataAuthReqDto {
	
	  @Override
	  public String toString() {
	  	   return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
	     }
	  	

	/** RID */
    private String rid;
    private String srcType;
    private String srcTypeNm;

	private String pgmRid;

    /** RID_고객 */
    private String ridCust;

    /** 고객유형코드 */
    private String custTypeCd;

    /** 식별값 유형 */
    private String identiTypeCd;

    /** 식별값 */
    private String identiVal;

    /** 회원 번호 */
    private String mbrNo;
    
    /** 회원 번호 */
    private String ecommMbrNo;
    
    /** 회원 번호 */
    private String wbMemId;

    /** 생년월일 */
    private String birthDt;

    /** 회원 상태 코드 */
    private String mbrStatCd;

    /** 회원 유형 코드 */
    private String mbrTypeCd;

    /** 가입 일자 */
    private String joinDate;

    /** RID_등급 현재 */
    private String ridTierCur;

    /** 현재 등급 선정 일자 */
    private String curTierSelDate;

    /** RID_채널_가입 */
    private String ridChnlJoin;

    /** RID_채널_주거래 */
    private String ridChnlPrimary;

    /** RID_PGM */
    private String ridPgm;

    /** 휴대폰 번호 */
    private String hhpNo;

    /** 집전화 번호 */
    private String homeTelNo;

    /** 사무실 전화 번호 */
    private String offTelNo;

    /** 이메일 주소 */
    private String emailAddr;

    /** 단체고객사 직원 이름 */
    private String grpCustEmpName;

    /** 주소1_우편번호 */
    private String addr1Zip;

    /** 주소1_기본 */
    private String addr1Dflt;

    /** 주소1_상세 */
    private String addr1Dtl;

    /** 주소2_우편번호 */
    private String addr2Zip;

    /** 주소2_기본 */
    private String addr2Dflt;

    /** 주소2_상세 */
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

    private String cipherKey;

    private String pgmNo;

    private String chnlNo;

    private String custNm;
    
    private String custNo;

    private String ridChnlMbrRel;

    private String bonusCardNo;

    private String birth;

    private String webId;

    private String searchYM;

    private String searchDef;

    private String dealAmount;

    private String limitAmt;

    private String ridTaxiConv;

    private String addr1Delt;

    /** 고객명 */
    private String mbrNm;

    /** 회원 구분 */
    private String memDiv;
    /** 회원 등급 코드 */
    private String tierCd;
    /** 회원 상태 명 */
    private String mbrStatNm;

    /** 회원 유형명 */
    private String mbrTypeNm;

    /** 현재 등급명 */
    private String tierNm;

    /** 가입채널명 */
    private String chnlJoinNm;

    /** 주거래채널명 */
    private String chnlPrimaryNm;

    /** PGM명 */
    private String pgmNm;

    /** 가용포인트 */
    private String availablePoints;
    
    private String searchType;

    /** CREATE_DATE */
    /*private String createDate;*/

    /** CREATE_BY */
    /*private String createBy;*/

    /** 수정일시 */
    /*private String modifyDate;*/

    /** MODIFY_BY */
    /*private String modifyBy;*/
    
    private String ridMbr;
    private Date trDt;
    private String intRidMbr;
    private String prevMbrRid;
    private String mbrIntCd;
    private String chnlNameGrid;
    
    private String sendChnlType;
    
    private String pntUpdateType;
    
    private String beforePntAcrlYnVal;
    private String beforePntRdmYnVal;

    private String afterPntAcrlYnVal;
    private String afterPntRdmYnVal;
    private String pntResn;
    
    private String chgPstn;
    private String memNo;
	private String chgTbl;
    private String chgCol;
    private String bchngData;   
    private String achngData;
    private String rMark;
    private String cpnNo;
    private String ofrNm;
    private String cpnExpiryState;
    private String secsnAbleResnEtc;
    @Encrypted
    private String encrytedHhp;
    @Encrypted
    private String encrytedCustNm;
    
    private String billNo;
	
	//회원 설문
    private String ridSurv;

    private String cponNm;
    private String cponStCd;

 	//권한
	private String authType;
	private String brandCd;
	private String empType;

    
    
    public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getEncrytedHhp() {
		return encrytedHhp;
	}

	public void setEncrytedHhp(String encrytedHhp) {
		this.encrytedHhp = encrytedHhp;
	}

	public String getEncrytedCustNm() {
		return encrytedCustNm;
	}

	public void setEncrytedCustNm(String encrytedCustNm) {
		this.encrytedCustNm = encrytedCustNm;
	}

	public String getSecsnAbleResnEtc() {
		return secsnAbleResnEtc;
	}

	public void setSecsnAbleResnEtc(String secsnAbleResnEtc) {
		this.secsnAbleResnEtc = secsnAbleResnEtc;
	}

	public String getChgPstn() {
		return chgPstn;
	}

	public void setChgPstn(String chgPstn) {
		this.chgPstn = chgPstn;
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
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

	public String getBchngData() {
		return bchngData;
	}

	public void setBchngData(String bchngData) {
		this.bchngData = bchngData;
	}

	public String getAchngData() {
		return achngData;
	}

	public void setAchngData(String achngData) {
		this.achngData = achngData;
	}



    
	public String getChnlNameGrid() {
		return chnlNameGrid;
	}

	public void setChnlNameGrid(String chnlNameGrid) {
		this.chnlNameGrid = chnlNameGrid;
	}

	public String getMbrIntCd() {
		return mbrIntCd;
	}

	public void setMbrIntCd(String mbrIntCd) {
		this.mbrIntCd = mbrIntCd;
	}

	public String getIntRidMbr() {
		return intRidMbr;
	}

	public void setIntRidMbr(String intRidMbr) {
		this.intRidMbr = intRidMbr;
	}

	public String getPrevMbrRid() {
		return prevMbrRid;
	}

	public void setPrevMbrRid(String prevMbrRid) {
		this.prevMbrRid = prevMbrRid;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	/** 비밀번호 존재여부 */
    private Integer isEmptyPntUsePw;

    /** 본인생일구분 */
    private String lunarGbnCd;

    /** 주소변경 일시 */
    private String ownhomeAdrChgDt;

    /** 도로명주소 상세 */
    private String addrdtl;

    /** 총춘전포인트 */
    private String totChangePoint;

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

    private String ridConfNcst;

    private String diNo;

    private String ipinNo;

    private String rqtNo;

    private String authAgegrd;

    private String altrVrfMsg;

    private String authReslt;

    private String ipadr;

    private String foreignCd;

    private String genGbnCd;

    private String ridMnbsnStn;

    private String appNewsYn;

    private String appBenefitYn;

    private String addr1JiDtl;

    private String hCity;

    private String hGu;

    private String addr1JiDflt;

    private String addr1JiZip;

    private String rdAddrConfirm;

    private String pstmatrRecvDesk;

    private String marryAniv;
    
    private String marryYn;
    
    private String spousLunarGbnCd;
    
    private String spousBthday;
    
    private String carModel;

    private String mkngYy;

    private String usePrps;

    private String termsAgreeFlg;

    private String cprtCmpnDiv;

    private String smartphPssnYn;

    private String carNo;

    private String pntUsePw;

    private String phCertiYn;

    private String phCertDt;

    private String sbscChnlCd;

    private String ridChnl;

    private String startDt;
    private String endDt;
    
    
    //탈퇴 회원 프로시져
    private String empId;
    private String commitYn;
    private String secsnReqDt;
    private String secsnResnCd;
    private String secsnResnEtc;
    private String pRst;
	private String pRstCd;
	private String pRstMsg;
	
	//법인회원카드 인증
	private String cardNo;
	private String cateSubCd;
	
	//웹아이디 인증
	private String loginTypeCd;
	private String userId;
	
	private String tierGrpRid;
	private String tierRid;
	
	//추천인코드 검증
	private String rcmmdNo;
	
	//구매이력 적립버튼
	private String purHeadRid;
	private String value;
	
	//포인트 양도
	private String tgtMbrNo;
	private String feeLevyCd;
	private String feeAmt;
	private String feeRcptNo;
	private String giftComment;
	private String countFee;
	private String pntPwd;
	private String salesTypeName;
	private String slrtClsCd;

	
	public String getSalesTypeName() {
		return salesTypeName;
	}

	public void setSalesTypeName(String salesTypeName) {
		this.salesTypeName = salesTypeName;
	}

	public String getPntPwd() {
		return pntPwd;
	}

	public void setPntPwd(String pntPwd) {
		this.pntPwd = pntPwd;
	}

	public String getCountFee() {
		return countFee;
	}

	public void setCountFee(String countFee) {
		this.countFee = countFee;
	}

	public String getTgtMbrNo() {
		return tgtMbrNo;
	}

	public void setTgtMbrNo(String tgtMbrNo) {
		this.tgtMbrNo = tgtMbrNo;
	}

	public String getFeeLevyCd() {
		return feeLevyCd;
	}

	public void setFeeLevyCd(String feeLevyCd) {
		this.feeLevyCd = feeLevyCd;
	}

	public String getFeeAmt() {
		return feeAmt;
	}

	public void setFeeAmt(String feeAmt) {
		this.feeAmt = feeAmt;
	}

	public String getFeeRcptNo() {
		return feeRcptNo;
	}

	public void setFeeRcptNo(String feeRcptNo) {
		this.feeRcptNo = feeRcptNo;
	}

	public String getGiftComment() {
		return giftComment;
	}

	public void setGiftComment(String giftComment) {
		this.giftComment = giftComment;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getPurHeadRid() {
		return purHeadRid;
	}

	public void setPurHeadRid(String purHeadRid) {
		this.purHeadRid = purHeadRid;
	}

	public String getTierGrpRid() {
		return tierGrpRid;
	}

	public void setTierGrpRid(String tierGrpRid) {
		this.tierGrpRid = tierGrpRid;
	}

	public String getTierRid() {
		return tierRid;
	}

	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}

	public String getRcmmdNo() {
		return rcmmdNo;
	}

	public void setRcmmdNo(String rcmmdNo) {
		this.rcmmdNo = rcmmdNo;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
    public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getRqtNo() {
		return rqtNo;
	}

	public void setRqtNo(String rqtNo) {
		this.rqtNo = rqtNo;
	}

	public String getAuthAgegrd() {
		return authAgegrd;
	}

	public void setAuthAgegrd(String authAgegrd) {
		this.authAgegrd = authAgegrd;
	}

	public String getAltrVrfMsg() {
		return altrVrfMsg;
	}

	public void setAltrVrfMsg(String altrVrfMsg) {
		this.altrVrfMsg = altrVrfMsg;
	}

	public String getAuthReslt() {
		return authReslt;
	}

	public void setAuthReslt(String authReslt) {
		this.authReslt = authReslt;
	}

	public String getIpadr() {
		return ipadr;
	}

	public void setIpadr(String ipadr) {
		this.ipadr = ipadr;
	}

	public String getForeignCd() {
		return foreignCd;
	}

	public void setForeignCd(String foreignCd) {
		this.foreignCd = foreignCd;
	}

	public String getGenGbnCd() {
		return genGbnCd;
	}

	public void setGenGbnCd(String genGbnCd) {
		this.genGbnCd = genGbnCd;
	}

	public String getRidMnbsnStn() {
		return ridMnbsnStn;
	}

	public void setRidMnbsnStn(String ridMnbsnStn) {
		this.ridMnbsnStn = ridMnbsnStn;
	}

	public String getAppNewsYn() {
		return appNewsYn;
	}

	public void setAppNewsYn(String appNewsYn) {
		this.appNewsYn = appNewsYn;
	}

	public String getAppBenefitYn() {
		return appBenefitYn;
	}

	public void setAppBenefitYn(String appBenefitYn) {
		this.appBenefitYn = appBenefitYn;
	}

	public String getAddr1JiDtl() {
		return addr1JiDtl;
	}

	public void setAddr1JiDtl(String addr1JiDtl) {
		this.addr1JiDtl = addr1JiDtl;
	}

	public String gethCity() {
		return hCity;
	}

	public void sethCity(String hCity) {
		this.hCity = hCity;
	}

	public String gethGu() {
		return hGu;
	}

	public void sethGu(String hGu) {
		this.hGu = hGu;
	}

	public String getAddr1JiDflt() {
		return addr1JiDflt;
	}

	public void setAddr1JiDflt(String addr1JiDflt) {
		this.addr1JiDflt = addr1JiDflt;
	}

	public String getAddr1JiZip() {
		return addr1JiZip;
	}

	public void setAddr1JiZip(String addr1JiZip) {
		this.addr1JiZip = addr1JiZip;
	}

	public String getRdAddrConfirm() {
		return rdAddrConfirm;
	}

	public void setRdAddrConfirm(String rdAddrConfirm) {
		this.rdAddrConfirm = rdAddrConfirm;
	}

	public String getPstmatrRecvDesk() {
		return pstmatrRecvDesk;
	}

	public void setPstmatrRecvDesk(String pstmatrRecvDesk) {
		this.pstmatrRecvDesk = pstmatrRecvDesk;
	}

	public String getMarryAniv() {
		return marryAniv;
	}

	public void setMarryAniv(String marryAniv) {
		this.marryAniv = marryAniv;
	}

	public String getMarryYn() {
		return marryYn;
	}

	public void setMarryYn(String marryYn) {
		this.marryYn = marryYn;
	}

	public String getSpousLunarGbnCd() {
		return spousLunarGbnCd;
	}

	public void setSpousLunarGbnCd(String spousLunarGbnCd) {
		this.spousLunarGbnCd = spousLunarGbnCd;
	}

	public String getSpousBthday() {
		return spousBthday;
	}

	public void setSpousBthday(String spousBthday) {
		this.spousBthday = spousBthday;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}

	public String getMkngYy() {
		return mkngYy;
	}

	public void setMkngYy(String mkngYy) {
		this.mkngYy = mkngYy;
	}

	public String getUsePrps() {
		return usePrps;
	}

	public void setUsePrps(String usePrps) {
		this.usePrps = usePrps;
	}

	public String getTermsAgreeFlg() {
		return termsAgreeFlg;
	}

	public void setTermsAgreeFlg(String termsAgreeFlg) {
		this.termsAgreeFlg = termsAgreeFlg;
	}

	public String getCprtCmpnDiv() {
		return cprtCmpnDiv;
	}

	public void setCprtCmpnDiv(String cprtCmpnDiv) {
		this.cprtCmpnDiv = cprtCmpnDiv;
	}

	public String getSmartphPssnYn() {
		return smartphPssnYn;
	}

	public void setSmartphPssnYn(String smartphPssnYn) {
		this.smartphPssnYn = smartphPssnYn;
	}

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getPntUsePw() {
		return pntUsePw;
	}

	public void setPntUsePw(String pntUsePw) {
		this.pntUsePw = pntUsePw;
	}

	public String getPhCertiYn() {
		return phCertiYn;
	}

	public void setPhCertiYn(String phCertiYn) {
		this.phCertiYn = phCertiYn;
	}

	public String getPhCertDt() {
		return phCertDt;
	}

	public void setPhCertDt(String phCertDt) {
		this.phCertDt = phCertDt;
	}

	public String getSbscChnlCd() {
		return sbscChnlCd;
	}

	public void setSbscChnlCd(String sbscChnlCd) {
		this.sbscChnlCd = sbscChnlCd;
	}


    public String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
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

	public String getMbrStatNm() {
		return mbrStatNm;
	}

	public void setMbrStatNm(String mbrStatNm) {
		this.mbrStatNm = mbrStatNm;
	}

	public String getMbrTypeNm() {
		return mbrTypeNm;
	}

	public void setMbrTypeNm(String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getChnlJoinNm() {
		return chnlJoinNm;
	}

	public void setChnlJoinNm(String chnlJoinNm) {
		this.chnlJoinNm = chnlJoinNm;
	}

	public String getChnlPrimaryNm() {
		return chnlPrimaryNm;
	}

	public void setChnlPrimaryNm(String chnlPrimaryNm) {
		this.chnlPrimaryNm = chnlPrimaryNm;
	}

	public String getPgmNm() {
		return pgmNm;
	}

	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	public String getAvailablePoints() {
		return availablePoints;
	}

	public void setAvailablePoints(String availablePoints) {
		this.availablePoints = availablePoints;
	}

	/*public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}*/

	public Integer getIsEmptyPntUsePw() {
		return isEmptyPntUsePw;
	}

	public void setIsEmptyPntUsePw(Integer isEmptyPntUsePw) {
		this.isEmptyPntUsePw = isEmptyPntUsePw;
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

	public String getAddrdtl() {
		return addrdtl;
	}

	public void setAddrdtl(String addrdtl) {
		this.addrdtl = addrdtl;
	}

	public String getTotChangePoint() {
		return totChangePoint;
	}

	public void setTotChangePoint(String totChangePoint) {
		this.totChangePoint = totChangePoint;
	}

	public String getAvlPoint() {
		return avlPoint;
	}

	public void setAvlPoint(String avlPoint) {
		this.avlPoint = avlPoint;
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

	public String getEcommMbrNo() {
		return ecommMbrNo;
	}

	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}



	public String getSbscChnlCdMarkName() {
		return sbscChnlCdMarkName;
	}

	public void setSbscChnlCdMarkName(String sbscChnlCdMarkName) {
		this.sbscChnlCdMarkName = sbscChnlCdMarkName;
	}


	public LoyMbrReqDto() {
   /*     try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
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

	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
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
	 * @return the cipherKey
	 */
	public String getCipherKey() {
		return cipherKey;
	}


	/**
	 * @param cipherKey the cipherKey to set
	 */
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
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


	public String getCustNm() {
		return custNm;
	}


	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}


	public String getRidChnlMbrRel() {
		return ridChnlMbrRel;
	}


	public void setRidChnlMbrRel(String ridChnlMbrRel) {
		this.ridChnlMbrRel = ridChnlMbrRel;
	}

	public String getBonusCardNo() {
		return bonusCardNo;
	}

	public void setBonusCardNo(String bonusCardNo) {
		this.bonusCardNo = bonusCardNo;
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

	public String getBirthDt() {
		return birthDt;
	}

	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}

	public String getWbMemId() {
		return wbMemId;
	}

	public void setWbMemId(String wbMemId) {
		this.wbMemId = wbMemId;
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

	public String getRidTaxiConv() {
		return ridTaxiConv;
	}

	public void setRidTaxiConv(String ridTaxiConv) {
		this.ridTaxiConv = ridTaxiConv;
	}

	public String getAddr1Delt() {
		return addr1Delt;
	}

	public void setAddr1Delt(String addr1Delt) {
		this.addr1Delt = addr1Delt;
	}

	public String getRidConfNcst() {
		return ridConfNcst;
	}

	public void setRidConfNcst(String ridConfNcst) {
		this.ridConfNcst = ridConfNcst;
	}

	public String getDiNo() {
		return diNo;
	}

	public void setDiNo(String diNo) {
		this.diNo = diNo;
	}

	public String getIpinNo() {
		return ipinNo;
	}

	public void setIpinNo(String ipinNo) {
		this.ipinNo = ipinNo;
	}

	/**
	* @return the ridChnl
	*/
	public String getRidChnl() {
		return ridChnl;
	}

	/**
	* @param ridChnl the ridChnl to set
	*/
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getCommitYn() {
		return commitYn;
	}

	public void setCommitYn(String commitYn) {
		this.commitYn = commitYn;
	}

	public String getSecsnResnCd() {
		return secsnResnCd;
	}

	public void setSecsnResnCd(String secsnResnCd) {
		this.secsnResnCd = secsnResnCd;
	}

	public String getSecsnResnEtc() {
		return secsnResnEtc;
	}

	public void setSecsnResnEtc(String secsnResnEtc) {
		this.secsnResnEtc = secsnResnEtc;
	}

	public String getpRst() {
		return pRst;
	}

	public void setpRst(String pRst) {
		this.pRst = pRst;
	}

	public String getpRstCd() {
		return pRstCd;
	}

	public void setpRstCd(String pRstCd) {
		this.pRstCd = pRstCd;
	}

	public String getpRstMsg() {
		return pRstMsg;
	}

	public void setpRstMsg(String pRstMsg) {
		this.pRstMsg = pRstMsg;
	}

	public String getSecsnReqDt() {
		return secsnReqDt;
	}

	public void setSecsnReqDt(String secsnReqDt) {
		this.secsnReqDt = secsnReqDt;
	}

	public String getLoginTypeCd() {
		return loginTypeCd;
	}

	public void setLoginTypeCd(String loginTypeCd) {
		this.loginTypeCd = loginTypeCd;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public Date getTrDt() {
		return trDt;
	}

	public void setTrDt(Date trDt) {
		this.trDt = trDt;
	}

	public String getCateSubCd() {
		return cateSubCd;
	}

	public void setCateSubCd(String cateSubCd) {
		this.cateSubCd = cateSubCd;
	}
	public String getSrcTypeNm() {
		return srcTypeNm;
	}

	public void setSrcTypeNm(String srcTypeNm) {
		this.srcTypeNm = srcTypeNm;
	}
	
	public String getSendChnlType() {
		return sendChnlType;
	}

	public void setSendChnlType(String sendChnlType) {
		this.sendChnlType = sendChnlType;
	}

	public String getPntUpdateType() {
		return pntUpdateType;
	}

	public void setPntUpdateType(String pntUpdateType) {
		this.pntUpdateType = pntUpdateType;
	}

	public String getAfterPntAcrlYnVal() {
		return afterPntAcrlYnVal;
	}

	public void setAfterPntAcrlYnVal(String afterPntAcrlYnVal) {
		this.afterPntAcrlYnVal = afterPntAcrlYnVal;
	}

	public String getPntResn() {
		return pntResn;
	}

	public void setPntResn(String pntResn) {
		this.pntResn = pntResn;
	}

	public String getAfterPntRdmYnVal() {
		return afterPntRdmYnVal;
	}

	public void setAfterPntRdmYnVal(String afterPntRdmYnVal) {
		this.afterPntRdmYnVal = afterPntRdmYnVal;
	}

	public String getBeforePntAcrlYnVal() {
		return beforePntAcrlYnVal;
	}

	public void setBeforePntAcrlYnVal(String beforePntAcrlYnVal) {
		this.beforePntAcrlYnVal = beforePntAcrlYnVal;
	}

	public String getBeforePntRdmYnVal() {
		return beforePntRdmYnVal;
	}

	public void setBeforePntRdmYnVal(String beforePntRdmYnVal) {
		this.beforePntRdmYnVal = beforePntRdmYnVal;
	}

	public String getrMark() {
		return rMark;
	}

	public void setrMark(String rMark) {
		this.rMark = rMark;
	}

	public String getCpnNo() {
		return cpnNo;
	}

	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}

	public String getOfrNm() {
		return ofrNm;
	}

	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}

	public String getCpnExpiryState() {
		return cpnExpiryState;
	}

	public void setCpnExpiryState(String cpnExpiryState) {
		this.cpnExpiryState = cpnExpiryState;
	}

	public String getRidSurv() {
		return ridSurv;
	}

	public void setRidSurv(String ridSurv) {
		this.ridSurv = ridSurv;
	}

	public String getCponNm() {
		return cponNm;
	}

	public void setCponNm(String cponNm) {
		this.cponNm = cponNm;
	}

	public String getCponStCd() {
		return cponStCd;
	}

	public void setCponStCd(String cponStCd) {
		this.cponStCd = cponStCd;
	}

	public String getSlrtClsCd() {
		return slrtClsCd;
	}

	public void setSlrtClsCd(String slrtClsCd) {
		this.slrtClsCd = slrtClsCd;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}

	public String getBrandCd() {
		return brandCd;
	}

	public void setBrandCd(String brandCd) {
		this.brandCd = brandCd;
	}

	public String getEmpType() {
		return empType;
	}

	public void setEmpType(String empType) {
		this.empType = empType;
	}
}
