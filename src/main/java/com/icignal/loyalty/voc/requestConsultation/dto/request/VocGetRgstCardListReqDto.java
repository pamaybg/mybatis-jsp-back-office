package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;




/**
 * @name : infavor.voc.requestConsultation.dto.request.VOCGetRgstCardListRequestDTO
 * @date : 2018. 1. 27.
 * @author : jun.lee
 * @description : 포인트카드 목록 조회
 */
public class VocGetRgstCardListReqDto extends CommonDataAuthReqDto {
	
	private String ridMbr;
	private String mbrRidFlag;
	private String cipherKey;
	
	
	public VocGetRgstCardListReqDto(){
		/*try {
			this.setCipherKey(CryptoManager.getCipherKey());
		} catch (Exception e) {
			LogUtility.error(e);
		}*/
	}
	
	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


	public String getMbrRidFlag() {
		return mbrRidFlag;
	}


	public void setMbrRidFlag(String mbrRidFlag) {
		this.mbrRidFlag = mbrRidFlag;
	}
}

	
