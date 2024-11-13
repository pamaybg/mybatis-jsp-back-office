package com.icignal.onlineapproval.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 승인레포트 : 전체 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description :
 */
public class AprvReportResDto extends StatusResDto{

    private AprvReportCampaignResDto campaignDefaultInfo;   // 캠페인 기본정보
    private AprvReportTargetingResDto targetingInfo;        // 타겟팅 기본정보
    private AprvReportOfferResDto offerInfo;                // 오퍼 정보
    private AprvReportCoupnResDto coupnInfo;                // 쿠폰 정보
    private AprvReportPromInfoResDto promInfo;              // 프로모션 정보
    private List<AprvReportAprvResDto> approvalList;        // 승인자목록
    private AprvReportSchedulingResDto schedulingInfo;      // 일정 정보
    private List<AprvReportContsResDto> contsList;          // 발송채널 목록
    
    private List<List<AprvReportNodeResDto>> eventNodeList; // 이벤트 노드 목록
    private List<AprvReportCampaignResDto> relCampaignList; // 연관캠페인 목록
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public List<AprvReportCampaignResDto> getRelCampaignList() {
        return relCampaignList;
    }

    public void setRelCampaignList(List<AprvReportCampaignResDto> relCampaignList) {
        this.relCampaignList = relCampaignList;
    }

    public List<List<AprvReportNodeResDto>> getEventNodeList() {
        return eventNodeList;
    }

    public void setEventNodeList(List<List<AprvReportNodeResDto>> eventNodeList) {
        this.eventNodeList = eventNodeList;
    }

    public List<AprvReportContsResDto> getContsList() {
        return contsList;
    }

    public void setContsList(List<AprvReportContsResDto> contsList) {
        this.contsList = contsList;
    }

    public AprvReportSchedulingResDto getSchedulingInfo() {
        return schedulingInfo;
    }

    public void setSchedulingInfo(AprvReportSchedulingResDto schedulingInfo) {
        this.schedulingInfo = schedulingInfo;
    }

    public AprvReportCampaignResDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(AprvReportCampaignResDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

    public AprvReportTargetingResDto getTargetingInfo() {
        return targetingInfo;
    }

    public void setTargetingInfo(AprvReportTargetingResDto targetingInfo) {
        this.targetingInfo = targetingInfo;
    }

    public AprvReportOfferResDto getOfferInfo() {
        return offerInfo;
    }

    public void setOfferInfo(AprvReportOfferResDto offerInfo) {
        this.offerInfo = offerInfo;
    }

    public AprvReportCoupnResDto getCoupnInfo() {
        return coupnInfo;
    }

    public void setCoupnInfo(AprvReportCoupnResDto coupnInfo) {
        this.coupnInfo = coupnInfo;
    }

    public AprvReportPromInfoResDto getPromInfo() {
        return promInfo;
    }

    public void setPromInfo(AprvReportPromInfoResDto promInfo) {
        this.promInfo = promInfo;
    }

    public List<AprvReportAprvResDto> getApprovalList() {
        return approvalList;
    }

    public void setApprovalList(List<AprvReportAprvResDto> approvalList) {
        this.approvalList = approvalList;
    }

}
