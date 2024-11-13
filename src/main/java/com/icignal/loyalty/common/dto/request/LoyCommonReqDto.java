package com.icignal.loyalty.common.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCommonReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String ridChnl;
	private String ridCust;
	private String empId;

	private String chnlLvlNo;	
	private String parRidTop;
	private String repYn;
	private String repYnCheck;
	
	private String chnlTypeCd;

	
	public String getRepYnCheck() {
		return repYnCheck;
	}

	public void setRepYnCheck(String repYnCheck) {
		this.repYnCheck = repYnCheck;
	}

	public String getParRidTop() {
		return parRidTop;
	}

	public void setParRidTop(String parRidTop) {
		this.parRidTop = parRidTop;
	}

	public String getChnlLvlNo() {
		return chnlLvlNo;
	}

	public void setChnlLvlNo(String chnlLvlNo) {
		this.chnlLvlNo = chnlLvlNo;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getRidCust() {
		return ridCust;
	}

	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}

	public String getRepYn() {
		return repYn;
	}

	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

}
