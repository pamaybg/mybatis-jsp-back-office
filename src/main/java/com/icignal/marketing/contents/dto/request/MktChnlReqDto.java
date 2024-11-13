package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktChnlReqDto extends CommonDataAuthReqDto {
	private String chnltype;
	private String accntId;
	
	public String getChnltype() {
		return chnltype;
	}

	public void setChnltype(String chnltype) {
		this.chnltype = chnltype;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
	
}
