package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : MktCampaignWorkflowStatusDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 워크플로우 진행현황 ReqDto
 */
public class MktCampaignWorkflowStatusReqDto extends MKTBaseReqDto {
    
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시

    private String campaignId;    //캠페인ID
    private String workflowId;    //워크플로우 기준 ID
    
    private String taskId;    //테스크아이디
    private String taskName;    //테스크 명
    private String taskTypeCode;    //테스크유형
    private String taskDesc;    //테스크 설명
    
    private String statusCode;    //상태
    
    private String actualTaskId;    //실제업무 ID
    
    private String parTaskId;		//상위 테스크아이디
    private String cnctrTypeCd;		//커넥터 유형코드
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getTaskTypeCode() {
        return taskTypeCode;
    }

    public void setTaskTypeCode(String taskTypeCode) {
        this.taskTypeCode = taskTypeCode;
    }

    public String getTaskDesc() {
        return taskDesc;
    }

    public void setTaskDesc(String taskDesc) {
        this.taskDesc = taskDesc;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getActualTaskId() {
        return actualTaskId;
    }

    public void setActualTaskId(String actualTaskId) {
        this.actualTaskId = actualTaskId;
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

}
