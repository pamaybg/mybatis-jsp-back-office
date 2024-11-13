package com.icignal.systemmanagement.worddictionary.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemWordDictionaryResDto
 * 2. 파일명	: SystemWordDictionaryResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.worddictionary.dto.response
 * 4. 작성자명	: seungjun
 * 5. 작성일자	: 2020. 4. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *	
 * </PRE>
 */ 
public class SystemWordDictionaryResDto extends GridPagingItemResDto{
	
	private String rid;
	private String logicalName; 
	private String logicalDesc;
	private String physicalName;
	private String physicalDesc;
	private String tag;
	private String logicalSynonm;
	private String physicalSynonm;
	private int cnt;
	
	
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
	public String getLogicalDesc() {
		return logicalDesc;
	}
	public void setLogicalDesc(String logicalDesc) {
		this.logicalDesc = logicalDesc;
	}
	public String getPhysicalName() {
		return physicalName;
	}
	public void setPhysicalName(String physicalName) {
		this.physicalName = physicalName;
	}
	public String getPhysicalDesc() {
		return physicalDesc;
	}
	public void setPhysicalDesc(String physicalDesc) {
		this.physicalDesc = physicalDesc;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
}
