package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
public class LoyMbrTmAgrHistReqDto extends CommonDataAuthReqDto {

	private String cprtType;
	private String cprtCmpnDiv;
	private String tmAgreeYn;
	private String tmAgreeRcpChnl;
	private String tmAgreeDd;
	private String ridCam;
	@Encrypted
	private String memCntcDesk;
	private String chnlNo;
	private String cprtCmpnTrmDt;
	private String rmark;
	private String ridMbr;
	private String rid;
	private String cipherKey;

	public LoyMbrTmAgrHistReqDto() {
        /*try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }

	public String getCprtType() {
		return cprtType;
	}
	public void setCprtType(String cprtType) {
		this.cprtType = cprtType;
	}
	public String getCprtCmpnDiv() {
		return cprtCmpnDiv;
	}
	public void setCprtCmpnDiv(String cprtCmpnDiv) {
		this.cprtCmpnDiv = cprtCmpnDiv;
	}
	public String getTmAgreeYn() {
		return tmAgreeYn;
	}
	public void setTmAgreeYn(String tmAgreeYn) {
		this.tmAgreeYn = tmAgreeYn;
	}
	public String getTmAgreeRcpChnl() {
		return tmAgreeRcpChnl;
	}
	public void setTmAgreeRcpChnl(String tmAgreeRcpChnl) {
		this.tmAgreeRcpChnl = tmAgreeRcpChnl;
	}
	public String getTmAgreeDd() {
		return tmAgreeDd;
	}
	public void setTmAgreeDd(String tmAgreeDd) {
		this.tmAgreeDd = tmAgreeDd;
	}
	public String getRidCam() {
		return ridCam;
	}
	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}
	public String getMemCntcDesk() {
		return memCntcDesk;
	}
	public void setMemCntcDesk(String memCntcDesk) {
		this.memCntcDesk = memCntcDesk;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getCprtCmpnTrmDt() {
		return cprtCmpnTrmDt;
	}
	public void setCprtCmpnTrmDt(String cprtCmpnTrmDt) {
		this.cprtCmpnTrmDt = cprtCmpnTrmDt;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	/**
	* @return the ridMbr
	*/
	public String getRidMbr() {
		return ridMbr;
	}
	/**
	* @param ridMbr the ridMbr to set
	*/
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	/**
	* @return the rid
	*/
	public String getRid() {
		return rid;
	}
	/**
	* @param rid the rid to set
	*/
	public void setRid(String rid) {
		this.rid = rid;
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
