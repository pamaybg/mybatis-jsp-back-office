package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 수정 RequestDTO
 */
public class KprEditIdxListReqDto extends CommonDataAuthReqDto {
	
    private String idxId;    //테이블정보 아이디
    private String tableId;    //테이블정보 아이디
    private String modifyBy;     //수정자
    
	private String idxNm; //주제영역DB 아이디
	private String tblSpaceNm; //DB유형
	private String unqYn; //디스플레이명
	
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public String getIdxId() {
		return idxId;
	}
	public void setIdxId(String idxId) {
		this.idxId = idxId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getIdxNm() {
		return idxNm;
	}
	public void setIdxNm(String idxNm) {
		this.idxNm = idxNm;
	}
	public String getTblSpaceNm() {
		return tblSpaceNm;
	}
	public void setTblSpaceNm(String tblSpaceNm) {
		this.tblSpaceNm = tblSpaceNm;
	}
	public String getUnqYn() {
		return unqYn;
	}
	public void setUnqYn(String unqYn) {
		this.unqYn = unqYn;
	}
	
}
