package com.icignal.onlineapproval.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTApprvReqRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결재 승인자 조회
 */
public class CommonApprovalReqDto extends CommonDataAuthReqDto{

    private String aprvType;    //승인업무유형 (공통코드 : APRV_TYPE_CD)
    private String aprvTitle;   //승인요청 TITLE (ex) 캠페인명, 등
    private String reqRid;      //승인요청자 RID
    private String fstRid;      //1차 승인자 RID
    private String secRid;      //2차 승인자 RID
    private Boolean lastFlg;
    private String recordRid;   //요청건의 RID
    private String elecAprvTblNm;
    private String rid;
    private String status;     // 1차 승인요청 : 10    1차 승인처리 : 20    1차 승인거절 :30 2차 승인처리 : 40    2차 승인거절 : 50
    private String rejectRsn;  // 거절사유
    private String trtStatus;  //수동요청용   상태값
    private List<ApproverListReqDto> approverList;
    private String apvId;
    private String getSeqNo;

    private String apvrId;
    private String dataVal;

    private String elecAprvEmpName;
    private String elecAprvEmpNo;
    private String elecAprvTitle;

    public String getAprvType() {
        return aprvType;
    }

    public void setAprvType(String aprvType) {
        this.aprvType = aprvType;
    }

    public String getAprvTitle() {
        return aprvTitle;
    }

    public void setAprvTitle(String aprvTitle) {
        this.aprvTitle = aprvTitle;
    }

    public String getReqRid() {
        return reqRid;
    }

    public void setReqRid(String reqRid) {
        this.reqRid = reqRid;
    }

    public String getFstRid() {
        return fstRid;
    }

    public void setFstRid(String fstRid) {
        this.fstRid = fstRid;
    }

    public String getSecRid() {
        return secRid;
    }

    public void setSecRid(String secRid) {
        this.secRid = secRid;
    }

    public String getRecordRid() {
        return recordRid;
    }

    public void setRecordRid(String recordRid) {
        this.recordRid = recordRid;
    }

    public String getElecAprvTblNm() {
        return elecAprvTblNm;
    }

    public void setElecAprvTblNm(String elecAprvTblNm) {
        this.elecAprvTblNm = elecAprvTblNm;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrtStatus() {
        return trtStatus;
    }

    public void setTrtStatus(String trtStatus) {
        this.trtStatus = trtStatus;
    }

    public String getRejectRsn() {
        return rejectRsn;
    }

    public void setRejectRsn(String rejectRsn) {
        this.rejectRsn = rejectRsn;
    }

    public List<ApproverListReqDto> getApproverList() {
        return approverList;
    }

    public void setApproverList(List<ApproverListReqDto> approverList) {
        this.approverList = approverList;
    }

    public Boolean getLastFlg() {
        return lastFlg;
    }

    public void setLastFlg(Boolean lastFlg) {
        this.lastFlg = lastFlg;
    }

	/**
	* @return the apvId
	*/
	public String getApvId() {
		return apvId;
	}

	/**
	* @param apvId the apvId to set
	*/
	public void setApvId(String apvId) {
		this.apvId = apvId;
	}

    public String getGetSeqNo() {return getSeqNo;}

    public void setGetSeqNo(String getSeqNo) {this.getSeqNo = getSeqNo;}

    public String getApvrId() {return apvrId;}

    public void setApvrId(String apvrId) {this.apvrId = apvrId;}

    public String getDataVal() {return dataVal;}

    public void setDataVal(String dataVal) {this.dataVal = dataVal;}

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

    public String getElecAprvEmpName() {
        return elecAprvEmpName;
    }

    public void setElecAprvEmpName(String elecAprvEmpName) {
        this.elecAprvEmpName = elecAprvEmpName;
    }
}
