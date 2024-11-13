package com.icignal.marketing.common.eventTrigger.dto.response;

import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNEventTriggerResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 트리거
 */
public class MktEventTriggerCamResultResDto extends StatusResDto {
	
	private String ruleNo;
	
	private Map<String, Object> data;
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


	public String getRuleNo() {
		return ruleNo;
	}

	public void setRuleNo(String ruleNo) {
		this.ruleNo = ruleNo;
	}


	public Map<String, Object> getData() {
		return data;
	}


	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
