package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 21.
 * @author : 이원준
 * @description : 인덱스 목록 ResponseDTO
 */
public class KprGetIdxListResDto extends StatusResDto {
	
    private String idxId;     				//인덱스 아이디
    private String createByName;     	//생성자명
    private String createDate;     		//생성일시
    private String idxNm;     				//인덱스명
    private String tblSpaceNm;    		//저장공간명
    private String unqYn;  					//Unique 여부

    private int cnt;  							//중복명cnt

    private Integer pctfree;  				//PCTFREE
    private Integer initrans;  				//INITRANS
    private Integer maxtrans;  			//MAXTRANS
    private Integer initial;  					//INITIAL
    private Integer next;  					//NEXT
    private Integer minextents;  			//MINEXTENTS
    private Integer maxextents;  			//MAXEXTENTS
    private String bufferPool;  			//BUFFER_POOL
    private String loggingYn;  			//LOGGING_YN
    private String compressYn;  			//COMPRESS_YN
    private String parallelYn;  				//PARALLEL_YN
    
	public String getIdxId() {
		return idxId;
	}
	public void setIdxId(String idxId) {
		this.idxId = idxId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
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
	public String getBufferPool() {
		return bufferPool;
	}
	public void setBufferPool(String bufferPool) {
		this.bufferPool = bufferPool;
	}
	public String getLoggingYn() {
		return loggingYn;
	}
	public void setLoggingYn(String loggingYn) {
		this.loggingYn = loggingYn;
	}
	public String getCompressYn() {
		return compressYn;
	}
	public void setCompressYn(String compressYn) {
		this.compressYn = compressYn;
	}
	public String getParallelYn() {
		return parallelYn;
	}
	public void setParallelYn(String parallelYn) {
		this.parallelYn = parallelYn;
	}
    
}
