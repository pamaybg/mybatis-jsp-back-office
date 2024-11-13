package com.icignal.kepler.customerSegment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CustSegStageResDto extends GridPagingItemResDto {
	
	private String rid; 
	private String createDate;
	private String createBy;
	private String modifyBy;
	private String modifyDate;
	
	private String csegCustCtgCd;
	@MarkName(groupCode = "ANL_CSEG_CUST_CTG_CD", codeField = "csegCustCtgCd")
	private String csegCustCtgNm;
	
	private String csegCustTypeCd;
	@MarkName(groupCode = "ANL_CSEG_CUST_TYPE_CD", codeField = "csegCustTypeCd")
	private String csegCustTypeNm;
	
	private String cvsegTypeCd;
	@MarkName(groupCode = "ANL_CVSEG_TYPE_CD", codeField = "cvsegTypeCd")
	private String cvsegTypeNm;
	
	private String csegStageNm;
	private String valueType;
	private String filterVal;
	
	private String csegCustRuleNm; 
	private String csegCustRuleId;
	
	private String csegStageIndex;
	private String dupIndexChk;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
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
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCsegCustCtgCd() {
		return csegCustCtgCd;
	}
	public void setCsegCustCtgCd(String csegCustCtgCd) {
		this.csegCustCtgCd = csegCustCtgCd;
	}
	public String getCsegCustTypeCd() {
		return csegCustTypeCd;
	}
	public void setCsegCustTypeCd(String csegCustTypeCd) {
		this.csegCustTypeCd = csegCustTypeCd;
	}
	public String getCsegStageNm() {
		return csegStageNm;
	}
	public void setCsegStageNm(String csegStageNm) {
		this.csegStageNm = csegStageNm;
	}
	public String getValueType() {
		return valueType;
	}
	public void setValueType(String valueType) {
		this.valueType = valueType;
	}
	public String getFilterVal() {
		return filterVal;
	}
	public void setFilterVal(String filterVal) {
		this.filterVal = filterVal;
	}
	public String getCsegCustCtgNm() {
		return csegCustCtgNm;
	}
	public void setCsegCustCtgNm(String csegCustCtgNm) {
		this.csegCustCtgNm = csegCustCtgNm;
	}
	public String getCsegCustTypeNm() {
		return csegCustTypeNm;
	}
	public void setCsegCustTypeNm(String csegCustTypeNm) {
		this.csegCustTypeNm = csegCustTypeNm;
	}
	public String getCvsegTypeCd() {
		return cvsegTypeCd;
	}
	public void setCvsegTypeCd(String cvsegTypeCd) {
		this.cvsegTypeCd = cvsegTypeCd;
	}
	public String getCvsegTypeNm() {
		return cvsegTypeNm;
	}
	public void setCvsegTypeNm(String cvsegTypeNm) {
		this.cvsegTypeNm = cvsegTypeNm;
	}
	public String getCsegCustRuleNm() {
		return csegCustRuleNm;
	}
	public void setCsegCustRuleNm(String csegCustRuleNm) {
		this.csegCustRuleNm = csegCustRuleNm;
	}
	public String getCsegCustRuleId() {
		return csegCustRuleId;
	}
	public void setCsegCustRuleId(String csegCustRuleId) {
		this.csegCustRuleId = csegCustRuleId;
	}
	public String getCsegStageIndex() {
		return csegStageIndex;
	}
	public void setCsegStageIndex(String csegStageIndex) {
		this.csegStageIndex = csegStageIndex;
	}
	public String getDupIndexChk() {
		return dupIndexChk;
	}
	public void setDupIndexChk(String dupIndexChk) {
		this.dupIndexChk = dupIndexChk;
	}


}
