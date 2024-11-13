package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 컬럼등록 RequestDTO
 */
public class KprSetIdxColListReqDto extends CommonDataAuthReqDto {
	
	private String idxColId;    		//인덱스컬럼 아이디
	private String idxId;    			//인덱스 아이디
    private String accountId;   	//어카운트 아이디
    private String createBy;     	//생성자
    private String modifyBy;     	//수정자

    private String colNm;     		//컬럼명
    private String orderTypeCd;  //정렬타입
    private int seq;    				//순서
    
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
