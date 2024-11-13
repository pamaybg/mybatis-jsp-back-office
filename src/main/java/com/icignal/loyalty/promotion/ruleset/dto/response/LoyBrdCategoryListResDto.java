package com.icignal.loyalty.promotion.ruleset.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : LOYLoyBrdCategoryListResponseDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 브랜드 카테고리 목록 ResponseDTO
 */
public class LoyBrdCategoryListResDto extends GridPagingItemResDto {
	
	private String rid;              //RID
	private String brdId;            //브랜드 ID
	private String brdNm;            //브랜드 명
	private String brdDesctxt;       //브랜드 설명
	private String parRid;           //PAR_RID
	private String createDate;       //생성일시
	private String createByNm;         //CREATE_BY
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getBrdId() {
		return brdId;
	}

	public void setBrdId(String brdId) {
		this.brdId = brdId;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getBrdDesctxt() {
		return brdDesctxt;
	}

	public void setBrdDesctxt(String brdDesctxt) {
		this.brdDesctxt = brdDesctxt;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}
}
