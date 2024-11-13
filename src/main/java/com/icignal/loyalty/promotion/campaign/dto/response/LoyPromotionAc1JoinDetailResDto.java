/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc1JoinDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 3. 오전 3:04:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionAc1JoinDetailResDto
 * 2. 파일명	: LoyPromotionAc1JoinDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionAc1JoinDetailResDto extends StatusResDto{
	private String rid;
	private String promRid;
	private String chnlTgtGrpRid;
	private String prulJoinChnlCd;
	private String tgtGrpNo;
	private String tgtGrpNm;
	
	
	public String getTgtGrpNo() {
		return tgtGrpNo;
	}
	public void setTgtGrpNo(String tgtGrpNo) {
		this.tgtGrpNo = tgtGrpNo;
	}
	public String getTgtGrpNm() {
		return tgtGrpNm;
	}
	public void setTgtGrpNm(String tgtGrpNm) {
		this.tgtGrpNm = tgtGrpNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getChnlTgtGrpRid() {
		return chnlTgtGrpRid;
	}
	public void setChnlTgtGrpRid(String chnlTgtGrpRid) {
		this.chnlTgtGrpRid = chnlTgtGrpRid;
	}
	public String getPrulJoinChnlCd() {
		return prulJoinChnlCd;
	}
	public void setPrulJoinChnlCd(String prulJoinChnlCd) {
		this.prulJoinChnlCd = prulJoinChnlCd;
	}
	
	
}
