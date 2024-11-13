package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyExecutivesViewResDto extends GridPagingItemResDto {
	private String lcirid;
	private String lcrid;
	private String empNo;
	@MarkName(groupCode="LOY_MBR_STAT_CD",codeField="mbrStatCd")
	private String mbrStatCdNm;
	private String mbrStatCd;
	
	

	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getLcirid() {
		return lcirid;
	}
	public void setLcirid(String lcirid) {
		this.lcirid = lcirid;
	}
	public String getLcrid() {
		return lcrid;
	}
	public void setLcrid(String lcrid) {
		this.lcrid = lcrid;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
}
