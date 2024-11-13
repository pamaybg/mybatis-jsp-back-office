package com.icignal.systemmanagement.partner.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class SystemPartnerDetailResDto {
	private String ptnrStatus;
	private String ptnrTitle;
	private String ptnrDesc;
	private String openDate;
	private String solYn;
	private String ptnrLang;

	private String ptnrSubId;
	private String ptnrMasterId;
	//이미지 업로드
	private String imageUrl;
	private MultiImage imageMUrl;
	private List<MultiImage> images;
	private List<MultiImage> imagesDetail;
	private String oriName;
	private String category;
	private String dispSeq;
	private String pageUrl;
	private String rid;
	private String ptnrName;
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
	public String getSolYn() {
		return solYn;
	}
	public void setSolYn(String solYn) {
		this.solYn = solYn;
	}
	public List<MultiImage> getImagesDetail() {
		if(this.imagesDetail == null) {
            this.imagesDetail = new ArrayList<>();
        } else {
            for (MultiImage multiImage : imagesDetail) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
		return imagesDetail;
	}
	public void setImagesDetail(List<MultiImage> imagesDetail) {
		this.imagesDetail = imagesDetail;
	}
	public String getPtnrName() {
		return ptnrName;
	}
	public void setPtnrName(String ptnrName) {
		this.ptnrName = ptnrName;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPtnrStatus() {
		return ptnrStatus;
	}
	public void setPtnrStatus(String ptnrStatus) {
		this.ptnrStatus = ptnrStatus;
	}
	public String getPtnrTitle() {
		return ptnrTitle;
	}
	public void setPtnrTitle(String ptnrTitle) {
		this.ptnrTitle = ptnrTitle;
	}
	public String getPtnrDesc() {
		return ptnrDesc;
	}
	public void setPtnrDesc(String ptnrDesc) {
		this.ptnrDesc = ptnrDesc;
	}
	public String getPtnrLang() {
		return ptnrLang;
	}
	public void setPtnrLang(String ptnrLang) {
		this.ptnrLang = ptnrLang;
	}
	public String getPtnrSubId() {
		return ptnrSubId;
	}
	public void setPtnrSubId(String ptnrSubId) {
		this.ptnrSubId = ptnrSubId;
	}
	public String getPtnrMasterId() {
		return ptnrMasterId;
	}
	public void setPtnrMasterId(String ptnrMasterId) {
		this.ptnrMasterId = ptnrMasterId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDispSeq() {
		return dispSeq;
	}
	public void setDispSeq(String dispSeq) {
		this.dispSeq = dispSeq;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
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
	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}




}
