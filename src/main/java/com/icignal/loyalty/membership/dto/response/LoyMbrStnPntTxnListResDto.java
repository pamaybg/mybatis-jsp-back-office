/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;





/**
* @name : infavor.loyalty.member.mbr.dto.response.LOYMbrStmpTxnHistListResponseDTO
* @date : 2017. 10. 23.
* @author : 이성원
* @description :
*/
public class LoyMbrStnPntTxnListResDto  extends GridPagingItemResDto {

	private String rid;
	private String ridChnl;
	private String mbrRid;
	private String chnlNm;
	private String chnlNo;
	private String usablePoints;
	private String rmark;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getUsablePoints() {
		return usablePoints;
	}
	public void setUsablePoints(String usablePoints) {
		this.usablePoints = usablePoints;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	
	
	



}
