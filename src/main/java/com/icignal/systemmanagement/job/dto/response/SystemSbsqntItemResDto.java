package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemSbsqntItemResDto extends GridPagingItemResDto {

	private String rid;
	private String sbsqntJobNm;
	private String activeYn;
	private String execCondCd;
	@MarkName(groupCode = "BAT_JOB_COND_VAL", codeField = "condValCdNm")
	private String condVal;
	private String condValCdNm;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSbsqntJobNm() {
		return sbsqntJobNm;
	}
	public void setSbsqntJobNm(String sbsqntJobNm) {
		this.sbsqntJobNm = sbsqntJobNm;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public String getExecCondCd() {
		return execCondCd;
	}
	public void setExecCondCd(String execCondCd) {
		this.execCondCd = execCondCd;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public String getCondValCdNm() {
		return condValCdNm;
	}
	public void setCondValCdNm(String condValCdNm) {
		this.condValCdNm = condValCdNm;
	}
	
}
