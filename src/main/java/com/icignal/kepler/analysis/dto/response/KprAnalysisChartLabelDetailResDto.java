package com.icignal.kepler.analysis.dto.response;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;

/*
 * 1. 클래스명	: KPRAnalysisChartLabelDetailResponseDTO
 * 2. 파일명	: KPRAnalysisChartLabelDetailResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisChartLabelDetailResDto extends KprAnalysisCommonResDto {
	
	private String chartTypeCode;
	private String leftLabelTypeCode;
	private String rightLabelTypeCode;
	private String displayTypeCode;
	private String horizontalName;
	private String leftVerticalName;
	private String rightVerticalName;
	private String legendPositionTypeCode;
	private String leftChartLabelPrefix;
	private String leftChartLabelSuffix;
	private Integer leftChartLabelValue;
	private String rightChartLabelPrefix;
	private String rightChartLabelSuffix;
	private Integer rightChartLabelValue;
	private String fontId;
	private String chartLabelTypeCode;
	private String fontTypeCode;
	private String fontStyleTypeCode;
	private String fontColor;
	private Integer fontSize;
	private String fontTypeAttrib01;
	private String fontStyleAttrib01;
	private String fontStyleAttrib02;

	private List<KprAnalysisChartLabelDetailResDto> chartLabelFontList;

	public String getChartTypeCode() {
		return chartTypeCode;
	}

	public void setChartTypeCode(String chartTypeCode) {
		this.chartTypeCode = chartTypeCode;
	}

	public String getLeftLabelTypeCode() {
		return leftLabelTypeCode;
	}

	public void setLeftLabelTypeCode(String leftLabelTypeCode) {
		this.leftLabelTypeCode = leftLabelTypeCode;
	}

	public String getRightLabelTypeCode() {
		return rightLabelTypeCode;
	}

	public void setRightLabelTypeCode(String rightLabelTypeCode) {
		this.rightLabelTypeCode = rightLabelTypeCode;
	}

	public String getDisplayTypeCode() {
		return displayTypeCode;
	}

	public void setDisplayTypeCode(String displayTypeCode) {
		this.displayTypeCode = displayTypeCode;
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

	public String getLegendPositionTypeCode() {
		return legendPositionTypeCode;
	}

	public void setLegendPositionTypeCode(String legendPositionTypeCode) {
		this.legendPositionTypeCode = legendPositionTypeCode;
	}

	public String getLeftChartLabelPrefix() {
		return leftChartLabelPrefix;
	}

	public void setLeftChartLabelPrefix(String leftChartLabelPrefix) {
		this.leftChartLabelPrefix = leftChartLabelPrefix;
	}

	public String getLeftChartLabelSuffix() {
		return leftChartLabelSuffix;
	}

	public void setLeftChartLabelSuffix(String leftChartLabelSuffix) {
		this.leftChartLabelSuffix = leftChartLabelSuffix;
	}

	public Integer getLeftChartLabelValue() {
		return leftChartLabelValue;
	}

	public void setLeftChartLabelValue(Integer leftChartLabelValue) {
		this.leftChartLabelValue = leftChartLabelValue;
	}

	public String getRightChartLabelPrefix() {
		return rightChartLabelPrefix;
	}

	public void setRightChartLabelPrefix(String rightChartLabelPrefix) {
		this.rightChartLabelPrefix = rightChartLabelPrefix;
	}

	public String getRightChartLabelSuffix() {
		return rightChartLabelSuffix;
	}

	public void setRightChartLabelSuffix(String rightChartLabelSuffix) {
		this.rightChartLabelSuffix = rightChartLabelSuffix;
	}

	public Integer getRightChartLabelValue() {
		return rightChartLabelValue;
	}

	public void setRightChartLabelValue(Integer rightChartLabelValue) {
		this.rightChartLabelValue = rightChartLabelValue;
	}

	public String getFontId() {
		return fontId;
	}

	public void setFontId(String fontId) {
		this.fontId = fontId;
	}

	public String getChartLabelTypeCode() {
		return chartLabelTypeCode;
	}

	public void setChartLabelTypeCode(String chartLabelTypeCode) {
		this.chartLabelTypeCode = chartLabelTypeCode;
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

	public List<KprAnalysisChartLabelDetailResDto> getChartLabelFontList() {
		return chartLabelFontList;
	}

	public void setChartLabelFontList(List<KprAnalysisChartLabelDetailResDto> chartLabelFontList) {
		this.chartLabelFontList = chartLabelFontList;
	}

	public String getFontTypeAttrib01() {
		return fontTypeAttrib01;
	}

	public void setFontTypeAttrib01(String fontTypeAttrib01) {
		this.fontTypeAttrib01 = fontTypeAttrib01;
	}

	public String getFontStyleAttrib01() {
		return fontStyleAttrib01;
	}

	public void setFontStyleAttrib01(String fontStyleAttrib01) {
		this.fontStyleAttrib01 = fontStyleAttrib01;
	}

	public String getFontStyleAttrib02() {
		return fontStyleAttrib02;
	}

	public void setFontStyleAttrib02(String fontStyleAttrib02) {
		this.fontStyleAttrib02 = fontStyleAttrib02;
	}
}