package com.icignal.systemmanagement.worddictionary.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemWordDictionaryReqDto
 * 2. 파일명	: SystemWordDictionaryReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.worddictionary.dto.request
 * 4. 작성자명	: seungjun
 * 5. 작성일자	: 2020. 4. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *	
 * </PRE>
 */ 
public class SystemWordDictionaryReqDto extends CommonDataAuthReqDto {
	
	private String id;
	
	private String rid;
	private String logicalName;
	private String physicalName;
	private String logicalDesc;
	private String physicalDesc;
	private String logicalSynonm;
	private String physicalSynonm;
	private String tag;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getLogicalName() {
		return logicalName;
	}

	public void setLogicalName(String logicalName) {
		this.logicalName = logicalName;
	}

	public String getPhysicalName() {
		return physicalName;
	}

	public void setPhysicalName(String physicalName) {
		this.physicalName = physicalName;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getLogicalDesc() {
		return logicalDesc;
	}

	public void setLogicalDesc(String logicalDesc) {
		this.logicalDesc = logicalDesc;
	}

	public String getPhysicalDesc() {
		return physicalDesc;
	}

	public void setPhysicalDesc(String physicalDesc) {
		this.physicalDesc = physicalDesc;
	}

	public String getLogicalSynonm() {
		return logicalSynonm;
	}

	public void setLogicalSynonm(String logicalSynonm) {
		this.logicalSynonm = logicalSynonm;
	}

	public String getPhysicalSynonm() {
		return physicalSynonm;
	}

	public void setPhysicalSynonm(String physicalSynonm) {
		this.physicalSynonm = physicalSynonm;
	}
	
}
