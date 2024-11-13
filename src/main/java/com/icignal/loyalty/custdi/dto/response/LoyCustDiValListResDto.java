package com.icignal.loyalty.custdi.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyCustDiValListResDto extends GridPagingItemResDto{

	private String rid;
	@MarkName(groupCode = "LOY_CUST_DI_TYPE_CD", codeField = "fieldCd")
	private String field;
	private String fieldCd;
	private int seq;
	private int score;
	private String createDate;
	private String createBy;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getFieldCd() {
		return fieldCd;
	}
	public void setFieldCd(String fieldCd) {
		this.fieldCd = fieldCd;
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
	
}
