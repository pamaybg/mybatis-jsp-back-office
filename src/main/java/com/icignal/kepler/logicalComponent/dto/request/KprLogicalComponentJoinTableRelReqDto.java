package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinTableRelRequestDTO
 * 2. 파일명	: KPRLogicalComponentJoinTableRelRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인설정 > 테이블 관계 요청 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinTableRelReqDto extends CommonDataAuthReqDto {

	/** 아이디 */
	private String tblRelId = "";
	/** 임시 아이디 */
	private String tempTblRelId = "";
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
	/** 로지컬컴포넌트ID */
	private String lgcCompId = "";
	/** 로지컬컴포넌트 조인 컬럼ID */
	private String tblId = "";
	/** 스키마_테이블명 스키마.물리테이블명 */
	private String schmaTblNm = "";
	/** 테이블명 */
	private String tblNm = "";
	/** 테이블ALIAS */
	private String tblAlias = "";
	/** 화면 X 좌표 */
	private String offSetX = "";
	/** 화면 Y 좌표 */
	private String offSetY = "";

	private Integer tableSeq;

	public Integer getTableSeq() {
		return tableSeq;
	}

	public void setTableSeq(Integer tableSeq) {
		this.tableSeq = tableSeq;
	}

	public String getTblRelId() {
		return tblRelId;
	}

	public void setTblRelId(String tblRelId) {
		this.tblRelId = tblRelId;
	}

	public String getTempTblRelId() {
		return tempTblRelId;
	}

	public void setTempTblRelId(String tempTblRelId) {
		this.tempTblRelId = tempTblRelId;
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

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public String getTblId() {
		return tblId;
	}

	public void setTblId(String tblId) {
		this.tblId = tblId;
	}

	public String getSchmaTblNm() {
		return schmaTblNm;
	}

	public void setSchmaTblNm(String schmaTblNm) {
		this.schmaTblNm = schmaTblNm;
	}

	public String getTblNm() {
		return tblNm;
	}

	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}

	public String getTblAlias() {
		return tblAlias;
	}

	public void setTblAlias(String tblAlias) {
		this.tblAlias = tblAlias;
	}

	public String getOffSetX() {
		return offSetX;
	}

	public void setOffSetX(String offSetX) {
		this.offSetX = offSetX;
	}

	public String getOffSetY() {
		return offSetY;
	}

	public void setOffSetY(String offSetY) {
		this.offSetY = offSetY;
	}

}