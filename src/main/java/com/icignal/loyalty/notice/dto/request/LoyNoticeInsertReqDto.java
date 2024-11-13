package com.icignal.loyalty.notice.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;


public class LoyNoticeInsertReqDto extends  CommonCondReqDto {

	private String noticeName; //공지사항 제목
	private String openDate; //공지사항 게시일
	private String noticeDesc; //공지사항 상세내용
	private String noticeStatus; //공지사항 노출 여부
	private Boolean updateFlag;
	private String noticeId;

	private List<String> images;
	private String fileName;
	private String angles;

	private String noticeLang;
	private String noticeMasterId;
	private String noticeSubId;
	private String type;
	private String rid;
	private String imgUrl1;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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




	public String getNoticeName() {
		return noticeName;
	}
	public void setNoticeName(String noticeName) {
		this.noticeName = noticeName;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getNoticeDesc() {
		return noticeDesc;
	}
	public void setNoticeDesc(String noticeDesc) {
		this.noticeDesc = noticeDesc;
	}
	public String getNoticeStatus() {
		return noticeStatus;
	}
	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
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
	public String getNoticeLang() {
		return noticeLang;
	}
	public void setNoticeLang(String noticeLang) {
		this.noticeLang = noticeLang;
	}
	public String getNoticeMasterId() {
		return noticeMasterId;
	}
	public void setNoticeMasterId(String noticeMasterId) {
		this.noticeMasterId = noticeMasterId;
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
