package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2016. 11. 16.
 * @author : dg.ryu
 * @description : et function 목록
 */
public class MktETFunctionListReqDto extends CommonDataAuthReqDto {
	
	private String nodeTypeCd;       //노드 유형 코드
	private String subTypeCd;		  //서브 유형 코드
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getNodeTypeCd() {
		return nodeTypeCd;
	}

	public void setNodeTypeCd(String nodeTypeCd) {
		this.nodeTypeCd = nodeTypeCd;
	}

	public String getSubTypeCd() {
		return subTypeCd;
	}

	public void setSubTypeCd(String subTypeCd) {
		this.subTypeCd = subTypeCd;
	}
}