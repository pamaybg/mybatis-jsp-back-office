package com.icignal.systemmanagement.event.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImageResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;


public class SystemEventDetailResDto {

	private String eventStatus;
	private String eventName;
	private String startDate;
	private String endDate;
	private String win_notice_date;
	private String win_notice_exposure;
	private String eventLandingPage;
	private String eventDesc;
	private String eventId;
	private String eventSubId;
	private Integer eventCount;
	private String eventDetailPage;
	//이미지 업로드
	private String imageUrl;
	private MultiImageResDto imageMUrl;
	private List<MultiImageResDto> images;
	private List<MultiImageResDto> imagesEvent;
	private String oriName;

	private String appPopYn;
	private String seq;



	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getEventDetailPage() {
		return eventDetailPage;
	}
	public void setEventDetailPage(String eventDetailPage) {
		this.eventDetailPage = eventDetailPage;
	}
	public String getAppPopYn() {
		return appPopYn;
	}
	public void setAppPopYn(String appPopYn) {
		this.appPopYn = appPopYn;
	}
	public List<MultiImageResDto> getImagesEvent() {
	     if(this.imagesEvent == null) {
	            this.imagesEvent = new ArrayList<>();
	        } else {
	            for (MultiImageResDto MultiImageResDto : imagesEvent) {
	                ImageUtil.setMultiImages(MultiImageResDto.getImgOrgUrl(), MultiImageResDto);
	            }
	        }
	        return imagesEvent;
	}
	public void setImagesEvent(List<MultiImageResDto> imagesEvent) {
		this.imagesEvent = imagesEvent;
	}
	//다중 이미지 업로드를 위한 세팅
	public List<MultiImageResDto> getImages() {
		if(this.images == null) {
			this.images = new ArrayList<>();
		} else {
			for (MultiImageResDto MultiImageResDto : images) {
				ImageUtil.setMultiImages(MultiImageResDto.getImgOrgUrl(), MultiImageResDto);
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

	public String getEventStatus() {
		return eventStatus;
	}

	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
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

	public String getWin_notice_date() {
		return win_notice_date;
	}

	public void setWin_notice_date(String win_notice_date) {
		this.win_notice_date = win_notice_date;
	}

	public String getWin_notice_exposure() {
		return win_notice_exposure;
	}

	public void setWin_notice_exposure(String win_notice_exposure) {
		this.win_notice_exposure = win_notice_exposure;
	}

	public String getEventLandingPage() {
		return eventLandingPage;
	}

	public void setEventLandingPage(String eventLandingPage) {
		this.eventLandingPage = eventLandingPage;
	}

	public String getEventDesc() {
		return eventDesc;
	}

	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getEventSubId() {
		return eventSubId;
	}

	public void setEventSubId(String eventSubId) {
		this.eventSubId = eventSubId;
	}

	public Integer getEventCount() {
		return eventCount;
	}

	public void setEventCount(Integer eventCount) {
		this.eventCount = eventCount;
	}



}
