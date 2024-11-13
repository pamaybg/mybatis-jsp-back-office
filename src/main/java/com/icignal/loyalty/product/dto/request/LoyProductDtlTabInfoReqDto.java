package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyProductDtlTabInfoReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String pointApplyPrice;
	private String mbrbsSplPrice;
	private String aplyStartDd;
	private String aplyEndDd;
	private String ridProd;
	private String empId;
	
	private String startDd;
	private String endDd;
	private String prodNm;
	private String chnlNo;
	private String chnlNm;
	private String desc1;
	private String ridChnl;
	
	private String tabDiv;
	
	
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getPointApplyPrice() {
		return pointApplyPrice;
	}

	public void setPointApplyPrice(String pointApplyPrice) {
		this.pointApplyPrice = pointApplyPrice;
	}

	public String getMbrbsSplPrice() {
		return mbrbsSplPrice;
	}

	public void setMbrbsSplPrice(String mbrbsSplPrice) {
		this.mbrbsSplPrice = mbrbsSplPrice;
	}

	public String getAplyStartDd() {
		return aplyStartDd;
	}

	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}

	public String getAplyEndDd() {
		return aplyEndDd;
	}

	public void setAplyEndDd(String aplyEndDd) {
		this.aplyEndDd = aplyEndDd;
	}

	public String getRidProd() {
		return ridProd;
	}

	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getStartDd() {
		return startDd;
	}

	public void setStartDd(String startDd) {
		this.startDd = startDd;
	}

	public String getEndDd() {
		return endDd;
	}

	public void setEndDd(String endDd) {
		this.endDd = endDd;
	}

	public String getProdNm() {
		return prodNm;
	}

	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
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

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getTabDiv() {
		return tabDiv;
	}

	public void setTabDiv(String tabDiv) {
		this.tabDiv = tabDiv;
	}
}
