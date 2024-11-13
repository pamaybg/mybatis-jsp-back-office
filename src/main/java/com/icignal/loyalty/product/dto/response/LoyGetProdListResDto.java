package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LOYgetProdListResponseDTO
 * 2. 파일명	: LOYgetProdListResponseDTO.java
 * 3. 패키지명	: com.icignal.loyalty.product.dto.response
 * 4. 작성자명	: wjlee 
 * 5. 작성일자	: 2016. 12. 9. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class LoyGetProdListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridPgm; 
	private String ridBrdCat; 
	private String brdNm; 
	private String ridProdCat; 
	private String catNm; 
	private String ridChnl; 
	private String chnlNm; 
	private Integer prodAmt; 
	private String createBy; 
	private String createDate;
	@MarkName(groupCode = "LOY_PROD_TYPE", codeField = "prodTypeCd")
	private String prodType;
	private String prodTypeCd;
	private String color;
	private String baseYmd;
	private Integer cnt;
	private String prodColor;
	
	//락앤락 신규
	private String prodId;
	private String mmzzStdItemCd;
	private String mmzzItemCd;
	private String mmzzRepCd1;
	private String mmzzRepCd2;
	private String mmSkucd;
	private String prodNm;
	private String shGoodsNo;
	private String shGoodsCode;
	private String shGoodsName;
	private String mmMtart;
	private String lCtg;
	private String mCtg;
	private String sCtg;
	private String mmPrdha;
	private String mmGroup;
	private String sdp1Price;
	private String sdp1Unit;
	private String mmfStdate;
	private String scmGrade;
	private String goodsCode;
	private String goodsName;
	private String salesMall;
	private String goodsPack;
	private String oversea;
	private String salesSdate;
	private String salesEdate;
	private String eprice;
	private String oprice;
	private String bprice;
	private String marketPrice;
	private String mallPrice;
	private String originalPrice;
	private String margin;
	private String istaxfree;
	private String stock;
	private String state;
	private String offPrice;
	private String offPromPrice;
	private String offEvtSupPrice;
	private String offStrdSupPrice;
	private String desc1;
	private String cpnAvlYn;

	private String itemCd;
	private String itemNm;

	private String modifyDate;
	private String modifyBy;

	
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public String getCpnAvlYn() {
		return cpnAvlYn;
	}
	public void setCpnAvlYn(String cpnAvlYn) {
		this.cpnAvlYn = cpnAvlYn;
	}
	public String getMmfStdate() {
		return mmfStdate;
	}
	public void setMmfStdate(String mmfStdate) {
		this.mmfStdate = mmfStdate;
	}
	public String getMmzzStdItemCd() {
		return mmzzStdItemCd;
	}
	public void setMmzzStdItemCd(String mmzzStdItemCd) {
		this.mmzzStdItemCd = mmzzStdItemCd;
	}
	public String getMmzzItemCd() {
		return mmzzItemCd;
	}
	public void setMmzzItemCd(String mmzzItemCd) {
		this.mmzzItemCd = mmzzItemCd;
	}
	public String getMmzzRepCd1() {
		return mmzzRepCd1;
	}
	public void setMmzzRepCd1(String mmzzRepCd1) {
		this.mmzzRepCd1 = mmzzRepCd1;
	}
	public String getMmzzRepCd2() {
		return mmzzRepCd2;
	}
	public void setMmzzRepCd2(String mmzzRepCd2) {
		this.mmzzRepCd2 = mmzzRepCd2;
	}
	public String getMmSkucd() {
		return mmSkucd;
	}
	public void setMmSkucd(String mmSkucd) {
		this.mmSkucd = mmSkucd;
	}
	public String getShGoodsNo() {
		return shGoodsNo;
	}
	public void setShGoodsNo(String shGoodsNo) {
		this.shGoodsNo = shGoodsNo;
	}
	public String getShGoodsCode() {
		return shGoodsCode;
	}
	public void setShGoodsCode(String shGoodsCode) {
		this.shGoodsCode = shGoodsCode;
	}
	public String getShGoodsName() {
		return shGoodsName;
	}
	public void setShGoodsName(String shGoodsName) {
		this.shGoodsName = shGoodsName;
	}
	public String getMmMtart() {
		return mmMtart;
	}
	public void setMmMtart(String mmMtart) {
		this.mmMtart = mmMtart;
	}
	public String getlCtg() {
		return lCtg;
	}
	public void setlCtg(String lCtg) {
		this.lCtg = lCtg;
	}
	public String getmCtg() {
		return mCtg;
	}
	public void setmCtg(String mCtg) {
		this.mCtg = mCtg;
	}
	public String getsCtg() {
		return sCtg;
	}
	public void setsCtg(String sCtg) {
		this.sCtg = sCtg;
	}
	public String getMmPrdha() {
		return mmPrdha;
	}
	public void setMmPrdha(String mmPrdha) {
		this.mmPrdha = mmPrdha;
	}
	public String getMmGroup() {
		return mmGroup;
	}
	public void setMmGroup(String mmGroup) {
		this.mmGroup = mmGroup;
	}
	public String getSdp1Price() {
		return sdp1Price;
	}
	public void setSdp1Price(String sdp1Price) {
		this.sdp1Price = sdp1Price;
	}
	public String getSdp1Unit() {
		return sdp1Unit;
	}
	public void setSdp1Unit(String sdp1Unit) {
		this.sdp1Unit = sdp1Unit;
	}
	public String getScmGrade() {
		return scmGrade;
	}
	public void setScmGrade(String scmGrade) {
		this.scmGrade = scmGrade;
	}
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
	public String getOversea() {
		return oversea;
	}
	public void setOversea(String oversea) {
		this.oversea = oversea;
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
	public String getEprice() {
		return eprice;
	}
	public void setEprice(String eprice) {
		this.eprice = eprice;
	}
	public String getOprice() {
		return oprice;
	}
	public void setOprice(String oprice) {
		this.oprice = oprice;
	}
	public String getBprice() {
		return bprice;
	}
	public void setBprice(String bprice) {
		this.bprice = bprice;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getMallPrice() {
		return mallPrice;
	}
	public void setMallPrice(String mallPrice) {
		this.mallPrice = mallPrice;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}
	public String getIstaxfree() {
		return istaxfree;
	}
	public void setIstaxfree(String istaxfree) {
		this.istaxfree = istaxfree;
	}
	public String getStock() {
		return stock;
	}
	public void setStock(String stock) {
		this.stock = stock;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOffPrice() {
		return offPrice;
	}
	public void setOffPrice(String offPrice) {
		this.offPrice = offPrice;
	}
	public String getOffPromPrice() {
		return offPromPrice;
	}
	public void setOffPromPrice(String offPromPrice) {
		this.offPromPrice = offPromPrice;
	}
	public String getOffEvtSupPrice() {
		return offEvtSupPrice;
	}
	public void setOffEvtSupPrice(String offEvtSupPrice) {
		this.offEvtSupPrice = offEvtSupPrice;
	}
	public String getOffStrdSupPrice() {
		return offStrdSupPrice;
	}
	public void setOffStrdSupPrice(String offStrdSupPrice) {
		this.offStrdSupPrice = offStrdSupPrice;
	}
	protected String getProdColor() {
		return prodColor;
	}
	protected void setProdColor(String prodColor) {
		this.prodColor = prodColor;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getBaseYmd() {
		return baseYmd;
	}
	public void setBaseYmd(String baseYmd) {
		this.baseYmd = baseYmd;
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
	public Integer getProdAmt() {
		return prodAmt;
	}
	public void setProdAmt(Integer prodAmt) {
		this.prodAmt = prodAmt;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getProdTypeCd() {
		return prodTypeCd;
	}
	public void setProdTypeCd(String prodTypeCd) {
		this.prodTypeCd = prodTypeCd;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
}