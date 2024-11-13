package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LOYCustAddInfoResDto extends GridPagingItemResDto {

	/** RID */
	private String rid;
	/** RID_고객 */
	private String ridCust;
	/** 부가 정보 유형 코드 */
	private String addInfoTypeCd;

	/** 부가 정보 유형 코드 */
	@MarkName(groupCode="LOY_CUST_ADD_INFO_CD",codeField="addInfoTypeCd")
	private String addInfoTypeNm;


	/** 속성 유형 코드 */
	private String attrTypeCd;
	

	/** 속성 유형 명 */
	@MarkName(groupCode="LOY_DATA_TYPE_CD",codeField="attrTypeCd")
	private String attrTypeNm;


	/** 속성 값 */
	private String attrVal;


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
	


}
