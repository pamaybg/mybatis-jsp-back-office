package com.icignal.marketing.calendar.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.marketing.calandar.dto.request
 * @date : 2015. 11. 16.
 * @author : 안형욱
 * @description : 캠페인 마스터 
 */
public class MktgetCampaignReqDto extends CommonDataAuthReqDto {
	
	private String campaignId;				//아이디
    private String campaignStatusCode;		//상태 코드
    private String campaignStatusCodeName;	//상태 코드명
    private String title;					//캠페인명
    private String campaignData;			//비고
    private String start;					//시작일
    private String end;						//종료일
    private String campaignTypeCode;		//캠페인 유형
    private String campaignTypeCodeName;	//캠페인 유형명  
    private String colorClass;				//캠페인 바 색상
    private String thisYear;				//연 달력 Year
	private String camNm;				 	//캠페인 명
	private String targetMonth;				//캠페인 타겟달
	private String brandCd;					//권한 - 브랜드 코드
	private String empId;					//권한 - empId
	private String authType;				//권한 타입
	
	public String getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}

	public String getCampaignStatusCode() {
		return campaignStatusCode;
	}

	public void setCampaignStatusCode(String campaignStatusCode) {
		this.campaignStatusCode = campaignStatusCode;
	}

	public String getCampaignStatusCodeName() {
		return campaignStatusCodeName;
	}

	public void setCampaignStatusCodeName(String campaignStatusCodeName) {
		this.campaignStatusCodeName = campaignStatusCodeName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCampaignData() {
		return campaignData;
	}

	public void setCampaignData(String campaignData) {
		this.campaignData = campaignData;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getCampaignTypeCode() {
		return campaignTypeCode;
	}

	public void setCampaignTypeCode(String campaignTypeCode) {
		this.campaignTypeCode = campaignTypeCode;
	}

	public String getCampaignTypeCodeName() {
		return campaignTypeCodeName;
	}

	public void setCampaignTypeCodeName(String campaignTypeCodeName) {
		this.campaignTypeCodeName = campaignTypeCodeName;
	}

	public String getColorClass() {
		return colorClass;
	}

	public void setColorClass(String colorClass) {
		this.colorClass = colorClass;
	}

	public String getThisYear() {
		return thisYear;
	}

	public void setThisYear(String thisYear) {
		this.thisYear = thisYear;
	}

	public String getCamNm() {
		return camNm;
	}

	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}

	public String getTargetMonth() {
		return targetMonth;
	}

	public void setTargetMonth(String targetMonth) {
		this.targetMonth = targetMonth;
	}

	public String getBrandCd() {return brandCd;}

	public void setBrandCd(String brandCd) {this.brandCd = brandCd;}

	public String getEmpId() {return empId;}

	public void setEmpId(String empId) {this.empId = empId;}

	public String getAuthType() {return authType;}

	public void setAuthType(String authType) {this.authType = authType;}
}
