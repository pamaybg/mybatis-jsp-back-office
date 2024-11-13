/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrChnlRelListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 13. 오후 3:50:45
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrChnlRelListResDto
 * 2. 파일명	: LoyMbrChnlRelListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrChnlRelListResDto extends GridPagingItemResDto {
	private String rid;
	private String chnlNm;
	private String chnlRelTypeCd;
	@MarkName(groupCode="LOY_CHNL_REL_TYPE_CD", codeField="chnlRelTypeCd")
	private String chnlRelTypeNm;
	private String createDate;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlRelTypeCd() {
		return chnlRelTypeCd;
	}
	public void setChnlRelTypeCd(String chnlRelTypeCd) {
		this.chnlRelTypeCd = chnlRelTypeCd;
	}
	public String getChnlRelTypeNm() {
		return chnlRelTypeNm;
	}
	public void setChnlRelTypeNm(String chnlRelTypeNm) {
		this.chnlRelTypeNm = chnlRelTypeNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	
	
}
