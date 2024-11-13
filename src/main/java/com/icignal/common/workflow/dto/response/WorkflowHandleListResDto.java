package com.icignal.common.workflow.dto.response;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 
 */
public class WorkflowHandleListResDto extends GridPagingItemResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String nodeId;    //노드아이디
    private String handleName;    //핸들명
    
    private String positionType;    //위치
    private String positionTypeName;    //위치명
    private String positionTypeCode;    //위치코드
    
    private String size;    //크기
    private String backgroundColor;    //바탕색
    private String enableMultiSelection;    //다중선택 가능여부
    
    private String imagePathData;    //핸들이미지 데이터
    private String method;    //메서드
    
    private String methodType;    //메서드유형
    private String methodTypeName;    //메서드유형
    private String methodTypeCode;    //메서드유형
    
    private String handleDesc;    //핸들설명 
    
    private String seq;    //순서
	
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

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getHandleName() {
        return handleName;
    }

    public void setHandleName(String handleName) {
        this.handleName = handleName;
    }

    public String getPositionType() {
        return positionType;
    }

    public void setPositionType(String positionType) {
        this.positionType = positionType;
    }

    public String getPositionTypeName() {
        return positionTypeName;
    }

    public void setPositionTypeName(String positionTypeName) {
        this.positionTypeName = positionTypeName;
    }

    public String getPositionTypeCode() {
        return positionTypeCode;
    }

    public void setPositionTypeCode(String positionTypeCode) {
        this.positionTypeCode = positionTypeCode;
    }



    public String getBackgroundColor() {
        return backgroundColor;
    }

    public void setBackgroundColor(String backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public String getEnableMultiSelection() {
        return enableMultiSelection;
    }

    public void setEnableMultiSelection(String enableMultiSelection) {
        this.enableMultiSelection = enableMultiSelection;
    }

    public String getImagePathData() {
        return imagePathData;
    }

    public void setImagePathData(String imagePathData) {
        this.imagePathData = imagePathData;
    }

  
    public String getMethodType() {
        return methodType;
    }

    public void setMethodType(String methodType) {
        this.methodType = methodType;
    }

    public String getMethodTypeName() {
        return methodTypeName;
    }

    public void setMethodTypeName(String methodTypeName) {
        this.methodTypeName = methodTypeName;
    }

    public String getMethodTypeCode() {
        return methodTypeCode;
    }

    public void setMethodTypeCode(String methodTypeCode) {
        this.methodTypeCode = methodTypeCode;
    }


	public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getHandleDesc() {
        return handleDesc;
    }

    public void setHandleDesc(String handleDesc) {
        this.handleDesc = handleDesc;
    }

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}
	
}
