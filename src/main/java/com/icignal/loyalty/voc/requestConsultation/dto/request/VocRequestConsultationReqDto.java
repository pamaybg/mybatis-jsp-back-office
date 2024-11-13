package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * @name : infavor.voc.requestConsultation.dto.request.VOCRequestConsultationRequestDTO
 * @date : 2017. 10. 13.
 * @author : "dg.ryu"
 * @description : 상담요청 Request DTO
 */
public class VocRequestConsultationReqDto extends MKTGridPagingReqDto {
	
	private String rid;
	private String ridCust;
	private String memNo;
	
	private String cipherKey;
	private String ridMbr;

	
	public VocRequestConsultationReqDto(){
		/*try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtility.error(e);
		}*/
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
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


	public String getRidCust() {
		return ridCust;
	}


	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}


	public String getMemNo() {
		return memNo;
	}


	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
}