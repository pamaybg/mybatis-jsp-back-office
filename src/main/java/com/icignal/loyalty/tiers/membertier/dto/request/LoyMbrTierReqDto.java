package com.icignal.loyalty.tiers.membertier.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class LoyMbrTierReqDto extends MKTGridPagingReqDto {
	
	private String rid;
	
	private String ridMbr;
	
	private String desc;
	
	private String rst;
	
	private String rstCd;
	
	private String rstMsg;
		
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getRst() {
		return rst;
	}

	public void setRst(String rst) {
		this.rst = rst;
	}

	public String getRstCd() {
		return rstCd;
	}

	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}

	public String getRstMsg() {
		return rstMsg;
	}

	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}