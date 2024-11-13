package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSalesDtlListReqDto extends StatusResDto {

	private String accntId;
	private String id;
	private String salesId;
	private String salesDt;
	private String prodId;
	private Integer qty;
	private Integer prc;
	private Integer amt;
	
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSalesId() {
		return salesId;
	}
	public void setSalesId(String salesId) {
		this.salesId = salesId;
	}
	public String getSalesDt() {
		return salesDt;
	}
	public void setSalesDt(String salesDt) {
		this.salesDt = salesDt;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Integer getPrc() {
		return prc;
	}
	public void setPrc(Integer prc) {
		this.prc = prc;
	}
	public Integer getAmt() {
		return amt;
	}
	public void setAmt(Integer amt) {
		this.amt = amt;
	}

}
