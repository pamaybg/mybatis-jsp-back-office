package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemAlrtItemResDto extends GridPagingItemResDto {

	private String rid;
	private String alrtNm;
	private String activeYn;
	private String alrtCondCd;
	
	@MarkName(groupCode = "BAT_JOB_COND_VAL", codeField = "condValCdNm")
	private String condVal;
	
	private String condValCdNm;
	private String trsChnlcd;
	private String rcvr;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAlrtNm() {
		return alrtNm;
	}
	public void setAlrtNm(String alrtNm) {
		this.alrtNm = alrtNm;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public String getAlrtCondCd() {
		return alrtCondCd;
	}
	public void setAlrtCondCd(String alrtCondCd) {
		this.alrtCondCd = alrtCondCd;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public String getTrsChnlcd() {
		return trsChnlcd;
	}
	public void setTrsChnlcd(String trsChnlcd) {
		this.trsChnlcd = trsChnlcd;
	}
	public String getRcvr() {
		return rcvr;
	}
	public void setRcvr(String rcvr) {
		this.rcvr = rcvr;
	}
	public String getCondValCdNm() {
		return condValCdNm;
	}
	public void setCondValCdNm(String condValCdNm) {
		this.condValCdNm = condValCdNm;
	}
	

}
