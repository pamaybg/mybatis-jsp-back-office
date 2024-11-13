package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 10. 27.
 * @author : 류동균
 * @description : 캠페인 프로그램
 */
public class MktCampaignTargetListResDto extends GridPagingItemResDto {
    
    private String id;     //아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자
    private String createDate;     //생성일시
    private String modifyDate;     //수정일시
    
    private String campaignId;    //캠페인아이디
    
    private String campaignTargetTypeCode;    //타겟유형코드
    private String campaignTargetTypeCodeName;    //타겟유형코드명
    
    private String campaignTargetCount;    //캠페인대상자건수
    private String controlGroupCount;   //제어그룹건수
    
    private String controlGroupUnitCode;    //제어그룹단위코드
    private String controlGroupUnitCodeName;    //제어그룹단위코드명
    
    private String duplicateRemoveCount;    //중복제거건수
    private String fatigueCheckRemoveCount;    //피로도점검제거건수
    private String authorityCheckRemoveCount;    //권한점검제거건수
    private String oneCaseRemoveTotalCount;    //건제거건수
    private String finalCount;     //최종건수
    
    private String segmentId;    //세그먼트 ID
    private String segmentName;    //세그먼트명
    
    private String campaignTargetDesc;    //캠페인대상자설명
    private String campaignTargetFileName;    //캠페인대상자파일명
    private String segmentTargetIncYn;    //세그먼트대상자증가여부

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

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getCampaignTargetTypeCode() {
        return campaignTargetTypeCode;
    }

    public void setCampaignTargetTypeCode(String campaignTargetTypeCode) {
        this.campaignTargetTypeCode = campaignTargetTypeCode;
    }

    public String getCampaignTargetTypeCodeName() {
        return campaignTargetTypeCodeName;
    }

    public void setCampaignTargetTypeCodeName(String campaignTargetTypeCodeName) {
        this.campaignTargetTypeCodeName = campaignTargetTypeCodeName;
    }

    public String getCampaignTargetCount() {
        return campaignTargetCount;
    }

    public void setCampaignTargetCount(String campaignTargetCount) {
        this.campaignTargetCount = campaignTargetCount;
    }

    public String getControlGroupCount() {
        return controlGroupCount;
    }

    public void setControlGroupCount(String controlGroupCount) {
        this.controlGroupCount = controlGroupCount;
    }

    public String getControlGroupUnitCode() {
        return controlGroupUnitCode;
    }

    public void setControlGroupUnitCode(String controlGroupUnitCode) {
        this.controlGroupUnitCode = controlGroupUnitCode;
    }

    public String getControlGroupUnitCodeName() {
        return controlGroupUnitCodeName;
    }

    public void setControlGroupUnitCodeName(String controlGroupUnitCodeName) {
        this.controlGroupUnitCodeName = controlGroupUnitCodeName;
    }

    public String getDuplicateRemoveCount() {
        return duplicateRemoveCount;
    }

    public void setDuplicateRemoveCount(String duplicateRemoveCount) {
        this.duplicateRemoveCount = duplicateRemoveCount;
    }

    public String getFatigueCheckRemoveCount() {
        return fatigueCheckRemoveCount;
    }

    public void setFatigueCheckRemoveCount(String fatigueCheckRemoveCount) {
        this.fatigueCheckRemoveCount = fatigueCheckRemoveCount;
    }

    public String getAuthorityCheckRemoveCount() {
        return authorityCheckRemoveCount;
    }

    public void setAuthorityCheckRemoveCount(String authorityCheckRemoveCount) {
        this.authorityCheckRemoveCount = authorityCheckRemoveCount;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getCampaignTargetDesc() {
        return campaignTargetDesc;
    }

    public void setCampaignTargetDesc(String campaignTargetDesc) {
        this.campaignTargetDesc = campaignTargetDesc;
    }

    public String getCampaignTargetFileName() {
        return campaignTargetFileName;
    }

    public void setCampaignTargetFileName(String campaignTargetFileName) {
        this.campaignTargetFileName = campaignTargetFileName;
    }

    public String getSegmentTargetIncYn() {
        return segmentTargetIncYn;
    }

    public void setSegmentTargetIncYn(String segmentTargetIncYn) {
        this.segmentTargetIncYn = segmentTargetIncYn;
    }

    public String getSegmentName() {
        return segmentName;
    }

    public void setSegmentName(String segmentName) {
        this.segmentName = segmentName;
    }

    public String getOneCaseRemoveTotalCount() {
        return oneCaseRemoveTotalCount;
    }

    public void setOneCaseRemoveTotalCount(String oneCaseRemoveTotalCount) {
        this.oneCaseRemoveTotalCount = oneCaseRemoveTotalCount;
    }

    public String getFinalCount() {
        return finalCount;
    }

    public void setFinalCount(String finalCount) {
        this.finalCount = finalCount;
    }
	
}
