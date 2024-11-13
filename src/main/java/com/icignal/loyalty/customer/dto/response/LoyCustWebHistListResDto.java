package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyCustWebHistListResDto extends GridPagingItemResDto{

	private String rid;
	private String sessionId;
	private String accessTypeCd;
	@MarkName(groupCode="WEB_ACCESS_TYPE_CD", codeField="accessTypeCd")
	private String accessTypeCdNm;
	private String logTypeCd;
	@MarkName(groupCode="WEB_LOG_TYPE_CD", codeField="logTypeCd")
	private String logTypeCdNm;
	private String chnlNm;
	private String chnlNo;
	private String createDate;
	private String acDeviceCd;
	@MarkName(groupCode="LOY_ACCESS_DEVICE_CD", codeField="acDeviceCd")
	private String acDeviceCdNm;
	
	private String regDate;
	private String ipAddr;
	private String deviceUuid;
	
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getAccessTypeCdNm() {
		return accessTypeCdNm;
	}
	public void setAccessTypeCdNm(String accessTypeCdNm) {
		this.accessTypeCdNm = accessTypeCdNm;
	}
	public String getLogTypeCdNm() {
		return logTypeCdNm;
	}
	public void setLogTypeCdNm(String logTypeCdNm) {
		this.logTypeCdNm = logTypeCdNm;
	}
	public String getAcDeviceCd() {
		return acDeviceCd;
	}
	public void setAcDeviceCd(String acDeviceCd) {
		this.acDeviceCd = acDeviceCd;
	}
	public String getAcDeviceCdNm() {
		return acDeviceCdNm;
	}
	public void setAcDeviceCdNm(String acDeviceCdNm) {
		this.acDeviceCdNm = acDeviceCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getAccessTypeCd() {
		return accessTypeCd;
	}
	public void setAccessTypeCd(String accessTypeCd) {
		this.accessTypeCd = accessTypeCd;
	}
	public String getLogTypeCd() {
		return logTypeCd;
	}
	public void setLogTypeCd(String logTypeCd) {
		this.logTypeCd = logTypeCd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getDeviceUuid() {
		return deviceUuid;
	}
	public void setDeviceUuid(String deviceUuid) {
		this.deviceUuid = deviceUuid;
	}
}
