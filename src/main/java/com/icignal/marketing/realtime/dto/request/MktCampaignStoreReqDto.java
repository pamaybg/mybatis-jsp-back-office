package com.icignal.marketing.realtime.dto.request;


import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktCampaignStoreReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String chnlNm;
	private String chnlNo;
	private String parRid;
	private String chnlTypeSubCd;
	private String delYn;
	private String chnlTypeCd;
	private String id;
	private String createDate;
	private String modifyDate;
	private String flag;
	private String appServiceType;
	private String type;
	private String camId;
	private String storeId;
	private String sndChnlId;
	private String storeNm;  
	private String upperStoreId;
	private String storeTypeCd;
	private String sndStoreNm;
	private String accntId;
	private String storeCd;
	private String sndStoreCd;
	
	private List<MktCampaignStoreReqDto> storeList;
	
	public String getSndStoreNm() {
		return sndStoreNm;
	}
	public void setSndStoreNm(String sndStoreNm) {
		this.sndStoreNm = sndStoreNm;
	}
	
	
	
	public String getUpperStoreId() {
		return upperStoreId;
	}
	public void setUpperStoreId(String upperStoreId) {
		this.upperStoreId = upperStoreId;
	}
	public String getStoreTypeCd() {
		return storeTypeCd;
	}
	public void setStoreTypeCd(String storeTypeCd) {
		this.storeTypeCd = storeTypeCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getAppServiceType() {
		return appServiceType;
	}
	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getSndChnlId() {
		return sndChnlId;
	}
	public void setSndChnlId(String sndChnlId) {
		this.sndChnlId = sndChnlId;
	}
	public String getStoreNm() {
		return storeNm;
	}
	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}
	public List<MktCampaignStoreReqDto> getStoreList() {
		return storeList;
	}
	public void setStoreList(List<MktCampaignStoreReqDto> storeList) {
		this.storeList = storeList;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getStoreCd() {
		return storeCd;
	}
	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	public String getSndStoreCd() {
		return sndStoreCd;
	}
	public void setSndStoreCd(String sndStoreCd) {
		this.sndStoreCd = sndStoreCd;
	}
	
	
	
}
