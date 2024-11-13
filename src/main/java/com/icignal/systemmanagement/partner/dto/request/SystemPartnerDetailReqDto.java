package com.icignal.systemmanagement.partner.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.ObjectUtil;

public class SystemPartnerDetailReqDto extends CommonCondReqDto{
	private String ptnrName; //공지사항 제목
	private String openDate; //공지사항 게시일
	private String ptnrDesc; //공지사항 상세내용
	private String ptnrStatus; //공지사항 노출 여부
	private Boolean updateFlag;
	private String ptnrId;

	private List<String> images;
	private String fileName;
	private String angles;

	private String ptnrLang;
	private String ptnrMasterId;
	private String ptnrSubId;
	private String category;
	private String dispSeq;
	private String pageUrl;
	private String imageDetailType;
	private String endDate;
	private String startDate;
	
	
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getImageDetailType() {
		return imageDetailType;
	}
	public void setImageDetailType(String imageDetailType) {
		this.imageDetailType = imageDetailType;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public String getDispSeq() {
		return dispSeq;
	}
	public void setDispSeq(String dispSeq) {
		this.dispSeq = dispSeq;
	}

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
					//break;
				}
			}

			return category;
		}

	public String getSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFileName());
				result.append(',');
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFilePath());
				result.append(',');
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getOriName());
				result.append(',');
			}
		}

		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}

	public String getSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getRotateAngle());
				result.append(',');
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
	public String getPtnrName() {
		return ptnrName;
	}
	public void setPtnrName(String ptnrName) {
		this.ptnrName = ptnrName;
	}
	public String getPtnrDesc() {
		return ptnrDesc;
	}
	public void setPtnrDesc(String ptnrDesc) {
		this.ptnrDesc = ptnrDesc;
	}
	public String getPtnrStatus() {
		return ptnrStatus;
	}
	public void setPtnrStatus(String ptnrStatus) {
		this.ptnrStatus = ptnrStatus;
	}
	public String getPtnrId() {
		return ptnrId;
	}
	public void setPtnrId(String ptnrId) {
		this.ptnrId = ptnrId;
	}
	public String getPtnrLang() {
		return ptnrLang;
	}
	public void setPtnrLang(String ptnrLang) {
		this.ptnrLang = ptnrLang;
	}
	public String getPtnrMasterId() {
		return ptnrMasterId;
	}
	public void setPtnrMasterId(String ptnrMasterId) {
		this.ptnrMasterId = ptnrMasterId;
	}
	public String getPtnrSubId() {
		return ptnrSubId;
	}
	public void setPtnrSubId(String ptnrSubId) {
		this.ptnrSubId = ptnrSubId;
	}

}
