package com.icignal.loyalty.notice.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class LoyNoticeDetailResDto extends StatusResDto{

	private String noticeStatus;
	private String noticeTitle;
	private String noticeDesc;
	private String openDate;

	private String noticeLang;

	private String noticeSubId;

	//이미지 업로드
	private String imageUrl;
	private MultiImage imageMUrl;
	private List<MultiImage> images;
	private String oriName;
	private String type;
	private String imgUrl1;



	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
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



	public String getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeDesc() {
		return noticeDesc;
	}

	public void setNoticeDesc(String noticeDesc) {
		this.noticeDesc = noticeDesc;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getNoticeLang() {
		return noticeLang;
	}

	public void setNoticeLang(String noticeLang) {
		this.noticeLang = noticeLang;
	}

	public String getNoticeSubId() {
		return noticeSubId;
	}

	public void setNoticeSubId(String noticeSubId) {
		this.noticeSubId = noticeSubId;
	}

	public String getImgUrl1() {
		return imgUrl1;
	}
	public void setImgUrl1(String imgUrl1) {
		this.imgUrl1 = imgUrl1;
	}

}
