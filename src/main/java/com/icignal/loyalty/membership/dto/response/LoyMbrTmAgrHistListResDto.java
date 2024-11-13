package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyMbrTmAgrHistListResDto extends GridPagingItemResDto{

	private String cperTypeCd;
	@MarkName(groupCode="ALLIANCE_TYPE", codeField="cperTypeCd")
	private String cprtType;
	private String cprtCmpnDivCd;
	@MarkName(groupCode="ALLIANCE_COMPANY_TYPE", codeField="cprtCmpnDivCd")
	private String cprtCmpnDiv;
	private String tmAgreeYn;
	private String tmAgreeRcpChnlCd;
	@MarkName(groupCode="ALI_TM_AGRE_CHNL", codeField="tmAgreeRcpChnlCd")
	private String tmAgreeRcpChnl;
	private String tmAgreeDd;
	private String ridCam;
	@Decrypted(masked = "tel")
	private String memCntcDesk;
	private String chnlNo;
	private String rmark;
    private String cprtCmpnTrmDt;
    private String ridMbr;
    private String rid;

    
	public String getCperTypeCd() {
		return cperTypeCd;
	}
	public void setCperTypeCd(String cperTypeCd) {
		this.cperTypeCd = cperTypeCd;
	}
	public String getCprtCmpnDivCd() {
		return cprtCmpnDivCd;
	}
	public void setCprtCmpnDivCd(String cprtCmpnDivCd) {
		this.cprtCmpnDivCd = cprtCmpnDivCd;
	}
	public String getTmAgreeRcpChnlCd() {
		return tmAgreeRcpChnlCd;
	}
	public void setTmAgreeRcpChnlCd(String tmAgreeRcpChnlCd) {
		this.tmAgreeRcpChnlCd = tmAgreeRcpChnlCd;
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
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	public String getCprtCmpnTrmDt() {
		return cprtCmpnTrmDt;
	}
	public void setCprtCmpnTrmDt(String cprtCmpnTrmDt) {
		this.cprtCmpnTrmDt = cprtCmpnTrmDt;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}






}
