package com.icignal.onlineapproval.dto.response;

import com.icignal.core.annotation.commcode.MarkName;

public class AprvSendContsResDto {

    private String id;                    //아이디
    private String elecAprvNo;            //전자결재 번호

    private String lastApvDd;
    private String elecAprvStatusCode;

    private String itemId;                //승인자 Row Id

    private String elecAprvTypeCode;

    private String elecAprvTitle;
    private String elecAprvRqtrId;        //결제 요청자ID

    private String createDate;
    private String lastApvrId;
    private String recordRid;
    private String aprvType;			// 승인유형
    private String seq;					// 승인순서
    private String apvrTypeCd;			// 승인자 유형 9 일경우 최종 승인자     else 3

    private String reqMobileNo;
    private String resMobileNo;
    private String contents;

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

    public String getLastApvDd() {
        return lastApvDd;
    }

    public void setLastApvDd(String lastApvDd) {
        this.lastApvDd = lastApvDd;
    }

    public String getElecAprvStatusCode() {
        return elecAprvStatusCode;
    }

    public void setElecAprvStatusCode(String elecAprvStatusCode) {
        this.elecAprvStatusCode = elecAprvStatusCode;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getElecAprvTypeCode() {
        return elecAprvTypeCode;
    }

    public void setElecAprvTypeCode(String elecAprvTypeCode) {
        this.elecAprvTypeCode = elecAprvTypeCode;
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

    public String getReqMobileNo() {
        return reqMobileNo;
    }

    public void setReqMobileNo(String reqMobileNo) {
        this.reqMobileNo = reqMobileNo;
    }

    public String getResMobileNo() {
        return resMobileNo;
    }

    public void setResMobileNo(String resMobileNo) {
        this.resMobileNo = resMobileNo;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }
}
