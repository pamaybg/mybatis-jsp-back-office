/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlPgmDetailResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 20. 오후 2:20:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 20.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyChnlPgmDetailResDto
 * 2. 파일명	: LoyChnlPgmDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlPgmDetailResDto extends StatusResDto{
	private String rid;
	private String chnlRid;
	private String pgmRid;
	private String useYn;
	private String pntAcrlYn;
	private String pntRdmYn;
	private String evtYn;
	private String pgmNo;
	private String pgmNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getPntAcrlYn() {
		return pntAcrlYn;
	}
	public void setPntAcrlYn(String pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}
	public String getPntRdmYn() {
		return pntRdmYn;
	}
	public void setPntRdmYn(String pntRdmYn) {
		this.pntRdmYn = pntRdmYn;
	}
	public String getEvtYn() {
		return evtYn;
	}
	public void setEvtYn(String evtYn) {
		this.evtYn = evtYn;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	
	
}
