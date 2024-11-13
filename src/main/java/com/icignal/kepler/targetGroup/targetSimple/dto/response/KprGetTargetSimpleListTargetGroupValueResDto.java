package com.icignal.kepler.targetGroup.targetSimple.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListTargetGroupValueResDto extends MKTBaseReqDto {
	
	private String id;
	private String compOper;
	private String compVal;
	private String lgcFldId;
	private String sumYn;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCompOper() {
		return compOper;
	}
	public void setCompOper(String compOper) {
		this.compOper = compOper;
	}
	public String getCompVal() {
		return compVal;
	}
	public void setCompVal(String compVal) {
		this.compVal = compVal;
	}
	public String getLgcFldId() {
		return lgcFldId;
	}
	public void setLgcFldId(String lgcFldId) {
		this.lgcFldId = lgcFldId;
	}

	public String getSumYn() {
		return sumYn;
	}

	public void setSumYn(String sumYn) {
		this.sumYn = sumYn;
	}
}
