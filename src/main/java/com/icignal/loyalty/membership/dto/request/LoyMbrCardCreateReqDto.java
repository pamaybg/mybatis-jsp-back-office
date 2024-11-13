/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
  * @fileName : LoyMbrChnlRelRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 6.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원  채널관계 요청 DTO
  */
public class LoyMbrCardCreateReqDto  extends CommonDataAuthReqDto {
    
    /** rid card */
    private String ridCard;
    
    /** 프로그램 번호 */
    private String pgmNo;
    
    /** rid Pgm */
    private String ridPgm;
    
    /** rid 회원 */
    private String ridMbr;
    
    private String ridChnl;

	/** 카드 유형/채번 유형 */
	private String cardKindNo;
	
	private String ridCardKind;

	/** 회원 정보 처리 유형 */
	private String mbrJoinTp;

	/** 카드 탈회 일자 */
	private String cardLeavDate;

	/**카드발급 내용 문자메시지 전송 여부 */
	private String notiFlg;

	/** 기존 동일 유형 카드 해지 처리 여부 */
	private String existCardExpireFlg;
    
    /** 카드번호 */
    private String cardNo;
    
    /** 회원번호 */
    private String mbrNo;
    
    /** 회원명 */
    private String mbrNm;
    
    /** 회원 식별 유형 */
    private String mbrCertTp;
    
    /** 회원 식별 값 */
    private String mbrCertVal;
    
    /** 고객유형코드 */
    private String custTypeCd;
    
    /** 회원유형코드 */
    private String mbrTypeCd;
    
    /** Email */
    private String mbrEmailAddr;
    
    /** 우편번호 */
    private String addr1Zip;
    
    /** 주소 */
    private String addr1Dflt;
    
	/** 주소 상세*/
	private String addr1Dtl;

	/** 주소2_우편번호 */
	private String addr2Zip;

	/** 주소2_기본 */
	private String addr2Dflt;

	/** 주소2_상세 */
	private String addr2Dtl;

	/* 컨택  정보 */

	/** 휴대전화 번호*/
	private String hhpNo;

	/** 집전화 번호*/
	private String homeTelNo;

	/** 사무실 전화 번호  */
    private String offTelNo;
    
    /** 이메일 주소 */
    private String emailAddr;
    
    /** 발급일자 */
    private String cardIssueDt;
    
    /** 카드발급채널번호 */
    private String cardIssueChnlNo;
    
    /** 카드사용비밀번호 */
    private String cardUsePw;
    
    private String ridFaml;
    
	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
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
	 * @return the ridCard
	 */
	public String getRidCard() {
		return ridCard;
	}

	/**
	 * @param ridCard the ridCard to set
	 */
	public void setRidCard(String ridCard) {
		this.ridCard = ridCard;
	}

	/**
	 * @return the pgmNo
	 */
	public String getPgmNo() {
		return pgmNo;
	}

	/**
	 * @param pgmNo the pgmNo to set
	 */
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	/**
	 * @return the cardKindNo
	 */
	public String getCardKindNo() {
		return cardKindNo;
	}

	/**
	 * @param cardKindNo the cardKindNo to set
	 */
	public void setCardKindNo(String cardKindNo) {
		this.cardKindNo = cardKindNo;
	}

	/**
	 * @return the mbrJoinTp
	 */
	public String getMbrJoinTp() {
		return mbrJoinTp;
	}

	/**
	 * @param mbrJoinTp the mbrJoinTp to set
	 */
	public void setMbrJoinTp(String mbrJoinTp) {
		this.mbrJoinTp = mbrJoinTp;
	}

	/**
	 * @return the notiFlg
	 */
	public String getNotiFlg() {
		return notiFlg;
	}

	/**
	 * @param notiFlg the notiFlg to set
	 */
	public void setNotiFlg(String notiFlg) {
		this.notiFlg = notiFlg;
	}

	/**
	 * @return the existCardExpireFlg
	 */
	public String getExistCardExpireFlg() {
		return existCardExpireFlg;
	}

	/**
	 * @param existCardExpireFlg the existCardExpireFlg to set
	 */
	public void setExistCardExpireFlg(String existCardExpireFlg) {
		this.existCardExpireFlg = existCardExpireFlg;
	}

	/**
	 * @return the cardNo
	 */
	public String getCardNo() {
		return cardNo;
	}

	/**
	 * @param cardNo the cardNo to set
	 */
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
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
	 * @return the mbrCertTp
	 */
	public String getMbrCertTp() {
		return mbrCertTp;
	}

	/**
	 * @param mbrCertTp the mbrCertTp to set
	 */
	public void setMbrCertTp(String mbrCertTp) {
		this.mbrCertTp = mbrCertTp;
	}

	/**
	 * @return the mbrCertVal
	 */
	public String getMbrCertVal() {
		return mbrCertVal;
	}

	/**
	 * @param mbrCertVal the mbrCertVal to set
	 */
	public void setMbrCertVal(String mbrCertVal) {
		this.mbrCertVal = mbrCertVal;
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
	 * @return the mbrEmailAddr
	 */
	public String getMbrEmailAddr() {
		return mbrEmailAddr;
	}

	/**
	 * @param mbrEmailAddr the mbrEmailAddr to set
	 */
	public void setMbrEmailAddr(String mbrEmailAddr) {
		this.mbrEmailAddr = mbrEmailAddr;
	}

	/**
	 * @return the cardIssueDt
	 */
	public String getCardIssueDt() {
		return cardIssueDt;
	}

	/**
	 * @param cardIssueDt the cardIssueDt to set
	 */
	public void setCardIssueDt(String cardIssueDt) {
		this.cardIssueDt = cardIssueDt;
	}

	/**
	 * @return the cardIssueChnlNo
	 */
	public String getCardIssueChnlNo() {
		return cardIssueChnlNo;
	}

	/**
	 * @param cardIssueChnlNo the cardIssueChnlNo to set
	 */
	public void setCardIssueChnlNo(String cardIssueChnlNo) {
		this.cardIssueChnlNo = cardIssueChnlNo;
	}

	/**
	 * @return the cardUsePw
	 */
	public String getCardUsePw() {
		return cardUsePw;
	}

	/**
	 * @param cardUsePw the cardUsePw to set
	 */
	public void setCardUsePw(String cardUsePw) {
		this.cardUsePw = cardUsePw;
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
	 * @return the ridMbr
	 */
	public String getRidMbr() {
		return ridMbr;
	}

	/**
	 * @param ridMbr the ridMbr to set
	 */
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
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

	/**
	 * @return the cardLeavDate
	 */
	public String getCardLeavDate() {
		return cardLeavDate;
	}

	/**
	 * @param cardLeavDate the cardLeavDate to set
	 */
	public void setCardLeavDate(String cardLeavDate) {
		this.cardLeavDate = cardLeavDate;
	}

	/**
	 * @return the ridFaml
	 */
	public String getRidFaml() {
		return ridFaml;
	}

	/**
	 * @param ridFaml the ridFaml to set
	 */
	public void setRidFaml(String ridFaml) {
		this.ridFaml = ridFaml;
	}






}
