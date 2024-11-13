package com.icignal.systemmanagement.apppopup.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.ObjectUtil;


public class SystemAppPopSubInsertReqDto extends CommonCondReqDto {
	
	private String appPopName;
	private String appPopContent;
	private Boolean updateFlag;
	private String appPopSubId;
	private String appPopId;
	private String appPopLang;
	private String popupObject;
	
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
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getAppPopSubId() {
		return appPopSubId;
	}
	public void setAppPopSubId(String appPopSubId) {
		this.appPopSubId = appPopSubId;
	}
	public String getAppPopId() {
		return appPopId;
	}
	public void setAppPopId(String appPopId) {
		this.appPopId = appPopId;
	}
	public String getAppPopLang() {
		return appPopLang;
	}
	public void setAppPopLang(String appPopLang) {
		this.appPopLang = appPopLang;
	}
	public String getPopupObject() {
		return popupObject;
	}
	public void setPopupObject(String popupObject) {
		this.popupObject = popupObject;
	}

	
	

}
