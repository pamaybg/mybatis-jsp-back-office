package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LOYgetProdSpecListResponseDTO
 * 2. 파일명	: LOYgetProdSpecListResponseDTO.java
 * 3. 패키지명	: com.icignal.loyalty.product.dto.response
 * 4. 작성자명	: ps.lee 
 * 5. 작성일자	: 2018. 05. 21. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class LoyGetProdSpecListResDto extends GridPagingItemResDto {
	
	private String prodSpecRid;     			//RID
	private String ridProd;     				//RID_PROD
	
	@MarkName(groupCode = "LOY_PROD_SPEC", codeField = "specType")
	private String specTypeMark;     			//SPEC_TYPE Mark Name
	private String specType;     				//SPEC_TYPE
	
	private String specTypeCd;
	private String specTypeVal;     			//SPEC_TYPE_VAL
	private String createDate;					//CREATE_DATE
	private String modifyDate;					//MODIFY_DATE
	
	//락앤락 신규
	private String goodsCode;     		
	private String goodsName;     		
	private String salesMall;     		
	private String goodsPack;     		
	private String overSea;
	private String salesSdate;
	private String salesEdate;
	private String epRice;
	private String opRice;
	private String bpRice;
	private String marketPrice;
	private String pRice;
	private String originalPrice;
	private String marGin;
	private String istaxFree;
	private String sTock;
	private String sTate;
	
	
	
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getSalesMall() {
		return salesMall;
	}
	public void setSalesMall(String salesMall) {
		this.salesMall = salesMall;
	}
	public String getGoodsPack() {
		return goodsPack;
	}
	public void setGoodsPack(String goodsPack) {
		this.goodsPack = goodsPack;
	}
	public String getOverSea() {
		return overSea;
	}
	public void setOverSea(String overSea) {
		this.overSea = overSea;
	}
	public String getSalesSdate() {
		return salesSdate;
	}
	public void setSalesSdate(String salesSdate) {
		this.salesSdate = salesSdate;
	}
	public String getSalesEdate() {
		return salesEdate;
	}
	public void setSalesEdate(String salesEdate) {
		this.salesEdate = salesEdate;
	}
	public String getEpRice() {
		return epRice;
	}
	public void setEpRice(String epRice) {
		this.epRice = epRice;
	}
	public String getOpRice() {
		return opRice;
	}
	public void setOpRice(String opRice) {
		this.opRice = opRice;
	}
	public String getBpRice() {
		return bpRice;
	}
	public void setBpRice(String bpRice) {
		this.bpRice = bpRice;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getpRice() {
		return pRice;
	}
	public void setpRice(String pRice) {
		this.pRice = pRice;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String getMarGin() {
		return marGin;
	}
	public void setMarGin(String marGin) {
		this.marGin = marGin;
	}
	public String getIstaxFree() {
		return istaxFree;
	}
	public void setIstaxFree(String istaxFree) {
		this.istaxFree = istaxFree;
	}
	public String getsTock() {
		return sTock;
	}
	public void setsTock(String sTock) {
		this.sTock = sTock;
	}
	public String getsTate() {
		return sTate;
	}
	public void setsTate(String sTate) {
		this.sTate = sTate;
	}
	public String getRidProd() {
		return ridProd;
	}
	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}
	public String getSpecType() {
		return specType;
	}
	public void setSpecType(String specType) {
		this.specType = specType;
	}
	public String getSpecTypeVal() {
		return specTypeVal;
	}
	public void setSpecTypeVal(String specTypeVal) {
		this.specTypeVal = specTypeVal;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getSpecTypeMark() {
		return specTypeMark;
	}
	public void setSpecTypeMark(String specTypeMark) {
		this.specTypeMark = specTypeMark;
	}
	public String getProdSpecRid() {
		return prodSpecRid;
	}
	public void setProdSpecRid(String prodSpecRid) {
		this.prodSpecRid = prodSpecRid;
	}
	public String getSpecTypeCd() {
		return specTypeCd;
	}
	public void setSpecTypeCd(String specTypeCd) {
		this.specTypeCd = specTypeCd;
	}
	
}