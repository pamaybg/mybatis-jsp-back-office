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
public class WorkflowTaskHeaderReqDto extends CommonDataAuthReqDto {
    
    private String id;    //아이디

    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String workflowDispNo;    //표시값
    
    private String workflowName;    //워크플로우명
    private String workflowDescText;    //워크플로우개요
    
    private String parentId;    //상위아이디
    
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

    public String getWorkflowDispNo() {
        return workflowDispNo;
    }

    public void setWorkflowDispNo(String workflowDispNo) {
        this.workflowDispNo = workflowDispNo;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }



   	
}
