package com.icignal.kepler.analytics.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRAnalyticsExportRequestDTO
 * 2. 파일명	: KPRAnalyticsExportRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analytics.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalyticsExportReqDto extends MKTBaseReqDto {
	private String fileName; // 파일명
	private Integer imageCnt; // 이미지 갯수
	private String exportType; // Export Type

	private String targetName; // Export 대상명
	private String analyticsTypeCode; // 분석 타입

	private Integer totalWidth; // 테이블 총 넓이
	private Integer totalHeight; // 테이블 총 높이
	private Integer totalColCnt; // 테이블 총 컬럼 갯수(한 로우에)
	private Integer totalRowCnt; // 테이블 총 로우 갯수

	private Integer colAddr; // 컬럼 위치
	private Integer rowAddr; // 로우 위치
	private Integer colSpan;
	private Integer rowSpan;
	private Integer colWidth;
	private Integer colHeight;
	private String colValue;
	private Boolean strongFlag;
	private Boolean alignFlag;

	private String imageId; // 차트 이미지 ID
	private Integer imageWidth; // 차트 이미지 Width
	private Integer imageHeight; // 차트 이미지 Height
	private String imageExtension; // 차트 이미지 확장자
	private String imageEncoding; // 차트 이미지 Encoding
	private String imageBinaryData; // 차트 이미지 데이터
	private Integer ImageSize; // 차트 이미지 사이즈

	private List<KprAnalyticsExportReqDto> exportDataList;
	private List<List<KprAnalyticsExportReqDto>> tableRowList;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getImageCnt() {
		return imageCnt;
	}

	public void setImageCnt(Integer imageCnt) {
		this.imageCnt = imageCnt;
	}

	public String getExportType() {
		return exportType;
	}

	public void setExportType(String exportType) {
		this.exportType = exportType;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public String getAnalyticsTypeCode() {
		return analyticsTypeCode;
	}

	public void setAnalyticsTypeCode(String analyticsTypeCode) {
		this.analyticsTypeCode = analyticsTypeCode;
	}

	public Integer getTotalWidth() {
		return totalWidth;
	}

	public void setTotalWidth(Integer totalWidth) {
		this.totalWidth = totalWidth;
	}

	public Integer getTotalHeight() {
		return totalHeight;
	}

	public void setTotalHeight(Integer totalHeight) {
		this.totalHeight = totalHeight;
	}

	public Integer getTotalColCnt() {
		return totalColCnt;
	}

	public void setTotalColCnt(Integer totalColCnt) {
		this.totalColCnt = totalColCnt;
	}

	public Integer getTotalRowCnt() {
		return totalRowCnt;
	}

	public void setTotalRowCnt(Integer totalRowCnt) {
		this.totalRowCnt = totalRowCnt;
	}

	public Integer getColAddr() {
		return colAddr;
	}

	public void setColAddr(Integer colAddr) {
		this.colAddr = colAddr;
	}

	public Integer getRowAddr() {
		return rowAddr;
	}

	public void setRowAddr(Integer rowAddr) {
		this.rowAddr = rowAddr;
	}

	public Integer getColSpan() {
		return colSpan;
	}

	public void setColSpan(Integer colSpan) {
		this.colSpan = colSpan;
	}

	public Integer getRowSpan() {
		return rowSpan;
	}

	public void setRowSpan(Integer rowSpan) {
		this.rowSpan = rowSpan;
	}

	public Integer getColWidth() {
		return colWidth;
	}

	public void setColWidth(Integer colWidth) {
		this.colWidth = colWidth;
	}

	public Integer getColHeight() {
		return colHeight;
	}

	public void setColHeight(Integer colHeight) {
		this.colHeight = colHeight;
	}

	public String getColValue() {
		return colValue;
	}

	public void setColValue(String colValue) {
		this.colValue = colValue;
	}

	public Boolean getStrongFlag() {
		return strongFlag;
	}

	public void setStrongFlag(Boolean strongFlag) {
		this.strongFlag = strongFlag;
	}

	public Boolean getAlignFlag() {
		return alignFlag;
	}

	public void setAlignFlag(Boolean alignFlag) {
		this.alignFlag = alignFlag;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public Integer getImageWidth() {
		return imageWidth;
	}

	public void setImageWidth(Integer imageWidth) {
		this.imageWidth = imageWidth;
	}

	public Integer getImageHeight() {
		return imageHeight;
	}

	public void setImageHeight(Integer imageHeight) {
		this.imageHeight = imageHeight;
	}

	public String getImageExtension() {
		return imageExtension;
	}

	public void setImageExtension(String imageExtension) {
		this.imageExtension = imageExtension;
	}

	public String getImageEncoding() {
		return imageEncoding;
	}

	public void setImageEncoding(String imageEncoding) {
		this.imageEncoding = imageEncoding;
	}

	public String getImageBinaryData() {
		return imageBinaryData;
	}

	public void setImageBinaryData(String imageBinaryData) {
		this.imageBinaryData = imageBinaryData;
	}

	public Integer getImageSize() {
		return ImageSize;
	}

	public void setImageSize(Integer imageSize) {
		ImageSize = imageSize;
	}

	public List<KprAnalyticsExportReqDto> getExportDataList() {
		return exportDataList;
	}

	public void setExportDataList(List<KprAnalyticsExportReqDto> exportDataList) {
		this.exportDataList = exportDataList;
	}

	public List<List<KprAnalyticsExportReqDto>> getTableRowList() {
		return tableRowList;
	}

	public void setTableRowList(List<List<KprAnalyticsExportReqDto>> tableRowList) {
		this.tableRowList = tableRowList;
	}
}