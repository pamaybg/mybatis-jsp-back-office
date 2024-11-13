package com.icignal.common.workflow.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.request
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowTaskReqDto extends CommonDataAuthReqDto {

    private String id;    //아이디
    
    private String workflowName;    //워크플로우명
    private String workflowDescText;    //워크플로우개요
    
    private String parentId;    //상위아이디
    
    private List<WorkflowTaskNodeReqDto> nodeList;    //노드목록
    private List<WorkflowTaskConnectorReqDto> connectorList;    //커넥터목록
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<WorkflowTaskNodeReqDto> getNodeList() {
        return nodeList;
    }

    public void setNodeList(List<WorkflowTaskNodeReqDto> nodeList) {
        this.nodeList = nodeList;
    }

    public List<WorkflowTaskConnectorReqDto> getConnectorList() {
        return connectorList;
    }

    public void setConnectorList(List<WorkflowTaskConnectorReqDto> connectorList) {
        this.connectorList = connectorList;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWorkflowName() {
        return workflowName;
    }

    public void setWorkflowName(String workflowName) {
        this.workflowName = workflowName;
    }

    public String getWorkflowDescText() {
        return workflowDescText;
    }

    public void setWorkflowDescText(String workflowDescText) {
        this.workflowDescText = workflowDescText;
    }
	
}
