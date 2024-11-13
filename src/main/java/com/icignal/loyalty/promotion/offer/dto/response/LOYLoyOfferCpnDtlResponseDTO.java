package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @name : infavor.loyalty.offer.dto.response.LOYLoyOfferCpnDtlResponseDTO
 * @date : 2017. 6. 28.
 * @author : "jh.kim"
 * @description : 로얄티 오퍼 쿠폰 상세 Response DTO 
 */
public class LOYLoyOfferCpnDtlResponseDTO extends StatusResDto {

    private String rid;                   //RID
    private String ridMktOfferMst;        //RID_오퍼마스터
    private String issueStatCd;           //발급 상태 코드
    private String cpnTypeCd;             //쿠폰 유형 코드
    private String issueTmplCd;           //발급 양식 코드
    private String mbrMappTypeCd;         //회원 매핑 유형 코드
    private String cpnNoTypeCd;           //쿠폰 번호 유형 코드
    private String cpnPrtGrpNo;           //쿠폰 발행 그룹 번호
    private String prtStartdt;            //발행 시작일
    private String prtEnddt;              //발행 종료일
    private String usePsblStartdtType;    //사용 가능 시작일 유형
    private String usePsblStartdt;        //사용 가능 시작일
    private String usePsblStartdtPlusVal; //사용 가능 시작일 플러스 값
    private String usePsblEnddtPlusVal;   //사용 가능 종료일 플러스 값
    private String usePsblTimeDtlTypeCd;  //사용 가능 시간 상세 유형 코드
    private String dcType;                //할인 유형
    private String dcVal;                 //할인 값
    private String dcMaxAmt;              //할인 최대 금액
    private String dcMaxAmtCucy;          //할인 최대 금액 통화
    private String dupIssuePsblCnt;       //중복 발급 가능 건수
    private String usePsblCnt;            //사용 가능 건수
    private String dt1UsePsblCnt;         //1일 사용 가능 건수
    private String flag;                  //FLAG
    private String modNum;                //MOD_NUM
    private String createDate;            //CREATE_DATE
    private String createBy;              //CREATE_BY
    private String modifyDate;            //수정일시
    private String modifyBy;              //MODIFY_BY
    
    private String issueStatCdNm;
    private String cpnTypeCdNm;
    private String issueTmplCdNm;
    private String mbrMappTypeCdNm;
    private String cpnNoTypeCdNm;
    private String cpnPrtGrpNoNm;
    private String dcTypeNm;
    private String dupIssuePsblCntNm;
    private String usePsblCntNm;
    private String dt1UsePsblCntNm;
    
    private String createName;
    
    public String getCreateName() {
        return createName;
    }
    
    public void setCreateName(String createName) {
        this.createName = createName;
    }
    
    public String getIssueStatCdNm() {
        return issueStatCdNm;
    }
    
    public void setIssueStatCdNm(String issueStatCdNm) {
        this.issueStatCdNm = issueStatCdNm;
    }
    
    public String getCpnTypeCdNm() {
        return cpnTypeCdNm;
    }

    public void setCpnTypeCdNm(String cpnTypeCdNm) {
        this.cpnTypeCdNm = cpnTypeCdNm;
    }

    public String getIssueTmplCdNm() {
        return issueTmplCdNm;
    }

    public void setIssueTmplCdNm(String issueTmplCdNm) {
        this.issueTmplCdNm = issueTmplCdNm;
    }

    public String getMbrMappTypeCdNm() {
        return mbrMappTypeCdNm;
    }

    public void setMbrMappTypeCdNm(String mbrMappTypeCdNm) {
        this.mbrMappTypeCdNm = mbrMappTypeCdNm;
    }

    public String getCpnNoTypeCdNm() {
        return cpnNoTypeCdNm;
    }

    public void setCpnNoTypeCdNm(String cpnNoTypeCdNm) {
        this.cpnNoTypeCdNm = cpnNoTypeCdNm;
    }

    public String getCpnPrtGrpNoNm() {
        return cpnPrtGrpNoNm;
    }

    public void setCpnPrtGrpNoNm(String cpnPrtGrpNoNm) {
        this.cpnPrtGrpNoNm = cpnPrtGrpNoNm;
    }

    public String getDcTypeNm() {
        return dcTypeNm;
    }

    public void setDcTypeNm(String dcTypeNm) {
        this.dcTypeNm = dcTypeNm;
    }

    public String getDupIssuePsblCntNm() {
        return dupIssuePsblCntNm;
    }

    public void setDupIssuePsblCntNm(String dupIssuePsblCntNm) {
        this.dupIssuePsblCntNm = dupIssuePsblCntNm;
    }

    public String getUsePsblCntNm() {
        return usePsblCntNm;
    }

    public void setUsePsblCntNm(String usePsblCntNm) {
        this.usePsblCntNm = usePsblCntNm;
    }

    public String getDt1UsePsblCntNm() {
        return dt1UsePsblCntNm;
    }

    public void setDt1UsePsblCntNm(String dt1UsePsblCntNm) {
        this.dt1UsePsblCntNm = dt1UsePsblCntNm;
    }

    public String getRid() {
        return rid;
    }
    
    public void setRid(String rid) {
        this.rid = rid;
    }
    
