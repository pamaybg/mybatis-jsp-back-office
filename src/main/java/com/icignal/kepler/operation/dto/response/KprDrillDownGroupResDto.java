package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class KprDrillDownGroupResDto extends StatusResDto {
	
	private String nodeId;
	private String nodeName;
	private String nodeParentId;
	private String nodeType;
	private Integer nodeLevel;
	private String serviceId;
	private String serviceName;

	private String tableId;
	private String tableColumnId;
	private String drillDownGroupId;

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeParentId() {
		return nodeParentId;
	}

	public void setNodeParentId(String nodeParentId) {
		this.nodeParentId = nodeParentId;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public Integer getNodeLevel() {
		return nodeLevel;
	}

	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getTableColumnId() {
		return tableColumnId;
	}

	public void setTableColumnId(String tableColumnId) {
		this.tableColumnId = tableColumnId;
	}

	public String getDrillDownGroupId() {
		return drillDownGroupId;
	}

	public void setDrillDownGroupId(String drillDownGroupId) {
		this.drillDownGroupId = drillDownGroupId;
	}
}