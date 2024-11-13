package com.icignal.systemmanagement.pushmsg.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImageResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;


public class SystemPushMsgDetailResDto {
	
	private String pushTitle;
	private String pushContent;
	private String pushLang;
	private String pushType;
	private String pushTarget;
	private String sendDate;
	private String sendTime;
	private String PushStatus;
	private String summary;
	
	
	//이미지 업로드
	private String imageUrl;
	private MultiImageResDto imageMUrl;
	private List<MultiImageResDto> images;
	private String oriName;
	
	
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
	
	
	public String getPushTitle() {
		return pushTitle;
	}
	public void setPushTitle(String pushTitle) {
		this.pushTitle = pushTitle;
	}
	public String getPushContent() {
		return pushContent;
	}
	public void setPushContent(String pushContent) {
		this.pushContent = pushContent;
	}
	public String getPushLang() {
		return pushLang;
	}
	public void setPushLang(String pushLang) {
		this.pushLang = pushLang;
	}
	public String getPushType() {
		return pushType;
	}
	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
	public String getPushTarget() {
		return pushTarget;
	}
	public void setPushTarget(String pushTarget) {
		this.pushTarget = pushTarget;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getPushStatus() {
		return PushStatus;
	}
	public void setPushStatus(String pushStatus) {
		PushStatus = pushStatus;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	


}
