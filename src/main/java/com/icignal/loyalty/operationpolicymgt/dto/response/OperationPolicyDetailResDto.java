package com.icignal.loyalty.operationpolicymgt.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class OperationPolicyDetailResDto extends GridPagingItemResDto {

	// 멤버필드
	private String rid;
	private String createDate;
	private String modifyDate;
	private String createBy;
	private String modifyBy;
	private String flag;
	private String ridOpr;
	@MarkName(groupCode="LOY_OPR_PLCY_CD", codeField="ridOpr")
	private String ridOprNm;
	private String parRid;
	private String attrCd;
    //@MarkName(groupCode="LOY_OPR_PLCY_ATTR_CD", codeField="attr_cd")
	//@MarkName(groupCode="LOY_OPR_PLCY_ATTR_CD", codeField="attrCd")
	private String attrCdNm;
	private String dataType;
	@MarkName(groupCode="LOY_OPR_PLCY_DATA_TYPE_CD", codeField="dataType")
	private String dataTypeNm;
	private String dataVal;
	private String contents;
	private String useYn;
	private String groupCd;
	private String singleValYn;
	private String dataValMarkNm; // dataVal값(+그와 함께 있는 group_code값)에 대한 MarkName 필드 
	//private String data_val_mark_nm;
	
	
	/*public String getData_val_mark_nm() {
		return data_val_mark_nm;
	}
	public void setData_val_mark_nm(String data_val_mark_nm) {
		this.data_val_mark_nm = data_val_mark_nm;
	}*/
	
	public String getRidOprNm() {
		return ridOprNm;
	}
	public void setRidOprNm(String ridOprNm) {
		this.ridOprNm = ridOprNm;
	}
	
	// 게터세터
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
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public String getRidOpr() {
		return ridOpr;
	}
	public void setRidOpr(String ridOpr) {
		this.ridOpr = ridOpr;
	}
	
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getAttrCd() {
		return attrCd;
	}
	public void setAttrCd(String attrCd) {
		this.attrCd = attrCd;
	}
	public String getAttrCdNm() {
		return attrCdNm;
	}
	public void setAttrCdNm(String attrCdNm) {
		this.attrCdNm = attrCdNm;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getDataVal() {
		return dataVal;
	}
	public void setDataVal(String dataVal) {
		this.dataVal = dataVal;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getDataTypeNm() {
		return dataTypeNm;
	}
	public void setDataTypeNm(String dataTypeNm) {
		this.dataTypeNm = dataTypeNm;
	}
	public String getGroupCd() {
		return groupCd;
	}
	public void setGroupCd(String groupCd) {
		this.groupCd = groupCd;
	}
	public String getSingleValYn() {
		return singleValYn;
	}
	public void setSingleValYn(String singleValYn) {
		this.singleValYn = singleValYn;
	}
	public String getDataValMarkNm() {
		return dataValMarkNm;
	}
	public void setDataValMarkNm(String dataValMarkNm) {
		this.dataValMarkNm = dataValMarkNm;
	}

	
}
