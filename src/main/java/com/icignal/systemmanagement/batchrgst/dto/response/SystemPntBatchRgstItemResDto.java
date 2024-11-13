package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYPntBatchRgstItemResponseDTO
* @date : 2018. 11. 5.
* @author : hy.jun
* @description :
*/
@CommCode
@PersonalData
public class SystemPntBatchRgstItemResDto extends GridPagingItemResDto {
	private String rid;
	private String ridPntUpload;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String targetNm;
	@Decrypted(masked = "tel")
	private String targetHhpNo;
	@Decrypted(masked = "webId")
	private String webId;
	private String acrlAmt;
	private String validStartDate;
	private String validEndDate;
	
	@MarkName(groupCode = "PNT_UPLOAD_ITEM_BATCH_STATUS_CD", codeField = "batchResultCd")
	private String batchResultCdNm;
	private String batchResultCd;
	private String batchErrorDesc;
	private String ridMbr;

	private String camNm;
	
	@MarkName(groupCode = "PNT_TXN_TYPE'", codeField = "pntAccntBigTypeCdNm")
    private String pntAccntBigTypeCd; //대분류
	private String pntAccntBigTypeCdNm; 
	@MarkName(groupCode = "'PNT_TXN_DTL_TYPE", codeField = "pntAccntMidTypeCdNm")
    private String pntAccntMidTypeCd; //중분류
	private String pntAccntMidTypeCdNm;
	@MarkName(groupCode = "'DA_PNT_ACCNT_SML_TYPE", codeField = "pntAccntSmlTypeCdNm")
    private String pntAccntSmlTypeCd; //소분류
	private String pntAccntSmlTypeCdNm;
	@MarkName(groupCode = "DA_PNT_ACCNT_DETAIL_TYPE'", codeField = "pntAccntDetailTypeCdNm")
	private String pntAccntDetailTypeCd; //세분류
	private String pntAccntDetailTypeCdNm;
    @MarkName(groupCode = "LOY_VALID_STARTDT_BAS_CD'", codeField = "validStartdtBas")
    private String validStartdtBas;
    private String validStartdtBasCdNm; //기준일자유형
  
    private String validStartDtnum; //혜택시작일
    private String validEndDtnum; //소멸예정월
    private String dividorChnlNm; //재원부서명
    private String pntAccntCodeVal; //회계코드
    private String promRid;
	private String mbrNoChk;
	@Decrypted(masked = "custNm")
	private String custNmChk;
	
	@MarkName(groupCode = "LOY_MBR_STAT_CD", codeField = "mbrStatCdChk")
	private String mbrStatCdNmChk;
	private String mbrStatCdChk;
	private String acrlDate; //적립일시
	private String seq; //순서
	private String ci;
	
	private String progNm;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
	@MarkName(groupCode = "PROM_TYPE_LV1", codeField = "promTypeLv1Cd")
	private String promTypeLv1CdNm;
	@MarkName(groupCode = "PROM_TYPE_LV2", codeField = "promTypeLv2Cd")
	private String promTypeLv2CdNm;
	private String promNm;
	private String ofrRid;
	private String ofrNm;
	private String ofrNo;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	@Decrypted(masked = "none")
	private String unMaskWebId;
	
	
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getUnMaskWebId() {
		return unMaskWebId;
	}
	public void setUnMaskWebId(String unMaskWebId) {
		this.unMaskWebId = unMaskWebId;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getPromTypeLv1Cd() {
		return promTypeLv1Cd;
	}
	public void setPromTypeLv1Cd(String promTypeLv1Cd) {
		this.promTypeLv1Cd = promTypeLv1Cd;
	}
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getPromTypeLv1CdNm() {
		return promTypeLv1CdNm;
	}
	public void setPromTypeLv1CdNm(String promTypeLv1CdNm) {
		this.promTypeLv1CdNm = promTypeLv1CdNm;
	}
	
	public String getPromTypeLv2CdNm() {
		return promTypeLv2CdNm;
	}
	public void setPromTypeLv2CdNm(String promTypeLv2CdNm) {
		this.promTypeLv2CdNm = promTypeLv2CdNm;
	}
	public String getProgNm() {
		return progNm;
	}
	public void setProgNm(String progNm) {
		this.progNm = progNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPntUpload() {
		return ridPntUpload;
	}
	public void setRidPntUpload(String ridPntUpload) {
		this.ridPntUpload = ridPntUpload;
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
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getPntAccntBigTypeCdNm() {
		return pntAccntBigTypeCdNm;
	}
	public void setPntAccntBigTypeCdNm(String pntAccntBigTypeCdNm) {
		this.pntAccntBigTypeCdNm = pntAccntBigTypeCdNm;
	}
	public String getPntAccntMidTypeCdNm() {
		return pntAccntMidTypeCdNm;
	}
	public void setPntAccntMidTypeCdNm(String pntAccntMidTypeCdNm) {
		this.pntAccntMidTypeCdNm = pntAccntMidTypeCdNm;
	}
	public String getPntAccntSmlTypeCdNm() {
		return pntAccntSmlTypeCdNm;
	}
	public void setPntAccntSmlTypeCdNm(String pntAccntSmlTypeCdNm) {
		this.pntAccntSmlTypeCdNm = pntAccntSmlTypeCdNm;
	}
	public String getPntAccntDetailTypeCdNm() {
		return pntAccntDetailTypeCdNm;
	}
	public void setPntAccntDetailTypeCdNm(String pntAccntDetailTypeCdNm) {
		this.pntAccntDetailTypeCdNm = pntAccntDetailTypeCdNm;
	}
	public String getValidStartdtBas() {
		return validStartdtBas;
	}
	public void setValidStartdtBas(String validStartdtBas) {
		this.validStartdtBas = validStartdtBas;
	}
	

}
