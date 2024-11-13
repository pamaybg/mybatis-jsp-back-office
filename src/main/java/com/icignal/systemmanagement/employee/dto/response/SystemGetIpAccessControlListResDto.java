package com.icignal.systemmanagement.employee.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemGetIpAccessControlListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String accessIpAddr;
	
	@MarkName(groupCode="ACL_TYPE",codeField="aclTypeCd")
	private String aclType;
	private String aclTypeCd;
	
	@MarkName(groupCode="YES_NO_FLAG",codeField="useYnCd")
	private String useYn;
	private String useYnCd;
	private String userId;
	private String modifyBy;
	private String modifyDate;
	private String useCdYn;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAccessIpAddr() {
		return accessIpAddr;
	}
	public void setAccessIpAddr(String accessIpAddr) {
		this.accessIpAddr = accessIpAddr;
	}
	public String getAclType() {
		return aclType;
	}
	public void setAclType(String aclType) {
		this.aclType = aclType;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public String getAclTypeCd() {
		return aclTypeCd;
	}
	public void setAclTypeCd(String aclTypeCd) {
		this.aclTypeCd = aclTypeCd;
	}
	public String getUseYnCd() {
		return useYnCd;
	}
	public void setUseYnCd(String useYnCd) {
		this.useYnCd = useYnCd;
	}
	public String getUseCdYn() {
		return useCdYn;
	}
	public void setUseCdYn(String useCdYn) {
		this.useCdYn = useCdYn;
	}
	
}
