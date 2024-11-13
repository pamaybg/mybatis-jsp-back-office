package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 10. 27.
 * @author : 류동균
 * @description : 캠페인 프로그램
 */
public class MktCampaignTargetTotalCountResDto extends StatusResDto {
    
    private String campaignId;    //캠페인 ID
    
    private String campaignTargetTotalCount;    //대상자 전체건수
    private String duplicateRemoveCount;    //중복 제거 전체 건수
    private String fatigueCheckRemoveTotalCount;    //피로도 제거 전체 건수
    private String authorityCheckRemoveTotalCount;    //퍼미션 제거 전체 건수
    private String oneCaseRemoveTotalCount;    //건 삭제 전체 건수
    private String ControlGroupCount;    //비교군 전체 건수
    private String finalCount;    //최종건수
    private String comparAmt; //비교 대상자 군 수

    private String tgtGroupId; // 타겟 그룹 아이디
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getCampaignTargetTotalCount() {
        return campaignTargetTotalCount;
    }

    public void setCampaignTargetTotalCount(String campaignTargetTotalCount) {
        this.campaignTargetTotalCount = campaignTargetTotalCount;
    }

    public String getDuplicateRemoveCount() {
        return duplicateRemoveCount;
    }

    public void setDuplicateRemoveCount(String duplicateRemoveCount) {
        this.duplicateRemoveCount = duplicateRemoveCount;
    }

    public String getFatigueCheckRemoveTotalCount() {
        return fatigueCheckRemoveTotalCount;
    }

    public void setFatigueCheckRemoveTotalCount(String fatigueCheckRemoveTotalCount) {
        this.fatigueCheckRemoveTotalCount = fatigueCheckRemoveTotalCount;
    }

    public String getAuthorityCheckRemoveTotalCount() {
        return authorityCheckRemoveTotalCount;
    }

    public void setAuthorityCheckRemoveTotalCount(
            String authorityCheckRemoveTotalCount) {
        this.authorityCheckRemoveTotalCount = authorityCheckRemoveTotalCount;
    }

    public String getFinalCount() {
        return finalCount;
    }

    public void setFinalCount(String finalCount) {
        this.finalCount = finalCount;
    }

    public String getOneCaseRemoveTotalCount() {
        return oneCaseRemoveTotalCount;
    }

    public void setOneCaseRemoveTotalCount(String oneCaseRemoveTotalCount) {
        this.oneCaseRemoveTotalCount = oneCaseRemoveTotalCount;
    }

    public String getControlGroupCount() {
        return ControlGroupCount;
    }

    public void setControlGroupCount(String controlGroupCount) {
        ControlGroupCount = controlGroupCount;
    }

	public String getComparAmt() {
		return comparAmt;
	}

	public void setComparAmt(String comparAmt) {
		this.comparAmt = comparAmt;
	}

    public String getTgtGroupId() {
        return tgtGroupId;
    }

    public void setTgtGroupId(String tgtGroupId) {
        this.tgtGroupId = tgtGroupId;
    }
}
