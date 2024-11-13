package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;


public class AprvReportNodeResDto {

    private String id;
    private String nodeTypeCd; // ETCOND / ETACT / 채널명
    private String actTaskId;
    private String taskNodeId;
    private String sNode;

    private AprvReportRuleResDto ruleInfo;
    private AprvReportContsResDto chnlInfo;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNodeTypeCd() {
        return nodeTypeCd;
    }

    public void setNodeTypeCd(String nodeTypeCd) {
        this.nodeTypeCd = nodeTypeCd;
    }

    public String getActTaskId() {
        return actTaskId;
    }

    public void setActTaskId(String actTaskId) {
        this.actTaskId = actTaskId;
    }

    public String getTaskNodeId() {
        return taskNodeId;
    }

    public void setTaskNodeId(String taskNodeId) {
        this.taskNodeId = taskNodeId;
    }

    public String getsNode() {
        return sNode;
    }

    public void setsNode(String sNode) {
        this.sNode = sNode;
    }

    public AprvReportRuleResDto getRuleInfo() {
        return ruleInfo;
    }

    public void setRuleInfo(AprvReportRuleResDto ruleInfo) {
        this.ruleInfo = ruleInfo;
    }

    public AprvReportContsResDto getChnlInfo() {
        return chnlInfo;
    }

    public void setChnlInfo(AprvReportContsResDto chnlInfo) {
        this.chnlInfo = chnlInfo;
    }

}
