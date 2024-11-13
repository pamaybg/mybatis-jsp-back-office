/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlTgtGrpResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오후 4:50:26
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlTgtGrpResDto
 * 2. 파일명	: LoyChnlTgtGrpResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyChnlTgtGrpResDto extends GridPagingItemResDto{
	private String rid;
	private String chnlTgtGrpNo;
	private String chnlTgtGrpNm;
	private String statCd;
	@MarkName(groupCode="COM_STAT_TYPE_2_CD", codeField="statCd")
	private String statCdNm;
	
	
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlTgtGrpNo() {
		return chnlTgtGrpNo;
	}
	public void setChnlTgtGrpNo(String chnlTgtGrpNo) {
		this.chnlTgtGrpNo = chnlTgtGrpNo;
	}
	public String getChnlTgtGrpNm() {
		return chnlTgtGrpNm;
	}
	public void setChnlTgtGrpNm(String chnlTgtGrpNm) {
		this.chnlTgtGrpNm = chnlTgtGrpNm;
	}
	
	
}
