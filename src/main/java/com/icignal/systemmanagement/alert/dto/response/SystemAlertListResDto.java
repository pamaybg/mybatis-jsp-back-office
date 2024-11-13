package com.icignal.systemmanagement.alert.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemAlertListResDto extends GridPagingItemResDto {

	private String rid;
	@MarkName(groupCode = "COM_ALERT_TYPE_CD", codeField = "alertTypeCd")
	private String alertTypeCdNm;
	private String alertTypeCd;
	private String title;
	@MarkName(groupCode = "YES_NO_FLAG", codeField = "emailSndYn")
	private String emailSndYnNm;
	private String emailSndYn;
	@MarkName(groupCode = "COM_SYS_ALERT_STAT_CD", codeField = "emailSndStatCd")
	private String emailSndStatCdNm;
	private String emailSndStatCd;
	@MarkName(groupCode = "YES_NO_FLAG", codeField = "smsSndYn")
	private String smsSndYnNm;
	private String smsSndYn;
	@MarkName(groupCode = "COM_SYS_ALERT_STAT_CD", codeField = "smsSndStatCd")
	private String smsSndStatCdNm;
	private String smsSndStatCd;
	private String contents;
	private String createDate;
	private String srcSystem;
	@MarkName(groupCode = "SRC_SYSTEM_TYPE_CD", codeField = "srcSystem")
	private String srcSystemNm;
	
	
	public String getSrcSystem() {
		return srcSystem;
	}
	public void setSrcSystem(String srcSystem) {
		this.srcSystem = srcSystem;
	}
	public String getSrcSystemNm() {
		return srcSystemNm;
	}
	public void setSrcSystemNm(String srcSystemNm) {
		this.srcSystemNm = srcSystemNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAlertTypeCdNm() {
		return alertTypeCdNm;
	}
	public void setAlertTypeCdNm(String alertTypeCdNm) {
		this.alertTypeCdNm = alertTypeCdNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmailSndYn() {
		return emailSndYn;
	}
	public void setEmailSndYn(String emailSndYn) {
		this.emailSndYn = emailSndYn;
	}
	public String getEmailSndStatCdNm() {
		return emailSndStatCdNm;
	}
	public void setEmailSndStatCdNm(String emailSndStatCdNm) {
		this.emailSndStatCdNm = emailSndStatCdNm;
	}
	public String getSmsSndYn() {
		return smsSndYn;
	}
	public void setSmsSndYn(String smsSndYn) {
		this.smsSndYn = smsSndYn;
	}
	public String getSmsSndStatCdNm() {
		return smsSndStatCdNm;
	}
	public void setSmsSndStatCdNm(String smsSndStatCdNm) {
		this.smsSndStatCdNm = smsSndStatCdNm;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getAlertTypeCd() {
		return alertTypeCd;
	}
	public void setAlertTypeCd(String alertTypeCd) {
		this.alertTypeCd = alertTypeCd;
	}
	public String getEmailSndYnNm() {
		return emailSndYnNm;
	}
	public void setEmailSndYnNm(String emailSndYnNm) {
		this.emailSndYnNm = emailSndYnNm;
	}
	public String getEmailSndStatCd() {
		return emailSndStatCd;
	}
	public void setEmailSndStatCd(String emailSndStatCd) {
		this.emailSndStatCd = emailSndStatCd;
	}
	public String getSmsSndYnNm() {
		return smsSndYnNm;
	}
	public void setSmsSndYnNm(String smsSndYnNm) {
		this.smsSndYnNm = smsSndYnNm;
	}
	public String getSmsSndStatCd() {
		return smsSndStatCd;
	}
	public void setSmsSndStatCd(String smsSndStatCd) {
		this.smsSndStatCd = smsSndStatCd;
	}
	
}
