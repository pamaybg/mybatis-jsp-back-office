package com.icignal.kepler.common.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRAnalysisExportRequestDTO
 * 2. 파일명	: KPRAnalysisExportRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisExportReqDto extends MKTBaseReqDto {
	
	private String fileName;
	private String targetName;
	private String analysisTypeCode;
	private String realPath;
	private Integer imageCnt;
	private Integer totalWidth;
	private Integer totalHeight;
	private Integer rowCount;
	private Integer colCount;
	private Integer width;
	private Integer height;
	private Integer rowAddr;
	private Integer colAddr;
	private Integer rowSpan;
	private Integer colSpan;
	private Boolean strongFlag;
	private Boolean alignFlag;
	private String value;
	private String imageId;
	private String imageEncoding;
	private Integer imageSize;
	private String imageBinaryData;
	private String imageExt;
	private String excelName;
	private String sheetName;
	private String sheetRef;
	private String cellType;
	private String cellValue;
	private Integer pointX;
	private Integer pointY;
	private Integer rowNumCount;
	private Integer startX;
	private Integer startY;
	private Integer endX;
	private Integer endY;

	private List<KprAnalysisExportReqDto> sheetDataList;
	private List<List<KprAnalysisExportReqDto>> excelDataList;
	private List<KprAnalysisExportReqDto> mergeDataList;
	private List<List<KprAnalysisExportReqDto>> tableRowList;
	private List<KprAnalysisExportReqDto> exportDataList;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public String getAnalysisTypeCode() {
		return analysisTypeCode;
	}

	public void setAnalysisTypeCode(String analysisTypeCode) {
		this.analysisTypeCode = analysisTypeCode;
	}

	public String getRealPath() {
		return realPath;
	}

	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}

	public Integer getImageCnt() {
		return imageCnt;
	}

	public void setImageCnt(Integer imageCnt) {
		this.imageCnt = imageCnt;
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

	public Integer getRowCount() {
		return rowCount;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public Integer getColCount() {
		return colCount;
	}

	public void setColCount(Integer colCount) {
		this.colCount = colCount;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getRowAddr() {
		return rowAddr;
	}

	public void setRowAddr(Integer rowAddr) {
		this.rowAddr = rowAddr;
	}

	public Integer getColAddr() {
		return colAddr;
	}

	public void setColAddr(Integer colAddr) {
		this.colAddr = colAddr;
	}

	public Integer getRowSpan() {
		return rowSpan;
	}

	public void setRowSpan(Integer rowSpan) {
		this.rowSpan = rowSpan;
	}

	public Integer getColSpan() {
		return colSpan;
	}

	public void setColSpan(Integer colSpan) {
		this.colSpan = colSpan;
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

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getImageEncoding() {
		return imageEncoding;
	}

	public void setImageEncoding(String imageEncoding) {
		this.imageEncoding = imageEncoding;
	}

	public Integer getImageSize() {
		return imageSize;
	}

	public void setImageSize(Integer imageSize) {
		this.imageSize = imageSize;
	}

	public String getImageBinaryData() {
		return imageBinaryData;
	}

	public void setImageBinaryData(String imageBinaryData) {
		this.imageBinaryData = imageBinaryData;
	}

	public String getImageExt() {
		return imageExt;
	}

	public void setImageExt(String imageExt) {
		this.imageExt = imageExt;
	}

	public String getExcelName() {
		return excelName;
	}

	public void setExcelName(String excelName) {
		this.excelName = excelName;
	}

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public String getSheetRef() {
		return sheetRef;
	}

	public void setSheetRef(String sheetRef) {
		this.sheetRef = sheetRef;
	}

	public String getCellType() {
		return cellType;
	}

	public void setCellType(String cellType) {
		this.cellType = cellType;
	}

	public String getCellValue() {
		return cellValue;
	}

	public void setCellValue(String cellValue) {
		this.cellValue = cellValue;
	}

	public Integer getPointX() {
		return pointX;
	}

	public void setPointX(Integer pointX) {
		this.pointX = pointX;
	}

	public Integer getPointY() {
		return pointY;
	}

	public void setPointY(Integer pointY) {
		this.pointY = pointY;
	}

	public Integer getRowNumCount() {
		return rowNumCount;
	}

	public void setRowNumCount(Integer rowNumCount) {
		this.rowNumCount = rowNumCount;
	}

	public Integer getStartX() {
		return startX;
	}

	public void setStartX(Integer startX) {
		this.startX = startX;
	}

	public Integer getStartY() {
		return startY;
	}

	public void setStartY(Integer startY) {
		this.startY = startY;
	}

	public Integer getEndX() {
		return endX;
	}

	public void setEndX(Integer endX) {
		this.endX = endX;
	}

	public Integer getEndY() {
		return endY;
	}

	public void setEndY(Integer endY) {
		this.endY = endY;
	}

	public List<KprAnalysisExportReqDto> getSheetDataList() {
		return sheetDataList;
	}

	public void setSheetDataList(List<KprAnalysisExportReqDto> sheetDataList) {
		this.sheetDataList = sheetDataList;
	}

	public List<List<KprAnalysisExportReqDto>> getExcelDataList() {
		return excelDataList;
	}

	public void setExcelDataList(List<List<KprAnalysisExportReqDto>> excelDataList) {
		this.excelDataList = excelDataList;
	}

	public List<KprAnalysisExportReqDto> getMergeDataList() {
		return mergeDataList;
	}

	public void setMergeDataList(List<KprAnalysisExportReqDto> mergeDataList) {
		this.mergeDataList = mergeDataList;
	}

	public List<List<KprAnalysisExportReqDto>> getTableRowList() {
		return tableRowList;
	}

	public void setTableRowList(List<List<KprAnalysisExportReqDto>> tableRowList) {
		this.tableRowList = tableRowList;
	}

	public List<KprAnalysisExportReqDto> getExportDataList() {
		return exportDataList;
	}

	public void setExportDataList(List<KprAnalysisExportReqDto> exportDataList) {
		this.exportDataList = exportDataList;
	}
}