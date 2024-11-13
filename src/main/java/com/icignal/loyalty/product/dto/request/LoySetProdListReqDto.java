package com.icignal.loyalty.product.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoySetProdListReqDto extends CommonDataAuthReqDto {
	
	private String rid;     			//RID
	private String ridPgm; 
	private String ridBrdCat; 
	private String brdNm; 
	private String ridProdCat; 
	private String catNm; 
	private String ridChnl; 
	private String chnlNm; 
	private String prodId; 
	private String prodNm; 
	private String prodAmt;
	private String  uploadValidCheck;
	private String  fileName;
	private String prodType;
	private String brndType;
	private String serialNo;
	private String color;
	private String stanYearMonth;
	private String prodColor;
	private List<LoySetProdListReqDto> array;
	
	
	public String getBrndType() {
		return brndType;
	}
	public void setBrndType(String brndType) {
		this.brndType = brndType;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getStanYearMonth() {
		return stanYearMonth;
	}
	public void setStanYearMonth(String stanYearMonth) {
		this.stanYearMonth = stanYearMonth;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getRidBrdCat() {
		return ridBrdCat;
	}
	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}
	public String getBrdNm() {
		return brdNm;
	}
	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}
	public String getRidProdCat() {
		return ridProdCat;
	}
	public void setRidProdCat(String ridProdCat) {
		this.ridProdCat = ridProdCat;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getProdAmt() {
		return prodAmt;
	}
	public void setProdAmt(String prodAmt) {
		this.prodAmt = prodAmt;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public List<LoySetProdListReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoySetProdListReqDto> array) {
		this.array = array;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getProdColor() {
		return prodColor;
	}
	public void setProdColor(String prodColor) {
		this.prodColor = prodColor;
	}
	
}