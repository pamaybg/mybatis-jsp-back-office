package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LOYgetCategoryListResponseDTO
 * 2. 파일명	: LOYgetCategoryListResponseDTO.java
 * 3. 패키지명	: com.icignal.loyalty.product.dto.response
 * 4. 작성자명	: wjlee 
 * 5. 작성일자	: 2016. 12. 9. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyGetCategoryListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridPgm;           //RID 프로그램
	private String parRid;           //PAR_RID
	private String parCatId; 
	private String parCatNm; 
	private String catId;            //범주 ID
	private String catNm;            //범주 명
	private String catDesctxt;       //범주 설명
	private String createBy; 
	private String createDate;
	private String modifyBy;
	private String modifyDate;
	private String brdNm;

	private Integer cnt;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getParCatId() {
		return parCatId;
	}
	public void setParCatId(String parCatId) {
		this.parCatId = parCatId;
	}
	public String getParCatNm() {
		return parCatNm;
	}
	public void setParCatNm(String parCatNm) {
		this.parCatNm = parCatNm;
	}
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getCatDesctxt() {
		return catDesctxt;
	}
	public void setCatDesctxt(String catDesctxt) {
		this.catDesctxt = catDesctxt;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}
	public String getBrdNm() {return brdNm;}
	public void setBrdNm(String brdNm) {this.brdNm = brdNm;}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
}