package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 컬럼 수정 RequestDTO
 */
public class KprEditIdxColListReqDto extends CommonDataAuthReqDto {
	
    private String idxColId;    //테이블정보 아이디
    private String idxId;    //테이블정보 아이디
    private String modifyBy;     //수정자
    
	private String colNm; //주제영역DB 아이디
	private String orderTypeCd; //DB유형
	private int seq; //디스플레이명
	
	public String getIdxColId() {
		return idxColId;
	}
	public void setIdxColId(String idxColId) {
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
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getOrderTypeCd() {
		return orderTypeCd;
	}
	public void setOrderTypeCd(String orderTypeCd) {
		this.orderTypeCd = orderTypeCd;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
}
