/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
  * @fileName : LoyMbrChnlRelRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 6.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원  채널관계 요청 DTO
  */
public class LoyMbrChnlRelReqDto  extends CommonDataAuthReqDto {

	/** rid Mbr */
	private String ridMbr;

	/** 마스크해제 */
	private String clearMask;

	private String cipherKey;

	public LoyMbrChnlRelReqDto(){
	/*	try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtil.error(e);
		}*/
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
	 * @return the clearMask
	 */
	public String getClearMask() {
		return clearMask;
	}

	/**
	 * @param clearMask the clearMask to set
	 */
	public void setClearMask(String clearMask) {
		this.clearMask = clearMask;
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
