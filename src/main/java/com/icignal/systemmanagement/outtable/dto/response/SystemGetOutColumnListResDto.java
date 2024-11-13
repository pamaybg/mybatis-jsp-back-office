package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemGetOutColumnlListResDto
 * 2. 파일명	: SystemGetOutColumnlListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 컬럼 리스트 조회
 * </PRE>
 */ 
@CommCode
public class SystemGetOutColumnListResDto extends GridPagingItemResDto {
	
	private String id;   
	private String extrTblId;     //외부 테이블 ID
	private String colEngNm;     //컬럼영문명
	private String colKorNm;     //컬럼한글명
	private String colTypeCd;     //컬럼유형코드
	private String colSize;     //컬럼사이즈
	private String colDesc;     //컬럼 설명
	private String flagAtribVal;     //데이터 속성 값
	private String whereSchMemid;     //조회 조건 회원컬럼
	private String whereSchHp;     //조회 조건 핸드폰 컬럼
	private String whereSchEmail;     //조회 조건 이메일 컬럼 
	private String attrib01;     //컬럼 산출식
	private String prmsItemMappgCol;     //퍼미션 항목 매핑 컬럼
	
	@MarkName(codeField = "colTypeDefineCdNm", groupCode = "MKT_CAM_CHNL_TYPE_CD")
	private String colTypeDefine;        //컬럼 속성 정의
	
	private String colTypeDefineCdNm;
	private String secretNm;		//비밀명
	private String encColYn;	// 암호화컬럼여부
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExtrTblId() {
		return extrTblId;
	}
	public void setExtrTblId(String extrTblId) {
		this.extrTblId = extrTblId;
	}
	public String getColEngNm() {
		return colEngNm;
	}
	public void setColEngNm(String colEngNm) {
		this.colEngNm = colEngNm;
	}
	public String getColKorNm() {
		return colKorNm;
	}
	public void setColKorNm(String colKorNm) {
		this.colKorNm = colKorNm;
	}
	public String getColTypeCd() {
		return colTypeCd;
	}
	public void setColTypeCd(String colTypeCd) {
		this.colTypeCd = colTypeCd;
	}
	public String getColSize() {
		return colSize;
	}
	public void setColSize(String colSize) {
		this.colSize = colSize;
	}
	public String getColDesc() {
		return colDesc;
	}
	public void setColDesc(String colDesc) {
		this.colDesc = colDesc;
	}
	public String getFlagAtribVal() {
		return flagAtribVal;
	}
	public void setFlagAtribVal(String flagAtribVal) {
		this.flagAtribVal = flagAtribVal;
	}
	public String getWhereSchMemid() {
		return whereSchMemid;
	}
	public void setWhereSchMemid(String whereSchMemid) {
		this.whereSchMemid = whereSchMemid;
	}
	public String getWhereSchHp() {
		return whereSchHp;
	}
	public void setWhereSchHp(String whereSchHp) {
		this.whereSchHp = whereSchHp;
	}
	public String getWhereSchEmail() {
		return whereSchEmail;
	}
	public void setWhereSchEmail(String whereSchEmail) {
		this.whereSchEmail = whereSchEmail;
	}
	public String getAttrib01() {
		return attrib01;
	}
	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}
	public String getPrmsItemMappgCol() {
		return prmsItemMappgCol;
	}
	public void setPrmsItemMappgCol(String prmsItemMappgCol) {
		this.prmsItemMappgCol = prmsItemMappgCol;
	}
	public String getColTypeDefine() {
		return colTypeDefine;
	}
	public void setColTypeDefine(String colTypeDefine) {
		this.colTypeDefine = colTypeDefine;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	public String getColTypeDefineCdNm() {
		return colTypeDefineCdNm;
	}
	public void setColTypeDefineCdNm(String colTypeDefineCdNm) {
		this.colTypeDefineCdNm = colTypeDefineCdNm;
	}
	public String getEncColYn() {
		return encColYn;
	}
	public void setEncColYn(String encColYn) {
		this.encColYn = encColYn;
	}

	
	
}
