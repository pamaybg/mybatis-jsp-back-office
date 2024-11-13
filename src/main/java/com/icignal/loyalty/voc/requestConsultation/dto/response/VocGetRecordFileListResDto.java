package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;



/**
 * @name : VOCGetRecordFileListResponseDTO.java
 * @date : 2017. 11. 30.
 * @author : jun.lee
 * @description : 녹취청취 목록 조회
 */
public class VocGetRecordFileListResDto extends GridPagingItemResDto {
	
	private String companyId;
	private String interactionId;
	private String actionDate;
	private String userId;
	private String mediaType;
	private String fileName;
	private String filepath;
	private String hostName;
	private String url;
	private String duration;
	private String transactionStatus;
	private String numberOfRetries;
	private String remoteStatus;
	private String projectId;
	private String mediaStatus;
	private String modifyDate;
	private String backupFilePath;
	
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getInteractionId() {
		return interactionId;
	}
	public void setInteractionId(String interactionId) {
		this.interactionId = interactionId;
	}
	public String getActionDate() {
		return actionDate;
	}
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMediaType() {
		return mediaType;
	}
	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getTransactionStatus() {
		return transactionStatus;
	}
	public void setTransactionStatus(String transactionStatus) {
		this.transactionStatus = transactionStatus;
	}
	public String getNumberOfRetries() {
		return numberOfRetries;
	}
	public void setNumberOfRetries(String numberOfRetries) {
		this.numberOfRetries = numberOfRetries;
	}
	public String getRemoteStatus() {
		return remoteStatus;
	}
	public void setRemoteStatus(String remoteStatus) {
		this.remoteStatus = remoteStatus;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getMediaStatus() {
		return mediaStatus;
	}
	public void setMediaStatus(String mediaStatus) {
		this.mediaStatus = mediaStatus;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getBackupFilePath() {
		return backupFilePath;
	}
	public void setBackupFilePath(String backupFilePath) {
		this.backupFilePath = backupFilePath;
	}
	
}