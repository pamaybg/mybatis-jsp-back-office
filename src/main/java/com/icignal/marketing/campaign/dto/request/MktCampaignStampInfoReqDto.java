package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : MktCampaignStampInfoReqDto.java
 * @date : 2018. 04. 25.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 스탬프형  ReqDto
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignStampInfoReqDto extends MKTBaseReqDto {
    
	private String ridCam;						//캠페인 RID
	
	private String inactiveStampImageFileName;
	private String inactiveStampImageFile;
	private String inactiveStampOriName;
	
	private String activeStampImageFileName;
	private String activeStampImageFile;
	private String activeStampOriName;
	
	private List<String> notDelRids;			//삭제 제외 RID
	
	private List<MktCampaignStampListReqDto> rows;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRidCam() {
		return ridCam;
	}

	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}

	public List<String> getNotDelRids() {
		return notDelRids;
	}

	public void setNotDelRids(List<String> notDelRids) {
		this.notDelRids = notDelRids;
	}

	public List<MktCampaignStampListReqDto> getRows() {
		return rows;
	}

	public void setRows(List<MktCampaignStampListReqDto> rows) {
		this.rows = rows;
	}

	public String getInactiveStampImageFileName() {
		return inactiveStampImageFileName;
	}

	public void setInactiveStampImageFileName(String inactiveStampImageFileName) {
		this.inactiveStampImageFileName = inactiveStampImageFileName;
	}

	public String getInactiveStampImageFile() {
		return inactiveStampImageFile;
	}

	public void setInactiveStampImageFile(String inactiveStampImageFile) {
		this.inactiveStampImageFile = inactiveStampImageFile;
	}

	public String getInactiveStampOriName() {
		return inactiveStampOriName;
	}

	public void setInactiveStampOriName(String inactiveStampOriName) {
		this.inactiveStampOriName = inactiveStampOriName;
	}

	public String getActiveStampImageFileName() {
		return activeStampImageFileName;
	}

	public void setActiveStampImageFileName(String activeStampImageFileName) {
		this.activeStampImageFileName = activeStampImageFileName;
	}

	public String getActiveStampImageFile() {
		return activeStampImageFile;
	}

	public void setActiveStampImageFile(String activeStampImageFile) {
		this.activeStampImageFile = activeStampImageFile;
	}

	public String getActiveStampOriName() {
		return activeStampOriName;
	}

	public void setActiveStampOriName(String activeStampOriName) {
		this.activeStampOriName = activeStampOriName;
	}

}
