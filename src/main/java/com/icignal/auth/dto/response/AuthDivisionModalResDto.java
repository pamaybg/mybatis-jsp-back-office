package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class AuthDivisionModalResDto extends GridPagingItemResDto{
	
	private String rid;
	private String divTypeCd;
	private String divNo;
	private String divNm;
	private String divLvl;
	private String ridParDiv;
	private String divStatus;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getDivTypeCd() {
		return divTypeCd;
	}
	public void setDivTypeCd(String divTypeCd) {
		this.divTypeCd = divTypeCd;
	}
	public String getDivNo() {
		return divNo;
	}
	public void setDivNo(String divNo) {
		this.divNo = divNo;
	}
	public String getDivNm() {
		return divNm;
	}
	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}
	public String getDivLvl() {
		return divLvl;
	}
	public void setDivLvl(String divLvl) {
		this.divLvl = divLvl;
	}
	public String getRidParDiv() {
		return ridParDiv;
	}
	public void setRidParDiv(String ridParDiv) {
		this.ridParDiv = ridParDiv;
	}
	public String getDivStatus() {
		return divStatus;
	}
	public void setDivStatus(String divStatus) {
		this.divStatus = divStatus;
	}
}
