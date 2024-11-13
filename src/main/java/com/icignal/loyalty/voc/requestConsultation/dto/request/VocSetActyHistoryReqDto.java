package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;



public class VocSetActyHistoryReqDto extends MKTBaseReqDto {
	
	private String id; 
	private String empId; 
	private String ridCust; 
	private String cuserId; 
	private String ridCrmuser;
	private String actyType;
	private String sbst;
	private String ridSvcReq;
	private String chnlType;
	private String rid;
	private String msgSubject;
	private String name;
	private String updateCrmName;
	private String crmName;
	private String rcpMeth;
	private String rcpMethNm;
	
	
	
	public String getRcpMethNm() {
		return rcpMethNm;
	}
	public void setRcpMethNm(String rcpMethNm) {
		this.rcpMethNm = rcpMethNm;
	}
	public String getRcpMeth() {
		return rcpMeth;
	}
	public void setRcpMeth(String rcpMeth) {
		this.rcpMeth = rcpMeth;
	}
	public String getCrmName() {
		return crmName;
	}
	public void setCrmName(String crmName) {
		this.crmName = crmName;
	}
	public String getUpdateCrmName() {
		return updateCrmName;
	}
	public void setUpdateCrmName(String updateCrmName) {
		this.updateCrmName = updateCrmName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getCuserId() {
		return cuserId;
	}
	public void setCuserId(String cuserId) {
		this.cuserId = cuserId;
	}
	public String getRidCrmuser() {
		return ridCrmuser;
	}
	public void setRidCrmuser(String ridCrmuser) {
		this.ridCrmuser = ridCrmuser;
	}
	public String getActyType() {
		return actyType;
	}
	public void setActyType(String actyType) {
		this.actyType = actyType;
	}
	public String getSbst() {
		return sbst;
	}
	public void setSbst(String sbst) {
		this.sbst = sbst;
	}
	public String getRidSvcReq() {
		return ridSvcReq;
	}
	public void setRidSvcReq(String ridSvcReq) {
		this.ridSvcReq = ridSvcReq;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getMsgSubject() {
		return msgSubject;
	}
	public void setMsgSubject(String msgSubject) {
		this.msgSubject = msgSubject;
	} 
	
}
