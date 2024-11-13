package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyMbrGroupAddInfoReqDto extends CommonDataAuthReqDto {

	private String chnlNm                   ;
	private String mbrbsCdadd               ;
	private String zipCd                    ;
	private String adrDtl                   ;
	private String email                    ;
	private String ouTypeCd            		;
	//private String ouTypeCdMarkName    		;
	private String parRid                   ;
	private String parChnlNo                ;
	private String parChnlNm                ;
	private String reprNm                   ;
	private String bizrNo                   ;
	private String faxNo                    ;
	private String telNo                    ;
	private String hpNo                     ;
	private String sbscDd                   ;
	private String ridAcrlRule              ;
	private String ruleCd                   ;
	private String ruleTypeCd               ;
	private String trmnDd                   ;
	private String rmark                    ;
	private String dnatStartDay             ;
	private String dnatEndDay               ;
	private String fndDd                    ;
	private String oprtPrps                 ;
	private String fraudDiv                 ;
	//private String fraudDivMarkName         ;
	private String fraudMbrbsActnDiv        ;
	//private String fraudMbrbsActnDivMarkName;
	private String fraudMbrbsActnDesc       ;
	private String rid;
	private String chnlId;
	private String mbrStatCd;
	private String roadNmAdrZipCd;
	private String roadNmAdr;
	private String gugun;
	private String sido;
	private String cipherKey;

	public LoyMbrGroupAddInfoReqDto() {
        //try {
            //this.setCipherKey(CryptoManager.getCipherKey());
        //}
        //catch ( Exception e ) {
           // LogUtil.error(e);
        //}
    }


	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getMbrbsCdadd() {
		return mbrbsCdadd;
	}
	public void setMbrbsCdadd(String mbrbsCdadd) {
		this.mbrbsCdadd = mbrbsCdadd;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getAdrDtl() {
		return adrDtl;
	}
	public void setAdrDtl(String adrDtl) {
		this.adrDtl = adrDtl;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOuTypeCd() {
		return ouTypeCd;
	}
	public void setOuTypeCd(String ouTypeCd) {
		this.ouTypeCd = ouTypeCd;
	}
//	public String getOuTypeCdMarkName() {
//		return ouTypeCdMarkName;
//	}
//	public void setOuTypeCdMarkName(String ouTypeCdMarkName) {
//		this.ouTypeCdMarkName = ouTypeCdMarkName;
//	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getParChnlNo() {
		return parChnlNo;
	}
	public void setParChnlNo(String parChnlNo) {
		this.parChnlNo = parChnlNo;
	}
	public String getParChnlNm() {
		return parChnlNm;
	}
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	public String getReprNm() {
		return reprNm;
	}
	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getFaxNo() {
		return faxNo;
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getSbscDd() {
		return sbscDd;
	}
	public void setSbscDd(String sbscDd) {
		this.sbscDd = sbscDd;
	}
	public String getRidAcrlRule() {
		return ridAcrlRule;
	}
	public void setRidAcrlRule(String ridAcrlRule) {
		this.ridAcrlRule = ridAcrlRule;
	}
	public String getRuleCd() {
		return ruleCd;
	}
	public void setRuleCd(String ruleCd) {
		this.ruleCd = ruleCd;
	}
	public String getRuleTypeCd() {
		return ruleTypeCd;
	}
	public void setRuleTypeCd(String ruleTypeCd) {
		this.ruleTypeCd = ruleTypeCd;
	}
	public String getTrmnDd() {
		return trmnDd;
	}
	public void setTrmnDd(String trmnDd) {
		this.trmnDd = trmnDd;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	public String getDnatStartDay() {
		return dnatStartDay;
	}
	public void setDnatStartDay(String dnatStartDay) {
		this.dnatStartDay = dnatStartDay;
	}
	public String getDnatEndDay() {
		return dnatEndDay;
	}
	public void setDnatEndDay(String dnatEndDay) {
		this.dnatEndDay = dnatEndDay;
	}
	public String getFndDd() {
		return fndDd;
	}
	public void setFndDd(String fndDd) {
		this.fndDd = fndDd;
	}
	public String getOprtPrps() {
		return oprtPrps;
	}
	public void setOprtPrps(String oprtPrps) {
		this.oprtPrps = oprtPrps;
	}
	public String getFraudDiv() {
		return fraudDiv;
	}
	public void setFraudDiv(String fraudDiv) {
		this.fraudDiv = fraudDiv;
	}
//	public String getFraudDivMarkName() {
//		return fraudDivMarkName;
//	}
//	public void setFraudDivMarkName(String fraudDivMarkName) {
//		this.fraudDivMarkName = fraudDivMarkName;
//	}
	public String getFraudMbrbsActnDiv() {
		return fraudMbrbsActnDiv;
	}
	public void setFraudMbrbsActnDiv(String fraudMbrbsActnDiv) {
		this.fraudMbrbsActnDiv = fraudMbrbsActnDiv;
	}
//	public String getFraudMbrbsActnDivMarkName() {
//		return fraudMbrbsActnDivMarkName;
//	}
//	public void setFraudMbrbsActnDivMarkName(String fraudMbrbsActnDivMarkName) {
//		this.fraudMbrbsActnDivMarkName = fraudMbrbsActnDivMarkName;
//	}
	public String getFraudMbrbsActnDesc() {
		return fraudMbrbsActnDesc;
	}
	public void setFraudMbrbsActnDesc(String fraudMbrbsActnDesc) {
		this.fraudMbrbsActnDesc = fraudMbrbsActnDesc;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getRoadNmAdrZipCd() {
		return roadNmAdrZipCd;
	}
	public void setRoadNmAdrZipCd(String roadNmAdrZipCd) {
		this.roadNmAdrZipCd = roadNmAdrZipCd;
	}
	public String getRoadNmAdr() {
		return roadNmAdr;
	}
	public void setRoadNmAdr(String roadNmAdr) {
		this.roadNmAdr = roadNmAdr;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	/**
	* @return the cipherKey
	*/
	public String getCipherKey() {
		return cipherKey;
	}
	/**
	* @param cipherKey the cipherKey to set
	*/
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}



}
