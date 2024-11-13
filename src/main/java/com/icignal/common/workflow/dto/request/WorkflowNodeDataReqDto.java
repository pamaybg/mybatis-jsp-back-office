package com.icignal.common.workflow.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowNodeDataReqDto extends CommonDataAuthReqDto {
	
    //노드 또는 커넥터의 아이디
    private String id;
    //노드명 또는 커넥터명
    private String name;
    //객체유형
    private String type;
    //task load시 task 아이디
    private String taskId;
    //테스크 유형 : 업무유형
    private String taskType;
    //노드에 연결되 소스 노드
    private String sourceNode;
    //데이터
    private WorkflowDataReqDto data;
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }

    public String getSourceNode() {
        return sourceNode;
    }

    public void setSourceNode(String sourceNode) {
        this.sourceNode = sourceNode;
    }

    public WorkflowDataReqDto getData() {
        return data;
    }

    public void setData(WorkflowDataReqDto data) {
        this.data = data;
    }


}
