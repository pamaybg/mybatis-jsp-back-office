package com.icignal.systemmanagement.event.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;


public class SystemEventSubInfoInsertReqDto extends CommonCondReqDto {

	private String eventName;
	private String eventLandingPage;
	private String fileNames;
	private String angles;
	private Boolean updateFlag;
	private String eventDesc;
	private String eventId;
	private String eventSubId;
	private String eventLang;
	private String eventDetailPage;

	//iCIGNAL 이미지 세팅
	private List<MultiUploadReqDto> appMainBannerSubImages;
	private List<MultiUploadReqDto> eventBannerSubImages;
	private List<MultiUploadReqDto> eventPageSubImages;
	private String imageLang;


	public String getEventDetailPage() {
		return eventDetailPage;
	}
	public void setEventDetailPage(String eventDetailPage) {
		this.eventDetailPage = eventDetailPage;
	}
	public List<MultiUploadReqDto> getAppMainBannerSubImages() {
			return appMainBannerSubImages;
		}
		public void setAppMainBannerSubImages(List<MultiUploadReqDto> subImages) {
			this.appMainBannerSubImages = subImages;
		}
	public IMAGE_UPLOAD_TYPE getAppMainBannerSubImageCategory () {
			IMAGE_UPLOAD_TYPE category = null;
			if(ObjectUtil.isNotEmpty(this.appMainBannerSubImages)) {
				for (MultiUploadReqDto mur : this.appMainBannerSubImages) {
					category = mur.getCategory();
					break;
				}
			}

			return category;
		}
	public String getAppMainBannerSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.appMainBannerSubImages)) {
			for(MultiUploadReqDto mur : this.appMainBannerSubImages) {
				result.append(mur.getFileName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getAppMainBannerSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.appMainBannerSubImages)) {
			for(MultiUploadReqDto mur : this.appMainBannerSubImages) {
				result.append(mur.getFilePath());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getAppMainBannerSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.appMainBannerSubImages)) {
			for(MultiUploadReqDto mur : this.appMainBannerSubImages) {
				result.append(mur.getOriName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getAppMainBannerSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.appMainBannerSubImages)) {
			for(MultiUploadReqDto mur : this.appMainBannerSubImages) {
				result.append(mur.getRotateAngle());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}


	public List<MultiUploadReqDto> getEventBannerSubImages() {
		return eventBannerSubImages;
	}
	public void setEventBannerSubImages(List<MultiUploadReqDto> subImages) {
		this.eventBannerSubImages = subImages;
	}

	public IMAGE_UPLOAD_TYPE getEventBannerSubImageCategory () {
		IMAGE_UPLOAD_TYPE category = null;
		if(ObjectUtil.isNotEmpty(this.eventBannerSubImages)) {
			for (MultiUploadReqDto mur : this.eventBannerSubImages) {
				category = mur.getCategory();
				break;
			}
		}

		return category;
	}
	public String getEventBannerSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventBannerSubImages)) {
			for(MultiUploadReqDto mur : this.eventBannerSubImages) {
				result.append(mur.getFileName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventBannerSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventBannerSubImages)) {
			for(MultiUploadReqDto mur : this.eventBannerSubImages) {
				result.append(mur.getFilePath());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventBannerSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventBannerSubImages)) {
			for(MultiUploadReqDto mur : this.eventBannerSubImages) {
				result.append(mur.getOriName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventBannerSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventBannerSubImages)) {
			for(MultiUploadReqDto mur : this.eventBannerSubImages) {
				result.append(mur.getRotateAngle());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}


	public List<MultiUploadReqDto> getEventPageSubImages() {
		return eventPageSubImages;
	}
	public void setEventPageSubImages(List<MultiUploadReqDto> subImages) {
		this.eventPageSubImages = subImages;
	}

	public IMAGE_UPLOAD_TYPE getEventPageSubImageCategory () {
		IMAGE_UPLOAD_TYPE category = null;
		if(ObjectUtil.isNotEmpty(this.eventPageSubImages)) {
			for (MultiUploadReqDto mur : this.eventPageSubImages) {
				category = mur.getCategory();
				break;
			}
		}

		return category;
	}
	public String getEventPageSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventPageSubImages)) {
			for(MultiUploadReqDto mur : this.eventPageSubImages) {
				result.append(mur.getFileName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventPageSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventPageSubImages)) {
			for(MultiUploadReqDto mur : this.eventPageSubImages) {
				result.append(mur.getFilePath());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventPageSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventPageSubImages)) {
			for(MultiUploadReqDto mur : this.eventPageSubImages) {
				result.append(mur.getOriName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	public String getEventPageSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.eventPageSubImages)) {
			for(MultiUploadReqDto mur : this.eventPageSubImages) {
				result.append(mur.getRotateAngle());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}


	public String getImageLang() {
		return imageLang;
	}
	public void setImageLang(String imageLang) {
		this.imageLang = imageLang;
	}


	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public String getEventLandingPage() {
		return eventLandingPage;
	}

	public void setEventLandingPage(String eventLandingPage) {
		this.eventLandingPage = eventLandingPage;
	}

	public String getFileNames() {
		return fileNames;
	}

	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}

	public String getAngles() {
		return angles;
	}

	public void setAngles(String angles) {
		this.angles = angles;
	}

	public Boolean getUpdateFlag() {
		return updateFlag;
	}

	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}

	public String getEventSubId() {
		return eventSubId;
	}

	public void setEventSubId(String eventSubId) {
		this.eventSubId = eventSubId;
	}

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getEventLang() {
		return eventLang;
	}

	public void setEventLang(String eventLang) {
		this.eventLang = eventLang;
	}

	public String getEventDesc() {
		return eventDesc;
	}

	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}

}
