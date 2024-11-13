package com.icignal.loyalty.promotion.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskReqDto;



/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 10. 16.
 * @author : 류동균
 * @description : 캠페인 워크플로우
 */
public class LoyCampaignWorkflowReqDto extends CommonDataAuthReqDto {
	
    private String id;            //아이디
    private String workflowId;    //워크플로우아이디
    private String campaignId;    //캠페인아이디
    private String statusCode;    //상태
    private String saveType;      //저장유형
  
    private List<LoyCampaignWorkflowNodeDataReqDto> nodeList;    //node 목록
    
    private WorkflowTaskReqDto workflowTask;		//task
    
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<LoyCampaignWorkflowNodeDataReqDto> getNodeList() {
        return nodeList;
    }

    public void setNodeList(List<LoyCampaignWorkflowNodeDataReqDto> nodeList) {
        this.nodeList = nodeList;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }

    public String getSaveType() {
        return saveType;
    }

    public void setSaveType(String saveType) {
        this.saveType = saveType;
    }

    public WorkflowTaskReqDto getWorkflowTask() {
        return workflowTask;
    }

    public void setWorkflowTask(WorkflowTaskReqDto workflowTask) {
        this.workflowTask = workflowTask;
    }


	
}
