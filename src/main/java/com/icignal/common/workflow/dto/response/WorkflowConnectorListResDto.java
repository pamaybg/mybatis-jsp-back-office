package com.icignal.common.workflow.dto.response;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowConnectorListResDto extends CommonDataAuthReqDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String paletteType;    //팔레트유형
    private String paletteTypeName;    //팔레트유형명
    private String paletteTypeCode;    //팔레트유형코드
    
    private String segmentType;    //세그먼트유형
    private String segmentTypeName;    //세그먼트유형명
    private String segmentTypeCode;    //세그먼트유형코드
    
    private String connectorName;    //커넥터명
    private String labelText;    //라벨텍스트
    private String labelReadOnly;    //라벨수정여부
    private String lineColor;    //선색
    private String lineWidth;    //선굵기
    private String lineDashArray;    //선배열
    private String seq;    //순서
    private String connectorDesc;    //커넥터 설명
	
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

    public String getPaletteType() {
        return paletteType;
    }

    public void setPaletteType(String paletteType) {
        this.paletteType = paletteType;
    }

    public String getPaletteTypeName() {
        return paletteTypeName;
    }

    public void setPaletteTypeName(String paletteTypeName) {
        this.paletteTypeName = paletteTypeName;
    }

    public String getPaletteTypeCode() {
        return paletteTypeCode;
    }

    public void setPaletteTypeCode(String paletteTypeCode) {
        this.paletteTypeCode = paletteTypeCode;
    }

    public String getSegmentType() {
        return segmentType;
    }

    public void setSegmentType(String segmentType) {
        this.segmentType = segmentType;
    }

    public String getSegmentTypeName() {
        return segmentTypeName;
    }

    public void setSegmentTypeName(String segmentTypeName) {
        this.segmentTypeName = segmentTypeName;
    }

    public String getSegmentTypeCode() {
        return segmentTypeCode;
    }

    public void setSegmentTypeCode(String segmentTypeCode) {
        this.segmentTypeCode = segmentTypeCode;
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

    public String getLabelReadOnly() {
        return labelReadOnly;
    }

    public void setLabelReadOnly(String labelReadOnly) {
        this.labelReadOnly = labelReadOnly;
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

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getConnectorDesc() {
        return connectorDesc;
    }

    public void setConnectorDesc(String connectorDesc) {
        this.connectorDesc = connectorDesc;
    }


	
}
