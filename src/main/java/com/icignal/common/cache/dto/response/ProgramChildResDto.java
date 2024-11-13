/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: ProgramChildResDto.java
 * 2. Package	: com.icignal.common.cache.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 18. 오전 9:39:02
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 18.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.cache.dto.response;

import java.io.Serializable;

/*
 * 1. 클래스명	: ProgramChildResDto
 * 2. 파일명	: ProgramChildResDto.java
 * 3. 패키지명	: com.icignal.common.cache.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class ProgramChildResDto implements Serializable{

	private static final long serialVersionUID = 7077013092586721807L;
	
	private String pgmRid;
	private String url;
	private String parPgmRid;
	private String tabLabelNm;
	private String tabSeq;
	
	
	public String getTabSeq() {
		return tabSeq;
	}
	public void setTabSeq(String tabSeq) {
		this.tabSeq = tabSeq;
	}
	public String getTabLabelNm() {
		return tabLabelNm;
	}
	public void setTabLabelNm(String tabLabelNm) {
		this.tabLabelNm = tabLabelNm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getParPgmRid() {
		return parPgmRid;
	}
	public void setParPgmRid(String parPgmRid) {
		this.parPgmRid = parPgmRid;
	}	
	
	
}
