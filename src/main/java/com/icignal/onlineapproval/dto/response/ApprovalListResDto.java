package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @author : 박지열
 * @name : MKTElapprovalListResponseDTO
 * @date : 2015. 09. 21.
 * @description : 전자 결제 목록 조회
 */

@CommCode
public class ApprovalListResDto extends GridPagingItemResDto {

    private String id;                    //아이디
    private String elecAprvNo;            //전자결재 번호
    private String camName;                  //전자결재 유형 코드
    private String camDd;              //캠페인 명

    private String camTypeCd;
    @MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "camTypeCd")
    private String camType;               //최종결제자
    private String createDd;              //전자결재 상태 코드

    private String elecAprvStatusCode;
    @MarkName(groupCode = "EL_APPROVAL_STATUS_CD", codeField = "elecAprvStatusCode")
    private String elecAprvStatusCd;      //전자결재 요청자 아이디
    private String lastApvDd;              //전자결재 완료 요청 일자
    private String itemId;                //승인자 Row Id
    private String itemStatus;            //현재 접속한 사람의 상태
    private String lastApvrName;          //최종승인자
    private String elecAprvTypeCode;
    @MarkName(groupCode = "APRV_TYPE_CD", codeField = "elecAprvTypeCode")
    private String elecAprvTypeCd;
    private String elecAprvTitle;
    private String elecAprvRqtrId;        //결제 요청자ID
    private String elecAprvEmpNo;          //결재 요청자 매장코드
    private String elecAprvRqtrNm;        //전자결제요청자명
    private String createDate;
    private String lastApvrId;
    private String recordRid;
    private String aprvType;            // 승인유형
    private String seq;                    // 승인순서
    private String apvrTypeCd;            // 승인자 유형 9 일경우 최종 승인자     else 3

    private String dispNo;
    private String campaignStartDate;
    private String campaignStatusCode;
    private String campaignTypeCode;
    private String offerCheckTypeCd;
    private String elecAprvType;
    private String camPlnerType;

    public String getElecAprvRqtrNm() {
        return elecAprvRqtrNm;
    }

    public void setElecAprvRqtrNm(String elecAprvRqtrNm) {
        this.elecAprvRqtrNm = elecAprvRqtrNm;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getElecAprvNo() {
        return elecAprvNo;
    }

    public void setElecAprvNo(String elecAprvNo) {
        this.elecAprvNo = elecAprvNo;
    }

    public String getCamName() {
        return camName;
    }

    public void setCamName(String camName) {
        this.camName = camName;
    }

    public String getCamDd() {
        return camDd;
    }

    public void setCamDd(String camDd) {
        this.camDd = camDd;
    }

    public String getCamType() {
        return camType;
    }

    public void setCamType(String camType) {
        this.camType = camType;
    }

    public String getCreateDd() {
        return createDd;
    }

    public void setCreateDd(String createDd) {
        this.createDd = createDd;
    }

    public String getElecAprvStatusCd() {
        return elecAprvStatusCd;
    }

    public void setElecAprvStatusCd(String elecAprvStatusCd) {
        this.elecAprvStatusCd = elecAprvStatusCd;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemStatus() {
        return itemStatus;
    }

    public void setItemStatus(String itemStatus) {
        this.itemStatus = itemStatus;
    }

    public String getLastApvrName() {
        return lastApvrName;
    }

    public void setLastApvrName(String lastApvrName) {
        this.lastApvrName = lastApvrName;
    }

    public String getLastApvDd() {
        return lastApvDd;
    }

    public void setLastApvDd(String lastApvDd) {
        this.lastApvDd = lastApvDd;
    }

    public String getElecAprvTypeCd() {
        return elecAprvTypeCd;
    }

    public void setElecAprvTypeCd(String elecAprvTypeCd) {
        this.elecAprvTypeCd = elecAprvTypeCd;
    }

    public String getElecAprvTitle() {
        return elecAprvTitle;
    }

    public void setElecAprvTitle(String elecAprvTitle) {
        this.elecAprvTitle = elecAprvTitle;
    }

    public String getElecAprvRqtrId() {
        return elecAprvRqtrId;
    }

    public void setElecAprvRqtrId(String elecAprvRqtrId) {
        this.elecAprvRqtrId = elecAprvRqtrId;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getLastApvrId() {
        return lastApvrId;
    }

    public void setLastApvrId(String lastApvrId) {
        this.lastApvrId = lastApvrId;
    }

    public String getRecordRid() {
        return recordRid;
    }

    public void setRecordRid(String recordRid) {
        this.recordRid = recordRid;
    }

    public String getAprvType() {
        return aprvType;
    }

    public void setAprvType(String aprvType) {
        this.aprvType = aprvType;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getApvrTypeCd() {
        return apvrTypeCd;
    }

    public void setApvrTypeCd(String apvrTypeCd) {
        this.apvrTypeCd = apvrTypeCd;
    }

    public String getElecAprvTypeCode() {
        return elecAprvTypeCode;
    }

    public void setElecAprvTypeCode(String elecAprvTypeCode) {
        this.elecAprvTypeCode = elecAprvTypeCode;
    }

    public String getElecAprvStatusCode() {
        return elecAprvStatusCode;
    }

    public void setElecAprvStatusCode(String elecAprvStatusCode) {
        this.elecAprvStatusCode = elecAprvStatusCode;
    }

    public String getCamTypeCd() {
        return camTypeCd;
    }

    public void setCamTypeCd(String camTypeCd) {
        this.camTypeCd = camTypeCd;
    }

    public String getDispNo() {
        return dispNo;
    }

    public void setDispNo(String dispNo) {
        this.dispNo = dispNo;
    }

    public String getCampaignStartDate() {
        return campaignStartDate;
    }

    public void setCampaignStartDate(String campaignStartDate) {
        this.campaignStartDate = campaignStartDate;
    }

    public String getCampaignStatusCode() {
        return campaignStatusCode;
    }

    public void setCampaignStatusCode(String campaignStatusCode) {
        this.campaignStatusCode = campaignStatusCode;
    }

    public String getCampaignTypeCode() {
        return campaignTypeCode;
    }

    public void setCampaignTypeCode(String campaignTypeCode) {
        this.campaignTypeCode = campaignTypeCode;
    }

    public String getOfferCheckTypeCd() {
        return offerCheckTypeCd;
    }

    public void setOfferCheckTypeCd(String offerCheckTypeCd) {
        this.offerCheckTypeCd = offerCheckTypeCd;
    }

    public String getElecAprvType() {
        return elecAprvType;
    }

    public void setElecAprvType(String elecAprvType) {
        this.elecAprvType = elecAprvType;
    }

    public String getElecAprvEmpNo() {
        return elecAprvEmpNo;
    }

    public void setElecAprvEmpNo(String elecAprvEmpNo) {
        this.elecAprvEmpNo = elecAprvEmpNo;
    }

    public String getCamPlnerType() {
        return camPlnerType;
    }

    public void setCamPlnerType(String camPlnerType) {
        this.camPlnerType = camPlnerType;
    }
}
