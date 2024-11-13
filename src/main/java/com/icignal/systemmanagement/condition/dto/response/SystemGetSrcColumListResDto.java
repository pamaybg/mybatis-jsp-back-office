package com.icignal.systemmanagement.condition.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : getTableList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 테이블 목록 조회
 */
public class SystemGetSrcColumListResDto extends GridPagingItemResDto {
	
	private String id; 			//테이블 컬럼 아이디
	private String colName; 	//테이블 컬럼 명
	private String colCode;		//테이블 컬럼 코드
	private String colDesc;		//테이블 컬럼 설명
	private String colEngNm;
	private String colKorNm;
	private String srchCondDesc;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public String getColCode() {
		return colCode;
	}
	public void setColCode(String colCode) {
		this.colCode = colCode;
	}
	public String getColDesc() {
		return colDesc;
	}
	public void setColDesc(String colDesc) {
		this.colDesc = colDesc;
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
	public String getSrchCondDesc() {
		return srchCondDesc;
	}
	public void setSrchCondDesc(String srchCondDesc) {
		this.srchCondDesc = srchCondDesc;
	}
	
	
}
