package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class OfferJoinProdResDto extends GridPagingItemResDto {

	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	// 릴레이션
	private String ridSupplyProd;
	private String ridOfrgrpSel;
	private String ofrgrpSelNm;
	private String ridStmp;
	private String stmpNm;
	
	// 기본 필드
	private String ridOfr;			/* 연결 오퍼 RID*/
	private String ridProdM;		/* 연결 상품 RID*/
	private String prodId;			/* 상품번호 */
	private String prodNm;     	/* 상품명 */
	private String mmzzStdItemCd;
	private String mmzzItemCd;
	private String mmzzRepCd1;
	private String mmzzRepCd2;
	private String mmSkucd;
	private String shGoodsNo;
	private String shGoodsCode;
	private String shGoodsName;
	private String mmMtart;
	private String lCtg;
	private String mCtg;
	private String sCtg;
	
	private String dataFlag;
	
	
	public String getDataFlag() {
		return dataFlag;
	}
	public void setDataFlag(String dataFlag) {
		this.dataFlag = dataFlag;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
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
	public String getRidSupplyProd() {
		return ridSupplyProd;
	}
	public void setRidSupplyProd(String ridSupplyProd) {
		this.ridSupplyProd = ridSupplyProd;
	}
	public String getRidOfrgrpSel() {
		return ridOfrgrpSel;
	}
	public void setRidOfrgrpSel(String ridOfrgrpSel) {
		this.ridOfrgrpSel = ridOfrgrpSel;
	}
	public String getOfrgrpSelNm() {
		return ofrgrpSelNm;
	}
	public void setOfrgrpSelNm(String ofrgrpSelNm) {
		this.ofrgrpSelNm = ofrgrpSelNm;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getStmpNm() {
		return stmpNm;
	}
	public void setStmpNm(String stmpNm) {
		this.stmpNm = stmpNm;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidProdM() {
		return ridProdM;
	}
	public void setRidProdM(String ridProdM) {
		this.ridProdM = ridProdM;
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
}
