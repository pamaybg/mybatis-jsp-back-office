/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlAddInfoDetailNewResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 19. 오전 9:55:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 19.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlAddInfoDetailNewResDto
 * 2. 파일명	: LoyChnlAddInfoDetailNewResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlAddInfoDetailNewResDto extends StatusResDto{
	private String rid;
	private String reprNm;
	private String charger;
	private String zip;
	private String adres;
	private String bunji;
	private String latitude;
	private String longitude;
	private String sido;
	private String gugun;
	private String salesTime;
	private String area;
	private String bizrNo;
	private String jurirNo;
	private String fondDt;
	private String telNo;
	private String fax;
	private String saleMethCd;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getReprNm() {
		return reprNm;
	}
	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}
	public String getCharger() {
		return charger;
	}
	public void setCharger(String charger) {
		this.charger = charger;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSalesTime() {
		return salesTime;
	}
	public void setSalesTime(String salesTime) {
		this.salesTime = salesTime;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getJurirNo() {
		return jurirNo;
	}
	public void setJurirNo(String jurirNo) {
		this.jurirNo = jurirNo;
	}
	public String getFondDt() {
		return fondDt;
	}
	public void setFondDt(String fondDt) {
		this.fondDt = fondDt;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getSaleMethCd() {
		return saleMethCd;
	}

	public void setSaleMethCd(String saleMethCd) {
		this.saleMethCd = saleMethCd;
	}
}
