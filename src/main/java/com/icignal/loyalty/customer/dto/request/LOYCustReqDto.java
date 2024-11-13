package com.icignal.loyalty.customer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LOYCustReqDto extends CommonDataAuthReqDto {
	/** RID */
	private String rid;
	/** 고객 유형 코드 */
	private String custTypeCd;
	/** 고객 명 */
	@Decrypted(masked = "custNm")
	private String custNm;
	/** 생년월일 */
	private String birthDt;
	/** 성별 구분 코드 */
	private String genGbnCd;
	/** 실 생년월일 */
	private String realBirthDt;
	/** 양음력 구분 코드 */
	private String lunarGbnCd;
	/** 식별 유형 코드 */
	private String identiTypeCd;
	/** 식별 값 */
	private String identiVal;
	/** 실명 인증 여부 */
	private String realnmCertiYn;
	/** 실명 인증 일자 */
	private String realnmCertiDate;

	private String cipherKey;

	public LOYCustReqDto(){
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
	 * @return the custNm
	 */
	public String getCustNm() {
		return custNm;
	}
	/**
	 * @param custNm the custNm to set
	 */
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	/**
	 * @return the birthDt
	 */
	public String getBirthDt() {
		return birthDt;
	}
	/**
	 * @param birthDt the birthDt to set
	 */
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	/**
	 * @return the genGbnCd
	 */
	public String getGenGbnCd() {
		return genGbnCd;
	}
	/**
	 * @param genGbnCd the genGbnCd to set
	 */
	public void setGenGbnCd(String genGbnCd) {
		this.genGbnCd = genGbnCd;
	}
	/**
	 * @return the realBirthDt
	 */
	public String getRealBirthDt() {
		return realBirthDt;
	}
	/**
	 * @param realBirthDt the realBirthDt to set
	 */
	public void setRealBirthDt(String realBirthDt) {
		this.realBirthDt = realBirthDt;
	}
	/**
	 * @return the lunarGbnCd
	 */
	public String getLunarGbnCd() {
		return lunarGbnCd;
	}
	/**
	 * @param lunarGbnCd the lunarGbnCd to set
	 */
	public void setLunarGbnCd(String lunarGbnCd) {
		this.lunarGbnCd = lunarGbnCd;
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
	 * @return the realnmCertiYn
	 */
	public String getRealnmCertiYn() {
		return realnmCertiYn;
	}
	/**
	 * @param realnmCertiYn the realnmCertiYn to set
	 */
	public void setRealnmCertiYn(String realnmCertiYn) {
		this.realnmCertiYn = realnmCertiYn;
	}
	/**
	 * @return the realnmCertiDate
	 */
	public String getRealnmCertiDate() {
		return realnmCertiDate;
	}
	/**
	 * @param realnmCertiDate the realnmCertiDate to set
	 */
	public void setRealnmCertiDate(String realnmCertiDate) {
		this.realnmCertiDate = realnmCertiDate;
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





}
