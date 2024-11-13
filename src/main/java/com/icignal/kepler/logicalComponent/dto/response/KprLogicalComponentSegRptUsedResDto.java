package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentSegRptUsedResponseDTO
 * 2. 파일명	: KPRLogicalComponentSegRptUsedResponseDTO.java
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
public class KprLogicalComponentSegRptUsedResDto extends GridPagingItemResDto {

	/**    아이디    */    private String  objId= "";
	/**    타입    */    private String  objType= "";
	/**    명칭    */    private String  objNm= "";
	
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