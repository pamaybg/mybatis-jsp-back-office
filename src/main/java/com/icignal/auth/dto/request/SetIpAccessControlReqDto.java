package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SetIpAccessControlReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String ridUserAcl;
	private String ridCrmuser;
	private String aclType;
	private String accessIpAddr;
	private String useYn;
	private String creatorIpAddr;
	
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRidUserAcl() {
		return ridUserAcl;
	}
	public void setRidUserAcl(String ridUserAcl) {
		this.ridUserAcl = ridUserAcl;
	}
	public String getRidCrmuser() {
		return ridCrmuser;
	}
	public void setRidCrmuser(String ridCrmuser) {
		this.ridCrmuser = ridCrmuser;
	}
	public String getAclType() {
		return aclType;
	}
	public void setAclType(String aclType) {
		this.aclType = aclType;
	}
	public String getAccessIpAddr() {
		return accessIpAddr;
	}
	public void setAccessIpAddr(String accessIpAddr) {
		this.accessIpAddr = accessIpAddr;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getCreatorIpAddr() {
		return creatorIpAddr;
	}
	public void setCreatorIpAddr(String creatorIpAddr) {
		this.creatorIpAddr = creatorIpAddr;
	}
	
}
