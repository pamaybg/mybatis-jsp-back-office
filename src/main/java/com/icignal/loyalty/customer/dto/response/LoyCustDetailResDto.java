/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustDetailResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 27. 오후 8:12:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyCustDetailResDto
 * 2. 파일명	: LoyCustDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyCustDetailResDto extends GridPagingItemResDto{
	/** RID */
	private String rid;

	/** 고객 유형 코드 */
	private String custTypeCd;

	/** 고객 유형 명 */
	@MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
	private String custTypeNm;

	/** 고객 명 */
	@Decrypted(masked = "none")
	private String custNm;

	/** 생년월일 */
	private String birthDt;

	/** 성별 구분 코드 */
	private String genGbnCd;

	/** 성별 */
	@MarkName(groupCode="LOY_GEN_CD", codeField="genGbnCd")
	private String genGbnNm;


	/** 실 생년월일 */
	private String realBirthDt;

	/** 양음력 구분 코드 */
	private String lunarGbnCd;

	/** 식별 유형 코드 */
	private String identiTypeCd;

	/** 식별 유형 명 */
	@MarkName(groupCode="LOY_IDENTI_TYPE_CD", codeField="identiTypeCd")
	private String identiTypeNm;
	private String custNmR;



	public String getCustNmR() {
		return custNmR;
	}
	public void setCustNmR(String custNmR) {
		this.custNmR = custNmR;
	}
	/** 식별 값 */
	private String identiVal;
	/** 실명 인증 여부 */
	private String realnmCertiYn;
	/** 실명 인증 일자 */
	private String realnmCertiDate;
	/** FLAG */
	private String flag;
	/** MOD_NUM */
	private String modNum;
	/** CREATE_DATE */
	private String createDate;
	/** CREATE_BY */
	private String createBy;
	/** 수정일시 */
	private String modifyDate;
	/** MODIFY_BY */
	private String modifyBy;
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
	/**fcustTypeCd
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
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/**
	 * @return the modNum
	 */
	public String getModNum() {
		return modNum;
	}
	/**
	 * @param modNum the modNum to set
	 */
	public void setModNum(String modNum) {
		this.modNum = modNum;
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
	 * @return the genGbnNm
	 */
	public String getGenGbnNm() {
		return genGbnNm;
	}
	/**
	 * @param genGbnNm the genGbnNm to set
	 */
	public void setGenGbnNm(String genGbnNm) {
		this.genGbnNm = genGbnNm;
	}
}
