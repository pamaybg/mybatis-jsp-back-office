/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpItemListResDto.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 9:14:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyChnlGrpItemListResDto
 * 2. 파일명	: LoyChnlGrpItemListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlGrpItemListResDto extends GridPagingItemResDto{
	private String chnlNo;
	private String chnlNm;
	private String createDate;
	private String name;
	private String rid;
	private String lvlCd;
	
	
	public String getLvlCd() {
		return lvlCd;
	}
	public void setLvlCd(String lvlCd) {
		this.lvlCd = lvlCd;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
