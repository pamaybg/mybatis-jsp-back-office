package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinColumnRequestDTO
 * 2. 파일명	: KPRLogicalComponentJoinColumnRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인칼럼 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinColumnReqDto extends CommonDataAuthReqDto {
	
	/**    아이디    */    private String  joinColumnId= "";
	/**    임시 아이디    */    private String  tempJoinColumnId= "";
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
	/**    조인유형코드 Inner,Left Oute,Right Outer    */    private String  joinTypeCd= "";
	/**    순서    */    private String  seq= "";
	/**    좌측_로지컬컴포넌트_테이블_REL_ID    */    private String  leftLgcCompTblRelId= "";
	/**    좌측_컬럼_ID    */    private String  leftColId= "";
	/**    좌측_테이블ALIAS_컬럼명 ex) T1.컬럼명    */    private String leftTblAliasColNm= "";
	/**    조인연산자코드 =, >, >=, <, <=    */    private String  joinOprtCd= "";
	/**    우측_로지컬컴포넌트_테이블_REL_ID    */    private String  rightLgcCompTblRelId= "";
	/**    우측_컬럼_ID    */    private String  rightColId= "";
	/**    우측_테이블ALIAS_컬럼명 ex) T1.컬럼명    */    private String  rightTblAliasColNm= "";
	
	public String getJoinColumnId() {
		return joinColumnId;
	}
	public void setJoinColumnId(String joinColumnId) {
		this.joinColumnId = joinColumnId;
	}
	public String getTempJoinColumnId() {
		return tempJoinColumnId;
	}
	public void setTempJoinColumnId(String tempJoinColumnId) {
		this.tempJoinColumnId = tempJoinColumnId;
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
	public String getJoinTypeCd() {
		return joinTypeCd;
	}
	public void setJoinTypeCd(String joinTypeCd) {
		this.joinTypeCd = joinTypeCd;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getLeftLgcCompTblRelId() {
		return leftLgcCompTblRelId;
	}
	public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
		this.leftLgcCompTblRelId = leftLgcCompTblRelId;
	}
	public String getLeftColId() {
		return leftColId;
	}
	public void setLeftColId(String leftColId) {
		this.leftColId = leftColId;
	}
	public String getLeftTblAliasColNm() {
		return leftTblAliasColNm;
	}
	public void setLeftTblAliasColNm(String leftTblAliasColNm) {
		this.leftTblAliasColNm = leftTblAliasColNm;
	}
	public String getJoinOprtCd() {
		return joinOprtCd;
	}
	public void setJoinOprtCd(String joinOprtCd) {
		this.joinOprtCd = joinOprtCd;
	}
	public String getRightLgcCompTblRelId() {
		return rightLgcCompTblRelId;
	}
	public void setRightLgcCompTblRelId(String rightLgcCompTblRelId) {
		this.rightLgcCompTblRelId = rightLgcCompTblRelId;
	}
	public String getRightColId() {
		return rightColId;
	}
	public void setRightColId(String rightColId) {
		this.rightColId = rightColId;
	}
	public String getRightTblAliasColNm() {
		return rightTblAliasColNm;
	}
	public void setRightTblAliasColNm(String rightTblAliasColNm) {
		this.rightTblAliasColNm = rightTblAliasColNm;
	}

}