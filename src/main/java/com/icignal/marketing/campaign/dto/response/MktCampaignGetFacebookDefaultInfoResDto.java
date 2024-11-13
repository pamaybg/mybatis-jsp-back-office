package com.icignal.marketing.campaign.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class MktCampaignGetFacebookDefaultInfoResDto extends GridPagingItemResDto{
	
	private String conid;
	
	private String snsInfo;
	private String id;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	private String acesToken;
	private String acesExpDt;
	 
	private String contents;
	private String openRange;
	private String reservePost;
	private String attType;
	private String postId;
	private String filePath;
	private String fileName;
	private String imageUrl;
	private List<MultiImage> images;
	private MultiImage imageMUrl;
	
	
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getOpenRange() {
		return openRange;
	}
	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}
	public String getReservePost() {
		return reservePost;
	}
	public void setReservePost(String reservePost) {
		this.reservePost = reservePost;
	}
	public String getAttType() {
		return attType;
	}
	public void setAttType(String attType) {
		this.attType = attType;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getAcesToken() {
		return acesToken;
	}
	public void setAcesToken(String acesToken) {
		this.acesToken = acesToken;
	}
	public String getAcesExpDt() {
		return acesExpDt;
	}
	public void setAcesExpDt(String acesExpDt) {
		this.acesExpDt = acesExpDt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSnsPageId() {
		return snsPageId;
	}
	public void setSnsPageId(String snsPageId) {
		this.snsPageId = snsPageId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAppSecurCode() {
		return appSecurCode;
	}
	public void setAppSecurCode(String appSecurCode) {
		this.appSecurCode = appSecurCode;
	}
	public MultiImage getImageMUrl() {
		return imageMUrl;
	}
	public void setImageMUrl(MultiImage imageMUrl) {
		this.imageMUrl = imageMUrl;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getConid() {
		return conid;
	}
	public void setConid(String conid) {
		this.conid = conid;
	}
	public String getSnsInfo() {
		return snsInfo;
	}
	public void setSnsInfo(String snsInfo) {
		this.snsInfo = snsInfo;
	}
	
}
