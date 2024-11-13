package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : 
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : 캠페인 Wait
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignWaitReqDto extends MKTBaseReqDto {
	
	private String id;
	private String camId;
	private String exeDt;
	private String exeTm;
	private String tgtTypeCd;
	private String tgtDtlTypeCd;
	private int tgtCnt;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getExeDt() {
		return exeDt;
	}

	public void setExeDt(String exeDt) {
		this.exeDt = exeDt;
	}

	public String getExeTm() {
		return exeTm;
	}

	public void setExeTm(String exeTm) {
		this.exeTm = exeTm;
	}

	public String getTgtTypeCd() {
		return tgtTypeCd;
	}

	public void setTgtTypeCd(String tgtTypeCd) {
		this.tgtTypeCd = tgtTypeCd;
	}

	public String getTgtDtlTypeCd() {
		return tgtDtlTypeCd;
	}

	public void setTgtDtlTypeCd(String tgtDtlTypeCd) {
		this.tgtDtlTypeCd = tgtDtlTypeCd;
	}

	public int getTgtCnt() {
		return tgtCnt;
	}

	public void setTgtCnt(int tgtCnt) {
		this.tgtCnt = tgtCnt;
	}
}
