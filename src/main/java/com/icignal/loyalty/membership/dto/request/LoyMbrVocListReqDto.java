/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrVocRequestDTO
* @date : 2017. 10. 20.
* @author : 이성원
* @description :
*/
public class LoyMbrVocListReqDto  extends CommonDataAuthReqDto {


	private String rid;
	private String mbrRid;
	private String srNo;
	private String rcp_dt;
	private String srTrtStatus;
	private String memNo;
	private String memNm;
	private String cnctDesk;
	private String memPtblNo;
	private String cnslgTypeCdL;
	private String cnslgTypeCdM;
	private String cnslgTypeCdS;
	private String cnslgTitle;
	private String cnslgSbst;
	private String cipherKey;
	private String ridCust;
	private String mbrStatCd;


	
    public String getMbrStatCd() {
		return mbrStatCd;
	}


	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}


	public LoyMbrVocListReqDto() {
       /* try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }


	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getRcp_dt() {
		return rcp_dt;
	}
	public void setRcp_dt(String rcp_dt) {
		this.rcp_dt = rcp_dt;
	}
	public String getSrTrtStatus() {
		return srTrtStatus;
	}
	public void setSrTrtStatus(String srTrtStatus) {
		this.srTrtStatus = srTrtStatus;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getCnctDesk() {
		return cnctDesk;
	}
	public void setCnctDesk(String cnctDesk) {
		this.cnctDesk = cnctDesk;
	}
	public String getMemPtblNo() {
		return memPtblNo;
	}
	public void setMemPtblNo(String memPtblNo) {
		this.memPtblNo = memPtblNo;
	}
	public String getCnslgTypeCdL() {
		return cnslgTypeCdL;
	}
	public void setCnslgTypeCdL(String cnslgTypeCdL) {
		this.cnslgTypeCdL = cnslgTypeCdL;
	}
	public String getCnslgTypeCdM() {
		return cnslgTypeCdM;
	}
	public void setCnslgTypeCdM(String cnslgTypeCdM) {
		this.cnslgTypeCdM = cnslgTypeCdM;
	}
	public String getCnslgTypeCdS() {
		return cnslgTypeCdS;
	}
	public void setCnslgTypeCdS(String cnslgTypeCdS) {
		this.cnslgTypeCdS = cnslgTypeCdS;
	}
	public String getCnslgTitle() {
		return cnslgTitle;
	}
	public void setCnslgTitle(String cnslgTitle) {
		this.cnslgTitle = cnslgTitle;
	}
	public String getCnslgSbst() {
		return cnslgSbst;
	}
	public void setCnslgSbst(String cnslgSbst) {
		this.cnslgSbst = cnslgSbst;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


	public String getMbrRid() {
		return mbrRid;
	}


	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}


	/**
	* @return the ridCust
	*/
	public String getRidCust() {
		return ridCust;
	}


	/**
	* @param ridCust the ridCust to set
	*/
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}






}
