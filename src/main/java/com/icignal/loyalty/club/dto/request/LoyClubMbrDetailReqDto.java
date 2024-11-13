package com.icignal.loyalty.club.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyClubMbrDetailReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String empId;
	private String parRid;
	private String ridClub;
	private String ridMbr;
	private String ridClubMbr;
	private String statCd;
	private String processDate;
	private String validStartDate;
	private String validEndDate;
	private String secsnResnCd;
	private String secsnResnEtc;
	
	private List<LoyClubMbrAttrMetaReqDto> mbrAttrList;
	
	private String ridAttr;
	private String val;
	private String fileName;
	private String filePName;
	private String fileLName;
	
	private String fileNameText;
	
	private List<LoyClubMbrDetailReqDto> array;
	
	private Boolean stayFile;

	public Boolean getStayFile() {
		return stayFile;
	}

	public void setStayFile(Boolean stayFile) {
		this.stayFile = stayFile;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getRidClub() {
		return ridClub;
	}

	public void setRidClub(String ridClub) {
		this.ridClub = ridClub;
	}

	public String getRidClubMbr() {
		return ridClubMbr;
	}

	public void setRidClubMbr(String ridClubMbr) {
		this.ridClubMbr = ridClubMbr;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getProcessDate() {
		return processDate;
	}

	public void setProcessDate(String processDate) {
		this.processDate = processDate;
	}

	public String getValidStartDate() {
		return validStartDate;
	}

	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}

	public String getValidEndDate() {
		return validEndDate;
	}

	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}

	public String getSecsnResnCd() {
		return secsnResnCd;
	}

	public void setSecsnResnCd(String secsnResnCd) {
		this.secsnResnCd = secsnResnCd;
	}

	public String getSecsnResnEtc() {
		return secsnResnEtc;
	}

	public void setSecsnResnEtc(String secsnResnEtc) {
		this.secsnResnEtc = secsnResnEtc;
	}

	public List<LoyClubMbrAttrMetaReqDto> getMbrAttrList() {
		return mbrAttrList;
	}

	public void setMbrAttrList(List<LoyClubMbrAttrMetaReqDto> mbrAttrList) {
		this.mbrAttrList = mbrAttrList;
	}

	public String getFileNameText() {
		return fileNameText;
	}

	public void setFileNameText(String fileNameText) {
		this.fileNameText = fileNameText;
	}

	public String getRidAttr() {
		return ridAttr;
	}

	public void setRidAttr(String ridAttr) {
		this.ridAttr = ridAttr;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePName() {
		return filePName;
	}

	public void setFilePName(String filePName) {
		this.filePName = filePName;
	}

	public String getFileLName() {
		return fileLName;
	}

	public void setFileLName(String fileLName) {
		this.fileLName = fileLName;
	}

	public List<LoyClubMbrDetailReqDto> getArray() {
		return array;
	}

	public void setArray(List<LoyClubMbrDetailReqDto> array) {
		this.array = array;
	}
	
}
