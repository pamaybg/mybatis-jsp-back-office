package com.icignal.systemmanagement.banner.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;


public class SystemBannerInsertReqDto extends  CommonCondReqDto {

	private String bannerName; //공지사항 제목
	private String openDate; //공지사항 게시일
	private String bannerDesc; //공지사항 상세내용
	private String bannerStatus; //공지사항 노출 여부
	private Boolean updateFlag;
	private String bannerId;

	private List<String> images;
	private String fileName;
	private String angles;

	private String bannerLang;
	private String bannerMasterId;
	private String bannerSubId;
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
	//iCIGNAL 이미지 세팅
	private List<MultiUploadReqDto> subImages;
	private String imageLang;


	public List<MultiUploadReqDto> getSubImages() {
			return subImages;
		}
		public void setSubImages(List<MultiUploadReqDto> subImages) {
			this.subImages = subImages;
		}


	public IMAGE_UPLOAD_TYPE getSubImageCategory () {
			IMAGE_UPLOAD_TYPE category = null;
			if(ObjectUtil.isNotEmpty(this.subImages)) {
				for (MultiUploadReqDto mur : this.subImages) {
					category = mur.getCategory();
					break;
				}
			}

			return category;
		}

	public String getSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFileName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFilePath());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getOriName());
				result.append(",");
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
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





	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}

	public List<String> getImages() {
		return images;
	}
	public void setImages(List<String> images) {
		this.images = images;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getAngles() {
		return angles;
	}
	public void setAngles(String angles) {
		this.angles = angles;
	}
	public String getBannerName() {
		return bannerName;
	}
	public void setBannerName(String bannerName) {
		this.bannerName = bannerName;
	}
	public String getBannerDesc() {
		return bannerDesc;
	}
	public void setBannerDesc(String bannerDesc) {
		this.bannerDesc = bannerDesc;
	}
	public String getBannerStatus() {
		return bannerStatus;
	}
	public void setBannerStatus(String bannerStatus) {
		this.bannerStatus = bannerStatus;
	}
	public String getBannerId() {
		return bannerId;
	}
	public void setBannerId(String bannerId) {
		this.bannerId = bannerId;
	}
	public String getBannerLang() {
		return bannerLang;
	}
	public void setBannerLang(String bannerLang) {
		this.bannerLang = bannerLang;
	}
	public String getBannerMasterId() {
		return bannerMasterId;
	}
	public void setBannerMasterId(String bannerMasterId) {
		this.bannerMasterId = bannerMasterId;
	}
	public String getBannerSubId() {
		return bannerSubId;
	}
	public void setBannerSubId(String bannerSubId) {
		this.bannerSubId = bannerSubId;
	}


}
