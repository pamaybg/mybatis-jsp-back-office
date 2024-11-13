package com.icignal.qpid.rest;

import java.util.Calendar;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.icignal.qpid.rest.RestManager.Push_TYPE;
import com.icignal.qpid.rest.RestManager.Send_TYPE;

/**
 * 디바이스 정보 클래스
 * 
 * @author jskim
 * 
 */
public class Payload {
	private Send_TYPE sendType;
	private String title;
	private Push_TYPE pushType;
	private Boolean realtimeFlag;
	private Date reservationDate;
	private Date expiredDate;
	private String publicPushMessage;

	@JsonProperty("send_type")
	public Send_TYPE getSendType() {
		if (this.sendType == null)
			this.sendType = Send_TYPE.Personal;
		return sendType;
	}

	public void setSendType(Send_TYPE sendType) {
		this.sendType = sendType;
	}

	@JsonProperty("title")
	public String getTitle() {
		if (this.title == null)
			this.title = "";
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@JsonProperty("push_type")
	public Push_TYPE getPushType() {
		if (this.pushType == null)
			this.pushType = Push_TYPE.Notification;
		return pushType;
	}

	public void setPushType(Push_TYPE pushType) {
		this.pushType = pushType;
	}

	@JsonProperty("realtime_flag")
	public Boolean isRealtimeFlag() {
		if (this.realtimeFlag == null)
			this.realtimeFlag = true;
		return realtimeFlag;
	}

	public void setRealtimeFlag(boolean realtimeFlag) {
		this.realtimeFlag = realtimeFlag;
	}

	@JsonProperty("reservation_date")
	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}

	@JsonProperty("expired_date")
	public Date getExpiredDate() {
		if (this.expiredDate == null) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, 1);
			cal.add(Calendar.HOUR, 1);
			this.expiredDate = new Date(cal.getTimeInMillis());
		}

		return expiredDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this.expiredDate = expiredDate;
	}

	@JsonProperty("public_push_message")
	public String getPublicPushMessage() {
		return publicPushMessage;
	}

	public void setPublicPushMessage(String publicPushMessage) {
		this.publicPushMessage = publicPushMessage;
	}

}

