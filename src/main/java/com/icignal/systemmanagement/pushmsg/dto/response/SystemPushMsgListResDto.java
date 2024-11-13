package com.icignal.systemmanagement.pushmsg.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemPushMsgListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String pushTitle;
	private String pushMessage;
	private String createBy;
	private String createDate;
	private String sendDate;
	@MarkName(groupCode = "LOY_PUSH_SEND_TYPE", codeField = "sendTypeCdNm")
	private String sendType;
	private String  sendTypeCdNm;
	@MarkName(groupCode = "LOY_PUSH_TARGET_MBR_TYPE", codeField = "targetMbrTypeCdNm")
	private String targetMbrType;
	private String targetMbrTypeCdNm;
	@MarkName(groupCode = "LOY_PUSH_SEND_STATUS", codeField = "pushStatusCd")
	private String pushStatus;
	private String pushStatusCd;
	private String pushLang;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPushTitle() {
		return pushTitle;
	}
	public void setPushTitle(String pushTitle) {
		this.pushTitle = pushTitle;
	}
	public String getPushMessage() {
		return pushMessage;
	}
	public void setPushMessage(String pushMessage) {
		this.pushMessage = pushMessage;
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
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	public String getTargetMbrType() {
		return targetMbrType;
	}
	public void setTargetMbrType(String targetMbrType) {
		this.targetMbrType = targetMbrType;
	}
	public String getPushStatus() {
		return pushStatus;
	}
	public void setPushStatus(String pushStatus) {
		this.pushStatus = pushStatus;
	}
	public String getPushStatusCd() {
		return pushStatusCd;
	}
	public void setPushStatusCd(String pushStatusCd) {
		this.pushStatusCd = pushStatusCd;
	}
	public String getPushLang() {
		return pushLang;
	}
	public void setPushLang(String pushLang) {
		this.pushLang = pushLang;
	}
	public String getSendTypeCdNm() {
		return sendTypeCdNm;
	}
	public void setSendTypeCdNm(String sendTypeCdNm) {
		this.sendTypeCdNm = sendTypeCdNm;
	}
	public String getTargetMbrTypeCdNm() {
		return targetMbrTypeCdNm;
	}
	public void setTargetMbrTypeCdNm(String targetMbrTypeCdNm) {
		this.targetMbrTypeCdNm = targetMbrTypeCdNm;
	}
	
}
