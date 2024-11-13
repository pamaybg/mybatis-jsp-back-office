package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpStoreListResponseDTO
* @date : 2019. 3. 6.
* @author : hy.jun
* @description :
*/
public class LoyStmpStoreListResDto extends GridPagingItemResDto {

	private static final long serialVersionUID = 7346669806608963749L;

	private String rid;
	private String chnlNo;
	private String chnlTypeCdNm;
	private String chnlNm;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
}
