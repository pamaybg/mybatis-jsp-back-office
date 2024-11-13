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
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrAlterHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String actionDt;
	private String confirmDt;
	private String msg;
	private String msgType;
	@MarkName(groupCode="ALT_MSG_TYPE_CD",codeField="msgType")
	private String msgTypeNm;
	private String chnlNm;
	private String showYn;
	
	private String sendDate;
	@MarkName(groupCode="LOY_MBR_ALT_TYPE_CD",codeField="altTypeCd")
	private String altTypeCd;
	@MarkName(groupCode="LOY_MBR_ALT_CHNL_TYPE_CD",codeField="sendChnlType")
	private String sendChnlType;
	private String title; 
	private String userRecvCheck;
	private String userRecvDate;

	
	
	public String getUserRecvDate() {
		return userRecvDate;
	}
	public void setUserRecvDate(String userRecvDate) {
		this.userRecvDate = userRecvDate;
	}
	public String getUserRecvCheck() {
		return userRecvCheck;
	}
	public void setUserRecvCheck(String userRecvCheck) {
		this.userRecvCheck = userRecvCheck;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getAltTypeCd() {
		return altTypeCd;
	}
	public void setAltTypeCd(String altTypeCd) {
		this.altTypeCd = altTypeCd;
	}
	public String getSendChnlType() {
		return sendChnlType;
	}
	public void setSendChnlType(String sendChnlType) {
		this.sendChnlType = sendChnlType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
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
	public String getMsgTypeNm() {
		return msgTypeNm;
	}
	public void setMsgTypeNm(String msgTypeNm) {
		this.msgTypeNm = msgTypeNm;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getShowYn() {
		return showYn;
	}
	public void setShowYn(String showYn) {
		this.showYn = showYn;
	}
	
	

}
