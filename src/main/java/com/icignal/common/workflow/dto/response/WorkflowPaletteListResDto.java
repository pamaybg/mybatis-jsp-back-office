package com.icignal.common.workflow.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 5.
 * @author : 류동균
 * @description : 
 */
public class WorkflowPaletteListResDto extends StatusResDto {
	
    private String id;    //아이디
    
    private String paletteType;    //팔레트유형
    private String paletteTypeCode;    //팔레트유형
    private String paletteTypeName;    //팔레트유형
    
    private List<WorkflowNodeListResDto> nodeList;    //노드목록
    private List<WorkflowConnectorListResDto> connectorList;    //커넥터목록
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public List<WorkflowNodeListResDto> getNodeList() {
        return nodeList;
    }

    public void setNodeList(List<WorkflowNodeListResDto> nodeList) {
        this.nodeList = nodeList;
    }

    public List<WorkflowConnectorListResDto> getConnectorList() {
        return connectorList;
    }

    public void setConnectorList(List<WorkflowConnectorListResDto> connectorList) {
        this.connectorList = connectorList;
    }



	
}
