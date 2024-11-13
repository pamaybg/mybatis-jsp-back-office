package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentsResponseDTO
 * 2. 파일명	: KPRLogicalComponentsResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentsResDto extends GridPagingItemResDto {

	/**    아이디    */    private String  lgcCompId= "";
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
	/**    로지컬컴포넌트명    */    private String  lgcCompNm= "";
	/**    설명    */    private String  lgcDesc= "";
	/**    로지컬컴포넌트의 최종 SQL    */    private String  lgcSql= "";
	/**    로지컬컴포넌트 사용가능여부    */    private String  cmpltYn= "";
	/**    주제영역DB관계ID    */    private String  dbInformId= "";
	
	/**    생성자    */    private String  name= "";
	
	/**    분석 또는 세그먼트 사용여부 확인    */    private boolean  analysisSegmentUsed;
	
	public boolean isAnalysisSegmentUsed() {
		return analysisSegmentUsed;
	}
	public void setAnalysisSegmentUsed(boolean analysisSegmentUsed) {
		this.analysisSegmentUsed = analysisSegmentUsed;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
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
	public String getLgcCompNm() {
		return lgcCompNm;
	}
	public void setLgcCompNm(String lgcCompNm) {
		this.lgcCompNm = lgcCompNm;
	}
	public String getLgcDesc() {
		return lgcDesc;
	}
	public void setLgcDesc(String lgcDesc) {
		this.lgcDesc = lgcDesc;
	}
	public String getLgcSql() {
		return lgcSql;
	}
	public void setLgcSql(String lgcSql) {
		this.lgcSql = lgcSql;
	}
	public String getCmpltYn() {
		return cmpltYn;
	}
	public void setCmpltYn(String cmpltYn) {
		this.cmpltYn = cmpltYn;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

}