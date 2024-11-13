package com.icignal.systemmanagement.banner.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemBannerReqDto extends CommonCondReqDto {
	
	private String bannerId;
	private String bannerStatus;
	private String bannerTitle;
	private String bannerDesc;
	private String bannerLang;
	private String bannerSubId;
	private String openDate;
	private List<String> imageId;
	private String type;



	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public List<String> getImageId() {
		return imageId;
	}

	public void setImageId(List<String> imageId) {
		this.imageId = imageId;
	}

	public String getBannerId() {
		return bannerId;
	}

	public void setBannerId(String bannerId) {
		this.bannerId = bannerId;
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
