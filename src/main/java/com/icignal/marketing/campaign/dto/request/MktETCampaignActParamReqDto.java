package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : 캠페인 활동값 목록
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktETCampaignActParamReqDto extends MKTBaseReqDto {
	
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
