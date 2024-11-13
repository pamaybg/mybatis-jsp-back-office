package com.icignal.kepler.common.dto.response;

import java.util.List;

/*
 * 1. 클래스명	: KPRNodeListResponseDTO
 * 2. 파일명	: KPRNodeListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprNodeListResDto {
	
	private String nodeId;
	private String nodeText;
	private String parNodeId;
	private String nodeType;
	private Boolean modifyFlag;
	private Boolean expandedFlag;
	private String myFolderFlag;

	private List<KprNodeListResDto> nodeList;

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeText() {
		return nodeText;
	}

	public void setNodeText(String nodeText) {
		this.nodeText = nodeText;
	}

	public String getParNodeId() {
		return parNodeId;
	}

	public void setParNodeId(String parNodeId) {
		this.parNodeId = parNodeId;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public Boolean getModifyFlag() {
		return modifyFlag;
	}

	public void setModifyFlag(Boolean modifyFlag) {
		this.modifyFlag = modifyFlag;
	}

	public Boolean getExpandedFlag() {
		return expandedFlag;
	}

	public void setExpandedFlag(Boolean expandedFlag) {
		this.expandedFlag = expandedFlag;
	}

	public String getMyFolderFlag() {
		return myFolderFlag;
	}

	public void setMyFolderFlag(String myFolderFlag) {
		this.myFolderFlag = myFolderFlag;
	}

	public List<KprNodeListResDto> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<KprNodeListResDto> nodeList) {
		this.nodeList = nodeList;
	}
}