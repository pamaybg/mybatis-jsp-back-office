package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignPromotionExeInfoReqDto extends MKTBaseReqDto {
	
	private String id;               //아이디
	private String type;             //유형
	private String camId;            //캠페인아이디
	private String ridRuleset;       //RID룰셋
	private String promNo;           //프로모션번호
	private String promStatusCd;	 //프로모션상태코드(1:신규 2:변경 3:중지)
	private String promStartDt;      //프로모션시작일시
	private String promEndDt;        //프로모션종료일시
	private String exeSeq;           //실행순서
	private String exeDt;            //실행일시
	private String exeInfoStatusCd;      //실행상태코드
	private String tgtSendTypeCd;	 //대상전송주기(O: 1회, D: 매일)
	private String tgtExtrtYn;       //대상자추출여부
	private String tgtExtrtDt;       //대상자추출일시
	private String txnTranYn;        //승인전송여부
	private String txnTranDt;        //승인전송일시
	private String promCyclTypeCd;	 //프로모션반복주기
    
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getRidRuleset() {
		return ridRuleset;
	}

	public void setRidRuleset(String ridRuleset) {
		this.ridRuleset = ridRuleset;
	}

	public String getPromNo() {
		return promNo;
	}

	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}

	public String getPromStartDt() {
		return promStartDt;
	}

	public void setPromStartDt(String promStartDt) {
		this.promStartDt = promStartDt;
	}

	public String getPromEndDt() {
		return promEndDt;
	}

	public void setPromEndDt(String promEndDt) {
		this.promEndDt = promEndDt;
	}

	public String getExeSeq() {
		return exeSeq;
	}

	public void setExeSeq(String exeSeq) {
		this.exeSeq = exeSeq;
	}

	public String getExeDt() {
		return exeDt;
	}

	public void setExeDt(String exeDt) {
		this.exeDt = exeDt;
	}

	public String getTgtExtrtYn() {
		return tgtExtrtYn;
	}

	public void setTgtExtrtYn(String tgtExtrtYn) {
		this.tgtExtrtYn = tgtExtrtYn;
	}

	public String getTgtExtrtDt() {
		return tgtExtrtDt;
	}

	public void setTgtExtrtDt(String tgtExtrtDt) {
		this.tgtExtrtDt = tgtExtrtDt;
	}

	public String getTxnTranYn() {
		return txnTranYn;
	}

	public void setTxnTranYn(String txnTranYn) {
		this.txnTranYn = txnTranYn;
	}

	public String getTxnTranDt() {
		return txnTranDt;
	}

	public void setTxnTranDt(String txnTranDt) {
		this.txnTranDt = txnTranDt;
	}

	public String getTgtSendTypeCd() {
		return tgtSendTypeCd;
	}

	public void setTgtSendTypeCd(String tgtSendTypeCd) {
		this.tgtSendTypeCd = tgtSendTypeCd;
	}

	public String getPromCyclTypeCd() {
		return promCyclTypeCd;
	}

	public void setPromCyclTypeCd(String promCyclTypeCd) {
		this.promCyclTypeCd = promCyclTypeCd;
	}

	public String getExeInfoStatusCd() {
		return exeInfoStatusCd;
	}

	public void setExeInfoStatusCd(String exeInfoStatusCd) {
		this.exeInfoStatusCd = exeInfoStatusCd;
	}

	public String getPromStatusCd() {
		return promStatusCd;
	}

	public void setPromStatusCd(String promStatusCd) {
		this.promStatusCd = promStatusCd;
	}

}