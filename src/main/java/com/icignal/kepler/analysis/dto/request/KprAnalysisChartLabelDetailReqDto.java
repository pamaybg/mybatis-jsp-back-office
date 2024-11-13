package com.icignal.kepler.analysis.dto.request;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;

/*
 * 1. 클래스명	: KPRAnalysisChartLabelDetailRequestDTO
 * 2. 파일명	: KPRAnalysisChartLabelDetailRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisChartLabelDetailReqDto extends KprAnalysisCommonReqDto {
	
	private String fontId;
	private String fontTypeCode;
	private String fontStyleTypeCode;
	private String fontColor;
	private Integer fontSize;
	private String chartLabelTypeCode;
	private String chartLegendPositionTypeCode;
	private String horizontalName;
	private String leftVerticalName;
	private String rightVerticalName;
	private String leftChartLabelTypeCode;
	private String rightChartLabelTypeCode;
	private String dataDisplayTypeCode;
	private String dataUnitTypeCode;

	private List<KprAnalysisChartLabelDetailReqDto> chartLabelFontList;
	
	private List<String> fontIdList;
	
	
		
	public String getFontId() {
		return fontId;
	}

	public void setFontId(String fontId) {
		this.fontId = fontId;
	}

	public String getFontTypeCode() {
		return fontTypeCode;
	}

	public void setFontTypeCode(String fontTypeCode) {
		this.fontTypeCode = fontTypeCode;
	}

	public String getFontStyleTypeCode() {
		return fontStyleTypeCode;
	}

	public void setFontStyleTypeCode(String fontStyleTypeCode) {
		this.fontStyleTypeCode = fontStyleTypeCode;
	}

	public String getFontColor() {
		return fontColor;
	}

	public void setFontColor(String fontColor) {
		this.fontColor = fontColor;
	}

	public Integer getFontSize() {
		return fontSize;
	}

	public void setFontSize(Integer fontSize) {
		this.fontSize = fontSize;
	}

	public String getChartLabelTypeCode() {
		return chartLabelTypeCode;
	}

	public void setChartLabelTypeCode(String chartLabelTypeCode) {
		this.chartLabelTypeCode = chartLabelTypeCode;
	}

	public String getChartLegendPositionTypeCode() {
		return chartLegendPositionTypeCode;
	}

	public void setChartLegendPositionTypeCode(String chartLegendPositionTypeCode) {
		this.chartLegendPositionTypeCode = chartLegendPositionTypeCode;
	}

	public String getHorizontalName() {
		return horizontalName;
	}

	public void setHorizontalName(String horizontalName) {
		this.horizontalName = horizontalName;
	}

	public String getLeftVerticalName() {
		return leftVerticalName;
	}

	public void setLeftVerticalName(String leftVerticalName) {
		this.leftVerticalName = leftVerticalName;
	}

	public String getRightVerticalName() {
		return rightVerticalName;
	}

	public void setRightVerticalName(String rightVerticalName) {
		this.rightVerticalName = rightVerticalName;
	}

	public String getLeftChartLabelTypeCode() {
		return leftChartLabelTypeCode;
	}

	public void setLeftChartLabelTypeCode(String leftChartLabelTypeCode) {
		this.leftChartLabelTypeCode = leftChartLabelTypeCode;
	}

	public String getRightChartLabelTypeCode() {
		return rightChartLabelTypeCode;
	}

	public void setRightChartLabelTypeCode(String rightChartLabelTypeCode) {
		this.rightChartLabelTypeCode = rightChartLabelTypeCode;
	}

	public String getDataDisplayTypeCode() {
		return dataDisplayTypeCode;
	}

	public void setDataDisplayTypeCode(String dataDisplayTypeCode) {
		this.dataDisplayTypeCode = dataDisplayTypeCode;
	}

	public String getDataUnitTypeCode() {
		return dataUnitTypeCode;
	}

	public void setDataUnitTypeCode(String dataUnitTypeCode) {
		this.dataUnitTypeCode = dataUnitTypeCode;
	}

	public List<KprAnalysisChartLabelDetailReqDto> getChartLabelFontList() {
		return chartLabelFontList;
	}

	public void setChartLabelFontList(List<KprAnalysisChartLabelDetailReqDto> chartLabelFontList) {
		this.chartLabelFontList = chartLabelFontList;
	}

	public List<String> getFontIdList() {
		return fontIdList;
	}

	public void setFontIdList(List<String> fontIdList) {
		this.fontIdList = fontIdList;
	}
}