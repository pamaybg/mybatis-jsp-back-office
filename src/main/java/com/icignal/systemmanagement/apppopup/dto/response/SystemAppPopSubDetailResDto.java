package com.icignal.systemmanagement.apppopup.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class SystemAppPopSubDetailResDto extends StatusResDto {
	
	private String appPopName;
	private String appPopContent;
	private String popupObject;
	private String appPopSubId;

	//이미지 업로드
	private String imageUrl;
	private MultiImage imageMUrl;
	private List<MultiImage> images;
	private String oriName;
	
	
	//다중 이미지 업로드를 위한 세팅
	public List<MultiImage> getImages() {
		if(this.images == null) {
			this.images = new ArrayList<>();
		} else {
			for (MultiImage multiImage : images) {
				ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
			}
		}
		return images;
	}
	public void setImages(List<MultiImage> images) {
		this.images = images;
	}
	public String getImageUrl() {
		if(this.imageUrl != null && this.imageUrl.length() > 0 && !this.imageUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.imageMUrl = new MultiImage();
			ImageUtil.setMultiImages(this.imageUrl, this.imageMUrl);
			this.imageUrl = CommonUtil.getInstance().getImageServerUrl() + "/" + this.imageUrl;
		}

		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public MultiImage getImageMUrl() {
		return imageMUrl;
	}
	public void setImageMUrl(MultiImage imageMUrl) {
		this.imageMUrl = imageMUrl;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	
	

	public String getAppPopName() {
		return appPopName;
	}

	public void setAppPopName(String appPopName) {
		this.appPopName = appPopName;
	}

	public String getAppPopContent() {
		return appPopContent;
	}

	public void setAppPopContent(String appPopContent) {
		this.appPopContent = appPopContent;
	}

	public String getPopupObject() {
		return popupObject;
	}

	public void setPopupObject(String popupObject) {
		this.popupObject = popupObject;
	}

	public String getAppPopSubId() {
		return appPopSubId;
	}

	public void setAppPopSubId(String appPopSubId) {
		this.appPopSubId = appPopSubId;
	}

}
