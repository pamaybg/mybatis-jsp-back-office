package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCustItemConfResDto extends GridPagingItemResDto {

	private String rid;
	private String custTypeCd;
	private String fieldNm;
	private String fieldDesc;
	private String requiredYn;
	private String encodeYn;
	private String fieldValCd;
	private String gpCdNm;
	private String gpNm;
	private String columnNm;
	private String createBy;
	private String modifyBy;
	private String pgmRid;
	private String pgmNm;
	private String pgmNo;

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public String getPgmNm() {
		return pgmNm;
	}

	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	public String getColumnNm() {
		return columnNm;
	}
	public void setColumnNm(String columnNm) {
		this.columnNm = columnNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getFieldNm() {
		return fieldNm;
	}
	public void setFieldNm(String fieldNm) {
		this.fieldNm = fieldNm;
	}
	public String getFieldDesc() {
		return fieldDesc;
	}
	public void setFieldDesc(String fieldDesc) {
		this.fieldDesc = fieldDesc;
	}
	public String getRequiredYn() {
		return requiredYn;
	}
	public void setRequiredYn(String requiredYn) {
		this.requiredYn = requiredYn;
	}
	public String getEncodeYn() {
		return encodeYn;
	}
	public void setEncodeYn(String encodeYn) {
		this.encodeYn = encodeYn;
	}
	public String getFieldValCd() {
		return fieldValCd;
	}
	public void setFieldValCd(String fieldValCd) {
		this.fieldValCd = fieldValCd;
	}
	public String getGpCdNm() {
		return gpCdNm;
	}
	public void setGpCdNm(String gpCdNm) {
		this.gpCdNm = gpCdNm;
	}
	public String getGpNm() {
		return gpNm;
	}
	public void setGpNm(String gpNm) {
		this.gpNm = gpNm;
	}
	public String getCreateBy() {return createBy;}
	public void setCreateBy(String createBy) {this.createBy = createBy;}
}
