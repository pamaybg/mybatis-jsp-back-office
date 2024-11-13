package com.icignal.marketing.common.eventTrigger.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNEventNodeRequestDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 노드
 */
public class MktEventNodeReqDto extends MKTBaseReqDto {

	private String id;     			//아이디
    private String nodeTypeCd;		//노드유형코드
    private String actTaskId;		//업무 아이디
   
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

	public String getNodeTypeCd() {
		return nodeTypeCd;
	}

	public void setNodeTypeCd(String nodeTypeCd) {
		this.nodeTypeCd = nodeTypeCd;
	}

	public String getActTaskId() {
		return actTaskId;
	}

	public void setActTaskId(String actTaskId) {
		this.actTaskId = actTaskId;
	}

}
