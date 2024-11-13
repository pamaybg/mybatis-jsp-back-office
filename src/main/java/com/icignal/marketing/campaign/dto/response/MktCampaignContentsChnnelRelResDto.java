package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.StatusResDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignContentsChnnelRelResDto extends StatusResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    private String accountId;    //어카운트ID
    
    private String campaignId;    //캠페인 ID
    
    private String contentsId;    //콘텐츠ID
    private String chnnelId;    //채널ID
    private String urlInfo;    //url정보
    private String attachmentDesc;    //첨부파일설명
    private String treatmentDesc;    //처리설명
    private String contentsName;    //콘텐츠명
    
    private String exeDt;			// 실행일자
    private String exeTm;			// 실행시간
    
    private String useNotiYn;		//운영정책 구매유형 알림 사용유무
    
    private int promBuyYnCount;		//프로모션 구매유형 알림 사용유무
    private String exeType;
    


	

	public String getExeType() {
		return exeType;
	}

	public void setExeType(String exeType) {
		this.exeType = exeType;
	}

	public int getPromBuyYnCount() {
		return promBuyYnCount;
	}

	public void setPromBuyYnCount(int promBuyYnCount) {
		this.promBuyYnCount = promBuyYnCount;
	}

	public String getUseNotiYn() {
		return useNotiYn;
	}

	public void setUseNotiYn(String useNotiYn) {
		this.useNotiYn = useNotiYn;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getContentsId() {
        return contentsId;
    }

    public void setContentsId(String contentsId) {
        this.contentsId = contentsId;
    }

    public String getChnnelId() {
        return chnnelId;
    }

    public void setChnnelId(String chnnelId) {
        this.chnnelId = chnnelId;
    }

    public String getUrlInfo() {
        return urlInfo;
    }

    public void setUrlInfo(String urlInfo) {
        this.urlInfo = urlInfo;
    }

    public String getAttachmentDesc() {
        return attachmentDesc;
    }

    public void setAttachmentDesc(String attachmentDesc) {
        this.attachmentDesc = attachmentDesc;
    }

    public String getTreatmentDesc() {
        return treatmentDesc;
    }

    public void setTreatmentDesc(String treatmentDesc) {
        this.treatmentDesc = treatmentDesc;
    }

    public String getContentsName() {
        return contentsName;
    }

    public void setContentsName(String contentsName) {
        this.contentsName = contentsName;
    }

	public String getExeDt() {
		return exeDt;
	}

	public void setExeDt(String exeDt) {
		this.exeDt = exeDt;
	}

	public String getExeTm() {
		return exeTm;
	}

	public void setExeTm(String exeTm) {
		this.exeTm = exeTm;
	}


}
