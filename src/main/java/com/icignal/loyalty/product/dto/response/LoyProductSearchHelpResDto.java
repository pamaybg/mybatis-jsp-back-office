package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyProductSearchHelpResDto extends GridPagingItemResDto {

	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String prodTypeLv1;
	private String prodTypeLv2;
	private String prodId;
	private String prodNm;
	private String compnUseYn;
	private String desc1;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getProdTypeLv1() {
		return prodTypeLv1;
	}
	public void setProdTypeLv1(String prodTypeLv1) {
		this.prodTypeLv1 = prodTypeLv1;
	}
	public String getProdTypeLv2() {
		return prodTypeLv2;
	}
	public void setProdTypeLv2(String prodTypeLv2) {
		this.prodTypeLv2 = prodTypeLv2;
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
	public String getCompnUseYn() {
		return compnUseYn;
	}
	public void setCompnUseYn(String compnUseYn) {
		this.compnUseYn = compnUseYn;
	}
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	
	

}
