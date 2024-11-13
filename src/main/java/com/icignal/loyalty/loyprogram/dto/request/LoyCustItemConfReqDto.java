package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCustItemConfReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String empId;
	private String ridPgm;
	private String pgmNo;
	private String custTypeCd;
	private String fieldNm;
	private String fieldDesc;
	private String requiredYn;
	private String repYn;
	private String encodeYn;
	private String fieldValCd;
	private String gpCdNm;
	private String columnNm;
	private String pgmNm;
	private String createBy;
	private String modifyBy;

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
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
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
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
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
	public String getPgmNm() {return pgmNm;}
	public void setPgmNm(String pgmNm) {this.pgmNm = pgmNm;}
	@Override
	public String getCreateBy() {return createBy;}
	@Override
	public void setCreateBy(String createBy) {this.createBy = createBy;}
}
