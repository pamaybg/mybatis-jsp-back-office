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
public class WorkflowTaskNodeReqDto extends CommonDataAuthReqDto {
    
    private String id;    //아이디

    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String taskHeaderId;    //상위아이디
    private String nodeId;    //노드아이디
    private String taskNodeName;    //노드명
    private String offSetX;    //X좌표
    private String offSetY;    //Y좌표
    
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

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getTaskNodeName() {
        return taskNodeName;
    }

    public void setTaskNodeName(String taskNodeName) {
        this.taskNodeName = taskNodeName;
    }

    public String getOffSetX() {
        return offSetX;
    }

    public void setOffSetX(String offSetX) {
        this.offSetX = offSetX;
    }

    public String getOffSetY() {
        return offSetY;
    }

    public void setOffSetY(String offSetY) {
        this.offSetY = offSetY;
    }
}
