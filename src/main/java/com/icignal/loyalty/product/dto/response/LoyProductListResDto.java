package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyProductListResDto extends GridPagingItemResDto {

	private String chnlNo;
	private String chnlNm;
	private String prodTypeLv1;
	private String prodTypeLv2;
	private String prodId;
	private String prodNm;
	private String compnUseYn;
	private String desc1;
	@MarkName(groupCode = "PRODUCT_STATUS", codeField = "statusCdNm")
	private String statusCd;
	private String statusCdNm;
	private String enisSetlMeth;
	private String taxtnYn;
	private String taxtnOccAmt;
	private String taxtnRate;
	private String taxtnProdCd;
	private String taxtnProdNm;
	private String taxfrProdCd;
	private String taxfrProdNm;
	private String ridTaxtn;
	private String ridTaxfr;
	private String ridChnl;
	private String rid;
	
	private String coplexProdFlg;
	private String prodNickNm ;
	private String barcodr;
	private String price;
	private String priceFlg;
	private String barcode;
	
	
	
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
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getEnisSetlMeth() {
		return enisSetlMeth;
	}
	public void setEnisSetlMeth(String enisSetlMeth) {
		this.enisSetlMeth = enisSetlMeth;
	}
	public String getTaxtnYn() {
		return taxtnYn;
	}
	public void setTaxtnYn(String taxtnYn) {
		this.taxtnYn = taxtnYn;
	}
	public String getTaxtnOccAmt() {
		return taxtnOccAmt;
	}
	public void setTaxtnOccAmt(String taxtnOccAmt) {
		this.taxtnOccAmt = taxtnOccAmt;
	}
	public String getTaxtnRate() {
		return taxtnRate;
	}
	public void setTaxtnRate(String taxtnRate) {
		this.taxtnRate = taxtnRate;
	}

	
	public String getTaxtnProdCd() {
		return taxtnProdCd;
	}
	public void setTaxtnProdCd(String taxtnProdCd) {
		this.taxtnProdCd = taxtnProdCd;
	}
	public String getTaxtnProdNm() {
		return taxtnProdNm;
	}
	public void setTaxtnProdNm(String taxtnProdNm) {
		this.taxtnProdNm = taxtnProdNm;
	}
	public String getTaxfrProdCd() {
		return taxfrProdCd;
	}
	public void setTaxfrProdCd(String taxfrProdCd) {
		this.taxfrProdCd = taxfrProdCd;
	}
	
	public String getTaxfrProdNm() {
		return taxfrProdNm;
	}
	public void setTaxfrProdNm(String taxfrProdNm) {
		this.taxfrProdNm = taxfrProdNm;
	}
	public String getRidTaxtn() {
		return ridTaxtn;
	}
	public void setRidTaxtn(String ridTaxtn) {
		this.ridTaxtn = ridTaxtn;
	}
	public String getRidTaxfr() {
		return ridTaxfr;
	}
	public void setRidTaxfr(String ridTaxfr) {
		this.ridTaxfr = ridTaxfr;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getCoplexProdFlg() {
		return coplexProdFlg;
	}
	public void setCoplexProdFlg(String coplexProdFlg) {
		this.coplexProdFlg = coplexProdFlg;
	}
	public String getProdNickNm() {
		return prodNickNm;
	}
	public void setProdNickNm(String prodNickNm) {
		this.prodNickNm = prodNickNm;
	}
	public String getBarcodr() {
		return barcodr;
	}
	public void setBarcodr(String barcodr) {
		this.barcodr = barcodr;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPriceFlg() {
		return priceFlg;
	}
	public void setPriceFlg(String priceFlg) {
		this.priceFlg = priceFlg;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public String getStatusCdNm() {
		return statusCdNm;
	}
	public void setStatusCdNm(String statusCdNm) {
		this.statusCdNm = statusCdNm;
	}
	
}
