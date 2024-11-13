package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupRequestDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupReqDto extends BaseReqDto {
	
	/**    아이디    */    private String  attributeGroupId= "";
	/**    아이디    */    private String  tempAttributeGroupId= "";
	/**    생성자    */    private String  createBy= "";
	/**    수정자    */    private String  modifyBy= "";
	/**    생성일시    */    private String  createDate= "";
	/**    수정일시    */    private String  modifyDate= "";
	/**    삭제여부    */    private String  flag= "";
	/**    국가코드 KR : 한국, US : 미국    */    private String  country= "";
	/**    화폐단위 KRW : 원화, USD : 달러    */    private String  currency= "";
	/**    APP 서비스 ID    */    private String  appServiceType= "";
	/**    유형    */    private String  type= "";
	/**    어카운트ID    */    private String  accountId= "";
	/**    스토어ID    */    private String  storeId= "";
	/**    어트리뷰터그룹명    */    private String  atribGroupNm= "";
	/**    순서    */    private String  seq= "";
	/**    로지컬컴포넌트 ID    */    private String  lgcCompId= "";
	
	public String getTempAttributeGroupId() {
		return tempAttributeGroupId;
	}
	public void setTempAttributeGroupId(String tempAttributeGroupId) {
		this.tempAttributeGroupId = tempAttributeGroupId;
	}
	public String getAttributeGroupId() {
		return attributeGroupId;
	}
	public void setAttributeGroupId(String attributeGroupId) {
		this.attributeGroupId = attributeGroupId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getAtribGroupNm() {
		return atribGroupNm;
	}
	public void setAtribGroupNm(String atribGroupNm) {
		this.atribGroupNm = atribGroupNm;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

}
