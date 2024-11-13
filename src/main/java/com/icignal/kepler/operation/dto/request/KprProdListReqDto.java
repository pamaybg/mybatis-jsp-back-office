package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprProdListReqDto extends StatusResDto {

	private String accntId;
	private String id;
	private String prdCd;
	private String prdNm;
	private String brand;
	private String prdLar;
	private String prdMid;
	private String prdSml;
	
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
	public String getPrdCd() {
		return prdCd;
	}
	public void setPrdCd(String prdCd) {
		this.prdCd = prdCd;
	}
	public String getPrdNm() {
		return prdNm;
	}
	public void setPrdNm(String prdNm) {
		this.prdNm = prdNm;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getPrdLar() {
		return prdLar;
	}
	public void setPrdLar(String prdLar) {
		this.prdLar = prdLar;
	}
	public String getPrdMid() {
		return prdMid;
	}
	public void setPrdMid(String prdMid) {
		this.prdMid = prdMid;
	}
	public String getPrdSml() {
		return prdSml;
	}
	public void setPrdSml(String prdSml) {
		this.prdSml = prdSml;
	}

}
