package com.icignal.systemmanagement.program.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SystemInsertProgDetailReqDto extends MKTBaseReqDto {

	private String id;
	private String progNo;
	private String progName;
	private String progType;
	private String progPath;
	private String progId;
	private String empId;
	private String mainPgmId;
	private String parPgmId;
	private String menuChkYn;
	private String tabLabelName;
	private String tabSeq;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTabSeq() {
		return tabSeq;
	}
	public void setTabSeq(String tabSeq) {
		this.tabSeq = tabSeq;
	}
	public String getTabLabelName() {
		return tabLabelName;
	}
	public void setTabLabelName(String tabLabelName) {
		this.tabLabelName = tabLabelName;
	}
	public String getProgId() {
		return progId;
	}
	public void setProgId(String progId) {
		this.progId = progId;
	}
	public String getProgNo() {
		return progNo;
	}
	public void setProgNo(String progNo) {
		this.progNo = progNo;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getMainPgmId() {
		return mainPgmId;
	}
	public void setMainPgmId(String mainPgmId) {
		this.mainPgmId = mainPgmId;
	}
	public String getParPgmId() {
		return parPgmId;
	}
	public void setParPgmId(String parPgmId) {
		this.parPgmId = parPgmId;
	}
	public String getMenuChkYn() {
		return menuChkYn;
	}
	public void setMenuChkYn(String menuChkYn) {
		this.menuChkYn = menuChkYn;
	}

}
