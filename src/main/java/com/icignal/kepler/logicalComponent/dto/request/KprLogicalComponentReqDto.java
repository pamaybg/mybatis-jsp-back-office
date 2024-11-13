package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentRequestDTO
 * 2. 파일명	: KPRLogicalComponentRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 요청 DTO
 * </PRE>
 */ 
public class KprLogicalComponentReqDto extends CommonDataAuthReqDto {

	/** 아이디 */
	private String lgcCompId = "";
	/** 임시 로지컬 컴포넌트 ID */
	private String tempLgcCompId = "";
	/** 생성자 */
	private String createBy = "";
	/** 수정자 */
	private String modifyBy = "";
	/** 생성일시 */
	private String createDate = "";
	/** 수정일시 */
	private String modifyDate = "";
	/** 삭제여부 */
	private String flag = "";
	/** 국가코드 KR : 한국, US : 미국 */
	private String country = "";
	/** 화폐단위 KRW : 원화, USD : 달러 */
	private String currency = "";
	/** APP 서비스 ID */
	private String appServiceType = "";
	/** 유형 */
	private String type = "";
	/** 어카운트ID */
	private String accountId = "";
	/** 스토어ID */
	private String storeId = "";
	/** 로지컬컴포넌트명 */
	private String lgcCompNm = "";
	/** 설명 */
	private String lgcDesc = "";
	/** 로지컬컴포넌트의 최종 SQL */
	private String lgcSql = "";
	/** 로지컬컴포넌트 사용가능여부 */
	private String cmpltYn = "";
	/** 주제영역DB관계ID */
	private String dbInformId = "";

	private Integer tableSeq;
	private String sqlValue="";

	/** 주제영역DB관계ID 변경여부 */
	private boolean dbInformIdChange;

	/** 조인설정 테이블 관계 리스트 */
	private List<KprLogicalComponentJoinTableRelReqDto> joinTableRelList;
	/** 조인설정 컬럼 리스트 */
	private List<KprLogicalComponentJoinColumnReqDto> joinColumnList;

	/** 어트리뷰트 그룹 리스트 */
	private List<KprLogicalComponentAttributeGroupReqDto> atribGroupList;
	/** 어트리뷰트 그룹 컬럼 리스트 */
	private List<KprLogicalComponentAttributeGroupColumnReqDto> atribGroupColumnList;

	private List<KprLogicalComponentGroupColumnReqDto> joinColumnGrpList;

	
	public String getSqlValue() {
		return sqlValue;
	}

	public void setSqlValue(String sqlValue) {
		this.sqlValue = sqlValue;
	}

	public Integer getTableSeq() {
		return tableSeq;
	}

	public void setTableSeq(Integer tableSeq) {
		this.tableSeq = tableSeq;
	}

	public boolean isDbInformIdChange() {
		return dbInformIdChange;
	}

	public void setDbInformIdChange(boolean dbInformIdChange) {
		this.dbInformIdChange = dbInformIdChange;
	}

	public String getTempLgcCompId() {
		return tempLgcCompId;
	}

	public void setTempLgcCompId(String tempLgcCompId) {
		this.tempLgcCompId = tempLgcCompId;
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

	public void setAccountId(String accntId) {
		this.accountId = accntId;
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

	public List<KprLogicalComponentJoinTableRelReqDto> getJoinTableRelList() {
		return joinTableRelList;
	}

	public void setJoinTableRelList(List<KprLogicalComponentJoinTableRelReqDto> joinTableRelList) {
		this.joinTableRelList = joinTableRelList;
	}

	public List<KprLogicalComponentJoinColumnReqDto> getJoinColumnList() {
		return joinColumnList;
	}

	public void setJoinColumnList(List<KprLogicalComponentJoinColumnReqDto> joinColumnList) {
		this.joinColumnList = joinColumnList;
	}

	public List<KprLogicalComponentAttributeGroupReqDto> getAtribGroupList() {
		return atribGroupList;
	}

	public void setAtribGroupList(List<KprLogicalComponentAttributeGroupReqDto> atribGroupList) {
		this.atribGroupList = atribGroupList;
	}

	public List<KprLogicalComponentAttributeGroupColumnReqDto> getAtribGroupColumnList() {
		return atribGroupColumnList;
	}

	public void setAtribGroupColumnList(List<KprLogicalComponentAttributeGroupColumnReqDto> atribGroupColumnList) {
		this.atribGroupColumnList = atribGroupColumnList;
	}

	public List<KprLogicalComponentGroupColumnReqDto> getJoinColumnGrpList() {
		return joinColumnGrpList;
	}

	public void setJoinColumnGrpList(List<KprLogicalComponentGroupColumnReqDto> joinColumnGrpList) {
		this.joinColumnGrpList = joinColumnGrpList;
	}
}