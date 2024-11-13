package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.*;

@CommCode
public class LoyCustSettleResDto extends GridPagingItemResDto {

	private String rid;
	private String stlCycleCd;
	@MarkName(groupCode="LOY_SETTLE_CYCLE_CD", codeField="stlCycleCd")
	private String stlCycleCdNm;
	private String shaChnlCd;
	@MarkName(groupCode="LOY_SETTLE_SHR_CHNL_CD", codeField="shaChnlCd")
	private String shaChnlCdNm;
	private String chnlShaRate;
	private String ridMbrC;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getStlCycleCd() {
		return stlCycleCd;
	}

	public void setStlCycleCd(String stlCycleCd) {
		this.stlCycleCd = stlCycleCd;
	}

	public String getStlCycleCdNm() {
		return stlCycleCdNm;
	}

	public void setStlCycleCdNm(String stlCycleCdNm) {
		this.stlCycleCdNm = stlCycleCdNm;
	}

	public String getShaChnlCd() {
		return shaChnlCd;
	}

	public void setShaChnlCd(String shaChnlCd) {
		this.shaChnlCd = shaChnlCd;
	}

	public String getShaChnlCdNm() {
		return shaChnlCdNm;
	}

	public void setShaChnlCdNm(String shaChnlCdNm) {
		this.shaChnlCdNm = shaChnlCdNm;
	}

	public String getChnlShaRate() {
		return chnlShaRate;
	}

	public void setChnlShaRate(String chnlShaRate) {
		this.chnlShaRate = chnlShaRate;
	}

	public String getRidMbrC() {
		return ridMbrC;
	}

	public void setRidMbrC(String ridMbrC) {
		this.ridMbrC = ridMbrC;
	}
}
