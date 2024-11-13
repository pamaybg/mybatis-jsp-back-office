package com.icignal.systemmanagement.banner.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImageResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class SystemBannerDetailResDto{

	private String bannerStatus;
	private String bannerTitle;
	private String bannerDesc;
	private String openDate;

	private String bannerLang;

	private String bannerSubId;

	//이미지 업로드
	private String imageUrl;
	private MultiImageResDto imageMUrl;
	private List<MultiImageResDto> images;
	private String oriName;
	private String type;
	private String bannerSeq;

	public String getBannerSeq() {
		return bannerSeq;
	}
	public void setBannerSeq(String bannerSeq) {
		this.bannerSeq = bannerSeq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	//다중 이미지 업로드를 위한 세팅
	public List<MultiImageResDto> getImages() {
		if(this.images == null) {
			this.images = new ArrayList<>();
		} else {
			for (MultiImageResDto multiImage : images) {
				ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
			}
		}
		return images;
	}
	public void setImages(List<MultiImageResDto> images) {
		this.images = images;
	}
	public String getImageUrl() {
		if(this.imageUrl != null && this.imageUrl.length() > 0 && !this.imageUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.imageMUrl = new MultiImageResDto();
			ImageUtil.setMultiImages(this.imageUrl, this.imageMUrl);
			this.imageUrl = CommonUtil.getInstance().getImageServerUrl() + "/" + this.imageUrl;
		}

		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public MultiImageResDto getImageMUrl() {
		return imageMUrl;
	}
	public void setImageMUrl(MultiImageResDto imageMUrl) {
		this.imageMUrl = imageMUrl;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}



	public String getBannerStatus() {
		return bannerStatus;
	}

	public void setBannerStatus(String bannerStatus) {
		this.bannerStatus = bannerStatus;
	}

	public String getBannerTitle() {
		return bannerTitle;
	}

	public void setBannerTitle(String bannerTitle) {
		this.bannerTitle = bannerTitle;
	}

	public String getBannerDesc() {
		return bannerDesc;
	}

	public void setBannerDesc(String bannerDesc) {
		this.bannerDesc = bannerDesc;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getBannerLang() {
		return bannerLang;
	}

	public void setBannerLang(String bannerLang) {
		this.bannerLang = bannerLang;
	}

	public String getBannerSubId() {
		return bannerSubId;
	}

	public void setBannerSubId(String bannerSubId) {
		this.bannerSubId = bannerSubId;
	}

}
