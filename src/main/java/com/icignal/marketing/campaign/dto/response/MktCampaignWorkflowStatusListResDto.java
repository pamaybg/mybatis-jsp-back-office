package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2015. 10. 19.
 * @author : 류동균
 * @description : 
 */
public class MktCampaignWorkflowStatusListResDto extends StatusResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시

    private String campaignId;    //캠페인ID
    private String workflowId;    //워크플로우 기준 ID
    
    private String statusCode;    //테스크 진행 현황코드
    private String statusCodeName;    //테스크 진행 현황명
    
    private String taskId;    //테스크아이디
    private String taskName;    //테스크 명
    private String taskDesc;    //테스크 설명
    
    private String taskTypeCode;    //테스크유형
    private String taskTypeCodeName;    //테스크유형명
    
    private String nodeTypeCode;    //테스크유형
    private String nodeTypeCodeName;    //테스크유형명
    
    private String title;   //제목
    private String text;   //내용
    private String enterTime;   //입력시간
    
    private String actualTaskId;    //실제업무 ID;
    
    private MktCampaignWorkflowDataResDto data;
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
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

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskDesc() {
        return taskDesc;
    }

    public void setTaskDesc(String taskDesc) {
        this.taskDesc = taskDesc;
    }

    public String getTaskTypeCode() {
        return taskTypeCode;
    }

    public void setTaskTypeCode(String taskTypeCode) {
        this.taskTypeCode = taskTypeCode;
    }

    public String getTaskTypeCodeName() {
        return taskTypeCodeName;
    }

    public void setTaskTypeCodeName(String taskTypeCodeName) {
        this.taskTypeCodeName = taskTypeCodeName;
    }

    public MktCampaignWorkflowDataResDto getData() {
        return data;
    }

    public void setData(MktCampaignWorkflowDataResDto data) {
        this.data = data;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getEnterTime() {
        return enterTime;
    }

    public void setEnterTime(String enterTime) {
        this.enterTime = enterTime;
    }

    public String getNodeTypeCode() {
        return nodeTypeCode;
    }

    public void setNodeTypeCode(String nodeTypeCode) {
        this.nodeTypeCode = nodeTypeCode;
    }

    public String getNodeTypeCodeName() {
        return nodeTypeCodeName;
    }

    public void setNodeTypeCodeName(String nodeTypeCodeName) {
        this.nodeTypeCodeName = nodeTypeCodeName;
    }

    public String getActualTaskId() {
        return actualTaskId;
    }

    public void setActualTaskId(String actualTaskId) {
        this.actualTaskId = actualTaskId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

}
