package com.icignal.loyalty.club.dto.request;

/*
 * 1. 클래스명	: LoyClubAtttMetaReqDto
 * 2. 파일명	: LoyClubAtttMetaReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.request
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		클럽 회원 속성 MetaData
 * </PRE>
 */ 
public class LoyClubMbrAttrMetaReqDto {
	
	private String ridAttr;
	private String val;
	private String fileName;
	private String filePName;
	private String fileLName;
	
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

}
