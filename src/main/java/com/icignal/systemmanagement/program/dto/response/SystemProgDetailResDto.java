package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemProgDetailResDto extends BaseReqDto {

	private String progNo;
	private String progName;
	private String progType;
	private String progPath;
	private String progCreater;
	private String progCreateDate;
	private String mainPgmId;
	private String parPgmId;
	private String menuChkYn;
	private String mainPgmNm;
	private String parPgmNm;
	private String tabLabelName;
	private String tabSeq;
	
	
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
	public String getProgCreater() {
		return progCreater;
	}
	public void setProgCreater(String progCreater) {
		this.progCreater = progCreater;
	}
	public String getProgCreateDate() {
		return progCreateDate;
	}
	public void setProgCreateDate(String progCreateDate) {
		this.progCreateDate = progCreateDate;
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
	public String getMainPgmNm() {
		return mainPgmNm;
	}
	public void setMainPgmNm(String mainPgmNm) {
		this.mainPgmNm = mainPgmNm;
	}
	public String getParPgmNm() {
		return parPgmNm;
	}
	public void setParPgmNm(String parPgmNm) {
		this.parPgmNm = parPgmNm;
	}

	
	
}
