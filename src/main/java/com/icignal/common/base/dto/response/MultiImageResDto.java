package com.icignal.common.base.dto.response;

import java.io.Serializable;

/**
   @file MultiImage.java
   @date 2013. 03. 15.
   @author 김정석
 */

public class MultiImageResDto implements Serializable {
	/*
	 * 1. 필드종류	: long
	 * 2. 필드명	: serialVersionUID
	 * 3. 작성자명	: knlee
	 * 4. 작성일자: 2020. 4. 13.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 */
	private static final long serialVersionUID = 1L;


	public MultiImageResDto() {
	}

	private String imageId;
	private int seq;
	private String imgOrgUrl;
	private String imgWebDetailUrl;
	private String imgWebNormalUrl;
	private String imgWebThumbUrl;
	private String imgMobileLargeDetailUrl;
	private String imgMobileLargeNormalUrl;
	private String imgMobileLargeThumbUrl;
	private String imgMobileSmallDetailUrl;
	private String imgMobileSmallNormalUrl;
	private String imgMobileSmallThumbUrl;
	private String oriName;
	

	public String getImgWebDetailUrl() {
		return imgWebDetailUrl;
	}
	public void setImgWebDetailUrl(String imgWebDetailUrl) {
		this.imgWebDetailUrl = imgWebDetailUrl;
	}
	public String getImgWebNormalUrl() {
		return imgWebNormalUrl;
	}
	public void setImgWebNormalUrl(String imgWebNormalUrl) {
		this.imgWebNormalUrl = imgWebNormalUrl;
	}
	public String getImgWebThumbUrl() {
		return imgWebThumbUrl;
	}
	public void setImgWebThumbUrl(String imgWebThumbUrl) {
		this.imgWebThumbUrl = imgWebThumbUrl;
	}
	public String getImgMobileLargeDetailUrl() {
		return imgMobileLargeDetailUrl;
	}
	public void setImgMobileLargeDetailUrl(String imgMobileLargeDetailUrl) {
		this.imgMobileLargeDetailUrl = imgMobileLargeDetailUrl;
	}
	public String getImgMobileLargeNormalUrl() {
		return imgMobileLargeNormalUrl;
	}
	public void setImgMobileLargeNormalUrl(String imgMobileLargeNormalUrl) {
		this.imgMobileLargeNormalUrl = imgMobileLargeNormalUrl;
	}
	public String getImgMobileLargeThumbUrl() {
		return imgMobileLargeThumbUrl;
	}
	public void setImgMobileLargeThumbUrl(String imgMobileLargeThumbUrl) {
		this.imgMobileLargeThumbUrl = imgMobileLargeThumbUrl;
	}
	public String getImgMobileSmallDetailUrl() {
		return imgMobileSmallDetailUrl;
	}
	public void setImgMobileSmallDetailUrl(String imgMobileSmallDetailUrl) {
		this.imgMobileSmallDetailUrl = imgMobileSmallDetailUrl;
	}
	public String getImgMobileSmallNormalUrl() {
		return imgMobileSmallNormalUrl;
	}
	public void setImgMobileSmallNormalUrl(String imgMobileSmallNormalUrl) {
		this.imgMobileSmallNormalUrl = imgMobileSmallNormalUrl;
	}
	public String getImgMobileSmallThumbUrl() {
		return imgMobileSmallThumbUrl;
	}
	public void setImgMobileSmallThumbUrl(String imgMobileSmallThumbUrl) {
		this.imgMobileSmallThumbUrl = imgMobileSmallThumbUrl;
	}
	public String getImgOrgUrl() {
		return imgOrgUrl;
	}
	public void setImgOrgUrl(String imgOrgUrl) {
		this.imgOrgUrl = imgOrgUrl;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}




}


