package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCamMstListResDto extends GridPagingItemResDto{
	private String id;       /* rid*/
	private String ridPgm;       /* rid*/
	private String camStatusCd;       /* rid*/
	private String camNm;       /* rid*/
	private String camTypeCd;       /* rid*/
	private String camTypeNm;       /* rid*/
	private String camId;       /* rid*/
	private String offerId;       /* rid*/
	private String offerNm;       /* rid*/
	private String promSubType;       /* rid*/
	private String promSubTypeNm;       /* rid*/
	private String camStartDd;       /* rid*/
	private String camEndDd;       /* rid*/
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getCamStatusCd() {
		return camStatusCd;
	}
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamTypeCd() {
		return camTypeCd;
	}
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}
	public String getCamTypeNm() {
		return camTypeNm;
	}
	public void setCamTypeNm(String camTypeNm) {
		this.camTypeNm = camTypeNm;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getOfferId() {
		return offerId;
	}
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
	public String getOfferNm() {
		return offerNm;
	}
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}
	public String getPromSubType() {
		return promSubType;
	}
	public void setPromSubType(String promSubType) {
		this.promSubType = promSubType;
	}
	public String getPromSubTypeNm() {
		return promSubTypeNm;
	}
	public void setPromSubTypeNm(String promSubTypeNm) {
		this.promSubTypeNm = promSubTypeNm;
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
	

}
