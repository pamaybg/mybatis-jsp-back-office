package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.personaldata.PersonalData;


/**
 * @name : VocGetReplyHistoryListResDto.java
 * @date : 2021. 02. 17.
 * @author : 2sh.park
 * @description : 답변내역 목록 조회
 */

@CommCode
@PersonalData
public class VocGetReplyHistoryListResDto extends GridPagingItemResDto {

	private String rid;
	private String prodNo;
	
	/*@Decrypted(masked = "none")*/
	private String writer;
	
	private String prodNm;
	private String reContent;
	private String adminDate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getReContent() {
		return reContent;
	}
	public void setReContent(String reContent) {
		this.reContent = reContent;
	}
	public String getAdminDate() {
		return adminDate;
	}
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}

}