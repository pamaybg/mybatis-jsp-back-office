package com.icignal.common.workflow.dto.response;


import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.CommCode;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */

@CommCode
public class WorkflowNodeListResDto extends StatusResDto {
	
    private String id;    //아이디
    
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String paletteType;    //팔레트유형
    private String paletteTypeCode;    //팔레트유형코드
    private String paletteTypeName;    //팔레트유형명
    
    private String shapeType;    //쉐잉프유형
    private String shapeTypeCode;    //쉐잉프유형코드
    private String shapeTypeName;    //쉐잉프유형명
    
    private String nodeType;    //노드유형
    private String nodeTypeCode;    //노드유형코드
    private String nodeTypeName;    //노드유형명
    
    private String nodeName;    //노드명
    
    private String htmlTemplateId;    //템플릿아이디
    private String imageSource;    //이미지소스
    private String labelText;    //라벨텍스트
    private String labelReadOnly;    //라벨수정여부
    private String width;    //너비
    private String height;    //높이
    private String borderColor;    //선색
    private String borderWidth;    //선굵기
    private String fillColor;    //바탕색
    private String points;    //도형연결점
    
    private String nodeDesc;    //노드설명 
    
    private String actYn;    //활성여부
    private String imagePathData;    //image path data
    
    private String seq;    //순서
    private String connectSeq;    //연결순서
    
    private List<WorkflowHandleListResDto> handleList;    //핸들 목록
	
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

    public String getShapeType() {
        return shapeType;
    }

    public void setShapeType(String shapeType) {
        this.shapeType = shapeType;
    }

    public String getShapeTypeCode() {
        return shapeTypeCode;
    }

    public void setShapeTypeCode(String shapeTypeCode) {
        this.shapeTypeCode = shapeTypeCode;
    }

    public String getShapeTypeName() {
        return shapeTypeName;
    }

    public void setShapeTypeName(String shapeTypeName) {
        this.shapeTypeName = shapeTypeName;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getHtmlTemplateId() {
        return htmlTemplateId;
    }

    public void setHtmlTemplateId(String htmlTemplateId) {
        this.htmlTemplateId = htmlTemplateId;
    }

    public String getImageSource() {
        return imageSource;
    }

    public void setImageSource(String imageSource) {
        this.imageSource = imageSource;
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

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getBorderColor() {
        return borderColor;
    }

    public void setBorderColor(String borderColor) {
        this.borderColor = borderColor;
    }

    public String getBorderWidth() {
        return borderWidth;
    }

    public void setBorderWidth(String borderWidth) {
        this.borderWidth = borderWidth;
    }

    public String getFillColor() {
        return fillColor;
    }

    public void setFillColor(String fillColor) {
        this.fillColor = fillColor;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }

    public String getActYn() {
        return actYn;
    }

    public void setActYn(String actYn) {
        this.actYn = actYn;
    }

    public String getImagePathData() {
        return imagePathData;
    }

    public void setImagePathData(String imagePathData) {
        this.imagePathData = imagePathData;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public List<WorkflowHandleListResDto> getHandleList() {
        return handleList;
    }

    public void setHandleList(List<WorkflowHandleListResDto> handleList) {
        this.handleList = handleList;
    }

    public String getNodeDesc() {
        return nodeDesc;
    }

    public void setNodeDesc(String nodeDesc) {
        this.nodeDesc = nodeDesc;
    }

    public String getNodeType() {
        return nodeType;
    }

    public void setNodeType(String nodeType) {
        this.nodeType = nodeType;
    }

    public String getNodeTypeCode() {
        return nodeTypeCode;
    }

    public void setNodeTypeCode(String nodeTypeCode) {
        this.nodeTypeCode = nodeTypeCode;
    }

    public String getNodeTypeName() {
        return nodeTypeName;
    }

    public void setNodeTypeName(String nodeTypeName) {
        this.nodeTypeName = nodeTypeName;
    }

    public String getConnectSeq() {
        return connectSeq;
    }

    public void setConnectSeq(String connectSeq) {
        this.connectSeq = connectSeq;
    }

}
