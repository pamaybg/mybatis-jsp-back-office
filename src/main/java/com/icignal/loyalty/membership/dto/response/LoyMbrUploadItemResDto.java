package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
* @name : infavor.Loyalty.batchRgst.dto.response.LoyPntBatchRgstItemResponseDTO
* @date : 2018. 11. 5.
* @author : hy.jun
* @description :
*/
@SuppressWarnings("serial")
@CommCode
@PersonalData
public class LoyMbrUploadItemResDto extends GridPagingItemResDto {
	private String rid;
	private String ridMbrUpload;
	private String mbrNo;
	private String targetNm;
	@Decrypted(masked = "tel")
	private String targetHhpNo;
	private String acrlAmt;
	private String validStartDate;
	private String validEndDate;
	private String batchResultCd;
	@MarkName(groupCode="PNT_UPLOAD_ITEM_BATCH_STATUS_CD", codeField="batchResultCd")
	private String batchResultCdNm;
	private String batchErrorDesc;
	private String ridMbr;

	private String camNm;

	private String pntAccntBigCd;
	@MarkName(groupCode="PNT_TXN_TYPE", codeField="pntAccntBigCd")
    private String pntAccntBigTypeCd; //대분류
    private String pntAccntMidCd;
    @MarkName(groupCode="PNT_TXN_DTL_TYPE", codeField="pntAccntMidCd")
    private String pntAccntMidTypeCd; //중분류
    private String pntAccntSmlCd;
    @MarkName(groupCode="DA_PNT_ACCNT_SML_TYPE", codeField="pntAccntSmlCd")
    private String pntAccntSmlTypeCd; //소분류
    private String pntAccntDetailCd;
    @MarkName(groupCode="DA_PNT_ACCNT_DETAIL_TYPE", codeField="pntAccntDetailCd")
    private String pntAccntDetailTypeCd; //세분류

    @MarkName(groupCode="LOY_VALID_STARTDT_BAS_CD", codeField="validStartdtBasTypeCd")
    private String validStartdtBasCdNm; //기준일자유형
    private String validStartdtBasTypeCd;
    private String validStartDtnum; //혜택시작일
    private String validEndDtnum; //소멸예정월
    private String dividorChnlNm; //재원부서명
    private String pntAccntCodeVal; //회계코드

	private String mbrNoChk;
	private String custNmChk;
	private String mbrStatCdChk;
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCdChk")
	private String mbrStatCdNmChk;

