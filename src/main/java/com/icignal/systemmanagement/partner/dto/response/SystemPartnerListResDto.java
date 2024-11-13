package com.icignal.systemmanagement.partner.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class SystemPartnerListResDto extends GridPagingItemResDto {
	
	private String rid           ;
	private String createDate    ;
	private String createBy      ;
	private String dispSeq       ;
	private String dispYn        ;
	@MarkName(groupCode = "PTNR_TYPE", codeField = "categoryCdNm")
	private String category      ;
	private String categoryCdNm;
	private String ptnrNm        ;
	private String solYn		 ;
	
	
	public String getSolYn() {
		return solYn;
	}
	public void setSolYn(String solYn) {
		this.solYn = solYn;
	}
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
	public String getDispSeq() {
		return dispSeq;
	}
	public void setDispSeq(String dispSeq) {
		this.dispSeq = dispSeq;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPtnrNm() {
		return ptnrNm;
	}
	public void setPtnrNm(String ptnrNm) {
		this.ptnrNm = ptnrNm;
	}
	public String getCategoryCdNm() {
		return categoryCdNm;
	}
	public void setCategoryCdNm(String categoryCdNm) {
		this.categoryCdNm = categoryCdNm;
	}
	
}
