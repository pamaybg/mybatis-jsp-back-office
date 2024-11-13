package com.icignal.loyalty.promotion.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignWorkflowNodeDataReqDto extends CommonDataAuthReqDto {
	
    //노드 또는 커넥터의 아이디
    private String nodeId;
    //노드명 또는 커넥터명
    private String nodeName;
    //객체유형
    private String nodeType;
    //task load시 task 아이디
    private String taskId;
    //테스크 유형 : 업무유형
    private String taskType;
    //노드에 연결된 소스 노드
    private String sourceNode;
    //task 데이터 상태
    private String taskDataStatus;
    //실제업무 ID
    private String actualTaskId;
    //캠페인 ID
    private String campaignId;
    //이전 캠페인 ID
    private String oldCampaignId;
    //캠페인 워크플로우 관계 ID
    private String campaignWfRelId;
    
    private LoyCampaignWorkflowDataReqDto data;    //node data
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getNodeId() {
        return nodeId;
    }
    
    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getNodeType() {
        return nodeType;
    }

    public void setNodeType(String nodeType) {
        this.nodeType = nodeType;
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

    public LoyCampaignWorkflowDataReqDto getData() {
        return data;
    }

    public void setData(LoyCampaignWorkflowDataReqDto data) {
        this.data = data;
    }

    public String getTaskDataStatus() {
        return taskDataStatus;
    }

    public void setTaskDataStatus(String taskDataStatus) {
        this.taskDataStatus = taskDataStatus;
    }

    public String getActualTaskId() {
        return actualTaskId;
    }

    public void setActualTaskId(String actualTaskId) {
        this.actualTaskId = actualTaskId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getOldCampaignId() {
        return oldCampaignId;
    }

    public void setOldCampaignId(String oldCampaignId) {
        this.oldCampaignId = oldCampaignId;
    }

    public String getCampaignWfRelId() {
        return campaignWfRelId;
    }

    public void setCampaignWfRelId(String campaignWfRelId) {
        this.campaignWfRelId = campaignWfRelId;
    }

}
