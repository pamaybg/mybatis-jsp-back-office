package com.icignal.marketing.calendar.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTCampaignListResponseDTO.java
 * @date : 2015. 11. 16.
 * @author : 안형욱
 * @description : 캠페인 목록조회 ResponseDTO
 */
public class MktgetCampaignResDto extends GridPagingItemResDto {
	
	private String campaignId;				//아이디
    private String campaignStatusCode;		//상태 코드
	private String campaignStatusCodeName;	//상태 코드명
    private String title;					//캠페인명, monthCalendar title
    private String campaignData;			//비고
    private String start;					//시작일
    private String end;						//종료일
    private String camTypeCodeName;			//캠페인 유형명(code_name)
    private String campaignTypeCode;		//캠페인 유형
    private String campaignTypeCodeName;	//캠페인 유형명(mark_name)  
    private String colorClass;				//캠페인 바 색상
    private String campaignPeriod;			//캠페인 기간 , yearCalendar title 

	



	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
	
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

		public String getCamTypeCodeName() {
			return camTypeCodeName;
		}

		public void setCamTypeCodeName(String camTypeCodeName) {
			this.camTypeCodeName = camTypeCodeName;
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


		public String getCampaignPeriod() {
			return campaignPeriod;
		}


		public void setCampaignPeriod(String campaignPeriod) {
			this.campaignPeriod = campaignPeriod;
		}

}
