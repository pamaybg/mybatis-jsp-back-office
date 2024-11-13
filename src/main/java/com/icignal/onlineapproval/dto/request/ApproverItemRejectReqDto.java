package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTElapprovalUpdateRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 승인 및 반려 업데이트
 */
public class ApproverItemRejectReqDto extends CommonDataAuthReqDto{
    private String id;                      //고유 아이디
    private String memId;                   //회원 아이디
    private String rejectRsn;               //반려 사유
    private String statusCode;              //상태코드
    private String apvDd;                   //결제 일자
    private String itemId;                  //선택한 RowId
    private String apvrId;                   //승인자 사원 아이디
    private String aprvType;
    private String approvalTypeCd;          // 승인자 유형  9일경우 최종 승인자
    private String recordRid;
    private String elecAprvStatusCd;
    private String seq;
    private Boolean lastFlg;

    private String dataVal;
    private String elecAprvId;

    private String elecAprvEmpNo;
    private String elecAprvTitle;
    
    public Boolean getLastFlg() {
        return lastFlg;
    }
    public void setLastFlg(Boolean lastFlg) {
        this.lastFlg = lastFlg;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getMemId() {
        return memId;
    }
    public void setMemId(String memId) {
        this.memId = memId;
    }
    public String getRejectRsn() {
        return rejectRsn;
    }
    public void setRejectRsn(String rejectRsn) {
        this.rejectRsn = rejectRsn;
    }
    public String getStatusCode() {
        return statusCode;
    }
    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }
    public String getApvDd() {
        return apvDd;
    }
    public void setApvDd(String apvDd) {
        this.apvDd = apvDd;
    }
    public String getItemId() {
        return itemId;
    }
    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
    public String getApvrId() {
        return apvrId;
    }
    public void setApvrId(String apvrId) {
        this.apvrId = apvrId;
    }
    public String getAprvType() {
        return aprvType;
    }
    public void setAprvType(String aprvType) {
        this.aprvType = aprvType;
    }
    public String getRecordRid() {
        return recordRid;
    }
    public void setRecordRid(String recordRid) {
        this.recordRid = recordRid;
    }
    public String getElecAprvStatusCd() {
        return elecAprvStatusCd;
    }
    public void setElecAprvStatusCd(String elecAprvStatusCd) {
        this.elecAprvStatusCd = elecAprvStatusCd;
    }
    public String getSeq() {
        return seq;
    }
    public void setSeq(String seq) {
        this.seq = seq;
    }
    public String getApprovalTypeCd() {
        return approvalTypeCd;
    }
    public void setApprovalTypeCd(String approvalTypeCd) {
        this.approvalTypeCd = approvalTypeCd;
    }
    public String getDataVal() {return dataVal;}
    public void setDataVal(String dataVal) {this.dataVal = dataVal;}
    public String getElecAprvId() {return elecAprvId;}
    public void setElecAprvId(String elecAprvId) {this.elecAprvId = elecAprvId;}
    public String getElecAprvEmpNo() {
        return elecAprvEmpNo;
    }
    public void setElecAprvEmpNo(String elecAprvEmpNo) {
        this.elecAprvEmpNo = elecAprvEmpNo;
    }
    public String getElecAprvTitle() {
        return elecAprvTitle;
    }
    public void setElecAprvTitle(String elecAprvTitle) {
        this.elecAprvTitle = elecAprvTitle;
    }
}
