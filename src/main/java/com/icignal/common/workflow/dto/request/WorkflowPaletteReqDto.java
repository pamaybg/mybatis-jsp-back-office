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
public class WorkflowPaletteReqDto extends CommonDataAuthReqDto {
	
    
    private String id;    //아이디
    
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String paletteType;    //팔레트유형
    private String shapeType;    //쉐잉프유형
    private String shapeName;    //쉐이프명
    private String nodeId;    //노드아이디
    
    private String segmentsType;    //세그먼트유형
    private String connectorName;    //커넥터명
    
    private String actYn;    //활성여부
    
    private String type; //팔레트 사용처 구분 (ex)MKT,SCR...)
	
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

    public String getPaletteType() {
        return paletteType;
    }

    public void setPaletteType(String paletteType) {
        this.paletteType = paletteType;
    }

    public String getShapeType() {
        return shapeType;
    }

    public void setShapeType(String shapeType) {
        this.shapeType = shapeType;
    }

    public String getShapeName() {
        return shapeName;
    }

    public void setShapeName(String shapeName) {
        this.shapeName = shapeName;
    }

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getSegmentsType() {
        return segmentsType;
    }

    public void setSegmentsType(String segmentsType) {
        this.segmentsType = segmentsType;
    }

    public String getConnectorName() {
        return connectorName;
    }

    public void setConnectorName(String connectorName) {
        this.connectorName = connectorName;
    }

    public String getActYn() {
        return actYn;
    }

    public void setActYn(String actYn) {
        this.actYn = actYn;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

   	
}
