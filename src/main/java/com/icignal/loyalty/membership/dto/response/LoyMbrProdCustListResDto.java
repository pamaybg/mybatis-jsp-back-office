package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyMbrProdCustListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String prodId;
	private String desc1;
	private String subject;
	private String score;
	private String regDate;
	
	private String prodNo;
	private String prodNm;
	
	private String modifyDate;
	private String mmZzitemCd;
	private String reviewTypeCd;
	@MarkName(groupCode = "REVIEW_TYPE_CD", codeField = "reviewTypeCd")
	private String reviewTypeCdName;
	
	private String uploadImgPath;
	private String ItemCd;
	private String goodsCode;
	
	
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getMmZzitemCd() {
		return mmZzitemCd;
	}
	public void setMmZzitemCd(String mmZzitemCd) {
		this.mmZzitemCd = mmZzitemCd;
	}
	public String getUploadImgPath() {
		return uploadImgPath;
	}
	public void setUploadImgPath(String uploadImgPath) {
		this.uploadImgPath = uploadImgPath;
	}
	public String getReviewTypeCd() {
		return reviewTypeCd;
	}
	public void setReviewTypeCd(String reviewTypeCd) {
		this.reviewTypeCd = reviewTypeCd;
	}
	public String getReviewTypeCdName() {
		return reviewTypeCdName;
	}
	public void setReviewTypeCdName(String reviewTypeCdName) {
		this.reviewTypeCdName = reviewTypeCdName;
	}
	public String getItemCd() {
		return ItemCd;
	}
	public void setItemCd(String itemCd) {
		ItemCd = itemCd;
	}

	
}
