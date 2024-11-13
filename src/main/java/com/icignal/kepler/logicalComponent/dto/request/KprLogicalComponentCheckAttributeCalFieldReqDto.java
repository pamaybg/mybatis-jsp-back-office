package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentCheckAttributeCalFieldRequestDTO
 * 2. 파일명	: KPRLogicalComponentCheckAttributeCalFieldRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 설정 > 변환 필드 작동 확인 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentCheckAttributeCalFieldReqDto extends BaseReqDto {
	
	/**    아이디    */    private String  lgcCompId= "";
	/**    변환필드    */    private String  calDtl= "";
	/**    DB 서비스 ID    */    private String  dbInformId= "";
	
	/**    테이블 명 Alias List */ private List<String> tblNmAliasList;
	
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public List<String> getTblNmAliasList() {
		return tblNmAliasList;
	}
	public void setTblNmAliasList(List<String> tblNmAliasList) {
		this.tblNmAliasList = tblNmAliasList;
	}
	public String getCalDtl() {
		return calDtl;
	}
	public void setCalDtl(String calDtl) {
		this.calDtl = calDtl;
	}
	
}