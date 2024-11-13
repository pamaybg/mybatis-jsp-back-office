package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupColumnRequestDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupColumnRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 칼럼 칼럼 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupColumnReqDto extends BaseReqDto {
	
	/**    아이디    */    private String  attributeGroupColumnId= "";
	/**    아이디    */    private String  tempAttributeGroupColumnId= "";
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
	/**    컬럼 순서 Attribute Group별 순서    */    private String  seq= "";
	/**    로지컬컴포넌트 테이블 REL ID    */    private String  lgcCompTblRelId= "";
	/**    컬럼 ID    */    private String  colId= "";
	/**    디스플레이명(한글컬럼명)    */    private String  dpNm= "";
	/**    디멘전컬럼 ID    */    private String  dimColId= "";
	/**    변환식 한글테이블명,필드명으로 구성 ex) 구매테이블2.상품수/구매테이블2.구매횟수    */    private String  calDtl= "";
	/**    Cal Dtl을 만들 때 화면에서 사용하던 Buffer */    private String  calDtlHis= "";
	/**    테이블 ALIAS+컬럼명 1. 변환필드가 아닐 때,--->영문테이블Alias,컬럼명 ex) T1.컬럼명 
	 * 					2. 변환필드 일 때, ---> 변환식(영문테이블Alias,컬럼명으로 구성) ex) T1.컬럼명1/T2.컬럼명2    */
	private String  tblAliasColNm= "";
	/**    변환필드여부    */ private String  calColYn= "";
	/**    어트리뷰트그룹 ID */ private String  atribGroupId= "";
	/**    세그먼트키여부 */ private String  segKeyYn= "";
	/**    이벤트트리거키여부 */ private String  evtTriggerKeyYn= "";
	/**    로지컬 컴포넌트 ID */ private String  lgcCompId= "";
	/**    해당 컬럼의 유니크 Alias */ private String colAlias = "";
	/**    기준일자 키여부 */ private String  dateKeyYn= "";
	/**    선택형 query */ private String  sqlValue= "";


	public String getSqlValue() {
		return sqlValue;
	}
	public void setSqlValue(String sqlValue) {
		this.sqlValue = sqlValue;
	}
	public String getEvtTriggerKeyYn() {
        return evtTriggerKeyYn;
    }
    public void setEvtTriggerKeyYn(String evtTriggerKeyYn) {
        this.evtTriggerKeyYn = evtTriggerKeyYn;
    }
    public String getDateKeyYn() {
		return dateKeyYn;
	}
	public void setDateKeyYn(String dateKeyYn) {
		this.dateKeyYn = dateKeyYn;
	}
	public String getTempAttributeGroupColumnId() {
		return tempAttributeGroupColumnId;
	}
	public void setTempAttributeGroupColumnId(String tempAttributeGroupColumnId) {
		this.tempAttributeGroupColumnId = tempAttributeGroupColumnId;
	}
	public String getColAlias() {
		return colAlias;
	}
	public void setColAlias(String colAlias) {
		this.colAlias = colAlias;
	}
	public String getCalDtlHis() {
		return calDtlHis;
	}
	public void setCalDtlHis(String calDtlHis) {
		this.calDtlHis = calDtlHis;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getAttributeGroupColumnId() {
		return attributeGroupColumnId;
	}
	public void setAttributeGroupColumnId(String attributeGroupColumnId) {
		this.attributeGroupColumnId = attributeGroupColumnId;
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
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getLgcCompTblRelId() {
		return lgcCompTblRelId;
	}
	public void setLgcCompTblRelId(String lgcCompTblRelId) {
		this.lgcCompTblRelId = lgcCompTblRelId;
	}
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getDpNm() {
		return dpNm;
	}
	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}
	public String getDimColId() {
		return dimColId;
	}
	public void setDimColId(String dimColId) {
		this.dimColId = dimColId;
	}
	public String getCalDtl() {
		return calDtl;
	}
	public void setCalDtl(String calDtl) {
		this.calDtl = calDtl;
	}
	public String getTblAliasColNm() {
		return tblAliasColNm;
	}
	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}
	public String getCalColYn() {
		return calColYn;
	}
	public void setCalColYn(String calColYn) {
		this.calColYn = calColYn;
	}
	public String getAtribGroupId() {
		return atribGroupId;
	}
	public void setAtribGroupId(String atribGroupId) {
		this.atribGroupId = atribGroupId;
	}
	public String getSegKeyYn() {
		return segKeyYn;
	}
	public void setSegKeyYn(String segKeyYn) {
		this.segKeyYn = segKeyYn;
	}
	
}