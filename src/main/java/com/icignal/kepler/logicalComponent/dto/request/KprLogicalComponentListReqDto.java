package com.icignal.kepler.logicalComponent.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentListRequestDTO
 * 2. 파일명	: KPRLogicalComponentListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 리스트 요청 DTO
 * </PRE>
 */ 
@JsonIgnoreProperties(ignoreUnknown = true)
public class KprLogicalComponentListReqDto extends CommonDataAuthReqDto {

	/**    아이디    */    private String  lgcCompId= "";
	/**    생성자    */    private String  createBy= "";
	/**    수정자    */    private String  modifyBy= "";
	/**    생성일시    */    private String  createDate= "";
	/**    수정일시    */    private String  modifyDate= "";
	/**    삭제여부    */    private String  flag= "";
	/**    유형    */    private String  type= "";
	/**    스토어ID    */    private String  storeId= "";
	/**    로지컬컴포넌트명    */    private String  lgcCompNm= "";
	/**    설명    */    private String  lgcDesc= "";
	/**    로지컬컴포넌트의 최종 SQL    */    private String  lgcSql= "";
	/**    로지컬컴포넌트 사용가능여부    */    private String  cmpltYn= "";
	/**    주제영역DB관계ID    */    private String  dbInformId= "";
	
	/**    생성자    */    private String  name= "";

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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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