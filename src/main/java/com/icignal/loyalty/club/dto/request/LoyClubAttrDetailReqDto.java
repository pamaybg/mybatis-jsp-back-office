package com.icignal.loyalty.club.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyClubAttrDetailReqDto extends CommonDataAuthReqDto{
	
	private String rid;
	private String parRid;
	private String empId;
	private String ridClub;
	private String fieldTypeCd;
	private String code;
	private String val;
	private String reqYn;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getRidClub() {
		return ridClub;
	}

	public void setRidClub(String ridClub) {
		this.ridClub = ridClub;
	}

	public String getFieldTypeCd() {
		return fieldTypeCd;
	}

	public void setFieldTypeCd(String fieldTypeCd) {
		this.fieldTypeCd = fieldTypeCd;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getReqYn() {
		return reqYn;
	}

	public void setReqYn(String reqYn) {
		this.reqYn = reqYn;
	}
	
}
