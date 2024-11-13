package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @fileName : LOYTicketHistListResponseDTO.java
 * @project : 
 * @date : 2019. 9. 4.
 * @author : jh.seo
 * @descripton : 티켓 발행이력 조회 요청 DTO
 */

public class LoyAttendanceReqDto extends CommonDataAuthReqDto {
	private String pstMbrRid;					//회원RID
	private String cipherKey;
	private String rid;
	//getter, setter
	
	public String getPstMbrRid() {
		return pstMbrRid;
	}
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public void setPstMbrRid(String pstMbrRid) {
		this.pstMbrRid = pstMbrRid;
	}
	
	/*public LoyAttendanceReqDto() {
        try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }
    }*/

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	
}