	private String acrlDate; //적립일시
	private String seq; //순서
	private String ci;

	
	public String getValidStartdtBasTypeCd() {
		return validStartdtBasTypeCd;
	}
	public void setValidStartdtBasTypeCd(String validStartdtBasTypeCd) {
		this.validStartdtBasTypeCd = validStartdtBasTypeCd;
	}
	public String getPntAccntBigCd() {
		return pntAccntBigCd;
	}
	public void setPntAccntBigCd(String pntAccntBigCd) {
		this.pntAccntBigCd = pntAccntBigCd;
	}
	public String getPntAccntMidCd() {
		return pntAccntMidCd;
	}
	public void setPntAccntMidCd(String pntAccntMidCd) {
		this.pntAccntMidCd = pntAccntMidCd;
	}
	public String getPntAccntSmlCd() {
		return pntAccntSmlCd;
	}
	public void setPntAccntSmlCd(String pntAccntSmlCd) {
		this.pntAccntSmlCd = pntAccntSmlCd;
	}
	public String getPntAccntDetailCd() {
		return pntAccntDetailCd;
	}
	public void setPntAccntDetailCd(String pntAccntDetailCd) {
		this.pntAccntDetailCd = pntAccntDetailCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidMbrUpload() {
		return ridMbrUpload;
	}
	public void setRidMbrUpload(String ridMbrUpload) {
		this.ridMbrUpload = ridMbrUpload;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getTargetNm() {
		return targetNm;
	}
	public void setTargetNm(String targetNm) {
		this.targetNm = targetNm;
	}
	public String getTargetHhpNo() {
		return targetHhpNo;
	}
	public void setTargetHhpNo(String targetHhpNo) {
		this.targetHhpNo = targetHhpNo;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getBatchResultCd() {
		return batchResultCd;
	}
	public void setBatchResultCd(String batchResultCd) {
		this.batchResultCd = batchResultCd;
	}
	public String getBatchResultCdNm() {
		return batchResultCdNm;
	}
	public void setBatchResultCdNm(String batchResultCdNm) {
		this.batchResultCdNm = batchResultCdNm;
	}
	public String getBatchErrorDesc() {
		return batchErrorDesc;
	}
	public void setBatchErrorDesc(String batchErrorDesc) {
		this.batchErrorDesc = batchErrorDesc;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrNoChk() {
		return mbrNoChk;
	}
	public void setMbrNoChk(String mbrNoChk) {
		this.mbrNoChk = mbrNoChk;
	}
	public String getCustNmChk() {
		return custNmChk;
	}
	public void setCustNmChk(String custNmChk) {
		this.custNmChk = custNmChk;
	}
	public String getMbrStatCdChk() {
		return mbrStatCdChk;
	}
	public void setMbrStatCdChk(String mbrStatCdChk) {
		this.mbrStatCdChk = mbrStatCdChk;
	}
	public String getMbrStatCdNmChk() {
		return mbrStatCdNmChk;
	}
	public void setMbrStatCdNmChk(String mbrStatCdNmChk) {
		this.mbrStatCdNmChk = mbrStatCdNmChk;
	}
	public String getPntAccntBigTypeCd() {
		return pntAccntBigTypeCd;
	}
	public void setPntAccntBigTypeCd(String pntAccntBigTypeCd) {
		this.pntAccntBigTypeCd = pntAccntBigTypeCd;
	}
	public String getPntAccntMidTypeCd() {
		return pntAccntMidTypeCd;
	}
	public void setPntAccntMidTypeCd(String pntAccntMidTypeCd) {
		this.pntAccntMidTypeCd = pntAccntMidTypeCd;
	}
	public String getPntAccntSmlTypeCd() {
		return pntAccntSmlTypeCd;
	}
	public void setPntAccntSmlTypeCd(String pntAccntSmlTypeCd) {
		this.pntAccntSmlTypeCd = pntAccntSmlTypeCd;
	}
	public String getPntAccntDetailTypeCd() {
		return pntAccntDetailTypeCd;
	}
	public void setPntAccntDetailTypeCd(String pntAccntDetailTypeCd) {
		this.pntAccntDetailTypeCd = pntAccntDetailTypeCd;
	}
	public String getValidStartdtBasCdNm() {
		return validStartdtBasCdNm;
	}
	public void setValidStartdtBasCdNm(String validStartdtBasCdNm) {
		this.validStartdtBasCdNm = validStartdtBasCdNm;
	}
	public String getValidStartDtnum() {
		return validStartDtnum;
	}
	public void setValidStartDtnum(String validStartDtnum) {
		this.validStartDtnum = validStartDtnum;
	}
	public String getValidEndDtnum() {
		return validEndDtnum;
	}
	public void setValidEndDtnum(String validEndDtnum) {
		this.validEndDtnum = validEndDtnum;
	}
	public String getDividorChnlNm() {
		return dividorChnlNm;
	}
	public void setDividorChnlNm(String dividorChnlNm) {
		this.dividorChnlNm = dividorChnlNm;
	}
	public String getPntAccntCodeVal() {
		return pntAccntCodeVal;
	}
	public void setPntAccntCodeVal(String pntAccntCodeVal) {
		this.pntAccntCodeVal = pntAccntCodeVal;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getAcrlDate() {
		return acrlDate;
	}
	public void setAcrlDate(String acrlDate) {
		this.acrlDate = acrlDate;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}


}
