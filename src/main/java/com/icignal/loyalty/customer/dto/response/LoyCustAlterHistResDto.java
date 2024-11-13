/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustAlterHistResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 11. 오전 10:38:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustAlterHistResDto
 * 2. 파일명	: LoyCustAlterHistResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustAlterHistResDto extends GridPagingItemResDto {
	private String rid;
	private String actionDt;
	private String confirmDt;
	private String msg;
	private String msgType;
	@MarkName(groupCode="ALT_MSG_TYPE_CD",codeField="msgType")
	private String msgTypeNm;
	private String chnlNm;
	private String showYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getActionDt() {
		return actionDt;
	}
	public void setActionDt(String actionDt) {
		this.actionDt = actionDt;
	}
	public String getConfirmDt() {
		return confirmDt;
	}
	public void setConfirmDt(String confirmDt) {
		this.confirmDt = confirmDt;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getMsgTypeNm() {
		return msgTypeNm;
	}
	public void setMsgTypeNm(String msgTypeNm) {
		this.msgTypeNm = msgTypeNm;
	}
	public String getShowYn() {
		return showYn;
	}
	public void setShowYn(String showYn) {
		this.showYn = showYn;
	}
	

}
