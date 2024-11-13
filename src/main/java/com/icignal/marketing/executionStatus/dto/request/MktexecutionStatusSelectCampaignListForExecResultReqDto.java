package com.icignal.marketing.executionStatus.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktexecutionStatusSelectCampaignListForExecResultReqDto extends CommonDataAuthReqDto {
	private String id;
	private String dispNo;
	private String camNm;
	private String camStartDd;
	private String camEndDd;
	private String c1markName;
	private String c2markName;
	private String name;
	private String createDate;
	private String empId;
	private String authType;
	private String brandCd;
	private String camId;
	private String startDate;
	private String endDate;
	private String dataType;
	private String itemId;
	private String chnlId;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamStartDd() {
		return camStartDd;
	}
	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}
	public String getCamEndDd() {
		return camEndDd;
	}
	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}
	public String getC1markName() {
		return c1markName;
	}
	public void setC1markName(String c1markName) {
		this.c1markName = c1markName;
	}
	public String getC2markName() {
		return c2markName;
	}
	public void setC2markName(String c2markName) {
		this.c2markName = c2markName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEmpId() {return empId;}
	public void setEmpId(String empId) {this.empId = empId;}
	public String getAuthType() {return authType;}
	public void setAuthType(String authType) {this.authType = authType;}
	public String getBrandCd() {return brandCd;}
	public void setBrandCd(String brandCd) {this.brandCd = brandCd;}
	public String getCamId() {return camId;}
	public void setCamId(String camId) {this.camId = camId;}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
}
