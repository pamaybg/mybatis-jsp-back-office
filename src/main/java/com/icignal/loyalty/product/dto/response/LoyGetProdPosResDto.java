package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

/*
 * 1. 클래스명	: LoyGetProdPosResDto
 * 2. 파일명	: LoyGetProdPosResDto
 * 3. 패키지명	: com.icignal.loyalty.product.dto.response
 * 4. 작성자명	: LEE GYEONG YOUNG 
 * 5. 작성일자	: 2020. 11. 19. 
 */

@CommCode
public class LoyGetProdPosResDto extends GridPagingItemResDto {
	//락앤락 신규
	private String msNo;
	private String msNm;
	private String goodsCd;
	private String goodsPriceFg;
	private String startDate;
	private String endDate;
	private String prePrice;
	private String aftPrice;
	private String goodsControlFg;
	public String getMsNo() {
		return msNo;
	}
	public void setMsNo(String msNo) {
		this.msNo = msNo;
	}
	public String getMsNm() {
		return msNm;
	}
	public void setMsNm(String msNm) {
		this.msNm = msNm;
	}
	public String getGoodsCd() {
		return goodsCd;
	}
	public void setGoodsCd(String goodsCd) {
		this.goodsCd = goodsCd;
	}
	public String getGoodsPriceFg() {
		return goodsPriceFg;
	}
	public void setGoodsPriceFg(String goodsPriceFg) {
		this.goodsPriceFg = goodsPriceFg;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getPrePrice() {
		return prePrice;
	}
	public void setPrePrice(String prePrice) {
		this.prePrice = prePrice;
	}
	public String getAftPrice() {
		return aftPrice;
	}
	public void setAftPrice(String aftPrice) {
		this.aftPrice = aftPrice;
	}
	public String getGoodsControlFg() {
		return goodsControlFg;
	}
	public void setGoodsControlFg(String goodsControlFg) {
		this.goodsControlFg = goodsControlFg;
	}
}
