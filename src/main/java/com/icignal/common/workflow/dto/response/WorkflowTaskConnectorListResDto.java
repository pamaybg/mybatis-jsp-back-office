package com.icignal.common.workflow.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowTaskConnectorListResDto extends StatusResDto {
	
    private String id;    //아이디

    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String taskHeaderId;    //상위아이디
    private String taskConnectorName;    //테스크 커넥터명
    
    private String sourceNode;    //소스노드명
    private String sourcePointX;    //소스포인트X좌표
    private String sourcePointY;    //소스포인트Y좌표
    
    private String targetNode;    //타겟노드명
    private String targetPointX;    //타겟포인트X좌표
    private String targetPointY;    //타겟포인트Y좌표
    
    private String connectorId;    //커넥터아이디
    
    private String paletteType;    //팔레트유형
    private String paletteTypeCode;    //팔레트유형
    private String paletteTypeName;    //팔레트유형
    
    private String segmentType;    //세그먼트유형
    private String segmentTypeCode;    //세그먼트유형
    private String segmentTypeName;    //세그먼트유형

    private String connectorName;    //커넥터명
    private String labelText;    //라벨텍스트
    private String lableReadOnly;    //라벨수정여부
    private String lineColor;    //선색
    private String lineWidth;    //선굵기
    private String lineDashArray;    //선배열
    private String connectorDesc;    //커넥터설명
    
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

    public String getTaskHeaderId() {
        return taskHeaderId;
    }

    public void setTaskHeaderId(String taskHeaderId) {
        this.taskHeaderId = taskHeaderId;
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

    public String getConnectorId() {
        return connectorId;
    }

    public void setConnectorId(String connectorId) {
        this.connectorId = connectorId;
    }

    public String getPaletteType() {
        return paletteType;
    }

    public void setPaletteType(String paletteType) {
        this.paletteType = paletteType;
    }

    public String getPaletteTypeCode() {
        return paletteTypeCode;
    }

    public void setPaletteTypeCode(String paletteTypeCode) {
        this.paletteTypeCode = paletteTypeCode;
    }

    public String getPaletteTypeName() {
        return paletteTypeName;
    }

    public void setPaletteTypeName(String paletteTypeName) {
        this.paletteTypeName = paletteTypeName;
    }

    public String getSegmentType() {
        return segmentType;
    }

    public void setSegmentType(String segmentType) {
        this.segmentType = segmentType;
    }

    public String getSegmentTypeCode() {
        return segmentTypeCode;
    }

    public void setSegmentTypeCode(String segmentTypeCode) {
        this.segmentTypeCode = segmentTypeCode;
    }

    public String getSegmentTypeName() {
        return segmentTypeName;
    }

    public void setSegmentTypeName(String segmentTypeName) {
        this.segmentTypeName = segmentTypeName;
    }

    public String getConnectorName() {
        return connectorName;
    }

    public void setConnectorName(String connectorName) {
        this.connectorName = connectorName;
    }

    public String getLabelText() {
        return labelText;
    }

    public void setLabelText(String labelText) {
        this.labelText = labelText;
    }

    public String getLableReadOnly() {
        return lableReadOnly;
    }

    public void setLableReadOnly(String lableReadOnly) {
        this.lableReadOnly = lableReadOnly;
    }

    public String getLineColor() {
        return lineColor;
    }

    public void setLineColor(String lineColor) {
        this.lineColor = lineColor;
    }

    public String getLineWidth() {
        return lineWidth;
    }

    public void setLineWidth(String lineWidth) {
        this.lineWidth = lineWidth;
    }

    public String getLineDashArray() {
        return lineDashArray;
    }

    public void setLineDashArray(String lineDashArray) {
        this.lineDashArray = lineDashArray;
    }

    public String getConnectorDesc() {
        return connectorDesc;
    }

    public void setConnectorDesc(String connectorDesc) {
        this.connectorDesc = connectorDesc;
    }

	
}
