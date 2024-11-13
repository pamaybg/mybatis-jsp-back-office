package com.icignal.marketing.common.eventTrigger.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNEventTriggerResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 트리거
 */
public class MktEventTriggerResDto extends StatusResDto {
	
	private List<MktEventTriggerCamResultResDto> resultList;
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public List<MktEventTriggerCamResultResDto> getResultList() {
		return resultList;
	}

	public void setResultList(List<MktEventTriggerCamResultResDto> resultList) {
		this.resultList = resultList;
	}
}
