package com.icignal.marketing.contents.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktChnlResDto extends GridPagingItemResDto {
	private String chnlId;

	public String getChnlId() {
		return chnlId;
	}

	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	
}
