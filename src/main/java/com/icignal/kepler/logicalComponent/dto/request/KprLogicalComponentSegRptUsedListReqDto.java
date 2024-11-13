package com.icignal.kepler.logicalComponent.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentSegRptUsedListRequestDTO
 * 2. 파일명	: KPRLogicalComponentSegRptUsedListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		분석/세그먼트 적용 리스트 요청 DTO
 * </PRE>
 */ 
@JsonIgnoreProperties(ignoreUnknown = true)
public class KprLogicalComponentSegRptUsedListReqDto extends CommonDataAuthReqDto {

	/**    아이디    */    private String  lgcCompId= "";
	/**    아이디    */    private String  objId= "";
	/**    타입    */    private String  objType= "";
	/**    명칭    */    private String  objNm= "";
	/**    생성일    */    private String  createDate= "";
	/**    생성자   */    private String  createBy= "";
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public String getObjType() {
		return objType;
	}
	public void setObjType(String objType) {
		this.objType = objType;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	
}