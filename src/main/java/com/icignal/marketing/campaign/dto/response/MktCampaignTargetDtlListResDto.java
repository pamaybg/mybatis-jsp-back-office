package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 10. 27.
 * @author : 류동균
 * @description : 캠페인 프로그램
 */
public class MktCampaignTargetDtlListResDto extends GridPagingItemResDto {

    private String id;                          //아이디
    private String createBy;                    //생성자
    private String modifyBy;                    //수정자
    private String createDate;                  //생성일시
    private String modifyDate;                  //수정일시

    private String campaignId;                  //캠페인ID
    private String itemSeq;                     //항목순서
    private String campaignTargetHeaderId;      //캠페인 대상자 헤더 ID
    private String memberId;                    //회원 아이디
    private String controlGroupYn;              //제어그룹 여부
    private String exceptionYn;                 //제외 여부
    private String duplicateDeleteYn;           //중복 삭제 여부
    private String permissionCheckDeleteYn;     //허가 점검 삭제 여부
    private String fatigueCheckDeleteYn;        //피로도 점검 삭제 여부

    private String exceptionReasonCode;         //제외사유코드
    private String exceptionReasonCodeName;     //제외사유코드명

    private String segmentTargetId;             //세그먼트 대상자 ID
    private String segmentName;                 //세그먼트명

    private String exeInfoItemId;               //실행정보아이템 ID

    private String attrip01;    //속성01
    private String attrip02;    //속성02
    private String attrip03;    //속성03
    private String attrip04;    //속성04
    private String attrip05;    //속성05

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

    public String getAttrip01() {
        return attrip01;
    }

    public void setAttrip01(String attrip01) {
        this.attrip01 = attrip01;
    }

    public String getAttrip02() {
        return attrip02;
    }

    public void setAttrip02(String attrip02) {
        this.attrip02 = attrip02;
    }

    public String getAttrip03() {
        return attrip03;
    }

    public void setAttrip03(String attrip03) {
        this.attrip03 = attrip03;
    }

    public String getAttrip04() {
        return attrip04;
    }

    public void setAttrip04(String attrip04) {
        this.attrip04 = attrip04;
    }

    public String getAttrip05() {
        return attrip05;
    }

    public void setAttrip05(String attrip05) {
        this.attrip05 = attrip05;
    }

    public String getExeInfoItemId() {
        return exeInfoItemId;
    }

    public void setExeInfoItemId(String exeInfoItemId) {
        this.exeInfoItemId = exeInfoItemId;
    }

    public String getSegmentName() {
        return segmentName;
    }

    public void setSegmentName(String segmentName) {
        this.segmentName = segmentName;
    }


}
