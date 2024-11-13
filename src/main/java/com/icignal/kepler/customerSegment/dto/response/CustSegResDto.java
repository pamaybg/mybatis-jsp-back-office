package com.icignal.kepler.customerSegment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CustSegResDto extends GridPagingItemResDto {
	
	private String rid; 
	private String createDate;
	private String createBy;
	private String modifyBy;
	private String modifyDate;

	private String csegHadId;
	private String csegNm;
	private String csegTypeCd;
	
	@MarkName(groupCode = "ANL_CSEG_TYPE_CD", codeField = "csegTypeCd")
	private String csegTypeNm;
	
	private String csegStatusCd;
	
	@MarkName(groupCode = "ANL_CSEG_STATUS_CD", codeField = "csegStatusCd")
	private String csegStatusNm;
	private String aplyStartDd;
	private String aplyEndDd;
	private String csegInfoDesc;
	private String csegCyclTypeCd;

	
	@MarkName(groupCode = "ANL_CSEG_CYCL_TYPE_CD", codeField = "csegStatusCd")
	private String csegCyclTypeNm;
	
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
	public String getCsegHadId() {
		return csegHadId;
	}
	public void setCsegHadId(String csegHadId) {
		this.csegHadId = csegHadId;
	}
	public String getCsegNm() {
		return csegNm;
	}
	public void setCsegNm(String csegNm) {
		this.csegNm = csegNm;
	}
	public String getCsegTypeCd() {
		return csegTypeCd;
	}
	public void setCsegTypeCd(String csegTypeCd) {
		this.csegTypeCd = csegTypeCd;
	}
	public String getCsegStatusCd() {
		return csegStatusCd;
	}
	public void setCsegStatusCd(String csegStatusCd) {
		this.csegStatusCd = csegStatusCd;
	}
	public String getAplyStartDd() {
		return aplyStartDd;
	}
	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}
	public String getAplyEndDd() {
		return aplyEndDd;
	}
	public void setAplyEndDd(String aplyEndDd) {
		this.aplyEndDd = aplyEndDd;
	}
	public String getCsegInfoDesc() {
		return csegInfoDesc;
	}
	public void setCsegInfoDesc(String csegInfoDesc) {
		this.csegInfoDesc = csegInfoDesc;
	}
	public String getCsegTypeNm() {
		return csegTypeNm;
	}
	public void setCsegTypeNm(String csegTypeNm) {
		this.csegTypeNm = csegTypeNm;
	}
	public String getCsegStatusNm() {
		return csegStatusNm;
	}
	public void setCsegStatusNm(String csegStatusNm) {
		this.csegStatusNm = csegStatusNm;
	}
	public String getCsegCyclTypeCd() {
		return csegCyclTypeCd;
	}
	public void setCsegCyclTypeCd(String csegCyclTypeCd) {
		this.csegCyclTypeCd = csegCyclTypeCd;
	}
	public String getCsegCyclTypeNm() {
		return csegCyclTypeNm;
	}
	public void setCsegCyclTypeNm(String csegCyclTypeNm) {
		this.csegCyclTypeNm = csegCyclTypeNm;
	}

}
