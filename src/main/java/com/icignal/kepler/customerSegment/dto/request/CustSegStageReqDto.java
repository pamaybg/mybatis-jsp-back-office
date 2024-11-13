package com.icignal.kepler.customerSegment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CustSegStageReqDto extends CommonDataAuthReqDto {


	private String rid;

	private String csegCustCtgCd;
	
	private String csegCustTypeCd;
	
	private String cvsegTypeCd;
	
	private String csegStageNm;
	private String valueType;
	private String csegMstId;
	
	private String csegCustRuleNm;  // 고객 세분화 명
	private String csegCustRuleId;   //  고객 세분화 룰 ID 
	
	private String csegStageIndex;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getCvsegTypeCd() {
		return cvsegTypeCd;
	}
	public void setCvsegTypeCd(String cvsegTypeCd) {
		this.cvsegTypeCd = cvsegTypeCd;
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
	public String getCsegMstId() {
		return csegMstId;
	}
	public void setCsegMstId(String csegMstId) {
		this.csegMstId = csegMstId;
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
	private String filterVal;


}
