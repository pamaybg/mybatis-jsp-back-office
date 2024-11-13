package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 인덱스 컬럼 삭제 RequestDTO
 */
public class KprDelIdxColListReqDto extends CommonDataAuthReqDto {
	
    private List<String> idxColId;    	//인덱스컬럼 아이디
    private List<String> idxId1;    		//인덱스 아이디
    private String idxId;     				//인덱스 아이디
    private String modifyBy;     			//수정자
    
	public List<String> getIdxId1() {
		return idxId1;
	}
	public void setIdxId1(List<String> idxId1) {
		this.idxId1 = idxId1;
	}
	public List<String> getIdxColId() {
		return idxColId;
	}
	public void setIdxColId(List<String> idxColId) {
		this.idxColId = idxColId;
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
    
}
