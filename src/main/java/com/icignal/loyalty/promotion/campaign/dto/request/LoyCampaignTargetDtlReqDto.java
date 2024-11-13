package com.icignal.loyalty.promotion.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignTargetDtlReqDto extends CommonDataAuthReqDto {
	
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인ID
    private String itemSeq;    //항목순서
    private String campaignTargetHeaderId;    //캠페인 대상자 헤더 아이디
    private String memberId;    //회원 아이디
    private String controlGroupYn;    //제어그룹 여부
    private String exceptionYn;    //제외 여부
    private String duplicateDeleteYn;    //중복 삭제 여부
    private String permissionCheckDeleteYn;    //허가 점검 삭제 여부
    private String fatigueCheckDeleteYn;    //피로도 점검 삭제 여부
    
    private String exceptionReasonCode;    //제외사유코드
    private String exceptionReasonCodeName;    //제외사유코드명
    
    private String segmentTargetId;    //세그먼트 대상자 아이디
    private String referenceKey;    //참고 키
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getItemSeq() {
        return itemSeq;
    }

    public void setItemSeq(String itemSeq) {
        this.itemSeq = itemSeq;
    }

    public String getCampaignTargetHeaderId() {
        return campaignTargetHeaderId;
    }

    public void setCampaignTargetHeaderId(String campaignTargetHeaderId) {
        this.campaignTargetHeaderId = campaignTargetHeaderId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getControlGroupYn() {
        return controlGroupYn;
    }

    public void setControlGroupYn(String controlGroupYn) {
        this.controlGroupYn = controlGroupYn;
    }

    public String getExceptionYn() {
        return exceptionYn;
    }

    public void setExceptionYn(String exceptionYn) {
        this.exceptionYn = exceptionYn;
    }

    public String getDuplicateDeleteYn() {
        return duplicateDeleteYn;
    }

    public void setDuplicateDeleteYn(String duplicateDeleteYn) {
        this.duplicateDeleteYn = duplicateDeleteYn;
    }

    public String getPermissionCheckDeleteYn() {
        return permissionCheckDeleteYn;
    }

    public void setPermissionCheckDeleteYn(String permissionCheckDeleteYn) {
        this.permissionCheckDeleteYn = permissionCheckDeleteYn;
    }

    public String getFatigueCheckDeleteYn() {
        return fatigueCheckDeleteYn;
    }

    public void setFatigueCheckDeleteYn(String fatigueCheckDeleteYn) {
        this.fatigueCheckDeleteYn = fatigueCheckDeleteYn;
    }

    public String getExceptionReasonCode() {
        return exceptionReasonCode;
    }

    public void setExceptionReasonCode(String exceptionReasonCode) {
        this.exceptionReasonCode = exceptionReasonCode;
    }

    public String getExceptionReasonCodeName() {
        return exceptionReasonCodeName;
    }

    public void setExceptionReasonCodeName(String exceptionReasonCodeName) {
        this.exceptionReasonCodeName = exceptionReasonCodeName;
    }

    public String getSegmentTargetId() {
        return segmentTargetId;
    }

    public void setSegmentTargetId(String segmentTargetId) {
        this.segmentTargetId = segmentTargetId;
    }

    public String getReferenceKey() {
        return referenceKey;
    }

    public void setReferenceKey(String referenceKey) {
        this.referenceKey = referenceKey;
    }
}
