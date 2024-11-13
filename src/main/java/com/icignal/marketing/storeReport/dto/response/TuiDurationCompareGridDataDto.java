package com.icignal.marketing.storeReport.dto.response;

public class TuiDurationCompareGridDataDto {
	/* 판매정보 기간 비교 그리드 조회 */
	private String colNm;
	private String newMbrCnt;
	private String mbrCnt;
	private String ordCnt;
	private String purCnt;
	private String sales;
	private String avgPurCnt;
	private String avgMbrSales;
	private String avgOrdSales;



	/* 아이템, 상품 TOP 10개 성과 비교 그리드 */
	private String productCode;
	private String itemCode;
	private String stdPurCnt;
	private String cmpPurCnt;
	private String stdSales;
	private String cmpSales;
	private float purCntRate;
	private float salesRate;




	public String getColNm() {
		return colNm;
	}

	public void setColNm(String colNm) {
		this.colNm = colNm;
	}

	public String getPurCnt() {
		return purCnt;
	}

	public void setPurCnt(String purCnt) {
		this.purCnt = purCnt;
	}
	public String getNewMbrCnt() {
		return newMbrCnt;
	}

	public void setNewMbrCnt(String newMbrCnt) {
		this.newMbrCnt = newMbrCnt;
	}

	public String getMbrCnt() {
		return mbrCnt;
	}

	public void setMbrCnt(String mbrCnt) {
		this.mbrCnt = mbrCnt;
	}

	public String getOrdCnt() {
		return ordCnt;
	}

	public void setOrdCnt(String ordCnt) {
		this.ordCnt = ordCnt;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}

	public String getAvgPurCnt() {
		return avgPurCnt;
	}

	public void setAvgPurCnt(String avgPurCnt) {
		this.avgPurCnt = avgPurCnt;
	}

	public String getAvgMbrSales() {
		return avgMbrSales;
	}

	public void setAvgMbrSales(String avgMbrSales) {
		this.avgMbrSales = avgMbrSales;
	}

	public String getAvgOrdSales() {
		return avgOrdSales;
	}

	public void setAvgOrdSales(String avgOrdSales) {
		this.avgOrdSales = avgOrdSales;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getStdPurCnt() {
		return stdPurCnt;
	}

	public void setStdPurCnt(String stdPurCnt) {
		this.stdPurCnt = stdPurCnt;
	}

	public String getCmpPurCnt() {
		return cmpPurCnt;
	}

	public void setCmpPurCnt(String cmpPurCnt) {
		this.cmpPurCnt = cmpPurCnt;
	}

	public String getStdSales() {
		return stdSales;
	}

	public void setStdSales(String stdSales) {
		this.stdSales = stdSales;
	}

	public String getCmpSales() {
		return cmpSales;
	}

	public void setCmpSales(String cmpSales) {
		this.cmpSales = cmpSales;
	}

	public void setPurCntRate(float purCntRate) {
		this.purCntRate = purCntRate;
	}

	public String getPurCntRate() {
		return String.valueOf(this.purCntRate) + '%';
	}

	public void setSalesRate(float salesRate) {
		this.salesRate = salesRate;
	}


	public String getSalesRate() {
		return String.valueOf(this.salesRate) + '%';
	}
}
