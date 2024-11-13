package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.common.log.dto.response.ICNLoginHistoryResponseDTO
 * @date : 2019. 01. 28.
 * @author : "dw.keum"
 * @description : 공통 조회 조건 이력 Response
 */

@PersonalData
public class SystemCondLogHistoryResDto extends GridPagingItemResDto{
	
	private String rid;				//로그 ID
//	@excelDown(fieldName ="메뉴명")
	private String pgmNm;			//메뉴명
	private String srchCondDpVal;	//조회조건
	private int rsltCnt;			//조회결과 건수
	private String name;			//조회자
	private String userId;			//아이디
	private String srchDt;			//조회일시
	private String createDate;
	private String menuNm;

	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	
	private String custRid;
	
	@Decrypted(masked = "none")
	private String noneMskCustNm;
	@Decrypted(masked = "none")
	private String noneMskHhp;
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getSrchCondDpVal() {
		return srchCondDpVal;
	}
	public void setSrchCondDpVal(String srchCondDpVal) {
		this.srchCondDpVal = srchCondDpVal;
	}
	public int getRsltCnt() {
		return rsltCnt;
	}
	public void setRsltCnt(int rsltCnt) {
		this.rsltCnt = rsltCnt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSrchDt() {
		return srchDt;
	}
	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getNoneMskCustNm() {
		return noneMskCustNm;
	}
	public void setNoneMskCustNm(String noneMskCustNm) {
		this.noneMskCustNm = noneMskCustNm;
	}
	public String getNoneMskHhp() {
		return noneMskHhp;
	}
	public void setNoneMskHhp(String noneMskHhp) {
		this.noneMskHhp = noneMskHhp;
	}
	public String getMenuNm() {return menuNm;}
	public void setMenuNm(String menuNm) {this.menuNm = menuNm;}
	
}
