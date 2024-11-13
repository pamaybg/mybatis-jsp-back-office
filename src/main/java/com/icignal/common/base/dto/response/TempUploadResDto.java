package com.icignal.common.base.dto.response;

import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

public class TempUploadResDto extends StatusResDto {
	private String name;
	private Integer size;
	private String url;
	private String thumbnailUrl;
	private String deleteUrl;
	private String deleteType;
	private MultiImageResDto mUrl;
	private MultiImageResDto thumbnailMUrl;
	private MultiImageResDto deleteMUrl;
	private String oriName;
	private String fileName;
	
	public TempUploadResDto() {
		super();
	}
	
	public TempUploadResDto(String name, Integer size, String url) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
	}
	
	public TempUploadResDto(String name, Integer size, String url, String oriName) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
		this.oriName = oriName;
		this.fileName = name;
	}
	
	public TempUploadResDto(String name, Integer size, String url,
			String thumbnailUrl, String deleteUrl, String deleteType) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
		this.thumbnailUrl = thumbnailUrl;
		this.deleteUrl = deleteUrl;
		this.deleteType = deleteType;
	}
	
	public TempUploadResDto(String name, Integer size, String url,
			String thumbnailUrl, String deleteUrl, String deleteType, String oriName) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
		this.thumbnailUrl = thumbnailUrl;
		this.deleteUrl = deleteUrl;
		this.deleteType = deleteType;
		this.oriName = oriName;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public String getUrl() {
		if(this.url != null && this.url.length() > 0 && !this.url.contains(CommonUtil.getInstance().getImageServerUrl())){
			//this.mUrl = new MultiImage();
			//ImageUtility.setMultiImages(this.url, this.mUrl);
			this.url = "/" + this.url;
		}
		
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getThumbnailUrl() {
		if(this.thumbnailUrl != null && this.thumbnailUrl.length() > 0 && !this.thumbnailUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.thumbnailMUrl = new MultiImageResDto();
			ImageUtil.setMultiImages(this.thumbnailUrl, this.thumbnailMUrl);
			this.thumbnailUrl = "/" + this.thumbnailUrl;
		}
		
		return thumbnailUrl;
	}
	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}
	public String getDeleteUrl() {
		if(this.deleteUrl != null && this.deleteUrl.length() > 0 && !this.deleteUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.deleteMUrl = new MultiImageResDto();
			ImageUtil.setMultiImages(this.deleteUrl, this.deleteMUrl);
			this.deleteUrl = "/" + this.deleteUrl;
		}
		
		return deleteUrl;
	}
	public void setDeleteUrl(String deleteUrl) {
		this.deleteUrl = deleteUrl;
	}
	public String getDeleteType() {
		return deleteType;
	}
	public void setDeleteType(String deleteType) {
		this.deleteType = deleteType;
	}
	
	@Override
	public String toString() {
		return "UploadedFile [name=" + name + ", size=" + size + ", url=" + url
				+ ", thumbnailUrl=" + thumbnailUrl + ", deleteUrl="
				+ deleteUrl + ", deleteType=" + deleteType + "]";
	}

	public MultiImageResDto getmUrl() {
		return mUrl;
	}

	public void setmUrl(MultiImageResDto mUrl) {
		this.mUrl = mUrl;
	}

	public MultiImageResDto getThumbnailMUrl() {
		return thumbnailMUrl;
	}

	public void setThumbnailMUrl(MultiImageResDto thumbnailMUrl) {
		this.thumbnailMUrl = thumbnailMUrl;
	}

	public MultiImageResDto getDeleteMUrl() {
		return deleteMUrl;
	}

	public void setDeleteMUrl(MultiImageResDto deleteMUrl) {
		this.deleteMUrl = deleteMUrl;
	}

	public String getOriName() {
		return oriName;
	}

	public void setOriName(String oriName) {
		this.oriName = oriName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}
