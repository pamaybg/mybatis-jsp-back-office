package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 등록 RequestDTO
 */
public class KprSetIdxListReqDto extends CommonDataAuthReqDto {
	
	private String idxId;    				//인덱스 아이디
	private String tableId;    			//테이블 아이디
    private String accountId;   		//어카운트 아이디
    private String createBy;     		//생성자
    private String modifyBy;     		//수정자

    private String idxNm;     			//인덱스명
    private String tblSpaceNm;    	//저장공간명
    private String unqYn;    			//Unique여부
    
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
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
