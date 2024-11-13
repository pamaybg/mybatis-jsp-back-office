/**
 * 회원 캠페인이력 응답 DTO
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;





/**
  * @fileName : LoyMbrChnlRelResponseDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 6.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 채널관계 응답  DTO
  */
@PersonalData
@CommCode
public class LoyMbrChnlRelResDto  extends GridPagingItemResDto {
	/** RID */
	private String rid     ;

	/** 채널번호 */
    private String chnlNo  ;

    /** 채널명 */
    private String chnlNm  ;

    /** 채널 관계 유형 코드 */
    private String chnlRelTypeCd   ;

    /** 채널 관계 유형 코드 */
    @MarkName(groupCode="LOY_CHNL_REL_TYPE_CD", codeField="chnlRelTypeCd")
    private String chnlRelTypeNm   ;

    /** 개인정보활용동의 */
    private String mktAgrePrvInfo  ;

    /** 위치정보사업동의 */
    private String mktAgreLbsBiz   ;

    /** 위치정보서비스활용동의 */
    private String mktAgreLbsSvc   ;

    /** 3자정보제공동의 */
    private String mktAgreThirdSnd ;

    /** 마케팅활용동의 */
    private String mktAgreUse;

    /** RID_MEM */
    private String ridMbr    ;

    /** RID_CHNL */
    private String ridChnl   ;

    /** 주소1_우편번호 */
    private String addr1Zip  ;

    /** 주소1_기본 */
    private String addr1Dflt ;

    /** 주소1_상세 */
    @Decrypted(masked = "none")
    private String addr1Dtl  ;

    /** 주소2_우편번호 */
    private String addr2Zip  ;

    /** 주소2_기본 */
    private String addr2Dflt ;

    /** 주소2_상세 */
    private String addr2Dtl  ;
    
    /** 채널관계 등록일시 */
    private String regDt  ;

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
	 * @return the chnlNo
	 */
	public String getChnlNo() {
		return chnlNo;
	}

	/**
	 * @param chnlNo the chnlNo to set
	 */
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	/**
	 * @return the chnlNm
	 */
	public String getChnlNm() {
		return chnlNm;
	}

	/**
	 * @param chnlNm the chnlNm to set
	 */
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	/**
	 * @return the chnlRelTypeCd
	 */
	public String getChnlRelTypeCd() {
		return chnlRelTypeCd;
	}

	/**
	 * @param chnlRelTypeCd the chnlRelTypeCd to set
	 */
	public void setChnlRelTypeCd(String chnlRelTypeCd) {
		this.chnlRelTypeCd = chnlRelTypeCd;
	}

	/**
	 * @return the chnlRelTypeNm
	 */
	public String getChnlRelTypeNm() {
		return chnlRelTypeNm;
	}

	/**
	 * @param chnlRelTypeNm the chnlRelTypeNm to set
	 */
	public void setChnlRelTypeNm(String chnlRelTypeNm) {
		this.chnlRelTypeNm = chnlRelTypeNm;
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

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}





}
