package com.icignal.marketing.common.eventTrigger.dto.response;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNEventNodeResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 노드
 */
public class MktEventNodeResDto extends StatusResDto {

	private String id;     			//아이디
    private String nodeTypeCd;		//노드유형코드
    private String actTaskId;		//업무 아이디
    private String taskNodeId;		//소스노드 아이디
    private Boolean firstNodeFlag;
    private String parTaskId;
    private String cnctrTypeCd;
    private String taskId;
    private Map<String, Object> data;
    
    private List<MktEventNodeResDto> childEventNodeList;		//하위 이벤트노드 목록
   
    
    public MktEventNodeResDto() {
    	firstNodeFlag = false;
    }
    
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

	public List<MktEventNodeResDto> getChildEventNodeList() {
		return childEventNodeList;
	}

	public void setChildEventNodeList(List<MktEventNodeResDto> childEventNodeList) {
		this.childEventNodeList = childEventNodeList;
	}

	public String getTaskNodeId() {
		return taskNodeId;
	}

	public void setTaskNodeId(String taskNodeId) {
		this.taskNodeId = taskNodeId;
	}

	public Boolean getFirstNodeFlag() {
		return firstNodeFlag;
	}

	public void setFirstNodeFlag(Boolean firstNodeFlag) {
		this.firstNodeFlag = firstNodeFlag;
	}

	public String getParTaskId() {
		return parTaskId;
	}

	public void setParTaskId(String parTaskId) {
		this.parTaskId = parTaskId;
	}

	public String getCnctrTypeCd() {
		return cnctrTypeCd;
	}

	public void setCnctrTypeCd(String cnctrTypeCd) {
		this.cnctrTypeCd = cnctrTypeCd;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
