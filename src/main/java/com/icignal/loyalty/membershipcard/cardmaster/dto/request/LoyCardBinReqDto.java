package com.icignal.loyalty.membershipcard.cardmaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
* <pre>
* infavor.loyalty.membership.card.dto.request
*  |_ LOYsetIssuCardRequestDTO.java
* </pre>
* @작성일		: 2017. 1. 18. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
public class LoyCardBinReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String ridCardKind;
	private String startNo;
	private String endNo;
	private String validEndDt;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}

	public String getStartNo() {
		return startNo;
	}

	public void setStartNo(String startNo) {
		this.startNo = startNo;
	}

	public String getEndNo() {
		return endNo;
	}

	public void setEndNo(String endNo) {
		this.endNo = endNo;
	}

	public String getValidEndDt() {
		return validEndDt;
	}

	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}
}