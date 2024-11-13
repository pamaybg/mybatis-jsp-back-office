package com.icignal.loyalty.product.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyProdSpecReqDto extends CommonDataAuthReqDto {
	
	private String prodSpecRid;     			//RID
	private String ridProd;     				//RID_PROD
	private String specType;     				//SPEC_TYPE
	private String specTypeVal;     			//SPEC_TYPE_VAL
	private String rid;
	private String empId;
	private List<String> rids;					//delete용 RID 리스트
	
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
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	public String getProdSpecRid() {
		return prodSpecRid;
	}
	public void setProdSpecRid(String prodSpecRid) {
		this.prodSpecRid = prodSpecRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}