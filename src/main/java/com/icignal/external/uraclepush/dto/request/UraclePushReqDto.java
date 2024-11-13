package com.icignal.external.uraclepush.dto.request;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;


/*
 * 1. 클래스명	: UraclePushReqDto
 * 2. 파일명	: UraclePushReqDto.java
 * 3. 패키지명	: com.icignal.external.uraclepush.dto.request
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 * 유라클사의 푸시서버로 발생할 푸시요청 객체
 *
 * </PRE>
 */ 
public class UraclePushReqDto  {
	private String authkey;
	private String psid;
	private String cuid;
	private String message;
	private String sub_title;
	private String priority;
	private String badgeno;
	private String reservedate;
	private String servicecode;
	private String soundfile;
	private String ext;
	private String sendercode;
	private String app_id;
	private String type;
	private String db_in;
	private String split_msg_cnt;
	private String delay_second;
	private String send_time_limit;
	private String doz_gcm_send;
	private String push_fail_sms_send;
	private String sms_read_wait_minute;
	
	public UraclePushReqDto() {		
		this.priority  = BeansUtil.getApplicationProperty("uracle.push.priority");
		this.badgeno   = BeansUtil.getApplicationProperty("uracle.push.badgeno");
		this.soundfile = BeansUtil.getApplicationProperty("uracle.push.soundfile");
		this.sendercode = BeansUtil.getApplicationProperty("uracle.push.sendercode");		
		this.app_id = BeansUtil.getApplicationProperty("uracle.push.app_id");
		this.message = BeansUtil.getApplicationProperty("uracle.push.default-msg");
		this.servicecode = BeansUtil.getApplicationProperty("uracle.push.servicecode");
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,String> extMap = new HashMap<String,String>();
		extMap.put("TYPE", "PNT");
		try {
			this.ext = mapper.writeValueAsString(extMap);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}
	}
	
	
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public String getPsid() {
		return psid;
	}
	public void setPsid(String psid) {
		this.psid = psid;
	}
	public String getCuid() {
		return cuid;
	}
	public void setCuid(String cuid) {
		this.cuid = cuid;
	}
	public String getMessage() {		
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getSub_title() {
		return sub_title;
	}
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getBadgeno() {
		
		return badgeno;
	}
	public void setBadgeno(String badgeno) {
		this.badgeno = badgeno;
	}
	public String getReservedate() {
		return reservedate;
	}
	public void setReservedate(String reservedate) {
		this.reservedate = reservedate;
	}
	public String getSoundfile() {
		return soundfile;
	}
	public void setSoundfile(String soundfile) {
		this.soundfile = soundfile;
	}
	
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	public String getSendercode() {
		return sendercode;
	}
	public void setSendercode(String sendercode) {
		this.sendercode = sendercode;
	}
	public String getApp_id() {		
		return app_id;
	}
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDb_in() {
		return db_in;
	}
	public void setDb_in(String db_in) {
		this.db_in = db_in;
	}
	public String getSplit_msg_cnt() {
		return split_msg_cnt;
	}
	public void setSplit_msg_cnt(String split_msg_cnt) {
		this.split_msg_cnt = split_msg_cnt;
	}
	public String getDelay_second() {
		return delay_second;
	}
	public void setDelay_second(String delay_second) {
		this.delay_second = delay_second;
	}
	public String getSend_time_limit() {
		return send_time_limit;
	}
	public void setSend_time_limit(String send_time_limit) {
		this.send_time_limit = send_time_limit;
	}
	public String getDoz_gcm_send() {
		return doz_gcm_send;
	}
	public void setDoz_gcm_send(String doz_gcm_send) {
		this.doz_gcm_send = doz_gcm_send;
	}
	public String getPush_fail_sms_send() {
		return push_fail_sms_send;
	}
	public void setPush_fail_sms_send(String push_fail_sms_send) {
		this.push_fail_sms_send = push_fail_sms_send;
	}
	public String getSms_read_wait_minute() {
		return sms_read_wait_minute;
	}
	public void setSms_read_wait_minute(String sms_read_wait_minute) {
		this.sms_read_wait_minute = sms_read_wait_minute;
	}
	public String getServicecode() {		
		return servicecode;
	}
	public void setServicecode(String servicecode) {
		this.servicecode = servicecode;
	}
}
