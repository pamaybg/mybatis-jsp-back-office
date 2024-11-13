package com.icignal.onlineapproval.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 승인을 위한 캠페인 전체 정보 조회 Request DTO
 * 
 * @name : infavor.marketing.elapproval.dto.request.MKTApprovalReportRequestDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description :
 */
public class AprvReportReqDto extends CommonDataAuthReqDto {

    private String campaingId; // 캠페인ID
    
    /** 컨텐츠 조회시 필요 */
    private String contsId;    // 컨텐츠ID
    
    /** 노드 조회시 필요 */
    private String taskNodeId; // 상위노드ID
    
    private String actTaskId;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getActTaskId() {
        return actTaskId;
    }

    public void setActTaskId(String actTaskId) {
        this.actTaskId = actTaskId;
    }

    public String getCampaingId() {
        return campaingId;
    }

    public void setCampaingId(String campaingId) {
        this.campaingId = campaingId;
    }

    public String getContsId() {
        return contsId;
    }

    public void setContsId(String contsId) {
        this.contsId = contsId;
    }

    public String getTaskNodeId() {
        return taskNodeId;
    }

    public void setTaskNodeId(String taskNodeId) {
        this.taskNodeId = taskNodeId;
    }
}
