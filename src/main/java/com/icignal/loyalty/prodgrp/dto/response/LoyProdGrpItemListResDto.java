/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpItemListResDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오전 9:27:21
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyProdGrpItemListResDto
 * 2. 파일명	: LoyProdGrpItemListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyProdGrpItemListResDto extends GridPagingItemResDto{
	private String prodId;
	private String prodNm;
	private String createDate;
	private String name;
	private String rid;

	//락앤락 신규
	private String mmZzstdItemCd;
	private String mmZzItemCd;
	private String mmZzRepCd1;
	private String mmZzRepCd2;
	private String mmSkuCd;
	private String shGoodsNo;
	private String shGoodsCode;
	private String	shGoodsName;
	private String	mmMtart;
	private String	mmCate1;
	private String	mmCate2;
	private String	mmCate3;
	private String	mmPrdha;
	private String	mmGroup;
	private String	sdP1Price;
	private String	sdP1Unit;
	private String	mmFstDate;
	private String	scmGrade;
	private String	lpc_mm_cate;
	
	
	
	public String getMmZzstdItemCd() {
		return mmZzstdItemCd;
	}
	public void setMmZzstdItemCd(String mmZzstdItemCd) {
		this.mmZzstdItemCd = mmZzstdItemCd;
	}
	public String getMmZzItemCd() {
		return mmZzItemCd;
	}
	public void setMmZzItemCd(String mmZzItemCd) {
		this.mmZzItemCd = mmZzItemCd;
	}
	public String getMmZzRepCd1() {
		return mmZzRepCd1;
	}
	public void setMmZzRepCd1(String mmZzRepCd1) {
		this.mmZzRepCd1 = mmZzRepCd1;
	}
	public String getMmZzRepCd2() {
		return mmZzRepCd2;
	}
	public void setMmZzRepCd2(String mmZzRepCd2) {
		this.mmZzRepCd2 = mmZzRepCd2;
	}
	public String getMmSkuCd() {
		return mmSkuCd;
	}
	public void setMmSkuCd(String mmSkuCd) {
		this.mmSkuCd = mmSkuCd;
	}
	public String getShGoodsNo() {
		return shGoodsNo;
	}
	public void setShGoodsNo(String shGoodsNo) {
		this.shGoodsNo = shGoodsNo;
	}
	public String getShGoodsCode() {
		return shGoodsCode;
	}
	public void setShGoodsCode(String shGoodsCode) {
		this.shGoodsCode = shGoodsCode;
	}
	public String getShGoodsName() {
		return shGoodsName;
	}
	public void setShGoodsName(String shGoodsName) {
		this.shGoodsName = shGoodsName;
	}
	public String getMmMtart() {
		return mmMtart;
	}
	public void setMmMtart(String mmMtart) {
		this.mmMtart = mmMtart;
	}
	public String getMmCate1() {
		return mmCate1;
	}
	public void setMmCate1(String mmCate1) {
		this.mmCate1 = mmCate1;
	}
	public String getMmCate2() {
		return mmCate2;
	}
	public void setMmCate2(String mmCate2) {
		this.mmCate2 = mmCate2;
	}
	public String getMmCate3() {
		return mmCate3;
	}
	public void setMmCate3(String mmCate3) {
		this.mmCate3 = mmCate3;
	}
	public String getMmPrdha() {
		return mmPrdha;
	}
	public void setMmPrdha(String mmPrdha) {
		this.mmPrdha = mmPrdha;
	}
	public String getMmGroup() {
		return mmGroup;
	}
	public void setMmGroup(String mmGroup) {
		this.mmGroup = mmGroup;
	}
	public String getSdP1Price() {
		return sdP1Price;
	}
	public void setSdP1Price(String sdP1Price) {
		this.sdP1Price = sdP1Price;
	}
	public String getSdP1Unit() {
		return sdP1Unit;
	}
	public void setSdP1Unit(String sdP1Unit) {
		this.sdP1Unit = sdP1Unit;
	}
	public String getMmFstDate() {
		return mmFstDate;
	}
	public void setMmFstDate(String mmFstDate) {
		this.mmFstDate = mmFstDate;
	}
	public String getScmGrade() {
		return scmGrade;
	}
	public void setScmGrade(String scmGrade) {
		this.scmGrade = scmGrade;
	}
	public String getLpc_mm_cate() {
		return lpc_mm_cate;
	}
	public void setLpc_mm_cate(String lpc_mm_cate) {
		this.lpc_mm_cate = lpc_mm_cate;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
