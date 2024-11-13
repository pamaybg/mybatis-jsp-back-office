package com.icignal.onlineapproval.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * @author : 박지열
 * @description : 전자 결제 승인자 및 참조자 조회
 */
public class ApprovalEmpListReqDto extends CommonDataAuthReqDto{
	private String id;                 //아이디
	private String memid;              //맴버 아이디
	private List<String>  empId;              //회원 아이디
	private String  accntId;              //회원 아이디
	private String empType;
	private String divRid;
	private String checkDiv;			//팀 체크
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public List<String> getEmpId() {
		return empId;
	}
	public void setEmpId(List<String> empId) {
		this.empId = empId;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getEmpType() {return empType;}
	public void setEmpType(String empType) {this.empType = empType;}
	public String getDivRid() {return divRid;}
	public void setDivRid(String divRid) {this.divRid = divRid;}
	public String getCheckDiv() {return checkDiv;}
	public void setCheckDiv(String checkDiv) {this.checkDiv = checkDiv;}
}
