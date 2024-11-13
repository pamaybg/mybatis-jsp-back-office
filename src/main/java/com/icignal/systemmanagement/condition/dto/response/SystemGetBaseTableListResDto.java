package com.icignal.systemmanagement.condition.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : getTableList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 테이블 목록 조회
 */
public class SystemGetBaseTableListResDto extends GridPagingItemResDto {
	
	private String id; 			//테이블 아이디
	private String tableName; 	//테이블 명
	private String tableCode;	//테이블 코드
	private String tableDesc;	//테이블 설명
	private String tblEngNm;
	private String tblKorNm;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableCode() {
		return tableCode;
	}
	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
	}
	public String getTableDesc() {
		return tableDesc;
	}
	public void setTableDesc(String tableDesc) {
		this.tableDesc = tableDesc;
	}
	public String getTblEngNm() {
		return tblEngNm;
	}
	public void setTblEngNm(String tblEngNm) {
		this.tblEngNm = tblEngNm;
	}
	public String getTblKorNm() {
		return tblKorNm;
	}
	public void setTblKorNm(String tblKorNm) {
		this.tblKorNm = tblKorNm;
	}
	
	
}
