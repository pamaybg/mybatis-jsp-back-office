package com.icignal.marketing.common.eventTrigger.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : 캠페인 조건값
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktETCampaignActParamResDto {
	
	private String rid;               //RID
	private String ridCamNode;        //RID_CAM_NODE
	private String paramType;
	private String paramNm;
	private String paramVal;
	private String paramDesc;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCamNode() {
		return ridCamNode;
	}

	public void setRidCamNode(String ridCamNode) {
		this.ridCamNode = ridCamNode;
	}

	public String getParamType() {
		return paramType;
	}

	public void setParamType(String paramType) {
		this.paramType = paramType;
	}

	public String getParamNm() {
		return paramNm;
	}

	public void setParamNm(String paramNm) {
		this.paramNm = paramNm;
	}

	public String getParamVal() {
		return paramVal;
	}

	public void setParamVal(String paramVal) {
		this.paramVal = paramVal;
	}

	public String getParamDesc() {
		return paramDesc;
	}

	public void setParamDesc(String paramDesc) {
		this.paramDesc = paramDesc;
	}
}
