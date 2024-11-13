package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 컬럼 ResponsDTO
 */
public class KprGetIdxColListResDto extends StatusResDto {
	
    private String idxColId;     		//인덱스 컬럼 아이디
    private String idxId;    		 		//인덱스 아이디
    private String createByName;     //생성자명
    private String createDate;     	//생성일시
    private String colNm;     			//컬럼명
    private String orderTypeCd;    	//정렬
    private Integer seq;  				//순서

    private int cnt;  						//중복명cnt

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

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
    

}
