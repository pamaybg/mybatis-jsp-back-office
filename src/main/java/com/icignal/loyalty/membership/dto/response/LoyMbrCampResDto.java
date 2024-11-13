/**
 * 회원 캠페인이력 응답 DTO
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;





/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrCampResResponseDTO
* @date : 2018. 2. 2.
* @author : 이성원
* @description :
*/
public class LoyMbrCampResDto  extends GridPagingItemResDto {
	public String camNm;
	public String camType;
	public String startDt;
	public String endDt;
	public String chnlType;
	public String recStatus;
	public String emailOpenYn;
	public String respDt;
	public String failDesc;
	public String chnlNm;
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamType() {
		return camType;
	}
	public void setCamType(String camType) {
		this.camType = camType;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getRecStatus() {
		return recStatus;
	}
	public void setRecStatus(String recStatus) {
		this.recStatus = recStatus;
	}
	public String getEmailOpenYn() {
		return emailOpenYn;
	}
	public void setEmailOpenYn(String emailOpenYn) {
		this.emailOpenYn = emailOpenYn;
	}
	public String getRespDt() {
		return respDt;
	}
	public void setRespDt(String respDt) {
		this.respDt = respDt;
	}
	public String getFailDesc() {
		return failDesc;
	}
	public void setFailDesc(String failDesc) {
		this.failDesc = failDesc;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}


	



}
