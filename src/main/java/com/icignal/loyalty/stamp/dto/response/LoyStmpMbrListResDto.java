package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpMbrListResponseDTO
* @date : 2019. 3. 6.
* @author : hy.jun
* @description :
*/
public class LoyStmpMbrListResDto extends GridPagingItemResDto {
	
	private static final long serialVersionUID = -8143682997298538923L;

	private String rid;
	private String mbrNo;
	private String custNm;
	private String webId;
	private String mbrStatCdNm;
	private String stmpJoinDt;
	private String stmpLastAcrlDt; //최근이용일시
	private String stmpMbrStatNm;
	private String stmpMbrBnft;
	private String stmpMbrCnt;
	private int purAmt; //구매금액
	private int purCnt; //방문횟수
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getStmpJoinDt() {
		return stmpJoinDt;
	}
	public void setStmpJoinDt(String stmpJoinDt) {
		this.stmpJoinDt = stmpJoinDt;
	}
	public String getStmpMbrStatNm() {
		return stmpMbrStatNm;
	}
	public void setStmpMbrStatNm(String stmpMbrStatNm) {
		this.stmpMbrStatNm = stmpMbrStatNm;
	}
	public String getStmpMbrBnft() {
		return stmpMbrBnft;
	}
	public void setStmpMbrBnft(String stmpMbrBnft) {
		this.stmpMbrBnft = stmpMbrBnft;
	}
	public int getPurAmt() {
		return purAmt;
	}
	public void setPurAmt(int purAmt) {
		this.purAmt = purAmt;
	}
	public int getPurCnt() {
		return purCnt;
	}
	public void setPurCnt(int purCnt) {
		this.purCnt = purCnt;
	}
	public String getStmpMbrCnt() {
		return stmpMbrCnt;
	}
	public void setStmpMbrCnt(String stmpMbrCnt) {
		this.stmpMbrCnt = stmpMbrCnt;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getStmpLastAcrlDt() {
		return stmpLastAcrlDt;
	}
	public void setStmpLastAcrlDt(String stmpLastAcrlDt) {
		this.stmpLastAcrlDt = stmpLastAcrlDt;
	}
}
