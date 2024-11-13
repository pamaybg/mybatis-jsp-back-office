package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 2.
 * @author : LEE
 * @description : 인덱스 고급설정 수정 RequestDTO
 */
public class KprEditIdxAdvanceReqDto extends CommonDataAuthReqDto {
	
    private String idxId;    //DB정보 아이디
    private String modifyBy;     //수정자
    
	private Integer pctfree; //접속 PORT
	private Integer initrans; //접속 PORT
	private Integer maxtrans; //접속 PORT
	private Integer initial; //접속 PORT
	private Integer next; //접속 PORT
	private Integer minextents; //접속 PORT
	private Integer maxextents; //접속 PORT
	private Integer bufferPool; //접속 PORT
	private Integer loggingYn; //접속 PORT
	private Integer compressYn; //접속 PORT
	private Integer parallelYn; //접속 PORT
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
	public Integer getPctfree() {
		return pctfree;
	}
	public void setPctfree(Integer pctfree) {
		this.pctfree = pctfree;
	}
	public Integer getInitrans() {
		return initrans;
	}
	public void setInitrans(Integer initrans) {
		this.initrans = initrans;
	}
	public Integer getMaxtrans() {
		return maxtrans;
	}
	public void setMaxtrans(Integer maxtrans) {
		this.maxtrans = maxtrans;
	}
	public Integer getInitial() {
		return initial;
	}
	public void setInitial(Integer initial) {
		this.initial = initial;
	}
	public Integer getNext() {
		return next;
	}
	public void setNext(Integer next) {
		this.next = next;
	}
	public Integer getMinextents() {
		return minextents;
	}
	public void setMinextents(Integer minextents) {
		this.minextents = minextents;
	}
	public Integer getMaxextents() {
		return maxextents;
	}
	public void setMaxextents(Integer maxextents) {
		this.maxextents = maxextents;
	}
	public Integer getBufferPool() {
		return bufferPool;
	}
	public void setBufferPool(Integer bufferPool) {
		this.bufferPool = bufferPool;
	}
	public Integer getLoggingYn() {
		return loggingYn;
	}
	public void setLoggingYn(Integer loggingYn) {
		this.loggingYn = loggingYn;
	}
	public Integer getCompressYn() {
		return compressYn;
	}
	public void setCompressYn(Integer compressYn) {
		this.compressYn = compressYn;
	}
	public Integer getParallelYn() {
		return parallelYn;
	}
	public void setParallelYn(Integer parallelYn) {
		this.parallelYn = parallelYn;
	}
	
	
}
