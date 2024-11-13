package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LOYgetProdListRequestDTO
 * 2. 파일명	: LOYgetProdListRequestDTO.java
 * 3. 패키지명	: com.icignal.loyalty.product.dto.request
 * 4. 작성자명	: wjlee 
 * 5. 작성일자	: 2016. 12. 9. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyGetProdListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String prodId;
	private String serialNo;
	private String cpnAvlYn;
	private String ridOfr;
	private String prodUseType;
	
	public String getCpnAvlYn() {
		return cpnAvlYn;
	}

	public void setCpnAvlYn(String cpnAvlYn) {
		this.cpnAvlYn = cpnAvlYn;
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

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getProdUseType() {
		return prodUseType;
	}

	public void setProdUseType(String prodUseType) {
		this.prodUseType = prodUseType;
	}
	
}