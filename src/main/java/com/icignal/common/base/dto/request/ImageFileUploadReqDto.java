package com.icignal.common.base.dto.request;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @name : ImageFileUploadRequestDTO 
 * @date : 2018. 09. 11.
 * @author : 금동우
 */ 
@JsonIgnoreProperties(ignoreUnknown = true)
public class ImageFileUploadReqDto extends CommonDataAuthReqDto{
    private String id;
	private String userId;
	private String accountId;
	private String filePath;
	private String fileType;
	private String fileName;
    private String extension;    
    private String description;
    private String appServiceType;
    private String realfileName;
    private String fileId;
    private String fileCommcode;
    private String memId;
    private String imgSize;
    private String imageType;

    private List<ImageFileUploadReqDto> array;
    
    //syncFusion
    private String Action;
	private String ActionType;
	private String commonFiles;
	private String extensionsAllow;
	private String fileUpload;
	private String locationFrom;
	private String locationTo;
	private String name;
	private String newName;
	private String Path;
	private String previousName;
	private String Type;
	private String spriteCssClass;
	private String pid;
	private String _update;
	private String sizeInByte;
	private String itemType;
	private List<ImageFileUploadReqDto> selectedItems;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAppServiceType() {
		return appServiceType;
	}
	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}
	public String getRealfileName() {
		return realfileName;
	}
	public void setRealfileName(String realfileName) {
		this.realfileName = realfileName;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileCommcode() {
		return fileCommcode;
	}
	public void setFileCommcode(String fileCommcode) {
		this.fileCommcode = fileCommcode;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getImgSize() {
		return imgSize;
	}
	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}
	public List<ImageFileUploadReqDto> getArray() {
		return array;
	}
	public void setArray(List<ImageFileUploadReqDto> array) {
		this.array = array;
	}
	public String getCommonFiles() {
		return commonFiles;
	}
	public void setCommonFiles(String commonFiles) {
		this.commonFiles = commonFiles;
	}
	public String getExtensionsAllow() {
		return extensionsAllow;
	}
	public void setExtensionsAllow(String extensionsAllow) {
		this.extensionsAllow = extensionsAllow;
	}
	public String getLocationFrom() {
		return locationFrom;
	}
	public void setLocationFrom(String locationFrom) {
		this.locationFrom = locationFrom;
	}
	public String getLocationTo() {
		return locationTo;
	}
	public void setLocationTo(String locationTo) {
		this.locationTo = locationTo;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public String getPreviousName() {
		return previousName;
	}
	public void setPreviousName(String previousName) {
		this.previousName = previousName;
	}
	public List<ImageFileUploadReqDto> getSelectedItems() {
		return selectedItems;
	}
	public void setSelectedItems(List<ImageFileUploadReqDto> selectedItems) {
		this.selectedItems = selectedItems;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSpriteCssClass() {
		return spriteCssClass;
	}
	public void setSpriteCssClass(String spriteCssClass) {
		this.spriteCssClass = spriteCssClass;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String get_update() {
		return _update;
	}
	public void set_update(String _update) {
		this._update = _update;
	}
	public String getSizeInByte() {
		return sizeInByte;
	}
	public void setSizeInByte(String sizeInByte) {
		this.sizeInByte = sizeInByte;
	}
	@JsonProperty("ActionType")
	public String getActionType() {
		return ActionType;
	}
	
	public void setActionType(String actionType) {
		ActionType = actionType;
	}
	public String getAction() {
		return Action;
	}
	public void setAction(String action) {
		Action = action;
	}
	@JsonProperty("Path")
	public String getPath() {
		return Path;
	}
	public void setPath(String path) {
		Path = path;
	}
	@JsonProperty("Type")
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	@JsonProperty("itemType")
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getImageType() {
		return imageType;
	}
	public void setImageType(String imageType) {
		this.imageType = imageType;
	}
	public String getFileUpload() {
		return fileUpload;
	}
	public void setFileUpload(String fileUpload) {
		this.fileUpload = fileUpload;
	}
	
}