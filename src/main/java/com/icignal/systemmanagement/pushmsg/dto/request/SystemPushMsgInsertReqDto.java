package com.icignal.systemmanagement.pushmsg.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;


public class SystemPushMsgInsertReqDto extends CommonCondReqDto {
	
	private String insertPushMsgRid;
	private String insertPushMsgLogRid;
	private String insertPushMbrRid;
	private String sendDate;
	private String pushLang;
	private String pushType;
	private String pushTarget;
	private String pushTitle;
	private String pushContent;
	private List<String> images;
	private Boolean updateFlag;
	private String pushMsgId;
	private String natnCd;
	private List<String> pushMembers; // 테스트 발송 대상으로 선택한 직원들의 loy.loy_mbr.rid 목록
	
	private String pushMbrRid;
	
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
				category = this.subImages.get(0).getCategory();
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
	
	

	public String getInsertPushMsgRid() {
		return insertPushMsgRid;
	}
	public void setInsertPushMsgRid(String insertPushMsgRid) {
		this.insertPushMsgRid = insertPushMsgRid;
	}
	public String getInsertPushMsgLogRid() {
		return insertPushMsgLogRid;
	}
	public void setInsertPushMsgLogRid(String insertPushMsgLogRid) {
		this.insertPushMsgLogRid = insertPushMsgLogRid;
	}
	public String getInsertPushMbrRid() {
		return insertPushMbrRid;
	}
	public void setInsertPushMbrRid(String insertPushMbrRid) {
		this.insertPushMbrRid = insertPushMbrRid;
	}
	public String getImageLang() {
		return imageLang;
	}
	public void setImageLang(String imageLang) {
		this.imageLang = imageLang;
	}
	
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
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
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getPushMsgId() {
		return pushMsgId;
	}
	public void setPushMsgId(String pushMsgId) {
		this.pushMsgId = pushMsgId;
	}
	public List<String> getImages() {
		return images;
	}
	public void setImages(List<String> images) {
		this.images = images;
	}
	public String getNatnCd() {
		return natnCd;
	}
	public void setNatnCd(String natnCd) {
		this.natnCd = natnCd;
	}
	public List<String> getPushMembers() {
		return pushMembers;
	}
	public void setPushMembers(List<String> pushMembers) {
		this.pushMembers = pushMembers;
	}
	public String getPushMbrRid() {
		return pushMbrRid;
	}
	public void setPushMbrRid(String pushMbrRid) {
		this.pushMbrRid = pushMbrRid;
	}
}
