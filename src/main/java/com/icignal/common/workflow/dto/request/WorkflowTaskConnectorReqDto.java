package com.icignal.common.workflow.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.request
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowTaskConnectorReqDto extends CommonDataAuthReqDto {
	
    private String id;    //아이디

    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String taskHeaderId;    //상위아이디
    private String connectorId;    //노드아이디
    private String taskConnectorName;    //테스크 커넥터명
    private String sourceNode;    //소스노드명
    private String sourcePointX;    //소스포인트X좌표
    private String sourcePointY;    //소스포인트Y좌표
    private String targetNode;    //타겟노드명
    private String targetPointX;    //타겟포인트X좌표
    private String targetPointY;    //타겟포인트Y좌표
    
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

    public String getTaskHeaderId() {
        return taskHeaderId;
    }

    public void setTaskHeaderId(String taskHeaderId) {
        this.taskHeaderId = taskHeaderId;
    }

    public String getConnectorId() {
        return connectorId;
    }

    public void setConnectorId(String connectorId) {
        this.connectorId = connectorId;
    }

    public String getTaskConnectorName() {
        return taskConnectorName;
    }

    public void setTaskConnectorName(String taskConnectorName) {
        this.taskConnectorName = taskConnectorName;
    }

    public String getSourceNode() {
        return sourceNode;
    }

    public void setSourceNode(String sourceNode) {
        this.sourceNode = sourceNode;
    }

    public String getSourcePointX() {
        return sourcePointX;
    }

    public void setSourcePointX(String sourcePointX) {
        this.sourcePointX = sourcePointX;
    }

    public String getSourcePointY() {
        return sourcePointY;
    }

    public void setSourcePointY(String sourcePointY) {
        this.sourcePointY = sourcePointY;
    }

    public String getTargetNode() {
        return targetNode;
    }

    public void setTargetNode(String targetNode) {
        this.targetNode = targetNode;
    }

    public String getTargetPointX() {
        return targetPointX;
    }

    public void setTargetPointX(String targetPointX) {
        this.targetPointX = targetPointX;
    }

    public String getTargetPointY() {
        return targetPointY;
    }

    public void setTargetPointY(String targetPointY) {
        this.targetPointY = targetPointY;
    }

}
