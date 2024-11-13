package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2015. 11. 24.
 * @author : 안형욱
 * @description : 템플릿 헤더  노드 리스트 조회
 */
public class MktCampaignGetTempNodeListResDto extends GridPagingItemResDto {
	
    private String taskTitle;   	//제목
    private String camTypeCd;   	//캠페인 유형 코드
	private String camTypeCdName;	//캠페인 유형 코드명
    private String taskDesc;    	//설명
    private String tempMstId;		//템플릿 마스터 ID
    private String taskTypeCode;	//작업타입코드
    private String nodeTypeCodeName;//노드타입 유형명
    private String workflowId;      //워크플로우 ID
    private String campaignId;		//캠페인ID
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public String getCamTypeCd() {
		return camTypeCd;
	}

	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}

	public String getTaskDesc() {
		return taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}

	public String getTempMstId() {
		return tempMstId;
	}

	public void setTempMstId(String tempMstId) {
		this.tempMstId = tempMstId;
	}

	public String getTaskTypeCode() {
		return taskTypeCode;
	}

	public void setTaskTypeCode(String taskTypeCode) {
		this.taskTypeCode = taskTypeCode;
	}

	public String getNodeTypeCodeName() {
		return nodeTypeCodeName;
	}

	public void setNodeTypeCodeName(String nodeTypeCodeName) {
		this.nodeTypeCodeName = nodeTypeCodeName;
	}

	public String getCamTypeCdName() {
		return camTypeCdName;
	}

	public void setCamTypeCdName(String camTypeCdName) {
		this.camTypeCdName = camTypeCdName;
	}

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }

	public String getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}
	
	
}
