package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRNodeDetailRequestDTO
 * 2. 파일명	: KPRNodeDetailRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprNodeDetailReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String nodeId;
	private String nodeText;
	private String parNodeId;
	private String myFolderFlag;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

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

	public String getMyFolderFlag() {
		return myFolderFlag;
	}

	public void setMyFolderFlag(String myFolderFlag) {
		this.myFolderFlag = myFolderFlag;
	}
}