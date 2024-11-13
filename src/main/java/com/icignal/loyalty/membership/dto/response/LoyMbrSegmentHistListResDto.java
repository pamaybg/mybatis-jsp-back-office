/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrAlterHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 13. 오후 6:04:28
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
 * 1. 클래스명	: LoyMbrAlterHistListResDto
 * 2. 파일명	: LoyMbrAlterHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrSegmentHistListResDto extends GridPagingItemResDto{
	private String id;
	private String createBy;
	private String createDate;
	private String csegNm;
	private String csegId;
	private String csegStageId;
	private String csegStageNm;
	private String csegTypeCd;
	@MarkName(groupCode = "ANL_CSEG_TYPE_CD", codeField = "csegTypeCd")
	private String csegTypeNm;
	private String createByName;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCsegNm() {
		return csegNm;
	}
	public void setCsegNm(String csegNm) {
		this.csegNm = csegNm;
	}
	public String getCsegStageNm() {
		return csegStageNm;
	}
	public void setCsegStageNm(String csegStageNm) {
		this.csegStageNm = csegStageNm;
	}
	public String getCsegTypeCd() {
		return csegTypeCd;
	}
	public void setCsegTypeCd(String csegTypeCd) {
		this.csegTypeCd = csegTypeCd;
	}
	public String getCsegTypeNm() {
		return csegTypeNm;
	}
	public void setCsegTypeNm(String csegTypeNm) {
		this.csegTypeNm = csegTypeNm;
	}
	public String getCsegId() {
		return csegId;
	}
	public void setCsegId(String csegId) {
		this.csegId = csegId;
	}
	public String getCsegStageId() {
		return csegStageId;
	}
	public void setCsegStageId(String csegStageId) {
		this.csegStageId = csegStageId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}

	
	
	
	
	

}
