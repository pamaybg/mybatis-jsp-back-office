package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
public class LoyClubMbrAttrDetailResDto extends GridPagingItemResDto{	
	
	private String rid;
	private String ridClub;
	private String ridMbr;
	private String ridClubMbr;
	private String ridAttr;
	private String ridClubMbrAttr;
	private String val;
	private String fileName;
	private String fieldTypeCd;
	private String filePName;
	private String fileLName;
	
	@Decrypted(masked = "custNm")
	private String custNm;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidClub() {
		return ridClub;
	}
	public void setRidClub(String ridClub) {
		this.ridClub = ridClub;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidClubMbr() {
		return ridClubMbr;
	}
	public void setRidClubMbr(String ridClubMbr) {
		this.ridClubMbr = ridClubMbr;
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
	public String getFieldTypeCd() {
		return fieldTypeCd;
	}
	public void setFieldTypeCd(String fieldTypeCd) {
		this.fieldTypeCd = fieldTypeCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRidClubMbrAttr() {
		return ridClubMbrAttr;
	}
	public void setRidClubMbrAttr(String ridClubMbrAttr) {
		this.ridClubMbrAttr = ridClubMbrAttr;
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
