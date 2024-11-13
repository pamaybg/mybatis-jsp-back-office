package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyCustItemConfListResDto extends GridPagingItemResDto{

	private String rid;
	@MarkName(groupCode = "LOY_CUST_TYPE_CD", codeField = "custTypeCd")
	private String custType;
	private String custTypeCd;
	private String fieldNm;
	private String fieldDesc;
	private String createDate;
	private String requiredYn;
	private String encodeYn;
	@MarkName(groupCode = "LOY_CUST_FIELD_VAL_CD", codeField = "fieldValCdNm")
	private String fieldValCd;
	private String fieldValCdNm;
	private String grpCdNm;
	private String columnNm;
	private String pgmNm;
	
	
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
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
	public String getFieldValCdNm() {
		return fieldValCdNm;
	}
	public void setFieldValCdNm(String fieldValCdNm) {
		this.fieldValCdNm = fieldValCdNm;
	}
	public String getGrpCdNm() {
		return grpCdNm;
	}
	public void setGrpCdNm(String grpCdNm) {
		this.grpCdNm = grpCdNm;
	}

	public String getPgmNm() {
		return pgmNm;
	}

	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
}
