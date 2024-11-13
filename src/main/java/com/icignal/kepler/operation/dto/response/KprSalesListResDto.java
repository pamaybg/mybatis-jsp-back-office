package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSalesListResDto extends StatusResDto {

	
	private String accntId;
	private String id;
	private String storeId;
	private String salesDt;
	private String salesType;
	private Integer qty;
	private Integer totSalesAmt;
	private Integer realSalesAmt;
	private Integer totDcAmt;
	private String salesEmpId;
	private String cpnNo;
	private String mbrId;
	private String offerNo;
	
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
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getSalesDt() {
		return salesDt;
	}
	public void setSalesDt(String salesDt) {
		this.salesDt = salesDt;
	}
	public String getSalesType() {
		return salesType;
	}
	public void setSalesType(String salesType) {
		this.salesType = salesType;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Integer getTotSalesAmt() {
		return totSalesAmt;
	}
	public void setTotSalesAmt(Integer totSalesAmt) {
		this.totSalesAmt = totSalesAmt;
	}
	public Integer getRealSalesAmt() {
		return realSalesAmt;
	}
	public void setRealSalesAmt(Integer realSalesAmt) {
		this.realSalesAmt = realSalesAmt;
	}
	public Integer getTotDcAmt() {
		return totDcAmt;
	}
	public void setTotDcAmt(Integer totDcAmt) {
		this.totDcAmt = totDcAmt;
	}
	public String getSalesEmpId() {
		return salesEmpId;
	}
	public void setSalesEmpId(String salesEmpId) {
		this.salesEmpId = salesEmpId;
	}
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getOfferNo() {
		return offerNo;
	}
	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}
    
}
