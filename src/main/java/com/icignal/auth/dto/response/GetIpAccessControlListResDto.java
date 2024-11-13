package com.icignal.auth.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class GetIpAccessControlListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String accessIpAddr;
	private String aclType;
	private String aclTypeCd;
	private String useYn;
	private String useYnCd;
	private String userId;
	private String modifyBy;
	private String modifyDate;
	
	
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
	
}
