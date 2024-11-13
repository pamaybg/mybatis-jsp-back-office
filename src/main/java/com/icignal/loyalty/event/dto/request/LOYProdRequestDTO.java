package com.icignal.loyalty.event.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LOYProdRequestDTO extends CommonDataAuthReqDto{
	private String rid;
	private String prodId;
	private String itemcd;
	private String prodNm;
	private String salePrice;
	private String desc;
	private String cpnAvlYn;
	private String fileName;

	private String uploadValidCheck;
	
	private List<LOYProdRequestDTO> array;
	private List<LOYProdRequestDTO> ridList;
	private int cnt;
	private boolean message;
	private String mbrNo;
	
	
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getItemcd() {
		return itemcd;
	}
	public void setItemcd(String itemcd) {
		this.itemcd = itemcd;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getCpnAvlYn() {
		return cpnAvlYn;
	}
	public void setCpnAvlYn(String cpnAvlYn) {
		this.cpnAvlYn = cpnAvlYn;
	}
	public List<LOYProdRequestDTO> getArray() {
		return array;
	}
	public void setArray(List<LOYProdRequestDTO> array) {
		this.array = array;
	}
	public List<LOYProdRequestDTO> getRidList() {
		return ridList;
	}
	public void setRidList(List<LOYProdRequestDTO> ridList) {
		this.ridList = ridList;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public boolean isMessage() {
		return message;
	}
	public void setMessage(boolean message) {
		this.message = message;
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

	
}