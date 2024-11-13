package com.icignal.marketing.contents.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class MktFacebookDtlResDto {
	private String id;                 //아이디
	private String contentsName;
	private String contentsType;
	private String title;
	private String emailType;
	private String contents;
	private String html;
	private String textByteSize;
	private String postId;
	private String reservePost;
	private String openRange;
	private String attType;
	
	private String fileSize;
	private String oriFileName;
	private String fileName;
	private String filePath;
	private String snsInfo;
	private String imgFileName;
	
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
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContentsName() {
		return contentsName;
	}
	public void setContentsName(String contentsName) {
		this.contentsName = contentsName;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(String textByteSize) {
		this.textByteSize = textByteSize;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getReservePost() {
		return reservePost;
	}
	public void setReservePost(String reservePost) {
		this.reservePost = reservePost;
	}
	public String getOpenRange() {
		return openRange;
	}
	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getAttType() {
		return attType;
	}
	public void setAttType(String attType) {
		this.attType = attType;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getSnsInfo() {
		return snsInfo;
	}
	public void setSnsInfo(String snsInfo) {
		this.snsInfo = snsInfo;
	}
	public String getImgFileName() {
		return imgFileName;
	}
	public void setImgFileName(String imgFileName) {
		this.imgFileName = imgFileName;
	}
}
