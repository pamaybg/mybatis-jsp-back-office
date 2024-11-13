/**
 *
 */
package com.icignal.loyalty.customer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
  * @fileName : LOYCustAddInfoRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 19.
  * @author : knlee
  * @변경이력 :
  * @descripton :
  */
public class LOYCustAddInfoReqDto extends CommonDataAuthReqDto {

	/**
	 * 부가정보 RID
	 */
	private String rid;

	/** RID_고객 */
	private String ridCust;
	/** 부가 정보 유형 코드 */
	private String addInfoTypeCd;

	/** 부가 정보 유형 코드 */
	private String addInfoTypeNm;

	/** 속성 유형 코드 */
	private String attrTypeCd;

	/** 속성 유형 명 */
	private String attrTypeNm;


	/** 속성 값 */
	private String attrVal;


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
	 * @return the addInfoTypeCd
	 */
	public String getAddInfoTypeCd() {
		return addInfoTypeCd;
	}

	/**
	 * @param addInfoTypeCd the addInfoTypeCd to set
	 */
	public void setAddInfoTypeCd(String addInfoTypeCd) {
		this.addInfoTypeCd = addInfoTypeCd;
	}

	/**
	 * @return the addInfoTypeNm
	 */
	public String getAddInfoTypeNm() {
		return addInfoTypeNm;
	}

	/**
	 * @param addInfoTypeNm the addInfoTypeNm to set
	 */
	public void setAddInfoTypeNm(String addInfoTypeNm) {
		this.addInfoTypeNm = addInfoTypeNm;
	}

	/**
	 * @return the attrTypeCd
	 */
	public String getAttrTypeCd() {
		return attrTypeCd;
	}

	/**
	 * @param attrTypeCd the attrTypeCd to set
	 */
	public void setAttrTypeCd(String attrTypeCd) {
		this.attrTypeCd = attrTypeCd;
	}

	/**
	 * @return the attrTypeNm
	 */
	public String getAttrTypeNm() {
		return attrTypeNm;
	}

	/**
	 * @param attrTypeNm the attrTypeNm to set
	 */
	public void setAttrTypeNm(String attrTypeNm) {
		this.attrTypeNm = attrTypeNm;
	}

	/**
	 * @return the attrVal
	 */
	public String getAttrVal() {
		return attrVal;
	}

	/**
	 * @param attrVal the attrVal to set
	 */
	public void setAttrVal(String attrVal) {
		this.attrVal = attrVal;
	}



}