    public String getRidMktOfferMst() {
        return ridMktOfferMst;
    }
    
    public void setRidMktOfferMst(String ridMktOfferMst) {
        this.ridMktOfferMst = ridMktOfferMst;
    }
    
    public String getIssueStatCd() {
        return issueStatCd;
    }
    
    public void setIssueStatCd(String issueStatCd) {
        this.issueStatCd = issueStatCd;
    }
    
    public String getCpnTypeCd() {
        return cpnTypeCd;
    }
    
    public void setCpnTypeCd(String cpnTypeCd) {
        this.cpnTypeCd = cpnTypeCd;
    }
    
    public String getIssueTmplCd() {
        return issueTmplCd;
    }
    
    public void setIssueTmplCd(String issueTmplCd) {
        this.issueTmplCd = issueTmplCd;
    }
    
    public String getMbrMappTypeCd() {
        return mbrMappTypeCd;
    }
    
    public void setMbrMappTypeCd(String mbrMappTypeCd) {
        this.mbrMappTypeCd = mbrMappTypeCd;
    }
    
    public String getCpnNoTypeCd() {
        return cpnNoTypeCd;
    }
    
    public void setCpnNoTypeCd(String cpnNoTypeCd) {
        this.cpnNoTypeCd = cpnNoTypeCd;
    }
    
    public String getCpnPrtGrpNo() {
        return cpnPrtGrpNo;
    }
    
    public void setCpnPrtGrpNo(String cpnPrtGrpNo) {
        this.cpnPrtGrpNo = cpnPrtGrpNo;
    }
    
    public String getPrtStartdt() {
        return prtStartdt;
    }
    
    public void setPrtStartdt(String prtStartdt) {
        this.prtStartdt = prtStartdt;
    }
    
    public String getPrtEnddt() {
        return prtEnddt;
    }
    
    public void setPrtEnddt(String prtEnddt) {
        this.prtEnddt = prtEnddt;
    }
    
    public String getUsePsblStartdtType() {
        return usePsblStartdtType;
    }
    
    public void setUsePsblStartdtType(String usePsblStartdtType) {
        this.usePsblStartdtType = usePsblStartdtType;
    }
    
    public String getUsePsblStartdt() {
        return usePsblStartdt;
    }
    
    public void setUsePsblStartdt(String usePsblStartdt) {
        this.usePsblStartdt = usePsblStartdt;
    }
    
    public String getUsePsblStartdtPlusVal() {
        return usePsblStartdtPlusVal;
    }
    
    public void setUsePsblStartdtPlusVal(String usePsblStartdtPlusVal) {
        this.usePsblStartdtPlusVal = usePsblStartdtPlusVal;
    }
    
    public String getUsePsblEnddtPlusVal() {
        return usePsblEnddtPlusVal;
    }
    
    public void setUsePsblEnddtPlusVal(String usePsblEnddtPlusVal) {
        this.usePsblEnddtPlusVal = usePsblEnddtPlusVal;
    }
    
    public String getUsePsblTimeDtlTypeCd() {
        return usePsblTimeDtlTypeCd;
    }
    
    public void setUsePsblTimeDtlTypeCd(String usePsblTimeDtlTypeCd) {
        this.usePsblTimeDtlTypeCd = usePsblTimeDtlTypeCd;
    }
    
    public String getDcType() {
        return dcType;
    }
    
    public void setDcType(String dcType) {
        this.dcType = dcType;
    }
    
    public String getDcVal() {
        return dcVal;
    }
    
    public void setDcVal(String dcVal) {
        this.dcVal = dcVal;
    }
    
    public String getDcMaxAmt() {
        return dcMaxAmt;
    }
    
    public void setDcMaxAmt(String dcMaxAmt) {
        this.dcMaxAmt = dcMaxAmt;
    }
    
    public String getDcMaxAmtCucy() {
        return dcMaxAmtCucy;
    }
    
    public void setDcMaxAmtCucy(String dcMaxAmtCucy) {
        this.dcMaxAmtCucy = dcMaxAmtCucy;
    }
    
    public String getDupIssuePsblCnt() {
        return dupIssuePsblCnt;
    }
    
    public void setDupIssuePsblCnt(String dupIssuePsblCnt) {
        this.dupIssuePsblCnt = dupIssuePsblCnt;
    }
    
    public String getUsePsblCnt() {
        return usePsblCnt;
    }
    
    public void setUsePsblCnt(String usePsblCnt) {
        this.usePsblCnt = usePsblCnt;
    }
    
    public String getDt1UsePsblCnt() {
        return dt1UsePsblCnt;
    }
    
    public void setDt1UsePsblCnt(String dt1UsePsblCnt) {
        this.dt1UsePsblCnt = dt1UsePsblCnt;
    }
    
    public String getFlag() {
        return flag;
    }
    
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    public String getModNum() {
        return modNum;
    }
    
    public void setModNum(String modNum) {
        this.modNum = modNum;
    }
    
    public String getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    
    public String getCreateBy() {
        return createBy;
    }
    
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
    
    public String getModifyDate() {
        return modifyDate;
    }
    
    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }
    
    public String getModifyBy() {
        return modifyBy;
    }
    
    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
}
