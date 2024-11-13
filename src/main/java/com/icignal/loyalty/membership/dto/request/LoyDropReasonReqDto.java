package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class LoyDropReasonReqDto extends MKTBaseReqDto {
	private String rid;
	private String reasonData;
	private String ridMbr;
    private String pnt ;
    private String srgMbr;
    private String tgtMbr;
	private String dropReason;
    
	
	public String getDropReason() {
		return dropReason;
	}
	public void setDropReason(String dropReason) {
		this.dropReason = dropReason;
	}
	public String getPnt() {
		return pnt;
	}
	public void setPnt(String pnt) {
		this.pnt = pnt;
	}
	public String getSrgMbr() {
		return srgMbr;
	}
	public void setSrgMbr(String srgMbr) {
		this.srgMbr = srgMbr;
	}
	public String getTgtMbr() {
		return tgtMbr;
	}
	public void setTgtMbr(String tgtMbr) {
		this.tgtMbr = tgtMbr;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getReasonData() {
		return reasonData;
	}
	public void setReasonData(String reasonData) {
		this.reasonData = reasonData;
	}

}
