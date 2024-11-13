package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.util.ObjectUtil;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : 캠페인 활동값 목록
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktETCampaignActValReqDto extends MKTBaseReqDto {
	
	private String rid;               //RID
	private String ridCamNode;        //RID_CAM_NODE
	private String logicOper;         //
	private String compValType;       //
	private String compVal;           //
	private String compOper;          //
	private String ridMktOfferMst;    //RID_오퍼마스터
	private String acrlType;          //적립 유형
	private String bnftLcBas;         //혜택 LC 기준
	private String bnftAcrlAmt;       //혜택 적립 금액
	private String sndChnlCd;         //전송 채널 코드
	private String tgtTblInputYn;     //타겟 테이블 입력 여부
	private String ifCallYn;          //IF 호출 여부
	
	private String offerNm;			   //오퍼명
	private String offerTypeCd;		   //오퍼유형코드
	private String offerTypeCdNm;	   //오퍼유형명
	
	private String lgclCmpntId;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCamNode() {
		return ridCamNode;
	}

	public void setRidCamNode(String ridCamNode) {
		this.ridCamNode = ridCamNode;
	}

	public String getLogicOper() {
		return logicOper;
	}

	public void setLogicOper(String logicOper) {
		this.logicOper = logicOper;
	}

	public String getCompValType() {
		return compValType;
	}

	public void setCompValType(String compValType) {
		this.compValType = compValType;
	}

	public String getCompVal() {
		return compVal;
	}

	public void setCompVal(String compVal) {
		this.compVal = compVal;
	}

	public String getCompOper() {
		return compOper;
	}

	public void setCompOper(String compOper) {
		this.compOper = compOper;
	}

	public String getRidMktOfferMst() {
		return ridMktOfferMst;
	}

	public void setRidMktOfferMst(String ridMktOfferMst) {
		this.ridMktOfferMst = ridMktOfferMst;
	}

	public String getAcrlType() {
		return acrlType;
	}

	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}

	public String getBnftLcBas() {
		return bnftLcBas;
	}

	public void setBnftLcBas(String bnftLcBas) {
		this.bnftLcBas = bnftLcBas;
	}

	public String getBnftAcrlAmt() {
		return bnftAcrlAmt;
	}

	public void setBnftAcrlAmt(String bnftAcrlAmt) {
		
		this.bnftAcrlAmt = ObjectUtil.isNotEmpty(bnftAcrlAmt) ? bnftAcrlAmt : null;
	}

	public String getSndChnlCd() {
		return sndChnlCd;
	}

	public void setSndChnlCd(String sndChnlCd) {
		this.sndChnlCd = sndChnlCd;
	}

	public String getTgtTblInputYn() {
		return tgtTblInputYn;
	}

	public void setTgtTblInputYn(String tgtTblInputYn) {
		this.tgtTblInputYn = tgtTblInputYn;
	}

	public String getIfCallYn() {
		return ifCallYn;
	}

	public void setIfCallYn(String ifCallYn) {
		this.ifCallYn = ifCallYn;
	}

	public String getOfferNm() {
		return offerNm;
	}

	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}

	public String getOfferTypeCd() {
		return offerTypeCd;
	}

	public void setOfferTypeCd(String offerTypeCd) {
		this.offerTypeCd = offerTypeCd;
	}

	public String getOfferTypeCdNm() {
		return offerTypeCdNm;
	}

	public void setOfferTypeCdNm(String offerTypeCdNm) {
		this.offerTypeCdNm = offerTypeCdNm;
	}

	public String getLgclCmpntId() {
		return lgclCmpntId;
	}

	public void setLgclCmpntId(String lgclCmpntId) {
		this.lgclCmpntId = lgclCmpntId;
	}
}
